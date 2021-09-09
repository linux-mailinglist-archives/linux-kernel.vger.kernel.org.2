Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0CF140478E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 11:09:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232410AbhIIJKU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 05:10:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbhIIJKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 05:10:19 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D76FC061757
        for <linux-kernel@vger.kernel.org>; Thu,  9 Sep 2021 02:09:10 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id z12so704562qvx.5
        for <linux-kernel@vger.kernel.org>; Thu, 09 Sep 2021 02:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0hDmckIUhW4xP9T5NuiftLSR/C86BoP2/jqvqwaE02o=;
        b=elmkR1Bbh6XmYNFdzgh0hgTXafz4Xm0DePk4KvEIO4eKkY/YIFL35pXMyfKDDIMcly
         m+giVBWl+V9uwEV0R1rRrkCPH1EP8TVl3mMmI30FTk8fuLAX3Bnr41QZnH6fILp+yikM
         mwzRxmpQjeh8+vCXZPKaMJd6KmVkM8eIJv5xM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0hDmckIUhW4xP9T5NuiftLSR/C86BoP2/jqvqwaE02o=;
        b=1b+rMDnrU2hTh5xYKBfmeZlZ+QNwCPMR5CCrt0ZPmPUb0xsTSn5K6vk+AVAzm1gneJ
         gpn8r4zmQiFtdCiMtYz2zd+Ah0s7tn04oXvUUf7pSAPjbplhGMRM61ZTAK0CV1dfGYZ7
         vONh/ehNMrSzOkvojTeTJJZpL5P01STwZdpYXkyekD8PWx1Tf4vSxRQoYvHXYnS4lCdX
         2bpdaJu9DKMy+B0Myh6EGk4PGbZDCTSLJ//AFZRnVz3FOBovhm9d740mCyo/aYqkgl9N
         GzSPp2mZshkIAiIgd2AZnrCH1VjKo0vdBm8wuDxuShekFb9pG/WH+tvNU6uCEmXg5Z6C
         kcbQ==
X-Gm-Message-State: AOAM5331XMI0dBcKsc2XEbJMQfE7y3doASZJjaDrxviMquEPfDvbd2/e
        /nKxhO2lPRL8+nOpOI1jTNBnaKIBB9LSiEZodfw5jQ==
X-Google-Smtp-Source: ABdhPJyqcsQzQ2sNTrTC3KyamsklcPHgYm8JKQNFbYRhEoJIdXr8/z97k7va01bC8GJla73vfLab0CgBPRrMjeIJHUs=
X-Received: by 2002:a0c:f58a:: with SMTP id k10mr1865801qvm.62.1631178549225;
 Thu, 09 Sep 2021 02:09:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210627220544.8757-1-rdunlap@infradead.org> <2bae95d0-0932-847c-c105-a333e9956dff@infradead.org>
 <f63694aa-85b3-0238-5228-eb35a52bf360@physik.fu-berlin.de>
In-Reply-To: <f63694aa-85b3-0238-5228-eb35a52bf360@physik.fu-berlin.de>
From:   Daniel Palmer <daniel@0x0f.com>
Date:   Thu, 9 Sep 2021 18:08:58 +0900
Message-ID: <CAFr9PXn5S_3mpJBF0bNo+S1US=Z5s89rbO-OhhqGk=zqPGWXoQ@mail.gmail.com>
Subject: Re: [PATCH 0/3 v2] sh: fixes for various build and kconfig warnings
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>, j-core@j-core.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HI Adrian,

On Thu, 9 Sept 2021 at 17:25, John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> wrote:
> There are quite a number of patches on the mailing list that need reviewing and
> I fear if that doesn't happen in the foreseeable future, the SH port is being
> kicked out which would be a pity given that we're still maintaining the port in
> Debian and given that there is new hardware available with the J-Core board [2].

This really is a poor situation. The fact that there are patches means
that it's not totally dead but no one ever looking at them really puts
people off bothering in the future.
I might have a go at getting OF to work on the SH4 hardware I have but
knowing that the patches will probably never get looked at is very
demotivating.

Can we get a new maintainer from somewhere?

Cheers,

Daniel
