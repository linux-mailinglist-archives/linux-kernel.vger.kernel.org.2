Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BC654606FC
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Nov 2021 15:52:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357945AbhK1Ozp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Nov 2021 09:55:45 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:36526 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1352701AbhK1Oxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Nov 2021 09:53:44 -0500
X-UUID: ec9b61076a0d4450a92c73cc97b8ee90-20211128
X-UUID: ec9b61076a0d4450a92c73cc97b8ee90-20211128
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <jason-jh.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1340841150; Sun, 28 Nov 2021 22:50:23 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sun, 28 Nov 2021 22:50:22 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sun, 28 Nov 2021 22:50:22 +0800
Message-ID: <1807a4c28ee57aa9c61ccecbc87dae749ae14808.camel@mediatek.com>
Subject: Re: [PATCH 1/3] mialbox: move cmdq suspend,resume and remove after
 cmdq_mbox_flush
From:   Jason-JH Lin <jason-jh.lin@mediatek.com>
To:     Tzung-Bi Shih <tzungbi@google.com>
CC:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Jassi Brar" <jassisinghbrar@gmail.com>,
        David Airlie <airlied@linux.ie>,
        "Daniel Vetter" <daniel@ffwll.ch>,
        <dri-devel@lists.freedesktop.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <hsinyi@chromium.org>,
        <fshao@chromium.org>, <nancy.lin@mediatek.com>,
        <singo.chang@mediatek.com>
Date:   Sun, 28 Nov 2021 22:50:22 +0800
In-Reply-To: <YZXqxaVANvrv53t3@google.com>
References: <20211117064158.27451-1-jason-jh.lin@mediatek.com>
         <20211117064158.27451-2-jason-jh.lin@mediatek.com>
         <YZXqxaVANvrv53t3@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tzung-Bi,

Thanks for the reviews.

On Thu, 2021-11-18 at 13:55 +0800, Tzung-Bi Shih wrote:
> On Wed, Nov 17, 2021 at 02:41:56PM +0800, jason-jh.lin wrote:
> 
> Typo in the commit title "mialbox: move cmdq suspend,resume and
> remove after cmdq_mbox_flush".
> 
> s/mialbox/mailbox/
-- 
I'll fix this typo at the next version.

Regards,
Jason-JH Lin <jason-jh.lin@mediatek.com>

