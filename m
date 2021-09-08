Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 340984034B5
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 09:05:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232847AbhIHHGO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 03:06:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345947AbhIHHEt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 03:04:49 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B433C061575
        for <linux-kernel@vger.kernel.org>; Wed,  8 Sep 2021 00:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=gatW1BubQnKb2kduQto9Cf0sWBkeir64mglmf+pQf2Q=; b=k7G3Dc9dTikD/msbbkUkrK6bH/
        rcD7O+3KeLMyQ1++oVllKlyi8fr3OzWCFSPglsQEwTuZYSOeBs1r73L3/drk5ceobljVtDfydSKFB
        j/domY+VTpfr9Pk9f5rNEQqFYIDkHP5jTSDi9iVT3CSZOC35ka5bQlKxSolhcWPXaq/1QfK21G+ih
        COU4O1kTW2U6YdQXei4QY2KiZAUUKvTqMlzEA/VevxT4QnIBgJt2vBtZgAO4rpNo8bQHCz2QyPe5C
        fe2/HGVSMq4ipo4jC45iFAjbTS29+lrORLywMIyJG16unTn6UIJAoJaoEX8vMVXeRptUArk8CdQ0M
        IkU/sUdQ==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mNrbE-008aLp-HO; Wed, 08 Sep 2021 07:03:05 +0000
Date:   Wed, 8 Sep 2021 08:02:24 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Jan Beulich <jbeulich@suse.com>
Cc:     Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
Subject: Re: [PATCH 07/12] swiotlb-xen: drop leftover __ref
Message-ID: <YThgAClbSGQCBv5n@infradead.org>
References: <588b3e6d-2682-160c-468e-44ca4867a570@suse.com>
 <7cd163e1-fe13-270b-384c-2708e8273d34@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7cd163e1-fe13-270b-384c-2708e8273d34@suse.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 07, 2021 at 02:06:55PM +0200, Jan Beulich wrote:
> Commit a98f565462f0 ("xen-swiotlb: split xen_swiotlb_init") should not
> only have added __init to the split off function, but also should have
> dropped __ref from the one left.
> 
> Signed-off-by: Jan Beulich <jbeulich@suse.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
