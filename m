Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C50284034A8
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 09:01:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347911AbhIHHBJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 03:01:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233179AbhIHHBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 03:01:08 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11041C061575
        for <linux-kernel@vger.kernel.org>; Wed,  8 Sep 2021 00:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7gmr+v/UYd69hqQff5Fcu4B0asSjyasIdDD4iqilMBs=; b=BhJhq2e3Ic/6vaQ2X9A7y70QlA
        LN7tsn+RSNKPWUCjSCIDNsjviepIb4CgpXAMqNPNl0hCUOuRIE5CY+CkQLja8SX75eR6DryDm1ntu
        3lscohH7+1ssTfUDNi/P/N7uBNXacnQBZA8Hwdqtv+q8NMyvtpoAp4qXNq9o5P6fAZ2/dkCjoEriy
        9tKDLpzsK8JdUsp5eCc433G7x3oabL/dTqC0I0T/PLIzJFdqeztX9uUHC6V51OBay7pb4m35Oya0f
        MqyWaHEDdXo8bVRyW4we+Z42VMXBxFTjies7EWwuwlP/xoOr+NeRaW4DyrX4oGeCcpwEA6IVe1Gbq
        8C+Nm+Sg==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mNrXr-008aF4-Do; Wed, 08 Sep 2021 06:59:08 +0000
Date:   Wed, 8 Sep 2021 07:58:55 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Jan Beulich <jbeulich@suse.com>
Cc:     Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
Subject: Re: [PATCH 05/12] swiotlb-xen: suppress certain init retries
Message-ID: <YThfL9RChhtBA0Oc@infradead.org>
References: <588b3e6d-2682-160c-468e-44ca4867a570@suse.com>
 <56477481-87da-4962-9661-5e1b277efde0@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56477481-87da-4962-9661-5e1b277efde0@suse.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 07, 2021 at 02:05:54PM +0200, Jan Beulich wrote:
> Only on the 2nd of the paths leading to xen_swiotlb_init()'s "error"
> label it is useful to retry the allocation; the first one did already
> iterate through all possible order values.
> 
> Signed-off-by: Jan Beulich <jbeulich@suse.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
