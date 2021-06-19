Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66FCD3ADBF6
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jun 2021 00:17:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbhFSWTC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Jun 2021 18:19:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbhFSWTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jun 2021 18:19:01 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE997C061574
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jun 2021 15:16:49 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624141006;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4ojLj1mAhxhckAWs7K8QRLYCa1x/mjo9aEhFN3Fw818=;
        b=PMmheOBT9k568KrMl0wHpvuJC+csAVQ8YfMmOBpTTafrrNZfGiD0nOr7OkYq/WBVR3UxXQ
        fGutODuoZpz3FIvD+/YT3BUdBZ0SNs2XLRufDjT6JGazHbzCqhU92JBYmSdP6mj7qpgV6u
        LLrXBEn9vqvGBKPS8Wj93blRpp6TI2k/PnrvwVgfry32Y3a3OLkMb/V0FgjGGxhU4IDZX8
        FxRqaie0IAPNkfpZx7QV8yc02fAIQ4xU4WMlgio0YI2TFvE25YoD7vPLB/oX1yEtY6fXTn
        jp7TBSmILJARFs9cDbHi2BNJyBU+JjY0qKW9atjZPkRVw7bWQubGobo+LXmM0A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624141006;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4ojLj1mAhxhckAWs7K8QRLYCa1x/mjo9aEhFN3Fw818=;
        b=KrwT13ujgAJHCvubTWY/7hoBCLcVAPWeHqwBM8D9n6+u3U7ct3hO4LloPP1n62ahiM0rRZ
        KHB5oe+LT0/jylAw==
To:     Yaohui Wang <yaohuiwang@linux.alibaba.com>,
        dave.hansen@linux.intel.com
Cc:     luto@kernel.org, peterz@infradead.org, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, linux-kernel@vger.kernel.org,
        Ben Luo <luoben@linux.alibaba.com>,
        Yahui Wang <yaohuiwang@linux.alibaba.com>
Subject: Re: [PATCH v2 2/2] mm: fix boundary judgment issues in kernel/resource.c
In-Reply-To: <20210611042147.80744-3-yaohuiwang@linux.alibaba.com>
References: <20210611042147.80744-1-yaohuiwang@linux.alibaba.com> <20210611042147.80744-3-yaohuiwang@linux.alibaba.com>
Date:   Sun, 20 Jun 2021 00:16:45 +0200
Message-ID: <87k0mph54i.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yaohui!

On Fri, Jun 11 2021 at 12:21, Yaohui Wang wrote:

The same formal issues as with patch #1

> The original boundary judgment may ignore @end if @end equals @start. For

May means it can but it must not. But this is not the case here. end
equals start is always ignored.

Also 'original' is meaningless here. Before the patch is applied the
code is that way.

 find_next_iomem_res() and __walk_iomem_res_desc() require that the
 provided end address is larger than the start address, which ...


> example, if we call ioremap(phys, 1), then @end == @start, and the memory
> check will not be applied on the page where @end lives, which is
> unexpected.

Please avoid 'we' and 'I':

 is incorrect when ioremap() is invoked with length=1.

> In kernel/resource.c:find_next_iomem_res, the mem region is a closed

See the reply to #1 vs. function names. Also please write out 'memory',
there is no shortage of space in change logs.

> interval (i.e. [@start..@end]). So @start == @end should be allowed.

closed interval reads strange. The usual terminology is: The end address
is inclusive.

  Resources are described with the start address and the inclusive end
  address, which means for a resource with 1 byte length the start
  address is the same as the end address.

  find_next_iomem_res() and __walk_iomem_res_desc() ignore resources
  with 1 byte length, which prevents that ioremap(phys, 1) is checked
  whether it touches non ioremappable resources.

  ...

Thanks,

        tglx
