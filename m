Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D07C931EA1F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 14:01:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233068AbhBRM6S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 07:58:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232480AbhBRLOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 06:14:33 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAD03C061756
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 03:12:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=sHWzYpmgHKT+8RL/bSuylxH66VLPMwZFU5Pzml9yfAk=; b=C2vpF0CAJapIgOcErz0BoOW4Wv
        mZRfuvBmI++LZYBsZZDin/iqbMYeyV4MKtOa1Uuoir+HSSBh8QOKEay6CqYxbzGhBv6C9aC+WiiKq
        0UeEF/smsycn1FgnaH/uUo2Q1fP+PSJUoSMdsa7EGYSqHM/5W8GkrO6eVMoxNTvkDcNp9bZojnELl
        53s46zlLtYPv/xN44yNOn2BKbr+6lRpD0eTB8j9xa8CM7dpPomFpMHpKsRcVGtkQm/+jmxUYivsvz
        ZpJJlRp26p3JTKUcsT5jsUjkgkCrQO84oOmtdTbnAYrUCIhh9kEtPqH+OdILBT5qCzdD/xRDl0qwl
        9QlY0SjA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1lChEU-0007wk-9W; Thu, 18 Feb 2021 11:12:30 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 522179814E2; Thu, 18 Feb 2021 12:12:28 +0100 (CET)
Date:   Thu, 18 Feb 2021 12:12:28 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nadav Amit <namit@vmware.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Rik van Riel <riel@surriel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH v5 1/8] smp: Run functions concurrently in
 smp_call_function_many_cond()
Message-ID: <20210218111228.GG4348@worktop.programming.kicks-ass.net>
References: <20210209221653.614098-1-namit@vmware.com>
 <20210209221653.614098-2-namit@vmware.com>
 <20210218080929.GA335524@infradead.org>
 <ACE814E2-5986-44AE-920C-1EA241D2E12D@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ACE814E2-5986-44AE-920C-1EA241D2E12D@vmware.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 18, 2021 at 09:36:09AM +0000, Nadav Amit wrote:
> I prefer to export on_each_cpu_cond_mask() and instead turn the users
> (on_each_cpu(), on_each_cpu_mask() and on_each_cpu_cond()) into inline
> functions in smp.h.

That makes it impossible (barring LTO) for the compiler to do constant
propagation on the cond and mask thingies.
