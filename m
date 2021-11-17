Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0102B454711
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 14:20:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237466AbhKQNXH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 08:23:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232270AbhKQNXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 08:23:06 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4665C061570
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 05:20:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=GmiZj8sWSkK1ZozqITiUiasPtEGPR1td8EgcpndVpcE=; b=kTQgHYPwq0Nh1svgre1DlvBxJq
        DeG3iBpQNABdRVrRHJq3Pb+qjLPy7nS2l/nQtO1NvlrxaErll1X9w0XEDKy6IAtpnXiz5oBaNuTEx
        OhRcDnwSkhAH/oNKXe66vJ1ANUpf9o3MFh+VFkZXpaYlYERKvqrOwwO1+wrnXOSqWPCm+75wZJ2Xk
        fwfOByqYshQHmZgVvg7LQrmswqq1IHHw6wk0aY0PERdxzcoJJEfLh2H5qvoIGJKtmvHPXFWfPho0z
        +N0ENQ47rGFqJzpV/EaJrBXveMrhf+nlYiEPOGHS/zSkTNNR5Fincem4i0f1RjnO3QR7Ibl9Hd5h4
        DK+gf7KA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mnKr4-007ctd-K3; Wed, 17 Nov 2021 13:20:02 +0000
Date:   Wed, 17 Nov 2021 13:20:02 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     David Howells <dhowells@redhat.com>, linux-mm@kvack.org,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: Export PageHeadHuge()
Message-ID: <YZUBgs+2PtnsmTAw@casper.infradead.org>
References: <163707085314.3221130.14783857863702203440.stgit@warthog.procyon.org.uk>
 <20211117083623.elcauwjasw2hbuqi@box.shutemov.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211117083623.elcauwjasw2hbuqi@box.shutemov.name>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 17, 2021 at 11:36:23AM +0300, Kirill A. Shutemov wrote:
> On Tue, Nov 16, 2021 at 01:54:13PM +0000, David Howells wrote:
> > Export PageHeadHuge() - it's used by folio_test_hugetlb() and thence by
> > folio_file_page() and folio_contains().
> 
> Maybe move it to page-flag.h instead? It is trivial enough.

HUGETLB_PAGE_DTOR is defined in mm.h so there's a bit of a dependency
problem there.
