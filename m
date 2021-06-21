Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 229DE3AEBE9
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 17:00:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbhFUPCY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 11:02:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbhFUPCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 11:02:22 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFE0CC061574
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 08:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=MeE5VfIcLBkueUaXBU3Nrjbln3thvwwMBj/aCLS5j/4=; b=oBr0Hw9vmpDFKSNZUUeCLbOE5F
        yVoJ+ZyG6xv11HZaLrK8Xuan4/NZ3o+vkj/jSUSl9+PKtPl9LqwQ9Kj3Yp5w8kaS2ProRotfD7Wy8
        pmwdxtSw8liv7MtBo68/GxQ6sPM6TMNUr3ZG2k8Jw8CVmHTEpUM1fkLYWTH6vBankWS8lkgd8N6kB
        OirGjxUHt7SJ1RDCO/AS4fohI3ZT+HpktwNr1DSD430d1n9Iq9PvT0rw+el2C3Cs+qPJdqgWvtnFa
        w2KTWEvNC0reEcGo5FOlU6cXBwO4mB6CGpKatKKSTQD8zE/ZBr0fgHUZZ3A3Bq/jE55pf5NU3mehI
        CaOqoCDQ==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lvLNo-00DCuH-EW; Mon, 21 Jun 2021 14:58:47 +0000
Date:   Mon, 21 Jun 2021 15:58:40 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Alexandre Ghiti <alex@ghiti.fr>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jisheng Zhang <jszhang@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Zong Li <zong.li@sifive.com>, Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/2] riscv: Introduce set_kernel_memory helper
Message-ID: <YNCpIN3RSgVubHJC@infradead.org>
References: <20210617131734.1923932-1-alex@ghiti.fr>
 <20210617131734.1923932-2-alex@ghiti.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210617131734.1923932-2-alex@ghiti.fr>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 17, 2021 at 03:17:33PM +0200, Alexandre Ghiti wrote:
> +int set_kernel_memory(char *start, char *end, int (*set_memory)(unsigned long, int));

Pretty unreadable with the crazy long line and the missing parameter
names for the callback.  It probably is worth to implement this as
__always_inline so that the compiler unwinds the indirect call.
