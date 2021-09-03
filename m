Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A576D4004F6
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 20:38:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348188AbhICSjH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 14:39:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230421AbhICSjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 14:39:05 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41136C061575
        for <linux-kernel@vger.kernel.org>; Fri,  3 Sep 2021 11:38:04 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id q21so71041plq.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 Sep 2021 11:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AwMjWECVF5DouWRg4DDCdzuDm8b1FUkL2lfLjigAdrw=;
        b=yPp78YefA5OulhXKpgoj7VOFdGIMV4/hkTb7A7cYDExX5sMe0SIb9JkbU5kkQGNFqM
         Mg6TWDXyH0psAuuj9rC/blDlean6r4rAZvJFcVsg2vNblmUQ7B6FcN6+CmJvcBXbD6hR
         jQuMs6DQVKqMQoZ7R8b68PnqpPfWTimC9XLCS3XjH1aAFuGRghcl3XLNA/ox+qCk/OH8
         GDMml/nqQyANCVkw1+3m0IfZ4opjWUp7GampTB4girBWalOk3FiBI4A9wLbxy96eoEjT
         UCbxYj/7QdzJeTxBuCpebgB0CjRKtvIQEZkztGLX5zWqcyTuv+63lXWzU6UVt30o9BkG
         ++dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AwMjWECVF5DouWRg4DDCdzuDm8b1FUkL2lfLjigAdrw=;
        b=j5qLRg1wUGFbU4MHuqsnmFvoPC5fzGfDQnatwW/ctj31gKX8dRCP7WgB/KWbjwWDYD
         WK8MOPHfiQ7TkqGpjV0k0vOLLFNc09EFHqiWgT+6Lz2EZGvN4P6bJDG8i/38+OFRO+sD
         GUlcqB4OswQ4zh1gqiVSS+aGXDxFwwmhDlNB6jlu0ln0gA1NEz9usUxichzMaYRCSD0K
         0jL4o0OY+183MJ2kxXdRYnTrkoUfgojRkZMz1aG/U05YCIyoLRn07qwwAFt8t48pT5Yh
         FJuPAPRmj+kldEUaT/s1iHGlZmZQFMWFMpff2KI0S+4CWzkcxyqx6omqt0U+p4PjDMrg
         YNIQ==
X-Gm-Message-State: AOAM532qolo41tTB6w57kJCK/RTEwEI5krI1ZyjGj+WEuCmO9RzpOAOi
        wiI+MFjTHFaMPU9bcdglnSGSmS4Q6kUBBEg1EiHMKg==
X-Google-Smtp-Source: ABdhPJyyj+KbMk2/1Jcy/3c5IkjNcQX5t+5qP+Gn0/3iNoyJbLgEOdEywfmmlMNyqFCeuS7aVFZovgcz/HSC0ZGSCsA=
X-Received: by 2002:a17:90a:414c:: with SMTP id m12mr342815pjg.100.1630694284100;
 Fri, 03 Sep 2021 11:38:04 -0700 (PDT)
MIME-Version: 1.0
References: <22d59432-1b8e-0125-96e9-51b041fe3536@kernel.dk>
 <20210827235623.1344-1-phil@philpotter.co.uk> <89679d81-7e9e-7cae-c335-b97d53fa68ab@kernel.dk>
In-Reply-To: <89679d81-7e9e-7cae-c335-b97d53fa68ab@kernel.dk>
From:   Phillip Potter <phil@philpotter.co.uk>
Date:   Fri, 3 Sep 2021 19:37:53 +0100
Message-ID: <CAA=Fs0kVfjn7vDSq-v=aQcUuZwoST0ucYRir90GEC5cU=K9Hrw@mail.gmail.com>
Subject: Re: Wanted: CDROM maintainer
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-scsi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Sept 2021 at 15:09, Jens Axboe <axboe@kernel.dk> wrote:
>
> On 8/27/21 5:56 PM, Phillip Potter wrote:
> > Dear Jens,
> >
> > Thought I'd reply publicly given the spirit of the mailing lists, hope this
> > is OK.
> >
> > Whilst I haven't worked on this area of the kernel, I would certainly like
> > to register my interest. Many thanks.
>
> Why don't we give it a try, then? Here's what I propose:
>
> 1) Send a patch that updates MAINTAINERS for the uniform cdrom driver to
>    yourself
>
> 2) Just send pull requests for changes through me, so I can keep an eye
>    on it at least initially
>
> I'll send in a patch to update the SCSI cdrom to just fall under SCSI,
> probably just removing that entry as that should then happen by default.
>
> --
> Jens Axboe
>

Dear Jens,

Many thanks, sounds great - I'll send through a patch this evening as suggested.

Regards,
Phil
