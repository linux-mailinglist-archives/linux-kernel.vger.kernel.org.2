Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E327930C739
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 18:17:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237273AbhBBRNo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 12:13:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236264AbhBBQ1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 11:27:18 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5838FC061793
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 08:26:37 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id j12so14657177pfj.12
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 08:26:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=l4h6Ivu7DxeeLevJc1wQ+Ze6BVBDNOqfFBaVlOOvfD0=;
        b=Prj01pdPh3i/44KjbGbWaacJo35qLM4VarOzw/eGcQFhdfXnRipH1JT6n5AVVzqyBB
         ElkQT02SXpzSxXEy/04+RB50ZxAsJ7bfObZzNTc//m4oD5tL75/ltzjotxdcTRWkt2Kx
         rYR4RwqyrT6K3Hi2lJuJ4rzgoZhlwAbidDy3aOU8x7lhv0m/bd1mlqIDEGbKQ3nnZ7mK
         711c/pTmQ5kjzjDkYniVLcjV4kVMa+Bv4pVgbwq1kZaHpxgvJcy2YM9G+B9WlYBIPTxU
         JmvVCPC2OFaQ8I74JdqNI34TMPp1+GkN9FIFr2PjkpgjFhAmSdFlo28ayqjcOKiOrpkc
         jrfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=l4h6Ivu7DxeeLevJc1wQ+Ze6BVBDNOqfFBaVlOOvfD0=;
        b=ovQot/aOwbREwGTQBF1uf9YwaoWUbNmEtp3O+RXTG2pfFbP494U9rdaDpjG6haTjpp
         RXE+2OVLu4wS2gc1YacqSBlS9XWBk+c5EeMT9NqpBE91dR3MW2mt+2VxykcWTCNEtcWE
         8qVCHPQvtX0ALKwDX8120fUXNFOIAzR0snJ70aR9F2e3d3i4uy8FOKrxEAuVvlRVgR7b
         JXHviyJEXWW9QLPx7bXnnVueBWqiCoGBegkxS8iHJFA5Ps1hXJO+iuq3Ua2ie5I2QaGQ
         oxfpbwzZLiau47e7h3arZGT7MAgh81nSw2N3v8Vun/OaVyyhZ9aG8ZLSlv9tB8WRbtwk
         6R3A==
X-Gm-Message-State: AOAM5325TwBNKu7Qbxb6qShogC6azBTra06ZUnDq6hTQvFWeKe38v0m7
        rzU+Xv0UMUAgDsmuzzoBV+CKog==
X-Google-Smtp-Source: ABdhPJz23hBGlWbblH5zl60/YjQ3RKwRUlZd50alKTD1+nw88ReAaT0M2kwABWE88CwZbsdwgcrgmw==
X-Received: by 2002:a63:fe13:: with SMTP id p19mr22812940pgh.119.1612283196793;
        Tue, 02 Feb 2021 08:26:36 -0800 (PST)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id o14sm24015155pgr.44.2021.02.02.08.26.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 08:26:35 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-rtc@vger.kernel.org, Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
Subject: Re: [PATCH 10/21] rtc: meson: quiet maybe-unused variable warning
In-Reply-To: <20210202112219.3610853-11-alexandre.belloni@bootlin.com>
References: <20210202112219.3610853-1-alexandre.belloni@bootlin.com>
 <20210202112219.3610853-11-alexandre.belloni@bootlin.com>
Date:   Tue, 02 Feb 2021 08:26:35 -0800
Message-ID: <7hsg6eh1vo.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alexandre Belloni <alexandre.belloni@bootlin.com> writes:

> When CONFIG_OF is disabled then the matching table is not referenced.
>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

Acked-by: Kevin Hilman <khilman@baylibre.com>

> ---
>  drivers/rtc/rtc-meson.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/rtc/rtc-meson.c b/drivers/rtc/rtc-meson.c
> index 8642c06565ea..44bdc8b4a90d 100644
> --- a/drivers/rtc/rtc-meson.c
> +++ b/drivers/rtc/rtc-meson.c
> @@ -380,7 +380,7 @@ static int meson_rtc_probe(struct platform_device *pdev)
>  	return ret;
>  }
>  
> -static const struct of_device_id meson_rtc_dt_match[] = {
> +static const __maybe_unused struct of_device_id meson_rtc_dt_match[] = {
>  	{ .compatible = "amlogic,meson6-rtc", },
>  	{ .compatible = "amlogic,meson8-rtc", },
>  	{ .compatible = "amlogic,meson8b-rtc", },
> -- 
> 2.29.2
