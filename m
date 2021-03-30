Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C8B534EA5C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 16:25:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231950AbhC3OZR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 10:25:17 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:54790 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231882AbhC3OYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 10:24:49 -0400
X-UUID: 36093d43e0884872946b8d49f557ef4a-20210330
X-UUID: 36093d43e0884872946b8d49f557ef4a-20210330
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <lecopzer.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 275825953; Tue, 30 Mar 2021 22:24:47 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 30 Mar 2021 22:24:39 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 30 Mar 2021 22:24:40 +0800
From:   Lecopzer Chen <lecopzer.chen@mediatek.com>
To:     <maz@kernel.org>
CC:     <julien.thierry.kdev@gmail.com>, <lecopzer.chen@mediatek.com>,
        <lecopzer@gmail.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <lorenzo.pieralisi@arm.com>,
        <tglx@linutronix.de>, <yj.chiang@mediatek.com>
Subject: Re: [PATCH] irqchip/gic-v3: Fix IPRIORITYR can't perform byte operations in GIC-600
Date:   Tue, 30 Mar 2021 22:24:40 +0800
Message-ID: <20210330142440.30119-1-lecopzer.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <87eefwrash.wl-maz@kernel.org>
References: <87eefwrash.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[...]
> > > > 
> > > > From the architecture spec:
> > > > 
> > > > <quote>
> > > > 11.1.3 GIC memory-mapped register access
> > > > 
> > > > In any system, access to the following registers must be supported:
> > > > 
> > > > [...]
> > > > * Byte accesses to:
> > > > 	- GICD_IPRIORITYR<n>.
> > > > 	- GICD_ITARGETSR<n>.
> > > > 	- GICD_SPENDSGIR<n>.
> > > > 	- GICD_CPENDSGIR<n>.
> > > > 	- GICR_IPRIORITYR<n>.
> > > > </quote>
> > > > 
> > > > So if GIC600 doesn't follow this architectural requirement, this is a
> > > > HW erratum, and I want an actual description of the HW issue together
> > > > with an erratum number.
> > > > 
> > > > Lorenzo, can you please investigate on your side?
> > > 
> > > Sure - I will look into it and report back.
> > 
> > Checked - I don't think this patch is needed so it should be dropped and
> > a follow-up discussion can continue in the relevant/appropriate forum -
> > if there is anything left to discuss.
> 
> Thanks for having had a look. This really smells like an integration
> issue rather than an actual GIC bug.
> 
> Lecopzer, please check with your HW people and potentially ARM, as I
> think you are looking at the wrong problem.

Thanks a lot for the suggestion and checking,

I think I'll back to disscuss with ARM and our HW team to figure out
the previous answer from ARM Support in detail.

Thanks again!


Lecopzer
