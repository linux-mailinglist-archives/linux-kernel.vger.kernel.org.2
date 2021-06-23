Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 416C03B146E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 09:13:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbhFWHPa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 03:15:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbhFWHP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 03:15:29 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E1BBC061574
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 00:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=LjIbOik+tUzV2FAD2na1696gFXMGb7R+P+hDuHHFZOI=; b=JAZPOKEMwDPIg03f1aYgme25zA
        g9aQTjfMe07QbFC3mfhnrgbQlD/YUrJ38nUhvqx5RZQxUNLxFHUX1VD+YHbDEI0M0iMNJtuydIwqd
        GLisIytMEGBdipVxvGUj6Z3CqozBv8W5rX0fijltGRJHwMb2GP6sLaM35qj6d/18pBVi2cfV28tzQ
        s/U/cWaCk5fLB5Sn7Y+3ED2asMw91BZ7E5e5uQYkunpOzgmm8U1MHSifaCXFKH7TZnx6XliHz9zr+
        Qu4gM+hHyUyyLbQzr1Zg38NzDeSpz2B/XnurpGeEzZ32ijQG1BahdQRVJl5J+QpMb25u91sTI5oSH
        5kjUycFg==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lvx3B-00F8z9-5R; Wed, 23 Jun 2021 07:12:02 +0000
Date:   Wed, 23 Jun 2021 08:11:53 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Jisheng Zhang <jszhang3@mail.ustc.edu.cn>
Cc:     Alexandre Ghiti <alex@ghiti.fr>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jisheng Zhang <jszhang@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Zong Li <zong.li@sifive.com>, Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 1/2] riscv: Introduce set_kernel_memory helper
Message-ID: <YNLeuR9j5DE1zcLY@infradead.org>
References: <20210622082134.2404162-1-alex@ghiti.fr>
 <20210622082134.2404162-2-alex@ghiti.fr>
 <20210622225304.53d94c0b@xhacker>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210622225304.53d94c0b@xhacker>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 22, 2021 at 10:53:04PM +0800, Jisheng Zhang wrote:
> >  
> > +__always_inline int set_kernel_memory(char *startp, char *endp,
> 
> If __always_inline, can it be moved to set_memory.h?

Yes, __always_inline pretty much only makes sense as
"static __always_inline" anyway.
