Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 635E0366CE5
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 15:33:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241193AbhDUNdz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 09:33:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239412AbhDUNdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 09:33:52 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CA8BC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 06:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=m8+ukUnKX1UN4v+oEFo61NeqPbdozFzIkzd1W6ilz2c=; b=NpAIwf66aozx1FI0vafphGaIzm
        Nf3+CvhIYsqvOqLsT+/ymDDoj2qubI+Gk0j+3ktoXiLMHK441VG6MUEUhsnA1CR7SPeS9nP8ibSVh
        xhgcNjNR5gZ6LDbZGa3XVEHD8fo0+bjtAVrBq9/cdgIZv9unG5iROOv9g3G1RZKmSeZF/mSfvI7dK
        vHgbBYcTJc56lBar0iCGfSgsgQLS9GB0FTtuFi5MLkxOS7hYt/wSQ896v2hbyg3HwPaaQOZJtPBbu
        xY0O5OuxQ7pyJ0cOoJN2UpKdLa0005eIm3jPdFxGrdKEh1tO2uPsx/DFfmSAwmvENqCBdrw8gEwDq
        AyN9SdlA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lZCyY-00ETCz-4t; Wed, 21 Apr 2021 13:33:08 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B8B6730013E;
        Wed, 21 Apr 2021 15:33:04 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 68AA428582675; Wed, 21 Apr 2021 15:33:04 +0200 (CEST)
Date:   Wed, 21 Apr 2021 15:33:04 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     joel@joelfernandes.org, chris.hyser@oracle.com, joshdon@google.com,
        mingo@kernel.org, vincent.guittot@linaro.org,
        valentin.schneider@arm.com, mgorman@suse.de
Cc:     linux-kernel@vger.kernel.org, tj@kernel.org, tglx@linutronix.de
Subject: Re: [PATCH 4/9] sched: Default core-sched policy
Message-ID: <YIApkMU+2jZHUVD7@hirez.programming.kicks-ass.net>
References: <20210401131012.395311786@infradead.org>
 <20210401133917.291069972@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210401133917.291069972@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 01, 2021 at 03:10:16PM +0200, Peter Zijlstra wrote:
> Implement default core scheduling policy.
> 
>  - fork() / clone(): inherit cookie from parent
>  - exec(): if cookie then new cookie
> 
> Did that exec() thing want to change cookie on suid instead, just like
> perf_event_exit_task() ?

Talk to me about that exec() thing; I still think it's weird. Did we
just want to drop cookie on suid instead?
