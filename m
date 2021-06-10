Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F53C3A37B0
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 01:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbhFJXPi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 19:15:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbhFJXPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 19:15:36 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77864C0617A6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 16:13:28 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id c10so1585624eja.11
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 16:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2wq1V57QRB2EJu3YuApsOJs72DhMcHf+KyQ+W+Og+aM=;
        b=RdIdZp8EfKJJiOGA0GslcDOPC9NQyzGy3J39OA5B0L6PZpiMfFMvwGJ7f3NzwFz9KB
         jx1hVB23XDQlb0hXs+ep3ippJ9XyaTi40CnBC2fYK4h7EVNrYRyCg4tbpFuBsOij5zXj
         e9T+8ctzpf01+7GieaJc46VIjN5GbJURNjz48JzqDZvXnsS17zllFe3MnjLloOgi3tbX
         hshZgmOICeWGf/tEtHy9nBOcRWAuijJdqrtpwVoHVuRwskoDb4F4w8E6ka03ya9OsOx1
         ariGEp9k84lJIzuDmsotLta0DFwOCqbK6yx2GAMt1qFmASz4xuW+ysXtD9HXegMHuugr
         BS9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2wq1V57QRB2EJu3YuApsOJs72DhMcHf+KyQ+W+Og+aM=;
        b=LvTJMjTftNfVayaHNK8uQi7VYDikPJ9EGF1dD8I9Xs9o3RXUeEa9iK/Htn7YXR5FXo
         m7NHUxVNfNxBPxC3OMdU1jUZqeO09QnTsK/ELcCJxU5R1VR7CWU+XYGA1JAS4XoBv5Va
         RH3Wcym8pYCqZ/Zb6m2lI3EQxPC9vhKJOJxAiSksK/efYrkfpFYgr3pBzgQU8XZ4Sv44
         UEMv6aOhINMER8amxVTjs6ApSs7tIyzuL4zVWP6d0VGJjXOcxa1P6PBelp4nnkxfGz11
         06QXiB53BMw5NYW2iiVTK2pV6y5k1nmgUVZUiYnK1c/6SM+w4kpip/v6zl3+wsfAUF1Z
         l3ow==
X-Gm-Message-State: AOAM533dMNWLgym/ODhvms9efAaxIePO9Lzhtd21Z4ogjRHnpvRzqmS0
        Z2sAvYrnRqIYKhlesarI9f0Z3QV4ygRZln6eyKc1
X-Google-Smtp-Source: ABdhPJxG9+awrPvceSUEO3hN4rw0KjRho7Ah3g+sCSWUO29p/qTSBZiG5b4Vs6VCIUwR6GUuLfDgsj6Wx0aR/6yiVcI=
X-Received: by 2002:a17:906:2c54:: with SMTP id f20mr749072ejh.91.1623366806917;
 Thu, 10 Jun 2021 16:13:26 -0700 (PDT)
MIME-Version: 1.0
References: <20210609163717.2719253-1-minchan@kernel.org> <20210610160650.d2112a9db8130224c597bfaf@linux-foundation.org>
In-Reply-To: <20210610160650.d2112a9db8130224c597bfaf@linux-foundation.org>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 10 Jun 2021 19:13:16 -0400
Message-ID: <CAHC9VhTYeOmJqoyEniXLGMv3cJGBW4_BLc3LhDLBDhQCKtfp7Q@mail.gmail.com>
Subject: Re: [PATCH] selinux: use __GFP_NOWARN with GFP_NOWAIT
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Minchan Kim <minchan@kernel.org>, Michal Hocko <mhocko@suse.com>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        John Dias <joaodias@google.com>, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 10, 2021 at 7:06 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> On Wed,  9 Jun 2021 09:37:17 -0700 Minchan Kim <minchan@kernel.org> wrote:
>
> > In the field, we have seen lots of allocation failure from the call path below.
> >
> > ...
> >
> > Based on [1], selinux is tolerate for failure of memory allocation.
> > Then, use __GFP_NOWARN together.
> >
>
> Thanks.  I trust that the selinux developers will process this patch.

That's the plan; this is in my review queue for this evening.

-- 
paul moore
www.paul-moore.com
