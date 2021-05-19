Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E313388C6E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 13:12:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346234AbhESLNk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 07:13:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:45052 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346209AbhESLNb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 07:13:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A573AAF3E;
        Wed, 19 May 2021 11:12:10 +0000 (UTC)
Date:   Wed, 19 May 2021 13:12:02 +0200
From:   Borislav Petkov <bp@suse.de>
To:     James Feeney <james@nurealm.net>
Cc:     linux-smp@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: linux 5.12 - fails to boot - soft lockup - CPU#0 stuck for 23s!
 - RIP smp_call_function_single
Message-ID: <YKTygvN0QNlExEQP@zn.tnic>
References: <8a9599b2-f4fe-af9b-90f5-af39c315ec2f@nurealm.net>
 <YKIqDdFNaXYd39wz@zn.tnic>
 <1876afbe-a167-2be5-3690-846700eeb76c@nurealm.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1876afbe-a167-2be5-3690-846700eeb76c@nurealm.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 18, 2021 at 09:58:46PM -0600, James Feeney wrote:
> Hmm - I am naively supposing that "the bisect is the bisect". No
> matter what commit initiates a problem, it's still a problem. It would
> be useful to investigate, and introspect the calling functions in the
> Call Trace. No?

I'd like to know that the source you're looking at is the same source
I'm looking at.

And yes, AFAIK, Arch kernels are simply the upstream kernels but
still...

> Attached:
> bootlog.7bb39313cd62
> bootlog.4f432e8bb15b
>
> The later with the "soft lockup" repeating four times. The kernel
> command line has loglevel=5 and console=ttyS0,115200.

Those are not the full boot messages - they should look like
dmesglog.7bb39313cd62 but probably you cannot log into the box after the
softlockup happens to dump them. That's why I meant to try the serial
connection...

Anyway, let's start somewhere.

1. Take a pristine 5.12 upstream kernel from git, build it using your
bisectconfig and try booting it with

debug ignore_loglevel log_buf_len=16M no_console_suspend systemd.log_target=null console=ttyS0,115200 console=tty0

on the kernel command line. Then save a full dmesg, if you can. If you
ocan catch ot ver serial, then that would be awesomer.

2. Use the exact same kernel but this time disable

CONFIG_X86_THERMAL_VECTOR

in its .config and do the same thing.

Send me both dmesg files then.

Thx.

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
