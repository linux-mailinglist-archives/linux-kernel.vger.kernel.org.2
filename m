Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C901A3065F1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 22:26:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234125AbhA0VZV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 16:25:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234150AbhA0VXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 16:23:42 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41C5EC061574
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 13:23:02 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1611782580;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=II6M8iM5PIuvLXe9aK/VVdDXafw1OqaL8gCEsAXcvnk=;
        b=WUVHxkzpXwdrvLEovnJc+gLF3SjpK+ZsSAaANxaD1s+ZAdnweeZUmBGuv00CaP03chrsBU
        V8tDGWi1PL59W4gjaOM2iXlUJAI8cbe8SylPmm+rt0EPerOrXeSt59vO/FJ2LGX2c2cAR1
        3wYpizXSzpmaYiEEZ6hDd7ewOFUmYnMJ57m0QnpyF+dufAsGlLwzgUrnZxb6nQkKc98zzy
        jYEL2Cx17p1bV5tirMqGj1kMX5hsr2WrjBXx8J3GU1z6nGWoSEz6Ot/3jkIuCmsHyOMqY4
        +Ij4XNI+SB7ouVTsCo5cv/jqzKSBBHWY49cQj859KOD7jnQw92Xmg6A5QYZ5gw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1611782580;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=II6M8iM5PIuvLXe9aK/VVdDXafw1OqaL8gCEsAXcvnk=;
        b=QmNp86P08ti1jhKYyBpBD5eh6ghaSxiRuwndOEa+4CWhGoZpUuDYAJ/FRKNdYRfqYlYWwx
        cR1rn3Jp5CTQ5gDw==
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Petr Mladek <pmladek@suse.com>
Cc:     kernel test robot <oliver.sang@intel.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com, zhengjun.xing@linux.intel.com
Subject: Re: [printk]  b031a684bf: INFO:rcu_tasks_detected_stalls_on_tasks
In-Reply-To: <YA+gAV1kW8Ru1+Bo@jagdpanzerIV.localdomain>
References: <20210122081311.GA12834@xsang-OptiPlex-9020> <YAr7d6A4CkMpgx+g@alley> <YA+gAV1kW8Ru1+Bo@jagdpanzerIV.localdomain>
Date:   Wed, 27 Jan 2021 22:28:59 +0106
Message-ID: <87bldaaxcc.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-01-26, Sergey Senozhatsky <sergey.senozhatsky@gmail.com> wrote:
> AFAIU this is just 'modprobe rcutorture'

I was finally able to trigger this by using my workstation:

    Intel(R) Core(TM) i5-8259U CPU @ 2.30GHz
    Debian/buster
    QEMU 3.1.0 (Debian 1:3.1+dfsg-8+deb10u8)

instead of my build server:

    Intel(R) Xeon(R) CPU E5-2697 v4 @ 2.30GHz
    Debian/bullseye
    QEMU 5.2.0 (Debian 1:5.2+dfsg-3)

I don't know what factors contributed, but I wanted to share my success
in reproducing the reported problem. Instead of using lkp, I am manually
booting with:

$ kvm -cpu host -smp 2 -m 8G -nographic \
      -kernel bzImage -append "console=ttyS0,115200 loglevel=6" \
      -initrd initrd

My initrd is a minimal busybox rootfs that runs:

# modprobe rcutorture onoff_interval=3 onoff_holdoff=30 torture_type=tasks

(Those are the same modprobe parameters used by the lkp job.)

After about a minute I see:

[   47.268292] tasks-torture: rcu_torture_read_exit: Start of episode
[   51.273365] tasks-torture: rcu_torture_read_exit: End of episode
[   55.823306] smpboot: do_boot_cpu failed(-1) to wakeup CPU#0
[   55.824350] tasks-torture:torture_onoff task: online 0 failed: errno -5
[   55.830661] tasks-torture:torture_onoff task: online 0 failed: errno -5
[   55.848524] tasks-torture:torture_onoff task: online 0 failed: errno -5

I will start to debug this now.

John Ogness
