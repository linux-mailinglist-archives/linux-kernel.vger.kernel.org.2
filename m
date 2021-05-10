Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE740377B50
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 06:46:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbhEJErM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 00:47:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:46968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229863AbhEJErI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 00:47:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8E47D613CE;
        Mon, 10 May 2021 04:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1620621964;
        bh=rp7Pr5ZwLz7xf26y8soMdGC8+zpjFeP6bya6HohveU8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CqyexdQOXdYJurd8t44gilCxJyd/22uk3uYbXEYUkNJt1aSbnwkCuFEt6rLVjHaFQ
         ZtJ0VcZ4E1eih/esEpLdf/IQYyVMLueE6B2tv+RKF3LqRezylSovsacOdKMbEPZ4YL
         P9NiKYAR7R7YOj1GRmmDexSjy73xHqOshwnt2G+4=
Date:   Sun, 9 May 2021 21:46:03 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     glittao@gmail.com
Cc:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, vbabka@suse.cz,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] mm/slub: use stackdepot to save stack trace in objects
Message-Id: <20210509214603.d2a5faaa3fe0d71c3517cb36@linux-foundation.org>
In-Reply-To: <20210414163434.4376-1-glittao@gmail.com>
References: <20210414163434.4376-1-glittao@gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Apr 2021 18:34:34 +0200 glittao@gmail.com wrote:

> Many stack traces are similar so there are many similar arrays.
> Stackdepot saves each unique stack only once.
> 
> Replace field addrs in struct track with depot_stack_handle_t handle.
> Use stackdepot to save stack trace.
> 
> The benefits are smaller memory overhead and possibility to aggregate
> per-cache statistics in the future using the stackdepot handle
> instead of matching stacks manually.

Which tree was this prepared against?  5.12's kmem_obj_info() is
significantly different from the version you were working on.

Please take a look, redo, retest and resend?  Thanks.
