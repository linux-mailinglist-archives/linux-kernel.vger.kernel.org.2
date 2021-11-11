Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9111244D284
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 08:33:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbhKKHgX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 02:36:23 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:60714 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229533AbhKKHgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 02:36:21 -0500
X-UUID: a9bda5ee136f42ab8225119f601b11dc-20211111
X-UUID: a9bda5ee136f42ab8225119f601b11dc-20211111
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <mark-pk.tsai@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1598580129; Thu, 11 Nov 2021 15:33:31 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Thu, 11 Nov 2021 15:33:30 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs10n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Thu, 11 Nov 2021 15:33:30 +0800
From:   Mark-PK Tsai <mark-pk.tsai@mediatek.com>
To:     <rppt@kernel.org>
CC:     <akpm@linux-foundation.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux@armlinux.org.uk>, <rppt@linux.ibm.com>, <tony@atomide.com>,
        <wangkefeng.wang@huawei.com>, <mark-pk.tsai@mediatek.com>,
        <yj.chiang@mediatek.com>
Subject: Re: [PATCH v3 0/4] memblock, arm: fixes for freeing of the memory map
Date:   Thu, 11 Nov 2021 15:33:29 +0800
Message-ID: <20211111073329.13095-1-mark-pk.tsai@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210630071211.21011-1-rppt@kernel.org>
References: <20210630071211.21011-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The lts kernel also have this issue. (we use 5.4-lts kernel.)
Currently we patch our custom kernel to select CONFIG_HOLES_IN_ZONE for arch arm.
But I think the formal solution should backport to lts.

Would you help to backport this patch series? (including the below commit)

(024591f9a6e0 arm: ioremap: don't abuse pfn_valid() to check if pfn is in RAM)

Thanks!
