Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AA653F5D11
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 13:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236298AbhHXL3B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 07:29:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46547 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235509AbhHXL25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 07:28:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629804493;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=csZdA38ecZk4uzGs0BOWcnl0I/SkMeploJ4X7WtB8Yg=;
        b=aztByu6WayThQN53bp0LtYjSVKzhL8s5DffGpULa8175eJT+vQFitqw9sYReGKefpKToXp
        OGga6MhKf1AsXC0Iu9wjjiFzhQ0qrj32iCnu5+Gyt2Ft9MVJNUU7tPCwUSxIc5JKPoKllF
        ifG3VG8W61MNWPvKZLFymAR9Qrq0Ud0=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-377-GB-jpdj2N_iGOkt_TVPVkQ-1; Tue, 24 Aug 2021 07:28:11 -0400
X-MC-Unique: GB-jpdj2N_iGOkt_TVPVkQ-1
Received: by mail-yb1-f200.google.com with SMTP id x5-20020a0569020505b0290592c25b8c59so19467082ybs.18
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 04:28:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=csZdA38ecZk4uzGs0BOWcnl0I/SkMeploJ4X7WtB8Yg=;
        b=PfxY7lwu1Fm62nh7kJlxRrr6TsNzksuQS39GQyzSywFWJWlHHQ+yg3rgsjlGhe87TJ
         NFkmbg49rBnamTX2f0FAhCHMZSrBCM/imBPIMl/RGFUbsf9/7YyAK/yfVDSsqKRypY42
         Z/I/e2L3H6WTk45LczkPt4EOht9GR5FF9op998o1Vkq4H7xq/Sk2ZY/RCIoy70WeOgUd
         XtHlxgzJDG/fiLbcohpE3bay/RqnKx6ly5V+TaUeptfeVoWUkpGL4fCkQLWWa7SsMi4W
         G1Sd+hWztA58jANpIMvhIeCLIMqMt2tct3w+mmVIRUc5SIZhD9r6WghXAsaa2GhHekQz
         KtlQ==
X-Gm-Message-State: AOAM532od/rUY5jeu/SnY2Xei+wO3422Me16kZR1I13CO5wGH48jpY+I
        MTwnnF2eQDsmsFGfBNKuj/ZwJC6/W7sQUa1ksX9T1Ni6UNoDJSjjbXVjeGHUjkc0qvRVya5hZxP
        c6hN3vt03QgLYBXOB/rSSQxIaOw2MT0H3m/86d8Wp
X-Received: by 2002:a25:6b50:: with SMTP id o16mr24086392ybm.400.1629804491445;
        Tue, 24 Aug 2021 04:28:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwhxz4MIsdc6SyQJMK3YjKVl+ABJrorZOL2PApPZT9gBrMSKrcSMF+pCYDUGd9qq3de3bXD6B1RjNxJHljcSJU=
X-Received: by 2002:a25:6b50:: with SMTP id o16mr24086370ybm.400.1629804491221;
 Tue, 24 Aug 2021 04:28:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210824022247.GA22908@raspberrypi>
In-Reply-To: <20210824022247.GA22908@raspberrypi>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Tue, 24 Aug 2021 13:27:59 +0200
Message-ID: <CAFqZXNuOnMpV4RJDej2tp8_2OkZLuxuC9X7jBpKGs00MAQADPQ@mail.gmail.com>
Subject: Re: [PATCH] selinux: remove duplicated initialization of 'i' for clean-up
To:     Austin Kim <austindh.kim@gmail.com>
Cc:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        SElinux list <selinux@vger.kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        kernel-team@lge.com, austin.kim@lge.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Austin,

On Tue, Aug 24, 2021 at 4:23 AM Austin Kim <austindh.kim@gmail.com> wrote:
>
> From: Austin Kim <austin.kim@lge.com>
>
> The local variable 'i' is used to be incremented inside while loop
> within sidtab_convert_tree(). Before while loop, 'i' is set to 0
> inside if/else statement.
>
> Since there is no 'goto' statement within sidtab_convert_tree(),
> it had better initialize 'i' as 0 once before if/else statement.
>
> Signed-off-by: Austin Kim <austin.kim@lge.com>
> ---
>  security/selinux/ss/sidtab.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/security/selinux/ss/sidtab.c b/security/selinux/ss/sidtab.c
> index 656d50b09f76..301620de63d3 100644
> --- a/security/selinux/ss/sidtab.c
> +++ b/security/selinux/ss/sidtab.c
> @@ -374,7 +374,7 @@ static int sidtab_convert_tree(union sidtab_entry_inner *edst,
>                                struct sidtab_convert_params *convert)
>  {
>         int rc;
> -       u32 i;
> +       u32 i = 0;
>
>         if (level != 0) {
>                 if (!edst->ptr_inner) {
> @@ -383,7 +383,6 @@ static int sidtab_convert_tree(union sidtab_entry_inner *edst,
>                         if (!edst->ptr_inner)
>                                 return -ENOMEM;
>                 }
> -               i = 0;
>                 while (i < SIDTAB_INNER_ENTRIES && *pos < count) {

I must say I prefer the original version more, because it makes it
clear when you look at the loop that it starts at 0. Once you move the
initialization to the declaration section, readers will have to scan
the code upwards to find it out. As is, it's also less prone to error
if e.g. someone adds another loop before the existing ones and reuses
the variable.

In case anyone is wondering why I didn't make these for loops when I
wrote this code: Since the loop condition a little more than the usual
"for(i = 0; i < n; i++)" pattern, my intention was to emphasize that
this is not a "regular" for loop and that readers should read the loop
carefully to not miss something. But perhaps that's not a good reason
and they would look more natural as for loops. If others think a for
loop would look better here, I'd be OK with a patch that makes these
into for loops instead.

>                         rc = sidtab_convert_tree(&edst->ptr_inner->entries[i],
>                                                  &esrc->ptr_inner->entries[i],
> @@ -400,7 +399,6 @@ static int sidtab_convert_tree(union sidtab_entry_inner *edst,
>                         if (!edst->ptr_leaf)
>                                 return -ENOMEM;
>                 }
> -               i = 0;
>                 while (i < SIDTAB_LEAF_ENTRIES && *pos < count) {
>                         rc = convert->func(&esrc->ptr_leaf->entries[i].context,
>                                            &edst->ptr_leaf->entries[i].context,
> --
> 2.20.1
>

--
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

