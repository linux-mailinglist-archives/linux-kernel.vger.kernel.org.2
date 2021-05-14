Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63D20380470
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 09:37:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233108AbhENHiZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 03:38:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232994AbhENHiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 03:38:23 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03396C061574
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 00:37:07 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id z130so3589287wmg.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 00:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Xie40h+gZ1kzYUn1rROBwrR8QVBZ1vuhKr3GMAIK+Q8=;
        b=TgVhJZN35mBTuD+cC15AfqK8ykz9udZlYfRFTLu9xXjgyLVHyoxCmmiA2XQ6mn7GQ6
         8+k32KSLVWn4LMs3+3ZnbRxeSb1X9Nzo8HyoPuP1zJTCmBiS54FMI256xNZ4YaJP9Unb
         2OdJkpT/f1RYZk3iDJlRqKDJMWgFUjS5D838OhtG72eqq0XV8ZXuv1dWpV4S/gl5hO9l
         y0KU5idVxel5dpb6LLKxO6bckYUiVW0kewFbnWGdNZJ9ak9yXUZZbO+A82/eU08EzFHB
         fXQ5B3Pwf2zcsm6kensIlmiSLxGwtAEBDtCtbKdpU7QfgslEXBqmiWDeTPwmrp5JNoiE
         BaVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Xie40h+gZ1kzYUn1rROBwrR8QVBZ1vuhKr3GMAIK+Q8=;
        b=SULmvhGOJrZEvS3Dml+Upnzbmxc5/FD9K7ZcfVKySn5actidD/O7eR6RkwsbJiNh4I
         Tlt9S/4G10CwxBGBrRUj0BZp/xGTBs1vX6SiykG6zTjypOGgKAcst3NXywRfOd55UpPR
         9I1FB9IG9Z+UnXvR4nLv+2Q6Kuy1aEiTmjW3Vqa9N450pPaZDA920qRISxgEt4VlA7kE
         z986NkmfOq8apsHdMnya8VzTm29iYyUs+YJOJAYBSSyGsAzOa3fkAt85oTKxzbOlCUG8
         4K1V7tr3z6jfoz0jTZkWwIxVJJp7eJINSx7SBgJCyb0jOcMhGoacIYMQt1/k9972h2Dz
         KHpA==
X-Gm-Message-State: AOAM532JJheLFDLsa6408dAyvmU/acn3g5LrsC9ksETduCPi/f5kmZAA
        ZxhfaMC0EM3It4DxQUSMJoGdCP5yvL8Yeg==
X-Google-Smtp-Source: ABdhPJwmhFrIvmqlONGCF4CpJDAkVPbQ35AP7JfhIb8MDmNU4+MHO5abZDYy/w/+WsNn4AWmn99G0A==
X-Received: by 2002:a1c:20d2:: with SMTP id g201mr8102333wmg.48.1620977825427;
        Fri, 14 May 2021 00:37:05 -0700 (PDT)
Received: from [172.20.10.7] ([37.164.52.111])
        by smtp.gmail.com with ESMTPSA id c14sm5664839wrt.77.2021.05.14.00.37.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 May 2021 00:37:04 -0700 (PDT)
Subject: Re: [PATCH] MAINTAINERS: ARM/Amlogic SoCs: add Neil as primary
 maintainer
To:     Kevin Hilman <khilman@baylibre.com>, soc@kernel.org
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210511190054.26300-1-khilman@baylibre.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
Message-ID: <45188686-7fc2-e48f-e249-0483431e9d46@baylibre.com>
Date:   Fri, 14 May 2021 09:37:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210511190054.26300-1-khilman@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kevin,

On 11/05/2021 21:00, Kevin Hilman wrote:
> Add Neil as primary maintainer for the Amlogic family of Arm SoCs.  I
> will now act as co-maintainer.
> 
> Neil is already doing lots of the reviewing, testing and behind the
> scenes support for users of the upstream kernel on these SoCs, so this
> is just to formalize the current state of affairs.
> 
> Thanks Neil for all of your efforts, and keep up the great work!
> 
> Signed-off-by: Kevin Hilman <khilman@baylibre.com>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index bd7aff0c120f..1f64aa7de84d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1618,8 +1618,8 @@ F:	Documentation/devicetree/bindings/sound/amlogic*
>  F:	sound/soc/meson/
>  
>  ARM/Amlogic Meson SoC support
> +M:	Neil Armstrong <narmstrong@baylibre.com>
>  M:	Kevin Hilman <khilman@baylibre.com>
> -R:	Neil Armstrong <narmstrong@baylibre.com>
>  R:	Jerome Brunet <jbrunet@baylibre.com>
>  R:	Martin Blumenstingl <martin.blumenstingl@googlemail.com>
>  L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
> 

Acked-by: Neil Armstrong <narmstrong@baylibre.com>

Thanks for your trust, I'll do my best to continue maintaining the Amlogic Linux SoC drivers & DT !

Neil
