Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B1B84216CA
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 20:47:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235807AbhJDStC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 14:49:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234590AbhJDStA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 14:49:00 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F395C061745
        for <linux-kernel@vger.kernel.org>; Mon,  4 Oct 2021 11:47:11 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id q81so697114qke.5
        for <linux-kernel@vger.kernel.org>; Mon, 04 Oct 2021 11:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=eZqPoeO/Bp/UXPZPjvOZXIvz3RA4F/vG4+9qkCVgvOo=;
        b=Q07v33dkC6t7dTmRxkWjLXeYzqOfYY3HcWnnudfGakaBcbFQB6Jlq7/c4Aw9b6knFu
         ERYGxQBs6D33Mq/plILxc3N/wBNypVCPpBFljbkTOOB9R5F3hGsmeusFxnENF46YOq5W
         3je0mruNXcsvb/gMv9vrLrsKafVoJy2Ipm9M4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eZqPoeO/Bp/UXPZPjvOZXIvz3RA4F/vG4+9qkCVgvOo=;
        b=CBPFICWZuSaoz5nLvEYI0RixYz7BkHwf2IVa6Hsty/vllARHGDYSzbPX6wOZApUmHf
         xdUi9jTuo8fZM9hewm9kOViiy7cf/Xffg6I/MfBGwb5t+pGP61kQV+0ivV+Ipu5qXE+E
         PFg2tXWXc/oEaGB7dTR+EBQh0H9HDHZBpqnnTYUmXLrAVmx2+OUGc2ECmPqAMZuzWOoA
         Kbdjks5j48BhotH4pruGsQt6FN7ZQdAZFY20m4ugfMHYIaUybwLUXE65vzvxe9r5iqbh
         1EdMT/dHpay+xHs4SE5PbpCMxCf5oEpN6MBB6oYLpdYHF4yOOahuoupStX0yQ6N/Nd/R
         MrMA==
X-Gm-Message-State: AOAM533mHdTIVHS32hW6eqvsB6FgWxWhAReJoP3b7JfjBSuZnzz89a7Z
        Fym2su+dR09hggujZ0swv/KHB71H3XM2Rg==
X-Google-Smtp-Source: ABdhPJw4Y0g+HhWMhWta+azBkLLYfNhuWSch2vXN8tKqQWmoSwdSr/+cLI7sZ7GW3TxkbPu6SWUqZg==
X-Received: by 2002:a37:44c1:: with SMTP id r184mr11381406qka.126.1633373230502;
        Mon, 04 Oct 2021 11:47:10 -0700 (PDT)
Received: from meerkat.local (bras-base-mtrlpq5031w-grc-32-216-209-220-181.dsl.bell.ca. [216.209.220.181])
        by smtp.gmail.com with ESMTPSA id g1sm8914918qtj.22.2021.10.04.11.47.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 11:47:10 -0700 (PDT)
Date:   Mon, 4 Oct 2021 14:47:08 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6] kallsyms: strip LTO suffixes from static functions
Message-ID: <20211004184708.nxkd3si45vzj5c7k@meerkat.local>
References: <202110020501.RKX4zca7-lkp@intel.com>
 <20211004162936.21961-1-ndesaulniers@google.com>
 <163337043811.3396838.458236649388694225.b4-ty@chromium.org>
 <CAKwvOdm5bBUE0df8jbXq+bSCf9U0AM3Wm4NsZeHu=Nuhi0yd-A@mail.gmail.com>
 <20211004183806.5weyuk554ppe5olb@meerkat.local>
 <CAKwvOdkzviryHByOZj1K6r6HVKcC+4Tc43jXn4Eqk9EXGVpucg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKwvOdkzviryHByOZj1K6r6HVKcC+4Tc43jXn4Eqk9EXGVpucg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 04, 2021 at 11:41:29AM -0700, Nick Desaulniers wrote:
> On Mon, Oct 4, 2021 at 11:38 AM Konstantin Ryabitsev
> <konstantin@linuxfoundation.org> wrote:
> >
> > On Mon, Oct 04, 2021 at 11:32:43AM -0700, Nick Desaulniers wrote:
> > > $ git format-patch HEAD~
> > > 0001-ARM-mm-proc-macros-ensure-_tlb_fns-are-4B-aligned.patch
> > > $ git send-email --suppress-cc=body --to keescook@chromium.org
> > > 0001-ARM-mm-proc-macros-ensure-_tlb_fns-are-4B-aligned.patch
> > > patatt: E: -: Not a valid RFC2822 message
> > > fatal: 0001-ARM-mm-proc-macros-ensure-_tlb_fns-are-4B-aligned.patch:
> > > rejected by sendemail-validate hook
> > > fatal: command 'git hook run sendemail-validate -- <patch>' died with
> > > exit code 1
> > > warning: no patches were sent
> >
> > Woah. What git version is this?
> 
> $ git --version
> git version 2.33.0.800.g4c38ced690-goog
> 
> Looks like some corporate version...anything else I can to do to help
> debug? (Moving explicit CC's to BCC).

Yeah, can you please send me
0001-ARM-mm-proc-macros-ensure-_tlb_fns-are-4B-aligned.patch as an attachment?
Also, the output of running "locale" -- it's got to be something to do with
passing stdin as opposed ot loading from file.

-K
