Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F10E642E1C9
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 21:01:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232676AbhJNTDG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 15:03:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232468AbhJNTDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 15:03:04 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60DB4C061570
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 12:00:59 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id y15so31255817lfk.7
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 12:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N65pshGMOSWSb7ytdKQXKm+0kQotiHH1u3g8XlS6SNw=;
        b=MurAIBhAyWvppT1gcNnRicRI9zIENGp8xMMvTyFCuc/Ed0okX64APsncB/biZCuK/W
         YkbhQnbgtIVSbavZyNTA6MaswMyeo76MVVreGHF5lgKUd1Id+FiJuiUwqNeQ6gkiRgJK
         EGbBBUD90fzEUuim+zdEiYSIgfnlmIBH8/VqVRkiHMMu6EtzF/G6soZ8egpcYoDxiJgq
         eJ3lV7IewaWCU8j0LPzOhVLYCRGvzxL1KgHDj10F1AxTAyjKLXZRb7dyg8odmI7bsN6D
         KoGgXsWQ2CA3ZUwikn3n5UuyGQxdOq1v6hSIwdSlMlv5cKIvgZl0x0ihmPu8V09Bz+FO
         H6ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N65pshGMOSWSb7ytdKQXKm+0kQotiHH1u3g8XlS6SNw=;
        b=haZutRc4rS9wcEDv4jW5+q4DBqClFXmo7kz7HUQRh6bytNAoS7P+LE5H4gRXUG+UZS
         lfW23yCVlL2uJqmsXlbIZAafMfWD/i1CugESz7h3eh56F5FkuGOy9CHYisWyBcQvOXTE
         gPIlGaQEPSOexS9gIt99BbaCau9L6ymZWIr5aWlLjFw6m9buVHMfa/7LvkyvMtS6fyMu
         c59wMBiF7aEdGi0wwBSNZfMJbhb9s226bkIc4zgDCPiMX6R/o8mCuSNwDUF59Un6Gk/T
         MJYXZUGGRSLRGyFRZwwzytLVDFnQngDwn5jVeP4Waz+gJ+tqJrL6ReQYp8NbZeSJDCqD
         inXQ==
X-Gm-Message-State: AOAM533JMDGmpqRJ11j6mE+PjtKPSQAyfaPzmvk+7fV+mAvhU4hMxFFz
        CrqDIrGisy4hz6k5LILg7awU0BzLMlIPY/+bfoohbg==
X-Google-Smtp-Source: ABdhPJx4VtNZo6P/3mvHn2eIoRK5I0Ry6vLL9tIF5Vufdc6MMyrG1tLIRdbjhsp6q+0UJjBwDlR4ikuAI6lCXcOdKO0=
X-Received: by 2002:a05:6512:2284:: with SMTP id f4mr6823396lfu.489.1634238057524;
 Thu, 14 Oct 2021 12:00:57 -0700 (PDT)
MIME-Version: 1.0
References: <20211013181658.1020262-1-samitolvanen@google.com>
 <20211013181658.1020262-10-samitolvanen@google.com> <YWgSwmzPFrRbMC1P@zn.tnic>
 <202110140904.41B5183E@keescook> <YWhpbu/Y6V2p/zlY@zn.tnic> <CABCJKueW+=DfzONAZb-XF=mWYH_S-BeNihZfGhidOGJO=WYmZw@mail.gmail.com>
In-Reply-To: <CABCJKueW+=DfzONAZb-XF=mWYH_S-BeNihZfGhidOGJO=WYmZw@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 14 Oct 2021 12:00:46 -0700
Message-ID: <CAKwvOdnw4Ci_z4=y7NDFiWyhRO8W_KXjyBtd-RuNuznA2iMiPg@mail.gmail.com>
Subject: Re: [PATCH v5 09/15] x86: Use an opaque type for functions not
 callable from C
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Borislav Petkov <bp@alien8.de>, Kees Cook <keescook@chromium.org>,
        X86 ML <x86@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-hardening@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 14, 2021 at 11:24 AM Sami Tolvanen <samitolvanen@google.com> wrote:
>
> Anyway, I thought using a macro would make the code easier to
> understand. I'm happy to rename it to something that makes more sense,
> but also fine with switching to a simple extern u8[] if that's
> preferable.

Perhaps `extern u8 []`s with a comment that these symbols are
functions that aren't meant to be called from C, only asm (or compiler
generated code) would suffice?
-- 
Thanks,
~Nick Desaulniers
