Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE8013E0FB1
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 09:54:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237832AbhHEHyY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 03:54:24 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:59716 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231173AbhHEHyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 03:54:23 -0400
X-UUID: 831aadfcca6448ed92316f625e869ed5-20210805
X-UUID: 831aadfcca6448ed92316f625e869ed5-20210805
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <chihhao.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 917629391; Thu, 05 Aug 2021 15:54:07 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs06n2.mediatek.inc (172.21.101.130) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 5 Aug 2021 15:54:05 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 5 Aug 2021 15:54:05 +0800
From:   <chihhao.chen@mediatek.com>
To:     <geraldogabriel@gmail.com>
CC:     <alsa-devel@alsa-project.org>, <chihhao.chen@mediatek.com>,
        <damien@zamaudio.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <matthias.bgg@gmail.com>,
        <tiwai@suse.com>, <tiwai@suse.de>, <wsd_upstream@mediatek.com>
Subject: Re: [PATCH] ALSA: usb-audio: fix incorrect clock source setting
Date:   Thu, 5 Aug 2021 15:54:01 +0800
Message-ID: <20210805075401.21170-1-chihhao.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <CAEsQvctJDnsaRTXAGAJ6==juKazoo2=AJrWabLzqE=jCfg5EEA@mail.gmail.com>
References: <CAEsQvctJDnsaRTXAGAJ6==juKazoo2=AJrWabLzqE=jCfg5EEA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: chihhao chen <chihhao.chen@mediatek.com>

Hi Geraldo Nascimento,

For echo test, it means we use this earphone to receive and play sounds at the same time.
We found in this case serious noise problem happens.

Log as follows with your patch
<6>[  175.960387][T401365] __uac_clock_find_source: Clock Selector 0xc has pin 2 selected
<6>[  175.966980][T401365] __uac_clock_find_source: Clock Selector 0xb has pin 2 selected
<6>[  176.026251][T400354] __uac_clock_find_source: Clock Selector 0xc has pin 1 selected
<6>[  176.032406][T400354] __uac_clock_find_source: Clock Selector 0xb has pin 1 selected

There is no noise and I think this should be a firmware bug.

Thanks
Chihhao

