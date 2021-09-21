Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5238412F00
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 09:04:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbhIUHGP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 03:06:15 -0400
Received: from mout.gmx.net ([212.227.15.18]:45861 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229917AbhIUHGN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 03:06:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1632207853;
        bh=NhQ2FRb1gtO8O11CiH8UE4rdyQC20tTnlz7v+x9CsKo=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=N9503PsR8PfqDVcQc4/svBwiNarBw63gs7ZU9BIomO9/KdHAmpotDhNA4bAtAoVll
         h0ieghf8cJ0VYe1X8uaIGwaUMN0eMGv22gdPZLWfda/TnI92Rg8PtcReMJhJuU6lK2
         eKhvPUeiiMHCaG2M0oKSyj+Nyz1YgAg2K0bk+Sw4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.191.219.33]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MyKDe-1mnR5t0j0e-00yiKt; Tue, 21
 Sep 2021 09:04:13 +0200
Message-ID: <bdc1c7d989cdca3fabc356c8e330117b3985072d.camel@gmx.de>
Subject: Re: [PATCH 2/2] sched/fair: Scale wakeup granularity relative to
 nr_running
From:   Mike Galbraith <efault@gmx.de>
To:     Mel Gorman <mgorman@techsingularity.net>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Tue, 21 Sep 2021 09:04:10 +0200
In-Reply-To: <22e7133d674b82853a5ee64d3f5fc6b35a8e18d6.camel@gmx.de>
References: <20210920142614.4891-1-mgorman@techsingularity.net>
         <20210920142614.4891-3-mgorman@techsingularity.net>
         <22e7133d674b82853a5ee64d3f5fc6b35a8e18d6.camel@gmx.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.0 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wG/137JuIdqZCQulk5+HaNOvmugIXfeSyfNh6+a9/AHzRrFd1Sq
 h8jencsEpQr+oXellG1Vm5XJqgUyUTltvUcRJcgLZAxfzgQ3vUluCTRPUseInqh5dPkJ/f0
 3Qv1aVnxfGJty3gZ3xHtbcJcd8Yk9rZWmL/wwz5kaRHBi5eq9iEsuKvoiWAEaxmN5izcjzi
 PX3tgFCPpO5D4jxuABHQw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ArE1V0qbY20=:oyFI8cGkV20IzRpvzcTcPo
 PEiCyl6KfWS6uT4LWFnuAxazVArPlcZhuxZz5BUvhtMuC+GHFDWrAG5TWmPl2HdIjyTLdWx6n
 XuHvyYdL/rKU1lKsfMtM2xQ8iHkrRdhgMuY1XwT9QINc3CKQo9hxdRg69gFfq6u9wiGvyOEMh
 yPW/jaLF+nrENlqNIyZKjpe4AV372ievjbU5CAwVEcPaY+iktlAm7W49fBgt1K2vC2D0t3WXy
 B+tO7GMVGdwfhYZbeWCKJVtDx5TRKdFAzfC1wYEFSzYwnU8pC21rZUzpknf50IaiMstNJmlLh
 GgNyscRX9UyVtr9DP3yQkdTBMAmp8aTqPL1HAwXXqqpluq7bdyXHAclQKBYcafRhTk55BU3ts
 4ppwH0nZeQHHfKySrVIQsNPDjncC/rOQDTknh2GO1DI+44d4cin/qBc5Kd1ZdFUXwZqa6L5H3
 fyEoIXTB5+HsDMtqw1UT+yPFBpRudesMmOGxaiSVxgc+uiCor76MWcE2RVn0Y354MTeDfvpTJ
 reqhznFp5dZUBEjD5QQwCF2woyRXUe2vrDApA2B3YiysVXaY05hK0foIJ8WTFk8cEPY1qbkyv
 Wo4B0PtKy3nJzbes6rP2oZSL6QS6+1cUx/N1YC9nzRJyMuQII00PCLgWYM9kwepc5wyKBVMkS
 lsbtzPLFQKaDSACZNgtwcml847IhvE+C4PZaEovMiPfAK6KBAI+6WqfX5vHStuARwdBaBtCs/
 WuwEvmtOJoJN46vxfqXc0twxlTm0bIqqUWhso7jHZxQE/fOzrBxwEkCJyqMa+oOtox30DPtAS
 8fXl7nQswxsWJPMi/yLcC+HERW5tHkWxx7njZwP+Hgrdl6Yhn9SF4WXBW9+/Bf4kMeq+rQah+
 axz86uqG6xfh/Qr6In8y9WNrmn5ftVL+RMgONx3+76/aY1fodOhz8HvrQhy2yhg+4GUx3jMe2
 PmbrGzL4S0cVMwVT0V5F/5yHFjE+e/EzI+xa/WzhkP5z9SWKk1gTAyByYgGmaIW8VWImPhZXp
 bDkYTOuYn4KJ+IhvLr0SGANIssixzFOTsheOZKGWgnIpbsMb3LmM3GkxQDvNeHqqCpMZ6hUHA
 3yMr2OEhMx7Khs=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2021-09-21 at 05:52 +0200, Mike Galbraith wrote:
>
> ...preempt threshold reaches 12.000ms, by human booboo or now 3
> runnable tasks

Bah, 6 so not so close to hohum burst level, but still something that
maybe warrants a feature.

	-Mike
