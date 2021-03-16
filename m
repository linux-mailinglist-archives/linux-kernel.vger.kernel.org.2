Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 481BF33D3FF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 13:39:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232126AbhCPMjE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 08:39:04 -0400
Received: from casper.infradead.org ([90.155.50.34]:52928 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232197AbhCPMid (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 08:38:33 -0400
X-Greylist: delayed 974 seconds by postgrey-1.27 at vger.kernel.org; Tue, 16 Mar 2021 08:38:32 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Ryq5JraLWwmrZbOIDM5SRRh6a4iXNMWbds4wIizdRSU=; b=FWG8uvM7wEwDTZ8xoeJ2MGUiKH
        hWy4nMsZfpCZDNiJ3NgeNpKoh5XnT5RA4bf+GXanCDpyFAiR2QmigeJ8BoJJc9NympBVZKEMK7zlx
        3gJ8zCSLn+Dm5/f8GIBgCD1b0RzjX65sFyQ0Wg2ecdo+V2WZNdMrcBfSGvkS459tmXiJRHEVPGWTQ
        Buhvd57775aiOzcl7QppUP5CdU6CRyssM5ntsbOqVfib18Z4l4IywgGY1rMj/jOtqrJcDBT77TBD5
        eylTvh2hG9HMwPEi8f7F8tSl81z8kdETm/S/fRGcYbN80+BFD2EerR4YgWCRMvmpF8nQSy5bIxppw
        9tQdO2Yg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lM8hW-0002Cc-UY; Tue, 16 Mar 2021 12:21:33 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B72343012DF;
        Tue, 16 Mar 2021 13:21:29 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 65B1620B05D7A; Tue, 16 Mar 2021 13:21:29 +0100 (CET)
Date:   Tue, 16 Mar 2021 13:21:29 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        "Zhou Ti (x2019cwm)" <x2019cwm@stfx.ca>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Yunfeng Ye <yeyunfeng@huawei.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 01/10] tick/nohz: Prevent tick_nohz_get_sleep_length()
 from returning negative value
Message-ID: <YFCiycIaViYCy3GH@hirez.programming.kicks-ass.net>
References: <20210311123708.23501-1-frederic@kernel.org>
 <20210311123708.23501-2-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210311123708.23501-2-frederic@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 11, 2021 at 01:36:59PM +0100, Frederic Weisbecker wrote:
> From: "Zhou Ti (x2019cwm)" <x2019cwm@stfx.ca>
> 
> If the hardware clock happens to fire its interrupts late, two possible
> issues can happen while calling tick_nohz_get_sleep_length(). Either:
> 
> 1) The next clockevent device event is due past the last idle entry time.
> 
> or:
> 
> 2) The last timekeeping update happened before the last idle entry time
>    and the next timer callback expires before the last idle entry time.
> 
> Make sure that both cases are handled to avoid returning a negative
> duration to the cpuidle governors.

Why? ... and wouldn't it be cheaper the fix the caller to
check negative once, instead of adding two branches here?
