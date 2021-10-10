Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 735914283A0
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Oct 2021 22:55:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232989AbhJJU5R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Oct 2021 16:57:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:47968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230355AbhJJU5Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Oct 2021 16:57:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 00D0160F22;
        Sun, 10 Oct 2021 20:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1633899317;
        bh=VYCfwXiqKXGp+9DR4kGNpPumSvCR33w/NigEzc864Uc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ce0Wp/bo+NqkOapQsnRUSupU2/wwmTEQw9dT3zM5utafLvqJYMZl4/j5dAE793RFK
         wY4cwrcgKbv+BwRRCKOwTbnenr3NqGQNkr9F+cZHphVvJTwh7eu9j5RXPOHb48+rND
         HJFNPxnJc8sJGdm6K0TFRYb6irR1wClntharx0i8=
Date:   Sun, 10 Oct 2021 13:55:07 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     mike.kravetz@oracle.com, mhocko@kernel.org, guro@fb.com,
        corbet@lwn.net, yaozhenguo1@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH] hugetlb: Support node specified when using cma for
 gigantic hugepages
Message-Id: <20211010135507.f2d1c6bcaeecc82d6d025604@linux-foundation.org>
In-Reply-To: <1633843448-966-1-git-send-email-baolin.wang@linux.alibaba.com>
References: <1633843448-966-1-git-send-email-baolin.wang@linux.alibaba.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 10 Oct 2021 13:24:08 +0800 Baolin Wang <baolin.wang@linux.alibaba.com> wrote:

> Now the size of CMA area for gigantic hugepages runtime allocation is
> balanced for all online nodes, but we also want to specify the size of
> CMA per-node, or only one node in some cases, which are similar with

Please describe in full detail why "we want to" do this.  In other
words, what is the benefit to our users?  What are the use-cases, etc?

> commit 86acc55c3d32 ("hugetlbfs: extend the definition of hugepages
> parameter to support node allocation")[1].
> 
> Thus this patch adds node format for 'hugetlb_cma' parameter to support
> specifying the size of CMA per-node. An example is as follows:
> 
> hugetlb_cma=0:5G,2:5G
> 
> which means allocating 5G size of CMA area on node 0 and node 2
> respectively.
> 

