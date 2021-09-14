Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A44B40A25B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 03:11:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237522AbhINBM3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 21:12:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237193AbhINBMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 21:12:22 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BE67C061760
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 18:11:06 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id u18so11176323pgf.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 18:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ivan-computer.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=z2lOZGZdanpaYVRAt/kvSmIvYXxBB8qSaA1o9kisjMg=;
        b=Xt0ZPlRVNLKoo7f/9go3VQniX80+aRjOr3TNjoHcqY5VbakNlBn65Ufxe1U1HX9BXo
         KLCBdzaE3tcqQezis8ZrR7yyG+i8he02WyzB3fzpticQI52MIDnkOK3FeWBEkFkelDiZ
         8z0FJPwvunszsa6/Nm5Us8uZEcPyw9PFUHqnYe2Gy4O1vbBFGCVcZsOhiIyjbQFiw21J
         FtlM70CKKLusdtTaqU5Xg6ZMxicEdN8zn1fDpCOvTv8EMXXc58hCRQmg1jnzvz9ymq8v
         U4SNUEFjLQhbkjrsfS6PjkAbTrjs2HxVfNHMhFKktiR1j24tTNPkm0hQz7+5LFyZ4Cga
         tqcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=z2lOZGZdanpaYVRAt/kvSmIvYXxBB8qSaA1o9kisjMg=;
        b=JVIdAV8YVvsq5YxH9Kl6T6iA77R+CQpfANjDRl0tz/6Oy7NQIET4DzIub3wm38rLqg
         9NrfgrONB3fEeFqmd75cjWgAamnIcUvcJ9OpT2wRGjyAhdWUwQktYTuDt1lCsUuQm6Tp
         SIHRas6Pn2ZdysiTN33qdsRL54CNLYvhJj6PKZY6o39gXVhQ04zQBtB09JWiR/upBZr0
         ZeMj3REZ8lVF54rhnXIiBaOmyd/mq7wDRKi4DTZs4WJHEb+wiDaNwDA/6wzMv9ZCig1N
         NmNum73B5sfxn72bPmVabD9TgMFf7Fj76gbBJ88U83dHN6U/dC3hGFY2r84DZg1aIsSL
         9amA==
X-Gm-Message-State: AOAM531xJUrMX8DR+y5NpXHtwdhJkcmyb/WbqwveGESo2/SAq5Dq/Uu+
        4tUt9a9Sdz5xSTX5kIEH8X1SlA3GakXxGjbKHjyhEQ==
X-Google-Smtp-Source: ABdhPJxZLMOzU++Yr534PIvgmvPLqoY0wiy/m/5MqekCrmsD3aOr7SJTtlFVAA6QQu5SqxWHHHr0DfSDwMlxti/zU0Y=
X-Received: by 2002:a62:2905:0:b0:3f3:d4ce:443d with SMTP id
 p5-20020a622905000000b003f3d4ce443dmr2213624pfp.44.1631581865674; Mon, 13 Sep
 2021 18:11:05 -0700 (PDT)
MIME-Version: 1.0
From:   Ivan Babrou <ivan@ivan.computer>
Date:   Mon, 13 Sep 2021 18:10:55 -0700
Message-ID: <CAGjnhw920kNaJ9Vkg54WR8vh2TaomuTtA3WwR3eieD4v6iEJDw@mail.gmail.com>
Subject: Re: [PATCH] net: stmmac: dwmac-rk: fix unbalanced pm_runtime_enable warnings
To:     sashal@kernel.org
Cc:     alexandre.torgue@foss.st.com, davem@davemloft.net,
        joabreu@synopsys.com, kuba@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        mcoquelin.stm32@gmail.com, michael.riesch@wolfvision.net,
        netdev@vger.kernel.org, peppe.cavallaro@st.com, wens@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Is it possible to revert the patch from the 5.14 and 5.15 as well?
I've tried upgrading my rockpro64 board from 5.13 to 5.15-rc1 and
ended up bisecting the issue to this commit like the others. It would
be nice to spare others from this exercise.
