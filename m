Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3493E3EC10A
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Aug 2021 09:03:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237167AbhHNHDs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Aug 2021 03:03:48 -0400
Received: from verein.lst.de ([213.95.11.211]:49408 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236519AbhHNHDq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Aug 2021 03:03:46 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 3258767373; Sat, 14 Aug 2021 09:03:16 +0200 (CEST)
Date:   Sat, 14 Aug 2021 09:03:16 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     iommu@lists.linux-foundation.org,
        Russell King <linux@armlinux.org.uk>,
        Brian Cain <bcain@codeaurora.org>
Cc:     linux-hexagon@vger.kernel.org,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Dillon Min <dillon.minfei@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: add support for the global coherent pool to the dma core
Message-ID: <20210814070316.GA20875@lst.de>
References: <20210712061704.4162464-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210712061704.4162464-1-hch@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Any more comments?

Otherwise I'm going to pull this into the dma-mapping tree next week.
