Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0406F3E7DEA
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 19:01:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbhHJRBy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 13:01:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229474AbhHJRBx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 13:01:53 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1533C0613C1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 10:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=94EOIQouGlTJAzq6iuzYMmH+XFfcFVkH7sLnkfJnBo0=; b=MTF7TXszk6Upk/7HLlum0qi7WA
        /74ci0UwiktZW0T1hRkkbXcuOhaJ803PCUHCPjXFYaau1xhgZNLmz7C1CnWwL8QCCfnQZYXiOXB7+
        hAY1ljzWoXLDvz89Z8B6iZ15KJbk+DEvEosekAlXd+bx6S8GVzp4oqwm0ySEjJFgsDyS4iuxdHTJl
        HIJM5o1U7Pa6k9rP1YYg9x2gk8LkX6Ezm+oYMfGLDKm9ecHf3dCIKUWVFbnc7cx83apMah5dvgHP6
        I6q2A/SMzbsOeboooJh+wWLv8RFS8Ek4nMWPCdHyS1fCRZgwMyTH0J8mAUvuIKRR9xkcWuF6NNOcd
        fHmBuDOg==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mDV72-00CN9P-4l; Tue, 10 Aug 2021 17:00:33 +0000
Date:   Tue, 10 Aug 2021 18:00:24 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Maurizio Lombardi <mlombard@redhat.com>
Cc:     rppt@kernel.org, bp@alien8.de, tglx@linutronix.de, x86@kernel.org,
        pjones@redhat.com, konrad@kernel.org, george.kennedy@oracle.com,
        rafael@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3] iscsi_ibft: fix crash due to KASLR physical memory
 remapping
Message-ID: <YRKwqAlgWVGVpEJv@infradead.org>
References: <20210729135250.32212-1-mlombard@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210729135250.32212-1-mlombard@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Fix this bug by saving the address of the physical location
> of the ibft; later the driver will use isa_bus_to_virt() to get
> the correct virtual address.

That sound rather broken.  Why not save the physical address in
find_ibft_region and then later ioremap that when a virtual address is
needed like all other code accessing magic I/O memory?
