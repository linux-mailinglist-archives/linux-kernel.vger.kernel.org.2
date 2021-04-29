Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41BF236EBD5
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 16:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239861AbhD2OD2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 10:03:28 -0400
Received: from ozlabs.org ([203.11.71.1]:39193 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239627AbhD2ODT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 10:03:19 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4FWHJ70nrLz9t1D; Fri, 30 Apr 2021 00:02:30 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Alexey Kardashevskiy <aik@ozlabs.ru>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Leonardo Bras <leobras.c@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <20210318174414.684630-1-leobras.c@gmail.com>
References: <20210318174414.684630-1-leobras.c@gmail.com>
Subject: Re: [PATCH 1/1] powerpc/kernel/iommu: Align size for IOMMU_PAGE_SIZE() to save TCEs
Message-Id: <161970488591.4033873.12136899463811308450.b4-ty@ellerman.id.au>
Date:   Fri, 30 Apr 2021 00:01:25 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Mar 2021 14:44:14 -0300, Leonardo Bras wrote:
> Currently both iommu_alloc_coherent() and iommu_free_coherent() align the
> desired allocation size to PAGE_SIZE, and gets system pages and IOMMU
> mappings (TCEs) for that value.
> 
> When IOMMU_PAGE_SIZE < PAGE_SIZE, this behavior may cause unnecessary
> TCEs to be created for mapping the whole system page.
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/kernel/iommu: Align size for IOMMU_PAGE_SIZE() to save TCEs
      https://git.kernel.org/powerpc/c/3c0468d4451eb6b4f6604370639f163f9637a479

cheers
