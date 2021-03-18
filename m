Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06829340C49
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 18:56:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232501AbhCRR40 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 13:56:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232363AbhCRR4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 13:56:08 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B872BC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 10:56:08 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id z9so5674282ilb.4
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 10:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b5Wthup5WUj6FDszH8mqgF6S6FuvXRiquynPBZwqM9k=;
        b=e/SyiKOU9yQ/RADGScIBuTFmsc+wMFbrI6vcazKna/OdDKHSb2e23OrKwbrfNqR/ZH
         x+5TmHFYZpyppW1xQVmL0xrF5Z6LvTKxSfVCxydrM7Prb/IC5LSyPn9g6Tq1CwXhta/A
         mIzfVfUtRMirKSa4j3n3N838NLHjhcEg3vDCg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b5Wthup5WUj6FDszH8mqgF6S6FuvXRiquynPBZwqM9k=;
        b=YCSiCy4aocucL0jSR0kPMbPOWxnQpO72JFcvS2oXGxjU8RwWi4xsSUf7nvB4IUswoN
         RhovvFoKoE/luLH9AyGbDtB149l/xMISskOTPHqfmCaCSCmj2u9AeA3LtzndWE1p2sxm
         qf5QHunKNjcDGI3NMrUMF2iFIDDrNcFgjp1NV7fJjOU6eobpu4WMCZLolSohyEs39QAR
         YyZduP0YFMKvmCgY5Eq/k/nO6lw6QsDHqsjfWCitjNRBw/LUmecrjwRe6Csf50Pu0BhU
         J77RZx0mNw091tWqMSgeOyderx1e9mFBUEdcvJ3Ur8/Mm/rsy64DRROmHZ1+0PqN+4WD
         FJtA==
X-Gm-Message-State: AOAM530et2ZI1CUqLRmFI+iZoh35zfjEcLI2IaEx5VAm6zPJf705wCVL
        3s8r8AHVb6mO4nQ9qNt6uB7WzOW86Ex7BA==
X-Google-Smtp-Source: ABdhPJwnlbKy+JUEkwuAqUjDbNmC+upa2ctckHnbOE4RDehSfBpDAToXKCiYT4m/yDq176OUiVHGbQ==
X-Received: by 2002:a05:6e02:e0f:: with SMTP id a15mr4225381ilk.203.1616090167912;
        Thu, 18 Mar 2021 10:56:07 -0700 (PDT)
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com. [209.85.166.42])
        by smtp.gmail.com with ESMTPSA id b9sm1303794iof.54.2021.03.18.10.56.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Mar 2021 10:56:07 -0700 (PDT)
Received: by mail-io1-f42.google.com with SMTP id r193so3223703ior.9
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 10:56:07 -0700 (PDT)
X-Received: by 2002:a5e:8416:: with SMTP id h22mr11102113ioj.119.1616090167087;
 Thu, 18 Mar 2021 10:56:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210317104547.442203-1-leon@kernel.org> <CAHk-=wj+Bsc1T41qziHxf9DvrBrYSBWKj27hEL0EbysCGRPzTA@mail.gmail.com>
 <YFMHYUbPmpS+Kzcj@unreal> <CAHk-=wgdHxuQmhKR9oAS5bhahmo5CFj3x6YdHVPBCGhbSz6rEg@mail.gmail.com>
 <YFOSpQcrfP1UvqoL@unreal>
In-Reply-To: <YFOSpQcrfP1UvqoL@unreal>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 18 Mar 2021 10:55:51 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjZoOr4yqAAxricTsachacAUvcKt6HOfxyReCyMN0V=QQ@mail.gmail.com>
Message-ID: <CAHk-=wjZoOr4yqAAxricTsachacAUvcKt6HOfxyReCyMN0V=QQ@mail.gmail.com>
Subject: Re: [PATCH master] module: remove never implemented MODULE_SUPPORTED_DEVICE
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 18, 2021 at 10:49 AM Leon Romanovsky <leon@kernel.org> wrote:
>
> No, I opened patch and added the note manually, so it is definitely my VIM.
> Most likely this part of my .vimrc caused it.

Ok, that would do it.

Yeah, whitespace is easy to "fix" at patch application time, but it
really is meaningful and you never should change whitespace for
patches.

Maybe you can limit your rules to just particular file types
(although, honestly, I think it's bad for headers and C files too when
it then causes entirely irrelevant and independent changes - you only
want your own _new_ edits to be whitespace-clean, not fix other random
issues).

Better yet, maybe not "fix whitespace" at all, but have some code
coloring logic that just points out bad whitespace? I use "git diff"
myself, with colorization being default for tty operations:

    [color]
        ui=auto

so that then "git diff" will show you your (new) evil whitespace
errors when you review your changes, but won't complain about existing
whitespace issues..

                      Linus
