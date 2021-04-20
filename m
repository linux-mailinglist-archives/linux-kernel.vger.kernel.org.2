Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A161F3660DD
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 22:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233968AbhDTU0b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 16:26:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233751AbhDTU01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 16:26:27 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41D6AC06174A
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 13:25:55 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id 65so44557753ybc.4
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 13:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6ZnvC7WqtbGWJJ90rcSCNfd5IgRs5WT1R+r3wLlKOvA=;
        b=Py3f40b0nf5cI5BfBtqXJGDUaFTD1Ffq+FieXmhIuOdeqrJBC9ST3uixHFF4RtIDHi
         gvlacx9ZSL1nuTEouTfQwHfZ1F81drfsPl2n8K0R62/mXLyvOIpbyDB8HxOcuwATW0C8
         bQyiZEpuuAudaCnZEaOJ1asNTZiqnak0ep/WuDQOBMq0WuC1bLXFn9ksZFhhajsHnQ+1
         uF86qJh8oCbpKDFONrQsaNQt46a8Nue9lTmWj1wJsdg9SDQf15yAf7QlkTsfeRoOcqEM
         UIxdhBs5eW8wU3PldTBPwLLA/0mJ2lluxerLIqsXRhOoRU/nI7lrLhNXu/UDGjOcfjKy
         WzIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6ZnvC7WqtbGWJJ90rcSCNfd5IgRs5WT1R+r3wLlKOvA=;
        b=Yb7cTaIWg6h8kpH8FsFF362Dp9OYYaNvKCBUao7MZ/uiHZBi+P4JN+x5QtTraM9dNL
         7SUvkDolXryxSFAPxCeSFh5wDEVgrnIMLv57SMxbugTpQVGOuJ8dJiv7P+4qs2keBvfc
         aUzeiHij4ESCNVfK6VNOGhX6eDAdBnQNSEGPfXTE6g7p8nuyN4+1Y4p74OCQ0p+QBaqO
         pq728J2fyrulE+IDtpnpKOolUvV5uWd74HdqWD/BimkLNbgzrEzVa7M7yStox6cgBWhz
         zTsmXn7OWRnB+/iFyJF1QBjbGydqfBiI9Hj5Yv8wPXoMmJwdSN3MifaN4/Bc75hRPfJf
         H+6A==
X-Gm-Message-State: AOAM5308LEB90XQgTDJ2SEoUCRbCSfvMeD1lcZdxUx+O0nkKmzzY3BfE
        mtr9O8n+cZoolRpVCoUrdvJbONmdpfrVrxFqzXicOQ==
X-Google-Smtp-Source: ABdhPJxVGLLM/eG1NkKpWkXN/Pb0N2bQIRRCmeqri95nr5U/1ekvrnyvttCaB4PypphENW5I9rpX0Ly+XvAM6pUs+F0=
X-Received: by 2002:a25:7085:: with SMTP id l127mr27885350ybc.293.1618950354345;
 Tue, 20 Apr 2021 13:25:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210416203844.3803177-1-samitolvanen@google.com>
 <20210416203844.3803177-2-samitolvanen@google.com> <20210420181412.3g5dsyhggxnvif7k@treble>
In-Reply-To: <20210420181412.3g5dsyhggxnvif7k@treble>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Tue, 20 Apr 2021 13:25:43 -0700
Message-ID: <CABCJKudO9Ovuih3ieQ70w8y744Cg3tPnciVBhCuuBPuhq4i3Xg@mail.gmail.com>
Subject: Re: [PATCH 01/15] objtool: Find a destination for jumps beyond the
 section end
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     X86 ML <x86@kernel.org>, Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        linux-hardening@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 20, 2021 at 11:14 AM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>
> On Fri, Apr 16, 2021 at 01:38:30PM -0700, Sami Tolvanen wrote:
> > With -ffunction-sections, Clang can generate a jump beyond the end of
> > a section when the section ends in an unreachable instruction.
>
> Why?  Can you show an example?

Here's the warning I'm seeing when building allyesconfig + CFI:

vmlinux.o: warning: objtool:
rockchip_spi_transfer_one.f088382d97b74759d70e27e891fe8f1c()+0x149:
can't find jump dest instruction at
.text.rockchip_spi_transfer_one.f088382d97b74759d70e27e891fe8f1c+0x7dc

$ objdump -d -r -j
.text.rockchip_spi_transfer_one.f088382d97b74759d70e27e891fe8f1c
vmlinux.o
0000000000000000 <rockchip_spi_transfer_one.f088382d97b74759d70e27e891fe8f1c>:
  ...
 149:   0f 85 8d 06 00 00       jne    7dc <.compoundliteral.4>
  ...
 7d7:   e8 00 00 00 00          callq  7dc <.compoundliteral.4>
                        7d8: R_X86_64_PLT32     __stack_chk_fail-0x4

Sami
