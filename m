Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69182366767
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 10:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235546AbhDUI7Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 04:59:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236099AbhDUI7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 04:59:12 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD44FC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 01:58:39 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id c3so9324086pfo.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 01:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Lr+Ycz6BuRbj33U2Is4Kuv/TVfp1al5FWNN9+J922js=;
        b=tRjtVdEqhhlRAjKgKXlbefmzETj4mNJWhRBUZVYMAEo72hE6RBbxhMYaJhCw+bH7bn
         z0kM0qYsaSDqyVz/z9UH8gQa/uyDPGRMrvBW0RT+YNUe3QvRAbSwNwQkCJ/gbZCJ8OOE
         uRDCjO/udzAoq1yXIRXo8/bqJGFfL8z8SWxaMC+7Ey0fcin/LtJ2AKzJT5ceUSeKYFvp
         JXAtXjDt6zcTnfsyCilxszx/GKDsZZIZLtZnLAwvBTSK3fAwKyTspTOOckEZBzdh0ybs
         QS7eVcVxUa1LmxprgHmoTKesXV6qOLjJzNg81grc3ejEBIujVJR5b/oJ01ymn/gAqfQZ
         WU6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Lr+Ycz6BuRbj33U2Is4Kuv/TVfp1al5FWNN9+J922js=;
        b=ZGuGOepeqK6P+DmuWjt0058KTXzh6bxtqMrkFYVvyQgwMrX5uNgfMK5Ick21R4OTc+
         xvyTyfnZDskeBk1xJ14cuu75+pOlUZN908Ge2IUhlvqHCHoX8p8ZAOqfYiRD6lMC25rR
         xt0TZTY6d00jHqFQ0vaYHi+/eo9JFm5MkmOwWHiddL8V2wD0RkjLAS40nfSTLceVTzhx
         Ck54RzHIM7ZeP3NjNXonXm+b3+mFzIN0WKxzRojcCTMEfpUs2hg+7JpiDv282QNxLlS/
         H69hlrk0OrUf2A9w75FMe/sQ2Ndkz9FsGhdi92/vTrO5ul09ceCIgZfka8A0tA5p6k9R
         Kc+w==
X-Gm-Message-State: AOAM531V1M6xl1VhnaYazbg5SqnCssIZl242g4Z98+Y6n+04oseg1v60
        UD0HDXfzhDVZTKbB9cMBnA6/vSijTouuZQhYScvuL5Th/6Y4Pg==
X-Google-Smtp-Source: ABdhPJykDmmu4Ncb1pa1fieQO2qdC4OFg3yF7VCrBNV7KetM5geUXbnStkkTpc8y2MM05DtUzuv4fcu8LrQe7oaGyg8=
X-Received: by 2002:a17:90a:644b:: with SMTP id y11mr9679126pjm.229.1618995519230;
 Wed, 21 Apr 2021 01:58:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210421060259.67554-1-songmuchun@bytedance.com>
 <YH/cVoUCTKu/UkqB@dhcp22.suse.cz> <CAMZfGtWh4tRiMrOTLvv5GHM1JUCt9b+UHf_DwLev32S=+iLW8g@mail.gmail.com>
 <20210421082103.GE22456@linux> <CAMZfGtXsXViJTWrMoECCaCD+2mF7zB5n61aFJvVgpGTaUVEC4A@mail.gmail.com>
 <20210421084911.GH22456@linux>
In-Reply-To: <20210421084911.GH22456@linux>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Wed, 21 Apr 2021 16:58:02 +0800
Message-ID: <CAMZfGtWCi7RoYE0q_7RzshvL_meSUpjWKavBOh6ifUUV6QEm+g@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] mm: hugetlb: fix a race between
 memory-failure/soft_offline and gather_surplus_pages
To:     Oscar Salvador <osalvador@suse.de>
Cc:     Michal Hocko <mhocko@suse.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 4:49 PM Oscar Salvador <osalvador@suse.de> wrote:
>
> On Wed, Apr 21, 2021 at 04:41:10PM +0800, Muchun Song wrote:
>
> > But softoffline does not set page hwpoison before
> > __get_hwpoison_page(). So the page still can be
> > allocated. Right?
>
> Yep, soft_offline() only marks the page as hwpoison once the page has been
> fully contended and no other use is possible.
> But yeah, hugetlb is a bit trickier in that regard.
>
> This needs fixing in there.

It is OK to fix it in softoffline/memory-failure.
I just want to expose the race. Thanks.

>
>
> --
> Oscar Salvador
> SUSE L3
