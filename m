Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B60983E2F19
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 20:03:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242436AbhHFSDd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 14:03:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242299AbhHFSDc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 14:03:32 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C410AC0613CF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Aug 2021 11:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=uVuBx4AEgB9ckEWGvUuo9HSwD+EJTE7laNcQEUtdjGY=; b=clKMz1xx3bb7a5S3dB8ZVWD0VX
        7g2csWAupUaaWfPNFiUt03siplzi6Mhk/LA5V0BLpnS7nDw5/F4VG1zu8Kw2VANXNBSvTZKmNOAot
        sdfVm40cnwIqjcHPQcfPBqY6dUii8B7nMucWZaGY1yWwfFiRwRKsuGbCSxKwRG3fu/iTmEVHzcdC0
        cWIAJ787WfYT902FkJmleDaoInRb8JKfKZlOjTmvGsq9kdvGRldlHjL84nKFedIFZ3CIhdu2aaUQ5
        I1lxKBOqu+PIHrWzzlEHtgJwe7OqzcFM0slqBUa8d6RdQ+/eez8VsXQtKQLHXEIUpS1AIK8Qkxuon
        d/l8iL/Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mC4B9-008Rey-13; Fri, 06 Aug 2021 18:02:48 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 17F9098632E; Fri,  6 Aug 2021 20:02:42 +0200 (CEST)
Date:   Fri, 6 Aug 2021 20:02:42 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH] notifier: Make atomic_notifiers use raw_spinlock
Message-ID: <20210806180242.GB2184@worktop.programming.kicks-ass.net>
References: <20210806140718.mxss3cbqijfebdo5@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210806140718.mxss3cbqijfebdo5@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 06, 2021 at 04:07:18PM +0200, Sebastian Andrzej Siewior wrote:
> What do we do with this?
> Do we merge this as-is, add another "robust atomic notifier" using only
> raw_spinlock_t for registration and notification (for only
> cpu_pm_notifier_chain) instead of switching to raw_spinlock_t for all
> atomic notifier in -tree?

Right, so the problem I see with this is that
notifier_chain_{,un}register() are O(n). Hardly something we should be
putting under raw_spin_lock :/
