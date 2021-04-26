Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B865736A9FA
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 02:00:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231444AbhDZABI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Apr 2021 20:01:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231330AbhDZABG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Apr 2021 20:01:06 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67AE4C061574
        for <linux-kernel@vger.kernel.org>; Sun, 25 Apr 2021 17:00:25 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id m13so54859145oiw.13
        for <linux-kernel@vger.kernel.org>; Sun, 25 Apr 2021 17:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EqVn2NQF0n5BpttiBW8koHwFVqrvCouVBVXT/eQcKLM=;
        b=qalPi7RjMUVUaSor9kV3M6kqnCSiidqKhApIRgfExLW5jh5+F6FmT3fNKXiqxX7Xbf
         NJa1wqxZgXItSncv4TW8rNIOALH/ywRh3GWOyNZ+5uSlXMorYh81/h7VFHESU5akr82H
         vfo4YCiZnTth3Q1toYgtpMm5p8n1XWx/h3+kqFsxqZZqlIHUxUcDf91cKGcWu1pYvKA4
         dbgdtdNFGyQ3+n/QikJx38ieLrOW1Ob9ZDDjK6KlZaNf1kA7rZHIKoJJZCUe0zzIDJLR
         XnZW8wD7R6PtJDoYWsOZxFFzvplHI8aia/gXAtd3KQpCCuq8W02X2+0jihs6SStqjbNU
         9MPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=EqVn2NQF0n5BpttiBW8koHwFVqrvCouVBVXT/eQcKLM=;
        b=IytnuQ0w3yqBppBZEXUYMMMsmfADomLTlaY2KIAespcZYM8Q1VMacEuLteOwtzMhOt
         mry17+z9SlTYxljBHehg9vQs5O6KSE0X7WVKKTAzyL7+Cb8PBg1mqL/kLWS09TMVnrLP
         oZvIy9Io3n9fQIdAQHWyxSzIk5shgeS2h+0X511+8YhotxeFNbMEPzi09DZuLwEdxruz
         GBoA+ntX1cyyoY/14KCRFtQFs0DeBxeiK91vOYkOdzTy0gklUCop6lBU9fP77qQ+GttD
         awrYzwThGF3cM0dkTz8ofbXVIfQoQhH2J9AOYWTyT8r1dFcumFafWW+gFAjah7p3PD53
         fkGA==
X-Gm-Message-State: AOAM5319cSdHu1EjilFJre+QiLc9dp9AcqHa/L7eqg9ItiZgSbAfKfZt
        rSuskz6UCSS/C9EbueHyuhfVDXf2R7g=
X-Google-Smtp-Source: ABdhPJzr2X89hLn4t8hFmRDYHVWkJTxS7Xz5lNEd7Gzal8dzWgNccYlxbl76q3iirJECH0u/dJJn1w==
X-Received: by 2002:aca:b387:: with SMTP id c129mr11085004oif.30.1619395224809;
        Sun, 25 Apr 2021 17:00:24 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t9sm3072054otl.5.2021.04.25.17.00.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 25 Apr 2021 17:00:24 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 25 Apr 2021 17:00:23 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 5.12
Message-ID: <20210426000023.GA116328@roeck-us.net>
References: <CAHk-=wj3ANm8QrkC7GTAxQyXyurS0_yxMR3WwjhD9r7kTiOSTw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wj3ANm8QrkC7GTAxQyXyurS0_yxMR3WwjhD9r7kTiOSTw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 25, 2021 at 02:06:35PM -0700, Linus Torvalds wrote:
> Thanks to everybody who made last week very calm indeed, which just
> makes me feel much happier about the final 5.12 release.
> 
> Both the shortlog (appended) and the diffstat are absolutely tiny, and
> it's mainly just a random collection of small fixes in various areas:
> arm64 devicetree files, some x86 perf event fixes (and a couple of
> tooling ones), various minor driver fixes (amd and i915 gpu fixes
> stand out, but honestly, that's not because they are big, but because
> the rest is even smaller), a couple of small reverts, and a few
> locking fixes (one kvm serialization fix, one memory ordering fix for
> rwlocks).
> 
> Anyway, this obviously means that I'll start the merge window for 5.13
> tomorrow. But I'd ask that even developers champing at the bit to get
> their shiny new code merged please spend a bit of time running and
> checking out 5.12.
> 
> Despite the extra week, this was actually a fairly small release
> overall.  Judging by linux-next, 5.13 will be making up for it.
> 

I wonder if it makes sense to report the status of -next at the beginning
of a commit window on a regular basis.

For next-20210423:

Build results:
	total: 151 pass: 149 fail: 2
Failed builds:
	csky:tinyconfig
	mips:allnoconfig
Qemu test results:
	total: 461 pass: 440 fail: 21
Failed tests:
	arm:raspi2:multi_v7_defconfig:net,usb:bcm2836-rpi-2-b:initrd
	arm:raspi2:multi_v7_defconfig:sd:net,usb:bcm2836-rpi-2-b:rootfs
	mipsel:mips32r6-generic:malta_32r6_defconfig:nocd:smp:net,pcnet:ide:rootfs
	<all riscv32>

Let's see how many of those problems find their way into mainline.

Guenter
