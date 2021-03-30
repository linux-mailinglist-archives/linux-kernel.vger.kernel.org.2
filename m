Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDFEB34E32C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 10:33:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231460AbhC3Icg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 04:32:36 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:54633 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231330AbhC3IcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 04:32:24 -0400
X-UUID: 159807769e2143cc819d2f8001608f85-20210330
X-UUID: 159807769e2143cc819d2f8001608f85-20210330
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <lecopzer.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 615337140; Tue, 30 Mar 2021 16:32:19 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 30 Mar 2021 16:32:18 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 30 Mar 2021 16:32:17 +0800
From:   Lecopzer Chen <lecopzer.chen@mediatek.com>
To:     <lecopzer.chen@mediatek.com>
CC:     <alexandru.elisei@arm.com>, <catalin.marinas@arm.com>,
        <daniel.thompson@linaro.org>, <dianders@chromium.org>,
        <lecopzer@gmail.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <mark.rutland@arm.com>,
        <sumit.garg@linaro.org>, <swboyd@chromium.org>, <will@kernel.org>,
        <yj.chiang@mediatek.com>
Subject: Re: [PATCH v5] arm64: Enable perf events based hard lockup detector
Date:   Tue, 30 Mar 2021 16:32:18 +0800
Message-ID: <20210330083218.22285-1-lecopzer.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210330080615.21938-1-lecopzer.chen@mediatek.com>
References: <20210330080615.21938-1-lecopzer.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > Hi Will, Mark,
> > 
> > On Fri, 15 Jan 2021 at 17:32, Sumit Garg <sumit.garg@linaro.org> wrote:
> > >
> > > With the recent feature added to enable perf events to use pseudo NMIs
> > > as interrupts on platforms which support GICv3 or later, its now been
> > > possible to enable hard lockup detector (or NMI watchdog) on arm64
> > > platforms. So enable corresponding support.
> > >
> > > One thing to note here is that normally lockup detector is initialized
> > > just after the early initcalls but PMU on arm64 comes up much later as
> > > device_initcall(). So we need to re-initialize lockup detection once
> > > PMU has been initialized.
> > >
> > > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > > ---
> > >
> > > Changes in v5:
> > > - Fix lockup_detector_init() invocation to be rather invoked from CPU
> > >   binded context as it makes heavy use of per-cpu variables and shouldn't
> > >   be invoked from preemptible context.
> > >
> > 
> > Do you have any further comments on this?
> > 
> > Lecopzer,
> > 
> > Does this feature work fine for you now?
> 
> This really fixes the warning, I have a real hardware for testing this now.
> but do we need to call lockup_detector_init() for each cpu?
> 
> In init/main.c, it's only called by cpu 0 for once.
 
Oh sorry, I just misread the code, please ignore previous mail.
 

BRs,
Lecopzer
