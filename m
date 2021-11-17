Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 483FD45449F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 11:05:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233163AbhKQKID (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 05:08:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231603AbhKQKID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 05:08:03 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E56E0C061570
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 02:05:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9xc3t/i++I6ZSvgabyN8b1xNPjuadKnTYzFKCHa2W98=; b=kDQL48/1Or/EEQ7xgm6UWU9cIT
        oZf7XWgbuA2H59eFP5qbPJYEc55FK96oxCfwkF9ocigyZVRvOjLXG/aYyqzwsF7XVaLiElhFF03yZ
        mnCRLTMoSqiph7YZzvnGzQiS4KuH6nRjDmKJIUARK8FTx6yCytI8JbDvS7ru7qpdQdczadcfkhpeB
        BAANC4jrLTMFowrXL15LjELzMrfKogiQxGHlo3DWDAo5eRlpZDfiixQxYAPiRMNW3Dp4LhWkyVSsP
        PQhgvPkPZcJeRTWIRPWDuezeU32/gtF0YNDZcE76BWJ03cIM7FM5oQcpn5G8EIw/skWRe3a54G5bB
        wkO+F60A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mnHoG-004OST-KF; Wed, 17 Nov 2021 10:04:56 +0000
Date:   Wed, 17 Nov 2021 02:04:56 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Georgi Djakov <quic_c_gdjako@quicinc.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, robdclark@gmail.com,
        arnd@arndb.de, sean@poorly.run, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org, maz@kernel.org,
        robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC 1/2] arm64: Add support for system cache memory type
Message-ID: <YZTTyErX4bb+dlEV@infradead.org>
References: <1637104560-37432-1-git-send-email-quic_c_gdjako@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1637104560-37432-1-git-send-email-quic_c_gdjako@quicinc.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 16, 2021 at 03:15:59PM -0800, Georgi Djakov wrote:
>  include/linux/dma-map-ops.h      | 8 ++++++++

Your forgot to CC the maintainer.  Also don't try to ever hide DMA
core changes in arch specific patches ever again.
