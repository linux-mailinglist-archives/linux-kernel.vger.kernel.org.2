Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D791231CA5A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 13:06:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230458AbhBPMEq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 07:04:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230427AbhBPMCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 07:02:20 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA454C061756
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 03:59:32 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id x16so541114wmk.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 03:59:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Vdhu8U1QU4NNQOQK7F0IcKROqAkbt4T+2oowJvOiIEI=;
        b=ZeFHwIKLx8FPqrshhYW0vuyUCycDIe6jJJ4Oi3dPexy/VoZt5EbyHd7OrxmpBDLXXX
         sFvh5O3l/RCabEg/zzykeEufyihQbduluEKfe/0XA4xiB/L0Z0aFbhTpE/r7O4nAPfTH
         pdUo91iHchn27Prhs3g8mijIzWMGGVS/SDKYnPlftyQANAA4IdGTeSLb7JAG7WShN0qA
         QVsgvik1YjRj+1dRZbrUegnz+nhI7IbXe8TKlAt0DnFa4fQ3q6JqPk0ZpdwFhb+1Q7Yn
         lnZyACt+ZLU7oL/uOyPM5HYt3nA0ZS+5OTHaZ7z3s7WuVguHUy4pTkIkP7NSLLHSopY4
         vF+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Vdhu8U1QU4NNQOQK7F0IcKROqAkbt4T+2oowJvOiIEI=;
        b=WQwqmWOH+iHNKGT9AeRb/q+C0SWDwTVx2x3QTEG+PNwuMugmDKGKPRKCWrrj2Sf4PY
         G3M/URv3nqxOMGIShmG/xHCte3WSQMCrhTkDX2+ncSYhKs+LfWpaqd5yOuLc8UVXrwFJ
         mGzJeYlcGPiMPkZ2Vuu8sWOHsdjJ79mOyUWTokVz2UKCMIG2DZyI9YAsiazE8MJiJJdx
         szsEOJOGOALEHaKBSMFg0kxl3YJP2sLGb6HeJrzgcBai0hdITjd8tC9AUe1wqjyTXP9n
         /ybzkfSUm+LciBFf0zMJOIKLn9/sKXEH+AnLytdWZJmDBjKl3pflJCv/ZhDzaX5wrUrS
         VtlA==
X-Gm-Message-State: AOAM531snOKdng4/tmACEgkVV9HM3MKESHSeKPwrkJ3OL86IQdUwbDp9
        7nPIkhDUWcEbzHT4xMtZMiRZSKbzRR3+Viif
X-Google-Smtp-Source: ABdhPJy4QtaFpwXzcg7OezjI/QsgDUwtqJ6OSEDxhqyvkNRvsHScS81WKCW86b2sKWSUyZyosirTBg==
X-Received: by 2002:a1c:2d47:: with SMTP id t68mr3103988wmt.189.1613476771741;
        Tue, 16 Feb 2021 03:59:31 -0800 (PST)
Received: from a-VirtualBox (cpc141888-watf13-2-0-cust663.15-2.cable.virginm.net. [86.14.42.152])
        by smtp.gmail.com with ESMTPSA id a186sm3348583wme.17.2021.02.16.03.59.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Feb 2021 03:59:31 -0800 (PST)
Date:   Tue, 16 Feb 2021 16:59:26 +0500
From:   Bilal Wasim <bilalwasim676@gmail.com>
To:     linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        matthias.bgg@gmail.com, enric.balletbo@collabora.com,
        hsinyi@chromium.org, weiyi.lu@mediatek.com
Subject: Re: [PATCH v2 0/3] Misc bug fixes in mtk power domain driver
Message-ID: <20210216165926.46bbafc7@a-VirtualBox>
In-Reply-To: <20210201121416.1488439-1-Bilal.Wasim@imgtec.com>
References: <20210201121416.1488439-1-Bilal.Wasim@imgtec.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


ping - can this series be merged ?

On Mon,  1 Feb 2021 17:14:13 +0500
Bilal Wasim <bilalwasim676@gmail.com> wrote:

> Incorrect mask for the "bus_prot_clr" field meant that imgtec
> gpu power domain (mfg_async) was not powered up correctly, causing
> failure in driver booting. Fixing this and also adding "domain_suuply"
> capability to "mfg_async" power domain (for mt8173) as imgtec gpu
> needs da9211 regulator to be enabled before enabling this subdomain.
> 
> Tested with mt8173 elm chromebook.
> 
> Bilal Wasim (3):
>   soc: mediatek: pm-domains: Use correct mask for bus_prot_clr
>   soc: mediatek: pm-domains: Add domain_supply cap for mfg_async PD
>   arm64: dts: mediatek: mt8173: Add domain supply for mfg_async
> 
>  arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi | 4 ++++
>  arch/arm64/boot/dts/mediatek/mt8173-evb.dts  | 4 ++++
>  arch/arm64/boot/dts/mediatek/mt8173.dtsi     | 2 +-
>  drivers/soc/mediatek/mt8173-pm-domains.h     | 1 +
>  drivers/soc/mediatek/mtk-pm-domains.h        | 2 +-
>  5 files changed, 11 insertions(+), 2 deletions(-)
> 

