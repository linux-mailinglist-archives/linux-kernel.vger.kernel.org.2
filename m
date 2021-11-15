Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C8C8450667
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 15:11:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232128AbhKOOOf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 09:14:35 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:49952
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234749AbhKOONb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 09:13:31 -0500
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com [209.85.208.200])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 7DE383F1AD
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 14:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1636985428;
        bh=mCa20cTk0YdiDi8pE/UhUWsJguQZFp7JH5I7pKz6MkE=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=hnDoADUaxsYQKlM/lVmqHni+/BxxWKNUJ69FU6+RF++BmOZkhSzkuWMy29GwDLL9W
         IELLH+azP85Bu4e8lfYg4BS63+gEjyjxNdFy7v6VDQFUmZaqzdy9xXqJHZec4mCQuA
         X2GXuiQkUG57Qb22YZsu+NBXA6PFedDLiQ30ZV/RhOyp4StY4bB7bQsbI9WlS3eXLk
         LrWSoa3/BjrqJKe5d5p8kXx+sqn9KvQ62AU4DcD6V2SXDCpDurGoKwPuvPXAcxx+NW
         MsIbbtzHo2PCUjzFSBTSY6DOmKiVjY2zfEFfpu8mMdHSPIV5Z72WhYEk+1LxuckPiK
         6W49MqphlR9KA==
Received: by mail-lj1-f200.google.com with SMTP id w16-20020a05651c103000b00218c9d46faeso5136338ljm.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 06:10:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mCa20cTk0YdiDi8pE/UhUWsJguQZFp7JH5I7pKz6MkE=;
        b=f/AAQX/AXYSbJA2lXfjF9BlSv93qvjhHF5Ayxxy+FZUC9LOCpWt4qFsPqstl7br99F
         4iZs4PELLlVc3a7Y2/kAWtURN93uBNv+VmtN3yumHwUFtSuXgMhKAugRosooDjufw/bn
         RQyx53KnWoW3FThM805Tv6SVr+rbzR6W3y9q0h7Gxl2ANyPZMOwgJSkNjpT1LiSRFnvW
         5TV05PFozTSoxykCXWqopRzi7j/C5+oYQtoVsndZQOsR/exOGzrb08snCyBNc8EYj6Cd
         SozmqkMRBvN1vD2WmepTk7LLpW2V2hwoknN5BUrRaZwXwIcM0EKhLKXjNeQwpeHJ3f4w
         azaQ==
X-Gm-Message-State: AOAM533P/1MMT1IfAlgVhzL2vDGT1vvYpm8LswwgGhMGTEixOwIjdnUu
        PhIjdl5r/SdQcu6f59XYVoZ1aeX1QAjqli0pInyh89UAIdotID95X/r1lo13y5bYMAg+p4y0L7e
        C03lQA9dU3sz7NOcxZ14X63wcwefb7U59Y8OBO11ieg==
X-Received: by 2002:a05:6512:203:: with SMTP id a3mr36529496lfo.409.1636985427908;
        Mon, 15 Nov 2021 06:10:27 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxA8sjBYSj935VPORa4y/NP6odiHrvYiO7ClVmkVvCP7LH5421J7OLkoFDm4wDXttT9K8avWQ==
X-Received: by 2002:a05:6512:203:: with SMTP id a3mr36529471lfo.409.1636985427768;
        Mon, 15 Nov 2021 06:10:27 -0800 (PST)
Received: from krzk-bin.lan (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id p17sm1508215ljm.138.2021.11.15.06.10.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Nov 2021 06:10:27 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        matthias.bgg@gmail.com, yong.wu@mediatek.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] memory: mtk-smi: Use ARRAY_SIZE to define MTK_SMI_CLK_NR_MAX
Date:   Mon, 15 Nov 2021 15:10:24 +0100
Message-Id: <163698542257.136651.16595102887098305060.b4-ty@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211015151557.510726-1-angelogioacchino.delregno@collabora.com>
References: <20211015151557.510726-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Oct 2021 17:15:57 +0200, AngeloGioacchino Del Regno wrote:
> This definition is tied to the number of SMI common clocks (the array
> mtk_smi_common_clks): improve the definition by using the ARRAY_SIZE
> macro instead. That will also reduce room for mistakes when updating
> the aforementioned array in the future.
> 
> 

Applied, thanks!

[1/1] memory: mtk-smi: Use ARRAY_SIZE to define MTK_SMI_CLK_NR_MAX
      commit: 3191e91ae15b60e69523578975bf5c6326ce1be4

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
