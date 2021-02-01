Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFB3C30A38D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 09:50:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232608AbhBAItJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 03:49:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232177AbhBAItE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 03:49:04 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EBDAC061573;
        Mon,  1 Feb 2021 00:48:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=IpQ8g4KpVRrhCWJ47QRTJtxg75Bvmi8TXjdGJU/RBFE=; b=WoKJJ0Q4q+pUmOyxczhhYj0bmN
        bCgw8idFFIiXrGjY62xgh2BpmI/RTRwnmNZ5pmxUotzJ/XkWCYYaxspr4C2TB6WYCsMHpTJGrn+j3
        ewjfnff6oKHrvSrNRPY6iQlyb+unxvyo8ifSrU9xtJnLog5HU4W5/y1dq4jaA0zj4IVpnkNuRaRgL
        ILv4nXrku7ZKXAPZ2FM3hoex+0v24PtwoJ8XQWnVcHov9hxIs/0fPAj4BRfvvzthY4PVBYYzErsDL
        NsdQ1Xhca4DBQm7j0pu5vEapE2uGBhzZy5rEMZYe3r66W3UVgDn27d3B4mAz0eNESGqD9ZGTVyR7q
        qooZHt2Q==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l6UsW-00DYS1-OF; Mon, 01 Feb 2021 08:48:12 +0000
Date:   Mon, 1 Feb 2021 08:48:12 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Sean Christopherson <seanjc@google.com>
Cc:     ira.weiny@intel.com, Jarkko Sakkinen <jarkko@kernel.org>,
        linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org
Subject: Re: [PATCH] x86: Remove unnecessary kmap() from
 sgx_ioc_enclave_init()
Message-ID: <20210201084812.GA3229269@infradead.org>
References: <20210129001459.1538805-1-ira.weiny@intel.com>
 <YBRH2jfPKS8ZofMZ@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YBRH2jfPKS8ZofMZ@google.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 29, 2021 at 09:37:30AM -0800, Sean Christopherson wrote:
> On Thu, Jan 28, 2021, ira.weiny@intel.com wrote:
> > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > There is no reason to alloc a page and kmap it to store this temporary
> > data from the user. 
> 
> Actually, there is, it's just poorly documented.  The sigstruct needs to be
> page aligned, and the token needs to be 512-byte aligned.  kmcalloc doesn't
> guarantee alignment.  IIRC things will work until slub_debug is enabled, at
> which point the natural alignment behavior goes out the window.

Well, there still is absolutely no need for the kmap as you can use
page_address for a GFP_KERNEL allocation.
