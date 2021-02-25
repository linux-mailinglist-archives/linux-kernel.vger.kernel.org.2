Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F35743259A2
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 23:27:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231414AbhBYW0X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 17:26:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232984AbhBYWYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 17:24:10 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22A41C061786;
        Thu, 25 Feb 2021 14:23:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=e5bIKFhbgZEj8SjfyeG858Itz+Ur+Q5wYYEPI3dfn5g=; b=Rt4URmSD2yF/t8D6C8T6K8D4Mh
        qnIfsJWbRbD6Y6mxX5jpzoJ16X9Atoly7OXJxDypRSaQGgxxFCm1lPeEC339uBrN9vM2WOP5qmYaX
        r/jcXRAuiLXbmEKATcuy6b50XhMBqyadn0/+D0VG7ZfBvhuIpsMZiNZVn8ywk+G2YZDBI0vjA/HsL
        yIKoyNjli/+wQ0cD+rFUrOO3ioZpBEez5cYyqeNHML2F9R8vS8uDRXsBMzoV6SxKyP5XroM3ZQ6TQ
        4V07luRj2QTtg9YOqItiSUQt8EcxY5YMNZakSv7wknlOxQB/ETHk+O1+iNTS5JN5l9znJctFaOwAr
        hRzx4Jkw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1lFP2W-0008P3-7I; Thu, 25 Feb 2021 22:23:20 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5DD2C9864D3; Thu, 25 Feb 2021 23:23:18 +0100 (CET)
Date:   Thu, 25 Feb 2021 23:23:18 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        rcu <rcu@vger.kernel.org>, Josh Triplett <josh@joshtriplett.org>,
        rostedt <rostedt@goodmis.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "Joel Fernandes, Google" <joel@joelfernandes.org>
Subject: Re: tasks-trace RCU: question about grace period forward progress
Message-ID: <20210225222318.GG4746@worktop.programming.kicks-ass.net>
References: <354598689.4868.1614262968890.JavaMail.zimbra@efficios.com>
 <20210225153656.GQ2743@paulmck-ThinkPad-P72>
 <47558398.5024.1614268052985.JavaMail.zimbra@efficios.com>
 <20210225183321.GT2743@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210225183321.GT2743@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 25, 2021 at 10:33:21AM -0800, Paul E. McKenney wrote:
> One question for Peter...  Does each and every context switch imply a
> full barrier?

Yes, also see the smp_mb__after_spinlock() in __schedule() :-)
