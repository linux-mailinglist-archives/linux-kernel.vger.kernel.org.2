Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E04245D49E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 07:14:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347436AbhKYGRx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 01:17:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346665AbhKYGPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 01:15:52 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17360C06175D
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 22:12:41 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id fv9-20020a17090b0e8900b001a6a5ab1392so4890295pjb.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 22:12:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YKVOYD3BZCO+X1y+/55daB35BTEfDtfDdx/rM8jqf9E=;
        b=n44WZ2z69BFhD6vXWR3Y71Tv2Zgm+1rz0FtTfpotm+0hmcPZ4gF1VMyFrivfZgFzR8
         MOGavT5d/logVOf2dPzjha8xDqIvaFogxvhakYpzRenhBiKAgeES61jdpxEqZg2oBi6c
         7mwCxUrW6+HKm73SPS/WPDIL6NhLX5CxWq3DUWJWqeGIg0xkpsm3jl23w9Y7ZhtoVkrf
         XXap00ZG3ymtg31S8xYpPyHcp3t9bzHzsbIhEJrt604GMm4tSSm1S9jOjbNKLk3KLYR3
         rsydc2tsDnNk0Tl45d2/T9Z/BEDWXslWhVFaIrkLtoByCb29PbSsbNuJEBoiELGgbGeM
         hP3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YKVOYD3BZCO+X1y+/55daB35BTEfDtfDdx/rM8jqf9E=;
        b=ZBoARraDoFdPrBhc2rbn34XxgG5Dpv1RE8i85DQrlzPgXyTdgdxBAHn499vnV4Wc50
         fcJpeEN+VNmX5mi7adAuKjeJXcx+GNAqkmVEdDLzXvIsFEHzjkz3sEBJCJYD2T2J/2Hd
         GhyVh3oVOXSktOip5yawNHBq/y9io3KWOzd1SKhbslJWM6nuCK6O+LqgDvC2f+giHOVW
         lzjuWvvwFXzqwWzqnwTRvXAmGMPcMbzFkjEf7ohWicUGywv/q4znbQb+f59/lXeAsWwC
         fjbgM6okVJlzits7Oshiaq6IEhv26DABmDaUi6ls5ViDlE4sHPPcFAtJLskdRf9A4cF9
         xgHw==
X-Gm-Message-State: AOAM533Xr37TlH4RB73ERo1HwFeHx771l38lzcvC8ScNmJNfLgoz6dFf
        4pLd65c1TfzwAWTeMe4eogfuXw==
X-Google-Smtp-Source: ABdhPJwCSDiaHHIcRXyx/a84z6DGPSsJ7vljD/viUs2u9iWx1qa9RfjpBOH+FGAIZgcGnOGyAhdYaw==
X-Received: by 2002:a17:90b:1e0e:: with SMTP id pg14mr4061574pjb.143.1637820760339;
        Wed, 24 Nov 2021 22:12:40 -0800 (PST)
Received: from google.com ([2401:fa00:1:10:cd6a:1959:1c65:cc19])
        by smtp.gmail.com with ESMTPSA id y130sm1621671pfg.202.2021.11.24.22.12.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Nov 2021 22:12:39 -0800 (PST)
Date:   Thu, 25 Nov 2021 14:12:36 +0800
From:   Tzung-Bi Shih <tzungbi@google.com>
To:     Jiaxin Yu <jiaxin.yu@mediatek.com>
Cc:     broonie@kernel.org, matthias.bgg@gmail.com,
        garlic.tseng@mediatek.com, kaichieh.chuang@mediatek.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, alsa-devel@alsa-project.org,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] ASoC: mediatek: remove unnecessary CONFIG_PM
Message-ID: <YZ8pVIVApvSiW6Ue@google.com>
References: <20211125042422.2349-1-jiaxin.yu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211125042422.2349-1-jiaxin.yu@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 25, 2021 at 12:24:22PM +0800, Jiaxin Yu wrote:
> The unnecessary conditional inclusion caused the following warning.
> 
> Such as:
> >> sound/soc/mediatek/mt8192/mt8192-afe-pcm.c:2368:32: warning: unused
> >> variable 'mt8192_afe_pm_ops' [-Wunused-const-variable]
>    static const struct dev_pm_ops mt8192_afe_pm_ops = {
> 
> Because runtime_pm already handles the case without CONFIG_PM, we
> can remove CONFIG_PM condition.
> 
> Signed-off-by: Jiaxin Yu <jiaxin.yu@mediatek.com>
> Reported-by: kernel test robot <lkp@intel.com>

Acked-by: Tzung-Bi Shih <tzungbi@google.com>
