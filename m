Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C51EC38BCE1
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 05:13:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238830AbhEUDOx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 23:14:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59784 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233224AbhEUDOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 23:14:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621566807;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=o+bViK+7PTgQkxKVxmLwJJadvz1EMcPfzuNvZmOXTgk=;
        b=b/pAD08HjWlyfgEsGGV4SUObUjcZBYUHy3wRFGdJzWHEOYiIWH0p2vfh1/cB+LkLWOfhca
        l0o3nkFCl54AJQhoF++F7/dKaWmw7im5oYmP5bJhXOG7gAzQxO7WEE7k1SdoDgoVl8Goho
        oI/OmEVRC9os9VP/slczwN9sgBl9XTI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-473-DBVGf6ZpNPuzu51rx1t-Kw-1; Thu, 20 May 2021 23:13:25 -0400
X-MC-Unique: DBVGf6ZpNPuzu51rx1t-Kw-1
Received: by mail-wm1-f69.google.com with SMTP id k124-20020a1ca1820000b0290175dd5429afso3206112wme.7
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 20:13:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o+bViK+7PTgQkxKVxmLwJJadvz1EMcPfzuNvZmOXTgk=;
        b=mbhd6uQf1dgPSq2NYNKMTi5aR/pFyIVqcf5M/2/YLVV9zATe5B9MCtdkZ6x6uBBwUW
         vB/5Hb3g/VmSVBj7bRqCnwMlfFlzT/xdQCW33lByQ2I/kUyXJzi9M+Oupw9JP258KIft
         NFgrWtcvvpqjVmlvN8md/boBKBjtA0XkshBdJtyXI3UHrCRseTWwWLfvAlkfrkZJs9Wp
         7s9Bns4YCGGvjblSuHlHNCb6+5wiTYesfPaEXUUBrzSE9CilLJ9Zuc1KubetEaBRIJFA
         YuvmyoGLdUmitO6DcZb6FyoH1euZ3E/G26FEcQUp/uQxJA5IaRubmhQ+lOHZQZ9h7ti4
         DyJg==
X-Gm-Message-State: AOAM5304sICyClkJKgUOqHFtFKmjbZIOVj7y2L4ASPTs9GRtLL7CE9TC
        dytHrojZR+dtlfbjluiEotlv5sVN3WJwIoxetF0gwFF9SjgUat/78WTq3WnjEtAVi2x4NRQgt6y
        c2VjS+jB08V1sV0+3SvmHGJVfmUX8GW8F7tlvKwr1
X-Received: by 2002:a5d:64a5:: with SMTP id m5mr7045071wrp.182.1621566804378;
        Thu, 20 May 2021 20:13:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzmGVfnDnhXyzF/fPnKqbtcfmKRXvvxw2jCT8VeWGkK/Q9520GpMy6L+N44cxe6vao1Tg1CswfpSCoH0YDhOv8=
X-Received: by 2002:a5d:64a5:: with SMTP id m5mr7045059wrp.182.1621566804198;
 Thu, 20 May 2021 20:13:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210520120043.3462759-1-lee.jones@linaro.org> <20210520120043.3462759-3-lee.jones@linaro.org>
In-Reply-To: <20210520120043.3462759-3-lee.jones@linaro.org>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Fri, 21 May 2021 05:13:13 +0200
Message-ID: <CAHc6FU429=1Hzoghqo3=hqkSSmja3+ujna=mE_-Ro=KOMTPecg@mail.gmail.com>
Subject: Re: [PATCH 02/15] fs: gfs2: glock: Fix some deficient kernel-doc
 headers and demote non-conformant ones
To:     Lee Jones <lee.jones@linaro.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Bob Peterson <rpeterso@redhat.com>,
        cluster-devel <cluster-devel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 20, 2021 at 2:00 PM Lee Jones <lee.jones@linaro.org> wrote:
> Fixes the following W=1 kernel build warning(s):
>
>  fs/gfs2/glock.c:365: warning: Function parameter or member 'gl' not described in 'do_error'
>  fs/gfs2/glock.c:365: warning: Function parameter or member 'ret' not described in 'do_error'
>  fs/gfs2/glock.c:461: warning: Function parameter or member 'new_state' not described in 'state_change'
>  fs/gfs2/glock.c:1277: warning: Function parameter or member 'delay' not described in 'handle_callback'
>  fs/gfs2/glock.c:1277: warning: Function parameter or member 'remote' not described in 'handle_callback'
>  fs/gfs2/glock.c:1578: warning: Function parameter or member 'p' not described in 'nq_m_sync'
>  fs/gfs2/glock.c:1993: warning: Excess function parameter 'wait' description in 'gfs2_gl_hash_clear'

What's that? Those warnings don't exist in mainline, and the two
warnings we have in mainline are fixed in for-next:

https://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git/commit/?h=for-next&id=75069590915f2

Andreas

> Cc: Bob Peterson <rpeterso@redhat.com>
> Cc: Andreas Gruenbacher <agruenba@redhat.com>
> Cc: cluster-devel@redhat.com
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  fs/gfs2/glock.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
> index ea7fc5c641c7e..0b34f50b51331 100644
> --- a/fs/gfs2/glock.c
> +++ b/fs/gfs2/glock.c
> @@ -356,7 +356,7 @@ static void gfs2_holder_wake(struct gfs2_holder *gh)
>         }
>  }
>
> -/**
> +/*
>   * do_error - Something unexpected has happened during a lock request
>   * @gl: The glock
>   * @ret: The status from the DLM
> @@ -1263,7 +1263,7 @@ int gfs2_glock_async_wait(unsigned int num_gh, struct gfs2_holder *ghs)
>         return ret;
>  }
>
> -/**
> +/*
>   * handle_callback - process a demote request
>   * @gl: the glock
>   * @state: the state the caller wants us to change to
> --
> 2.31.1
>

