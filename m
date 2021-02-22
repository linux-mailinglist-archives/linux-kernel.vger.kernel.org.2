Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55308322172
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 22:33:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231953AbhBVVcY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 16:32:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231939AbhBVVcN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 16:32:13 -0500
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F034EC061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 13:31:31 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id q186so15506729oig.12
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 13:31:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=WMA44PoUvfioyW3cHqKp4AAReznf8bJn7VnN6AdFIZc=;
        b=Cgdq8M1XpsfeBKNRkWZV/58VGOt5uwUJzitgP2Yk1Fh7dN/YDKUyHdLZRQNzV1W95u
         Ek1rWTCQun4e1FE7eTE9Q9SBfNuv9ZHVtEHFiljU6TZ1ijP6cBubJe2294lHmKDdmZX+
         NzDi6ZI8vqIa6CM4Ghq7WpUNULRCcqk7MB8uB2Y4kL49exWmXjv6jqH0ctkkoyefGlXg
         H7fZkHTisemJ5b0JuLpTYtFfqRpQrzysXEnMAjILJN5xh3ZsTSTv/ntEuqOk9Gvo2TOp
         MRg6fs+BHaRhqm9LCeoNJUY4R/XCF6Skq7n/sszMAAIgHYdikBvz30C27Qc9Q/prI1tI
         JOsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=WMA44PoUvfioyW3cHqKp4AAReznf8bJn7VnN6AdFIZc=;
        b=H4wwV+99fUQuFgCbQPDmXRojfAjuqOW5tC6E/h8R0iwHwN/AJQfYFQqk7AnkF7LT3k
         FygxXR1IdAx/h2nLcBFXvibtGmmusKkS3C6kbB9n5lYmlGnxgFUARD3PM0mwn/BqbxOa
         +iVt2Ex5YWWoh+597u7R8GxCtB6f54wxB77U+CaCuAY85Ck5ZEa8wjAVKBfDEZ7ZxkHd
         Frki0CFJyGFQWogsSuU6Cy4VHyHZej3N0pAB7Uk6iLvL7D4vthsltFPBQiodbG2Pt02i
         m2p+KPpK8Bord76wMX7ObGNXrk3kbmUPWRW40GSO+z/W2sJ8TbsehlnsiFU79Y4ZDFtd
         1L7g==
X-Gm-Message-State: AOAM533JNamOUs9je3hDuZfKBtUWJnDZb/9aDFB4TUz3isD6eailOpUG
        f7+pQGSmOw11nTmEjR71NCI0Pzwz5qsvcA==
X-Google-Smtp-Source: ABdhPJzUcgO9AGfbph+Zv0EBrbbZwKYK1FUCHGNVw7G5cSOpGLHLSp7ZNKPqKmxvC3L9ZR5zltgydQ==
X-Received: by 2002:a05:6808:693:: with SMTP id k19mr16852614oig.104.1614029491188;
        Mon, 22 Feb 2021 13:31:31 -0800 (PST)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 22sm2038743oix.11.2021.02.22.13.31.30
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Mon, 22 Feb 2021 13:31:30 -0800 (PST)
Date:   Mon, 22 Feb 2021 13:31:18 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Jens Axboe <axboe@kernel.dk>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] percpu_counter: increase batch count
In-Reply-To: <919b3aa5-7332-0817-3b70-4f20ae6410a8@kernel.dk>
Message-ID: <alpine.LSU.2.11.2102221309570.4728@eggly.anvils>
References: <0bf90e07-8758-b238-b3f3-a330725a1134@kernel.dk> <20210218151644.df430e4f77f763b7db2a004f@linux-foundation.org> <919b3aa5-7332-0817-3b70-4f20ae6410a8@kernel.dk>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Feb 2021, Jens Axboe wrote:
> On 2/18/21 4:16 PM, Andrew Morton wrote:
> > On Thu, 18 Feb 2021 14:36:31 -0700 Jens Axboe <axboe@kernel.dk> wrote:
> > 
> >> Currently we cap the batch count at max(32, 2*nr_online_cpus), which these
> >> days is kind of silly as systems have gotten much bigger than in 2009 when
> >> this heuristic was introduced.
> >>
> >> Bump it to capping it at 256 instead. This has a noticeable improvement
> >> for certain io_uring workloads, as io_uring tracks per-task inflight count
> >> using percpu counters.

I want to quibble with the word "capping" here, it's misleading -
but I'm sorry I cannot think of the right word.

The macro is max() not min(): you're making an improvement for
certain io_uring workloads on machines with 1 to 15 cpus, right?
Does "bigger than in 2009" apply to those?

Though, io_uring could as well use percpu_counter_add_batch() instead?

(Yeah, this has nothing to do with me really, but I was looking at
percpu_counter_compare() just now, for tmpfs reasons, so took more
interest.  Not objecting to a change, but the wording leaves me
wondering if the patch does what you think - or, not for the
first time, I'm confused.)

Hugh

> >>
> > 
> > It will also make percpu_counter_read() and
> > percpu_counter_read_positive() more inaccurate than at present.  Any
> > effects from this will take a while to discover.
> 
> It will, but the value of 32 is very low, especially when you are potentially
> doing millions of these per second. So I do think it should track the times
> a bit.
> 
> > But yes, worth trying - I'll add it to the post-rc1 pile.
> 
> Thanks!
> 
> -- 
> Jens Axboe
