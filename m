Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D685E3B8EB2
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 10:15:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234941AbhGAIRu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 04:17:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234635AbhGAIRt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 04:17:49 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6267C061756
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jul 2021 01:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1r4aB2jwn8yq7PguvAHI83p9WkRrP9o6Dj8f0dl7ZVM=; b=atB86pDZ/NnKUV3o1VvcG9Ck4z
        e6e/b+XRYYwmErtpDdp++MUOddxB+QIDFdckh/xzKtkBE2KoVMsdqcpnXirDH44GiCHuPcHHTvQQl
        uKHVvXH/F1QDzdu8Qa36DvalLZFEEX3zcGNNfxFXZNuJG4QEyPSfpcfNP4VQIc8FB2MxExtKWJlJJ
        W8MMDXMusYUWo1RgmfK/OukF6+mT0iRPwGx7lhzRVZhurqRebHX0W4IlDLKSzXg7KrAUghZMLzxb+
        YqVxFUVBikH73BzLBjFVi9IjVeTdOjMf4Ln1Q2NSsEEyxB0yb2xV1n21zNeCzedfpwEQocBJReugl
        F4i4eCzw==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lyrpj-006KhA-EX; Thu, 01 Jul 2021 08:14:12 +0000
Date:   Thu, 1 Jul 2021 09:14:03 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        ????????? <ohoono.kwon@samsung.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>,
        "ohkwon1043@gmail.com" <ohkwon1043@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: cleancache: fix potential race in cleancache apis
Message-ID: <YN15Sy8/Yy33hGlz@infradead.org>
References: <CGME20210630073310epcms1p2ad6803cfd9dbc8ab501c4c99f799f4da@epcms1p2>
 <20210630073310epcms1p2ad6803cfd9dbc8ab501c4c99f799f4da@epcms1p2>
 <YNwnqOuFlIG6Jofy@kroah.com>
 <YNxVAZDttnWncNUy@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNxVAZDttnWncNUy@casper.infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 30, 2021 at 12:26:57PM +0100, Matthew Wilcox wrote:
> I have a commit I haven't submitted yet with this changelog:
> 
>     Remove cleancache
> 
>     The last cleancache backend was deleted in v5.3 ("xen: remove tmem
>     driver"), so it has been unused since.  Remove all its filesystem hooks.
> 
>     Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

This would be really helpful.  cleancache is such mess.
