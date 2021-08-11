Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C4D63E8AA9
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 08:59:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234961AbhHKG7i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 02:59:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234770AbhHKG7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 02:59:38 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDA31C061765
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 23:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=XimkZqf7x1n5XEqY+N52qdgnIcMrFL9qCNABlasawcs=; b=Hft+tBCKJS5Cp5P4LCrP3BWmp7
        D92njh8+qM/aoikQGu3bVGGu6jYeT7eZmDURP9rQoSXNw1WNh38tP/6K0xgVa8xtDf2Vt/OY7VnfJ
        YcsLFGk5wg402tQ0Go2nyUYrU7nWvLk3V/LOTDg7ycsM5d6+FxnVYVL1xuRyUBheI4eTry4q7gHB+
        xDL2ePB8EHqqdrqdFbk6RVSQbAYhpjvRv0w7aKwfWhqaZE8msf/Rx1bbziPWA1BDdCZZ2YXj9CG1s
        iU/SNrZW1e+qe4mhg1AJzGa1remL2LdjQkqMtPWxILLhERcc+NM93mVHAIkHINaFiISZVzRJnc1ph
        7G0IZS7w==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mDiB3-00D5uf-5z; Wed, 11 Aug 2021 06:57:34 +0000
Date:   Wed, 11 Aug 2021 07:57:25 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Konrad Rzeszutek Wilk <konrad@darnok.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Maurizio Lombardi <mlombard@redhat.com>, rppt@kernel.org,
        bp@alien8.de, tglx@linutronix.de, x86@kernel.org,
        pjones@redhat.com, konrad@kernel.org, george.kennedy@oracle.com,
        rafael@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3] iscsi_ibft: fix crash due to KASLR physical memory
 remapping
Message-ID: <YRN01YySPVucdCF0@infradead.org>
References: <20210729135250.32212-1-mlombard@redhat.com>
 <YRKwqAlgWVGVpEJv@infradead.org>
 <YRK9fxhyPgEzWKce@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YRK9fxhyPgEzWKce@localhost.localdomain>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 10, 2021 at 01:55:11PM -0400, Konrad Rzeszutek Wilk wrote:
> On Tue, Aug 10, 2021 at 06:00:24PM +0100, Christoph Hellwig wrote:
> > > Fix this bug by saving the address of the physical location
> > > of the ibft; later the driver will use isa_bus_to_virt() to get
> > > the correct virtual address.
> > 
> > That sound rather broken.  Why not save the physical address in
> > find_ibft_region and then later ioremap that when a virtual address is
> > needed like all other code accessing magic I/O memory?
> 
> That is kind of what he does. The physical address is saved as a global
> static variable and also the physical address is memreserved. Then
> later on the physical address is used to create the virtual address.

Except that it uses isa_bus_to_virt, which is really broken.

> Or are you thinking of making the find_ibft_region reserve the physical
> address, and _cache_ the physical address so there is no global
> variable ?

No.  Just switch to ioremap/early_ioremap insted of this isa_bus_to_virt
mess.
