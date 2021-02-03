Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F78230E76C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 00:34:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233446AbhBCXeI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 18:34:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233234AbhBCXeF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 18:34:05 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89C7EC0613ED
        for <linux-kernel@vger.kernel.org>; Wed,  3 Feb 2021 15:33:25 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id i5so1774834edu.10
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 15:33:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=83sGorfu69qhIgwYTH9eGJ4bZproVEYl+EVcReOX+GE=;
        b=FTFs8FyNRotwcUi9o0JvkzLsTDXOqIjzkxMnYVFJM6coYzs29ef6sxU0o1XidbScOz
         0Sb/fXkJoLjPuPujzSHaxUEvK2FrApi9C5HT2JOeTcaxhpd2Y9EtyWYfFYtozkrdCQRO
         m+rb33mTHUwNBpIXpcc8ZCQC8E1MYGBbq1s/EwFWc3cGTa6reOavSoxcEtpM7ps6Eyqw
         ti855HcFxiqBQbIlRAEMJslqqUKiGZcLgyggpI2bG4mhbqkSVZUB85xxHRIIOJjKqtw1
         uLuVsYsAMOn9s3Xy2ssYsyCYnNFx7chOkiSHQiiLmQaPPeWMHoMsyHU00y3HwopuBiKC
         0p2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=83sGorfu69qhIgwYTH9eGJ4bZproVEYl+EVcReOX+GE=;
        b=pTNhD5OdUYFRVhOZosBXu3YPBiATyxiW2l85MKZ5tNAiplPAY002ONO1Q/+VLzABBr
         I7qEw2qPEC7eUOZ9x9/kxnqfrznaVSAg/1nY5tx0/hZnT0NTfCD1wGKL5Gskgkwg8/pW
         FGqJ59x2YYlgEBfsb/ZjZ98j2Tl63/R+Usl2LWgTzNVMBfJ+I1+Ew7PwG0PBOtj4cJj/
         +wZMEBWlgXYH9t7Que4iYTwxJndMsUBWmk4C0sOm55hwT/5KNHCimlTO9yuCvpY0auzz
         V1b67Xv6oYjaJb71RpnDnCh7ApeLDVzpeGPDCfjhVqP6qftx0i3fGFTOwSHJgZZFkcMb
         hDRw==
X-Gm-Message-State: AOAM530poCVETMB3cU/BuL/NKrS2M31ef0odHLp00FeyaprcFN/Seb6K
        bHAOMfPQJtykLvjFJWhRdUSYTbR1hwAQs7m/nXbBMA==
X-Google-Smtp-Source: ABdhPJy3kKi0diCxktiePXaN4krEpfMFX9UBPvX4g/pI1jopfEON7AoKoc7OhB2AMt/gAkKPveVcm2dOplxucXeAvck=
X-Received: by 2002:a50:ee10:: with SMTP id g16mr5552708eds.62.1612395204324;
 Wed, 03 Feb 2021 15:33:24 -0800 (PST)
MIME-Version: 1.0
References: <20210202200324.5179db33@canb.auug.org.au> <CAK8P3a3uJfyt6vsgTdSjnE23V4E_Mw=N89nrMPLJ6bhA363nqw@mail.gmail.com>
 <5504da4f-7eec-ecb0-c47d-7821d06dc880@infradead.org> <CAK8P3a2Y9-5dhk1MaZhhnKQkbOtqOSqfqZA0c4ncBXgD8tJTZg@mail.gmail.com>
 <CA+CK2bC9oMvtkT3MZzxNMtCn1b0hafYPbLH3GM_Z_66j_NQeJA@mail.gmail.com>
 <CA+CK2bBpuiLf7y7qVDoo3k6vajoaTkrDNx+pnNBTMYY616iDwA@mail.gmail.com> <20210204102832.4b5539a1@canb.auug.org.au>
In-Reply-To: <20210204102832.4b5539a1@canb.auug.org.au>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Wed, 3 Feb 2021 18:32:48 -0500
Message-ID: <CA+CK2bBmAZ972bJvvaaLUMJw9sQwkCAOnNXXSiSHEmiacjcqTw@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the akpm-current tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> >
> > Stephen, do you want to send a new patch based on the current
> > linux-next, or do you want me to send an updated version?
>
> I'll send another one and include it in linux-next today.

I appreciate it.

Pasha
