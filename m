Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CCEA3A9963
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 13:39:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232432AbhFPLlS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 07:41:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230330AbhFPLlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 07:41:18 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27AB2C061574
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 04:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=XtPVmlK1jzNcS6yikiAXkTW3U1VbjKSd7AQa7GX2l+U=; b=VSgy1b2rGNHUdtv6AvJhe9MoyG
        AKi+vmOnYWJUTGcxuTNWvLMC/rl9iF+YsUXJB6LsdJGQFYcyXqKPzo0ixn/biXUm5JPQ8eiNTkU/u
        VkRxuKu/wMdsQX1ad6X6M+HbVsASs4PnR3ys8uHVBHqKQk0fNeQZBfjTkYmm1KVj6BHA4TO0PFMOG
        y/5qnEADPOzXpig5vmQ9nyQnCu+5m/HMeThvECxCyB/fFEcuDN9QuurX0uFm/snGH9GE0An9sykDG
        zNv4o6LY7CKZYhMJ3anW6uuda+E8tCL5RMZb9ZKwUyAcKoH6ru7ouJPPuMan8e4VUsSW+4H33r9dF
        /XbblJAQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ltTsp-008JFs-Uw; Wed, 16 Jun 2021 11:39:06 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 30571300204;
        Wed, 16 Jun 2021 13:39:06 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0079520C169EA; Wed, 16 Jun 2021 13:39:05 +0200 (CEST)
Date:   Wed, 16 Jun 2021 13:39:05 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ley Foon Tan <lftan.linux@gmail.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: sched: Question about big and little cores system with SMP and
 EAS
Message-ID: <YMni2eclmqf05cL4@hirez.programming.kicks-ass.net>
References: <CAFiDJ5-ZO=BuSwBPPPecZhLyjyipTLenQxgCK=t52Pj7r659sQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFiDJ5-ZO=BuSwBPPPecZhLyjyipTLenQxgCK=t52Pj7r659sQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 16, 2021 at 07:29:26PM +0800, Ley Foon Tan wrote:
> Hi all
> 
> Would like to ask the experts here regarding the Symmetric
> Multi-Processing mode (SMP) with Energy aware scheduler (EAS) support
> on the big + little cores system.

And the you ask a question unrelated to either Symmetric MP or EAS :-)

> Hardware system:
> Big and little cores have almost the same ISA, but the big core has
> some extension instructions that little core doesn't have.

That problem is unrelated to big.Little / EAS, also by definition that
is not SMP seeing how the 'S' is a blatant lie.

The simplest solution is to simply disallow usage of the extended ISA
and force mandate the common subset. The complicated answer is something
along the lines of:

  https://lkml.kernel.org/r/20210608180313.11502-1-will@kernel.org
