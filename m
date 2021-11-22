Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02A57459559
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 20:10:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239573AbhKVTNV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 14:13:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:46148 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231418AbhKVTNS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 14:13:18 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 27BE360F41;
        Mon, 22 Nov 2021 19:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637608211;
        bh=F5k27c9VISEEVN+CMOp9ub+sALErxhbWmPf1J1GJdG8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NL7FQhQi1YPzjaKzIl+DS70pfK6bfKHgnN/UStn1gSDRTBM+SGjITUrza1k0m1HsS
         oP9o4MBK4Lwqk/En9qby9crtR1MIZljK/q4yYS/dX7Zmh6lfxBJwekYEwUt8pW+qot
         8+Be6/bRySMZ4NmjSGbQ/P8wOH26hKg4PnovmXH+Pnb3WMmDaAVX06nGMCINL20wp5
         SYi6qxVP+Khr44nWVmVaszT1ZEBBswOh+qEqQzAzXpYyGn7F9ZDaw4xPzBtSh8O8md
         TClDFqz2I1I4/D1xpmQ0GdYaquJH7woTblJRN9xHVvGnwNkfC7Xl3if2ZzxxtDcLfh
         oUZq9TJqmulKQ==
Received: by pali.im (Postfix)
        id 9AAD3A87; Mon, 22 Nov 2021 20:10:08 +0100 (CET)
Date:   Mon, 22 Nov 2021 20:10:08 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Armin Wolf <W_Armin@gmx.de>
Cc:     Guenter Roeck <linux@roeck-us.net>, jdelvare@suse.com,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] hwmon: (dell-smm) Unify i8k_ioctl() and
 i8k_ioctl_unlocked()
Message-ID: <20211122191008.uw2tk4orb7p2elb7@pali>
References: <20211120170319.72369-1-W_Armin@gmx.de>
 <20211120170319.72369-3-W_Armin@gmx.de>
 <20211122160122.gf6i3qj6dnwi6wla@pali>
 <c23caeab-dd27-4c95-2e25-9eb0ff7b33f6@roeck-us.net>
 <e336f501-fe07-7b49-bc65-d6ca443491ca@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e336f501-fe07-7b49-bc65-d6ca443491ca@gmx.de>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 22 November 2021 19:50:14 Armin Wolf wrote:
> Am 22.11.21 um 18:55 schrieb Guenter Roeck:
> > On 11/22/21 8:01 AM, Pali Rohár wrote:
> > > On Saturday 20 November 2021 18:03:19 Armin Wolf wrote:
> > > > The only purpose of i8k_ioctl() is to call i8k_ioctl_unlocked()
> > > > with i8k_mutex held. Judging from the hwmon code, this mutex
> > > > only needs to be held when setting the fan speed/mode.
> > > 
> > > Really? I think that there is no difference between setting and getting
> > > fan speed/mode. At least I do not see why 'set' needs mutex and 'get' do
> > > not need it. Some more explanation is needed...
> > > 
> > I8K_SET_FAN sets the fan speed and returns the current status. Without
> > locking, the returned status may not match or be associated with the
> > previous
> > set operation.
> > 
> > Maybe that doesn't matter, and the synchronization is not needed. If so,
> > you can probably remove the locking entirely.
> > 
> > Guenter
> 
> That is the reason i kept the locking code. Since i do not want to break
> the ioctl interfacein any way, removing the locking code seems too risky
> to me.

I see. That is a good point.

But there is same race condition also when at the same time going to
change speed via ioctl and also via hwmon sysfs.
