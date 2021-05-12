Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A2A437B6D6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 09:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbhELH15 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 03:27:57 -0400
Received: from verein.lst.de ([213.95.11.211]:40119 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229850AbhELH14 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 03:27:56 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 90F4A67373; Wed, 12 May 2021 09:26:45 +0200 (CEST)
Date:   Wed, 12 May 2021 09:26:45 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Stefano Stabellini <sstabellini@kernel.org>
Cc:     xen-devel@lists.xenproject.org, hch@lst.de,
        linux-kernel@vger.kernel.org,
        Stefano Stabellini <stefano.stabellini@xilinx.com>,
        boris.ostrovsky@oracle.com, jgross@suse.com,
        catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] xen/arm64: do not set SWIOTLB_NO_FORCE when
 swiotlb is required
Message-ID: <20210512072645.GA22396@lst.de>
References: <20210511174142.12742-1-sstabellini@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210511174142.12742-1-sstabellini@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -int xen_swiotlb_detect(void)
> -{
> -	if (!xen_domain())
> -		return 0;
> -	if (xen_feature(XENFEAT_direct_mapped))
> -		return 1;
> -	/* legacy case */
> -	if (!xen_feature(XENFEAT_not_direct_mapped) && xen_initial_domain())
> -		return 1;
> -	return 0;
> -}

I think this move should be a separate prep patch.
