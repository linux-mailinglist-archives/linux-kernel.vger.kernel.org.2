Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98FC737ED78
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 00:41:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345533AbhELUgF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 16:36:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:56772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344347AbhELULy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 16:11:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E584D61408;
        Wed, 12 May 2021 20:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620850243;
        bh=KiSht4eykHbuRx4encDVma3UC0WdUp6sYB51Ups/XBQ=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=oe+sv3ILc/RC+aVoS4W+Yefy9KsbBFO5a0a/INlcBlqGDSktVFnmkAeXr/w639z41
         FF6tet/bKQ9itBDU7qZ50bOtG4N5MDKvqG9wXs9XE5I7LA6RUYdRx25BxbmF5tLeM8
         vC7jRmufvNf0Cfxf5++3NwAC67oEPQXe/Acw1pHjw6tfLBhINnc8MFktxvcakjlL3t
         7tHb+8HFZ7QQHeyqwmf1dF6OY5SnoGvdYQ04BKAkHWVg+Q0awZtJSeCSnfthbMy5YS
         pp9vmID2lox89aKRN67CxlsLOK/QV8v48IrBEG+cQCZbXsRdFaQTNxlDH3SPOPnQnj
         ShdB+57YHYeuw==
Date:   Wed, 12 May 2021 13:10:42 -0700 (PDT)
From:   Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@sstabellini-ThinkPad-T480s
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>
cc:     Stefano Stabellini <sstabellini@kernel.org>,
        xen-devel@lists.xenproject.org, hch@lst.de,
        linux-kernel@vger.kernel.org,
        Stefano Stabellini <stefano.stabellini@xilinx.com>,
        jgross@suse.com
Subject: Re: [PATCH 2/2] xen/swiotlb: check if the swiotlb has already been
 initialized
In-Reply-To: <2e5a684b-3c74-5efc-2946-8ca002894ab4@oracle.com>
Message-ID: <alpine.DEB.2.21.2105121310210.5018@sstabellini-ThinkPad-T480s>
References: <20210511174142.12742-2-sstabellini@kernel.org> <2e5a684b-3c74-5efc-2946-8ca002894ab4@oracle.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 May 2021, Boris Ostrovsky wrote:
> On 5/11/21 1:41 PM, Stefano Stabellini wrote:
> > --- a/drivers/xen/swiotlb-xen.c
> > +++ b/drivers/xen/swiotlb-xen.c
> > @@ -164,6 +164,11 @@ int __ref xen_swiotlb_init(void)
> >  	int rc = -ENOMEM;
> >  	char *start;
> >  
> > +	if (io_tlb_default_mem != NULL) {
> > +		printk(KERN_WARNING "Xen-SWIOTLB: swiotlb buffer already initialized\n");
> 
> 
> pr_warn().
> 
> 
> Reviewed-by: Boris Ostrovsky <boris.ostrvsky@oracle.com>

Thank you! I'll send a v2 shortly with the change to pr_warn and your
reviewed-by.
