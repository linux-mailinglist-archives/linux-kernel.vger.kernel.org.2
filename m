Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A100A316504
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 12:21:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231310AbhBJLUP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 06:20:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230294AbhBJLM4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 06:12:56 -0500
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1A91C06178A
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 03:12:15 -0800 (PST)
Received: by mail-qk1-x72d.google.com with SMTP id q85so1186775qke.8
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 03:12:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l6Aa5lO3nX8StZdHni5HLbVJmff/S5b/H+w9der7I6w=;
        b=cH20E2hoIgdhIv7ZUGg4Kji8fgP8I30rf969LiyzfgKSxFOVljcaILS+YDx1Arwknx
         NceojQ07JRuMuscoqMNGTcoOSE0ca9QeIpAoockv+iRRDufhxNTrOx9NrnJrLFOH3CUb
         I4BT4EZY69waZThVs0Y8J7Kl4IYq4Tv96JYCPcICcqkvxrSX9ypNEYanl25M50qa2lvg
         JPJ4jCBd2/pVVVR3XP5NX/FfnayqWe50rMBw0DV7nlvxOz1BypO2JSQN/+Ae2VfB4DXd
         dnDqL5A9kUsz1OvkU6/L4JO/499Cz6+z/3M7bWB2e5FNhd2NhDZd+YCZK5doStLcqZef
         uNKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l6Aa5lO3nX8StZdHni5HLbVJmff/S5b/H+w9der7I6w=;
        b=OLMUJfvzwoL1zKNbFnGQdjZtm5kpMo02uVPbtYZzQPLHnVtexc/UTF48rHgvDXXgA1
         9KyYN/YXk6D7OWaIyR4R/EL9qgrK4k8rL6nM5EFPnGIgrJZxzm3uqBNVIo/VbqPw/s+j
         IBQB9Rf5glGIRioAZcBuz2i8owcXtqfYhkzu+VhnKbOi1pXoZaaOFG7PA0QOtkCzKN+K
         G7rj2EI/inHL/zFPuGRtj3SvTJ4itaxshVaeNlKhLy6XFdQ0UBJk9Qa5u1rQ0SRx4jhc
         sbPCcdVRfyFupSPKVr9iVj14G36S9MJzuYqGm+zMwWTwJAhlQyV3Tn/dppVbI4rwL5uJ
         Pbrg==
X-Gm-Message-State: AOAM533AyRAXYYXSuWeJLdCxP/6ulTn0RNZG+e6kpNzGif0npenJEiCc
        5HjDCMH3hWJKUKL25eQDao9op/WvFNDtTLOEjn6C7PfighQ=
X-Google-Smtp-Source: ABdhPJwsDcMa+DYZsa8ZrxJYIhlNsLdkVt1FpNlaoYv1QSqXBAhIM+dt/pKZRTwrf49Vu75DpaqqwcLJpz8kmVkv2bY=
X-Received: by 2002:a37:678b:: with SMTP id b133mr2707612qkc.237.1612955535243;
 Wed, 10 Feb 2021 03:12:15 -0800 (PST)
MIME-Version: 1.0
References: <20210124232007.21639-1-richard@nod.at> <CAJfpegvN2KdMj_7T-OF1PAs8xZiU3f4233AvigaXwwRAsgQEjw@mail.gmail.com>
 <563952295.378372.1612881357746.JavaMail.zimbra@nod.at> <1923896038.379134.1612901174023.JavaMail.zimbra@nod.at>
 <CAJfpegufojx4q_CfR6L-fzSyQw9QXJZKy5xKVZZWaepADkL=Kw@mail.gmail.com>
In-Reply-To: <CAJfpegufojx4q_CfR6L-fzSyQw9QXJZKy5xKVZZWaepADkL=Kw@mail.gmail.com>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Wed, 10 Feb 2021 12:12:03 +0100
Message-ID: <CAFLxGvxhxxfT_ugmeFuqZ099Z+v-ENg9C6zq78sV45YzA5_Y_w@mail.gmail.com>
Subject: Re: [PATCH 0/8] MUSE: Userspace backed MTD v3
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        Ron Minnich <rminnich@google.com>, sven <sven@narfation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 10, 2021 at 11:18 AM Miklos Szeredi <miklos@szeredi.hu> wrote:
> > Does this more or less what you had in mind?
>
> Just moving the whole internal header file is not nice.  I did a
> mechanical public/private separation of the interface based on what
> CUSE uses.   Incremental patch attached.
>
> But this is just a start.  From the big structures still left in
> <net/fuse.h> CUSE only uses the following fields:
>
> fc: .minor, max_read, max_write, rcu, release, initialized, num_waiting
> fm: .fc
> ff: .fm
> fud: .fc
>
> Dealing with the last 3 is trivial:  create and alloc function for the
> fm, and create accessor functions for the accessed fields.

Ah, ok. So the goal is that <net/fuse.h> provides the bare minimum such that
CUSE and MUSE can reside outside of fs/fuse?

> Dealing with fc properly is probably a bit more involved, but does not
> seem to be too compex at first glance.
>
> Do you want to take a stab at cleaning this up further?

Yes. I guess for MUSE the interface needs little adaptations as well.
But I won't be able to do this for the 5.12 merge window.

-- 
Thanks,
//richard
