Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5139230C236
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 15:45:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234662AbhBBOog (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 09:44:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234797AbhBBOmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 09:42:11 -0500
X-Greylist: delayed 2295 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 02 Feb 2021 06:41:30 PST
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 554EBC06174A;
        Tue,  2 Feb 2021 06:41:30 -0800 (PST)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 847AF3D4; Tue,  2 Feb 2021 15:41:28 +0100 (CET)
Date:   Tue, 2 Feb 2021 15:41:27 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Chunyan Zhang <zhang.lyra@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Sheng Xu <sheng.xu@unisoc.com>,
        iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>
Subject: Re: [PATCH 2/2] iommu: add Unisoc iommu basic driver
Message-ID: <20210202144126.GC32671@8bytes.org>
References: <20210202073258.559443-3-zhang.lyra@gmail.com>
 <20210202104257.736836-1-zhang.lyra@gmail.com>
 <20210202140101.GA32671@8bytes.org>
 <992fad43-c457-d809-3bd7-7fd5b6e8fa22@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <992fad43-c457-d809-3bd7-7fd5b6e8fa22@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 02, 2021 at 02:34:34PM +0000, Robin Murphy wrote:
> Nope, I believe if Arm Ltd. had any involvement in this I'd know about it :)

Okay, got confused by thinking of ARM as the CPU architecture, not the
company :)
But given the intel/ and amd/ subdirectories refer to company names as
well, the same is true for arm/.

Regards,

	Joerg
