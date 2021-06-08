Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 542F839F21F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 11:16:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230396AbhFHJSY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 05:18:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230291AbhFHJSX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 05:18:23 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88682C061574;
        Tue,  8 Jun 2021 02:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=WORT4I/yJe9ZDsklsCesuSnYRZ
        0+13XWjGXPE39wNgWQz0DTXs/43BtAEg0Cn3KSJuD2G5BUtfqPRvscIFv3cDzxFS/yb74VEKJSXn2
        GAWnFmoR6wFqKu5Gu1zK3wX0i3tGL7eHrS6nkdvN4bmNrjcffhY8xdg8dqQmHmU3sucO3vhc+Mtov
        d2z8KTNXSrPZ1NnEv5Fb5nAgKnd5depwIVeDpb01cPcUSmRs4VPbJOu8kXoDD9NzqplJJhdFIegmI
        jFToyzzxoMeW37WFah2yRf1M28ZlpYTgNLmnV5r9hraeds0WBls8mGkjDZ1mJ4Ktm5wmuOHc9FJfD
        JJSxezbQ==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lqXoB-00GlBe-P0; Tue, 08 Jun 2021 09:14:25 +0000
Date:   Tue, 8 Jun 2021 10:14:03 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Barry Song <song.bao.hua@hisilicon.com>
Cc:     akpm@linux-foundation.org, hpa@zytor.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hca@linux.ibm.com,
        gor@linux.ibm.com, borntraeger@de.ibm.com,
        naveen.n.rao@linux.ibm.com, anil.s.keshavamurthy@intel.com,
        davem@davemloft.net, mhiramat@kernel.org,
        linux-s390@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, liuqi115@huawei.com,
        linuxarm@huawei.com, Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v3] kprobes: remove duplicated strong free_insn_page in
 x86 and s390
Message-ID: <YL8025z/MCBiEpEZ@infradead.org>
References: <20210608065736.32656-1-song.bao.hua@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210608065736.32656-1-song.bao.hua@hisilicon.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
