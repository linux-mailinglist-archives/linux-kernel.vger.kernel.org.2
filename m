Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 528D6398AEC
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 15:41:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbhFBNmm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 09:42:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbhFBNmk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 09:42:40 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD074C061574
        for <linux-kernel@vger.kernel.org>; Wed,  2 Jun 2021 06:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9VXI9IDsTNx8jcKM0F7WQjsSFQrMM0WoeJ2HjMVY+fI=; b=Z1M5/TV+BFuOFCUJ/wezccC23S
        UxQDwNuqdH8PaXyv4Fx4fav+OWVpTOXUf6svzHTE5GMxVOCX+xiYEFh5iRgF6PqPuqAwN8Rjx4/oN
        ZGP3Rrjm76uNmugSHsrItOY0ttDE/HchDbTnOSjYJrGp8Swb5B8cVaItQvgev4uS51+r6WFZZLsXE
        6Yd85nWZKrP9khtbarKFEPT6Nv1ak3Xk4tUMpyTIr7arQT6F2nNEfgsZZAMlOpV70PybV7QEfOeKV
        UgzKslZ8MvCxRlc/gpF3Jmz30m9TM6zSmbrF12pelPbxLaewmCJ0Qx0EE5q8PSI8gKVTwooCCa8SP
        QBwaqERg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1loR6j-00B9Y9-P1; Wed, 02 Jun 2021 13:40:36 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 59BCF300269;
        Wed,  2 Jun 2021 15:40:29 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4250F2BE6588B; Wed,  2 Jun 2021 15:40:29 +0200 (CEST)
Date:   Wed, 2 Jun 2021 15:40:29 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Eric Dumazet <eric.dumazet@gmail.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Guenter Roeck <groeck@google.com>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] sched/debug: remove obsolete init_schedstats()
Message-ID: <YLeKTXYExADomHY4@hirez.programming.kicks-ass.net>
References: <20210602112108.1709635-1-eric.dumazet@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210602112108.1709635-1-eric.dumazet@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 02, 2021 at 04:21:08AM -0700, Eric Dumazet wrote:
> From: Eric Dumazet <edumazet@google.com>
> 
> Revert "sched/debug: Fix 'schedstats=enable' cmdline option"
> 
> This reverts commit 4698f88c06b893f2acc0b443004a53bf490fde7c.
> 
> After commit 6041186a3258 ("init: initialize jump labels before command
> line option parsing") we can rely on jump label infra being ready for use
> when setup_schedstats() is called.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Thanks!
