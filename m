Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 453A03D8812
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 08:36:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234740AbhG1Ggx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 02:36:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:35744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233670AbhG1Ggu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 02:36:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0017C601FF;
        Wed, 28 Jul 2021 06:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627454209;
        bh=B7yzPWws1Nr+a7STV8LsMQWwCuXmgiiHdZ1fBi5aN0U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Wc0oYejuDKoIBnlo6w1Ui5Py7pTZ7Mc6Foccozf+q5yxKPIMudVK+lkW8onPloPpK
         d5UyBu0xM4aYhWx4aSwsNSnqqdNAyTlBJUGzhgjhuTKWSVIvgCWo4UVR9ingw2OxTX
         so2emOj7ilxg1SeujRu90+sqyDl87JBXv1JA1YRaGXnRB1Ijx8EMiWawxxRZd0ogJk
         NlcVogyPOQXV3h4WmGawBhguivocCoUka6IC6OGNjTUgxLHn6IBsA0pmNrVxSNLIB7
         lJhCLgcwfjPA0WPRG9bB8g3FKOcN5y0BAmvKX5mZwSZ9KPM3Xk++EGGx/c7R89YhzV
         Beje02gN5jhdg==
Date:   Wed, 28 Jul 2021 12:06:45 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Baokun Li <libaokun1@huawei.com>
Cc:     linux-kernel@vger.kernel.org,
        Zhen Lei <thunder.leizhen@huawei.com>, weiyongjun1@huawei.com,
        yuehaibing@huawei.com, yangjihong1@huawei.com, yukuai3@huawei.com,
        dmaengine@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Hulk Robot <hulkci@huawei.com>
Subject: Re: [PATCH -next v2] dmaengine: fsl-dpaa2-qdma: Use list_move_tail
 instead of list_del/list_add_tail
Message-ID: <YQD6/XvTX/f2b944@matsya>
References: <20210609072802.1368785-1-libaokun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210609072802.1368785-1-libaokun1@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09-06-21, 15:28, Baokun Li wrote:
> Using list_move_tail() instead of list_del() + list_add_tail().

Applied, thanks

-- 
~Vinod
