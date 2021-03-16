Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0124833D958
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 17:26:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238701AbhCPQZ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 12:25:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235308AbhCPQZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 12:25:39 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2283BC06174A
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 09:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=I7ZEP/paw2W0PU7zcIUjqWbSxWw/n2kHGTHP3rq4/mo=; b=W2r3NtbbFCBWyQORfrlwQwdO1g
        qF+0s4m9I/Vd2bgogRFObva8guJKxJNvwTuB8a5dgpFzv3+J9jJHaFCXVIyNh0jI8V7mHhXOjXbSK
        SEoyCam2DOs+419RYhiIEdT0q6BbMUllTNKM49+Sel0gD0gs0Q3N4uOCXOL1cWvTdUsJM6Kz5JH5Q
        iIjF9BVXX6XJO6Mxb3qdUeHmkQzfmluqph+WBorh3jOjVaRUqCpQbTgZCZWW89PKEKPWvn6WbABCg
        FpJMzlqgWS4GGoRLJtNVD55f3cohQvYOSPSD7QcQh15xpR/1AbN6GuN9fZoqVzojHUt7uAmfrLg19
        AuWlJOig==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lMCVY-001ETp-L5; Tue, 16 Mar 2021 16:25:26 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 47AFA304D58;
        Tue, 16 Mar 2021 17:25:21 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DF9242B88085B; Tue, 16 Mar 2021 17:25:20 +0100 (CET)
Date:   Tue, 16 Mar 2021 17:25:20 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Zhou Ti (x2019cwm)" <x2019cwm@stfx.ca>,
        g@hirez.programming.kicks-ass.net
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Frederic Weisbecker <frederic@kernel.org>,
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
Message-ID: <YFDb8AzfajvlZ6iS@hirez.programming.kicks-ass.net>
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
> But I don't think it's a good idea to handle this in callers, because
> logically the function shouldn't return negative values. Returning 0
> directly would allow idle governors to get another chance to select
> again.


A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?
