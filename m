Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A158D4199B2
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 18:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235619AbhI0QxD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 12:53:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235492AbhI0Qw7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 12:52:59 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43EFDC061575
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 09:51:21 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id dm26so37722464edb.12
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 09:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GqnGVlOWWoCRs+MztdprLg+2bam6PwLqfCjC4dqsjTg=;
        b=XzN+yJ4nsOlXhukqXwuke6l972D9pHEjn8/qhZkDViqN8f5iEm/dSO4yvstar7/zzH
         hFTpPMA+C3o2yZJGHgnATrlYFNnADUOQqOTVClgkVA8e6dQdh4HsKcwqmkR4CjUdMjeV
         6hVqBYRV3cj1uW3CC051k97JwGgyR9T7BQt61dEQg5gIwS/pTg2vKxOjXvKUVQ0D8pw1
         5go4UWeQIri+ZQQCObKzqDiLWbuoLMlpj/LC25+l6JIhCX0Y1Vr0uFtQvCuMabq1XZWB
         9MvOtipYYmZCWFcNLUIzEJC/8/KEjgbw5L3dVMP7FzmrY47QgOICRl3lOQwxUuBoG1gI
         0uzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GqnGVlOWWoCRs+MztdprLg+2bam6PwLqfCjC4dqsjTg=;
        b=ZGpg5YLGi1tHO/D9f8c2BUVETxK6rxTIpnBMeV83lmESm0JZlxLQYdURzn3s6OUkc1
         bF/7rwV3I+J1sHrB9+T4tPSzuDXcuc6rxYGrw+66h6QOQrU9v9sH98maXOsFH+BR560s
         IXsdfxYlsEo8RB1eV8Ekhbvo+ND1ppEy1+JJaT3haA+sLoOxrZEFWQgdxAzbyvJ+g7+F
         Vu9qJWhcbbNthJCCS4uxomA+En/yQpPCaJZ9AslBRanR3ql2akVGtimCcXeHUZDIgw33
         hOrscgvVFCosbyOZLSvvEW/D56OlAdGzg/Ffq3ac99wjS63+FMnAh8GfBT/6nzTPN96N
         6DRA==
X-Gm-Message-State: AOAM531kMXaBhf2Hj0FhiYjHKafUc0WNMn/uGl0fX/snwU0f6IHwJkBB
        I/g9HaUkMnhWrnoz1oTlLvaisWsjS+CdU8MsfON1Nq37
X-Google-Smtp-Source: ABdhPJyxRDSVMXC96QqUsrRGo92OZcyTydl/griYsuQKaO07BcgSDmqOifKe2SGCqhzFlzi4P7jwNFbx4oYCm59uCtg=
X-Received: by 2002:a17:906:3854:: with SMTP id w20mr1057775ejc.537.1632761479812;
 Mon, 27 Sep 2021 09:51:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210924181218.21165-1-songkai01@inspur.com>
In-Reply-To: <20210924181218.21165-1-songkai01@inspur.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Mon, 27 Sep 2021 09:51:03 -0700
Message-ID: <CAHbLzkopfWZhT0f2D3VjUPyssDLO++zMqR+2qPbWNhkg0mUQ0A@mail.gmail.com>
Subject: Re: [PATCH] mm/vmscan.c:Fix -Wunused-but-set-variable warning
To:     Kai Song <songkai01@inspur.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 26, 2021 at 1:36 AM Kai Song <songkai01@inspur.com> wrote:
>
> We fix the following warning when building kernel with W=1:
> mm/vmscan.c:1362:6: warning: variable 'err' set but not used [-Wunused-but-set-variable]
>
> Signed-off-by: Kai Song <songkai01@inspur.com>

Reviewed-by: Yang Shi <shy828301@gmail.com>

> ---
>  mm/vmscan.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index f8b43f131673..7cf702bc1959 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -1359,7 +1359,6 @@ static unsigned int demote_page_list(struct list_head *demote_pages,
>  {
>         int target_nid = next_demotion_node(pgdat->node_id);
>         unsigned int nr_succeeded;
> -       int err;
>
>         if (list_empty(demote_pages))
>                 return 0;
> @@ -1368,7 +1367,7 @@ static unsigned int demote_page_list(struct list_head *demote_pages,
>                 return 0;
>
>         /* Demotion ignores all cpuset and mempolicy settings */
> -       err = migrate_pages(demote_pages, alloc_demote_page, NULL,
> +       migrate_pages(demote_pages, alloc_demote_page, NULL,
>                             target_nid, MIGRATE_ASYNC, MR_DEMOTION,
>                             &nr_succeeded);
>
> --
> 2.27.0
>
>
