Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9006035AE54
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 16:29:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234924AbhDJOaA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Apr 2021 10:30:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234920AbhDJO37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Apr 2021 10:29:59 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70939C06138A
        for <linux-kernel@vger.kernel.org>; Sat, 10 Apr 2021 07:29:44 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4FHcpF53B9z9sXH; Sun, 11 Apr 2021 00:29:41 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Cc:     kernel test robot <lkp@intel.com>,
        Anton Blanchard <anton@samba.org>,
        linuxppc-dev@lists.ozlabs.org
In-Reply-To: <20210404192623.10697-1-rdunlap@infradead.org>
References: <20210404192623.10697-1-rdunlap@infradead.org>
Subject: Re: [PATCH v2] powerpc: iommu: fix build when neither PCI or IBMVIO is set
Message-Id: <161806493809.1467223.11225410842334545249.b4-ty@ellerman.id.au>
Date:   Sun, 11 Apr 2021 00:28:58 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 4 Apr 2021 12:26:23 -0700, Randy Dunlap wrote:
> When neither CONFIG_PCI nor CONFIG_IBMVIO is set/enabled, iommu.c has a
> build error. The fault injection code is not useful in that kernel config,
> so make the FAIL_IOMMU option depend on PCI || IBMVIO.
> 
> Prevents this build error (warning escalated to error):
> ../arch/powerpc/kernel/iommu.c:178:30: error: 'fail_iommu_bus_notifier' defined but not used [-Werror=unused-variable]
>   178 | static struct notifier_block fail_iommu_bus_notifier = {

Applied to powerpc/next.

[1/1] powerpc: iommu: fix build when neither PCI or IBMVIO is set
      https://git.kernel.org/powerpc/c/b27dadecdf9102838331b9a0b41ffc1cfe288154

cheers
