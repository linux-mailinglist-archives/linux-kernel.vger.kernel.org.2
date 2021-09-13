Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF95D40843C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 07:56:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237132AbhIMF5A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 01:57:00 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:52842 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S237095AbhIMF46 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 01:56:58 -0400
X-UUID: a04d09bb2c8a4bf0aef64581cadeaee6-20210913
X-UUID: a04d09bb2c8a4bf0aef64581cadeaee6-20210913
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <trevor.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1343577215; Mon, 13 Sep 2021 13:55:40 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs06n2.mediatek.inc (172.21.101.130) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 13 Sep 2021 13:55:38 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 13 Sep 2021 13:55:38 +0800
Message-ID: <5fa1e99f1b9097336a3e610dc383170f09036b14.camel@mediatek.com>
Subject: Re: [PATCH v2] ASoC: mediatek: common: handle NULL case in
 suspend/resume function
From:   Trevor Wu <trevor.wu@mediatek.com>
To:     Mark Brown <broonie@kernel.org>
CC:     <tiwai@suse.com>, <matthias.bgg@gmail.com>,
        <alsa-devel@alsa-project.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <dan.carpenter@oracle.com>
Date:   Mon, 13 Sep 2021 13:55:38 +0800
In-Reply-To: <20210910102358.GC4474@sirena.org.uk>
References: <20210910092613.30188-1-trevor.wu@mediatek.com>
         <20210910102358.GC4474@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2021-09-10 at 11:23 +0100, Mark Brown wrote:
> On Fri, Sep 10, 2021 at 05:26:13PM +0800, Trevor Wu wrote:
> 
> > When memory allocation for afe->reg_back_up fails, reg_back_up
> > can't
> > be used.
> > Keep the suspend/resume flow but skip register backup when
> > afe->reg_back_up is NULL, in case illegal memory access happens.
> 
> It seems like it'd be better to just allocate the buffer at probe
> time
> and fail in case we can't get it, I'd be surprised if there's many
> platforms using this hardware that don't also end up suspending and
> resuming.

Hi Mark,

Thanks for your suggestion.
I agree it's better to allocate the memory at probe time.
I think we can still keep the implementation in the suspend/resume
function as a fallback solution if user doesn't allocate the memory in
probe function.

In the new mediatek SOCs, regcache has been used to handle register
backup.
Do I need to add the buffer allocation on probe function to the
platform in which mtk_afe_suspend and mtk_afe_resume are used?

Thanks,
Trevor

