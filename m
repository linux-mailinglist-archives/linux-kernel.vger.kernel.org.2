Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A8EA36D41B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 10:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237741AbhD1InF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 04:43:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237685AbhD1InA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 04:43:00 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F68DC061574
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 01:42:14 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id q9so7957435wrs.6
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 01:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=R50Avg3KJsdo4BeRwGLPiE4UlIIB3LgXMqGrn5lll8k=;
        b=ETU7dwygJgj5eDXnQ6pfi8iUFUTNPKNdnHUTtW+jULXAx/Vdo49mFXvIn2v2R27hXv
         iVliB+NYWvwxC1riBHhTYfZGSQH5pFCt0sDbhBevXrXj1qMygABOrewfJeH3HJmKjITx
         kr6IWY90hpyzQJKzOWVN+mWmrAsdU6U2clfBH944wiv4iI26p71EPmfladdeU5xSOHAf
         w9bImLnUiI4uk8bn6id3EkJRvEXYNGNz/i6zUJTnLQSRn/To+XmsWNttfrmwksHbczAr
         Ka6AO646FVNH74yu8brS8CPnOwmEVudbsFVfHVQ6KjhBd+hnN3Y5IA5rJsrc78PzGdmw
         13Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=R50Avg3KJsdo4BeRwGLPiE4UlIIB3LgXMqGrn5lll8k=;
        b=n7pITc9JiQSuLczpVRtQf6stcRz/piKZ8Mt3YXKiwL6RdpqA8kw94FFbS0N2sEM0RH
         qQLjQGArQ2tu5Pln+QeNuWKHaqUl+Gm6luAEs8CwchDsY8l2Qe4k4njJu9rIT3XQ9JrY
         C5VjRTk1h0NmVUo+muFfDMP5i7qGDeafRd22yLMiH4D8M//neKVY6zvUNpXTROg4I8tS
         E5lxt6uPZu9qQJby4gObblACkYsIOOnHFqXJl3bgxvx8qnJJT8s7qamQovVGap0FkSOV
         LgkgAOLwGKQAxAIoia5sLmp/Da3mrz4/ftxanJWVpo6FxcPilk2EWvzOFYLA6A2yjbyL
         Z33w==
X-Gm-Message-State: AOAM5323vjf8HniGu7NzL1QXvChKkFmO/peCjHrF7YrULCF/p8yMsHFA
        rDj5Fcco5NVnDx9RfXxmVjh2MgKZcLM=
X-Google-Smtp-Source: ABdhPJxyMuEQ/b0cIHA6rqLYR8WTArZrojG0HcGnlGJDBGromikyk+lksY1h4wbGUdDs9xgikh0eWw==
X-Received: by 2002:adf:efca:: with SMTP id i10mr34201311wrp.316.1619599333415;
        Wed, 28 Apr 2021 01:42:13 -0700 (PDT)
Received: from Red ([2a01:cb1d:3d5:a100:264b:feff:fe03:2806])
        by smtp.googlemail.com with ESMTPSA id q7sm7313479wrr.62.2021.04.28.01.42.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Apr 2021 01:42:13 -0700 (PDT)
Date:   Wed, 28 Apr 2021 10:42:11 +0200
From:   Corentin Labbe <clabbe.montjoie@gmail.com>
To:     hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com,
        iommu@lists.linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: DMA mapping fill dma_address to 0
Message-ID: <YIkf4yqt14dGPoyr@Red>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

I work on the crypto offloader driver of cortina/gemini SL3516 SoC.
I test it by filling a LUKS2 partition.
I got a reproductible problem when handling skcipher requests.
I use dma_map_sg() and when iterating other the result, sg_dma_address(sg) return 0.
But sg_dma_len(sg) is still correct (4096 in my case).

Below is a simplified view of my code:
nr_sgs = dma_map_sg(ce->dev, areq->src, sg_nents(areq->src), DMA_TO_DEVICE);
(nr_sgs = 1 in my case)
sg = areq->src;
if (!sg_dma_address(sg))
	FAIL

I have digged to find what do dma_map_sg() and I have added some debug.
sg_page(sg) return c7efb000 for example so sg_page() works.
But it seems the problem is that page_to_phys(sg_page(sg)) return 0.

This problem does not appear immediatly, luksOpen and subsequent fsck always work.
But it appears fast after, when mouting or rsync files in it.

I have added CONFIG_DEBUG_SG, CONFIG_DMA_API_DEBUG, CONFIG_DMA_API_DEBUG_SG but they didnt bringed any more hints.
Only "DMA-API: cacheline tracking ENOMEM, dma-debug disabled" appears but always with some "time" between my problem and its display.
So I am not sure it is related.

Regards
