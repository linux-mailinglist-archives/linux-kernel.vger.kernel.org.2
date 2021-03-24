Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C52F8348133
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 20:05:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237691AbhCXTFG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 15:05:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237726AbhCXTEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 15:04:48 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79668C061763
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 12:04:47 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id x126so18049252pfc.13
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 12:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=A6Nc9aMcq7+EQ6dTXC6K5AV/+r3Lw/sToxnXYeBBrHg=;
        b=TG9ZdBbsC14dV/G8r6EC4apbfUONcaQ+4FikYf7V3wU5EHgnpwXTa3pqy3t5awCWPA
         bq2xeScTiikkcJ5f8Ku/xPhKhNpsgodybG4FwG2kzuegE6NRv6EhgjwhRTgzWnNadewf
         K1/UVIuvSI12YfcVELAtScF+GScUZqodT5LIjtA1conVZSTrXUX8BXpitefSL0a1hcW4
         14hRGiu7qxZUpvKSrKx1EScWSeRjO6ERDl6vnUUmd3pmc6m/kcMxM2oKzRKCOrXtfGkd
         dphpm8O9U8nk/NnvzMMKXVQ2ld/NyWa0RNMhAwTXEJCCnor3UT8wvHN6gTA+OuWKSBJd
         Utrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=A6Nc9aMcq7+EQ6dTXC6K5AV/+r3Lw/sToxnXYeBBrHg=;
        b=XY8DLv5LzGnnlvJbphGhShFXNrEesmv89baIMHigp35QQhkS4/gfWaBl0m5u44hXGq
         wZuYxcyEwOl62o0xuVOv5uYClxlFFBUZouxHLVdG2w+SVBPkiqaEk3LIkHZYriWFFt5/
         97S5v6rcFnPFJpKXb03IFup24DKeMiSjo8RnYBNqAinTxwR/XfcZt+HpKC6eRVaKn9mW
         ddnoqiS7/3SYSrLfakiy6S6OLelowjxTVFxlVMenPwSyVMdFjHW24LwBjYOX9d/hZpLl
         OgwEorwKyINJo0way0o6TsQa6JfjBf0dpDScfISAid3J08gdnRiWbCvrDckEFrRupBQN
         5PYw==
X-Gm-Message-State: AOAM532u2e6Oto/MEVjcM+AXY8PSYf3Vem6/2/psuyAYH7JUmQCM0CL6
        AKWaj99ixWTiJgizy3+ApSwMiA==
X-Google-Smtp-Source: ABdhPJxlGHQwXuLGkqxg81umxZd6iX089au/ES9PkkTU1JTdQlDXHcccm+lnM11MQ123uHAXPysWcA==
X-Received: by 2002:a63:d449:: with SMTP id i9mr4121104pgj.227.1616612686794;
        Wed, 24 Mar 2021 12:04:46 -0700 (PDT)
Received: from [2620:15c:17:3:4192:718f:4827:be5] ([2620:15c:17:3:4192:718f:4827:be5])
        by smtp.gmail.com with ESMTPSA id y24sm3225118pfn.213.2021.03.24.12.04.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 12:04:45 -0700 (PDT)
Date:   Wed, 24 Mar 2021 12:04:45 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Uladzislau Rezki <urezki@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v2 3/4] mm/vmalloc: Use kvmalloc to allocate the table
 of pages
In-Reply-To: <20210324150518.2734402-4-willy@infradead.org>
Message-ID: <9e3d5e8a-4e47-d29a-8474-925036d8e5b@google.com>
References: <20210324150518.2734402-1-willy@infradead.org> <20210324150518.2734402-4-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Mar 2021, Matthew Wilcox (Oracle) wrote:

> If we're trying to allocate 4MB of memory, the table will be 8KiB in size
> (1024 pointers * 8 bytes per pointer), which can usually be satisfied
> by a kmalloc (which is significantly faster).  Instead of changing this
> open-coded implementation, just use kvmalloc().
> 
> This improves the allocation speed of vmalloc(4MB) by approximately
> 5% in our benchmark.  It's still dominated by the 1024 calls to
> alloc_pages_node(), which will be the subject of a later patch.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Acked-by: David Rientjes <rientjes@google.com>
