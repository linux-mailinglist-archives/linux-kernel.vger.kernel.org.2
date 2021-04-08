Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 298AA3589E2
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 18:38:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232192AbhDHQiw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 12:38:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231480AbhDHQiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 12:38:51 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4910BC061760;
        Thu,  8 Apr 2021 09:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5WVQk+7P/5/ZolZaMYRuxpu9ZytNhluiUoWmCVEJDsc=; b=KQEeBTtx6kshpfwtjpcIOZ7kZn
        Jk2l9MjZ+3Rwmhnst1TUq/L5sDhoq1s4q/ZkReF0N5Hgx2nL9Lt8NPtgwq/I2p834f0H5Yn5gg2kk
        i2o3tr6bP5gisRiLeP+cDW+nr4ULN7g5gW9GHQBDDmfftizTAs8MKTME2MQzu15PpVyDrGzgAThg5
        hy9Q2wTUDv+9NHc2eHXwz6lBnN8rTz8PYSAubRoCq1e7wB88Dntbm93G8YRJT5vi3391uAvOX2acO
        D14+mcpFg6jbYP3arN03OJpqF6DpvYwhvxWS832dLjgwcaGw0Vg5PjdIKi/B8A1y4ae0tMmSFNJiW
        7anxCuAA==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lUXfi-00GWrM-Cy; Thu, 08 Apr 2021 16:38:25 +0000
Date:   Thu, 8 Apr 2021 17:38:22 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Michel Lespinasse <walken@google.com>
Subject: Re: [PATCH] arch/m68k/kernel/sys_m68k: Add missing mmap_read_lock()
 to sys_cacheflush()
Message-ID: <20210408163822.GP2531743@casper.infradead.org>
References: <20210407200032.764445-1-Liam.Howlett@Oracle.com>
 <20210408163400.bcsmojb4ug7nnzwt@revolver>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210408163400.bcsmojb4ug7nnzwt@revolver>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 08, 2021 at 04:34:20PM +0000, Liam Howlett wrote:
> When the superuser flushes the entire cache, the mmap_read_lock() is not
> taken, but mmap_read_unlock() is called.  Add the missing
> mmap_read_lock() call.
> 
> Fixes: cd2567b6850b (m68k: call find_vma with the mmap_sem held in
> sys_cacheflush())
> Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Although if it's been broken since 2014, maybe the ability of the
superuser to flush the entire cache is not needed any more and can
be removed?

