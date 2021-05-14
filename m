Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0CA6381000
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 20:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231166AbhENSuO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 14:50:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbhENSuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 14:50:12 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDB73C061574
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 11:49:00 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id t3so3295543edc.7
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 11:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7aNLIovxf+Lwl2dDT23aHwbYOgVzois5ZTVGpET054M=;
        b=nJ/gKAjPe73iJPGorvByKq8jQYg4dGDJBGV79XPXTaGWXxm5cDmPA71RajP0geXSaR
         n2GUFRwdB0WwuKIVznZ9oT03lGXgaJfNCXtquEds/vTzerea4D8zFKh4BFdivCWBZWDY
         wlaOI+GTW+C93K0zCmVc2xg9FN+7FWb3J/W7e/KQq0eyT8hNmA5MojmGvcpJAODU6Fn+
         3D2h8X98i+ID6KOPux9F7Z0AJryOnb4SeFrKdOXdWnP9sMRmMqLlBlZazXHq0nM+5ew3
         vQEQqetc/f/FoRUnKhv0Jz9a+2MJXBfXfJppsI7VHcqTsy2hsDv1KtK0077YBgLvjv9a
         qRIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7aNLIovxf+Lwl2dDT23aHwbYOgVzois5ZTVGpET054M=;
        b=N5vVkqVLL04BUWCA7iPDTJ4obv/KRXkcAdenxP8QmjcO5YQo90u+XcEK0xNlxBT59T
         S9d4abFExNB5AApcxkzYRazReiKlVPc0bvGOE41Q/PFvHMhWJvPM5yGdrKWSkqHFXgM3
         IeU16Fd8ldoxMHJDRQGWFZZSVpYfOcDtiw73J+3mvk07oZUxjGArPj9nQGu1WGVllkak
         poN/3OPceQp7L77qoOzvdSUg2CFGakudxzYB4PRGvW+f1Jd4W5Y75Dj2Z/s24rqIdbGE
         8gSoikVBmpNwHrjIvjQAIBaNE4AWyAkquMoJ+liAr36WnJiVJSa+lEq7Rvi0VLEpbZxh
         4/1A==
X-Gm-Message-State: AOAM5308A8m1A9Lt6NrOxSDONPjgVhPvEJSxf+jENIZ3Ng/94Nz6cTWW
        yZjZEvZpIDbiZghP03xEJS1du1DHCxezLVyVOFM=
X-Google-Smtp-Source: ABdhPJzce0dSO7tXlZ1ThLB+caoxeXowCVqwqTekqw/baZQbfEgFjlrEE3zU1qcFlrYCGoCDguvCVqWS9qeRw7EVa50=
X-Received: by 2002:aa7:d818:: with SMTP id v24mr13415385edq.290.1621018139677;
 Fri, 14 May 2021 11:48:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210514065912.71734-1-pulehui@huawei.com>
In-Reply-To: <20210514065912.71734-1-pulehui@huawei.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Fri, 14 May 2021 11:48:48 -0700
Message-ID: <CAHbLzkonsd9f=48+cxKOJamNb9e8qpvWJCYDGFB_wNTdET2zmQ@mail.gmail.com>
Subject: Re: [PATCH -next] mm/huge_memory.c: remove unused variable 'count'
To:     Pu Lehui <pulehui@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 13, 2021 at 11:59 PM Pu Lehui <pulehui@huawei.com> wrote:
>
> mm/huge_memory.c:2663:6: warning:
>  variable =E2=80=98count=E2=80=99 set but not used [-Wunused-but-set-vari=
able]
>   2663 |  int count, mapcount, extra_pins, ret;
>        |      ^~~~~
>
> This variable is not used in function , this commit
> remove it to fix the warning.

Thanks for catching this warning. Not sure why my gcc 10 doesn't catch
this warning at all. What compiler are you using?

Andrew, the compile warning was introduced by my
mm-thp-check-total_mapcount-instead-of-page_mapcount.patch.
>
> Signed-off-by: Pu Lehui <pulehui@huawei.com>
> ---
>  mm/huge_memory.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 52ca04b905cf..a23a127302e9 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -2660,7 +2660,7 @@ int split_huge_page_to_list(struct page *page, stru=
ct list_head *list)
>         struct deferred_split *ds_queue =3D get_deferred_split_queue(head=
);
>         struct anon_vma *anon_vma =3D NULL;
>         struct address_space *mapping =3D NULL;
> -       int count, mapcount, extra_pins, ret;
> +       int mapcount, extra_pins, ret;
>         pgoff_t end;
>
>         VM_BUG_ON_PAGE(is_huge_zero_page(head), head);
> @@ -2737,7 +2737,6 @@ int split_huge_page_to_list(struct page *page, stru=
ct list_head *list)
>
>         /* Prevent deferred_split_scan() touching ->_refcount */
>         spin_lock(&ds_queue->split_queue_lock);
> -       count =3D page_count(head);
>         mapcount =3D total_mapcount(head);
>         if (!mapcount && page_ref_freeze(head, 1 + extra_pins)) {
>                 if (!list_empty(page_deferred_list(head))) {
> --
> 2.17.1
>
>
