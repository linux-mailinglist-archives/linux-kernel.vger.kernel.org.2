Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61EF03CD64A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 16:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240892AbhGSNYD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 09:24:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237189AbhGSNYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 09:24:01 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 086ABC061574
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 06:28:59 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id o72-20020a9d224e0000b02904bb9756274cso18280761ota.6
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 07:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bJroXTLsxSbbuxJPiogvgG9rISef9AxBrrLiQ3hhztQ=;
        b=bNvzuHFupIm55vxIahynVKCWTbbEge9gzDqPXzHpR4fbI2sOiQQWYv+6REjUMiCtCm
         mwRdvlJ6tnp25JTta6fjE0csE7bU7fuCcuTjsIloyP/PVjr6Nxl1Qj7pHLvlBZMYqx9v
         avzwl92kpJAyVO/CzOS52Wh1ca8EhGliyl2Uk1PewefhLpbFpmeYrHk3JJNBlR0NGcfh
         kQ0Hb+c1F4kzN7/92x2EsXX21AjkToA1Bvl/6S92T00JQ3qgi6a+ey423ve+Hjnd2TBl
         vBym0ihzyVxcHbBVEo8MyOnIWc4PGRJyyi2Z0vdESbanaErH+BJ6IZEVfoNkMo1TaYUB
         Z5Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=bJroXTLsxSbbuxJPiogvgG9rISef9AxBrrLiQ3hhztQ=;
        b=D1JGjW++AI2UAAfRoFhD5GD2Gu07bMpPJbc0tXBo8/lJ9r3sumvaw/cBj7chv2F3oA
         yQ4lRXWmlFxdZbMO5L/eBKiiyLIaQokrMM0mw5laZsS1x6e4XJ8hVoc8ob/VsNYRVhMJ
         3dmH9mvq7qCsOYYdAvT8ieSlAjDSARspIuSsK+m+2gFKsiY04/qkdP12KPP5ad8Lkc6a
         Ugo4aQelm40+rdLx89RIIzFueugS4W2C7uFxSGIuQC+4AtNRjbEBctyXaNfqVroHT0xn
         DRQUkvFd5pcKLk7nVXyZXbJwejpf0xh6kOhPILYabYd8o6KkosbNPWlRakFR59Wi012J
         zwrg==
X-Gm-Message-State: AOAM533RdXsyAV6b7HfmeaoWFufT/fyBgTvdyWMxMwNxcyOPZJTri9C7
        EP39aj6tkyj2zvwGUN032+ScW6uzTrM=
X-Google-Smtp-Source: ABdhPJxYTaOvgBd5mu3cWPAtcrDfFkN+9Bp5z4zwB+cscOcNch/9qJL83DUJirtAI7Wv5jJzz5UNNA==
X-Received: by 2002:a05:6830:2311:: with SMTP id u17mr18254539ote.65.1626703479056;
        Mon, 19 Jul 2021 07:04:39 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g66sm3513152oob.27.2021.07.19.07.04.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jul 2021 07:04:38 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 19 Jul 2021 07:04:37 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 5.14-rc2
Message-ID: <20210719140437.GA2178213@roeck-us.net>
References: <CAHk-=wjYghA5O+ZsWKVNApMK3j4V1EibO5P+c4MrHnqp8YhY=g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjYghA5O+ZsWKVNApMK3j4V1EibO5P+c4MrHnqp8YhY=g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 18, 2021 at 02:32:31PM -0700, Linus Torvalds wrote:
> Often rc2 ends up being fairly small and calm - either because people
> take a breather after the merge window, or because it takes a while
> for people to start reporting bugs.
> 
> Not so this time.
> 
> At least in pure number of commits, this is the biggest rc2 we've had
> during the 5.x cycle. Whether that is meaningful or not, who knows -
> it might be just random timing effects, or it might indicate that this
> release is not going to be one of those nice and calm ones. We'll just
> have to wait and see.
> 
> But it's not like anything looks super-scary, and it really is too
> early to start worrying about it, so let's just say that rc2's are
> usually smaller than this, and just leave it at that.
> 
> The changes are a bit all over the map, with gpu and networking driver
> fixes accounting for about half of the patch. But some of that is -
> again - AMD GPU header file noise, so that may not be all that
> important. The rest tends to be a mix of things: filesystem fixes,
> networking, perf tool and selftest fixes, and various random noise.
> 
> While being larger than usual, it's by no means _huge_, and anybody
> who cares about the details can easily scan the appended shortlog.
> 

Build results:
	total: 154 pass: 152 fail: 2
Failed builds:
	riscv32:allmodconfig
	riscv:allmodconfig
Qemu test results:
	total: 465 pass: 446 fail: 19
Failed tests:
	arm:z2:pxa_defconfig:nodebug:nocd:nofs:nonvme:noscsi:notests:novirt:nofdt:flash8,384k,2:rootfs
	<all riscv32>

No major change here, except that arcv2 images now build.
For reference, the riscv build problem is:

cc1: error: '4496' is not a valid offset in '-mstack-protector-guard-offset='

The patch fixing the arm boot problem is queued in pending-fixes.

There is still the warning about missing sha512 code.

[    3.581014] WARNING: CPU: 0 PID: 55 at crypto/testmgr.c:5652 alg_test.part.0+0x148/0x460
[    3.581548] alg: self-tests for drbg_nopr_hmac_sha512 (stdrng) failed (rc=-22)

The patch fixing this problem is queued in linux-next.

Guenter
