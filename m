Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8DEC323248
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 21:46:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234308AbhBWUoi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 15:44:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233266AbhBWUoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 15:44:18 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E9C7C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 12:43:38 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id t29so9551091pfg.11
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 12:43:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5J3yuey8Jopd/n1D+34h9Lm2NcuZmbIr5avJg6m8XNQ=;
        b=FsvXjvSdKykMGujQxCjeeT607EZaZlfQ4Ikl+iVNHK/sgVjughb88TBIQx928s7gDQ
         /6wo2a+tGDrRK69pQ5lBQZLEi712tB04KArY400dG/w3YcwyXvGh6w7FkSeWgg9W0V0f
         /NFc5+8wBXwMlJAkaULPESvL5WWmtoDNLbQUo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5J3yuey8Jopd/n1D+34h9Lm2NcuZmbIr5avJg6m8XNQ=;
        b=DWEDoKg/IIIW8kaQZJM5T/yK9uhGfQdwmO8FhY7IsAf3jgJWEWV9mSOY6grdutnvjy
         Bsvwc/8xekFs676a8Mm0VcuWDHJraPkfTKBqClDuDxoaV305gbPvt6GKnabxgRWc8XF6
         c9ak7coBPYT6E5pM5Kqxztz1/5mJnSSlwzpfwMYds4B75wMkagZ5N4DGCEX9cKGr+eKj
         mq2Cry2SLyaFU2Ta8JIV0YS4LDR/kF+d2eANo+epglogR9nXOjFUjKenDDEAZozciJkC
         n8z2HMF0FbMwlKjZAyZE54TI1P1VFkEGtzk50eM/S6haISmQf5bba/6xb4h6z1Nt+5Vh
         1G+w==
X-Gm-Message-State: AOAM532b7h0CPTuWSSnbTZxfxHeVsLjnpJANvLUctNCowWSdGWiwmVak
        NeKcUc/+Ezgc5sQnkeZvNoEft3ZWcVMzsA==
X-Google-Smtp-Source: ABdhPJyXuBKHA0Up3r6hul0iYzBXrAzBH2DUglU/2Z4H15bTqvOkg49yYEIKQr3DLC/z75Mh3wqJLQ==
X-Received: by 2002:a05:6a00:1e:b029:1ed:b82c:bb64 with SMTP id h30-20020a056a00001eb02901edb82cbb64mr8494626pfk.78.1614113017727;
        Tue, 23 Feb 2021 12:43:37 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id v26sm6872pff.195.2021.02.23.12.43.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Feb 2021 12:43:37 -0800 (PST)
Date:   Tue, 23 Feb 2021 12:43:36 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexander Lobakin <alobakin@pm.me>,
        Sami Tolvanen <samitolvanen@google.com>,
        Bill Wendling <morbo@google.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        George Burgess IV <gbiv@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will@kernel.org>
Subject: Re: [GIT PULL v2] clang-lto for v5.12-rc1
Message-ID: <202102231243.FC8512FE3D@keescook>
References: <202102221504.0418BE2D1@keescook>
 <CAHk-=wgUS-vqCk_d0wwBWgk4tRgFpYvfyob5y28c85msqpbjuw@mail.gmail.com>
 <CAHk-=wgQ=oaLD_ybzhOP+8LFNZH3Qzpc-dp4XB4cXxXLReCdnQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgQ=oaLD_ybzhOP+8LFNZH3Qzpc-dp4XB4cXxXLReCdnQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 23, 2021 at 12:33:05PM -0800, Linus Torvalds wrote:
> On Tue, Feb 23, 2021 at 9:49 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > On Mon, Feb 22, 2021 at 3:11 PM Kees Cook <keescook@chromium.org> wrote:
> > >
> > > While x86 LTO enablement is done[1], it depends on some objtool
> > > clean-ups[2], though it appears those actually have been in linux-next
> > > (via tip/objtool/core), so it's possible that if that tree lands [..]
> >
> > That tree is actually next on my list of things to merge after this
> > one, so it should be out soonish.
> 
> "soonish" turned out to be later than I thought, because my "build
> changes" set of pulls included the module change that I then wasted a
> lot of time on trying to figure out why it slowed down my build so
> much.
> 
> But it's out now, as pr-tracker-bot already noted.

Great! Thanks for the updates; I'll prepare "part 2" right away. :)

-- 
Kees Cook
