Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDD2139717C
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 12:30:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232173AbhFAKbw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 06:31:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:55306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230262AbhFAKbs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 06:31:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2952A6139A;
        Tue,  1 Jun 2021 10:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1622543405;
        bh=kNAwLTC/vYzJzA7/OMnucxDZFPGz19LT0a5jL1f44lI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZfWrQ4xU5t4rNRZGYcTmWiq/f4QjWfNpaG/etiMivb8+dEWpYrx//MIO4lGjHFR71
         AYJw+hi0eK61uZmTKiShHFN0RZ1lqyP1MFWNmkV+RigeKXzqXw56KTy8CdqmDTqV0E
         t56eZ5hq2l7owkxSi+tjzYnXzCNJXDKwlkFYqQss=
Date:   Tue, 1 Jun 2021 12:30:03 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Faiyaz Mohammed <faiyazm@codeaurora.org>
Cc:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, vbabka@suse.cz,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        glittao@gmail.com, vinmenon@codeaurora.org
Subject: Re: [PATCH v8] mm: slub: move sysfs slab alloc/free interfaces to
 debugfs
Message-ID: <YLYMK65WocBy3qG6@kroah.com>
References: <1622542057-14632-1-git-send-email-faiyazm@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1622542057-14632-1-git-send-email-faiyazm@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 01, 2021 at 03:37:37PM +0530, Faiyaz Mohammed wrote:
> alloc_calls and free_calls implementation in sysfs have two issues,
> one is PAGE_SIZE limitiation of sysfs and other is it does not adhere
> to "one value per file" rule.
> 
> To overcome this issues, move the alloc_calls and free_calls implemeation
> to debugfs.
> 
> Debugfs cache will be created if SLAB_STORE_USER flag is set.
> 
> Rename the alloc_calls/free_calls to alloc_traces/free_traces,
> to be inline with what it does.
> 
> Signed-off-by: Faiyaz Mohammed <faiyazm@codeaurora.org>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
