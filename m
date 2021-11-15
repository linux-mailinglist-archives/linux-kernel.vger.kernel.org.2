Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FA6C451788
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 23:30:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231650AbhKOWcN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 17:32:13 -0500
Received: from foss.arm.com ([217.140.110.172]:59522 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242076AbhKOSgz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 13:36:55 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 44ED41FB;
        Mon, 15 Nov 2021 10:33:59 -0800 (PST)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.196.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0D0B43F70D;
        Mon, 15 Nov 2021 10:33:57 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Vincent Donnefort <vincent.donnefort@arm.com>
Cc:     "peterz\@infradead.org" <peterz@infradead.org>,
        "mingo\@redhat.com" <mingo@redhat.com>,
        "vincent.guittot\@linaro.org" <vincent.guittot@linaro.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dietmar.eggemann\@arm.com" <dietmar.eggemann@arm.com>,
        "jing-ting.wu\@mediatek.com" <jing-ting.wu@mediatek.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH] sched/core: Mitigate race cpus_share_cache()/update_top_cache_domain()
In-Reply-To: <20211115104601.lwcwxoc67ftbf6uh@shindev>
References: <20211104175120.857087-1-vincent.donnefort@arm.com> <20211115104601.lwcwxoc67ftbf6uh@shindev>
Date:   Mon, 15 Nov 2021 18:33:52 +0000
Message-ID: <87h7cdqne7.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/11/21 10:46, Shinichiro Kawasaki wrote:
> Oh, this is the exactly same fix as I posted before [1]. It is a little bit sad
> that my post did not get reviewed. Anyway, good to see the issue fixed. Thanks.
>
> [1] https://lore.kernel.org/all/20211029005618.773579-1-shinichiro.kawasaki@wdc.com/
>

Oh, that sucks, sorry about that. I do try to keep an eye out for sched
stuff sent to LKML, but clearly there are some that fall through :(

> --
> Best Regards,
> Shin'ichiro Kawasaki
