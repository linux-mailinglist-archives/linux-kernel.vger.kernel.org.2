Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A1944034A9
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 09:01:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347952AbhIHHC2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 03:02:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346759AbhIHHC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 03:02:27 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1560C061575
        for <linux-kernel@vger.kernel.org>; Wed,  8 Sep 2021 00:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=R8OKvw4S2MzNKNmIXpBxq9HTvvmNUrQ/SvUk9VnsHUY=; b=rpo3HkOJxy7GQnr44u+Kw8/GWw
        b8U0qMtuai8fWaIBPF65LKePgrrYtAvsRonr7HKZ/kABbXwFaD3Mpb9NLGgv57kVtXFmpclCY72AW
        bRhylceyEaHc9mZwksibH7RRQWka7q8ZoZO0inYa0QUo14guNPVn4vgylPrf7IJVRKoj/ZEvI6QNn
        BnqFevB+Z2JckxFutk9LRF6NHmlUhurLK75V0CumKbej0KWAQMeYjX0SWkuA0cQAqZ5knLN3VjNDg
        0Q71U9TW6LUgg1Y/e5lIBYVvFbraJ7etFrdulT7G7nM5y7yJQdeATwHB+s08UVof9jVe9hk8cGZ1V
        nCpsr0OQ==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mNrZH-008aHN-76; Wed, 08 Sep 2021 07:00:34 +0000
Date:   Wed, 8 Sep 2021 08:00:23 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Jan Beulich <jbeulich@suse.com>
Cc:     Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
Subject: Re: [PATCH 06/12] swiotlb-xen: limit init retries
Message-ID: <YThfh2aIlAIkdrXA@infradead.org>
References: <588b3e6d-2682-160c-468e-44ca4867a570@suse.com>
 <984fa426-2b7b-4b77-5ce8-766619575b7f@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <984fa426-2b7b-4b77-5ce8-766619575b7f@suse.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 07, 2021 at 02:06:37PM +0200, Jan Beulich wrote:
> Due to the use of max(1024, ...) there's no point retrying (and issuing
> bogus log messages) when the number of slabs is already no larger than
> this minimum value.
> 
> Signed-off-by: Jan Beulich <jbeulich@suse.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
