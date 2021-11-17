Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA07A45480D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 15:02:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238096AbhKQOEl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 09:04:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238068AbhKQOEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 09:04:38 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7415C061570
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 06:01:39 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id u3so9045172lfl.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 06:01:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PobaIIgizH9bGYO/cfoNltukzkTDF2h881/xXkk3w1o=;
        b=kx10ak5h4aCwYCz3buyXgVNxv13xrEEZkQiY9z4UGkxgAJl/f00ivzMpFu/DTIjBht
         BLV0+FH71id+2VxkvQwChhWWEjAghTHWmxpWBorzzcmpYtopJwj9yKajkFP5DTnEjebg
         O8QqRGcqOuPKesMwcDZMh4ASCndmt0b71vn0OE0xwmppyqwZb9AV0Q9ICqNfFF8ESnEY
         xTNghjyoG4Vr9z4N3qSCFNup3u4WBGHli5TkmRBRcJIKdfpgn2bpAk6Iq6N00pt2rbMe
         caIna0rIgyX2IK40TWQbMA+IOsnrFWxgnJuYVp5nc6YjdAl9Flmi8XzFYFeVha1uOKL/
         iQlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PobaIIgizH9bGYO/cfoNltukzkTDF2h881/xXkk3w1o=;
        b=rmyv6fJVKSTZQS2GmNU7h3iuKJrx1XZrfSOiZSWYVse+dOcKTABilYAsSI516IEJx3
         STo5i+2b3vnswlKWL4A+kdO9AbkO2WSoLELT3wlwHnKaiaNVTT++Z2v1RrbFOtNwrie/
         SaCY9tcP3lz8KgWxGv8Y2wP1wmUSur4w+D4TVnI0/qYL0g2v8wppoU8wszcH2r8Udi20
         p3cpz4QH+M7gyHcZtTJABlGGngNq76sIVTjUcIZ0zDMyrcceVpxCKlA55kjl1Lvooke2
         6M1o43fDHh19OZRx8F0BGRStHnIqNV44DN0jeNa28n5fEPpBMRSfOKqO2w/hfJuZOeEB
         feCA==
X-Gm-Message-State: AOAM532UFhhlzGig7Vgj0AyFa+7H1toYYKMaR1VCXZjDUYng1G1tYKJR
        7CRzsFYx8hMw28v7Rjut4aRjRX/lRBuEjC6s
X-Google-Smtp-Source: ABdhPJxgnGYesjMVuRrZGbwuiv+zDG4GjVKbTbk4Ec54aNtwc6ETkhzccBOuwUWADRoafzhLDGwpGw==
X-Received: by 2002:a19:c102:: with SMTP id r2mr14597751lff.672.1637157692746;
        Wed, 17 Nov 2021 06:01:32 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id m27sm2126069lfp.268.2021.11.17.06.01.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 06:01:32 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id E7DA9103594; Wed, 17 Nov 2021 17:01:37 +0300 (+03)
Date:   Wed, 17 Nov 2021 17:01:37 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     David Howells <dhowells@redhat.com>, linux-mm@kvack.org,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: Export PageHeadHuge()
Message-ID: <20211117140137.rsokyulcmgj57ywz@box.shutemov.name>
References: <163707085314.3221130.14783857863702203440.stgit@warthog.procyon.org.uk>
 <20211117083623.elcauwjasw2hbuqi@box.shutemov.name>
 <YZUBgs+2PtnsmTAw@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YZUBgs+2PtnsmTAw@casper.infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 17, 2021 at 01:20:02PM +0000, Matthew Wilcox wrote:
> On Wed, Nov 17, 2021 at 11:36:23AM +0300, Kirill A. Shutemov wrote:
> > On Tue, Nov 16, 2021 at 01:54:13PM +0000, David Howells wrote:
> > > Export PageHeadHuge() - it's used by folio_test_hugetlb() and thence by
> > > folio_file_page() and folio_contains().
> > 
> > Maybe move it to page-flag.h instead? It is trivial enough.
> 
> HUGETLB_PAGE_DTOR is defined in mm.h so there's a bit of a dependency
> problem there.

Move enum compound_dtor_id to mm_types.h?

-- 
 Kirill A. Shutemov
