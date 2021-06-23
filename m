Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E19293B131A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 07:03:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbhFWFFX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 01:05:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbhFWFFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 01:05:22 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB97FC061574
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 22:03:03 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id bu12so2021980ejb.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 22:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=tAtp5Od/K+Ng7EzGisI/Fh2LgtQ1VXowqdQ9CgwHf+w=;
        b=VR5pJmCilDDWXmU2nYPb7/0eO2midGphauMyLokGgYk8xMFC3Up+Wv7ZEQhyWojEnc
         UOS+iK5tS22IysfewnWbmUz0wuEPH1CrAsl2AxrTyemsmls0SETIPGk4GJjb8LDTPhPN
         8QEeBbChtWNyHwkh3x7nQgQmX8SKjy1VRJJ9pa/I1Y+HpawphjDTLQet8s8v7bo/kxey
         ggUwe3xVySyYw5Vyli69GR2oIhELGfcE3JMAFbE2GTeBpM4nMxG5qfnHGKdYnaPZSSb5
         4wNoyxqB+bLPnFDr8Sbkoi0QCXXVFz/I1BFKMH3f1COF/+fpWck0Vo4kFKtW0uCxTjUz
         o5Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tAtp5Od/K+Ng7EzGisI/Fh2LgtQ1VXowqdQ9CgwHf+w=;
        b=Zi+1WCkvE2TaumLKmbf0vWNfpddabWxWBHb81KcgCGrq3WD7QhBVtzrunrh3GTuoQs
         mYtr3MxwdnGLIqiSI2QUIF1RIay2rPZe/hXAatQBDPeGHz2jRlGiMDhAxkcSoPoVumH/
         X9kOVoX+LVQHTwgg36b0q/0RM0BFSTz+6FC6hGUQeXM3kIAssSZL5FGif/dGsYaDrRHc
         58BUfs9M2840RNSOwNwaaPUme9FjGWVjaCD7OiVpbnZi83mQQQ9mEY+KbgKlCGs602LP
         gS9osIKNucT71s7fciGmR2kkgq7lCZ0F0rSJ0AN2nG6QZzK6KclAwHA/5iMoubBYdrfq
         hAHw==
X-Gm-Message-State: AOAM5325O0/8rae3NzY81ZT2KcAdvCkDnGfV9F4IXLaRard0SyzkTSC1
        lR+lFH9vDoC+5JBTqqxp5J/hD1cFBgyH+Ub3N+ARIQ==
X-Google-Smtp-Source: ABdhPJwXYAIL2/bjebELtCuyz1BTjVN7LNe1daHhaEHNKj6ZEN6Fir7f3Gbd8MJRZddT32XmP0ucl7LwSrRNlzcRTug=
X-Received: by 2002:a17:906:cc9b:: with SMTP id oq27mr7813116ejb.301.1624424582354;
 Tue, 22 Jun 2021 22:03:02 -0700 (PDT)
MIME-Version: 1.0
References: <1624424169-510-1-git-send-email-hsin-hsiung.wang@mediatek.com>
In-Reply-To: <1624424169-510-1-git-send-email-hsin-hsiung.wang@mediatek.com>
From:   Axel Lin <axel.lin@ingics.com>
Date:   Wed, 23 Jun 2021 13:02:26 +0800
Message-ID: <CAFRkauCxghVbH1ek7U65oU+zqwAR3LY9M=Dp0H7qYqKyDPjk0g@mail.gmail.com>
Subject: Re: [PATCH] regulator: mt6358: Fix vdram2 .vsel_mask
To:     Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com> =E6=96=BC 2021=E5=B9=B46=
=E6=9C=8823=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=8812:56=E5=AF=AB=E9=
=81=93=EF=BC=9A
>
> The valid vsel value are 0 and 12, so the .vsel_mask should be 0xf.
>
> Signed-off-by: Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
Reviewed-by: Axel Lin <axel.lin@ingics.com>
