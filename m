Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4C7B339E15
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Mar 2021 13:51:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233369AbhCMMtn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Mar 2021 07:49:43 -0500
Received: from mail.skyhub.de ([5.9.137.197]:51822 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231497AbhCMMtZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Mar 2021 07:49:25 -0500
Received: from zn.tnic (p200300ec2f1971005f32d49e743e65b9.dip0.t-ipconnect.de [IPv6:2003:ec:2f19:7100:5f32:d49e:743e:65b9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5FCCC1EC03A0;
        Sat, 13 Mar 2021 13:49:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1615639764;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=GMA48jWDBuLlXEc4qbUS7MDYbEpxc9CIvQlJSvKXFb4=;
        b=q/HKyHxn05U1+I/fKkOkdjJCV9snTk4m5KKqrGooKLnj5pGR3nHNsJi868Qvu61lpvl7Cs
        /pB66CGnnEmwTD31nYtVbqkTFX+mh4tUjgV3BhEAe9n7cSVNJJU7WWKbnLZ012DGln3VZI
        XtjxYBxDB7vVOixgfDmEwQpNhzLad/0=
Date:   Sat, 13 Mar 2021 13:49:19 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Sedat Dilek <sedat.dilek@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        rostedt@goodmis.org, hpa@zytor.com, torvalds@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-toolchains@vger.kernel.org,
        jpoimboe@redhat.com, alexei.starovoitov@gmail.com,
        mhiramat@kernel.org
Subject: Re: [PATCH 0/2] x86: Remove ideal_nops[]
Message-ID: <20210313124919.GD16144@zn.tnic>
References: <20210312113253.305040674@infradead.org>
 <20210312205914.GG22098@zn.tnic>
 <CA+icZUWSCS6vAQOXoG6nsW+Dbnogivzf+rmegCTMjz5hjE5cKQ@mail.gmail.com>
 <20210313084923.GA16144@zn.tnic>
 <CA+icZUVEkA6+5d3NGy7_G8eiaPvJkO_JCAX=XQwT1qpiGkLMWw@mail.gmail.com>
 <20210313121541.GC16144@zn.tnic>
 <CA+icZUXrJHHDNOC+DAcr9iw4MXn5cBDj-JrDkxeumk978Gtdcg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+icZUXrJHHDNOC+DAcr9iw4MXn5cBDj-JrDkxeumk978Gtdcg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 13, 2021 at 01:38:22PM +0100, Sedat Dilek wrote:
> AFAICS you did a 5 times x86-64 defconfig with dropped pagecache and `make -j9`?

The tailored .config for that particular test box.

> Does your distribution offer LLVM/Clang v12.0.0-rc3 (released this
> week) binaries?

The partition on that box I used is debian testing, so no:

$ apt search llvm-1* 2>/dev/null | grep llvm-1
libllvm-11-ocaml-dev/testing,testing 1:11.0.1-2 amd64
llvm-10/now 1:10.0.1-8+b1 amd64 [installed,local]
llvm-10-dev/now 1:10.0.1-8+b1 amd64 [installed,local]
llvm-10-runtime/now 1:10.0.1-8+b1 amd64 [installed,local]
llvm-10-tools/now 1:10.0.1-8+b1 amd64 [installed,local]
llvm-11/testing,testing,now 1:11.0.1-2 amd64 [installed,automatic]
llvm-11-dev/testing,testing,now 1:11.0.1-2 amd64 [installed,automatic]
llvm-11-doc/testing,testing 1:11.0.1-2 all
llvm-11-examples/testing,testing 1:11.0.1-2 all
llvm-11-runtime/testing,testing,now 1:11.0.1-2 amd64 [installed,automatic]
llvm-11-tools/testing,testing,now 1:11.0.1-2 amd64 [installed,automatic]

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
