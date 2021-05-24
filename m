Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F0A938E5D2
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 13:49:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232694AbhEXLvQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 07:51:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232476AbhEXLvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 07:51:15 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05AECC061574;
        Mon, 24 May 2021 04:49:46 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id gb17so23294559ejc.8;
        Mon, 24 May 2021 04:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CmDg0OPTc/Mfj+nfatUnRkw+P07W4/4NyprXDsEBySk=;
        b=M+KshWcevyw3gQMskiFellZq+xtrLGDuoL87DH6TQrGPYgG6+WtwHqkFMteifIoZDy
         IUx04svtQOuCDeWD0yPirVmgprpN9L1d37Hr3tApiluwUuMG3UcHsi06JSxHrWLKAdZf
         0qPjLHkAH23x9Gw0GmIFXkd8LPoTtMwWQRAsV+i/XVej/nAhg6czR6PVGTQCAKDmT1RT
         sTxSwnZnPSjtlksPRLbLvzIxGxy5R8yNg8th+V7l6igzmZKPtQV3gaznhNCZiqKGqgfb
         CjkpWhoLGuNCEEON1hxJUGJlw9WMFkzafaGFL3bhsKaUP6nxn2Xud4hRSh1PVUsI8SK1
         gt3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CmDg0OPTc/Mfj+nfatUnRkw+P07W4/4NyprXDsEBySk=;
        b=SzqCMth/bafDRq6uoffVkwW9mem9yLyyz593qaEO9Mna8RhAeZJFMkQ2SyFkaeOoJ9
         ntrmMaHMNkyjD5hn3nmiKvWOB4JFaVHEfV048TSwNuElIh+ub8S+Fc6T2OJgNZNKYtqE
         5vkSMakDBFxxMm4f+Ynn+TXIoq4X9b+SU69TwA97WMZv3jjA3aCFRzGLVzub0BivnU9R
         8JRmy3Kx8SQLa0HmOXWrxHTlA8Hq8mJCNc+4K3B82wxhJxmb+pAR7guI/PJIkd4jk76B
         SiBcDWxjOnj2MxyMi7LgPX/+3kKwFeGDzjaA9A5m8e84uzugrr11YdYOxivuIOXTE5RC
         vMvg==
X-Gm-Message-State: AOAM530x3daZ9JuvmfSjtd6ctWUaDdR8oMi0RGnNEFkwvr+jO/grdiIw
        jlX75QZSJzqpzoEjk7a4BDvnXJpAzJTp6ClXz2A=
X-Google-Smtp-Source: ABdhPJzD07dr5GAsLpaU3/MVHZTTnESWRgVvV5yJipcm5OF6jyEnTMkNYlSFvgDvRdDvG1QT4gLJcBIjaoRniROlDqU=
X-Received: by 2002:a17:907:2d8d:: with SMTP id gt13mr6315823ejc.162.1621856984608;
 Mon, 24 May 2021 04:49:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210524104533.555953-1-martin.blumenstingl@googlemail.com> <1jsg2cbdqh.fsf@starbuckisacylon.baylibre.com>
In-Reply-To: <1jsg2cbdqh.fsf@starbuckisacylon.baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 24 May 2021 13:49:33 +0200
Message-ID: <CAFBinCBs=vj_rp1yk_5bvYsMQUE6Pmq8xyc6JEwBPf6CewWm0w@mail.gmail.com>
Subject: Re: [PATCH] clk: meson: meson8b: Don't use MPLL1 as parent of vclk_in_sel
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     linux-amlogic@lists.infradead.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        mturquette@baylibre.com, sboyd@kernel.org, khilman@baylibre.com,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jerome,

On Mon, May 24, 2021 at 12:57 PM Jerome Brunet <jbrunet@baylibre.com> wrote:
>
>
> On Mon 24 May 2021 at 12:45, Martin Blumenstingl <martin.blumenstingl@googlemail.com> wrote:
>
> > MPLL1 is needed for audio output. Drop it from the vclk_in_sel parent
> > list so we only use the (mutable) vid_pll_final_div tree or one of the
> > (fixed) FCLK_DIV{3,4,5} clocks.
>
> Are the fixed ones actually needed ?
>
> If the consumer actually lives on the vid_pll only, I'd prefer if you
> could add CLK_SET_RATE_NOREPARENT and assign the proper parent in DT with
> `assigned-clock-parents`
you're right, only the vid_pll_final_div tree is used
I just tested it with assigned-clock-parents and
CLK_SET_RATE_NO_REPARENT and it's working fine. I'll send a v2 later
today

Thanks for this suggestion!


Best regards,
Martin
