Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C18F460702
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Nov 2021 15:55:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357966AbhK1O6Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Nov 2021 09:58:16 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:60064 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1358029AbhK1O4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Nov 2021 09:56:15 -0500
X-UUID: 115950d5e86a458383c4f8726f1ca184-20211128
X-UUID: 115950d5e86a458383c4f8726f1ca184-20211128
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <jason-jh.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 259558279; Sun, 28 Nov 2021 22:52:56 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sun, 28 Nov 2021 22:52:55 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sun, 28 Nov 2021 22:52:55 +0800
Message-ID: <b6c55b2374e69aa198b2dd934b318767bd6e2b3e.camel@mediatek.com>
Subject: Re: Fix drm suspend and resume issue
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
Date:   Sun, 28 Nov 2021 22:52:54 +0800
In-Reply-To: <YZXqrxinyBZkBgfq@google.com>
References: <20211117064158.27451-1-jason-jh.lin@mediatek.com>
         <YZXqrxinyBZkBgfq@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tzung-Bi,

Thanks, I'll fix it.

On Thu, 2021-11-18 at 13:54 +0800, Tzung-Bi Shih wrote:
> On Wed, Nov 17, 2021 at 02:41:55PM +0800, jason-jh.lin wrote:
> > Subject: [PATCH 0/3] Fix drm suspend and resume issue
> 
> You have 2 Subjects.  The first one takes precedence.
-- 
Regards,
Jason-JH Lin <jason-jh.lin@mediatek.com>

