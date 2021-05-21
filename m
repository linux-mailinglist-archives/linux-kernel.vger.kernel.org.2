Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E36638BF19
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 08:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231625AbhEUGL6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 02:11:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231224AbhEUGLz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 02:11:55 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9947FC061574
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 23:10:32 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id q15so13417674pgg.12
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 23:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CAzCHLCIfN3XrwNddwHKB4ONH1wjhvpnzX5+nKdDGjk=;
        b=N7XctzxRCWL1nRRWYEiS3sGId+HVBXxT4uBCmHpOYRWUHuRpwzXIPEuNJCgaWX/j5v
         a7ccDjjTTx6Phy1pWuszbzqQKaC0dshODBeq+EkcKUx7eNwU6YTbWOiUjhImK3eVuDow
         KHKr5XRFFN+RXIyNyd20C14jDX029FckG+Fi83FgayLDdq0zxUqYN2wkKprf/m0euf+K
         xRS6yGyMHPxSbh2BPSyY+tg0fWb/La5mBRi5KhPinfoshUs4DmdNCzf7Tr97lPh0o8Mn
         8fRXN2sQe0eMr5oPUI7N+ZnUv494EkvN4m1j1YzmTozJ/tfeKPmQPOudmCU3NAHF7fbX
         Purw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CAzCHLCIfN3XrwNddwHKB4ONH1wjhvpnzX5+nKdDGjk=;
        b=LSBEDtIcFbmD7vndJOzzQ/tA9w2HPtarRjOdvz88JV4NO90L1Lrzvsisx7MK+vYTGQ
         eLLP3GnO6Pi6MGdpn3NOfZ4SgopjW4g3wBjpI3dMbKyW0mu/NM9AQXyh+JW5nJe+od5e
         KhDbwnZpIitsmc27wIDB+7yNFUNmoUxu6DDajV/5+S65tIsKsDNv6E2rEstu1favjmYH
         wS+myhrsceO8+f/pKRhaU4l4Ipsc6eBghWsNan+yqPiTUQjHiwa8OSNlrRWS/hN2edmM
         ha+4fxKJNNKkp+Id9SKNPqVwVTuuMzoAq6a+QauSvuAJ44bcmihyWfmEc1Fuv88h22in
         e6xg==
X-Gm-Message-State: AOAM530M+TeC4/DiWeRY/2owB26TI/MBPVfpxiSlZGuFOfA3z1xSvnEx
        dzMAffkk6Axh8C1x7h2ZLeESMkFo9K5etnM/BVMUxw==
X-Google-Smtp-Source: ABdhPJxZ8kW344sG8y5La4SGZX7ICP1eKZQHRi+zXjYaiVK1wVmJHJBU4sYrMZ3MflQXdqIxaCVMs1bq/OasztGrd2Y=
X-Received: by 2002:a05:6a00:2493:b029:2c4:b6dd:d389 with SMTP id
 c19-20020a056a002493b02902c4b6ddd389mr8660619pfv.2.1621577432160; Thu, 20 May
 2021 23:10:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210521155359.13b023ff@canb.auug.org.au>
In-Reply-To: <20210521155359.13b023ff@canb.auug.org.au>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Fri, 21 May 2021 14:09:56 +0800
Message-ID: <CAMZfGtXSvWVbLwp-0SjoVub5z94nQyu1tL2jHffQCn32Ebaf7w@mail.gmail.com>
Subject: Re: [External] linux-next: build failure after merge of the
 akpm-current tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Xiongchun Duan <duanxiongchun@bytedance.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 21, 2021 at 1:54 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> After merging the akpm-current tree, today's linux-next build (arm
> multi_v7_defconfig) failed like this:
>
> mm/migrate.c: In function 'unmap_and_move_huge_page':
> mm/migrate.c:1295:6: error: implicit declaration of function 'hugetlb_page_subpool' [-Werror=implicit-function-declaration]
>  1295 |  if (hugetlb_page_subpool(hpage) && !page_mapping(hpage)) {
>       |      ^~~~~~~~~~~~~~~~~~~~
>
> Caused by commit
>
>   b63794a67ae2 ("mm: migrate: fix missing update page_private to hugetlb_page_subpool")
>
> CONFIG_HUGETLB_PAGE is not defined for this build.
>
> I have reverted that commit for today.

Thanks for your test. It has been fixed by the following patch.

https://lore.kernel.org/linux-mm/20210521022747.35736-1-songmuchun@bytedance.com/

>
> --
> Cheers,
> Stephen Rothwell
