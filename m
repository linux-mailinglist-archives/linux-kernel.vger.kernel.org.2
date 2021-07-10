Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D38733C35A0
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jul 2021 19:16:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbhGJQu7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jul 2021 12:50:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbhGJQu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jul 2021 12:50:59 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02B55C0613DD
        for <linux-kernel@vger.kernel.org>; Sat, 10 Jul 2021 09:48:13 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id f13so30451033lfh.6
        for <linux-kernel@vger.kernel.org>; Sat, 10 Jul 2021 09:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UMwYm3Z5kzi/jKsZNKzSHFnOUpat3NrlV7AI13eBog0=;
        b=h1J+0nIt4sfDSPrqc3+zf1KmH1ZX/FyrDYTxSHYZF5cNvUWD5k8W0IacYSS/7Yp2Tw
         S7byUrDkJ2y8Pi727vaVaRBdIS7p16mRkrIZeUy2OcEJTZ++6E5T29c6GoFamaUUS4pQ
         ADhYcYMcoNqrSzQOTx3Mfd79GREJ8Quw1wzs8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UMwYm3Z5kzi/jKsZNKzSHFnOUpat3NrlV7AI13eBog0=;
        b=Q25t6g1HqnsLTYrlbIpMAaDQ7uRQeBPP8inG5+WRrmSBcyA1iXnxxwod94gjzJsS+c
         JDPfqE5CVr66S/4hKMQiUGHblLRL9EIk7jvNYV/ETni/HCqBcHK96eles5vnkWPAJF67
         Rsp21JkKJal/CpOglETRJe6PAIsQSDhNHczz95WEBtlFyhLLEEjPp8s+MdtCqyQwEMH7
         mI4IJnQQeBS8jWG5f/TBPKNV/XTwCicZLyILSyytoF3rgyefW8tiyriBpmaB2bY5jsQ5
         E0ZM0F0YT7VWXUI6trS327usk5a7YA2axj9lEQcGZjosJhQ7HWBsCmk55ET4DeCtAtCY
         U+KA==
X-Gm-Message-State: AOAM533kKt5UZqdnSOILDaHUdGml7GoyMTSC4eqnsiuMkacR5xEkru8b
        F5MrskTSP7uqpBv6WPue2iOXryAjO+NZV2CU
X-Google-Smtp-Source: ABdhPJxaMrGa9bogW5wc4swFx5alTfKE3kvK44l6gEplmg29gkMeauEWwH1cqkYCZPFicYcTFOKh2w==
X-Received: by 2002:a19:7d04:: with SMTP id y4mr32924034lfc.201.1625935691270;
        Sat, 10 Jul 2021 09:48:11 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id o10sm8499lfi.41.2021.07.10.09.48.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Jul 2021 09:48:10 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id v14so30665075lfb.4
        for <linux-kernel@vger.kernel.org>; Sat, 10 Jul 2021 09:48:10 -0700 (PDT)
X-Received: by 2002:a19:7d04:: with SMTP id y4mr32924003lfc.201.1625935690648;
 Sat, 10 Jul 2021 09:48:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210709234054.10288-1-olof@lixom.net> <20210709234054.10288-3-olof@lixom.net>
In-Reply-To: <20210709234054.10288-3-olof@lixom.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 10 Jul 2021 09:47:54 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg3Pb1LxbXkTX6itxRvgaV9JwBaSyGmE8zXUurJ98M2Bg@mail.gmail.com>
Message-ID: <CAHk-=wg3Pb1LxbXkTX6itxRvgaV9JwBaSyGmE8zXUurJ98M2Bg@mail.gmail.com>
Subject: Re: [GIT PULL 3/4] ARM: Drivers for 5.14
To:     Olof Johansson <olof@lixom.net>
Cc:     ARM SoC <arm@kernel.org>, SoC Team <soc@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 9, 2021 at 4:41 PM Olof Johansson <olof@lixom.net> wrote:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/arm-drivers-5.14

Ahh. You had switched the diffstats between pulls 2 and 3.

            Linus
