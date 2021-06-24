Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 714D03B2BF2
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 11:56:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232179AbhFXJ6V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 05:58:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232156AbhFXJ6U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 05:58:20 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 039B4C061574
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 02:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Subject:Cc:To:From:Date:Message-ID:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=QCQHDmmZyyOQ8GgC66T6KReifyiUt2RRh+YVjbBaxvA=; b=HB0IeUCiDME0cLHwRlz+gHN9Sp
        iEgvzL5OdG3qwEi7e2cYPBOgIQmY0mr2MhAHZn+D8IYaZAW/MMUjv4p9afwTYp3Ntc7cj5JMilgpx
        VLAEhfySR2Tw0qkSBtaZRJsI3zs1KMaQZH9H4dEZnZTeWImjqxBvCk4jmao97TcmEndP/0A3UtYuU
        cHj+i7Q98yFVil04r2hNuLwoC4YAT/o5bcSj66hPF5DcyvikWaMLRuKyE3I33SPXwnoorfdy4GsPz
        Y1NsZHdUA+QcV1Ks43C0R4uXG7jjDJf8lYoWtKK7kTZmJ4kuw3uzR6xzZ9jIgruOtXVOHBmIP8Eh4
        mxhKh3uw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lwM40-00GQOY-TG; Thu, 24 Jun 2021 09:54:28 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D41D030022B;
        Thu, 24 Jun 2021 11:54:23 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 9791E2B64C05D; Thu, 24 Jun 2021 11:54:23 +0200 (CEST)
Message-ID: <20210624094059.886075998@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 24 Jun 2021 11:40:59 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     jpoimboe@redhat.com, tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        joro@8bytes.org, boris.ostrovsky@oracle.com, jgross@suse.com,
        x86@kernel.org, mbenes@suse.com, rostedt@goodmis.org,
        dvyukov@google.com, elver@google.com
Subject: [PATCH v2 00/24] objtool/x86: noinstr vs PARAVIRT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Per long standing request from Thomas, this makes the noinstr validation work
with PARAVIRT=y.

It isn't exactly pretty, but it does work.

With all this on top of tip/master (which includes some of the previous round),
all (*) the robots seem to get is endless garbage like:

  vmlinux.o: warning: objtool: __rdgsbase_inactive()+0x24: call to ftrace_likely_update() leaves .noinstr.text section

And my secret plan is to pull the KPTI CR3 swizzling into C such that all that
will insta explode and become unfixable.

Steve, can I please delete TRACE_BRANCH_PROFILING and PROFILE_ALL_BRANCHES already?


(*) there were also a few reports from 0day running out of memory.

