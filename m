Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50F7937FC22
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 19:09:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230295AbhEMRKW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 13:10:22 -0400
Received: from mga05.intel.com ([192.55.52.43]:41146 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229906AbhEMRKT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 13:10:19 -0400
IronPort-SDR: HjyYSErb/UN5phqlqCNm0JO3Yp7i+x/otmb1PcH5Mlt1wRwkJ7xJ6k4TjXEu0vnBNSSo5gaqqJ
 N6rWlx1XjbpQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9983"; a="285503925"
X-IronPort-AV: E=Sophos;i="5.82,296,1613462400"; 
   d="scan'208";a="285503925"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2021 10:06:22 -0700
IronPort-SDR: STnDbgJ5e1/EV9FwXRDSk2rhqhGIUjO3A+kFrPQAukeCA1MYQe7kafsPMf9QsE7mdEGw4jPE8l
 gOgUgVhS2zVA==
X-IronPort-AV: E=Sophos;i="5.82,296,1613462400"; 
   d="scan'208";a="626308346"
Received: from gna-dev.igk.intel.com (HELO localhost) ([10.102.80.34])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2021 10:06:20 -0700
References: <20210513110040.2268-1-maciej.kwapulinski@linux.intel.com> <20210513110040.2268-13-maciej.kwapulinski@linux.intel.com> <YJ0K7f0NiRwQBPPA@kroah.com>
User-agent: mu4e 1.4.13; emacs 26.3
From:   Maciej Kwapulinski <maciej.kwapulinski@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Jonathan Corbet <corbet@lwn.net>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Savo Novakovic <savox.novakovic@intel.com>
Subject: Re: [PATCH v3 12/14] intel_gna: add a 'misc' device
In-reply-to: <YJ0K7f0NiRwQBPPA@kroah.com>
Date:   Thu, 13 May 2021 19:06:18 +0200
Message-ID: <85r1iaimwl.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:

> On Thu, May 13, 2021 at 01:00:38PM +0200, Maciej Kwapulinski wrote:
>> The new 'misc' device is the node for applications in user space to
>> interact with the driver.
>> 
>> Signed-off-by: Maciej Kwapulinski <maciej.kwapulinski@linux.intel.com>
>> Tested-by: Savo Novakovic <savox.novakovic@intel.com>
>> ---
>>  drivers/misc/intel/gna/device.c | 52 +++++++++++++++++++++++++++++++--
>>  drivers/misc/intel/gna/device.h | 11 +++----
>>  2 files changed, 55 insertions(+), 8 deletions(-)
>> 
>> diff --git a/drivers/misc/intel/gna/device.c b/drivers/misc/intel/gna/device.c
>> index 0e31b8c6bb70..1e6345a8325b 100644
>> --- a/drivers/misc/intel/gna/device.c
>> +++ b/drivers/misc/intel/gna/device.c
>> @@ -20,6 +20,18 @@ module_param(recovery_timeout, int, 0644);
>>  MODULE_PARM_DESC(recovery_timeout, "Recovery timeout in seconds");
>>  #endif
>>  
>> +struct file;
>> +
>> +static int gna_open(struct inode *inode, struct file *f)
>> +{
>> +	return -EPERM;
>> +}
>
> That sucks, why have an open that does nothing but fail?

next patch provides complete implementation of gna_open(), here it's
just a protection if someone would incidentally run gna in the middle of patch series

>
>> +
>> +static const struct file_operations gna_file_ops = {
>> +	.owner		=	THIS_MODULE,
>> +	.open		=	gna_open,
>> +};
>> +
>>  static void gna_devm_idr_destroy(void *data)
>>  {
>>  	struct idr *idr = data;
>> @@ -27,6 +39,36 @@ static void gna_devm_idr_destroy(void *data)
>>  	idr_destroy(idr);
>>  }
>>  
>> +static void gna_devm_deregister_misc_dev(void *data)
>
> Why is this a void *?

it goes to devm_add_action() api.

>
> This isn't windows, use real pointer types everywhere in the kernel
> please.
>
>> +{
>> +	struct miscdevice *misc = data;
>> +
>> +	misc_deregister(misc);
>> +}
>> +
>> +static int gna_devm_register_misc_dev(struct device *parent, struct miscdevice *misc)
>> +{
>> +	int ret;
>> +
>> +	ret = misc_register(misc);
>> +	if (ret) {
>> +		dev_err(parent, "misc device %s registering failed. errcode: %d\n",
>> +			misc->name, ret);
>> +		gna_devm_deregister_misc_dev(misc);
>> +	} else {
>> +		dev_dbg(parent, "device: %s registered\n",
>> +			misc->name);
>
> You have loads of debugging in this driver still, is it really needed?
>
>> +	}
>> +
>> +	ret = devm_add_action(parent, gna_devm_deregister_misc_dev, misc);
>
> Why do you need this?

I'd like to avoid having gna_probe's fail path at all.

>
>
> thanks,
>
> greg k-h

