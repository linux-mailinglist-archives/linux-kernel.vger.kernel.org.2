Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26ECE3E8AF7
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 09:20:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235539AbhHKHVA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 03:21:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:40630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235109AbhHKHU6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 03:20:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 379EB604AC;
        Wed, 11 Aug 2021 07:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628666434;
        bh=8mg42c76I6K4QVczZl3i8PdVlEZAiViH4ykH1/0qaxI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JiDYrDJV0dUpoMwMbNMr7BlJRaWCyoeOGIhC2S23kLCgZ9KfJnJPUenjUKGxTNcAl
         Y2BoMi21mxOjneKQlpjVbmYpoiybgfGGUbPu00qxc1nL2MmN+mlcQ4GUCi4MpFJfkd
         g9K6E0r188qWtIWVbGXeb/DMcKafROfhLJqjS7JAOzYeU28kp/mfb8wxqV98i4Qdkm
         aQR2xBFzp7+l2FcbcTcpnMM582sq7R1Zs9KqAtpqqbYNK4j1Q+ifW9u7q9Hrnh60Js
         7JsOqL+NPXIFvZ292rs9psirqZBspJCPmDgy6WD57j0ygHSGdZ/7o7U6R4Cbz5ouIf
         14miPA5Kzg9cQ==
Date:   Wed, 11 Aug 2021 10:20:28 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Konrad Rzeszutek Wilk <konrad@darnok.org>,
        Maurizio Lombardi <mlombard@redhat.com>, bp@alien8.de,
        tglx@linutronix.de, x86@kernel.org, pjones@redhat.com,
        konrad@kernel.org, george.kennedy@oracle.com, rafael@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3] iscsi_ibft: fix crash due to KASLR physical memory
 remapping
Message-ID: <YRN6PN9uZeauadRJ@kernel.org>
References: <20210729135250.32212-1-mlombard@redhat.com>
 <YRKwqAlgWVGVpEJv@infradead.org>
 <YRK9fxhyPgEzWKce@localhost.localdomain>
 <YRN01YySPVucdCF0@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YRN01YySPVucdCF0@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 11, 2021 at 07:57:25AM +0100, Christoph Hellwig wrote:
> On Tue, Aug 10, 2021 at 01:55:11PM -0400, Konrad Rzeszutek Wilk wrote:
> > On Tue, Aug 10, 2021 at 06:00:24PM +0100, Christoph Hellwig wrote:
> > > > Fix this bug by saving the address of the physical location
> > > > of the ibft; later the driver will use isa_bus_to_virt() to get
> > > > the correct virtual address.
> > > 
> > > That sound rather broken.  Why not save the physical address in
> > > find_ibft_region and then later ioremap that when a virtual address is
> > > needed like all other code accessing magic I/O memory?
> > 
> > That is kind of what he does. The physical address is saved as a global
> > static variable and also the physical address is memreserved. Then
> > later on the physical address is used to create the virtual address.
> 
> Except that it uses isa_bus_to_virt, which is really broken.
> 
> > Or are you thinking of making the find_ibft_region reserve the physical
> > address, and _cache_ the physical address so there is no global
> > variable ?
> 
> No.  Just switch to ioremap/early_ioremap insted of this isa_bus_to_virt
> mess.

Why ioremap? This is not IO memory, plain phys_to_virt should be fine here.

-- 
Sincerely yours,
Mike.
