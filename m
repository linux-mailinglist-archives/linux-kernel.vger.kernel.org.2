Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB72735E221
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 16:59:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346467AbhDMO7D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 10:59:03 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:58510 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345302AbhDMO6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 10:58:51 -0400
Received: from mail-ed1-f70.google.com ([209.85.208.70])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lWKUp-0005Ei-1m
        for linux-kernel@vger.kernel.org; Tue, 13 Apr 2021 14:58:31 +0000
Received: by mail-ed1-f70.google.com with SMTP id f26-20020a056402069ab02903788b40ed89so1411579edy.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 07:58:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ph9+/mYhqHgYa9Fj9YRroZ2f7XAlKgwCaPOsxelpWRE=;
        b=TXPyO1v0jQkk1ZImiQiq9YC9DH9qO2kehs0cj4W8xhjGhUjcYvI060IwyKTb4UBC2E
         ee+oMs9mzJopnnKdQ0TNUGchoKO0W75dLDZGQOwi4sNoRYI5uK+hZe5Okttm9Gr7k3rC
         Ixc680qZRnG3BstwU+0N0TuU9XSBiAtWicqU4pbkGwq9U6wkxlGzg5yIpnDbwHhYhep2
         1a0LYyF48F/BJUG+p9KYPvcb4ul01d76fiXtE6rw9U8QkVvppufwM/8NSCPhpSuNX/V+
         bTB0PCpE0NQ/bebQiQDlDcMABw2AFRJ+oWbS/Qqne9ltdrPawkJ9wy+GkeG9CheAmz1I
         L1gA==
X-Gm-Message-State: AOAM531x46XQP1XTGQC0dXkOclRXK3LnvV6fbvaCQ/sJ8w/+mVQr7VoX
        BfoHNfGPydYe0wTYGQQxBcNiGfslAratD6sFGZb/M5HHeTR9CHvZMd//LF+PdXiGl7UhXqv1HPB
        /0SiwVcSb3BOY46p3T+gjRK8a0rIaDctczsY+rIC/0w==
X-Received: by 2002:a17:906:c7ca:: with SMTP id dc10mr13614390ejb.294.1618325910748;
        Tue, 13 Apr 2021 07:58:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwgRCGqwTKY1uXNFzYOC/YmWaq5iHZG/z/5N5f+QW5qWm9hQs1h7yWI+1JNCO0I2BVghLszFQ==
X-Received: by 2002:a17:906:c7ca:: with SMTP id dc10mr13614363ejb.294.1618325910652;
        Tue, 13 Apr 2021 07:58:30 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-192-147.adslplus.ch. [188.155.192.147])
        by smtp.gmail.com with ESMTPSA id p3sm4395217ejd.65.2021.04.13.07.58.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 07:58:30 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Yong Wu <yong.wu@mediatek.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Tomasz Figa <tfiga@chromium.org>, youlin.pei@mediatek.com,
        acourbot@chromium.org, iommu@lists.linux-foundation.org,
        eizan@chromium.org, linux-mediatek@lists.infradead.org,
        yi.kuo@mediatek.com, anan.sun@mediatek.com, chao.hao@mediatek.com,
        Evan Green <evgreen@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org, srv_heupstream@mediatek.com,
        ming-fan.chen@mediatek.com, linux-kernel@vger.kernel.org,
        Robin Murphy <robin.murphy@arm.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        devicetree@vger.kernel.org
Subject: Re: (subset) [PATCH v5 00/16] Clean up "mediatek,larb"
Date:   Tue, 13 Apr 2021 16:58:24 +0200
Message-Id: <161832589345.71964.1780926932144222450.b4-ty@canonical.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210410091128.31823-1-yong.wu@mediatek.com>
References: <20210410091128.31823-1-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 10 Apr 2021 17:11:12 +0800, Yong Wu wrote:
> MediaTek IOMMU block diagram always like below:
> 
>         M4U
>          |
>     smi-common
>          |
>   -------------
>   |         |  ...
>   |         |
> larb1     larb2
>   |         |
> vdec       venc
> 
> [...]

Applied, thanks!

[04/16] memory: mtk-smi: Add device-link between smi-larb and smi-common
        commit: 6ce2c05b21189eb17b3aa26720cc5841acf9dce8

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
