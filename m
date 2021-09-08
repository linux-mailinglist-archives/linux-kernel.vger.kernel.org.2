Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B447D4034CB
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 09:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347548AbhIHHJ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 03:09:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348036AbhIHHJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 03:09:16 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5220BC0613C1
        for <linux-kernel@vger.kernel.org>; Wed,  8 Sep 2021 00:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xTrVWx4u6aj0HJxIiwK6w63wBv8UFL6W0kryTgqQOBk=; b=UZnSHfGOxpfl5k2QHa5deLLAej
        zonJbx4n51ec8iDwWq3JYz2OPPMiVjGyAUWGv4ls4dA1usel5U3fT/1gvezBu704ucCFd3+IoU+Xx
        /3suk5AMMFVT85WrMAbyKyeKyDc8jQpU1ubdS0X6vYrUL91adfQ/uEwVJtCOmDDvt/xQGeNw5r7aT
        yWtkmphfLXByz/kFQQDjCEIQq8TuIrs78mKspznFajfvCQvCX6gPMzESAMk0sibuyeVlB3FQIOYdo
        CHiaZ+u6qSC1/p9oaZJ8UOV2EehqAHMkshll3Ux7bbkQN51H9mmfHonVGwsJSgxPP910Gd4H8k47p
        w6qvbcTw==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mNrfF-008aXl-2g; Wed, 08 Sep 2021 07:06:59 +0000
Date:   Wed, 8 Sep 2021 08:06:33 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Jan Beulich <jbeulich@suse.com>
Cc:     Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
Subject: Re: [PATCH 09/12] swiotlb-xen: drop DEFAULT_NSLABS
Message-ID: <YThg+e+5lDoSFuqO@infradead.org>
References: <588b3e6d-2682-160c-468e-44ca4867a570@suse.com>
 <15259326-209a-1d11-338c-5018dc38abe8@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15259326-209a-1d11-338c-5018dc38abe8@suse.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 07, 2021 at 02:07:47PM +0200, Jan Beulich wrote:
> It was introduced by 4035b43da6da ("xen-swiotlb: remove xen_set_nslabs")
> and then not removed by 2d29960af0be ("swiotlb: dynamically allocate
> io_tlb_default_mem").
> 
> Signed-off-by: Jan Beulich <jbeulich@suse.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
