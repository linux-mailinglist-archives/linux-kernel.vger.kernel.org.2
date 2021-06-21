Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8B263AE863
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 13:50:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbhFULww convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 21 Jun 2021 07:52:52 -0400
Received: from mga06.intel.com ([134.134.136.31]:11441 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229640AbhFULwv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 07:52:51 -0400
IronPort-SDR: nOubQCdixf+UuiFa9dFdQfK7dg2JVt6UFXzje2LuVbRbtlkzwdFNIlFd9XVRWUkDAHi83KHG0B
 VboIU0csMs/Q==
X-IronPort-AV: E=McAfee;i="6200,9189,10021"; a="267966300"
X-IronPort-AV: E=Sophos;i="5.83,289,1616482800"; 
   d="scan'208";a="267966300"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2021 04:50:37 -0700
IronPort-SDR: NYL4P8Nmut2ZfafhCs9t0/cueIMeXHLUvGX7qR+dr/+vYiI1enn7cvSV/rY40ijOmiIb/x6LVK
 yKjNGlIVS7vw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,289,1616482800"; 
   d="scan'208";a="453855175"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by fmsmga008.fm.intel.com with ESMTP; 21 Jun 2021 04:50:37 -0700
Received: from shsmsx601.ccr.corp.intel.com (10.109.6.141) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Mon, 21 Jun 2021 04:50:35 -0700
Received: from shsmsx601.ccr.corp.intel.com (10.109.6.141) by
 SHSMSX601.ccr.corp.intel.com (10.109.6.141) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Mon, 21 Jun 2021 19:50:33 +0800
Received: from shsmsx601.ccr.corp.intel.com ([10.109.6.141]) by
 SHSMSX601.ccr.corp.intel.com ([10.109.6.141]) with mapi id 15.01.2242.008;
 Mon, 21 Jun 2021 19:50:33 +0800
From:   "Xu, Pengfei" <pengfei.xu@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Yu, Yu-cheng" <yu-cheng.yu@intel.com>,
        "Su, Heng" <heng.su@intel.com>, "Du, Julie" <julie.du@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "Brown, Len" <len.brown@intel.com>,
        "Li, Philip" <philip.li@intel.com>,
        "Xu, Pengfei" <pengfei.xu@intel.com>
Subject: Re: Tested x86 FPU fixes and found "Bad FPU state" issue
Thread-Topic: Tested x86 FPU fixes and found "Bad FPU state" issue
Thread-Index: AddmOqPgT2Ohj/1gSo2GGOOxmvEmHQACF8iAABSENgA=
Date:   Mon, 21 Jun 2021 11:50:33 +0000
Message-ID: <72e37a644f474a3888ff96833213558d@intel.com>
References: <9e6f363f138e4d05b368f4428399466b@intel.com>
 <87pmwffruk.ffs@nanos.tec.linutronix.de>
In-Reply-To: <87pmwffruk.ffs@nanos.tec.linutronix.de>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
x-ms-exchange-imapappendstamp: SHSMSX601.ccr.corp.intel.com (15.01.2242.005)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [10.239.127.36]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A2C799789F2CE944A6D86C475548A254@intel.com>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,
  Thanks for your update!
  And I tried new fpu branch with last commit:
  b4c5dbb182058b2bd176fce77a4aea64494bf781
  I verified this issue was fixed.
  I will keep testing new FPU branch kernel.

  Thanks!
  BR.

On 2021-06-21 at 12:13:23 +0200, Thomas Gleixner wrote:
> Pengfei!
> 
> On Mon, Jun 21 2021 at 01:31, Pengfei Xu wrote:
> > This "Bad FPU state" issue was found in 20210619 FPU branch kernel:
> > https://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git
> > branch: origin/x86/fpu
> > last commit:
> > "
> > commit 2299e66e766a7cdca8aafc36b59ada8782d26233
> > ...
> > x86/fpu/signal: Let xrstor handle the features to init
> > "
> 
> Thanks for testing and reporting!
> 
> I found the issue and updated the branch. New head commit is
> 
>   b4c5dbb18205 ("x86/fpu/signal: Let xrstor handle the features to init")
> 
> Thanks,
> 
>         tglx
