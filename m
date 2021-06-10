Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 510A63A338C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 20:52:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230421AbhFJSyD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 14:54:03 -0400
Received: from mail-yb1-f182.google.com ([209.85.219.182]:41552 "EHLO
        mail-yb1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230351AbhFJSxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 14:53:55 -0400
Received: by mail-yb1-f182.google.com with SMTP id q21so734633ybg.8
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 11:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HfuCeAl5MSl4lisgs4d54ngu4sgiEZWbJvzZFPXnGcA=;
        b=svkIN/o8q6QyD6NGQYF66lgAUSDiyDZ/YRa9v88JiLTRVvXi/9kmo2nPCMSyST0e3R
         hGteTKQQF2W3PRa9xzbbYYhm/nTJhUXcqZw2+DLPdmrlAethpVLlvZemaJZiuDZ6IKua
         LuLLoYkVEQ5uMXCiQeVmphF6NX8r+kxX2rVuzXAcRdXcu+PD8hxsHSxLMOFWSFP1vMtI
         bBVOzEhox8tRx5vAp3NGUzRPGGPRGzxRrF/aU0etRNtKzzDDBPWRuVFfCrULbiUq5GgJ
         ixysB+vpzjSszn/5LKFkME3AvAG9QXu/EVzjLuaLE4VKcFMBasS2Sy6uJ5QGJ+Vsi38r
         yBvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HfuCeAl5MSl4lisgs4d54ngu4sgiEZWbJvzZFPXnGcA=;
        b=JEOR0HkeM7U0gnEsq/2pgRsMKiGc5EtOODIXPvCHnkKfPw9/XYRcyCjyg3LFfYurmY
         EBL9TSYI41h6tL0HsIvJGEgvoQL9Y/VcWCjl7Wi1VG7oQKtPF20If5RSBRkM6zE78GWW
         /1XUoCwnFkDayoNdhhx395Ka3ewdasVGvxiMSgsHPOkxppCmNMuL/tkDikxZj/f5Iltn
         Wgo2BTUmQSrPFUoJ/gpSotCVzEhhAUB0qeeSLfuR0wCVmiQ3mgo7k6iYwerQ+Gkc7nNI
         Z0hIVx5IR4di7nshwu17vSGZFLvcVMLRj+4G0pJZlGn/HfHez+EvdjdtKOYxrpasWg4p
         BqIg==
X-Gm-Message-State: AOAM5315WAt37SkWTaiek1ysLgNeR67C/lp0Q4DuKhJDePjwFeU2DDa7
        yQeC52Kh7FpMJ0di8V2CZwcdhjEeq21Mk5JQtuqTQQ==
X-Google-Smtp-Source: ABdhPJzipU485Q+rpHQ4rMM9oZranxS/4t+QN2Qyh4IDKML6L1xQi5pb6y2LK6b8hkDRGElu0UmTyLCIN9Yjx1rolIY=
X-Received: by 2002:a25:7085:: with SMTP id l127mr296805ybc.293.1623351047675;
 Thu, 10 Jun 2021 11:50:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210506193352.719596001@infradead.org> <20210506194157.452881700@infradead.org>
 <YMJWmzXgSipOqXAf@DESKTOP-1V8MEUQ.localdomain>
In-Reply-To: <YMJWmzXgSipOqXAf@DESKTOP-1V8MEUQ.localdomain>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Thu, 10 Jun 2021 11:50:36 -0700
Message-ID: <CABCJKudzC-Nss_LGrpYwRqwdDxeWOf1o6Bvp3J2fBQthEB=WGg@mail.gmail.com>
Subject: Re: [PATCH 01/13] objtool: Rewrite hashtable sizing
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>, X86 ML <x86@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jason Baron <jbaron@akamai.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 10, 2021 at 11:14 AM Nathan Chancellor <nathan@kernel.org> wrote:
> Adding Sami because I am not sure why this patch would have much of an impact
> in relation to LTO. https://git.kernel.org/tip/25cf0d8aa2a3 is the patch in
> question.

It's because LLVM enables -ffunction-sections with LTO, so using .text
section size to estimate the reloc hash table size isn't going to be
accurate, as confirmed by objtool output with --stats:

  OBJTOOL vmlinux.o
nr_sections: 141481
section_bits: 17
nr_symbols: 215262
symbol_bits: 17
max_reloc: 24850
tot_reloc: 590890
reloc_bits: 10

Sami
