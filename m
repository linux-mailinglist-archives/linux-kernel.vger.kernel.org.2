Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8FD33CD020
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 11:09:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235328AbhGSI2V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 04:28:21 -0400
Received: from mga06.intel.com ([134.134.136.31]:19386 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235235AbhGSI2U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 04:28:20 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10049"; a="272132044"
X-IronPort-AV: E=Sophos;i="5.84,251,1620716400"; 
   d="scan'208";a="272132044"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2021 01:46:59 -0700
X-IronPort-AV: E=Sophos;i="5.84,251,1620716400"; 
   d="scan'208";a="468350515"
Received: from shao2-debian.sh.intel.com (HELO [10.239.13.11]) ([10.239.13.11])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2021 01:46:57 -0700
Subject: Re: [kbuild-all] Re: [linux-stable-rc:linux-4.4.y 1449/1774]
 drivers/input/joydev.c:485:16: warning: comparison of integer expressions of
 different signedness: 'int' and 'long unsigned int'
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        kernel test robot <lkp@intel.com>
Cc:     Dan Carpenter <error27@gmail.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
References: <202107191112.AwqoFW63-lkp@intel.com>
 <20210719071758.GP1931@kadam>
From:   Rong Chen <rong.a.chen@intel.com>
Message-ID: <4dee6094-2bec-6afb-38ae-804675c8172c@intel.com>
Date:   Mon, 19 Jul 2021 16:46:56 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210719071758.GP1931@kadam>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/19/21 3:17 PM, Dan Carpenter wrote:
> On Mon, Jul 19, 2021 at 11:39:16AM +0800, kernel test robot wrote:
>>     drivers/input/joydev.c: In function 'joydev_handle_JSIOCSAXMAP':
>>     drivers/input/joydev.c:451:16: warning: comparison of integer expressions of different signedness: 'int' and 'size_t' {aka 'long unsigned int'} [-Wsign-compare]
>>       451 |  for (i = 0; i < len && i < joydev->nabs; i++) {
> We should figure out a way to turn this warning off in the compiler.
>
> It's a stupid warning.  It never fixes any bugs.  It sometimes
> introduces bugs.
>
> In the kernel if you are in drivers/ and you have a loop which iterates
> over 2 million times that's probably a bug.  But GCC is very very
> stupid and not designed to be a static analysis tool.  It does not know
> which loops can iterate more than 2 million times.  Even when it knows
> that the loop only loops up to 5 or 10 times it still warns that maybe
> it will loop over 2 million times.  INSULTS AND DISPARAGEMENT!
>
> Seriously, please disable this warning unless you can point to one
> single bug that it has fixed.

Hi Dan,

Thanks for the explanation, we'll stop reporting this warning.

Best Regards,
Rong Chen

>
> regards,
> dan carpenter

