Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 182393B5D31
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 13:34:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232671AbhF1Lg4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 07:36:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232566AbhF1Lgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 07:36:53 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1174C061574
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 04:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Subject:Cc:To:From:Date:Message-ID:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=5GEP1Vni9UstdpWjS6qbJv7fdpfN4qWWS6lzr7mIwX8=; b=Lve0w/14RLRrIUfR3My9n9Ig5I
        jxOYq8Trujve8n2pgbTdqtkDGan1qLAEvFqqGw68hu7N049E35YCGj86rT+7uxpC8tjcH6cqJ+MTD
        2juo5umICo/bKXzwzPjc7Lm8Xu5lJAt5TJFT0gNt8BT+ruylAK0SRwlicWN5Bj/DBZ+VY5j+1m1JF
        BVD6wRMyJLqIZt0Ut6E/L96lwbn51ZuLwqZ0zZ6yaVZH5Xtv3ZBuiSoNVAVSv3e6DKokl1ZMZwcfj
        XsvKZh36Ax6UJ3LmhXVNw35Ad3Dm5Q+CwNlmSdZmlIbTbf+qTzMLrvX7TizDyt9zmH8UKLnMDuxkM
        IcWolTlQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lxpUD-002uXo-5L; Mon, 28 Jun 2021 11:31:40 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6D1C230022B;
        Mon, 28 Jun 2021 13:31:29 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 3D3F7264FD3F5; Mon, 28 Jun 2021 13:31:29 +0200 (CEST)
Message-ID: <20210628112409.233121975@infradead.org>
User-Agent: quilt/0.66
Date:   Mon, 28 Jun 2021 13:24:09 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     jpoimboe@redhat.com, jbaron@akamai.com, rostedt@goodmis.org,
        ardb@kernel.org, naveen.n.rao@linux.ibm.com,
        anil.s.keshavamurthy@intel.com, mhiramat@kernel.org,
        davem@davemloft.net
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org
Subject: [PATCH 0/3] jump_label/static_call/kprobes: *_text_reserved() fixes
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

3 little pigs^Wfixes for kprobes on dynamic text.

