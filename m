Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8425360AF2
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 15:47:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233105AbhDONrC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 09:47:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232332AbhDONqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 09:46:53 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C213CC061574;
        Thu, 15 Apr 2021 06:46:30 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 6AFA0387; Thu, 15 Apr 2021 15:46:29 +0200 (CEST)
Date:   Thu, 15 Apr 2021 15:46:27 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     dwmw2@infradead.org, baolu.lu@linux.intel.com, will@kernel.org,
        kyung.min.park@intel.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] iommu/vt-d: Fix an error handling path in
 'intel_prepare_irq_remapping()'
Message-ID: <YHhDs/PTP9u1DD+F@8bytes.org>
References: <98d531caabe66012b4fffc7813fd4b9470afd517.1618124777.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <98d531caabe66012b4fffc7813fd4b9470afd517.1618124777.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 11, 2021 at 09:08:17AM +0200, Christophe JAILLET wrote:
>  drivers/iommu/intel/irq_remapping.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.
