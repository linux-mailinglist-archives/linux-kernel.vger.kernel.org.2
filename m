Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B152C36EBD6
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 16:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239903AbhD2ODa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 10:03:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239611AbhD2ODZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 10:03:25 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66278C06138B
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 07:02:39 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4FWHJ85c88z9sXL; Fri, 30 Apr 2021 00:02:32 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Alexey Kardashevskiy <aik@ozlabs.ru>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Leonardo Bras <leobras.c@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <20210318174414.684630-2-leobras.c@gmail.com>
References: <20210318174414.684630-1-leobras.c@gmail.com> <20210318174414.684630-2-leobras.c@gmail.com>
Subject: Re: [PATCH 1/1] powerpc/kernel/iommu: Use largepool as a last resort when !largealloc
Message-Id: <161970488610.4033873.6555670052413265008.b4-ty@ellerman.id.au>
Date:   Fri, 30 Apr 2021 00:01:26 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Mar 2021 14:44:17 -0300, Leonardo Bras wrote:
> As of today, doing iommu_range_alloc() only for !largealloc (npages <= 15)
> will only be able to use 3/4 of the available pages, given pages on
> largepool  not being available for !largealloc.
> 
> This could mean some drivers not being able to fully use all the available
> pages for the DMA window.
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/kernel/iommu: Use largepool as a last resort when !largealloc
      https://git.kernel.org/powerpc/c/fc5590fd56c9608f317729b59a56dad2a75d633f

cheers
