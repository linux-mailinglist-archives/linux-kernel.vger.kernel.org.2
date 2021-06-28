Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAB593B566D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 02:53:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231817AbhF1AzH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Jun 2021 20:55:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231689AbhF1Ayp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jun 2021 20:54:45 -0400
X-Greylist: delayed 128849 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 27 Jun 2021 17:52:09 PDT
Received: from forward100p.mail.yandex.net (forward100p.mail.yandex.net [IPv6:2a02:6b8:0:1472:2741:0:8b7:100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B05FBC061574
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jun 2021 17:52:09 -0700 (PDT)
Received: from iva7-16e50705448a.qloud-c.yandex.net (iva7-16e50705448a.qloud-c.yandex.net [IPv6:2a02:6b8:c0c:3227:0:640:16e5:705])
        by forward100p.mail.yandex.net (Yandex) with ESMTP id 204E45981989;
        Mon, 28 Jun 2021 03:52:06 +0300 (MSK)
Received: from iva4-b3ebd202b141.qloud-c.yandex.net (iva4-b3ebd202b141.qloud-c.yandex.net [2a02:6b8:c0c:4e8e:0:640:b3eb:d202])
        by iva7-16e50705448a.qloud-c.yandex.net (mxback/Yandex) with ESMTP id iNuPFh1AaH-q5JGAlwK;
        Mon, 28 Jun 2021 03:52:06 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=orca.pet; s=mail; t=1624841526;
        bh=6ZTmANWTnyfBR19OteQqAKwWX/UdFc56R8LJ5MgZO+E=;
        h=In-Reply-To:From:Date:References:To:Subject:Message-ID:Cc;
        b=KC8ZmXg325vycP4sK7SRm8o6BrVekXH7KUE/9/1gB44fjcxx0lNBmrh+gZOOQZj9X
         IIO1vtMpDIc26thZkdAXRvLRcRfDzUje3a31FmKhjV64BqCj4yBR0CVic198hkXps8
         hRQiF3qIqnv2tqCf8QmBP+5FbRCrK2Hx1IsMYoMk=
Authentication-Results: iva7-16e50705448a.qloud-c.yandex.net; dkim=pass header.i=@orca.pet
Received: by iva4-b3ebd202b141.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id 3FSFUhIMs7-q4PmdBB7;
        Mon, 28 Jun 2021 03:52:04 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
Subject: Re: [PATCH v3] x86: add NOPL and CMOV emulation
To:     David Laight <David.Laight@ACULAB.COM>,
        "x86@kernel.org" <x86@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <YNWAwVfzSdML/WhO@hirez.programming.kicks-ass.net>
 <20210626130313.1283485-1-marcos@orca.pet>
 <4b8e1393929b47d29a996f07cd332c65@AcuMS.aculab.com>
From:   Marcos Del Sol Vives <marcos@orca.pet>
Message-ID: <a7442c3e-02c2-b78b-cf3c-0343bbfa9b85@orca.pet>
Date:   Mon, 28 Jun 2021 02:52:03 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <4b8e1393929b47d29a996f07cd332c65@AcuMS.aculab.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: es-ES
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

El 27/06/2021 a las 12:57, David Laight escribió:
> From: Marcos Del Sol Vives
>> Sent: 26 June 2021 14:03
>>
>> NOPL and CMOV are a set of instructions that were introduced to the
>> x86 architecture with the i686 ISA in 1995, first implemented in the
>> Intel Pentium Pro and Pentium II processors.
>>
>> While virtually all desktop and server systems are modern enough to
>> support these instructions, in the embedded market things are a little
>> bit different: DM&P is still manufacturing their i586-only Vortex86
>> SoCs, and many embedded devices still in use are stuck on legacy SoCs
>> that either are i586-only (AMD Elan, AMD Geode GX1) or implement i686
>> but lack the NOPL instructions (Transmeta devices, AMD Geode LX).
>>
>> This is a problem because most modern Linux distributions, such as
>> Debian and all its derivatives, have started compiling targeting i686,
>> leaving old embedded devices using binary distributions without an
>> easy upgrade path.
>>
>> This ultimately results in most of these embedded devices running
>> years old, insecure and obsolete installations, and this itself can be
>> seen on the DM&P's own supported OS page where the newest supported
>> desktop Linux distro is Ubuntu 18.04, already three years old.
>>
>> The emulation of these instructions thus allow upgrading to newer
>> distributions just by replacing the kernel, keeping all precompiled
>> binaries intact.
> ...
> 
> Does this really help?
> 1) Trapping and emulating the instructions will be slow.

This is true. An emulated CMOV is almost 50 times slower than 
conditional branch on my Vortex86MX.

However, in practice this results in very little slowdown - GCC seems to 
really avoid emitting CMOVs, preferring conditional branches instead, so 
applications are still completely useable.

> 2) All 64bit cpus support these instructions - so these must be 32bit.
>     I believe the main distributions are about to drip 32bit support.

While it is true that Ubuntu has dropped support for 32 bit devices, 
Debian, OpenSUSE and many others don't seem to plan on doing so anytime 
soon.

> It also has to be said that using Ubuntu in an embedded device
> is about as sensible as running windows.
> There is far too much 'crud' running that you don't need and
> is only likely to result in security breaches.
> 
> Much better is something based on busybox+buildroot where you
> have (almost) complete control of the system userspace and
> can easily build a kernel that only has support for the required
> hardware from one of the LTS kernel trees.

These SoCs are not the average ARM-based SoC used in very high volume 
products such as WiFi routers where you want a million of units all 
executing the same thing. For those I totally agree you'd use a fully 
customized operating system on a build root image.

Vortex86 devices are on the other hand used generally in low-volume, 
niche applications, where the premium of a x86-compatible Vortex86 
device that can boot any standard x86 operating systems and applications 
is preferrable to the cost of developing a fully customized operating 
system image.

I've seen such devices used by small companies to develop point of sale 
machines, information screen, kiosks, etc... where they benefit from 
being easy to set up and, being a standard operating system, allow 
easily tweaking to the customer's needs.

Myself, I am using an eBox 3350MX-AP (which sports a Vortex86MX with 
512MB of RAM) as a small, low-power web server running Debian sid. If I 
were to use buildroot, I'd lose completely the ability to install new 
features or apply updates without having to rebuild the entire image, 
which is a complex and time-consuming task.
