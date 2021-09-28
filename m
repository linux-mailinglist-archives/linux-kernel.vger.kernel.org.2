Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20EB741AAD5
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 10:44:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239717AbhI1IqN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 04:46:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239722AbhI1IqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 04:46:02 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7D6BC061740
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 01:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Subject:Cc:To:From:Date:Message-ID:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=igqyip6PgtFTWLu5RC+rY33V0lnfiZxYZTJqWS0dFL8=; b=T9BZ/UUad7E8CuBBmM+hdimKrG
        usc7XkaVwzjAizfnA3fa8CNdEJPnMZ42dkAf0oDEG1S7OJbkY83sHJmmQLWD9m02kYgg/9/CHV7Bl
        kRiRnxkGFJwIqBsFbk+kBRDhtRp4VsS2S7Z8EQfNn4Q4aHMBUkzBeqa3UsAIp/GxMp4yJj/0qOSl8
        CE9MXysk8yNTGND5HD5tr46u3phTyqduKWB21+DX+XCAI3FYiQzKKAPSA23F9dE6WRqLmFSIqg5re
        famOVU0D1u/Y/LCSxfdlN74FN8LBc4uucnST4szx45bzqlVFdgBfgjynZOFKd65PK/CpPQnzGsypW
        IqcaRG/Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mV8hW-00AgFA-I8; Tue, 28 Sep 2021 08:43:10 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 39CE7300047;
        Tue, 28 Sep 2021 10:42:55 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id C335C2C2FF131; Tue, 28 Sep 2021 10:42:55 +0200 (CEST)
Message-ID: <20210928084020.819856223@infradead.org>
User-Agent: quilt/0.66
Date:   Tue, 28 Sep 2021 10:40:20 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     paulmck@kernel.org, tglx@linutronix.de, sfr@canb.auug.org.au
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org
Subject: [PATCH 0/3] rcu,sched: noinstr fixes
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A few noinstr fixes.. I'll stick the sched one in sched/urgent, Paul could you pick up the other two?


