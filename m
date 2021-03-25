Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A22113492E6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 14:14:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbhCYNOJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 09:14:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:52858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230296AbhCYNOD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 09:14:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6AA9F61601;
        Thu, 25 Mar 2021 13:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616678042;
        bh=Y1Rg5YBDRsRupPWL1QolKzKDrfgPP+t3tin3fDVz4+8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nBudAbRuRhBm/4kJSsGwrhP/0kYTdiMBeYbhkO0p+Xqm2vIFgTz0fOFgIJb5Riqed
         0Z4rliaoXf5g7sqzQ1QQBhnK6L3syEzRQlzO3uqKIDzLY6NThuK2IrYY85e8uwSfLN
         CJurSHPsPxLQJi1WqNe7Fv/B+Ru81zpq5W0qIjzsZ0lv54a6JqREAHJp+yBKVwbaTW
         0RK7kVV1h7vzvOIeP89PerAaePazYIRt1WyPrq2T06p+o4V3NW+CAUIt+zkyLmll0N
         XZ33VWp2T9mQeHhnAtnOsxibYDC5GvIElC9K4V13gkzErxaQ8o9QPGnSmnyUXTqS1l
         ApvwayYijIOZQ==
Date:   Thu, 25 Mar 2021 14:14:00 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Zhou Ti (x2019cwm)" <x2019cwm@stfx.ca>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Yunfeng Ye <yeyunfeng@huawei.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        "rafael@kernel.org" <rafael@kernel.org>
Subject: Re: =?utf-8?B?5Zue5aSNOiBbUEFUQ0ggMDEvMTBd?=
 =?utf-8?Q?_tick=2Fnohz=3A_Preven?= =?utf-8?Q?t?=
 tick_nohz_get_sleep_length() from returning negative value
Message-ID: <20210325131400.GA938586@lothringen>
References: <20210311123708.23501-1-frederic@kernel.org>
 <20210311123708.23501-2-frederic@kernel.org>
 <YFCiycIaViYCy3GH@hirez.programming.kicks-ass.net>
 <20210316133703.GC639918@lothringen>
 <YFDCOYstnDWPSWRU@hirez.programming.kicks-ass.net>
 <20210316145352.GE639918@lothringen>
 <ab753f1f-b03d-2a26-a552-b91f98708353@intel.com>
 <YTBPR01MB32623E6AC71C9F7670469A47C46B9@YTBPR01MB3262.CANPRD01.PROD.OUTLOOK.COM>
 <YTBPR01MB3262D78448BD2FB3AD5EB4F9C46B9@YTBPR01MB3262.CANPRD01.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YTBPR01MB3262D78448BD2FB3AD5EB4F9C46B9@YTBPR01MB3262.CANPRD01.PROD.OUTLOOK.COM>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 16, 2021 at 04:08:08PM +0000, Zhou Ti (x2019cwm) wrote:
> But I don't think it's a good idea to handle this in callers, because logically the function shouldn't return negative values. Returning 0 directly would allow idle governors to get another chance to select again.

Hmm, I'm going to leave the last word to Rafael since cpuidle are the only
callers of this. In any case we need to fix it.

Thanks.
