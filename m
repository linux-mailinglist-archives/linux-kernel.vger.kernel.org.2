Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 065863A72DB
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 02:16:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231224AbhFOASK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 20:18:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230428AbhFOASG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 20:18:06 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF6B4C061280
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 17:15:49 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id i13so645540lfc.7
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 17:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OJtrJImbv894aodHlfGhvjA96ubk8744/VBgEgqJsgg=;
        b=Cxl9CXmWtz6h3PBXK42GHtNtfVUK5gKSW3Bsm7bc21uVLBqTXc0oBPwRCh5hatbWG6
         VpIR43wqYbfMkh9ONF4JNMCU6ega7BcjDnKAoLwgOwwdIqH22htYiy2h1+sPC8zTbmhq
         Z3r9WhzjMXGUVtT9KnfCBuOGwDR8AEz5CMlPevXWDGsUTrN7N2qAkXEXxQ0RFz5OhLfG
         7RAzrMvRGztMFxAHJXnneCWAyCabqreMHB6qmAShHhoySjbgMudBvS3sDadYtwPTECKZ
         E3m8IjqYcL0ShbV+FnTrOOb33ngy5Yyj8ZmjUcKPBpU0kR7ApK2DarI/v8PuwlgpWjHF
         pBvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OJtrJImbv894aodHlfGhvjA96ubk8744/VBgEgqJsgg=;
        b=B4wZW5rteVMxVtQ6gcVXC1/HJVQ8gWUJXdlxmNOERX98o0KUCzsIPzPHwDKnb72rWj
         JN5rv8/buJGSgoBrczKd7oHuUVG5rMwZywr6CNeRCiUecDHgMxMNdYGju6L23xbiRTO5
         W+HHHJi2rU/KcHG/YNRy3hQh7sSTv3MZHxwBsgBnwhx8eCgMywwbQ9sU5TetSgkeBioW
         GVF+auLJUGJUT7MNwNvYxlSzUe+h7KZjI800jkkeIC1L/6WUa5mLGcHDrC8stVXv3dR9
         FPqpjJFkPU5L8rct5K6gs3N5vFTWDxm1eFdL0dbQxRtgREPwyXp7XY72EYc5IC9aLDcJ
         1y3w==
X-Gm-Message-State: AOAM531Lawyl68zi/Mc8Yg7UtWm61WgKFJmm8nYkqcQfd6V8XnIfV+k0
        7xbe6HzNxmvUy2IE1fZMirSWkzgaDMKci0r3dROb6Q==
X-Google-Smtp-Source: ABdhPJyFyHO5Xro3C4S+sJNTeLWyx3XDOZQ/K/8BNHg5b1NdtjnrP4nlhc2BpXedLYZme4raFzI/rFKdmJPaDDHjrzI=
X-Received: by 2002:a19:7015:: with SMTP id h21mr14090352lfc.299.1623716147913;
 Mon, 14 Jun 2021 17:15:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210614091530.22117-1-denghuilong@cdjrlc.com>
In-Reply-To: <20210614091530.22117-1-denghuilong@cdjrlc.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 14 Jun 2021 17:15:36 -0700
Message-ID: <CALvZod76wUmZ=EyaCeWKKAOaynpdWNMbcT_uz13LJJ4AunOV2Q@mail.gmail.com>
Subject: Re: [PATCH] mm: memcontrol: Remove trailing semicolon in macros
To:     Huilong Deng <denghuilong@cdjrlc.com>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+lkml and linux-mm

On Mon, Jun 14, 2021 at 2:15 AM Huilong Deng <denghuilong@cdjrlc.com> wrote:
>
> Macros should not use a trailing semicolon.
>
> Signed-off-by: Huilong Deng <denghuilong@cdjrlc.com>

Reviewed-by: Shakeel Butt <shakeelb@google.com>

> ---
>  include/linux/memcontrol.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 3cc18c2176e7..1c1b11530ab6 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -192,7 +192,7 @@ enum memcg_kmem_state {
>  struct memcg_padding {
>         char x[0];
>  } ____cacheline_internodealigned_in_smp;
> -#define MEMCG_PADDING(name)      struct memcg_padding name;
> +#define MEMCG_PADDING(name)      struct memcg_padding name
>  #else
>  #define MEMCG_PADDING(name)
>  #endif
> --
> 2.31.1
>
>
>
