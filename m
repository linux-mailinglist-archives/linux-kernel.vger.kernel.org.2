Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59F733C40EB
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 03:30:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbhGLBd3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jul 2021 21:33:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbhGLBd3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jul 2021 21:33:29 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DC59C0613DD
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jul 2021 18:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2KQDqhz4TIYF3Ugv03ZS6ZNGsJcwPUEkeYX3JFGuTNQ=; b=a/MMF+QDk2zyAwnUwBh/rXbQRz
        ruiFOlP9FMnBilOCx+IlHNgDEmIn6+Cq7OzPEb9+lEQRjEmyEZFyO8SPA1xs3NF0mtlucNKr+Ww0N
        9/RewVPnkmLd+seCJg/Tb4x+3z0sEtkW2hd9mXmK1/1W1mK32WWrmg0qOHIcDIt7mg8ucnXWeUsLy
        WhQrGjVWIlOn5PmsPXqDxO/qjhNosyUL/Y0vUzlk57HQ61Jh0utrm+88BXbdh9kIahmGlPiocnBTg
        cFZPQjB8BAYKTEfBWOUgtA6QMnjVF+oSYnjuJTzt8vm77eMjCh6lHwG5M8OlnIDdv36TpMuL8eMgW
        gRjATmJw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m2km2-00Giyz-Px; Mon, 12 Jul 2021 01:30:25 +0000
Date:   Mon, 12 Jul 2021 02:30:18 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "Longpeng (Mike, Cloud Infrastructure Service Product Dept.)" 
        <longpeng2@huawei.com>
Cc:     Steven Sistare <steven.sistare@oracle.com>,
        Anthony Yznaga <anthony.yznaga@oracle.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        "Gonglei (Arei)" <arei.gonglei@huawei.com>
Subject: Re: [RFC PATCH 0/5] madvise MADV_DOEXEC
Message-ID: <YOubKmDwxMIvdAed@casper.infradead.org>
References: <1595869887-23307-1-git-send-email-anthony.yznaga@oracle.com>
 <cc714571-4461-c9e0-7b24-e213664caa54@huawei.com>
 <43471cbb-67c6-f189-ef12-0f8302e81b06@oracle.com>
 <a1dbf12e-9949-109e-122c-ba7ba609801b@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a1dbf12e-9949-109e-122c-ba7ba609801b@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 12, 2021 at 09:05:45AM +0800, Longpeng (Mike, Cloud Infrastructure Service Product Dept.) wrote:
> Let me describe my use case more clearly (just ignore if you're not interested
> in it):
> 
> 1. Prog A mmap() 4GB memory (anon or file-mapping), suppose the allocated VA
> range is [0x40000000,0x140000000)
> 
> 2. Prog A specifies [0x48000000,0x50000000) and [0x80000000,0x100000000) will be
> shared by its child.
> 
> 3. Prog A fork() Prog B and then Prog B exec() a new ELF binary.
> 
> 4. Prog B notice the shared ranges (e.g. by input parameters or ...) and remap
> them to a continuous VA range.

This is dangerous.  There must be an active step for Prog B to accept
Prog A's ranges into its address space.  Otherwise Prog A could almost
completely fill Prog B's address space and so control where Prog B
places its mappings.  It could also provoke a latent bug in Prog B
if it doesn't handle address space exhaustion gracefully.

I had a proposal to handle this.  Would it meet your requirements?
https://lore.kernel.org/lkml/20200730152250.GG23808@casper.infradead.org/
