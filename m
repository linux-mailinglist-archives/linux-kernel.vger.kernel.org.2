Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 916B43D52E4
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 07:41:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231691AbhGZFBS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 01:01:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbhGZFBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 01:01:18 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53724C061757
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jul 2021 22:41:46 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id t68so7762523qkf.8
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jul 2021 22:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lr+v1Dycx82v2pTJSxbImSG810JR0dbgQNbPvS6Ipb0=;
        b=WE3mKf+WpgmQ/hDXfUmbJmqb1QJ1I+FCIHwSsdZ5p6gTN+UUiOAfOLYO0QjUNfYQw5
         e1N9ejWyN5ishKG2Z2QujKnzsBtWMIMKUh2V5IJXAot9vfOBIE0s4EcHgzqI6apjfJqt
         Lemoy6skg8RJgsO5TJUpvXX0YHY0biMZ3V/v47dXTqxfR+PnFtK6Ndx8MuVTEjd+J2ec
         yoLrxwc9JTjyN7sqzWjsW7svGHCfqJgZTOvuG+bRL0CTbS4HGVg94YmThlnRd3HUMhSR
         L41o+QekJPi8R7GmZ8iKDvqUPu7veBR1aZ7/GClk11oEJsWa0s+PyZNBRIogqcla2nIG
         CWrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=lr+v1Dycx82v2pTJSxbImSG810JR0dbgQNbPvS6Ipb0=;
        b=iDqm0/HmXowGbpz/s6M810VuSbnoZa8DtV8Kl1VHaig7FlTVN/Qy1XmfDz6b8uNhpE
         JmpC1XZbHkTCfQ4u0aHosCWnh0krF6OqOH8XOjTFNRz//cFdQ15XoYz1EIq0KTiwu5pp
         GNq2Ic4+qzyX67DYHwYSAJfFGmnYaZ06b3yMLUeHFOV7WG0YJIX875esD5TyAibHjB+0
         P9u9HwbuanLmDfCLmqbmeKU2KaSyUX+w74gRCkBwKbzOgYLa3s5hVaIxOane41LqC78i
         fKgiHSxfGX16DPr6D2YUj2mjM90ReBeJzcmc1NoaLsU76OtVsZfbB26NCav3Ch2fPOpo
         uKQA==
X-Gm-Message-State: AOAM532gnJzz4V9mQ2VeYBpJXIsewZhTP3AaTBZi8PHYkSqMqkCfr9yF
        wIbmtE2QyqQdHH/UXOLuzts=
X-Google-Smtp-Source: ABdhPJy2qAcnxhgYYYtcRq2W5FxpuE9r8hCuwuj/tGe2bi3NaCvC95eKb2iAwFKBaSnsC5rhIsJY9w==
X-Received: by 2002:a37:b9c2:: with SMTP id j185mr15649914qkf.336.1627278105384;
        Sun, 25 Jul 2021 22:41:45 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 141sm10441737qki.15.2021.07.25.22.41.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jul 2021 22:41:44 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 25 Jul 2021 22:41:43 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 5.14-rc3
Message-ID: <20210726054143.GA2219113@roeck-us.net>
References: <CAHk-=wgvwZiLbZpFUApWFDkwyjC3+EmRoEBAuP+VzNQaMd630g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgvwZiLbZpFUApWFDkwyjC3+EmRoEBAuP+VzNQaMd630g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 25, 2021 at 03:54:56PM -0700, Linus Torvalds wrote:
> Here we are, a week later. After a relatively big rc2, things seem to
> have calmed down and rc3 looks pretty normal. Most of the fixes here
> are small, and the diffstat looks largely flat. And there's not an
> undue amount of stuff.
> 
> The fixes are spread fairly evenly all over - driver changes do
> dominate, but it all seems commensurate with code size in general, so
> not anything odd or unusual. There's two bigger commits, but one of
> them is a revert, and the other is just making the amdgpu codec info
> structure initializations much clearer.
> 
> There are still various discussions about a few pending issues still,
> but on the whole things are looking pretty good, and I know of nothing
> so scary as to keep people from getting their toes wet and testing
> this all out.
> 
> Please test,

Here we are:

Build results:
	total: 154 pass: 153 fail: 1
Failed builds:
	riscv32:allmodconfig
Qemu test results:
	total: 471 pass: 470 fail: 1
Failed tests:
	arm:z2:pxa_defconfig:nodebug:nocd:nofs:nonvme:noscsi:notests:novirt:nofdt:flash8,384k,2:rootfs

riscv32:allmodconfig still reports

cc1: error: '6152' is not a valid offset in '-mstack-protector-guard-offset='

The arm image doesn't boot because of a regression in flash code.
The fix is in the pending-fixes branch and should hopefully find its
way into mainline soon.

There is also still the following warning all over the place.

alg: self-tests for drbg_nopr_hmac_sha512 (stdrng) failed (rc=-22)
WARNING: CPU: 0 PID: 57 at crypto/testmgr.c:5652 alg_test.part.0+0x12c/0x430

The riscv32 boot problem has been fixed.

The riscv compile problem is seen randomly (roughly every other build)
if both CONFIG_STACKPROTECTOR_PER_TASK and CONFIG_GCC_PLUGIN_RANDSTRUCT
are enabled. It looks like the problem may be difficult to reproduce
for others, and I am not sure if it will be fixed anytime soon.
Since the problem may hide other compile problems, I am going to
disable CONFIG_GCC_PLUGIN_RANDSTRUCT in future riscv test builds.
The problem won't be gone, but I will no longer report it.

Similar, the warning about drbg_nopr_hmac_sha512 is only seen if crypto
self tests are enabled and CONFIG_CRYPTO_SHA512 is not enabled. The fix
is queued in -next but not in pending-fixes, meaning it might not make it
into v5.14. Since the warning is distracting and may hide other problems,
I'll force-enable CONFIG_CRYPTO_SHA512 in future test builds and no longer
report this warning.

Guenter
