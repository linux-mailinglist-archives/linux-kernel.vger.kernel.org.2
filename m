Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83C703ACDBD
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 16:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234632AbhFROoX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 10:44:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234590AbhFROoT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 10:44:19 -0400
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com [IPv6:2607:f8b0:4864:20::936])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7DD8C061574
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 07:42:09 -0700 (PDT)
Received: by mail-ua1-x936.google.com with SMTP id n61so3477110uan.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 07:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=nqlCd2eHu+FNO0OH2gW6QkHD4Px5yMOfqRW26XQAK2o=;
        b=kYhMqUnz83h3s/37sIDv6unVm3hgmAnDw21NoXLxZpBiEwBC4HQ+gGAsfPYatAsbuA
         X6IEjDZiJzyns2/lnFDnsJqMlW113kPs5bpoxHBn/CzbOfrqQyh9d84b9u1Mffj/ekUZ
         pAWAT6WofHxbRthUqO1Wercd8AhpTrNpbSfLM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nqlCd2eHu+FNO0OH2gW6QkHD4Px5yMOfqRW26XQAK2o=;
        b=YF3KmnuU673xY/0GEKkTDFUjphFNo6MEDzhMzSqp2uOUpC/hl3LC/d6Ks3qJU6Aamg
         FqHmkGutbmMKEqfM/sbuFQ56d6vW8LFJoFSoF2AvfGfrkMjVLMUOk93U4/JjeaRVGhdD
         /ODZohvYaroZNddsG9aiACaDXEzw9EBhBpJljQSYP5r8ocMGa1k03CnIy0nWo0nlUDHI
         j3U3N1LQlleOopVdMeWbmqzSN/gEY2SzIMNaTz4hoEMZl+NN4JOhWOGONF9yifaGVyJC
         3F64itgG48I42y4PSiWl7NOV+Jz2dbXNJyW28B21P/o6nyRnkCbvr/+NgqV+2c5qCp+r
         WqDw==
X-Gm-Message-State: AOAM5302bQZoHVhWlHCiyedBUV5x+pKywuSlY/7omdkf+1bPiloLxpES
        Yw71pIBjIopTEv6HfZDMHZuWTrEiSrz4a/ZGox9avg==
X-Google-Smtp-Source: ABdhPJxCPhcUp8VAgjMWYNQ+3Qh6e+CuVyciWjfH2mFAT6A530O3DOsPQ0ktvjy3CnVHRYCPNLlXR3q0wOPmds5CHuM=
X-Received: by 2002:ab0:6448:: with SMTP id j8mr12732714uap.13.1624027329045;
 Fri, 18 Jun 2021 07:42:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210617095309.3542373-1-stapelberg+linux@google.com>
 <CAJfpegvpnQMSRU+TW4J5+F+3KiAj8J_m+OjNrnh7f2X9DZp2Ag@mail.gmail.com> <CAH9Oa-ZcG0+08d=D5-rbzY-v1cdUcuW0E7D_GcwjDoC1Phf+0g@mail.gmail.com>
In-Reply-To: <CAH9Oa-ZcG0+08d=D5-rbzY-v1cdUcuW0E7D_GcwjDoC1Phf+0g@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 18 Jun 2021 16:41:58 +0200
Message-ID: <CAJfpegu0prjjHVhBzwZBVk5N+avHvUcyi4ovhKbf+F7GEuVkmw@mail.gmail.com>
Subject: Re: [PATCH] backing_dev_info: introduce min_bw/max_bw limits
To:     Michael Stapelberg <stapelberg+linux@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm <linux-mm@kvack.org>,
        linux-fsdevel@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Dennis Zhou <dennis@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Roman Gushchin <guro@fb.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Jan Kara <jack@suse.cz>, Song Liu <song@kernel.org>,
        David Sterba <dsterba@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Jun 2021 at 10:31, Michael Stapelberg
<stapelberg+linux@google.com> wrote:

> Maybe, but I don=E2=80=99t have the expertise, motivation or time to
> investigate this any further, let alone commit to get it done.
> During our previous discussion I got the impression that nobody else
> had any cycles for this either:
> https://lore.kernel.org/linux-fsdevel/CANnVG6n=3DySfe1gOr=3D0ituQidp56idG=
ARDKHzP0hv=3DERedeMrMA@mail.gmail.com/
>
> Have you had a look at the China LSF report at
> http://bardofschool.blogspot.com/2011/?
> The author of the heuristic has spent significant effort and time
> coming up with what we currently have in the kernel:
>
> """
> Fengguang said he draw more than 10K performance graphs and read even
> more in the past year.
> """
>
> This implies that making changes to the heuristic will not be a quick fix=
.

Having a piece of kernel code sitting there that nobody is willing to
fix is certainly not a great situation to be in.

And introducing band aids is not going improve the above situation,
more likely it will prolong it even further.

Thanks,
Miklos
