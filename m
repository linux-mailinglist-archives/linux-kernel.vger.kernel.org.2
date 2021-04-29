Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BFAD36E855
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 12:03:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237788AbhD2KEd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 06:04:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232629AbhD2KEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 06:04:30 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8FA2C06138B;
        Thu, 29 Apr 2021 03:03:44 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id f12so48708991qtf.2;
        Thu, 29 Apr 2021 03:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AcjSzANMS6HIMfKrieYzsYzq45hgOJ71xRiU5GDItPk=;
        b=MqbV6CHcekXw68bg3H2A98ezVud2yeeRHpOp+fV3kOshYX4oxr7iFbs7ifLhsNQOmy
         kejhUFhad5UkKGph+Xu2LmLIpspIVDttDfulaYravbeaJEmNvqFDAwLF+PXaV0Tnw8f8
         Em3gtT/QaUnI9cVQ9+l58i8JMiPj5oCYCTrRzWC0iGb/nN39jWqrr/cdD4bFc9dugPbo
         GTtuSgzlhev6e4/Wv904U1mn/BDd4XTXPTKQiolEGrXGLMSBoBmSvWnR6GJOdtcFImC8
         SfoUj5Me69M5MKGi4vbcqGa5/lHo+/NVLKXiljNQym17OX7l5Hf9VPFdO7KrSOkFHJVe
         nzIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AcjSzANMS6HIMfKrieYzsYzq45hgOJ71xRiU5GDItPk=;
        b=UUBBwM85FNYoMRRN1b9Wv05Kwn2WQqqpN2w+ser+zJMJRgY3tIMwFIxYJKZ/5apraq
         y6QxqjUv/dH4Pto1ya35KlOD5MzJ+OZMnlYsHi085wgmSxq3orXHKwHDPb5w7W/E0oDO
         fqYy/hqAHMD2hFmang6gYR5uUYGpggShuWOMIs6Fz/2C/lVlrh7HqU7FFAxfEcYVa1tn
         NYlGyE1RAz7CTRVTFVtZBdcPV5u36Bk9TkV3qp3Eh6vjLSDSbWMri1ukGj3qErqUPBFw
         hTZeb1Ukhc1W5Toti9YnjbyJ8DVMzsLA8N9Nby/2I8oyfho719be7ABKWII7T0JQ10Yi
         aKmA==
X-Gm-Message-State: AOAM530ocs7WXvlfHt9Cfm/VvSyh0Xz1hgV+6JaFs2Vu6KwBm+s4JBSF
        WrxHgGxChW7MV6W4kKmy2Os4uDremPSB6sV3rbs=
X-Google-Smtp-Source: ABdhPJwGNTXNUIRbmonLReVBGTiBtFnLjx7ynUomR28zpT3yBPaqiYt1wEXEdfJ4KQF/bgUBDibGjuMSOhDq8SaJKYQ=
X-Received: by 2002:ac8:6b05:: with SMTP id w5mr18034535qts.204.1619690624006;
 Thu, 29 Apr 2021 03:03:44 -0700 (PDT)
MIME-Version: 1.0
References: <1619664739-12589-1-git-send-email-shengjiu.wang@nxp.com> <20210429070940.6hech7hezrpiyzzp@pengutronix.de>
In-Reply-To: <20210429070940.6hech7hezrpiyzzp@pengutronix.de>
From:   Shengjiu Wang <shengjiu.wang@gmail.com>
Date:   Thu, 29 Apr 2021 18:03:32 +0800
Message-ID: <CAA+D8ANeEbVMJ6QGfyrtqgP9ohHXD6FBFdwXT7rZ7pO+SVTFcw@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: imx6ul: Switch to fsl-asoc-card sound card
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     Shengjiu Wang <shengjiu.wang@nxp.com>,
        Rob Herring <robh+dt@kernel.org>, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de,
        Fabio Estevam <festevam@gmail.com>, linux-imx@nxp.com,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 29, 2021 at 3:09 PM Marco Felsch <m.felsch@pengutronix.de> wrote:
>
> Hi,
>
> thanks for the patch.
>
> On 21-04-29 10:52, Shengjiu Wang wrote:
> > There is issue with simple sound card, the simple sound
> > card can't configure the pll of codec.
>
> Hm, than we should fix this rather than moving to the 'old'
> 'fsl,imx-audio-wm8960'. But that only my opinion.
>

Thanks for your comments.

But fsl-asoc-card is better than simple sound card, it not only
avoids the pll error but also supports the ASRC module.
And this patch is to use the same machine driver as the imx6qdl
platform.

Best regards
Wang shengjiu
