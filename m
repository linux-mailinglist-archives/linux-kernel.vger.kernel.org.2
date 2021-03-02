Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 721AC32A1DC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 15:13:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1836351AbhCBHBO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 02:01:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1577264AbhCBF5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 00:57:38 -0500
Received: from mail-vk1-xa2d.google.com (mail-vk1-xa2d.google.com [IPv6:2607:f8b0:4864:20::a2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97BBEC061756
        for <linux-kernel@vger.kernel.org>; Mon,  1 Mar 2021 21:56:58 -0800 (PST)
Received: by mail-vk1-xa2d.google.com with SMTP id j188so4161102vke.13
        for <linux-kernel@vger.kernel.org>; Mon, 01 Mar 2021 21:56:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FyQGX2eMD6rdBbtObdA7/Z5HmES0IXIuNjRnK1kjO1s=;
        b=XndK7/Dhs0vxfvaUMiOisvVA4lOGqSC2DLw5kP6bHqigqwNLJoeaC1uQgZ7uSgPoQY
         7OG2XduyIIq8fq9ZVXvHGCCv6Tn707+lcvUMAlaB99mynoLi0VLU9T1jSuikc9NsvzX3
         4QEK4fZ/zMu4YO271Em55YtLxqWmdB5ZVP+Wle25ZjfeX+73sipYgrcpgSitPeJnPAY8
         6wyhnaJpaVc4+te6ZDSqYg4D0nWi4hxjjE+SaeJwDwlhfVfbzCtOBHhRaHCLIuX2YDRd
         Xry0Mo4PLdDEzWazlv3J9/xKPMSgTteB08wKjMBtuf9uqwm+3fve4xFf5F6cyRkchKqp
         EdJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FyQGX2eMD6rdBbtObdA7/Z5HmES0IXIuNjRnK1kjO1s=;
        b=OGx+bbQS4Pl+DSFpYuMv8QTQSqrxRqM25u4Ib6vb0sbe8TKJGycw1xq2AoUNkjsJbw
         QQIYt3GMBmx6uD34sd+aZhxmBySFUXGtVWzpZgDValBDfBq0vjYsugP0GbFkdeP+GZUh
         I6XgM4sAXQIi2wShsMaxPb7PCQz3mpFexGdhlWs1phMDRbshRGR7glMvC6d0WvSpe7MG
         AefCoyln0ufU4mUAglsB68k1qx5S6Kq20ZmFKv9LBgoiL46wnfKrgh6SYo6tuFfNAszo
         ZcvPrSh2NGmKrS9J9nayHYrfS3xjPWdqx5Di6Fn6STWuPphhSa/KNptXXcBixHRThrLH
         J2vA==
X-Gm-Message-State: AOAM533m2zknwhT00inzJ9z7deA7dfs2jkMv+CsEeE9Q762DcM4/E/1Z
        Ko226w0YFsEXiOdJV2QIqVkysNsAWyCrXBYE990=
X-Google-Smtp-Source: ABdhPJw/xVhLKZGJK07lCSlrpxQcqWqwfvmSy8bClGRVi/883vBnbM5n7MX/epQB0Bp+arN+D+tW8MkHgPT1M38xTe8=
X-Received: by 2002:a1f:1255:: with SMTP id 82mr1371048vks.21.1614664617716;
 Mon, 01 Mar 2021 21:56:57 -0800 (PST)
MIME-Version: 1.0
References: <1597061872-58724-1-git-send-email-xlpang@linux.alibaba.com> <1597061872-58724-4-git-send-email-xlpang@linux.alibaba.com>
In-Reply-To: <1597061872-58724-4-git-send-email-xlpang@linux.alibaba.com>
From:   Shu Ming <sming56@gmail.com>
Date:   Tue, 2 Mar 2021 13:56:46 +0800
Message-ID: <CANt8P=uyGF_QvpcW+BkHzPvdo-5cdH7OXw2Ozt1gFuXHmdizwQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] mm/slub: Use percpu partial free counter
To:     Xunlei Pang <xlpang@linux.alibaba.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>, Christoph Lameter <cl@linux.com>,
        Wen Yang <wenyang@linux.alibaba.com>,
        Roman Gushchin <guro@fb.com>, Pekka Enberg <penberg@gmail.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        David Rientjes <rientjes@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 10, 2020 at 8:22 PM Xunlei Pang <xlpang@linux.alibaba.com> wrote:

>  static inline void
> @@ -2429,12 +2439,12 @@ static unsigned long partial_counter(struct kmem_cache_node *n,
>         unsigned long ret = 0;
>
>         if (item == PARTIAL_FREE) {
> -               ret = atomic_long_read(&n->partial_free_objs);
> +               ret = get_partial_free(n);
>         } else if (item == PARTIAL_TOTAL) {
>                 ret = atomic_long_read(&n->partial_total_objs);
>         } else if (item == PARTIAL_INUSE) {
>                 ret = atomic_long_read(&n->partial_total_objs) -
> -               atomic_long_read(&n->partial_free_objs);
> +                               get_partial_free(n);

Is it "ret = get_partial_free(n);" above?


>                 if ((long)ret < 0)
>                         ret = 0;
>         }
