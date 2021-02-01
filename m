Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7FB630A1DD
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 07:13:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231609AbhBAGFt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 01:05:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231742AbhBAFzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 00:55:47 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C963C061573
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 21:54:37 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id q7so2217843iob.0
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 21:54:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yE9K9haDCJkujJfpiYMh3J0DehWAaLemXdkg4MY47Ac=;
        b=mPaxIlsIbgZnY/tVj3f9/oTEEP56Gg4rY5MpP3Nuq2v8tvJlXTifMfX3FrWevEXmWy
         wqBLPtJyjmz3CmKhJsDGUyfM2xfV4/GrizPfdgw3jkMshlzcok2brthQOxUJViWf9VgQ
         /eQUf4uJrB1lJbQxL27/9qTIfcbPCKRucodfI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yE9K9haDCJkujJfpiYMh3J0DehWAaLemXdkg4MY47Ac=;
        b=U60HABuxphfKH+eS6UkwGFRekMurGt5Leg7TQiJbI/JtNktyiYY/2Z7K7Rrz6+SdwO
         aR7pP2X8zDIvZWjdDzeqXpLDtu8MY+LLnh++XXKO6q7gV5Ei3x+Hodk+CckcnGazfHcC
         oav3Eti2urYIkcZg008BmOWFS4Fhp4UTfczGFdld+9Azioi2XmgtEdkfGJP9w4J5nozt
         oAu4MkrVyd4JeBAKBYwyjjTZ6U+t56UHY8OF88QU5eCaoT6Tpl+Lj2gO2iRjPYFI/0o4
         cGGbFhNWh0MI6IDRxQpm0v9JGB3p2Cvin3gLGBNeOo/aqaLoEy6pjYOxQw8cNeDDI42+
         34jA==
X-Gm-Message-State: AOAM530ppfFjZaBGcJQN84cdm48FVNTBAWstpZtgUL15P1W0qT9cgf/h
        ugbW5MtSVOd+sHFi/2s1kedt1KzTrjJOsxrmgp59kA==
X-Google-Smtp-Source: ABdhPJwbilNZuRAaOmpbOQ8lESG2o9x3QeCxZJsZsuAW3kkhwmlLpUANeswwfrRMQJmsNTF8X1lbaUiq8aHnTwORyJk=
X-Received: by 2002:a05:6638:619:: with SMTP id g25mr12990902jar.43.1612158876472;
 Sun, 31 Jan 2021 21:54:36 -0800 (PST)
MIME-Version: 1.0
References: <20210201054542.1470695-1-Bilal.Wasim@imgtec.com> <20210201054542.1470695-2-Bilal.Wasim@imgtec.com>
In-Reply-To: <20210201054542.1470695-2-Bilal.Wasim@imgtec.com>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Mon, 1 Feb 2021 13:54:10 +0800
Message-ID: <CAJMQK-hYsM=a747UvW91Pbb0XPsqov-O5dUqawrGozYk1Q7Wrw@mail.gmail.com>
Subject: Re: [PATCH 1/2] soc: mediatek: pm-domains: Use correct mask for bus_prot_clr
To:     Bilal Wasim <bilalwasim676@gmail.com>
Cc:     "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Weiyi Lu <weiyi.lu@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 1, 2021 at 1:45 PM Bilal Wasim <bilalwasim676@gmail.com> wrote:
>
> When "bus_prot_reg_update" is false, the driver should use
> INFRA_TOPAXI_PROTECTEN for both setting and clearing the bus
> protection. However, the driver does not use this mask for
> clearing bus protection which causes failure when booting
> the imgtec gpu.
>
> Corrected and tested with mt8173 chromebook.
>
> Signed-off-by: Bilal Wasim <Bilal.Wasim@imgtec.com>

Reviewed-by: Hsin-Yi Wang <hsinyi@chromium.org>

> ---
>  drivers/soc/mediatek/mtk-pm-domains.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/soc/mediatek/mtk-pm-domains.h b/drivers/soc/mediatek/mtk-pm-domains.h
> index 141dc76054e6..7454c0b4f768 100644
> --- a/drivers/soc/mediatek/mtk-pm-domains.h
> +++ b/drivers/soc/mediatek/mtk-pm-domains.h
> @@ -60,7 +60,7 @@
>  #define BUS_PROT_UPDATE_TOPAXI(_mask)                          \
>                 BUS_PROT_UPDATE(_mask,                          \
>                                 INFRA_TOPAXI_PROTECTEN,         \
> -                               INFRA_TOPAXI_PROTECTEN_CLR,     \
> +                               INFRA_TOPAXI_PROTECTEN,         \
>                                 INFRA_TOPAXI_PROTECTSTA1)
>
>  struct scpsys_bus_prot_data {
> --
> 2.25.1
>
