Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5E4030B547
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 03:31:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230214AbhBBCbR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 21:31:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbhBBCbO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 21:31:14 -0500
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62079C061573
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 18:30:34 -0800 (PST)
Received: by mail-qv1-xf29.google.com with SMTP id es14so9253042qvb.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 18:30:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QIpTOgzPdQ6YtC0rNK21Lw1lOKo/Ak0fXmEeIn6ftt0=;
        b=Imeh8hlGg2V38tVkhlaTGnS5NFabsC2q2pzv0il1Mwc1WnPzOyMh0/EbCCkdgSbAQX
         NemrZfPsXmukyK4M2YmP8R40paGEkRT2dctZMpVokXGFbGqgJj4+D31s7p7BgUbXGAMO
         3vjx9wNN1VoAleGONmrnuw7+Z/zR5YUvdNdNXHDJMvJhbpsSuTsMscSx67PrihFIL1e/
         ECxg89NsRYzgFmMxwc78wS6xAYtCUl8rhaxGJRgrzixds8p9fWDm23cTYcBnmZ4Sv0Xf
         Qi/eCCtkzyNzc5cVs2Nh6gdHmLtrYST7Rb/ZI1TblCA/NMbNFZwHrwc34bqTKN/xSLoW
         k2mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QIpTOgzPdQ6YtC0rNK21Lw1lOKo/Ak0fXmEeIn6ftt0=;
        b=ir0dYI3UKajhNCZo3mBH03U7uOJQmvPgiru73Z1PrCdZDhltMVMTKMgeMRoDom7v/O
         XRqbqMPbLfuiHgfj71pxPqeAeWTqbsb02BYZtkx5vOmRr8R7zz1crFlpPiaKkpB+CcbG
         GevcRvRKFods/LL2vllEXeerUCWW5AwPqhWj6aNgrgUzoK+oJoYBpGeqvN2CgIWjkK9P
         RbaL7bP2KhEDKrhGYa4HPTlSTTgoVxAgHTNhs2ERW6GcfrOd7Fqshrhfn+9PgfMBKg3K
         er+ifg5Obwbb0BJ/Zm+ir1rix//xyqaLkW0d6S2oONEU/aokN3y24Dn+L/ANuqrSrLBk
         b0HA==
X-Gm-Message-State: AOAM531o+y1K6WwZ9qu3cukl0D/g7hSmxdNnUBxJXaXazn4LE3iqZ+Ej
        OPoczf4K0jO0PZmlhhDoUOD3hb1G3rNhFL6AiQQ=
X-Google-Smtp-Source: ABdhPJxQYEVdgWApvJT9/ojTY/23tJijAEEqeJsLb013eOFzysMrFFbbydhH5M1amthAVT4PRbP7uWaVSdWA9kFcRLE=
X-Received: by 2002:a0c:be15:: with SMTP id k21mr18615044qvg.8.1612233033576;
 Mon, 01 Feb 2021 18:30:33 -0800 (PST)
MIME-Version: 1.0
References: <1612166909-129900-1-git-send-email-yang.lee@linux.alibaba.com>
In-Reply-To: <1612166909-129900-1-git-send-email-yang.lee@linux.alibaba.com>
From:   Shengjiu Wang <shengjiu.wang@gmail.com>
Date:   Tue, 2 Feb 2021 10:30:22 +0800
Message-ID: <CAA+D8ANQb4btyJo2DeVpr3W7vHz+gQTCQQJB-geV=wT5Sa0+yQ@mail.gmail.com>
Subject: Re: [PATCH] ASoC: fsl_xcvr: remove unneeded semicolon
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     Timur Tabi <timur@kernel.org>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, perex@perex.cz,
        Takashi Iwai <tiwai@suse.com>, p.zabel@pengutronix.de,
        alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 1, 2021 at 4:08 PM Yang Li <yang.lee@linux.alibaba.com> wrote:
>
> Eliminate the following coccicheck warning:
> ./sound/soc/fsl/fsl_xcvr.c:739:2-3: Unneeded semicolon
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>

Acked-by: Shengjiu Wang <shengjiu.wang@gmail.com>
