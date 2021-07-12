Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BB723C411D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 03:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbhGLB7K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jul 2021 21:59:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbhGLB7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jul 2021 21:59:10 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96E5CC0613DD
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jul 2021 18:56:22 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id z3so21456679oib.9
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jul 2021 18:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rM0a619Jo00993WBdz/zW3jIwprYZ51heuLHCSywbds=;
        b=YrpNXgmvhikfW/6n5XHuHG00BoI0bjoU5mtZQ5qe0l+C+ikRFnj+R+enLvF0nYlP7V
         dbsJ6MQsf/WWoR25C2W48W5Iby5BEgYeyzDHr6uUyHoAbs4cFrlmBEYEnxBV/tTImvXX
         aKge+jia9jSfUrF7ZHVvBytMgYEgJjH7shWuINoZ8Joj6kHbW++dZ+QRpbza4YrHwuIE
         JFHabQ+iHDp6KjY9X66pguLycU6Ya7PeHQYUla4kmWX2qgJZX7I6OMACTW8L2Tw1c5O8
         qZHi6dpkDXK0Gn1erUcAOCgQA0DHs7hjb1py/7Pmx9OwBrolDEXfRMl4VTA34WtsErt/
         rOng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=rM0a619Jo00993WBdz/zW3jIwprYZ51heuLHCSywbds=;
        b=RKZlkTNPH1IXvM6HT5r5McYN/2GHrZ+5R78lYQsZIFPMQ+0fMgfsLzqMH2KeAr7nP2
         eyKlUkeuT8BuuIUwDWko9j2H0mk6ScZkEiK2qsC6PIC/mmbvTAcQ8PVM28MIA+Ziyx3n
         nr18+p44aVTFjmLr2+QxUob450MhvLwrLx5VfZQugfbEDqEW3F5LNrswnHzEIQrGa5vX
         VKbT+IIKek56q2LsqoD2lo0NicTWHL7XTArdBG0SNwJX6rEWH2lvuE/ioh4IO/MVeglF
         ebMpHexSh0YYMonNAyYFG+xoWZgahtmtavjAAoZq8l4ozKCRpBzsi6nVepXIyJwwz1qC
         C4dw==
X-Gm-Message-State: AOAM5332NCQ+arzA5NbUdRSjKzhSSKmSHnHGM7PVLhOmq4qBk4CFC0mq
        I9DDXqxmYcFEj/JMqVPqpqYgM14T1Qw=
X-Google-Smtp-Source: ABdhPJxfqrG37HecXK6wbXpbUIp+pJcR6UsSvuoXIaenfiTTrcpebL60+OyGuzppJKnihMFuRCJx/Q==
X-Received: by 2002:aca:fc12:: with SMTP id a18mr5493508oii.85.1626054981801;
        Sun, 11 Jul 2021 18:56:21 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h96sm2827749oth.25.2021.07.11.18.56.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jul 2021 18:56:21 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 11 Jul 2021 18:56:19 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 5.14-rc1
Message-ID: <20210712015619.GA3547193@roeck-us.net>
References: <CAHk-=wjB5XBk4obhMPfrU3mnOakV9VgHAYOo-ZGJnB2X0DnBWA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjB5XBk4obhMPfrU3mnOakV9VgHAYOo-ZGJnB2X0DnBWA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 11, 2021 at 03:49:31PM -0700, Linus Torvalds wrote:
> You all know the drill by now. It's been the usual two weeks of merge
> window, and not it's closed, and 5.14-rc1 is out there.
> 
[ ... [ 
> Please do test, and we can get the whole calming-down period rolling
> and hopefully get a timely final 5.14 release.
> 

Build results:
	total: 154 pass: 152 fail: 2
Failed builds:
	arcv2:allnoconfig
	riscv:allmodconfig
Qemu test results:
	total: 462 pass: 443 fail: 19
Failed tests:
	arm:z2:pxa_defconfig:nodebug:nocd:nofs:nonvme:noscsi:notests:novirt:nofdt:flash8,384k,2:rootfs
	<all riscv32>

z2:pxa_defconfig fails to boot due to commit 4b361cfa8624 ("mtd: core:
add OTP nvmem provider support"). A patch to fix the problem has been
posted at
https://patchwork.ozlabs.org/project/linux-mtd/patch/20210707135359.32398-1-michael@walle.cc/

The riscv:allmodconfig build failure is not new. It is seen if both
STACKPROTECTOR_PER_TASK and GCC_PLUGIN_RANDSTRUCT are enabled.
See
https://patchwork.kernel.org/project/linux-riscv/patch/20210706162621.940924-1-linux@roeck-us.net/
for details and a proposed fix.

riscv32 images fail to boot due to commit ca6eaaa210de ("riscv:
__asm_copy_to-from_user: Optimize unaligned memory access and pipeline
stall"). I reported this a couple of days ago, but have not seen a reply.

In addition to that, there are some new warning tracebacks.

WARNING: CPU: 0 PID: 55 at crypto/testmgr.c:5652 alg_test.part.0+0x148/0x460
self-tests for drbg_nopr_hmac_sha512 (stdrng) failed (rc=-22)

This is due to commits

9b7b94683a9b crypto: DRBG - switch to HMAC SHA512 DRBG as default DRBG
8833272d876e crypto: drbg - self test for HMAC(SHA-512)

which set the default crypto algorithm to SHA-512 without actually
mandating CONFIG_CRYPTO_SHA512. A patch to fix this has been posted at
https://patchwork.kernel.org/project/linux-crypto/patch/304ee0376383d9ceecddbfd216c035215bbff861.camel@chronox.de/

WARNING: CPU: 0 PID: 24 at block/genhd.c:484 __device_add_disk+0x248/0x286

This is seen with riscv64 images when booting from usb or scsi drives.
I don't recall seeing this warning before, but I may have missed it
in the flurry of other warnings. It may have been introduced with commit
7c3f828b522b0 ("block: refactor device number setup in __device_add_disk")
but I did not try to bisect it yet.

Guenter
