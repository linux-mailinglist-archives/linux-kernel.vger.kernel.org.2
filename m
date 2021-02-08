Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66F4931351E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 15:26:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233026AbhBHOZq convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 8 Feb 2021 09:25:46 -0500
Received: from mail-ej1-f52.google.com ([209.85.218.52]:36782 "EHLO
        mail-ej1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231400AbhBHOG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 09:06:29 -0500
Received: by mail-ej1-f52.google.com with SMTP id lg21so24887314ejb.3;
        Mon, 08 Feb 2021 06:06:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=XphVOHheHYoGHKVI4PzWTQj/Y2Cb2UP33rdxMkO7I7M=;
        b=cH7+WaWRv+Jf/qvqsTtgPx2v0XbH9/9kcyO6mttzstO1PN92UpNXESdUElJGWxm9BZ
         km+zIupYup6OaiXvWpu+0pHDjl5SD4xGQZXKgSJBZonwlgtLFDbndzkGRE142mEi8JJ2
         X30QmIuivJ9E6kkLOPElfnAUJmjlXllRwo2+JSAXD+BtWYgOfcTXqSfPVADitZGC/I7P
         gGrOsR6pI+6zYl2sbqvCWu4LpN2rtqSSeIRRkvRGC6AFKYaxwDS05KS6lQrcKpHnp3Je
         tHCwSI3XMMv0UhexuWHOAAjThww6N9qq0cx6ZG7/X/YE23RpFDMP95MQ0ApS1sX11rFP
         KJhg==
X-Gm-Message-State: AOAM531S79zHUlJQInI7szzAodrHfJqWStpP2mSZwlNerw1cU00fJLAt
        TvbnHL1oB98jDz6ac6A5QEs=
X-Google-Smtp-Source: ABdhPJyt0nz9QpecNnWZqKbqOv1aQV6UJHItXhWO9Udd+7YtvNYJnGf8utGJfPMJ2MwPvxbiBFmUnA==
X-Received: by 2002:a17:906:1c17:: with SMTP id k23mr8206243ejg.121.1612793145996;
        Mon, 08 Feb 2021 06:05:45 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id h3sm9484366edw.18.2021.02.08.06.05.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 06:05:43 -0800 (PST)
Date:   Mon, 8 Feb 2021 15:05:42 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Martin Kepplinger <martin.kepplinger@puri.sm>
Cc:     robh@kernel.org, shawnguo@kernel.org, kernel@pengutronix.de,
        festevam@gmail.com, kernel@puri.sm, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Guido =?utf-8?Q?G=C3=BCnther?= <agx@sigxcpu.org>
Subject: Re: [PATCH 3/5] arm64: defconfig: Enable devfreq support for i.MX8MQ
Message-ID: <20210208140542.yah354hd7tqbweud@kozik-lap>
References: <20210208131527.24463-1-martin.kepplinger@puri.sm>
 <20210208131527.24463-4-martin.kepplinger@puri.sm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20210208131527.24463-4-martin.kepplinger@puri.sm>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 08, 2021 at 02:15:25PM +0100, Martin Kepplinger wrote:
> From: Guido Günther <agx@sigxcpu.org>
> 
> This is needed to make DRAM frequency scaling via devfreq as used
> on the Librem 5 and Librem 5 Devkit.
> 
> With the interconnect support enabled we now need imx devfreq on top
> to make this work.
> 
> Signed-off-by: Guido Günther <agx@sigxcpu.org>
> Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
> ---
>  arch/arm64/configs/defconfig | 2 ++
>  1 file changed, 2 insertions(+)
> 

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
