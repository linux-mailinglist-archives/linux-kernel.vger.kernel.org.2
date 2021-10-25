Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E37BF438F90
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 08:36:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231282AbhJYGjB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 02:39:01 -0400
Received: from mout.gmx.net ([212.227.15.18]:60877 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229823AbhJYGjA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 02:39:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1635143755;
        bh=KJXhuueJqnOfRbIAJbxY2hjIWqMEw3+yFWTcl9cZOkc=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=QGgyuqfw5dGa5MMaT3SGpycw4t9fpWzx66/CFX6Ak9QaB0ey6Y8Xy1ZzK+aUZZ1e+
         GOeTXVJ3O6agOk2+J4rI0q+LkhnGNCBBJOSO45ZsW6PgzWXHRGmgs+yjfqYaPaScEQ
         nO/piEj4z4Imc7qS+O2nepYkOc/KTFdLL16m8g6c=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.191.219.76]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N8XTv-1mjeqA0HNR-014WBN; Mon, 25
 Oct 2021 08:35:55 +0200
Message-ID: <496d495b290ac69fed75d02ab5915a7871243321.camel@gmx.de>
Subject: Re: [PATCH 1/2] sched/fair: Couple wakee flips with heavy wakers
From:   Mike Galbraith <efault@gmx.de>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Mon, 25 Oct 2021 08:35:52 +0200
In-Reply-To: <20211022110534.GJ3959@techsingularity.net>
References: <20211021145603.5313-1-mgorman@techsingularity.net>
         <20211021145603.5313-2-mgorman@techsingularity.net>
         <37d8c167df66a1ead16b699115548ca376494c0c.camel@gmx.de>
         <20211022110534.GJ3959@techsingularity.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.0 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:eLdlAhvXPFyothxswJqCutsqhbskwGQYNYcBMuGwdWdd7Th++ZS
 r2yQBuitSiWAdk595pBuTl2P9MKnV/3pwKhFdUYfgL+hEA8YOXTPm6dySBDytaUoadH3U+s
 GoM17zHEBT0mOVKW+qIMQn/9KPmiOo+akxysR4rbvgMgr0PJGiwzVbwD0ULSWG2h+BLQbum
 lr3n5/A7c8F1hoWNWF8tQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:NaHJ9JeH1Vw=:G1Mcm1UZQ4wv32y2F1uCjB
 +VCB72spIJATb7S0eL+UPvo4Og++4zbHFJvm9/EQ1v2Wbm+R3w6IFAkN014Q678wIm4Pv5uTE
 g8xnokz2v44aA1DR4AgV2IF8SyvR4k7EviGCkCvXV66pLzC7ovIE60M/5dkqcae1FLcf6IcaJ
 ws1pdQb13xGmWc1bXRExsOZBPbNYSbLSROAY04hX95elL98puKU+kKeklhm6NIq8I1YW+vP7E
 Bf953eTSeMh/vDpIYV5a4+4JiLEdZG0oPlrGUTRPnlG6JoRdR5nof7w6aBd7xEpkEqGYMSuaW
 QQBlXj58cJZuOhsymPCoFkPtLPQaA350MyrFh67oF/OFdD9FOmKR9IG+S2YsdXTC/7Fj22ytS
 eC+IZrkdE4MaWWUGSTnPxOwFP2Ils/d9YNyk+Gvqn1dAeIdI8CbZRr51OUuUdI0S2O51zrKJL
 bLNkzWw1JFIc9gfqhSC1A2hSaUWWpV50MsnnXlR2lRwMR2NeKKZHZVGlDLo1XiSo4yHDlkQ89
 +I16quLd+Ocvch+bQjGUaewSl5OKf/G18hO65EfRnOgBSIM5zVElHZGAI7MrAH72QFDyVC+8C
 Fm63Xu4b9BBHJklCULHUHSFmDkhdJJgONqOHGotrh0VgtxtAuAYPvOX0sqKCF8mdIKaZ0OMck
 c6SaROHp71JDpVELvIjDw0OFlkDRq6GQ5W9hAh0sgPRzA8XiXSh6eCgE5p//eSxfBQ9J0zJ8r
 b8S4BrtAUr9gYvRc8EdIAbAzM3cAkAxYrrNXRC2YqFvb10wS27f1wvnJD+NoKlahURoBMOBBP
 zQBvJl5v6mINlPHS2njd81h9B1GZtggNEogpBlsBprPmqCeQ+RYsPFWLicKDEitk5r9zQszfw
 iGoFbefk6VV/w6RhkDhJ2zEFudHy/CYqZ/reN/zWxXOVpLFP8UFeSswqD5NWQGb1rZsdFGYXa
 JEBH26QH9QpZjv1gsYdBTIVmtWwwyn5KKdnHCFcFBYLMewxa/m9k8n0X4wBFEtN5JP5iLpSHX
 O/2dGHAKrqz1c7NWa9HNnEc9LffEszfoFKMnCvNH+ghTWRr0V4P6m15/wWUi930HO4WD9wOPv
 Iu1AGxY5ImlYJo=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2021-10-22 at 12:05 +0100, Mel Gorman wrote:
> On Fri, Oct 22, 2021 at 12:26:08PM +0200, Mike Galbraith wrote:
>
> >
> > Patchlet helped hackbench?=C2=A0 That's.. unexpected (at least by me).
> >
>
> I didn't analyse in depth and other machines do not show as dramatic
> a difference but it's likely due to timings of tasks getting wakeup
> preempted.

Wakeup tracing made those hackbench numbers less surprising. There's
tons of wake-many going on. At a glance, it appears to already be bi-
directional though, so patchlet helping seemingly means that there's
just not quite enough to tickle the heuristic without a little help.
Question is, is the potential reward of strengthening that heuristic
yet again, keeping in mind that "heuristic" tends to not play well with
"deterministic", worth the risk?

My desktop trace session said distribution improved a bit, but there
was no meaningful latency or throughput improvement, making for a
pretty clear "nope" to the above question.  It benefiting NUMA box
hackbench is a valid indicator, but one that is IMO too disconnected
from the real world to carry much weight.

	-Mike
