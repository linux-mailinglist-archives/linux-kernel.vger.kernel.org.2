Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34CE93F99EA
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 15:28:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245448AbhH0NXu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 09:23:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245395AbhH0NXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 09:23:37 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE5D7C06179A
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 06:22:48 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Gx0kr2Q7Lz9sXN;
        Fri, 27 Aug 2021 23:22:44 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Daniel Axtens <dja@axtens.net>, Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org, clang-built-linux@googlegroups.com,
        Nathan Chancellor <nathan@kernel.org>,
        Fangrui Song <maskray@google.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Bill Wendling <morbo@google.com>
Cc:     Itaru Kitayama <itaru.kitayama@riken.jp>
In-Reply-To: <20210813200511.1905703-1-morbo@google.com>
References: <20210812204951.1551782-1-morbo@google.com> <20210813200511.1905703-1-morbo@google.com>
Subject: Re: [PATCH v2] ppc: add "-z notext" flag to disable diagnostic
Message-Id: <163007013373.52768.2144821424552273961.b4-ty@ellerman.id.au>
Date:   Fri, 27 Aug 2021 23:15:33 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Aug 2021 13:05:11 -0700, Bill Wendling wrote:
> Object files used to link .tmp_vmlinux.kallsyms1 have many R_PPC64_ADDR64
> relocations in non-SHF_WRITE sections. There are many text relocations (e.g. in
> .rela___ksymtab_gpl+* and .rela__mcount_loc sections) in a -pie link and are
> disallowed by LLD:
> 
>   ld.lld: error: can't create dynamic relocation R_PPC64_ADDR64 against local symbol in readonly segment; recompile object files with -fPIC or pass '-Wl,-z,notext' to allow text relocations in the output
>   >>> defined in arch/powerpc/kernel/head_64.o
>   >>> referenced by arch/powerpc/kernel/head_64.o:(__restart_table+0x10)
> 
> [...]

Applied to powerpc/next.

[1/1] ppc: add "-z notext" flag to disable diagnostic
      https://git.kernel.org/powerpc/c/0355785313e2191be4e1108cdbda94ddb0238c48

cheers
