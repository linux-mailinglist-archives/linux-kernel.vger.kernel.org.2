Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C636E372A3B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 14:40:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbhEDMlR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 08:41:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbhEDMlP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 08:41:15 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08CC6C061574
        for <linux-kernel@vger.kernel.org>; Tue,  4 May 2021 05:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=aOgw8gTtqCvsf+ExW83Mx/p2YK3vJgX1iSoS+5mnhKg=; b=UiI422hFygyJPipELGY6C3oM/Y
        +pKLGnNKutcok4zQRN3h0o9oonJEFJ/C0Jp9i5SUaq3Sc8lVm9G/r11GDZtZZFEJ/flPdW8aClyRB
        LPqFSrZYWKJoL1nDDi50srdwTAqcyN5HfgYuaYaM/ofMvYytM4uQxbeY2IQlsnnV9gH8y3GXfn695
        asPszBZFadMSO9SDgkVeaSQ9FYChJ/UaK+c6tFiaWJCQ/9CGD1jUhqOAG2ZUxzBVuD0pyBcUB4aGS
        4SlIsL2GiniVM8UwNH3vrATVI8J+Ab2PDOZAG7bE+jv75gv6TDv+NvLRZvH4/+sXu38+AURCRa7fw
        FFvtmQKA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lduLT-00GCSX-54; Tue, 04 May 2021 12:40:11 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 99E693001CD;
        Tue,  4 May 2021 14:40:10 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7F4DD2026F4B8; Tue,  4 May 2021 14:40:10 +0200 (CEST)
Date:   Tue, 4 May 2021 14:40:10 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Yunfeng Ye <yeyunfeng@huawei.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [PATCH 3/8] tick/nohz: Remove superflous check for
 CONFIG_VIRT_CPU_ACCOUNTING_NATIVE
Message-ID: <YJFAqnnWndcvHTvi@hirez.programming.kicks-ass.net>
References: <20210422120158.33629-1-frederic@kernel.org>
 <20210422120158.33629-4-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210422120158.33629-4-frederic@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 22, 2021 at 02:01:53PM +0200, Frederic Weisbecker wrote:
> The vtime_accounting_enabled_this_cpu() early check already makes what
> follows as dead code in the case of CONFIG_VIRT_CPU_ACCOUNTING_NATIVE.
> No need to keep the ifdeferry around.

Somewhat unrelated, but vtime_accounting_enabled_cpu() is missing a ' '...
