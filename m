Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 340A44595B5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 20:43:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240170AbhKVTqV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 14:46:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:56008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234367AbhKVTqU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 14:46:20 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1AE2160F51;
        Mon, 22 Nov 2021 19:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637610193;
        bh=2GSnTrkyMmob9ul0okQ5IjodpC5j/H3akBJZQJWdZWk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YFK4tp9d5S/A3WGokZ6l48peGnCQY7y/oDr+IxVe4LQYZOjKSXD3DqSudXuOpgmtJ
         17++mQAUtKFspXYVIt+AjBEkaJoqxLfRZ6wCyEO1L2ys2hpvdbPqvsfW7XiT7cUKLL
         QdmPMVNYg3oseNg0Wz8Q6wRWgRauhfH8uLTNfUPexHZLrRQ/tJf8JdBblB2WhCGVRY
         K+Vph8FX4J6krXVy05pYSlGx5lF+0VaFdzXNFfTywex6a/ikDtf96hAcj8sPLpa2xm
         +Hsy0RUKMa3SRsjbTSoeKcRwh9T9v0PygtRMtWQa42CzW+/AxO3hGPY/EB0pj8jBSO
         N1lLyOxFPvPoA==
Received: by pali.im (Postfix)
        id CE636A87; Mon, 22 Nov 2021 20:43:10 +0100 (CET)
Date:   Mon, 22 Nov 2021 20:43:10 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Armin Wolf <W_Armin@gmx.de>, jdelvare@suse.com,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] hwmon: (dell-smm) Unify i8k_ioctl() and
 i8k_ioctl_unlocked()
Message-ID: <20211122194310.viaddbblls2wxmbm@pali>
References: <20211120170319.72369-1-W_Armin@gmx.de>
 <20211120170319.72369-3-W_Armin@gmx.de>
 <20211122160122.gf6i3qj6dnwi6wla@pali>
 <c23caeab-dd27-4c95-2e25-9eb0ff7b33f6@roeck-us.net>
 <e336f501-fe07-7b49-bc65-d6ca443491ca@gmx.de>
 <20211122191008.uw2tk4orb7p2elb7@pali>
 <b73d5a00-ecce-0517-4fb5-4af451e1facb@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b73d5a00-ecce-0517-4fb5-4af451e1facb@roeck-us.net>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 22 November 2021 11:28:30 Guenter Roeck wrote:
> On 11/22/21 11:10 AM, Pali Rohár wrote:
> > On Monday 22 November 2021 19:50:14 Armin Wolf wrote:
> > > Am 22.11.21 um 18:55 schrieb Guenter Roeck:
> > > > On 11/22/21 8:01 AM, Pali Rohár wrote:
> > > > > On Saturday 20 November 2021 18:03:19 Armin Wolf wrote:
> > > > > > The only purpose of i8k_ioctl() is to call i8k_ioctl_unlocked()
> > > > > > with i8k_mutex held. Judging from the hwmon code, this mutex
> > > > > > only needs to be held when setting the fan speed/mode.
> > > > > 
> > > > > Really? I think that there is no difference between setting and getting
> > > > > fan speed/mode. At least I do not see why 'set' needs mutex and 'get' do
> > > > > not need it. Some more explanation is needed...
> > > > > 
> > > > I8K_SET_FAN sets the fan speed and returns the current status. Without
> > > > locking, the returned status may not match or be associated with the
> > > > previous
> > > > set operation.
> > > > 
> > > > Maybe that doesn't matter, and the synchronization is not needed. If so,
> > > > you can probably remove the locking entirely.
> > > > 
> > > > Guenter
> > > 
> > > That is the reason i kept the locking code. Since i do not want to break
> > > the ioctl interfacein any way, removing the locking code seems too risky
> > > to me.
> > 
> > I see. That is a good point.
> > 
> > But there is same race condition also when at the same time going to
> > change speed via ioctl and also via hwmon sysfs.
> > 
> 
> I thought the sysfs code does not change the fan speed and report the
> fan status in the same request. Did I miss something ?

No. I mean something different. Let me to write trace call:

CPU 0:                          CPU 1:
                                1. dell_smm_write()
1. ioctl(I8K_SET_FAN)
2. i8k_set_fan()
                                2. i8k_set_fan()
3. i8k_get_fan_status()

So to ensure that i8k_get_fan_status() on CPU 0 returns value which
belongs to i8k_set_fan() from CPU 0 it is needed to still use mutex.

Armin is right here and I think that patch is correct.
