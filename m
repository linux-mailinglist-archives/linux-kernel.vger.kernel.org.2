Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F05D363E6C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 11:23:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232261AbhDSJYK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 05:24:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238563AbhDSJYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 05:24:05 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FEC3C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 02:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=j1lU31rTZNG6wNmVz3ZQ8tSWhLi5TeccKCKD/Lh4VHs=; b=cDN/SoczlYUPKOizKaUHTQ8DoZ
        RmB0WLXtZenIC2Yw/Efx6BfJ4QVRUr5Yw9WTESbMvTh18v6qu1PwGjmVXMATuCwVMZNhQdeZWj6+I
        XpckIV+t7yrUP+EWu/vGiQgpywJfngs1IrUITMAXAzQrabyLOB9qdGGp7ikTSO3Ok1OBsf1fvrQNr
        Kn9bFPjo2M1TOhDAUMKcoDssTjopgUHoKos8Fua5drsAwX9EWhBigo4wAl9tjF4qJXKfpVJt1OJad
        BYOqBgWNkoLujagE7YNVASkKHX7uhYWvyfij3jLFDQN8RLzz0kSdY171XudPdn4dwZwCuRZbkjP8W
        RIbrD6uQ==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lYQ7p-00DWID-Ms; Mon, 19 Apr 2021 09:23:28 +0000
Date:   Mon, 19 Apr 2021 10:23:25 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Alexander Egorenkov <egorenar-dev@posteo.net>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] lib: scatterlist: Fix SGL length in sg_split() if
 !CONFIG_NEED_SG_DMA_LENGTH
Message-ID: <20210419092325.GA3215674@infradead.org>
References: <20210418081441.5040-1-egorenar-dev@posteo.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210418081441.5040-1-egorenar-dev@posteo.net>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 18, 2021 at 08:14:41AM +0000, Alexander Egorenkov wrote:
> If CONFIG_NEED_SG_DMA_LENGTH is NOT enabled then sg_dma_len() is an alias
> for the length field in a SGL. In that case sg_split() wrongly resets
> the length of split SGLs to zero after it was set correctly before.

Why is this routine messing with sg_dma_address and
sg_dma_lensg_dma_lensg_dma_len at all?  This whole sg_spli() routine
seems rather dangerous because ownership and state of the DMA mapping is
entirely unclear.
