Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50D8344AC66
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 12:17:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243309AbhKILU0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 06:20:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241667AbhKILUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 06:20:25 -0500
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C608C061764
        for <linux-kernel@vger.kernel.org>; Tue,  9 Nov 2021 03:17:40 -0800 (PST)
Received: by mail-oi1-x22f.google.com with SMTP id bl27so30192299oib.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Nov 2021 03:17:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Cv8ztnlWaPfhP0sypyGkwV20+n53fXJntUU+ZhOap88=;
        b=ur5uAj8bUiNKsDbqu3RvypRYmIvBImcWoP4RkNK3jr6iKCOLACdRYXBzALLZdo/XZZ
         eAp/j0q3aVI5ApL38Hlzy3wTAAWhfmVC5+wiqxtOcVZjFc3uhaaN4G6mvrCVa2Idgjxo
         SkF59Wpz+gBWlis/SZ/bPH0rkg1xcSZ1LYMAs1e9D7PrTYFuKw8NC6YvOxqFwQEbb3x0
         qS5j4kJ6rlZYfM2mvq+xOwwdfRa5ze2oxr8MRea8w68t66bKJGTOxroFIXbKAq1NGsXQ
         LTs+1tTK5IcO5nvWpeJ8bfjZOxBXs/4to+5z+HavHQlkDFO0FRhN/9JpbDQxFzyEOSGn
         1UbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Cv8ztnlWaPfhP0sypyGkwV20+n53fXJntUU+ZhOap88=;
        b=ENgKJwj+pWRmlMfgd6y9mMTclhk/nYaPtBUnweNkIBlAtreggjOCqSdZ5BxKtIWuDm
         BUOTp7ogqjIDTzFs6caemsCddcfl1MKxOn/BN/IgNZ60tK+6sHuB5tskyTeGUfx/DXXn
         UCZFtP34MXZ273gHSPnxThlkjViD0lXZOgv/GlN/ZSC96YFnGwve+fW9fFvox09ablSL
         5q/GqsMIn8JhOPKXSLl4jS66VPmKcJa4Xygq5DabY+rZXeMaUugvrp6yfmfX5xnltbx0
         gQp8qI0D2nV5mgdCbT9qoCqXNltfOO8att3zs0zJte6PblXcsvokRsl6W1lee9bAnIrT
         VsuQ==
X-Gm-Message-State: AOAM533SxO+igscIg2lt0Wt+LOp28dJWRnch+TYVIVHVX5Z6vSgF1DF3
        rpHxavcCSUX7X1hG5LgrPTS5JzqqL+ZXLr+E+KJCdA==
X-Google-Smtp-Source: ABdhPJzWtxSQXKhCHTrTtoBNQNsjLEb06mFsF/668M++pGpzFhuO5Urfobdic+1HCCyMHPzJ82GQZJ8pE6ibQw2AMSY=
X-Received: by 2002:a05:6808:60e:: with SMTP id y14mr5051120oih.162.1636456659466;
 Tue, 09 Nov 2021 03:17:39 -0800 (PST)
MIME-Version: 1.0
References: <cover.1635944413.git.hns@goldelico.com> <47e753ce9d1e17bbb2910ee24a23a85d27f860ce.1635944413.git.hns@goldelico.com>
In-Reply-To: <47e753ce9d1e17bbb2910ee24a23a85d27f860ce.1635944413.git.hns@goldelico.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 9 Nov 2021 12:17:27 +0100
Message-ID: <CACRpkdahO0Tes676-uGLxoh=P9ps1Kw0kVT2nT0eBVr1CWUbpg@mail.gmail.com>
Subject: Re: [RFC v3 3/6] mmc: core: provide macro and table to match the
 device tree to apply quirks
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        =?UTF-8?B?SsOpcsO0bWUgUG91aWxsZXI=?= <jerome.pouiller@silabs.com>,
        Avri Altman <Avri.Altman@wdc.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Tony Lindgren <tony@atomide.com>,
        Bean Huo <beanhuo@micron.com>, notasas@gmail.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        letux-kernel@openphoenux.org, kernel@pyra-handheld.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 3, 2021 at 2:01 PM H. Nikolaus Schaller <hns@goldelico.com> wrote:

> This (initially empty) table allows to match quirks early based
> on .compatible of the child node of some mmc/sdio interface.
>
> A new macro SDIO_FIXUP_COMPATIBLE makes the definition readable.
>
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
