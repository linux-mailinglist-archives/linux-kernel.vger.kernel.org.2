Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 061BD3FB864
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 16:42:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237199AbhH3OnL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 10:43:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237156AbhH3OnJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 10:43:09 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EF77C061575
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 07:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=EZA4oxuCnUaen/bj4k8tdkq2jibgifMiILkBMqfWID0=; b=tyx99hhd0HIIPh8tn7k1fWYyLz
        1790ARWjQCLnsX1HowT/oGgasjvtR91zrZKFVXrg5XElgmIKyOhRzf+t1PDvF5cmsp94He91DRPEQ
        YgvFNRZPiybebXKXQtVs6ofG0aLAEf6JM39vjgaOCWwLJmOSz46v0zvv2K3c64DzB2TiUahTlNUZQ
        8niY5SFpHmxIkc4YNJXUl6O1PkrZvGArOgK05bgbIP+4r9xa9GF0MH1IlHOphl+gLVuE5F61/fhmF
        TPvPnIxwy6pMLDmRLD6WJXCUKjjA6vcRycu9njcUkqkfIcmP1k3LWeN/Q9p9xmFiJBCGFbmZiCemV
        xqjOE1Pw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mKiTt-000FAi-4s; Mon, 30 Aug 2021 14:41:55 +0000
Date:   Mon, 30 Aug 2021 15:41:49 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Mikko Rantalainen <mikko.rantalainen@peda.net>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: Why is Shmem included in Cached in /proc/meminfo?
Message-ID: <YSzuLbHr7fHshafX@casper.infradead.org>
References: <5a42eb2b-fd7b-6296-f5d6-619661ad1418@peda.net>
 <0d11f620-0562-e150-259d-85de8d10cd7a@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0d11f620-0562-e150-259d-85de8d10cd7a@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 30, 2021 at 07:34:38AM -0700, Randy Dunlap wrote:
> [add linux-mm mailing list]
> 
> On 8/30/21 12:44 AM, Mikko Rantalainen wrote:
> > It's not immediately obvious from fs/proc/meminfo.c function
> > meminfo_proc_show() but the output of Cached: field seems to always
> > include all of Shmem: field, too.
> > 
> > Is this intentional? Usually cache is something that can be discarded if
> > needed but shared memory (e.g. used to contain files in tmpfs) cannot be
> > discarded without a data-loss. As such, I'd argue that it shouldn't be
> > included in the Cached: output.

That's a reasonable position to take.

Another point of view is that everything in tmpfs is part of the page
cache and can be written out to swap, so keeping it as part of Cached
is not misleading.

I can see it both ways, and personally, I'd lean towards clarifying
the documentation about how shmem is accounted rather than changing
how the memory usage is reported.
