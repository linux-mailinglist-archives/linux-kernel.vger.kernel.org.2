Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 703A43E561B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 10:59:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235532AbhHJI7T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 04:59:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238426AbhHJI7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 04:59:17 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D49B0C0613D3;
        Tue, 10 Aug 2021 01:58:55 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id o1-20020a05600c5101b02902e676fe1f04so1368381wms.1;
        Tue, 10 Aug 2021 01:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DZGtTjtzuONYDWQ02eZzQw+Y6sEYh4NUv+medlIAmQg=;
        b=egqehrq7CkJ97r5UIn8xQu8mS1JgYuuTIE88Yr6sIQfBuwd2f3cHYoXKMX5k8AeOXT
         zcUZLaJ8nM2QHotO5d3amELtbpr5YHHBnRivUmGei8ob2B0yF/kE17hSgB2+UeCPt6bs
         /XBwAilgaoeOgcZS/M1mzAMCszKBTxDuu7jvE5qEuROo0PihhQjFwWlKxFcDxcAkBClU
         KgEZC/o1yeHBeQM70+arvJSHFwDSSWfSN9IeCCFzfSo5s+/YISjacxmz6WTxzGtZVAa/
         ULKKC+SUT3ZMYXSc2AErLxggUjsNYlYgQ4kQoukWF3kc35qWCOX0ClymcFvgI76KgaXI
         hCaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DZGtTjtzuONYDWQ02eZzQw+Y6sEYh4NUv+medlIAmQg=;
        b=rChzf6l/Jdgyn/jCd+2IOqGokTK1BWOzyW+b2i0viBbWlz+fWnRcIOIu87dmI1v82a
         GwpQzN7DLpad3dpdCWLGHKxOrzX32UCBESiQ8fP0hl0LaUY1mWt8j3osMk4TBNMlq624
         xiM0FvFjqlHOi0wEwpqdGTH6KkWKnluziLbAlKyRCwRP3a5VhPm5iHRvExpbFtWIuWih
         Uag/B9NT6kpRBdHuiqc0DJJV4uLFhlAKIGZB8lDBKkMwCBGuJ87jlu5rN5cwKwXRNDVX
         Sph0HGGc5ei38higsyrCEDY6GrMfMjPoDdZUglIiDaD6Dfe/k14AJacxmA2d3Nfhi32w
         n4PA==
X-Gm-Message-State: AOAM530I6qdKnp/lDh4KkeWvHcL8Lx60K/nO48AWU7LPQ6/MphOvA3fZ
        JCTLscPemnv3BPjjgi3H3GE=
X-Google-Smtp-Source: ABdhPJzPEKr39AcsB3Lagut2U7pslSZe1FaUFeq/Uoj2qWkA8L7OvGIH6bMmf40+xCTrTTMonQ/omQ==
X-Received: by 2002:a1c:1904:: with SMTP id 4mr15181735wmz.93.1628585934443;
        Tue, 10 Aug 2021 01:58:54 -0700 (PDT)
Received: from ziggy.stardust ([207.188.163.204])
        by smtp.gmail.com with ESMTPSA id o17sm22127178wrw.17.2021.08.10.01.58.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Aug 2021 01:58:54 -0700 (PDT)
Subject: Re: Aw: [PATCH v8, 2/2] soc: mediatek: mmsys: Add mt8192 mmsys
 routing table
To:     Frank Wunderlich <frank-w@public-files.de>,
        Yongqiang Niu <yongqiang.niu@mediatek.com>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Fabien Parent <fparent@baylibre.com>,
        Dennis YC Hsieh <dennis-yc.hsieh@mediatek.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Hsin-Yi Wang <hsinyi@chromium.org>
References: <1627894773-23872-1-git-send-email-yongqiang.niu@mediatek.com>
 <1627894773-23872-3-git-send-email-yongqiang.niu@mediatek.com>
 <trinity-a5eeacb8-1625-4111-b613-19ee1609b902-1628062221917@3c-app-gmx-bap67>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <a09da534-274d-3eaf-6c4d-eb2a4817626b@gmail.com>
Date:   Tue, 10 Aug 2021 10:58:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <trinity-a5eeacb8-1625-4111-b613-19ee1609b902-1628062221917@3c-app-gmx-bap67>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/08/2021 09:30, Frank Wunderlich wrote:
> Hi
> 
> can you please test if your device still work after applying this
> 
> https://patchwork.kernel.org/project/linux-mediatek/patch/20210729070549.5514-1-linux@fw-web.de/
> 
> and
> 
> duplicate value constants in your routes?
> 
> e.g. changing
> 
> +		DDP_COMPONENT_OVL_2L0, DDP_COMPONENT_RDMA0,
> +		MT8192_DISP_OVL0_2L_MOUT_EN, MT8192_OVL0_MOUT_EN_DISP_RDMA0,
> 
> to
> 
> +		DDP_COMPONENT_OVL_2L0, DDP_COMPONENT_RDMA0,
> +		MT8192_DISP_OVL0_2L_MOUT_EN, MT8192_OVL0_MOUT_EN_DISP_RDMA0,
> +		MT8192_OVL0_MOUT_EN_DISP_RDMA0
> 
> regards Frank
> 

I did a fixup for that in v5.15-tmp/soc

Yongqiang, please test if this is working on the SoC.

Regards,
Matthias
