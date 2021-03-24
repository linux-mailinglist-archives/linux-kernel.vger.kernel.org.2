Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE64B34744D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 10:15:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231747AbhCXJOl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 05:14:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234534AbhCXJOh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 05:14:37 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2D9AC0613DF
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 02:14:36 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id x16so23626899wrn.4
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 02:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=4rN1YksKNQ6jMnv83wrys0vsQCA6pM1XeLstkQR9zSk=;
        b=aaEalBsXBstsM7Ugh18M+hl8k/wTbYlQwQ6ihztFCEL9SFffFl/IlB3eU6LSKJs1k4
         GjK340N7lCr3K0iNQ2HLCSKfu9qwSSS5Mp8zQ/OAzufhpBV6bxJQJuLmIMW602QW0Z0i
         CTqj7hTA4262C48pcQPTWxgvKGSQ1LQgks/73S/V10RAeBK5hHJhx7ZbxahrIHGsK5bU
         crb2aPqZrt9ArMgFvNEf6/iL2Ia25u/EldQEsOKbOrKgyMUfulRjc6gCETsPm62Fki99
         ayEXOIgKaYa4YohjIIoMQ+HavVGjkXvTiQCd0/ZohrHC0rsOqSu+B+oZ12+Csh5u+2CE
         xVgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=4rN1YksKNQ6jMnv83wrys0vsQCA6pM1XeLstkQR9zSk=;
        b=PAvWh7jcsDngxnIwMbvPFiThBES9t6C70ZyKvYiGZglUtuji0tCci+XgIDn5ESf0Q2
         P786CAuj2t3tugkm3S5pUsBMcEd4efeW2BtdxC1MAf0QlG6x7aV18kmwwTjveB6ewy/O
         A1KJ8La5Xk88kxzz2fGJXQrwRX4cn9fuvSlUzZHTUNtKOmZr64vj3Vbui0xBapqtxHI/
         2ZTBjiKyKnI/ZPEtHDbP2jNLdfOePAL7mUwGpBaRduCWIUc85u8oMu3/uNsAeCVjdzd9
         clJW8haOVBmwnR98/pj5awuCxMGMGGJpx0WJuMsWmXzQX81VZMR7X7cfLf2qSNgkloGr
         sKLQ==
X-Gm-Message-State: AOAM532/w5F7Yeqm84OIpQ7myCGDuRyrMg7BKayFXUjNhvCImr3KYIjw
        9u/ztnmdEVynoZMhFRdx+hDypA==
X-Google-Smtp-Source: ABdhPJwiwVGAQSOrEM4tqzstTbRBmqfvaxH3KFKNSYNSQI1y++GJvlZicb7puOlrOD6JdzLf3utu9Q==
X-Received: by 2002:adf:e8c9:: with SMTP id k9mr2327816wrn.315.1616577275230;
        Wed, 24 Mar 2021 02:14:35 -0700 (PDT)
Received: from dell ([91.110.221.180])
        by smtp.gmail.com with ESMTPSA id n1sm2536565wro.36.2021.03.24.02.14.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 02:14:34 -0700 (PDT)
Date:   Wed, 24 Mar 2021 09:14:32 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, Jingoo Han <jingoohan1@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kiran Gunda <kgunda@codeaurora.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        linux-leds <linux-leds@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>
Subject: Re: [PATCH 2/2] video: backlight: qcom-wled: Add PMI8994 compatible
Message-ID: <20210324091432.GC2916463@dell>
References: <20210228124106.135812-1-konrad.dybcio@somainline.org>
 <20210228124106.135812-2-konrad.dybcio@somainline.org>
 <20210322161810.biagj2qro66rv4gt@maple.lan>
 <20210323083935.GF2916463@dell>
 <CAMuHMdUamD4rAY1Sn-3Fb9Xf1B9g0FY0Pob8rAFsFR0ZcNZ0rw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdUamD4rAY1Sn-3Fb9Xf1B9g0FY0Pob8rAFsFR0ZcNZ0rw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Mar 2021, Geert Uytterhoeven wrote:

> Hi Lee,
> 
> On Tue, Mar 23, 2021 at 9:40 AM Lee Jones <lee.jones@linaro.org> wrote:
> > On Mon, 22 Mar 2021, Daniel Thompson wrote:
> > > On Sun, Feb 28, 2021 at 01:41:05PM +0100, Konrad Dybcio wrote:
> > > > Add a compatible for PMI8994 WLED. It uses the V4 of WLED IP.
> > > >
> > > > Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
> > >
> > > Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
> >
> > Why are you Reviewing/Acking a patch that was applied on the 10th?
> 
> Only 12 days later?!?
> 
> It's not uncommon to receive acks for patches after they have been
> applied upstream. But it is if the patch was applied 10 years and 9
> months ago!
> https://lore.kernel.org/linux-m68k/F5513AE92A5A1047AC2F91AEBB9202680288CBBA3983@E2K7-MS2.ds.strath.ac.uk/

That truly is next level! :)

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
