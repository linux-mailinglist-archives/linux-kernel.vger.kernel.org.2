Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 238CD43B910
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 20:09:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238093AbhJZSL7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 14:11:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238092AbhJZSL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 14:11:56 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3773C061745
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 11:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3Tjz+lVq4oCNPYNd2IGwBHt10T5b5l25ZLdzDs0m/hE=; b=S08qK0hhKI9+4O/T3ksI+N501W
        U02cVVD35YfWK5y4rHUjFKj+utv9T2O4ucSENENpzkFGYvvX3lbTxoniBVVoeteK+J46hg2x+hYEa
        OpbdEyt2fS0INss6AoYuRUGsUfW6lXBeGzs57jzPS9Z9XGuofqMpMUVRKaoZwFkMyaE9a2XSeNaTg
        jZE0OFBDiVmRIvfCW/TJMjQ+BGuz5t9kgdMyiTckwOCj1ogcNLo7k0UVX8V4f1eDrI5gLMpa9UvQ1
        GoMKSqiPyRQoAymznb27Y8dDiVPLT/f3ooWFsHAR4MkGxp4sSHj3F89qMLALPS3NcrNZdD7HTpvQQ
        emhLxWTQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mfQrh-00H3aS-Ks; Tue, 26 Oct 2021 18:08:19 +0000
Date:   Tue, 26 Oct 2021 19:08:01 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: move more expensive part of XA setup out of mapping
 check
Message-ID: <YXhEAZMf9Qrsev82@casper.infradead.org>
References: <49f67983-b802-8929-edab-d807f745c9ca@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49f67983-b802-8929-edab-d807f745c9ca@kernel.dk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 26, 2021 at 10:01:20AM -0600, Jens Axboe wrote:
> The fast path here is not needing any writeback, yet we spend time setting
> up the xarray lookup data upfront. Move the part that actually needs to
> iterate the address space mapping into a separate helper, saving ~30% of
> the time here.

No objection to this patch, but it did remind me that I never saw an answer to
https://lore.kernel.org/all/CAHk-=wg_-EwefQ_3Osz4iJxTrTk3tfrV53Z7-jaGg=tm9i5TXg@mail.gmail.com/
(and nor did lore)
