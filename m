Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D3E5437E67
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 21:13:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234225AbhJVTPe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 15:15:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234134AbhJVTP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 15:15:26 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D070BC061224
        for <linux-kernel@vger.kernel.org>; Fri, 22 Oct 2021 12:13:00 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id bq11so4668869lfb.10
        for <linux-kernel@vger.kernel.org>; Fri, 22 Oct 2021 12:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i7WRTjXxQ4DN8M2vOlJwK7DMWJ23bbvUg+XH4CNTslE=;
        b=Wv8R9T10aobCrs3M+YmRan10VWCF8IcL93mBD4Pf53lVLMeWToKnlOMUFrNogXM3ds
         1y1qbj4mIWnXiy6yih2yRFJuy484nXKvol2id1K4zFAG/wJ5LRY9rMur7DD0N4cACwu/
         773pwmn74KsGp6Id34qu0eLBaOasLOkeN+3kg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i7WRTjXxQ4DN8M2vOlJwK7DMWJ23bbvUg+XH4CNTslE=;
        b=43IR0BxmX4PRjEi79HC2y2wxJyKGWCEyX1F4PtuLpuQpj76O+5jGBPRwrK8O7phKjM
         a+iteQVIlpN7ofcx9tMEB8Fvv7sax/CU6v+oBcNRL9776IOzydxSWF8q1v2t+dJbRBEe
         G9+gEC1LWYXzLerdZkjYa1m923TEN7qxI8lx8fydvqpFBh2TrocaW7DrYpKrIFG1o3fZ
         z8leQ1amsTREslQMkjqF6mvZMCpSP9hvppmtKetTy9tcMZ280tM9UKaZe8z69WF6rQj9
         aqNgbiBNE4IWT7gaLXB0EZ9u0xDTSOavt+8J0kkoUxAkFT6Y0l1+wtctNfHIXg/FJQO9
         UV7g==
X-Gm-Message-State: AOAM532lbSbXkSMET8SUeFDKhtdpYVyw4y+fk4crfgT95sfJiEvrTasX
        b8gSOuufAMzY/SnJZgy+jHsPrE7DB6rQ9Q==
X-Google-Smtp-Source: ABdhPJysvl1qKAnaWZBddAxInHmJY0sFe2S8ggWijH5kFkr/YAzmsfmBDT9s3wwAVx4fWlJoiVdC3A==
X-Received: by 2002:a19:c3d7:: with SMTP id t206mr1362623lff.331.1634929978826;
        Fri, 22 Oct 2021 12:12:58 -0700 (PDT)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id w19sm982886ljd.84.2021.10.22.12.12.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Oct 2021 12:12:58 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id s19so1090435ljj.11
        for <linux-kernel@vger.kernel.org>; Fri, 22 Oct 2021 12:12:58 -0700 (PDT)
X-Received: by 2002:a2e:a4b6:: with SMTP id g22mr1839764ljm.191.1634929977783;
 Fri, 22 Oct 2021 12:12:57 -0700 (PDT)
MIME-Version: 1.0
References: <CAJZ5v0hTtyu981j91vxH_u3bvHWWBho4YSAhd+os9Zn=sbwe2Q@mail.gmail.com>
In-Reply-To: <CAJZ5v0hTtyu981j91vxH_u3bvHWWBho4YSAhd+os9Zn=sbwe2Q@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 22 Oct 2021 09:12:41 -1000
X-Gmail-Original-Message-ID: <CAHk-=whCammRsz8PEbrft3M6vGjF506gkxtyGw81uGOUUvD51g@mail.gmail.com>
Message-ID: <CAHk-=whCammRsz8PEbrft3M6vGjF506gkxtyGw81uGOUUvD51g@mail.gmail.com>
Subject: Re: [GIT PULL] ACPI fixes for v5.15-rc7
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 22, 2021 at 9:01 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
>  - Fix an ACPI tools build issue introduced recently when the minimal
>    stdarg.h was added (Miguel Bernal Marin).

Hmm. ACPI already has that odd ACPI_USE_BUILTIN_STDARG case in
acgcc.h, which ends up using _exactly_ the same macros as the
<linux/stdarg.h> implementation does, and is basically exactly the
same "minimal stdarg".

Ok, so the macro argument names are different, and there are
whitespace differences, but semantically identical.

So maybe the ACPI code could drop one or the other in favor of the
identical macros?

                 Linus
