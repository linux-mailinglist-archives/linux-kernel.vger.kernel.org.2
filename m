Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D87BF424E17
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 09:29:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240372AbhJGHbT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 03:31:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232512AbhJGHbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 03:31:18 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08390C061746
        for <linux-kernel@vger.kernel.org>; Thu,  7 Oct 2021 00:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/APldPBQ17CmqUOfIAZdcACbDhylN2sZo3m6qBO+mCE=; b=aTL8cjuxdwsRzemvmb1sTITpzA
        Uet9GqGQWn9Shbbx+uGiV7eJYL94YaDJ7Q2OYHhLy3V9G3+LPzbnLfAdV3Tyakqz00iwbb/127HU2
        DcCgqLKBqbGV6Y2dgSQizrfrD3dhshwFRplqRjDInG/br85l7oZMyT8l7GSXVzrK4KpvhsM+k+Ma+
        x/l4QadUR8XMve236vhfpGgHLY/RtWiBJsy+QWqY+YSU8Gt/KDc5AJi9xvJXIRNdoL9lIYwsBaG2a
        Q33C/2lt5Fva/vUKQrhTZ3YazXGxaJtJOsjlFFTdZ4Z7SOObrYsxF7sznmqW5Y+KxscOTW8zNTmdH
        siadGz1g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mYNq9-008Qtj-Nu; Thu, 07 Oct 2021 07:29:17 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 63B6C98623A; Thu,  7 Oct 2021 09:29:17 +0200 (CEST)
Date:   Thu, 7 Oct 2021 09:29:17 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Eric Dumazet <eric.dumazet@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH] x86/apic: reduce cache line misses in
 __x2apic_send_IPI_mask()
Message-ID: <20211007072917.GN174703@worktop.programming.kicks-ass.net>
References: <20211007031756.345269-1-eric.dumazet@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211007031756.345269-1-eric.dumazet@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 06, 2021 at 08:17:56PM -0700, Eric Dumazet wrote:
> +/* __x2apic_send_IPI_mask() possibly needs to read
> + * x86_cpu_to_logical_apicid for all online cpus in a sequential way.
> + * Using per cpu variable would cost one cache line per cpu.
> + */

Broken comment style..

> +static u32 x86_cpu_to_logical_apicid[NR_CPUS] __read_mostly;

NR_CPUS is really sad, could this at all be dynamically allocated? Say
in x2apic_cluster_probe() ?


Otherwise this looks very nice!
