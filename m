Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 273DE3AAF2E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 10:55:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231282AbhFQI6C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 04:58:02 -0400
Received: from ni.piap.pl ([195.187.100.5]:36612 "EHLO ni.piap.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231322AbhFQI55 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 04:57:57 -0400
Received: from t19.piap.pl (OSB1819.piap.pl [10.0.9.19])
        (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ni.piap.pl (Postfix) with ESMTPSA id BDD502628EE;
        Thu, 17 Jun 2021 10:55:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 ni.piap.pl BDD502628EE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=piap.pl; s=mail;
        t=1623920144; bh=G7D/+tPgAkXdXC9aKin1+br+jDGDhtEM7t8TN0pXahU=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=jINX8/Vi3JKUU4kjkq+whJ/Kpbmc0IlmxuD3nxuNam6L2j/r80aL6fXWVM9kg85a7
         +BGUYEKnBUc4Ort6J7QPN6mWz2E3CRffuey/8ZMuJ36AZBZaPYlEfxanONNSBuqRMN
         k18qiVUpahs4HIZoWkFoCAKPy/iY2aZ0HCMhi68w=
From:   =?utf-8?Q?Krzysztof_Ha=C5=82asa?= <khalasa@piap.pl>
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>, x86@kernel.org,
        Dave Hansen <dave.hansen@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        linux-arm-kernel@lists.infradead.org, Will Deacon <will@kernel.org>
Subject: Re: [PATCH 7/8] membarrier: Remove arm (32) support for SYNC_CORE
References: <2142129092ff9aa00e600c42a26c4015b7f5ceec.1623813516.git.luto@kernel.org>
        <YMnPezLs6vb418Wz@hirez.programming.kicks-ass.net>
        <YMnQVoKvM5G34Yan@hirez.programming.kicks-ass.net>
        <20210616103446.GC22278@shell.armlinux.org.uk>
        <YMncQv1uT5QyQ84w@hirez.programming.kicks-ass.net>
        <20210616132226.GD22278@shell.armlinux.org.uk>
        <20210616150456.GC22433@arm.com>
        <20210616152326.GG22278@shell.armlinux.org.uk>
        <20210616154529.GD22433@arm.com> <20210616160050.GE22433@arm.com>
        <20210616162716.GH22278@shell.armlinux.org.uk>
Sender: khalasa@piap.pl
Date:   Thu, 17 Jun 2021 10:55:43 +0200
In-Reply-To: <20210616162716.GH22278@shell.armlinux.org.uk> (Russell King's
        message of "Wed, 16 Jun 2021 17:27:16 +0100")
Message-ID: <m3fsxg7tv4.fsf@t19.piap.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-KLMS-Rule-ID: 4
X-KLMS-Message-Action: skipped
X-KLMS-AntiSpam-Status: not scanned, whitelist
X-KLMS-AntiPhishing: not scanned, whitelist
X-KLMS-AntiVirus: Kaspersky Security for Linux Mail Server, version 8.0.3.30, not scanned, whitelist
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Russell King (Oracle)" <linux@armlinux.org.uk> writes:

> So it seems to come down to a question about CNS3xxx and OXNAS. If
> these aren't being used, maybe we can drop ARM11MPCore support and
> the associated platforms?

Well, it appears we haven't updated software on our Gateworks Lagunas
(CNS3xxx dual core) for 4 years. This is old stuff, pre-DTB and all. We
have replacement setups (i.MX6 + mPCIe to mPCI bridge) which we don't
use either (due to lack of interest in mPCI - the old parallel, not the
express).

I don't have a problem with the CNS3xxx being dropped. In fact, we don't
use anything (ARM) older than v7 here.

Chris.

--=20
Krzysztof Ha=C5=82asa

Sie=C4=87 Badawcza =C5=81ukasiewicz
Przemys=C5=82owy Instytut Automatyki i Pomiar=C3=B3w PIAP
Al. Jerozolimskie 202, 02-486 Warszawa
