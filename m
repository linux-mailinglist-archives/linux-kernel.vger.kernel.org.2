Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 546AC34F88C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 08:09:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233749AbhCaGJI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 02:09:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233753AbhCaGIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 02:08:31 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB93CC061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 23:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=7IvC4hNDkOIVsb77e8MajyiRyQ2axEdp/5qIsuVXObY=; b=KyzoiUHJO4d+SyNZKEQhlBZXQX
        H8zbwZipxVM3w9wgrx6Nelr15WZ9t7NCvD3TyFzcMXqalX3dGo2Ony0+IdHCRo3lpPOxlFZY57VgE
        aEZmB6sgCXNDSx78i/t6a1847uCTZak+qkV6JFWyQhbvZ5N1Wvs2rbpw9lSCBMecnVHZRUHVkTY6N
        mJJ3B4wG/5Pjq+2E99hjDW6Fdtd+OScEwDToszr902HN0N50pVPdu66FBmltFOEk03RNzfJ2SU5Q0
        KWcHN92D5WCGNKrUDx19TKkzzRs5CLHk7VZ//VK4lOTOy8nM/zpCub/vqpPVkj+o9+DTfqRtDzKl7
        tXRzxXfA==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lRU0x-0046KK-M3; Wed, 31 Mar 2021 06:07:42 +0000
Date:   Wed, 31 Mar 2021 07:07:39 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     HORIGUCHI =?utf-8?B?TkFPWUEo5aCA5Y+j44CA55u05LmfKQ==?= 
        <naoya.horiguchi@nec.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Aili Yao <yaoaili@kingsoft.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "yangfeng1@kingsoft.com" <yangfeng1@kingsoft.com>,
        "sunhao2@kingsoft.com" <sunhao2@kingsoft.com>,
        Oscar Salvador <osalvador@suse.de>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: Re: [PATCH v5] mm/gup: check page hwposion status for coredump.
Message-ID: <20210331060739.GW351017@casper.infradead.org>
References: <20210317163714.328a038d@alex-virtual-machine>
 <20a0d078-f49d-54d6-9f04-f6b41dd51e5f@redhat.com>
 <20210318044600.GJ3420@casper.infradead.org>
 <20210318133412.12078eb7@alex-virtual-machine>
 <20210319104437.6f30e80d@alex-virtual-machine>
 <20210320003516.GC3420@casper.infradead.org>
 <20210322193318.377c9ce9@alex-virtual-machine>
 <afeac310-c6aa-f9d8-6c90-e7e7f21ddf9a@redhat.com>
 <f316ca3b-6f09-c51d-9661-66171f14ee33@redhat.com>
 <20210331015258.GB22060@hori.linux.bs1.fc.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210331015258.GB22060@hori.linux.bs1.fc.nec.co.jp>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 31, 2021 at 01:52:59AM +0000, HORIGUCHI NAOYA(堀口 直也) wrote:
> If we successfully unmapped but failed in truncate_error_page() for example,
> the processes mapping the page would get -EFAULT as expected.  But even in
> this case, other processes could reach the error page via page cache and
> __get_user_pages_locked() for them could return the hwpoisoned page.

How would that happen?  We check PageHWPoison before inserting a page
into the page tables.  See, eg, filemap_map_pages() and __do_fault().

