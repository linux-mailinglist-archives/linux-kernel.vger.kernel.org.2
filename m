Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 857534542C2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 09:37:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232771AbhKQIjT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 03:39:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbhKQIjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 03:39:18 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3E5DC061570
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 00:36:19 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id n12so5331342lfe.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 00:36:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kr53Hr5+6kxH//84H5wd+PfzX0t6JIO+NwKQHGVHTnk=;
        b=M0vAfA0aTrK4R3ymx5JhiZCPSHn4lFPlOu5v/xtBVeZAJh7Q2VaW7AIx4tAygAutZb
         6clxyeqOjqcgNkuQ6ZQYXOJPHxl0+ZKJ/92ucc7ortyiFmlUoEBcj8p0Wy5QSj7Yza3q
         EypZQ4wOxCkvBYvsqf7j6XWTLtifZW8Oz7NPotrBa48OXSRhX76w6p9tX1OFDnZ8odWi
         mxwNV3UjrKCz6MHNEKqSN7aD4YNfTJ1zp4h/2j59ZKCpTSpy1XYqIZilxRx1Nts7iV2K
         PuhcLA60QEozdbujpb/0Qj89JtIh90AIrTQk4Lz8EwG+7j4j+zXY0O8yd0dGqtNqZJQt
         fJ7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kr53Hr5+6kxH//84H5wd+PfzX0t6JIO+NwKQHGVHTnk=;
        b=UhIGA4EWd1os1e8ncdzp1Et+vuN38y7sY3Nx7eUgF0LvF3MwHtDg2Z0MhAqPl0XCBb
         iplWevmcl7ol3oov2K3KfOrUfLTpWn5hG8FsCUZMlLfb+n/1wndJ+8pq0JwWZlsjwqAl
         ekKsONM0Q4itGv6C14orlwVaEQZm/cWVgk/MkfcGEhPN5ykS/lXgTlEFIK/u06+6k3rx
         h1WuiwR9Etx99DTOz6J1ftLoPAbytC81gVURk2FGwav+rkhjzSzqMz7Uxd1Y39NDzMyZ
         YV/ioiGGmEXu5yUj5zAkhPueuh2A9bJsDT8+UUGGSI7lHen0ebHawNdM92fpUIBhtn/v
         ShZA==
X-Gm-Message-State: AOAM5316WD1gULYQE0F6chWnz1uoOOfffFAtqlwP+mMhcaXxszoXya65
        wKsKL6CgR7PEvJngdz78k6DzsQ==
X-Google-Smtp-Source: ABdhPJzWsBDB9pPMY+p8ryBEu5Sp7m4S9d6S9b/hL3w6JVj/kP8iWnYdlH/a5nPhAihE0OkzxXFXHQ==
X-Received: by 2002:a05:6512:c21:: with SMTP id z33mr13519680lfu.56.1637138178154;
        Wed, 17 Nov 2021 00:36:18 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id j16sm2040798lfe.4.2021.11.17.00.36.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 00:36:17 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id A469F103594; Wed, 17 Nov 2021 11:36:23 +0300 (+03)
Date:   Wed, 17 Nov 2021 11:36:23 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     David Howells <dhowells@redhat.com>
Cc:     willy@infradead.org, linux-mm@kvack.org,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: Export PageHeadHuge()
Message-ID: <20211117083623.elcauwjasw2hbuqi@box.shutemov.name>
References: <163707085314.3221130.14783857863702203440.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <163707085314.3221130.14783857863702203440.stgit@warthog.procyon.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 16, 2021 at 01:54:13PM +0000, David Howells wrote:
> Export PageHeadHuge() - it's used by folio_test_hugetlb() and thence by
> folio_file_page() and folio_contains().

Maybe move it to page-flag.h instead? It is trivial enough.

-- 
 Kirill A. Shutemov
