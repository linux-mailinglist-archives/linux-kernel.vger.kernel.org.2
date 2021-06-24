Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BAE43B298A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 09:41:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231681AbhFXHnS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 03:43:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231531AbhFXHnQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 03:43:16 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 711F7C061574
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 00:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=EmXIIBEAelCWJiUvAqUjUkf2YdWvF/kuldJ/8Ld8Evo=; b=V7QZ9MIRKH2jM8uygGEmicgGAM
        xf7rU1NpGS5gT7/Ohgahpti/v3DIz3vqnhPxzb4X91MPIvvGeaRmEz3xRH0uVsF6GvcxA/TF6Oo31
        VHohz18YNpWWYHFcVJA/YgETKyAj1vOBZarZ8teEvtQXsO/IJjnxRkVUA9gWTe14cj8t+OhaCHs9j
        KYB7pAdObvzxNPnGosp2y2ucbPnJjHntfCU2lQZGIYcqIeN/rzTZ1+AcU4rq9xTNybYxGDEvzaPTk
        T5i6Z14nWSnsj2bSUKYSVmsWWymwxXdLe9Db+X9S6qtFCaM+kgv/Cu4mUKy99ZVDLVjy77Vc0SBoe
        wafvCprw==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lwJyJ-00GJkX-44; Thu, 24 Jun 2021 07:40:32 +0000
Date:   Thu, 24 Jun 2021 08:40:23 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
        rientjes@google.com, rppt@linux.ibm.com, thomas.lendacky@amd.com,
        brijesh.singh@amd.com, kexec@lists.infradead.org
Subject: Re: [PATCH RFC 0/2] dma-pool: allow user to disable atomic pool
Message-ID: <YNQ258KHlzlajqo/@infradead.org>
References: <20210624052010.5676-1-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210624052010.5676-1-bhe@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So reduce the amount allocated.  But the pool is needed for proper
operation on systems with memory encryption.  And please add the right
maintainer or at least mailing list for the code you're touching next
time.
