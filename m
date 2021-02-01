Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D75530A927
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 14:57:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232043AbhBAN4R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 08:56:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231314AbhBAN4O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 08:56:14 -0500
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5B08C061573
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 05:55:33 -0800 (PST)
Received: by mail-ua1-x92c.google.com with SMTP id a16so5908481uad.9
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 05:55:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0kjg+aFHtPg9b2IaXzsxcXOA46NHNDEJ2LJRqUY4/wM=;
        b=GOhfWFvQDrYbl87/i5qZXR+6cCLQRL8KHfdFpWB5my0OdLD617ZeVt+IY39BMyZp41
         Yw9XMmWVKirI6Wj7Ab7L50dokhUnBl0ceSDti1qkEzarSLXwAnvMsJnkv/O9vuOn4osk
         oAVqi+4123NYb9b9pY4BLQx5sQaIr8AtCkIV4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0kjg+aFHtPg9b2IaXzsxcXOA46NHNDEJ2LJRqUY4/wM=;
        b=CV8umk5JupYQgcL97crvLo78P30athFMWRpC7enytblX5L3ctQ2GpYblQf8S3lCjL6
         zJnLsO7n9VEReGcvO/j4pmR3aLEGaxX9Wc86Ondh5Dd83KG6zs8VhEpIRAoDMI17r8wD
         QaRTGvINAhwfrQ/0NKlMT+CO5YlRZ8dTogKAGEH5tCwqgEw1XVAy3FKqi75VlKwohHNm
         Edkx/xx5CxMizBaoSUbALPEaLJGlEa37du2FKxg9AGMl4l0LE1puxANBLzDdVUht/fIr
         sgoPcaUJ2BbYZjSFztGLv4kdUvRAJodiMCG+RMoyrlywRQ0jionMneHFpUgTylovSSXQ
         WkAA==
X-Gm-Message-State: AOAM533wT8ATPpd65V256Jr5X4IjKrtGqpavkLT7u7mCXGS+0X/HFZsv
        plISB11x2tjm3E7QhTB+pXJ7DzkgAQboBf/Z4Og/gA==
X-Google-Smtp-Source: ABdhPJwBEwVr1nZfMHqUT7xd1pje3v/uC+693A9qDAsepAr9Q4/Z9Vl+wIZl+m082os1jVkjDur/QXHkif/B1Hsf0sE=
X-Received: by 2002:ab0:6f0d:: with SMTP id r13mr9322077uah.8.1612187733120;
 Mon, 01 Feb 2021 05:55:33 -0800 (PST)
MIME-Version: 1.0
References: <20210124232007.21639-1-richard@nod.at> <CAFLxGvzQo9H8h5XpLuVDYC8uaRrPmkH444yFv3jX0LNCs_nTmg@mail.gmail.com>
In-Reply-To: <CAFLxGvzQo9H8h5XpLuVDYC8uaRrPmkH444yFv3jX0LNCs_nTmg@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 1 Feb 2021 14:55:22 +0100
Message-ID: <CAJfpegsV6SoUM_30MNWhCQVa=+qE4_j5ZSsV_Y_kBJdY_MKuwQ@mail.gmail.com>
Subject: Re: [PATCH 0/8] MUSE: Userspace backed MTD v3
To:     Richard Weinberger <richard.weinberger@gmail.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        rminnich@google.com, sven@narfation.org,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mtd@lists.infradead.org,
        "open list:FUSE: FILESYSTEM..." <fuse-devel@lists.sourceforge.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 1, 2021 at 2:14 PM Richard Weinberger
<richard.weinberger@gmail.com> wrote:
>
> *friendly FUSE maintainer ping* :-)

Seems like MTD folks are happy, so I'll review and merge when I get the time.

Thanks,
Miklos
