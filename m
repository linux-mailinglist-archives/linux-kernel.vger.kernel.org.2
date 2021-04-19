Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EB15364D87
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 00:12:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbhDSWNQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 18:13:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbhDSWNP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 18:13:15 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00826C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 15:12:44 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id z8so41166847ljm.12
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 15:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+H3mqp2R90G8NCw9fCRyS3oUOaUPPm2FiUG9y073Tek=;
        b=CvduBEQUHFFh4Jq/ayDbLyMywS01YXp5FiMxStQ35SFbmG4ML4iS2QyKJWWBBzlOUg
         f1XbpwtpjLvOtS3v5710aVWlGcZKjR2JsPDMUdojSq7OYYl101N3FbPXm3uM5qcs7lgu
         te+yhQMxUKyArjW5eUhlZoc0312JyUXJVws3Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+H3mqp2R90G8NCw9fCRyS3oUOaUPPm2FiUG9y073Tek=;
        b=aJYRQWOZznJDsSalTFUSD2m5f/KPA56W2VM2UzyecL4sdiNeP6+Lx/Q6DifLpYwe5O
         LAc+vkmP4JJRD3FUYtbTROve4jzPIiyr6KkgouLgNqayWVfGFQ0S5SdlsNxQRTNEFfIu
         2gFhOCXhUiMOQI763zch5FmKiYd1Xqxdeq38pVfdaRCeWh7vJ+UH89x6TyIjFfI7zf0v
         iDXF7J0n6VSLyewMHTUc19QmKzf91pB36tQZ2G5CpjyH0YPLqglL1N23ScO8s73jD42V
         QUDO0P7yjaKgNrgQu8GbC13ngqcr66+/a+IRRePIPSU5XUX0LOQMqhl+c1zbHFTUn7xP
         bK9w==
X-Gm-Message-State: AOAM533tPmuwOWkOMDpOv/Y+5r6sf+mjWGStjGSsy4wUxQrTn+cihWwG
        +fCzR7141EUvGEDPimkUjdtQoypCmb1bjc+E
X-Google-Smtp-Source: ABdhPJwJraPA5azvfKBHQAuHbx7ykUg8igGO+EZTW9yB5CikTy1IROy8Ip42X7dzJv6lGmShncO3Nw==
X-Received: by 2002:a2e:a60c:: with SMTP id v12mr13223663ljp.310.1618870363261;
        Mon, 19 Apr 2021 15:12:43 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id k17sm387299lfg.253.2021.04.19.15.12.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Apr 2021 15:12:42 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id n138so58523558lfa.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 15:12:42 -0700 (PDT)
X-Received: by 2002:a05:6512:3763:: with SMTP id z3mr13215500lft.487.1618870362276;
 Mon, 19 Apr 2021 15:12:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210416154523.3f9794326e8e1db549873cf8@linux-foundation.org>
 <20210416224623.nZhisHrwM%akpm@linux-foundation.org> <YH33+R8pwviVysY5@archlinux-ax161>
In-Reply-To: <YH33+R8pwviVysY5@archlinux-ax161>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 19 Apr 2021 15:12:26 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgkck4D7ANx-uJCTugfR5GgH6MgvrmmGcqQRy6ZMECdTw@mail.gmail.com>
Message-ID: <CAHk-=wgkck4D7ANx-uJCTugfR5GgH6MgvrmmGcqQRy6ZMECdTw@mail.gmail.com>
Subject: Re: [patch 11/12] gcov: clang: fix clang-11+ build
To:     Nathan Chancellor <nathan@kernel.org>,
        stable <stable@vger.kernel.org>, Sasha Levin <sashal@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        johannes.berg@intel.com, Linux-MM <linux-mm@kvack.org>,
        mm-commits@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 19, 2021 at 2:37 PM Nathan Chancellor <nathan@kernel.org> wrote:
>
> This should not have been merged into mainline by itself. It was a fix
> for "gcov: use kvmalloc()", which is still in -mm/-next. Merging it
> alone has now broken the build:
>
> https://github.com/ClangBuiltLinux/continuous-integration2/runs/2384465683?check_suite_focus=true
>
> Could it please be reverted in mainline [..]

Now reverted in my tree.

Sasha and stable cc'd too, since it was apparently auto-selected there..

           Linus
