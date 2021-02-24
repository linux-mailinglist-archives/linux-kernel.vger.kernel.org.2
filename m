Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4F1D3235E3
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 03:52:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233037AbhBXCvK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 21:51:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233026AbhBXCuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 21:50:20 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90A55C061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 18:49:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=JUggJb3cAXYd36jW9el8DbW+0z3Kz4bUmTUE+LP6NRA=; b=JXFjj00htgCyW8UtVreSPf0CT6
        K2Ocjrpx8DV1U7adZnTfQMf9t4pIZ+f1QuwooS0lwker/aVutTEh4g7ouv1XTmedBwfUP/BsnbSal
        /edwa7vtCWJpjWazjj3lh0ev3RHCyY9FVp+PrxeU7m0txi88OMM4c+J6eJ/AXYIt36VYV+lvAXHut
        1t4hiZjFX7eYibQmkwz6YnqzdN0K+Df0Kyq50INlZbjeL6UAQPEQhw9FBhTnWDFpnGXWMlLq1hoB1
        JQ4orsZyfx7BIJajYENsfmkMKFE3C1rXQ+rm5m0fB8LfU3KUq1oTglmIogfPL//h1eHaLpnqnuyJO
        M/jBdrvA==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lEkEn-008qo9-Qv; Wed, 24 Feb 2021 02:49:20 +0000
Date:   Wed, 24 Feb 2021 02:49:17 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH v3] mm/mmap: Don't unlock VMAs in remap_file_pages()
Message-ID: <20210224024917.GO2858050@casper.infradead.org>
References: <20210223235010.2296915-1-Liam.Howlett@Oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210223235010.2296915-1-Liam.Howlett@Oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 23, 2021 at 11:50:23PM +0000, Liam Howlett wrote:
> Since this call uses MAP_FIXED, do_mmap() will munlock the necessary
> range.  There is also an error in the loop test expression which will
> evaluate as false and the loop body has never execute.
> 
> Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> Acked-by: Hugh Dickins <hughd@google.com>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
