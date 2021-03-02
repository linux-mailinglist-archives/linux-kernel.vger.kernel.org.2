Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A18C832A4E5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 16:58:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236845AbhCBLVu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 06:21:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442053AbhCBLJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 06:09:39 -0500
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F176C061756
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 03:08:58 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4DqZBX4cbBz9sWC;
        Tue,  2 Mar 2021 22:08:48 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1614683333;
        bh=E5E320AMUXuU79/x2LXrgb3lWNabFwBhGvYvTjQ9Vvs=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=GUZczDfrzu40onQa5Kh4fAmQ13WUIlUDpG5ZzfqlGn7006acZH7GjLNrNhUJvviNA
         5O2ff3izXVqXVOC0CEwFG9eQSRN7/Y/Ctmp9VJpuQzLFPGQK9QcQYBLn59yt7lshgP
         Q+ULkGMa7JqvXSQAY/2u0p/XJUCauuC9svJFSiZoP2hVrpHzEQlUbUSXksd1gzJHP6
         QzeOadAnZbsNoKDH/15TDMGR48xwbMNxmSsJ27NzIvluCnav7ECB264ezK6qZ5V3mI
         P28XH8Tgj7MW+Jc1k7X12bSVxO7EAa0jmGNgEXH133q2wbpbYDrMSVGvSqbBc6DoAH
         LDFMnWhf09SrQ==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>,
        linuxppc-dev@lists.ozlabs.org, Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH] powerpc: iommu: fix build when neither PCI or IBMVIO is
 set
In-Reply-To: <20210302082811.8671-1-rdunlap@infradead.org>
References: <20210302082811.8671-1-rdunlap@infradead.org>
Date:   Tue, 02 Mar 2021 22:08:43 +1100
Message-ID: <87lfb5sthg.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Randy Dunlap <rdunlap@infradead.org> writes:
> When neither CONFIG_PCI nor CONFIG_IBMVIO is enabled:
>
> ../arch/powerpc/kernel/iommu.c:178:30: error: 'fail_iommu_bus_notifier' defined but not used [-Werror=unused-variable]
>   178 | static struct notifier_block fail_iommu_bus_notifier = {
>
> If only that struct is bounded by 2 #if defined() phrases (PCI && IBMVIO):
>
> ../arch/powerpc/kernel/iommu.c:162:12: error: 'fail_iommu_bus_notify' defined but not used [-Werror=unused-function]
>   162 | static int fail_iommu_bus_notify(struct notifier_block *nb,
>
> If that function is also guarded by 2 #if defined() phrases:
>
> In file included from ../include/linux/dma-mapping.h:7,
>                  from ../arch/powerpc/kernel/iommu.c:19:
> ../include/linux/device.h:131:26: error: 'dev_attr_fail_iommu' defined but not used [-Werror=unused-variable]
>   131 |  struct device_attribute dev_attr_##_name = __ATTR_RW(_name)
> ../arch/powerpc/kernel/iommu.c:160:8: note: in expansion of macro 'DEVICE_ATTR_RW'
>   160 | static DEVICE_ATTR_RW(fail_iommu);
>
> and the snowball continues to grow.
> Next I got this one:
>
> ../arch/powerpc/kernel/iommu.c: In function 'iommu_range_alloc':
> ../arch/powerpc/kernel/iommu.c:234:6: error: implicit declaration of function 'should_fail_iommu'; did you mean 'should_failslab'? [-Werror=implicit-function-declaration]
>   234 |  if (should_fail_iommu(dev))
>
> and
>
> ../arch/powerpc/kernel/iommu.c: In function 'should_fail_iommu':
> ../arch/powerpc/kernel/iommu.c:122:50: error: 'fail_iommu' undeclared (first use in this function)
>   122 |  return dev->archdata.fail_iommu && should_fail(&fail_iommu, 1);
>
> So combine CONFIG_FAIL_IOMMU && (CONFIG_PCI || CONFIG_IBMVIO)
> to decide on building some of this code/data.

Couldn't we just make FAIL_IOMMU depend on PCI || IBMVIO?

cheers
