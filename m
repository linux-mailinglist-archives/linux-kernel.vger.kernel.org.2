Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F16CC3B5E64
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 14:49:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233069AbhF1Mvg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 08:51:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233057AbhF1Mve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 08:51:34 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6C1BC061760
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 05:49:07 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id w19so3851406lfk.5
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 05:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9YjsxWTv0kQVrcHNY3VGvdRvBxzuUPPPSmtpb6NmJ50=;
        b=YNZnxgyvRhhJNb3vzFToay8JPWo3nncmo9cy1cuzW1SihA1UiLkcTzuPnrj/dmzP10
         wAH2RSJ0Zj9dWhI/N6Y1GE4oM69cwn1xYNddwr0OPJlrujrDWLxrpk8TaHLzV95Qwq0B
         5jDonBN6O7j45FbnFnZVZVKouSsweskeWu8G3F+Sz79ognFxAcdgiBg0SSXOF5qfaRgv
         VWdp60u1N9fKrX/ACQBvzCNIGJ5RSGV2LR2aEuFNKPJ8A+Dw2MMCNwCtCnqozaDK0aBS
         3nunYq4hfSF2BrvP0XAayvthPFo3UyoNMsLxGP3YpuB4I0oLs9CshX+kdvP7ny8oKK2U
         81vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9YjsxWTv0kQVrcHNY3VGvdRvBxzuUPPPSmtpb6NmJ50=;
        b=rTNEzK+PEU8Mu2MOia6yp9HQrgWTbx4/nmYt22wO9q0fR9TgLKRKD/mqRsTIeC3rPD
         UMQvPoIAJtZa82P6qTg7XAgkdxd5lQCIIkHBwssAyoKn7PW7zWbjTN8M8OzpURE4eqC5
         qXnMLl8ikFILz+T9TtV0fY3+S+m2wdDcrBI4JwRGVUZ7ZAqEw+LZS/AJxmKNAOkTQXjq
         U0jDoTt/NgX0GAAxKf+tWBshCOdvidOOfi7VtEM0AQ5uns9EGNGAhTXi0YDbTF/JJQui
         ddrvIB0FAVt3Y9AR+d3Px6vpaAuDq8fmB+uRrxiBex5hpeYo6KFUOWyRh2BRgLiIA8vR
         gyNg==
X-Gm-Message-State: AOAM5306jGEXggPs8x/1OKkavWyt/mKCEr9CZYpK53eznJr7rzgihake
        Ke1Am1OHhxNxSpT/12fratKb4g==
X-Google-Smtp-Source: ABdhPJy5doUOoTBWEbaiUSSG4ylkr1yyjwbZH0tbB92CloI0zoeov7u71L3C4nVfRk5umkBFFcSPWw==
X-Received: by 2002:ac2:4211:: with SMTP id y17mr17641025lfh.607.1624884546282;
        Mon, 28 Jun 2021 05:49:06 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id j2sm1216847lfb.212.2021.06.28.05.49.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 05:49:05 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 3A79010280E; Mon, 28 Jun 2021 15:49:05 +0300 (+03)
Date:   Mon, 28 Jun 2021 15:49:05 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Vlastimil Babka <vbabka@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v12 32/33] fs/netfs: Add folio fscache functions
Message-ID: <20210628124905.5ndzvzltnuycrf2k@box.shutemov.name>
References: <20210622114118.3388190-1-willy@infradead.org>
 <20210622114118.3388190-33-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210622114118.3388190-33-willy@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 22, 2021 at 12:41:17PM +0100, Matthew Wilcox (Oracle) wrote:
> Match the page writeback functions by adding
> folio_start_fscache(), folio_end_fscache(), folio_wait_fscache() and
> folio_wait_fscache_killable().  Remove set_page_private_2().  Also rewrite
> the kernel-doc to describe when to use the function rather than what the
> function does, and include the kernel-doc in the appropriate rst file.
> Saves 31 bytes of text in netfs_rreq_unlock() due to set_page_fscache()
> calling page_folio() once instead of three times.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> Reviewed-by: William Kucharski <william.kucharski@oracle.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
 Kirill A. Shutemov
