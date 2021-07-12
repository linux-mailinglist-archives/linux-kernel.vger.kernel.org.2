Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1D103C5ACC
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 13:04:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232004AbhGLKX5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 06:23:57 -0400
Received: from mga18.intel.com ([134.134.136.126]:9365 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229725AbhGLKXz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 06:23:55 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10042"; a="197229058"
X-IronPort-AV: E=Sophos;i="5.84,232,1620716400"; 
   d="scan'208";a="197229058"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2021 03:21:06 -0700
X-IronPort-AV: E=Sophos;i="5.84,232,1620716400"; 
   d="scan'208";a="493361350"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2021 03:21:03 -0700
Received: from andy by smile with local (Exim 4.94.2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1m2t3Z-00BytJ-Gy; Mon, 12 Jul 2021 13:20:57 +0300
Date:   Mon, 12 Jul 2021 13:20:57 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     giovanni.cabiddu@intel.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, tomaszx.kowalik@intel.com,
        marco.chiappero@intel.com, fiona.trahe@intel.com,
        wojciech.ziemba@intel.com, ztong0001@gmail.com,
        qat-linux@intel.com, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 1/3] crypto: qat - Simplify code and axe the use of a
 deprecated API
Message-ID: <YOwXiQP5I+rNXK2O@smile.fi.intel.com>
References: <cover.1625983602.git.christophe.jaillet@wanadoo.fr>
 <7283306389ffa7fe230e2a40f7328f064b872757.1625983602.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7283306389ffa7fe230e2a40f7328f064b872757.1625983602.git.christophe.jaillet@wanadoo.fr>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 11, 2021 at 08:13:18AM +0200, Christophe JAILLET wrote:
> The wrappers in include/linux/pci-dma-compat.h should go away.
> 
> Replace 'pci_set_dma_mask/pci_set_consistent_dma_mask' by an equivalent
> and less verbose 'dma_set_mask_and_coherent()' call.

> If needed, see post from Christoph Hellwig on the kernel-janitors ML:
>    https://marc.info/?l=kernel-janitors&m=158745678307186&w=4

See his another (recent) mail here: https://www.spinics.net/lists/kernel/msg3967232.html...

> +	if (dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64))) {

> +		if ((dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32)))) {

...and drop this part from all entries completely.

> +	if (dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64))) {
> +		if ((dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32)))) {

> +	if (dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64))) {
> +		if ((dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32)))) {

> +	if (dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64))) {
> +		if ((dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32)))) {

> +	if (dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64))) {
> +		if ((dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32)))) {

> +	if (dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64))) {
> +		if ((dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32)))) {

> +	if (dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64))) {
> +		if ((dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32)))) {

-- 
With Best Regards,
Andy Shevchenko


