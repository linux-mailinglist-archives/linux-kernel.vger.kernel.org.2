Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECF223D9D61
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 07:58:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234210AbhG2F6r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 01:58:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233899AbhG2F6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 01:58:46 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCB52C061765
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 22:58:43 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id y200so5580314iof.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 22:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QpDRWGFIK+Oln4PWA6QkkpVe40JSJ8McnR2s+RnmGkE=;
        b=mmEdZWH9QO6nTwu1Vap8c1ufo0haYzJ8+AoIt9koR+Oq6F9tciWkxYwiyOr/1kks/t
         +wKXMxFzePzvH3ebDbbHnYTXduaI5UNG9WqujvKrMq0oix+whigIbboTajwuo5SArw9r
         xA/96OufmolG8tE1YH1ypC4LDe3rKlEtDr8TE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QpDRWGFIK+Oln4PWA6QkkpVe40JSJ8McnR2s+RnmGkE=;
        b=k8wI48BjWIn3sUc5P4/s4s7ghWkr5PmnN7DIfqHdSEemdTfkuAPGmRgyPjaORJADCo
         uyimsOa2IdjCI0Ue8sn3Bs7XcocgMbdbbTPg0aPncYMQPSRcDMLCjEUYv0nRTjglO4cD
         MkE4CSSEQBHk1Zkh7lPihUQTNE+oEDzssznXL+FPZ0KmWVQNQ/x0Wawrnl9OVdwKHO8x
         WdOpkUrKhME6jJiXGnQvgvlaPpD/RB3kenQQBwYZn49ub4q1A8Ch1KgrCt3HXb04hmRP
         5Xb2DHBnA0n4SRKr6wuu4kl8U94wtwO0DLViDZNScEOP6Idg4TP2P4yr7BibXGYmGj4z
         NiEw==
X-Gm-Message-State: AOAM532TD5aqPKfVNi9hdblTXqmzLatcPJtA+10B14xljbAX1kksy4qa
        7Z/nH4Jq2S4AKQHKgnHSxip8h+R6MKK5nuf/MCWNKA==
X-Google-Smtp-Source: ABdhPJyuGOXvEqwUIs3qU6ruO+/WOCDkqKZfKJc8oEGOVFJCqgihZ7D+ruxIRmlxDQfsEfCMhexgtinohW6+4bJCHhU=
X-Received: by 2002:a6b:c9d3:: with SMTP id z202mr2669436iof.44.1627538323171;
 Wed, 28 Jul 2021 22:58:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210727174025.10552-1-linux@fw-web.de> <CAJMQK-g8g5QJbBkU-A6th1VSWafxVv2fGtym+enQa_hDVaVoBw@mail.gmail.com>
 <97C4FA94-B28A-4F0E-9CD3-4E33B01BA353@fw-web.de> <CAJMQK-gQeMidjBZ1E=ReMmffC5G8oiFawB4Ey1PNb2ZWXw_1Bg@mail.gmail.com>
 <6BFE13A3-6A42-455E-BDF7-CD285CC6C66D@fw-web.de>
In-Reply-To: <6BFE13A3-6A42-455E-BDF7-CD285CC6C66D@fw-web.de>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Thu, 29 Jul 2021 13:58:17 +0800
Message-ID: <CAJMQK-iHfJWnGQRq299pZ9B9ABMsXPEkptyCrGtQqkEyc=HNFg@mail.gmail.com>
Subject: Re: [PATCH] soc: mmsys: mediatek: add mask to mmsys routes
To:     Frank Wunderlich <linux@fw-web.de>
Cc:     "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>, CK Hu <ck.hu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>, stable@vger.kernel.org,
        Frank Wunderlich <frank-w@public-files.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 29, 2021 at 1:54 PM Frank Wunderlich <linux@fw-web.de> wrote:
>
> Am 29. Juli 2021 07:47:03 MESZ schrieb Hsin-Yi Wang <hsinyi@chromium.org>:
> >On Thu, Jul 29, 2021 at 1:40 PM Frank Wunderlich <linux@fw-web.de>
> >wrote:
> >>
> >
> >>
> > struct mtk_mmsys_routes {
> >         u32 from_comp;
> >         u32 to_comp;
> >         u32 addr;
> > +       u32 mask;
> >         u32 val;
> >  };
> >mask is not the last element, and mmsys_mt8183_routing_table = {
> >  {
> >    DDP_COMPONENT_OVL0, DDP_COMPONENT_OVL_2L0,
> >    MT8183_DISP_OVL0_MOUT_EN, MT8183_OVL0_MOUT_EN_OVL0_2L
> >  }
> >...
> >so the mask and val will be wrong. CK, do you know what mask we should
> >set for mt8183? Or can we just set a dummy 0 mask.
>
> Ahhh...mt8183 has own mmsys-table and
> i had only changed the default one,so
> value is now missing because value is now the mask. I have used same order as
> CK to avoid confusion and make it easier
> to review.
> Afaik you could use same value as value to reset same bits...did this in default routing table too.
>
Should I create another patch based on this or can you help update the
mt8183 table in this patch?

Thanks

> regards Frank
