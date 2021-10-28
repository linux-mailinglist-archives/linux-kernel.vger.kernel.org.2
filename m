Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E30243DADB
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 07:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbhJ1FwU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 01:52:20 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:60282 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229689AbhJ1FwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 01:52:18 -0400
X-UUID: 0500a93a3b824aa4914b4f2b68f923ac-20211028
X-UUID: 0500a93a3b824aa4914b4f2b68f923ac-20211028
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <mark-pk.tsai@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1976393245; Thu, 28 Oct 2021 13:49:47 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Thu, 28 Oct 2021 13:49:46 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs10n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Thu, 28 Oct 2021 13:49:46 +0800
From:   Mark-PK Tsai <mark-pk.tsai@mediatek.com>
To:     <hch@infradead.org>
CC:     <agk@redhat.com>, <dm-devel@redhat.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <mark-pk.tsai@mediatek.com>,
        <matthias.bgg@gmail.com>, <snitzer@redhat.com>,
        <tequila.huang@mediatek.com>, <yj.chiang@mediatek.com>
Subject: Re: [PATCH] dm: add module parameter bdev_wait
Date:   Thu, 28 Oct 2021 13:49:46 +0800
Message-ID: <20211028054946.1524-1-mark-pk.tsai@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <YXj37wXtN0wQqwZx@infradead.org>
References: <YXj37wXtN0wQqwZx@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > dm_early_create() fail if the target block device not found in
> > the late init stage.
> > The block device is created in mmc_rescan() which kernel do
> > it async by queue it into system_freezable_wq.
> > Add module param bdev_wait to support waiting the block device
> > ready before dm_early_create() like prepare_namespace() does.
>
> This adds a busy loop.  There is a reason why we usually set up
> stacking drivers from userspace, in that we have a working event
> system there.  So the answer is not to add further hacks to the
> in-kernel DM setup hack, but to stop using it.

Thanks for your kind reply.
But We want to use DM target as root device without adding an initramfs.
Is there any other way to do so?
