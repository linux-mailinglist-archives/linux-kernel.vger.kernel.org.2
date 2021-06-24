Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 837E83B393B
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 00:31:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232858AbhFXWdw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 18:33:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbhFXWdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 18:33:46 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D48DC061574;
        Thu, 24 Jun 2021 15:31:27 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id t32so6448518pfg.2;
        Thu, 24 Jun 2021 15:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DWQPDbUhwa8rRro0K+E9CVvkvmIvuF1jMfpVGEdLzHk=;
        b=cEimBbV4fB3GkorwoPsXR6sJ9XYNA7EBWSdUlXRp0ODIKLvfilCFfUTD34qgOcmq8l
         EI5pvOJA4TGZcV/zRWiv82EzjlbVMNgyRqGp0hlE4IJ+WMM25IKdEAB/wUWZGWtZE0Fx
         u70hJCxH1/aw2MKM8NhyjoW5oq1C8Uokcyp4749RZAljV9J8R2tNaaCRvGrF8Te2Wj3K
         pLrVWaEz9HIucQqtPVWAXg5EYabDmZUaL/0zwtfUpg0wMQDyCNJs/4wjfAx2x2mdjf21
         ni+cel4J7N8AYNi5c9ozta19nkFkSnceOwhgsRrv/DlgG3inH1365JeDIKcAEzqdKLIf
         j/lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DWQPDbUhwa8rRro0K+E9CVvkvmIvuF1jMfpVGEdLzHk=;
        b=bkuPaYBECC/ToNAwX/DGevCpsr8O0yfPW6bx+pxvSqksBeTPoLvEQdwvCpP+LVKVv1
         HWKqkvTnWIpP24Obvvbpzng2Cyoertq1qTiJJ8jU3TAM8rX00vhaBBSiCmFUuo1jlpOT
         JdK2DuI/8IgWU31t6g6GtvhK/COAfai2s0DER2VpaWhmunBXR5iySvjKwlRQWA4MkOoN
         aJ5sWogP6es7+rM3f2O6q3qQ53D8kkA7eLDJDxvQ2/BNjos1tcRw4l2jZECw3xDkcArm
         rdvv2NGjC9GjOqCdBsJGqSqrzX+htYwa2Xj6MO5N9mHc7sKNDVOUJArY/Yp0KvX5+v3A
         DCsQ==
X-Gm-Message-State: AOAM531mlRpRUuHNmSEP6Ywh2VSBk8FrWrplLC4HLsduloPCFKUC61M8
        UT28G2raukJbeNS3j0OZ650=
X-Google-Smtp-Source: ABdhPJyhKhVZtl0sOV/phRDbuboJcR9fMCjCH/1uBUgEfqHocs6R6gj8W+AVJV8pnpudLuuJuP7w/g==
X-Received: by 2002:aa7:9808:0:b029:300:7da9:25a6 with SMTP id e8-20020aa798080000b02903007da925a6mr7362112pfl.50.1624573886821;
        Thu, 24 Jun 2021 15:31:26 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id x21sm3688690pfu.211.2021.06.24.15.31.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 15:31:26 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     bcm-kernel-feedback-list@broadcom.com,
        Matthew Hagan <mnhagan88@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 3/3] ARM: dts: NSP: enable DMA on bcm988312hr
Date:   Thu, 24 Jun 2021 15:31:17 -0700
Message-Id: <20210624223117.1315078-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210610203524.2215918-3-mnhagan88@gmail.com>
References: <20210610203524.2215918-1-mnhagan88@gmail.com> <20210610203524.2215918-3-mnhagan88@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Jun 2021 21:35:12 +0100, Matthew Hagan <mnhagan88@gmail.com> wrote:
> The previous patch "ARM: dts: NSP: Disable PL330 by default, add
> dma-coherent property" set the DMAC to disabled by default, requiring it
> to be manually enabled on each device. The bcm988312hr was mistakenly
> omitted. This patch adds it back.
> 
> Signed-off-by: Matthew Hagan <mnhagan88@gmail.com>
> ---

Applied to https://github.com/Broadcom/stblinux/commits/devicetree/next, thanks!
--
Florian
