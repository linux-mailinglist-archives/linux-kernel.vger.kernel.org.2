Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 788ED40B04A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 16:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233617AbhINOMF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 10:12:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233349AbhINOMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 10:12:02 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D0C9C061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 07:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ORJtzCbAdHLFjt3q5PVm7vWmJtjOXkitgYve8acSoVk=; b=Lomv8+pi0EJguTTHynaRBa4f5Z
        x9MHGfu/FXljL5t08hQWSBd9wjZHFLPI2+Y0MFswzMtXp2gVrGnGQnzgstg8JL+yN8WanMvzGSVjm
        kEIWLLJG2zTAYJ+zUhKDNO6SaD89qpxp7vEM1bTi76Kv9RcmGJHVUx9BY+UVQCDlSQc+j4Crs6Eyr
        GMyi/TpMHW7fq/G9X9d9bJ46oaoMc8nCAACaNmtN6DYjH5I25+hDaX+4UpFZf2djlMUK42kFWZ0/7
        Mmh2Aqra4S2Aq+BkMxk2kz49JERNTor8FUrdTpm58I0leQSCTR5M6/z1pRtkym5wCOdnkSG3PdWW3
        frThw5Yg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mQ98E-00EjcR-7u; Tue, 14 Sep 2021 14:10:05 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D9806300255;
        Tue, 14 Sep 2021 16:09:53 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C260C2D069C2D; Tue, 14 Sep 2021 16:09:53 +0200 (CEST)
Date:   Tue, 14 Sep 2021 16:09:53 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v3] sched: Provide Kconfig support for default dynamic
 preempt mode
Message-ID: <YUCtMWgWCckBOYM1@hirez.programming.kicks-ass.net>
References: <20210914103134.11309-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210914103134.11309-1-frederic@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2021 at 12:31:34PM +0200, Frederic Weisbecker wrote:
> Currently the boot defined preempt behaviour (aka dynamic preempt)
> selects full preemption by default when the "preempt=" boot parameter
> is omitted. However distros may rather want to default to either
> no preemption or voluntary preemption.
> 
> To provide with this flexibility, make dynamic preemption a visible
> Kconfig option and adapt the preemption behaviour selected by the user
> to either static or dynamic preemption.
> 
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>

Thanks!
