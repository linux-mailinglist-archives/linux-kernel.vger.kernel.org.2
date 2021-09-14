Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 284A540A1D2
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 02:20:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236882AbhINAVF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 20:21:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236554AbhINAVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 20:21:04 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 724C5C061760
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 17:19:47 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id a4so24752615lfg.8
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 17:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OJCOVeO589IX0eZ2k9PI4XmEqC+ha+gDBXVAR0aVS3A=;
        b=SclZiWrkT5KucTv1KidhHP6yMCpKWMNqoOiS1UgRHORAfJuSSMf+xaeagNjetAELs6
         Bh2TOhuIaWLPnM+/W2Yzq/TD4x6e1lZqhBUlLoChPi52C7bRjop+4ZM3lAIpZzJOEVn9
         lcHuoBjFShp/uD8fDDM5+JSs5YrWYKB9IWsGY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OJCOVeO589IX0eZ2k9PI4XmEqC+ha+gDBXVAR0aVS3A=;
        b=VB4o3FNkDm3uYrd23xx6ZGZD9wTFMjJ9qPhGR+B/sZ8BgniPn8c1Y2Ml4QLMl0SlpG
         qx7sOX9vRnKjqHBsqwNHJcTvGGoUDAoBTfbatqxV1R0IdBQGMNJXpOZTCi/yro4Kzh0/
         vR9j36cbOvMAuLZxkoL9d0mB5CqFJZcpiC2ELv3kuCMiLKA0tj3kAyZQZsCnPUzNmWKK
         bYYBpCTP9POofeWF8ufReSErgcajUD0zOVAX3chmcGldbnZ3gdtnOm8VXO4TOcYnojQe
         cGYrSXTWrLL0TUXEYTH2goHERlROwi1hw96+VKtypDMBqR8KpQVbYMQsgZKQ8dxkR3e6
         gkhw==
X-Gm-Message-State: AOAM531UxKEpyHjLIFIVITJO7NxdJhxQRdXa1Q+FNibY4A9CEw7NfeIA
        M33mYcf5TH8jRuOLjW2nuOUl5SdFYXxxanhcxbk=
X-Google-Smtp-Source: ABdhPJwWtcMtcZN4eG+qlaPb0cfeTj1pXxvsoMz09jAVWl1Ue8kSzDK367gU/cEgoTzC7rNnxFq8FQ==
X-Received: by 2002:a05:6512:b1b:: with SMTP id w27mr11115137lfu.105.1631578785558;
        Mon, 13 Sep 2021 17:19:45 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id z13sm1150151ljo.37.2021.09.13.17.19.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Sep 2021 17:19:45 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id s3so20366720ljp.11
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 17:19:44 -0700 (PDT)
X-Received: by 2002:a2e:b53a:: with SMTP id z26mr12192430ljm.95.1631578784223;
 Mon, 13 Sep 2021 17:19:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210914100853.3f502bc9@canb.auug.org.au>
In-Reply-To: <20210914100853.3f502bc9@canb.auug.org.au>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 13 Sep 2021 17:19:27 -0700
X-Gmail-Original-Message-ID: <CAHk-=whOv-LZKxBqQr8yzmhi7sN4zoFG7t8ALNx+2XFhXjGTpA@mail.gmail.com>
Message-ID: <CAHk-=whOv-LZKxBqQr8yzmhi7sN4zoFG7t8ALNx+2XFhXjGTpA@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the origin tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        PowerPC <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 13, 2021 at 5:09 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
>   gcc -Wp,-MD,arch/powerpc/boot/.crt0.o.d

Ok, so it's not the funky "clang reports gcc-4" that caused tool breakage.

What version of gcc is this? Are you maybe on gcc-4.9 and we just
didn't check that properly?

              Linus
