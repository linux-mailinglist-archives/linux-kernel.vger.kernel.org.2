Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84EC833EE47
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 11:27:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbhCQK0u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 06:26:50 -0400
Received: from smtp1.de.adit-jv.com ([93.241.18.167]:36789 "EHLO
        smtp1.de.adit-jv.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbhCQK0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 06:26:25 -0400
Received: from localhost (smtp1.de.adit-jv.com [127.0.0.1])
        by smtp1.de.adit-jv.com (Postfix) with ESMTP id CE4AF3C00C0;
        Wed, 17 Mar 2021 11:26:24 +0100 (CET)
Received: from smtp1.de.adit-jv.com ([127.0.0.1])
        by localhost (smtp1.de.adit-jv.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id f4vny2awvQ0I; Wed, 17 Mar 2021 11:26:19 +0100 (CET)
Received: from hi2exch02.adit-jv.com (hi2exch02.adit-jv.com [10.72.92.28])
        (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp1.de.adit-jv.com (Postfix) with ESMTPS id 212393C04C0;
        Wed, 17 Mar 2021 11:26:19 +0100 (CET)
Received: from lxhi-065.adit-jv.com (10.72.94.36) by hi2exch02.adit-jv.com
 (10.72.92.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Wed, 17 Mar
 2021 11:26:18 +0100
Date:   Wed, 17 Mar 2021 11:26:12 +0100
From:   Eugeniu Rosca <erosca@de.adit-jv.com>
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     Eugeniu Rosca <erosca@de.adit-jv.com>,
        <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Jiafei Pan <Jiafei.Pan@nxp.com>,
        Romain Perier <romain.perier@gmail.com>,
        Andrew Gabbasov <andrew_gabbasov@mentor.com>,
        Dirk Behme <dirk.behme@de.bosch.com>,
        Eugeniu Rosca <roscaeugeniu@gmail.com>
Subject: Re: [PATCH] softirq: Be more verbose on t->state BUG()
Message-ID: <YFHZRF6lTvZKgD3D@lxhi-065.adit-jv.com>
References: <20210315154421.11463-1-erosca@de.adit-jv.com>
 <87k0q7186h.fsf@nanos.tec.linutronix.de>
 <YFDKZ5Ukwy/j8Xk3@lxhi-065.adit-jv.com>
 <87tupbyqc7.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <87tupbyqc7.fsf@nanos.tec.linutronix.de>
X-Originating-IP: [10.72.94.36]
X-ClientProxiedBy: hi2exch02.adit-jv.com (10.72.92.28) To
 hi2exch02.adit-jv.com (10.72.92.28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Thomas,

On Tue, Mar 16, 2021 at 06:13:12PM +0100, Thomas Gleixner wrote:
> On Tue, Mar 16 2021 at 16:10, Eugeniu Rosca wrote:
> > If no other comments in the next days, I will resubmit your proposal as
> > v2, marked with 'Suggested-by: Thomas Gleixner <tglx@linutronix.de>'.
> >
> > Alternatively, feel free to author the patch and submit it with us in Cc.
> 
> Just send a v2 please

https://lore.kernel.org/lkml/20210317102012.32399-1-erosca@de.adit-jv.com/
("[PATCH v2] softirq: s/BUG/WARN_ONCE/ on tasklet SCHED state not set")

-- 
Best regards,
Eugeniu Rosca
