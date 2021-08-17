Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C53573EE1E1
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 02:57:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235487AbhHQA5v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 20:57:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236236AbhHQA5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 20:57:12 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 175CEC0612A8
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 17:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/os8BYCxcZjK7RsY8spTxNjEEn6tv7DFP2h8onEl7uo=; b=bOC/SoWz6/tdlOnV4/vUhVc5ss
        xNP/QQZyxbUWtNhj6aDaDiLVklj/o/4tH7MUMIMRrxX+R2FfB3IqA4GzDPIAC4iFIRXYQ97Jp9XTX
        hzslpysWO9j8E+SjdOpjNcjrx2z3abR9XHmT11PgWhr0n7ILUpPetBOcdN1EFTMY/6UvRCcFEKvPI
        GxnJ4B8uM8xLZxeBv5yhalK7ntBj/C2pjsdLEmAcrVDtWjzzy/RxfgRRnsNvZA2DhLaeVCgmChEIi
        DXRNVpVWHX5a9Y6H/2e80tveJbFvyzSS8e7dMCwiMsxVRkzRsD1sTKlcdMvkTb8i9Gg6ovtIe/Skn
        SkNhV+Bg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mFnNg-001yBT-Ji; Tue, 17 Aug 2021 00:55:15 +0000
Date:   Tue, 17 Aug 2021 01:55:04 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "Longpeng (Mike, Cloud Infrastructure Service Product Dept.)" 
        <longpeng2@huawei.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Khalid Aziz <khalid.aziz@oracle.com>,
        Steven Sistare <steven.sistare@oracle.com>,
        Anthony Yznaga <anthony.yznaga@oracle.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "Gonglei (Arei)" <arei.gonglei@huawei.com>
Subject: Re: [RFC PATCH 0/5] madvise MADV_DOEXEC
Message-ID: <YRsI6CXcRPTHFV0J@casper.infradead.org>
References: <1595869887-23307-1-git-send-email-anthony.yznaga@oracle.com>
 <cc714571-4461-c9e0-7b24-e213664caa54@huawei.com>
 <43471cbb-67c6-f189-ef12-0f8302e81b06@oracle.com>
 <a1dbf12e-9949-109e-122c-ba7ba609801b@huawei.com>
 <YOubKmDwxMIvdAed@casper.infradead.org>
 <a94973ab83ce48bd85c91397f82d7915@huawei.com>
 <55720e1b39cff0a0f882d8610e7906dc80ea0a01.camel@oracle.com>
 <db2b7337-4c6b-4e4b-71d3-dc4940353498@redhat.com>
 <YRpVHnr55LpQQvTb@casper.infradead.org>
 <3cdccacab6244dd3ac9d491ac7233b43@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3cdccacab6244dd3ac9d491ac7233b43@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 17, 2021 at 12:47:19AM +0000, Longpeng (Mike, Cloud Infrastructure Service Product Dept.) wrote:
> I understand your intent now, you want to share memory ranges by sharing the relevant
> pgtable pages. 
> 
> I had implemented a similar idea to support QEMU live upgrade about four years ago
> ( in late 2017),
> 
> https://patents.google.com/patent/US20210089345A1

I am not going to read a patent.  This conversation is now over until
I have had a conversation with my patent attorney.
