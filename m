Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08A9430C818
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 18:44:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237627AbhBBRlG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 12:41:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:47920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237626AbhBBRh4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 12:37:56 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 700A164F6B;
        Tue,  2 Feb 2021 17:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612287435;
        bh=Q5IXGz4agDy9l+eqDqusJEsm5r3+bp1i2JQICg3Sb68=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rOR49h7ioJoHRRu5wIYcUXazOLckzJoNzfEV3hbml47dbWe4z0657cijt/Nz8JJ/W
         Y68M2Y+uig8GpuIQD4jZlGffvlPWh1ZtJbBT+hc4yVpBRtghugXe7Vj++SNtaGTp3s
         RE0W636qwLqAeLeLVzfpwcLVrufiWqk0JCbXPZJr63Fy11w2ARUqiSdwsWN+JZepsa
         JbKzoIEx81P8nPMS3PH6Cbs6llixrsMMnmmne4hBl9v5IwYZDcd0ljqoyNROCDF/Ta
         NziQUEJ7C4SG2uK2SChu3+Qj7huntndezUE63PkmYT9XdGc41SNf/9hBINN70P3A2+
         xLv20C+mkmmpg==
Date:   Tue, 2 Feb 2021 19:37:08 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Sean Christopherson <seanjc@google.com>, ira.weiny@intel.com,
        linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org
Subject: Re: [PATCH] x86: Remove unnecessary kmap() from
 sgx_ioc_enclave_init()
Message-ID: <YBmNxAW8jYTqg/IF@kernel.org>
References: <20210129001459.1538805-1-ira.weiny@intel.com>
 <YBRH2jfPKS8ZofMZ@google.com>
 <20210201084812.GA3229269@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210201084812.GA3229269@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 01, 2021 at 08:48:12AM +0000, Christoph Hellwig wrote:
> On Fri, Jan 29, 2021 at 09:37:30AM -0800, Sean Christopherson wrote:
> > On Thu, Jan 28, 2021, ira.weiny@intel.com wrote:
> > > From: Ira Weiny <ira.weiny@intel.com>
> > > 
> > > There is no reason to alloc a page and kmap it to store this temporary
> > > data from the user. 
> > 
> > Actually, there is, it's just poorly documented.  The sigstruct needs to be
> > page aligned, and the token needs to be 512-byte aligned.  kmcalloc doesn't
> > guarantee alignment.  IIRC things will work until slub_debug is enabled, at
> > which point the natural alignment behavior goes out the window.
> 
> Well, there still is absolutely no need for the kmap as you can use
> page_address for a GFP_KERNEL allocation.

Yeah, we do that in sgx_ioc_enclave_create already based on feedback:

        secs = kmalloc(PAGE_SIZE, GFP_KERNEL);
        if (!secs)
                return -ENOMEM;
        
The kmap() in sgx_ioc_enclave_init() is an unfortunate miss. Let's just
follow the pre-existing pattern.

/Jarkko
