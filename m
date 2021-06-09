Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 274A73A09D2
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 04:12:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233143AbhFICOY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 22:14:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231699AbhFICOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 22:14:23 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45E63C061574
        for <linux-kernel@vger.kernel.org>; Tue,  8 Jun 2021 19:12:26 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id l1so35833649ejb.6
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 19:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Vs9UyG1oBggmraXiT5zXty6ypMpqvyNWXVELUMjpG5M=;
        b=y62cY8DoHM9SOXaLw/Fj6VvIonRjlNwZnGOSM5wO9tTMCIROdgn3pB5sD8Y/TgJr0+
         fQOmhN5piFrDq7J2Kzfyem7YYa//O8qOkq3CsY3rhSxFVq1da2vlk6VhV3el2TwL+Pj6
         2hxvQhPJa1j4uTR56WMIyzAxMaRdJr4ObUYZxkxDgGRlwrulymMFpca7ehQCfQuMtheO
         1BzPzR0xB6pphDm4Uw+9QAlac4gD6jb54inrJieogSHouWnY7o8xH3EccU/lo3XrvpwH
         KPeFqJ32cy/RNOZcp704DJgH0Z6+WqUvlEc5AM2+Y7GqAmaZdP41FdUBy7IUHAWCx0kQ
         g0MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Vs9UyG1oBggmraXiT5zXty6ypMpqvyNWXVELUMjpG5M=;
        b=Jp4c6lVHkKvXvZDOM1dICA96bVbrpuBN4svho/pSD9o2uZWfPNd+hfvYUUwCBLyyBO
         2WmOOENYmAGEenLVDx8OO85qsm0ivYlpi7apHK+6cM1juzr7kvZnvt0wSe4pUFqnlRHj
         hLdt2vey7Tn2zqxod667FTM/78yXF6ATpooPXKgUvk2FAd8dC5egJWC5oJj2BKTRBrFq
         iI0JwBgkwzD6JEM4sCoOvqHOojJXNaFD8GuqXQakpSrli0cDx7hcHCBlx1BjeyMlh4eZ
         drTJZxvF9+gFgFq/kKdGrtB2wTzjjW+saJZqO27/N1Y0nQhe/GrNxwX5nrr20sMGmdQ+
         0r6A==
X-Gm-Message-State: AOAM5327MRJSEHArKRJxHjdzXBldpofeRBjmT0ZlGIsSwqZL4DMmuwil
        TdnBm7cafcmtl92VaIkuoAVDukybeKbuNmfM4W0Y
X-Google-Smtp-Source: ABdhPJxA8kD5p5nenvwcdEhaha9O/90yASEyc2StjYtivU3lW5dWAh8SFyXrh2p44SH9TcT23Q+A7o3RMUIxisr9j1c=
X-Received: by 2002:a17:906:518b:: with SMTP id y11mr27127168ejk.178.1623204744048;
 Tue, 08 Jun 2021 19:12:24 -0700 (PDT)
MIME-Version: 1.0
References: <ba47c2acb7bee9102bb6a85e9ba8b5918fa3610b.camel@yandex.ru>
 <CAHC9VhTvp3Z26JbXJdq8p4T7w3GZk-1CFWY328o75-AqqUbNTg@mail.gmail.com>
 <79d5bffd63b46bb7d54ebcef4765cfca28f76ff0.camel@yandex.ru>
 <CAHC9VhQfzx6xhZz+ghkRB2UKWHmsHKjLzz_7z3L47GHOoHLchw@mail.gmail.com>
 <20210607175058.GO447005@madcap2.tricolour.ca> <CAHC9VhS341s99jZ=rb90-hHmR2vfavhBANw_wL6oJp-hasST6Q@mail.gmail.com>
 <61bf645f5daec5f7096b0c23e5407edf4b3da8a1.camel@yandex.ru>
In-Reply-To: <61bf645f5daec5f7096b0c23e5407edf4b3da8a1.camel@yandex.ru>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 8 Jun 2021 22:12:13 -0400
Message-ID: <CAHC9VhT1WGThacDZ=t_yz53yQGUzzXOoFLkBSEcyNzVuAzdp5Q@mail.gmail.com>
Subject: Re: [PATCH v2] audit: Rename enum audit_state constants to avoid
 AUDIT_DISABLED redefinition
To:     Sergey Nazarov <s-nazarov@yandex.ru>
Cc:     Richard Guy Briggs <rgb@redhat.com>, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org, Eric Paris <eparis@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 8, 2021 at 2:32 AM Sergey Nazarov <s-nazarov@yandex.ru> wrote:
>
> AUDIT_DISABLED defined in kernel/audit.h as element of enum audit_state
> and redefined in kernel/audit.c. This produces a warning when kernel builds
> with syscalls audit disabled and brokes kernel build if -Werror used.
> enum audit_state used in syscall audit code only. This patch changes
> enum audit_state constants prefix AUDIT to AUDIT_STATE to avoid
> AUDIT_DISABLED redefinition.
>
> v2: the comments of Richard Guy Briggs and Paul Moore were taken into account
>
> Signed-off-by: Sergey Nazarov <s-nazarov@yandex.ru>
> ---
>  kernel/audit.h   |  8 ++++----
>  kernel/auditsc.c | 34 +++++++++++++++++-----------------
>  2 files changed, 21 insertions(+), 21 deletions(-)

Merged into audit/next, thanks Sergey.

-- 
paul moore
www.paul-moore.com
