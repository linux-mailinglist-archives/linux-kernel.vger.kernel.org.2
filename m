Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE8C0424AC1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 01:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239889AbhJFX5H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 19:57:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239880AbhJFX5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 19:57:01 -0400
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com [IPv6:2607:f8b0:4864:20::933])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66F14C061746
        for <linux-kernel@vger.kernel.org>; Wed,  6 Oct 2021 16:55:08 -0700 (PDT)
Received: by mail-ua1-x933.google.com with SMTP id h4so3021568uaw.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Oct 2021 16:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B4ajeKSZ6zrl/IB0WedwC0S+wNiZoyctPpDLShCHEUM=;
        b=pIkhDmGWJeYEN9fozHPXeTyvKCn9+mj6A8+OKhxD40jL7FUgp+QxIQ0LU2F+yaI90z
         6fbnqUSm/2gq38m9Z4M25MdzgOq4dm82QZddyXCbBeaR+zYgT0C+GHNvPqAcyiQnsPe0
         Omvtdyfqq08gQNMOY/uNV2o275Bj5B/jKTcMBRRoN3M7BpIN7zwCs5FakFet9DyaA5GI
         5hokhIbDCDmBQgnd4HnY2p8NuRvEp6xN5VtAg44SmHpx/wVvFAk3a9w/8uL8kA5CfQ8U
         BYIjblUJYfAkr1LHx+7MT6v5UNeyH4vzcdbBcNfL01MZn2CZDZHyyCS4IkViriSGLU/D
         xEow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B4ajeKSZ6zrl/IB0WedwC0S+wNiZoyctPpDLShCHEUM=;
        b=QNBmnnvclO5dETwN8JbSnnTSh1k8LH3H/y2ZkmBUuPkTqz5y4H/tmNDXPYLw4uZHtN
         LtwDiLSZPWeT+eC6St88TLjmkhYNUZbLknRvbHmL765K4X0UObIyX2O6sjwPI99B4elM
         MFFJunBA7XBtjMXACrXDOYQ4Y5FynREi8aDDDTFdEm1EQ//q/HQs011Zi150ZgIK47YG
         mhQGQ14WB7XTQlwg8S4QYZVGAh19aT5YkkInNHU9kPbKy5ZV0FgDCCRO6+LSiDtSxPmG
         8xIIZI5/tDfrQBl7wIiTB5CwtZixHtm66czy2tehHdD4WQopqLfL2w9GUygLakNvLYoq
         7eUg==
X-Gm-Message-State: AOAM5326KJZn0BFkk4PI5N7Sjj5g9xs25UPaT1DpGeK6iFBQhbmiHpSR
        E7jygAWS7YnGIXzB6dgY1N6tTaBY9UwEVbS8DBR7pw==
X-Google-Smtp-Source: ABdhPJw+X6oiB/9ybWUt6uVNGwcJLEY3tJcxy/XsK7WUZQomWvE5wc821nETpGDf4vcZdPvCt7q2BiwTgv5maa+DMGo=
X-Received: by 2002:ab0:540e:: with SMTP id n14mr1569319uaa.73.1633564507507;
 Wed, 06 Oct 2021 16:55:07 -0700 (PDT)
MIME-Version: 1.0
References: <20211006224311.26662-1-ramjiyani@google.com> <YV4nnko8rmWAWj2+@gmail.com>
 <CAKUd0B-9ifaMBAxhaUZjppks8PCy4oCy=erRNnPBjrRxOGKUxQ@mail.gmail.com> <YV4yevOZqSJJVuVJ@gmail.com>
In-Reply-To: <YV4yevOZqSJJVuVJ@gmail.com>
From:   Ramji Jiyani <ramjiyani@google.com>
Date:   Wed, 6 Oct 2021 16:54:56 -0700
Message-ID: <CAKUd0B8ycmPuV31VoULyENuK74W8ZE-hC08LTbwv+Az9R4c2mA@mail.gmail.com>
Subject: Re: [PATCH v3] aio: Add support for the POLLFREE
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     arnd@arndb.de, viro@zeniv.linux.org.uk, bcrl@kvack.org, hch@lst.de,
        kernel-team@android.com, linux-aio@kvack.org,
        linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, oleg@redhat.com,
        Jeff Moyer <jmoyer@redhat.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 6, 2021 at 4:34 PM Eric Biggers <ebiggers@kernel.org> wrote:
>
> On Wed, Oct 06, 2021 at 04:28:23PM -0700, Ramji Jiyani wrote:
> > Should the Fixes tag refer to Commit bfe4037e722e ("aio: implement
> > IOCB_CMD_POLL") [2] in this case?
> >
> > [1] https://lore.kernel.org/lkml/20180110155853.32348-32-hch@lst.de/
> > [2] https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/fs/aio.c?h=v4.19.209&id=bfe4037e722ec672c9dafd5730d9132afeeb76e9
>
> That's the commit that introduced this bug, right?  The binder change was
> earlier.  So it seems the answer is yes.
>
> - Eric

Thanks Eric. I'll send the v4 with exact commit where the issue start
manifesting in aio with updated description and Fixes tag.

~ Ramji
