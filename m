Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0BC335BBB8
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 10:09:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237141AbhDLIJ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 04:09:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236808AbhDLIJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 04:09:26 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4E62C061574
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 01:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=DVIe+4d9I+G/am9Q3PISMJopYc/lkfgh9KdMieTh7Y0=; b=m6p33ZtUeh8y5beGxwx6STY+bL
        nMh8lFYg+sp9LP+GWzHHPhf+kjX0C9yaDplOYNSWj2fT1R51JhCnkXrA5tuwVtwpHAuUeDGHzkiMY
        xtg897nAI0LowhlXyL1NUeztXMipuT/XDBLLayK7Y+FiyAGLUQJWaGqP+oAwH34DgAQKva1Wc9aTG
        5DLJ70goPvpnRkUYERmAtO8lNrO+umO1D+TlV4mLSC76p8CH/ZSuO+6g7h0yqKACDo17PP0ZDN7CU
        yx+3YC/1Hmcu5ObrWma/HrptEIu3LQERKl7yQxuJhkVA+NTwfgnHTQnGYpF5cHRHRcVKde0T/X5JU
        yYwP99kw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lVrck-0063yC-Oe; Mon, 12 Apr 2021 08:08:46 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7BD63300222;
        Mon, 12 Apr 2021 10:08:44 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 3262620224231; Mon, 12 Apr 2021 10:08:44 +0200 (CEST)
Message-ID: <20210412080611.568192782@infradead.org>
User-Agent: quilt/0.66
Date:   Mon, 12 Apr 2021 10:00:13 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        boris.ostrovsky@oracle.com, jgross@suse.com,
        sstabellini@kernel.org, x86@kernel.org,
        jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, chris@chris-wilson.co.uk,
        intel-gfx@lists.freedesktop.org, linux-mm@kvack.org,
        keescook@chromium.org, hch@lst.de
Subject: [PATCH 1/7] mm: Unexport apply_to_existing_page_range()
References: <20210412080012.357146277@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are no modular in-tree users, remove the EXPORT.

This is an unsafe function in that it gives direct access to the
page-tables.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 mm/memory.c |    1 -
 1 file changed, 1 deletion(-)

--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2558,7 +2558,6 @@ int apply_to_existing_page_range(struct
 {
 	return __apply_to_page_range(mm, addr, size, fn, data, false);
 }
-EXPORT_SYMBOL_GPL(apply_to_existing_page_range);
 
 /*
  * handle_pte_fault chooses page fault handler according to an entry which was


