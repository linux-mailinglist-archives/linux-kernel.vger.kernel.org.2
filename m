Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 833A934E58A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 12:35:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231731AbhC3Kfa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 06:35:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231649AbhC3Kev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 06:34:51 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CFADC061574;
        Tue, 30 Mar 2021 03:34:51 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id d191so8094137wmd.2;
        Tue, 30 Mar 2021 03:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IKhgdA7IcdpUmIcp9LYMuYlTkJ/X/xDStYFjCCWtH0E=;
        b=L9+YP5uF5lUC3kfPwHeot2K4g+mhil7Im7mx8/oxjEUmwQodlNz08osCMRZp8xy5vH
         3adG+ekiScfM04iHesfJjtJdK8YhPc+4AzcLRtHBt8xyI14fFSxpwS0p54kHBJgZeZps
         baVPelKyUT8J/XlK5M1aiVM8cQWfbA5tmcX5DQIXMgoxi6TMcsLv1OV8aVcfABv/u8id
         QbwVaBO2KQrz6cElI91T/+7RpwY4DJnuS0qMaAgm84syvoAiXwwcKbZWXEA1iO3SELA7
         B8nnY8CmplaeZg/v97dr9CgedV+tnmeBl/cSlWAkVRToeDWbNnJGLFE4AoQLL6a3oTkT
         xkwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IKhgdA7IcdpUmIcp9LYMuYlTkJ/X/xDStYFjCCWtH0E=;
        b=UFIbYVu5BfHilq20atEM+G4ldnbumTQCAAlpeJqlzQdSXJ8ZfxloYOU/pO2EfJczg5
         PmeFu5Q8r3s+R1/i3IU5vJVvFX1TEoHAgXU65IhS40mcdr1fvwHXJWX/b+WeePOeP0tv
         YGE/S4Pw4EdA8yTSAYSG5ImbNZILbaCZeJ+Ljgp2JFAHk/ERuGpbeUOdFfaUUWAhRhTT
         xum3+6KdCU0M6uoqPqTKsjBScnN5mE+2r9T3BHzIMOx0KKcI5gUdNStplouiHIyW1+QS
         yd3dXkyE2spv6ZCRIN8M1oQonyAR6zn1Ggixip623jmxLFV1U8WQuF+m73EFtenZ2619
         fAjg==
X-Gm-Message-State: AOAM530C/D6U7aw14FC+awtnGjokEr8QOPKTsb1GjMvT+CXdJ1+hbY/I
        qD5hip4i+jtBilBZh7Pb/fI+tsM+s9LyPl2e
X-Google-Smtp-Source: ABdhPJyeURqXYD/cnr28buRAMw5ZpFL6vzxE5BY1Y9JvfpjlzuG9PzdcIzBZ2PZDVFebowgOj+DlNg==
X-Received: by 2002:a1c:bd55:: with SMTP id n82mr3310167wmf.3.1617100490242;
        Tue, 30 Mar 2021 03:34:50 -0700 (PDT)
Received: from ziggy.stardust ([213.195.126.134])
        by smtp.gmail.com with ESMTPSA id z8sm31845449wrh.37.2021.03.30.03.34.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Mar 2021 03:34:49 -0700 (PDT)
Subject: Re: [PATCH v6 0/5] Add PMIC wrapper support for Mediatek MT6873/8192
 SoC IC
To:     Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>, drinkcat@chromium.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <1615563286-22126-1-git-send-email-hsin-hsiung.wang@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <e33053cf-f337-d7f6-fbf6-93d385f7e683@gmail.com>
Date:   Tue, 30 Mar 2021 12:34:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <1615563286-22126-1-git-send-email-hsin-hsiung.wang@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/03/2021 16:34, Hsin-Hsiung Wang wrote:
> This series adds support for new SoC MT6873/8192 to the pmic-wrap driver.
> This series is based on Weiyi's patches[1].
> 
> [1] https://patchwork.kernel.org/project/linux-mediatek/patch/1608642587-15634-7-git-send-email-weiyi.lu@mediatek.com/
> 
> changes since v5:
> - rebase to Linux 5.12
> 
> Hsin-Hsiung Wang (5):
>   soc: mediatek: pwrap: use BIT() macro
>   soc: mediatek: pwrap: add arbiter capability
>   dt-bindings: mediatek: add compatible for MT6873/8192 pwrap
>   soc: mediatek: pwrap: add pwrap driver for MT6873/8192 SoCs

Applied to first four to v5.12-next/soc

Please resubmit the DTS node once the clock driver is accepted.

Regards,
Matthias

>   arm64: dts: mt8192: add pwrap node
> 
>  .../bindings/soc/mediatek/pwrap.txt           |  1 +
>  arch/arm64/boot/dts/mediatek/mt8192.dtsi      | 12 +++
>  drivers/soc/mediatek/mtk-pmic-wrap.c          | 97 ++++++++++++++++---
>  3 files changed, 95 insertions(+), 15 deletions(-)
> 
