Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E8A9375BE6
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 21:43:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235804AbhEFToy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 15:44:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235690AbhEFTox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 15:44:53 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8F3EC061763
        for <linux-kernel@vger.kernel.org>; Thu,  6 May 2021 12:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Subject:Cc:To:From:Date:Message-ID:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=b0EqNd0gmgwKLKJJOYOmHJjundexpcTI4xmU3pYNcaM=; b=EB25ImVxNbmOGdPMGSAJTX7qeV
        VQIeq/TUQ3GsDus3avAi5LBCJojKcIs8HxH71kZIxHEEJnW0V2I0NxmCXBkBsgL9Xt+XNUDE8WlzI
        OAixH1YIailS+4OcBFjB0tos/vldy0AV94F7y6/4c2rGaRLevdkgMvYJf9WLWMcrEM3L7kkay91BU
        LBcAhJMsmrRa0mj3eC5wcczEUb1HdUlFtBzUuA3xdewdlb0QU+zP2N+NEZ3DtB2Z9rJGZqyy3qU8f
        Id1m7adpt4+xri8qu8pibx7JdNoSpLd1Eh67vZ1736o4vYp6cgktUmIDu0VSyvSFSwHZedaiq0zB2
        S1rs7JLw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lejtQ-002ADD-Bt; Thu, 06 May 2021 19:42:48 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B50853001D0;
        Thu,  6 May 2021 21:42:38 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 98C9620B96F82; Thu,  6 May 2021 21:42:38 +0200 (CEST)
Message-ID: <20210506193352.719596001@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 06 May 2021 21:33:52 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, jpoimboe@redhat.com, jbaron@akamai.com,
        rostedt@goodmis.org, ardb@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org
Subject: [PATCH 00/13] jump_label: Yet another attempt at variable sized jump_labels
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I figured that since objtool is rewriting things anyway, we can also use it to
do the variable sized jump_labels.

previous attempts are here:

  https://lore.kernel.org/lkml/20191007084443.79370128.1@infradead.org/
  https://lore.kernel.org/lkml/1318007374.4729.58.camel@gandalf.stny.rr.com/

