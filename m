Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8356340BD53
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 03:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233532AbhIOBuq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 21:50:46 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:58632 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230401AbhIOBup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 21:50:45 -0400
X-UUID: 0bcc3c457ae1430d9735380ce54e8007-20210915
X-UUID: 0bcc3c457ae1430d9735380ce54e8007-20210915
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 546422078; Wed, 15 Sep 2021 09:49:22 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs06n1.mediatek.inc (172.21.101.129) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 15 Sep 2021 09:49:21 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 15 Sep 2021 09:49:21 +0800
Message-ID: <214844bdf9ccb3e37fe2c8815b6c4dfc6ecff253.camel@mediatek.com>
Subject: Re: [PATCH v3 0/4] clk: mediatek: modularize COMMON_CLK_MT6779
From:   Miles Chen <miles.chen@mediatek.com>
To:     Stephen Boyd <sboyd@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>
CC:     Wendell Lin <wendell.lin@mediatek.com>,
        Hanks Chen <hanks.chen@mediatek.com>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>
Date:   Wed, 15 Sep 2021 09:49:21 +0800
In-Reply-To: <163166901247.763609.17762427178197245692@swboyd.mtv.corp.google.com>
References: <20210901222526.31065-1-miles.chen@mediatek.com>
         <163166901247.763609.17762427178197245692@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2021-09-14 at 18:23 -0700, Stephen Boyd wrote:
> Quoting Miles Chen (2021-09-01 15:25:23)
> > This patch set makes COMMON_CLK_MEDIATEK and COMMON_CLK_MT6779*
> > be able to built as kernel modules. Necessary symbols are exported
> > in this patch.
> > 
> 
> The subject says 4 patches but there's really only three.

yes, there should be only 3 patches. sorry for the incorrect "0/4"
cover letter.

Miles

