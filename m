Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EABC45A714
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 17:02:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238648AbhKWQFg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 11:05:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:37530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236507AbhKWQFf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 11:05:35 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id AB3D060F6F;
        Tue, 23 Nov 2021 16:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637683346;
        bh=3YKo0Wgt681Mhq3j8srZ2KB07rY58egvW/B5jrq9sBw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FS3uIhcHYp9A901dJ8ROdu+Ka4i8L/b3oYMjRymB09ZDq8Nod3OIX7axqFADJmUi8
         PL5p13yVBGPEirg+z3sDZ6ufomMasg6DST0JYIzwDJqNHKVUAua7NwECdp/uIM5kqM
         1MjMnTEaA/z/2BHjua7w+wqrmvIy2mvEkfWRfrXJ8oNNLWHwSSg+ljdkUPBBcdOvVy
         bMmdW72P4VBpAIA6WVHwP/Nw0NMhBQs5WDCgfim9RFvqCCcZ2lKBUqDRMSOZHP8WEg
         N04NSex3FlOkbGezkEcrPAu9UM58GhJbK+ZR25VgtZtzQaVnWjMAeVwyoaQZjv9x4Y
         KWdBDc9ABNeiw==
Received: by pali.im (Postfix)
        id 62B368A3; Tue, 23 Nov 2021 17:02:24 +0100 (CET)
Date:   Tue, 23 Nov 2021 17:02:24 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Armin Wolf <W_Armin@gmx.de>, jdelvare@suse.com,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] hwmon: (dell-smm) Unify i8k_ioctl() and
 i8k_ioctl_unlocked()
Message-ID: <20211123160224.3khzbq2jil66wzgj@pali>
References: <20211120170319.72369-1-W_Armin@gmx.de>
 <20211120170319.72369-3-W_Armin@gmx.de>
 <20211122160122.gf6i3qj6dnwi6wla@pali>
 <c23caeab-dd27-4c95-2e25-9eb0ff7b33f6@roeck-us.net>
 <e336f501-fe07-7b49-bc65-d6ca443491ca@gmx.de>
 <20211122191008.uw2tk4orb7p2elb7@pali>
 <b73d5a00-ecce-0517-4fb5-4af451e1facb@roeck-us.net>
 <20211122194310.viaddbblls2wxmbm@pali>
 <20211123160051.GA2326185@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211123160051.GA2326185@roeck-us.net>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 23 November 2021 08:00:51 Guenter Roeck wrote:
> On Mon, Nov 22, 2021 at 08:43:10PM +0100, Pali Rohár wrote:
> > On Monday 22 November 2021 11:28:30 Guenter Roeck wrote:
> > > On 11/22/21 11:10 AM, Pali Rohár wrote:
> > > > On Monday 22 November 2021 19:50:14 Armin Wolf wrote:
> > > > > Am 22.11.21 um 18:55 schrieb Guenter Roeck:
> > > > > > On 11/22/21 8:01 AM, Pali Rohár wrote:
> > > > > > > On Saturday 20 November 2021 18:03:19 Armin Wolf wrote:
> > > > > > > > The only purpose of i8k_ioctl() is to call i8k_ioctl_unlocked()
> > > > > > > > with i8k_mutex held. Judging from the hwmon code, this mutex
> > > > > > > > only needs to be held when setting the fan speed/mode.
> > > > > > > 
> > > > > > > Really? I think that there is no difference between setting and getting
> > > > > > > fan speed/mode. At least I do not see why 'set' needs mutex and 'get' do
> > > > > > > not need it. Some more explanation is needed...
> > > > > > > 
> > > > > > I8K_SET_FAN sets the fan speed and returns the current status. Without
> > > > > > locking, the returned status may not match or be associated with the
> > > > > > previous
> > > > > > set operation.
> > > > > > 
> > > > > > Maybe that doesn't matter, and the synchronization is not needed. If so,
> > > > > > you can probably remove the locking entirely.
> > > > > > 
> > > > > > Guenter
> > > > > 
> > > > > That is the reason i kept the locking code. Since i do not want to break
> > > > > the ioctl interfacein any way, removing the locking code seems too risky
> > > > > to me.
> > > > 
> > > > I see. That is a good point.
> > > > 
> > > > But there is same race condition also when at the same time going to
> > > > change speed via ioctl and also via hwmon sysfs.
> > > > 
> > > 
> > > I thought the sysfs code does not change the fan speed and report the
> > > fan status in the same request. Did I miss something ?
> > 
> > No. I mean something different. Let me to write trace call:
> > 
> > CPU 0:                          CPU 1:
> >                                 1. dell_smm_write()
> > 1. ioctl(I8K_SET_FAN)
> > 2. i8k_set_fan()
> >                                 2. i8k_set_fan()
> > 3. i8k_get_fan_status()
> > 
> > So to ensure that i8k_get_fan_status() on CPU 0 returns value which
> > belongs to i8k_set_fan() from CPU 0 it is needed to still use mutex.
> > 
> > Armin is right here and I think that patch is correct.
> 
> Quoting your earlier reply:
> 
> > Really? I think that there is no difference between setting and getting
> > fan speed/mode. At least I do not see why 'set' needs mutex and 'get' do
> > not need it. Some more explanation is needed...
> 
> This was the reason for my comment. Your latest reply is leaving me a bit
> puzzled. If you are ok with the patch as-is, please provide a Reviewed-by:
> or Acked-by: tag.

Sorry for that. I should have explicitly wrote that I realized how it
works after Armin explained it.
