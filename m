Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4386E450666
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 15:11:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232102AbhKOOOa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 09:14:30 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:49978
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231805AbhKOONb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 09:13:31 -0500
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com [209.85.167.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id A0DF33F1E7
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 14:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1636985429;
        bh=pfr1cDNzcAoQOpDJQS2N+lpkCMkGHO9LO6u1gxB8aGM=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=ctNqT7HEX4QQTepOUtE/pPA69s+PbJpIXCDGH07HxDEie0T5HH0oRzR8kidQ3M6Wq
         QxCzGr4xpdId0V5CgDg6TGaydn0dptwB8DWjy6W5aVaLN5kR9WxQOty5ZcNDDbrgdq
         i3nk7+kWfxr2kFTwHB11GU53AjxO+Jq/qugipgE7oEhVwF49j7NnamPisA1Ge6qq67
         i57xPXmHTVru/Y1jfHIubA08VuL8Z08SUbwZVZOgHn2UpZti79IKE6NR0JV9ZwHz/P
         Hkat6arT3SLctNw+X8tbt3sUktB0/wvZTyAC6PeGyNi69LJzLa+zo610LtnlDx+jib
         uWOtb8wIHVNdA==
Received: by mail-lf1-f72.google.com with SMTP id n18-20020a0565120ad200b004036c43a0ddso6778007lfu.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 06:10:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pfr1cDNzcAoQOpDJQS2N+lpkCMkGHO9LO6u1gxB8aGM=;
        b=jnWXuHw8vhChOhzCyLeTZ1BNoihvNy6uzgiqI2fQ9AHlYTXIktxdCXeyKiekXmEpRw
         67OLjZxYnY1HZjM56wfzga0xLfsPDDd/ybbtg+qal2eeAWkrE7puY8IypBHmSdADff/v
         W2cI1xjjEgeAr2SNzGesGSK/HP8JsAmJauSK69Y6KrunRiCkwygJL538LFrLqEBh0+Ns
         pDKNRN3jxY8FqRGfPKRA1C+FHreo3EL3eJFLFVy8QmGA8pq05ib2HH+ZQ/hiNpLFEwEU
         18BvNjRPNLvzCtTYQ/U8I6SbT8LTwkLbQ9O+uqVvcoEDNSHmtn24qY4OB9W7Dpa0th/5
         w7yQ==
X-Gm-Message-State: AOAM5310Qw/iJgWQWXU9j9cwEhJHe5ENELwsrQp4dYLVnWgVXjMwN+Ke
        pL2SfGYbDDaUYK5VNb2WMn+33+NBNKknbZloz+t7WQruqpQvP0cnLK80yShKlMxHFsXLQ2xC6P9
        mkAB75JKrjhX+ymhud1LgxAu2oe36E6Jac2wjxqAT+Q==
X-Received: by 2002:a05:6512:20e:: with SMTP id a14mr18304379lfo.192.1636985429144;
        Mon, 15 Nov 2021 06:10:29 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw+mI02/0nQEVJ716rf5CIjp6Bip28AWoCb8f30KO4Aj7CFe5qZ574+bCxyzb4bWi3fMN8Ywg==
X-Received: by 2002:a05:6512:20e:: with SMTP id a14mr18304343lfo.192.1636985428995;
        Mon, 15 Nov 2021 06:10:28 -0800 (PST)
Received: from krzk-bin.lan (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id p17sm1508215ljm.138.2021.11.15.06.10.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Nov 2021 06:10:28 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Yong Wu <yong.wu@mediatek.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        anan.sun@mediatek.com, youlin.pei@mediatek.com,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>, yi.kuo@mediatek.com,
        Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        iommu@lists.linux-foundation.org, anthony.huang@mediatek.com,
        Ikjoon Jang <ikjn@chromium.org>,
        Robin Murphy <robin.murphy@arm.com>,
        srv_heupstream@mediatek.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] memory: mtk-smi: Fix a null dereference for the ostd
Date:   Mon, 15 Nov 2021 15:10:25 +0100
Message-Id: <163698542257.136651.14853548122836494400.b4-ty@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211108082429.15080-1-yong.wu@mediatek.com>
References: <20211108082429.15080-1-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Nov 2021 16:24:29 +0800, Yong Wu wrote:
> We add the ostd setting for mt8195. It introduces a KE for the
> previous SoC which doesn't have ostd setting. This is the log:
> 
> Unable to handle kernel NULL pointer dereference at virtual address
> 0000000000000080
> ...
> pc : mtk_smi_larb_config_port_gen2_general+0x64/0x130
> lr : mtk_smi_larb_resume+0x54/0x98
> ...
> Call trace:
>  mtk_smi_larb_config_port_gen2_general+0x64/0x130
>  pm_generic_runtime_resume+0x2c/0x48
>  __genpd_runtime_resume+0x30/0xa8
>  genpd_runtime_resume+0x94/0x2c8
>  __rpm_callback+0x44/0x150
>  rpm_callback+0x6c/0x78
>  rpm_resume+0x310/0x558
>  __pm_runtime_resume+0x3c/0x88
> 
> [...]

Applied, thanks!

[1/1] memory: mtk-smi: Fix a null dereference for the ostd
      commit: 8c5ba21c16bd7f8e23b8740dead6eaf164b8caa0

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
