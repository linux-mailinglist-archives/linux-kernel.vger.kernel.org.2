Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5F18380503
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 10:20:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233463AbhENIV7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 04:21:59 -0400
Received: from mga05.intel.com ([192.55.52.43]:52843 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233449AbhENIV6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 04:21:58 -0400
IronPort-SDR: dCEXjsWBS8B6NvjsOIbSJEMUw7tGD0Pp4NZ3519e44zz86pN7d3SrUPy+ppziaS0L1xJmKuurf
 o8DkA8TBcgwA==
X-IronPort-AV: E=McAfee;i="6200,9189,9983"; a="285658822"
X-IronPort-AV: E=Sophos;i="5.82,299,1613462400"; 
   d="scan'208";a="285658822"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2021 01:20:47 -0700
IronPort-SDR: g/Vp/h6w/8Vrrxv8ShXNChAaG6BkHt9AWzO3vsVoEn8fI3jPBRHZkX6bwD7cn53yCyG7AJh0oQ
 G2yo3RSDEX+w==
X-IronPort-AV: E=Sophos;i="5.82,299,1613462400"; 
   d="scan'208";a="401570868"
Received: from gna-dev.igk.intel.com (HELO localhost) ([10.102.80.34])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2021 01:20:44 -0700
References: <20210513110040.2268-1-maciej.kwapulinski@linux.intel.com> <20210513110040.2268-12-maciej.kwapulinski@linux.intel.com> <YJ0MXK2XSISC1fIl@kroah.com>
User-agent: mu4e 1.4.13; emacs 26.3
From:   Maciej Kwapulinski <maciej.kwapulinski@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Jonathan Corbet <corbet@lwn.net>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Tomasz Jankowski <tomasz1.jankowski@intel.com>,
        Savo Novakovic <savox.novakovic@intel.com>,
        Jianxun Zhang <jianxun.zhang@linux.intel.com>
Subject: Re: [PATCH v3 11/14] intel_gna: add ioctl handler
In-reply-to: <YJ0MXK2XSISC1fIl@kroah.com>
Date:   Fri, 14 May 2021 10:20:42 +0200
Message-ID: <85o8ddiv51.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:

> On Thu, May 13, 2021 at 01:00:37PM +0200, Maciej Kwapulinski wrote:
>> From: Tomasz Jankowski <tomasz1.jankowski@intel.com>
>> 
>> Add ioctl handler into GNA driver.
>> The ioctl interface provides the ability to do the following:
>>  - Map and unmap memory buffers for GNA computation requests.
>>  - Retrieve capabilities of the underlying GNA IP.
>>  - Submit GNA computation requests.
>>  - Request notification of scoring completion.
>
> Do you have a pointer to the userspace code that uses this ioctl?
> That's kind of required here, otherwise we have no idea how this all
> works.
>

yes, it's present under following link:

https://github.com/intel/gna

regards,
Maciej
