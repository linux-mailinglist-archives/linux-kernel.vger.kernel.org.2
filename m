Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A951A45033C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 12:11:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231216AbhKOLOr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 06:14:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230456AbhKOLOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 06:14:42 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0E50C061746
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 03:11:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=t7V8vkr29zZbMwpTi9zjV5Xk2KGVk9lglua9CYi555I=; b=osXk6uFjDeHhZH8nLNv49dvCac
        GFJW4dD/BC1vAl8em2qEC8S7JEvQAjqVH0FKjyE55dNNuZcwuUJO4ueCmp0MP3YgPO5yrdwb6z2Y+
        r4TivYqGQqfXPtBObnM9eiks3i7fWA2t7Ru7JBHDHkrHe4haUnvORyje3wBpHwq8klLjGa3cHLrDO
        OohhfkwgFepAJlT6HsXXBZYP24TTKG+l/YMA/YLZDK9LkHS1RFVkYJ8O00U1iawANyjgwzxzCko4K
        QuPEIArH9Kznw3D+J1N2jhGYUFtKwJIR6gV++dPndmM6+j+LDMFKG7Tfp9Vx1zT6Guuxy+5qzCK4v
        ZPVFDP8g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mmZti-005din-Tc; Mon, 15 Nov 2021 11:11:39 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 182B230031C;
        Mon, 15 Nov 2021 12:11:38 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id EBE90203C0207; Mon, 15 Nov 2021 12:11:37 +0100 (CET)
Date:   Mon, 15 Nov 2021 12:11:37 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Guo Zhengkui <guozhengkui@vivo.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "open list:LOCKING PRIMITIVES" <linux-kernel@vger.kernel.org>,
        kernel@vivo.com
Subject: Re: [PATCH] rtmutex: fix boolreturn.cocci warning:
Message-ID: <YZJAaUreHQQsilRL@hirez.programming.kicks-ass.net>
References: <20211115070411.6842-1-guozhengkui@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211115070411.6842-1-guozhengkui@vivo.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 15, 2021 at 03:04:10PM +0800, Guo Zhengkui wrote:
> Fix following boolreturn.cocci warning:
> ./kernel/locking/rtmutex.c:375:9-10: WARNING: return of 0/1 in function
>  '__waiter_less' with return type bool.

The right patch it so delete that stupid script.
