Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E2B134E2B8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 10:07:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231424AbhC3IGe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 04:06:34 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:37512 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231301AbhC3IG2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 04:06:28 -0400
X-UUID: 919b34e3c4c6490ca2e2fc9341e452c8-20210330
X-UUID: 919b34e3c4c6490ca2e2fc9341e452c8-20210330
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <lecopzer.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 334879961; Tue, 30 Mar 2021 16:06:17 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 30 Mar 2021 16:06:15 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 30 Mar 2021 16:06:15 +0800
From:   Lecopzer Chen <lecopzer.chen@mediatek.com>
To:     <sumit.garg@linaro.org>
CC:     <alexandru.elisei@arm.com>, <catalin.marinas@arm.com>,
        <daniel.thompson@linaro.org>, <dianders@chromium.org>,
        <lecopzer.chen@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <mark.rutland@arm.com>,
        <swboyd@chromium.org>, <will@kernel.org>, <yj.chiang@mediatek.com>,
        <lecopzer@gmail.com>
Subject: Re: [PATCH v5] arm64: Enable perf events based hard lockup detector
Date:   Tue, 30 Mar 2021 16:06:15 +0800
Message-ID: <20210330080615.21938-1-lecopzer.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <CAFA6WYOL3m6UspT1QG8_DAEFpGxtX=7aT_zTAdntmuUCcBvg5A@mail.gmail.com>
References: <CAFA6WYOL3m6UspT1QG8_DAEFpGxtX=7aT_zTAdntmuUCcBvg5A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi Will, Mark,
> 
> On Fri, 15 Jan 2021 at 17:32, Sumit Garg <sumit.garg@linaro.org> wrote:
> >
> > With the recent feature added to enable perf events to use pseudo NMIs
> > as interrupts on platforms which support GICv3 or later, its now been
> > possible to enable hard lockup detector (or NMI watchdog) on arm64
> > platforms. So enable corresponding support.
> >
> > One thing to note here is that normally lockup detector is initialized
> > just after the early initcalls but PMU on arm64 comes up much later as
> > device_initcall(). So we need to re-initialize lockup detection once
> > PMU has been initialized.
> >
> > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > ---
> >
> > Changes in v5:
> > - Fix lockup_detector_init() invocation to be rather invoked from CPU
> >   binded context as it makes heavy use of per-cpu variables and shouldn't
> >   be invoked from preemptible context.
> >
> 
> Do you have any further comments on this?
> 
> Lecopzer,
> 
> Does this feature work fine for you now?

This really fixes the warning, I have a real hardware for testing this now.
but do we need to call lockup_detector_init() for each cpu?

In init/main.c, it's only called by cpu 0 for once.


BRs,
Lecopzer
