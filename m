Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6C1F39F730
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 14:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232674AbhFHNAd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 09:00:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbhFHNAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 09:00:32 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D2F2C061574
        for <linux-kernel@vger.kernel.org>; Tue,  8 Jun 2021 05:58:26 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id t7so24832567lff.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 05:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JldEYX/aYDCuRQlAA13qtQYS64HOrhQMpjyRp9pf0Co=;
        b=FjLqjLPlIHLSem+vV5sKU8qW82neKJqhwE7+nwzEChHnPW20Eze/aJtEh88RXS9pcP
         eOXHwToKwcGsgj85jPqu+c2DV+QfJuOQoZyxG9tO1fCdcbsqTgOYrb5+kRmDaeWSDFKB
         DKjcLb5T+hiFQRnp8V4M5d/FNt1yRQyKfXBS9Cbe16ZEYJXp2BCtsKs3xxjRhS9w/qpt
         S9EZAUNvblPfuIa/EI2G/jiSoAFJbQGB/KMYhqzNkvD1RXiMjwjC8jCSRZylnJt+/kXR
         0PPyqtHJV6p8+/iYdviCsjX/VNyJO6R9cWACfhBiTFtF5MLf64/bdyBwvUdjNlddVHhn
         +CfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JldEYX/aYDCuRQlAA13qtQYS64HOrhQMpjyRp9pf0Co=;
        b=XBU+0xpoEWhnK/ku2mRGTcbX0buhDKXH3FxZjEdmPTs2HkvqSScXjNVpJ9vyxeYxLN
         l0vtxBM+J3R9NJaJUCGT7chhCR78/b1b1QUHrdhLvQbaXGIa6xTvJm31YEzxZwjh+fHE
         ULGjt+KWv03bWabL2iJlptP9kE8nyH3Xn/BimFLJQwREYlWksqQkP59O3KcFFoN24nuy
         nMd4d8/V6MVyyR0l5wvKAKGPb9q8Vx04h+4JT4x/rF4iZfwYKyGM5aykcxqNrLR81AKx
         JLLjNyfW0SorcerOGH99pdWtaJm+rw2LH3Ie33Ifx90yDnodNJ+lm/yNcxVVRb+2/VQk
         HNoA==
X-Gm-Message-State: AOAM530Y3/eeDxJKUDIdHp2gIUmIxf0fI9arcuacVHtJx//vtzAE9342
        wiyU5eyll2Fq9TRCcq7Lm6dklg==
X-Google-Smtp-Source: ABdhPJwiVHHdBJ2e3LGrPuYejYamakSP0GL5NIlStRaQlOKJEfCyp3m+7Ziws/FEP89lHi51O7ySVw==
X-Received: by 2002:a05:6512:2397:: with SMTP id c23mr15324583lfv.114.1623157104947;
        Tue, 08 Jun 2021 05:58:24 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id a14sm461743ljj.86.2021.06.08.05.58.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 05:58:24 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id F3930102815; Tue,  8 Jun 2021 15:58:38 +0300 (+03)
Date:   Tue, 8 Jun 2021 15:58:38 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Xu Yu <xuyu@linux.alibaba.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, hughd@google.com,
        akpm@linux-foundation.org, gavin.dg@linux.alibaba.com
Subject: Re: [PATCH v2] mm, thp: use head page in __migration_entry_wait
Message-ID: <20210608125838.6ixdlz3t334gjnp7@box.shutemov.name>
References: <b9836c1dd522e903891760af9f0c86a2cce987eb.1623144009.git.xuyu@linux.alibaba.com>
 <20210608120026.ugfh72ydjeba44bo@box.shutemov.name>
 <YL9jVYgWYBydOYst@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YL9jVYgWYBydOYst@casper.infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 08, 2021 at 01:32:21PM +0100, Matthew Wilcox wrote:
> On Tue, Jun 08, 2021 at 03:00:26PM +0300, Kirill A. Shutemov wrote:
> > But there's one quirk: if split succeed we effectively wait on wrong
> > page to be unlocked. And it may take indefinite time if split_huge_page()
> > was called on the head page.
> 
> Hardly indefinite time ... callers of split_huge_page_to_list() usually
> unlock the page soon after.  Actually, I can't find one that doesn't call
> unlock_page() within a few lines of calling split_huge_page_to_list().

I didn't check all callers, but it's not guaranteed by the interface and
it's not hard to imagine a future situation when a page got split on the
way to IO and kept locked until IO is complete.

The wake up shouldn't have much overhead as in most cases split going to
be called on the head page.

-- 
 Kirill A. Shutemov
