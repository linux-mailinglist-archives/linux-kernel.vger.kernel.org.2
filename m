Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82B873466A5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 18:47:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230480AbhCWRq5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 13:46:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231131AbhCWRqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 13:46:52 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E727C061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 10:46:52 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id u9so28519671ejj.7
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 10:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ql4xcjbxDiQewQBjoY2RWA9a9mOAjHNHjjlKvX5iKME=;
        b=ImQ/kiWhqm2FHjRW4oVru2YORFDIcuEufuObYX9u2FjTzqYgYl6/r+JWf6xVtdTz2u
         7AU6abiSQGDTT7olhxvb6fgkSt7EelRi/m7lBYnOoYzmq+N6bwBvzfhamelCfOTKlKle
         94UAtK9vvgLBgLB2JkZPoTsTnbiIp05/3xP8smzwihxYVzAP+gS/E9HrRpzqNq8onYCH
         N6xrpljENJkRbmx++O8szjm5Yptf9M+IQ5PegIQH8voLWKR9AW3xgdeoauIT7JLEsOJd
         9eLo41s0uq/w0dFZVtNXmypUl0lDG4ZDlWSDdKAzbnjDG9q0qgF2pnf6fVPUNs6NuRIx
         gkyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ql4xcjbxDiQewQBjoY2RWA9a9mOAjHNHjjlKvX5iKME=;
        b=At7eASmTDOlYwl/37F7N4O/HldPMEEyNv87qJypvAeZgd4q0eQARxkeHV5qLyq5NPF
         d13RawDwlVSb0PF4QFe5Ric7LCwXKKNYMFBObUDdtxU3YKnQ0mHu/pTklMk7qKSpmwIg
         0w9ivxkHQE5Bck3G5UrK3pYiXhPfeTpUQxkqsmISV1LRDf7OQNg/gf0eYDzQ591bxJau
         7o8bsMKrTLQOEnL2lJ/A8hdGNHtfnch3tGihIjbAtF1U7NF0OzP/sYlLwTI1gVenQv+a
         aXwhVoHjosX5cdmI2jlFsOj6sWrCJn/cemvoeN+S+y4TUT94tBjIaqJtZBLAc/0AWmy6
         3hMg==
X-Gm-Message-State: AOAM5320wNRD1cGYVCW8IrdYcbeX8cSMieh/1Fa1zoLMZTHBexiUcwRe
        f8hgzQyyXasU/5QXo6xUInygLc1iFXovW2hHzk8=
X-Google-Smtp-Source: ABdhPJxzFOGovvGm7xPD0TAOzpfYJ7X7k6cVcDxxZ6cFVl+Mf2WmiyLIAIKDWgQsgMBVjCyZho29t1+GVrcC1UKB3GE=
X-Received: by 2002:a17:906:bcfc:: with SMTP id op28mr6035782ejb.238.1616521610786;
 Tue, 23 Mar 2021 10:46:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210323135405.65059-1-linmiaohe@huawei.com> <20210323135405.65059-3-linmiaohe@huawei.com>
In-Reply-To: <20210323135405.65059-3-linmiaohe@huawei.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Tue, 23 Mar 2021 10:46:39 -0700
Message-ID: <CAHbLzkq7-vjiv-dbGTbY4f-TURF9W9bsMgRf4r9NZyvEW-jKgw@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] mm/migrate.c: remove unnecessary rc !=
 MIGRATEPAGE_SUCCESS check in 'else' case
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jerome Glisse <jglisse@redhat.com>,
        Rafael Aquini <aquini@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Alistair Popple <apopple@nvidia.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 23, 2021 at 6:54 AM Miaohe Lin <linmiaohe@huawei.com> wrote:
>
> It's guaranteed that in the 'else' case of the rc == MIGRATEPAGE_SUCCESS
> check, rc does not equal to MIGRATEPAGE_SUCCESS. Remove this unnecessary
> check.

Reviewed-by: Yang Shi <shy828301@gmail.com>

>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  mm/migrate.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/migrate.c b/mm/migrate.c
> index facec65c7374..97da1fabdf72 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1374,7 +1374,7 @@ static int unmap_and_move_huge_page(new_page_t get_new_page,
>  out:
>         if (rc == MIGRATEPAGE_SUCCESS)
>                 putback_active_hugepage(hpage);
> -       else if (rc != -EAGAIN && rc != MIGRATEPAGE_SUCCESS)
> +       else if (rc != -EAGAIN)
>                 list_move_tail(&hpage->lru, ret);
>
>         /*
> --
> 2.19.1
>
