Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FB6E339922
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 22:35:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235292AbhCLVea (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 16:34:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235293AbhCLVeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 16:34:24 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89C86C061574
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 13:34:23 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id mm21so55987319ejb.12
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 13:34:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tyBnlmhBLskZieTfs+bDJvdeNoM+ykRM/zdN80PKlsc=;
        b=X523DCvHD1tEWyn9zfgqQM7QusNWqwOUR41yxFrK6srzxpos19J7MjvcMp/U1JyXbF
         AW7l1KXUKkFcIpFS+raV9zWhrd4PWzbiow/b8o/xMv9QX9xZ9njderaP+N1/a7WOzU3D
         Dj1gmEgCbDVIayLwTsytc1K5BATHMPDzqJqkSnumk2hhpVj5giQBYMd1+jOMU513NiDA
         qBg8ps+cP6+mr7gR3it5EIO4Ls61pKm/f1xx/fJ37OvIj3aZwXwdqbKYkGW7DoDK8JL1
         ea9pMqM1hwkFkRwUV0l2LSNWrLgE1SRqWBvJ5+6LrCP7lfTld10BSiCFo/q4r6ZcCkk4
         I+lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tyBnlmhBLskZieTfs+bDJvdeNoM+ykRM/zdN80PKlsc=;
        b=SqkV5op1DR+QGj3wKcQLXA2O/0/RhK1M9ADDQwDHVccolF5JIzSLZL2RDdqOYV7yVZ
         pRe01eGRW1qzFktHzjbMcxW7wOMMpgn8YvJitUqARn9SiHg3R/1Yj2GgM5EFjJBxSj5K
         zv6g+ecChY8Fxull/WTrhISu/XKkR56wIuYfOY7UYpk6f50Yciv0kDvUJWbmIMFG9xIn
         DkOzsmBNg7kuP3eiHbjfW+VvXhd5Pu4K66kvh2mn1Acpnvvy1NTO6dmkjpwGdRVgFTKN
         1N847jbrzxYw3WHx+RUcGiN38OM54GHHsIWzi+cvS6ed4rQlkhoOJqmqJLg3Im6zGDC4
         0V1Q==
X-Gm-Message-State: AOAM533IdwLdvkcmDqF7G/IBl3jAYEi4NNT99R4IT7HpJjmnkzurcXJM
        19k1g+hw8IegZsXgKJdXcsSma5fiqtKM8+wkEqtg
X-Google-Smtp-Source: ABdhPJyfFlgnOEL7a6OEjpVRlJtx8exLUY2f5iNk81WPcqybaoXpPbUJ/70Tg0g9F6vRRn4U7o8jRuO86bVTJrc/Ho4=
X-Received: by 2002:a17:906:3ac3:: with SMTP id z3mr10996358ejd.106.1615584862264;
 Fri, 12 Mar 2021 13:34:22 -0800 (PST)
MIME-Version: 1.0
References: <ad54a5c360cf9566a59cc9fcc845444bf98edc69.1615411659.git.rgb@redhat.com>
In-Reply-To: <ad54a5c360cf9566a59cc9fcc845444bf98edc69.1615411659.git.rgb@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 12 Mar 2021 16:34:11 -0500
Message-ID: <CAHC9VhQFoSTBy+L3JCmatb1xW8Mn7Rxy7f_3EcJfXgo3tXuWew@mail.gmail.com>
Subject: Re: [PATCH] audit: further cleanup of AUDIT_FILTER_ENTRY deprecation
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Eric Paris <eparis@parisplace.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 11, 2021 at 11:38 AM Richard Guy Briggs <rgb@redhat.com> wrote:
>
> Remove the list parameter from the function call since the exit filter
> list is the only remaining list used by this function.
>
> This cleans up commit 5260ecc2e048
> ("audit: deprecate the AUDIT_FILTER_ENTRY filter")
>
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> ---
>  kernel/auditsc.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)

Looks good, merged.  Thanks.

-- 
paul moore
www.paul-moore.com
