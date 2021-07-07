Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D7DF3BE948
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 16:04:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231992AbhGGOGi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 10:06:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231978AbhGGOGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 10:06:37 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE0DDC061574
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jul 2021 07:03:56 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id fs7so1616576pjb.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jul 2021 07:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lucidpixels.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kWNFrdwm6dcxTY21QGy8ATtNEyVg7/urw+nLZear+zs=;
        b=o4LRhO72WAxkjFpfvMzD3o/1FAAsCDu5aCw510DNs2eBNaSjlYrIpkFykrCVLDKL1U
         s59iySE/2R0meVkyYsRh5/aDMK2bs5d4t0ndd2qReWnaVYQegobQk7Cl2U686PIlSYjm
         pdbAwpEjOIaO8QJgjaarjHwHNjQdodwuy5TII=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kWNFrdwm6dcxTY21QGy8ATtNEyVg7/urw+nLZear+zs=;
        b=T8WH6XjliYnicPTbAKNPWHg02NTKf/uWq4pMYH1Zs+FHKMO8kvnJPk40+GHpzHIiGx
         ZxptFXQk+9mMYU4pMz0uq4D0M3hFzHxmd0kkiRmFBGFW+lGcEBz6nLyfoI01qI+oMDOo
         8zeE0IQdtT2kdPImQHWz6SEHMj71mejhSJ+yUy09hHMH4hXqpVpPGnj9/nHCPdBmPCXs
         b+AqfgF2/HETr0eFP/ONgCnKlgOHsCZUdQBs9pjKVaS0Mvz02Wo/g8TKbn//dXlsS+Uh
         aurqEtuThJAU5Gv6WhzTE2dD6gUdb97acv6vow7pIUoibp0pBUFo6YCWnwN+RLJUHd4I
         AigA==
X-Gm-Message-State: AOAM530EfLJDdJHdrZ/14WmPhVYvEFry3ttDBjXmZDQQFMUwl7Xb3UKd
        j1WBaTbKtmMuO4b8Cg/8qlkhH71Ehta0AM64qYR7eQ==
X-Google-Smtp-Source: ABdhPJzYp4Rxfp2XxhR8boKcjXa39jZOtwTV1136/jM2Fr+/Zu+vKcUvF1dLgCaH0tcVOYCbMrw1b4sciZnGYydNn9s=
X-Received: by 2002:a17:902:7b8c:b029:129:5733:2e3b with SMTP id
 w12-20020a1709027b8cb029012957332e3bmr21491990pll.4.1625666636278; Wed, 07
 Jul 2021 07:03:56 -0700 (PDT)
MIME-Version: 1.0
References: <004d01d76cd3$18db1830$4a914890$@lucidpixels.com> <CB1159AE-7C7F-402C-9F52-954FFAEAAEE8@oracle.com>
In-Reply-To: <CB1159AE-7C7F-402C-9F52-954FFAEAAEE8@oracle.com>
From:   Justin Piszcz <jpiszcz@lucidpixels.com>
Date:   Wed, 7 Jul 2021 10:03:44 -0400
Message-ID: <CAO9zADz9S1MhnWbA3OA5hJ6vkbu3-2Hakk86orR=92AWBvkQnQ@mail.gmail.com>
Subject: Re: linux 5.13 kernel regression for NFS server
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 29, 2021 at 9:01 AM Chuck Lever III <chuck.lever@oracle.com> wrote:
>
> Hi Justin-
..
> > --- config-20210628.1624867695  2021-06-28 04:08:15.152781940 -0400
> > +++ config-20210628.1624867962  2021-06-28 04:12:42.591981706 -0400
> > @@ -1,6 +1,6 @@
> > #
> > # Automatically generated file; DO NOT EDIT.
> > -# Linux/x86 5.13.0-rc7 Kernel Configuration
> > +# Linux/x86 5.13.0 Kernel Configuration
> > #
> > CONFIG_CC_VERSION_TEXT="gcc (Debian 10.2.1-6) 10.2.1 20210110"
> > CONFIG_CC_IS_GCC=y
>
> It's likely this regression is due to a last minute change to
> alloc_pages_bulk_array() done just before v5.13. See:
>
> https://lore.kernel.org/linux-nfs/20210629081432.GE3840@techsingularity.net/T/#t
>
> for details.
>
> --
> Chuck Lever

Hello, thank you!  Confirmed that 5.13.1 includes the fix and it is working.

Justin.
