Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91F5940D303
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 08:01:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234520AbhIPGDH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 02:03:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234420AbhIPGDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 02:03:06 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDE76C061574
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 23:01:46 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id s11so5131283pgr.11
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 23:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vH9dgIGnKQD/XuZKe2gA/GBC6e3WA0eNQdhDGFa/TpU=;
        b=Km1jbC1/4B+mL6WKH3iLdl9fU5JlLh6OboIUabomRmPCGOsKIOLVCq9yBg7nYND3C6
         g+pF3IbM590GbUI3XnL5vRVRk4dOsEfW42znUCizhl4tNm9KyLBKw1PwZtjB4vkUrV9+
         bFhnNewhKUUxDM9TLQm7qvggwc2q5v+SgjH2aHDGsMHpS5LCN9MDHvSUV59JCFSPs8O1
         gUkDc3OyIS0pfrJrDhKTYcO79eqWLVY6hLbhuxJf8q+Ycgq/qO/ECg72CjvOJianP6MA
         /O0hEV6VXJaEob/8mku/JU2tPBgjHPZJg5C159+mxaDe0zW4vRVj8jdy4DDlYPLDNStf
         85ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vH9dgIGnKQD/XuZKe2gA/GBC6e3WA0eNQdhDGFa/TpU=;
        b=NG0ONgcLrDrerUQ59gK3/KRY8QLlRfWFplGUYDnSmbgjda82Vq4tgyfwD7DDt8O5D1
         xh6SB/mzC0owkBx6jPBk3XWFhSBb5mjOdN9vvgYvkfBUjZ6IhN6xFrqz9DXUWFDbCJze
         FBiF3g8iWa2/Wc9sWYzHhidBbTFUk7DGiRryCWh/LcuHw4IOH50D0YzrYi2lxJ5y4O57
         q/3Dehs1X2zQwL5cVSycBoj5ztSFaIfPNtPSTTTLxgFpzo5hC3qI/a9eZfTPd0L5UQyl
         GdmjahopJrvZWZZODNGR3MRbuz3mnV08HJfbyZPEGTWmwWfer89l31XKHQl/Tad1qd2Z
         jHlQ==
X-Gm-Message-State: AOAM532XI4D6zSOEFE73Vx3nhln2C3HsA0Jmun9yBZe8FJG8vX5DPDvz
        HukUcB17s0acUeFkiYhajgx3gkDZfZQJqluu9R72ibMUcqpZiw==
X-Google-Smtp-Source: ABdhPJzGf8kyrA66qjieGtx5CC/yGLbZJMqxNZp7t+zL2Cg7mGno0tshY1OyB9WQmltyINdM7DIP4BSuKCJDnDwDkCc=
X-Received: by 2002:aa7:9e8d:0:b0:406:be8:2413 with SMTP id
 p13-20020aa79e8d000000b004060be82413mr3412443pfq.66.1631772106170; Wed, 15
 Sep 2021 23:01:46 -0700 (PDT)
MIME-Version: 1.0
References: <f4f3187b-9684-e426-565d-827c2a9bbb0e@virtuozzo.com>
In-Reply-To: <f4f3187b-9684-e426-565d-827c2a9bbb0e@virtuozzo.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Thu, 16 Sep 2021 14:01:07 +0800
Message-ID: <CAMZfGtXQHRzZ8JZw=jnZ3AB2bdd6yWrGjNf_KpNnL+tQFN5eow@mail.gmail.com>
Subject: Re: [PATCH mm] mm/vmalloc: repair warn_alloc()s in __vmalloc_area_node()
To:     Vasily Averin <vvs@virtuozzo.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, kernel@openvz.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 15, 2021 at 7:43 PM Vasily Averin <vvs@virtuozzo.com> wrote:
>
> Commit f255935b9767 ("mm: cleanup the gfp_mask handling in
> __vmalloc_area_node") added __GFP_NOWARN to gfp_mask unconditionally
> however it disabled all output inside warn_alloc() call.
> This patch saves original gfp_mask and provides it to all warn_alloc() calls.
>
> Fixes: f255935b9767 ("mm: cleanup the gfp_mask handling in __vmalloc_area_node")
> Cc: Christoph Hellwig <hch@lst.de>
>
> Signed-off-by: Vasily Averin <vvs@virtuozzo.com>

LGTM. Thanks.

Reviewed-by: Muchun Song <songmuchun@bytedance.com>
