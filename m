Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 162FC36EFB3
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 20:50:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241200AbhD2Suv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 14:50:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241017AbhD2Suu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 14:50:50 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0D79C06138B
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 11:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0dfv+SpEYuBEoQs4wiKFRhD+0Q3NTeyzHUqYGaZb7Wk=; b=bRq9ONSpF0k+zDoO5t39WyTOvc
        RddRmbO6JlqbMu5RCO/6ldfnnQc+Ancu95kwWHJB0p+EbC2yxY80PIgwt0s+ykddfQC2/l0lWsqju
        +4wQHrzFJ3HWMGKkADvAF5eMza2wmWYujHuZazW2dElckRGmtyGYwVI38q5ht0F/xe0SaYIJV8exC
        sWZRIVHoDuF4fcHBvGvMTfgW+vCMYJK7jz+As8dKlzUkB84b1rytwuRz+sbQuXzZ8TJywfUPQp2Ho
        GBXo6XHdjYEdJuHn+T9oRQ4KUkWfrf3Jng/0nf/Mz3BZ4h1N7T+r++Lem2b7eXV1UMXSmSSjuu1vf
        p5iwqrnQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lcBim-00A0d2-3F; Thu, 29 Apr 2021 18:49:20 +0000
Date:   Thu, 29 Apr 2021 19:49:08 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Michel Lespinasse <michel@lespinasse.org>,
        Andy Lutomirski <luto@kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Rik van Riel <riel@surriel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Rom Lemarchand <romlem@google.com>,
        Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 13/37] mm: implement speculative handling in
 __handle_mm_fault().
Message-ID: <20210429184908.GH1847222@casper.infradead.org>
References: <20210407014502.24091-1-michel@lespinasse.org>
 <20210407014502.24091-14-michel@lespinasse.org>
 <eee7431c-3dc8-ca3c-02fb-9e059d30e951@kernel.org>
 <20210428145823.GA856@lespinasse.org>
 <CALCETrVRGtVqv9cMSryfg5q3iZ9s3jBey20cY4K23YLRhQRzbQ@mail.gmail.com>
 <20210428161108.GP975577@paulmck-ThinkPad-P17-Gen-1>
 <20210429000225.GC10973@lespinasse.org>
 <20210429155250.GV975577@paulmck-ThinkPad-P17-Gen-1>
 <20210429183412.GA278623@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210429183412.GA278623@paulmck-ThinkPad-P17-Gen-1>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 29, 2021 at 11:34:12AM -0700, Paul E. McKenney wrote:
> +++ b/include/linux/rcupdate.h
> @@ -532,7 +532,10 @@ do {									      \
>   * @p: The pointer to read, prior to dereferencing
>   * @c: The conditions under which the dereference will take place
>   *
> - * This is the RCU-bh counterpart to rcu_dereference_check().
> + * This is the RCU-bh counterpart to rcu_dereference_check().  However,
> + * please note that in recent kernels, synchronize_rcu() waits for
> + * local_bh_disable() regions of code in addition to regions of code
> + * demarked by rcu_read_lock() and rcu_read_unlock().
>   */

I've been trying to get rid of "please note that" in my own documentation
recently.  It doesn't add any value.  Also, "recent kernels" is going to
go stale quickly, "Since v5.8" (or whatever) is good because it lets us
know in ten years that we can just delete the reference.

So I'd make this:

 * This is the RCU-bh equivalent of rcu_dereference_check().  Since v5.8,
 * synchronize_rcu() waits for code with bottom halves disabled as well
 * as code between rcu_read_lock() and rcu_read_unlock().

