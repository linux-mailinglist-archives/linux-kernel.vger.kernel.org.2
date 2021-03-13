Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80850339D1C
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Mar 2021 09:52:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232179AbhCMIwB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Mar 2021 03:52:01 -0500
Received: from mail.skyhub.de ([5.9.137.197]:47096 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230114AbhCMIvh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Mar 2021 03:51:37 -0500
Received: from zn.tnic (p4fed3942.dip0.t-ipconnect.de [79.237.57.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 603BF1EC008F;
        Sat, 13 Mar 2021 09:51:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1615625496;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=StXyIIfqkxQHxQ5eh5tIDHPBxAG+44uelUfk7AF9bs4=;
        b=QxNPBfDwXJp2pCLJl7x8ymZD5bJttYMWExFOIJTtuT47G7HhAN1nm4XJWAw+FXsIYVA2Wy
        bd9lNprMeSPtA4eSrxWB20QCPmHiKMJxXyyF8ykbtyhzVnmP5PnA837qX9xPpnZL6zykFM
        5OQPDenNjIWs8G2tnTEbqNtGD5vwX/k=
Date:   Sat, 13 Mar 2021 09:49:23 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Sedat Dilek <sedat.dilek@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        rostedt@goodmis.org, hpa@zytor.com, torvalds@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-toolchains@vger.kernel.org,
        jpoimboe@redhat.com, alexei.starovoitov@gmail.com,
        mhiramat@kernel.org
Subject: Re: [PATCH 0/2] x86: Remove ideal_nops[]
Message-ID: <20210313084923.GA16144@zn.tnic>
References: <20210312113253.305040674@infradead.org>
 <20210312205914.GG22098@zn.tnic>
 <CA+icZUWSCS6vAQOXoG6nsW+Dbnogivzf+rmegCTMjz5hjE5cKQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+icZUWSCS6vAQOXoG6nsW+Dbnogivzf+rmegCTMjz5hjE5cKQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 13, 2021 at 06:26:15AM +0100, Sedat Dilek wrote:
> x86/jump_label: Mark arguments as const to satisfy asm constraints

Where do I find this patch?

> x86: Remove dynamic NOP selection
> objtool,x86: Use asm/nops.h
> 
> My benchmark was to build a Linux-kernel with LLVM/Clang v12.0.0-rc3
> on Debian/testing AMD64.
> 
> Patchset applied for a first build:
> 
>  Performance counter stats for 'make V=1 -j4 LLVM=1 LLVM_IAS=1
> PAHOLE=/opt/pahole/bin/pahole LOCALVERSION=-7-amd64-clang12-cfi
> KBUILD_VERBOSE=1 KBUILD_BUILD_HOST=iniza

There's a reason I have -s for silent in the build - printing output
during the build creates a *lot* of variance. And you have excessive
printing with V=1 and KBUILD_VERBOSE=1.

Also, you need to repeat those workloads a couple of times - one is not
enough. That's why I have --repeat 5 in there.

Also, you need --pre=/root/bin/pre-build-kernel.sh where that script is:

---
#!/bin/bash
echo $0

make -s clean
echo 3 > /proc/sys/vm/drop_caches
---

so that you can avoid pagecache influence.

Lemme rerun here with clang.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
