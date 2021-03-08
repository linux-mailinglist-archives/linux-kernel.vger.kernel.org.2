Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C670330873
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 07:51:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235063AbhCHGvY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 01:51:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235024AbhCHGvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 01:51:02 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5E44C06174A
        for <linux-kernel@vger.kernel.org>; Sun,  7 Mar 2021 22:51:01 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id n16so19321939lfb.4
        for <linux-kernel@vger.kernel.org>; Sun, 07 Mar 2021 22:51:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XEEJ+NdSVotCeqOa+J0COpT2uyZAFkgzUKOtpl6kuio=;
        b=F9c7bLbzgQ+8AYmdfA1AkrCB6L1QzKFDLjf4b4vHcDr+ssS3aVm2cBRN1LdkV1krdv
         HS2O7dX5fB34ToDTGIj39/XCOMDOXlk6btG2pnerTcMVHyTWtZR5ixl/blfarcignyS3
         +IlHiOU/PU4bFXiLZXFyge51AKxcP1UjpQ7uxb70O94dI/3A0+n/A/7aNc64odxP7f6Q
         sjCoNRS6EhXCYajVkUbSghZ8Vjq4YMCIJlSyC5F7TFz665iqs/hK33VqhutDMGkeeogF
         UaKhDcLS4+IWuAY7A/HQcvese9vOC3jZUBru0WKHjyCleFsBRZlfZrgyqSmDN+xKlH6C
         54VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XEEJ+NdSVotCeqOa+J0COpT2uyZAFkgzUKOtpl6kuio=;
        b=RMzR6t+UYXWMm4oDpRncsQjFrdRlcx46AWZfRhgccV7IglCrOsNKsYBxT5bmMjyV12
         OD7ziXJYGQRLuAr49IIDQx2rQn0xTZkb9gI3ffN5Etclu1B0CaPj6GRXYKzBUWRoG8mb
         j40QfnJtkkXl1+sO6V0xJLIQ9rAY/9gWzgQ0d3P9YliMIFZyd7AUuMR5AJ0buOC9KzS2
         kuq5d3UVg4ZYn6PyOIgUqAG89/A2e2igWiod83vvU5tq8Umou7vWS/DGn1KV2L4ADm4L
         p1evSsguIm26VMoNFjbOtfz9z/dJ3Fh2NI+AQY9RDO/XiSeVnfYJB/MxKqjId+FKxXEV
         z7Bg==
X-Gm-Message-State: AOAM531Mm1I3ICXabjy6o4dR+oAYf6mf2rIf0Zo5wnbNSasnBNC8fpI0
        4NQtQ2A6DW8mQjHITBj4ZQgWZiPBZ6U0pYgzrYjqjw==
X-Google-Smtp-Source: ABdhPJzf6blD5ezRDhly1I/2fKBsQ+75DEo7x3d66Mo8vY3YgWSuuREy3y5AvMLnQkVnWNakublLDD8up0FeOqQLjus=
X-Received: by 2002:a05:6512:39c9:: with SMTP id k9mr13229164lfu.432.1615186260215;
 Sun, 07 Mar 2021 22:51:00 -0800 (PST)
MIME-Version: 1.0
References: <20210217001322.2226796-1-shy828301@gmail.com> <20210217001322.2226796-7-shy828301@gmail.com>
In-Reply-To: <20210217001322.2226796-7-shy828301@gmail.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Sun, 7 Mar 2021 22:50:46 -0800
Message-ID: <CALvZod6KH7f5FaEcDg4NvhSdeuPjVQK1HHwHppV+vbcittLi2Q@mail.gmail.com>
Subject: Re: [v8 PATCH 06/13] mm: memcontrol: rename shrinker_map to shrinker_info
To:     Yang Shi <shy828301@gmail.com>
Cc:     Roman Gushchin <guro@fb.com>, Kirill Tkhai <ktkhai@virtuozzo.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Dave Chinner <david@fromorbit.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 16, 2021 at 4:13 PM Yang Shi <shy828301@gmail.com> wrote:
>
> The following patch is going to add nr_deferred into shrinker_map, the change will
> make shrinker_map not only include map anymore, so rename it to "memcg_shrinker_info".
> And this should make the patch adding nr_deferred cleaner and readable and make
> review easier.  Also remove the "memcg_" prefix.
>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> Acked-by: Kirill Tkhai <ktkhai@virtuozzo.com>
> Acked-by: Roman Gushchin <guro@fb.com>
> Signed-off-by: Yang Shi <shy828301@gmail.com>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
