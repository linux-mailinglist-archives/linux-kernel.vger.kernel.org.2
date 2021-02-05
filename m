Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFA0A310AAC
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 12:54:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231433AbhBELx5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 06:53:57 -0500
Received: from verein.lst.de ([213.95.11.211]:60106 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231961AbhBELuP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 06:50:15 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id C57C167373; Fri,  5 Feb 2021 12:49:29 +0100 (CET)
Date:   Fri, 5 Feb 2021 12:49:29 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Barry Song <song.bao.hua@hisilicon.com>
Cc:     m.szyprowski@samsung.com, hch@lst.de, robin.murphy@arm.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linuxarm@openeuler.org
Subject: Re: [PATCH v3 1/2] dma-mapping: benchmark: use u8 for reserved
 field in uAPI structure
Message-ID: <20210205114929.GA12578@lst.de>
References: <20210205113325.19556-1-song.bao.hua@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210205113325.19556-1-song.bao.hua@hisilicon.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks,

applied.
