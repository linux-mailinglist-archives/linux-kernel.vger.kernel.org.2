Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38B6F401F38
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 19:36:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244160AbhIFRhU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 13:37:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:37835 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244034AbhIFRhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 13:37:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630949773;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+a05OosEmaf1AUa3FK5vtidgTLGJcrBZj/K8KbUsPU0=;
        b=EBguDvHEb0Sqe2q6T7mGAGxXHFtJby3VWc9FN/phZIhm3zx9xLNnZTUZxRmhzBGIYpVzDC
        x1UnH7BXSToZrm9acthMW0xog6COHAZbMfpEHjLgQElzekWeH1BqsxqsqTleFX4eNgqHMf
        Dy8bq5gS040RLgHq61scz7K1oPDjuVc=
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-448-uYDQ1yL9ONOtqULFzaAH3A-1; Mon, 06 Sep 2021 13:36:12 -0400
X-MC-Unique: uYDQ1yL9ONOtqULFzaAH3A-1
Received: by mail-vs1-f69.google.com with SMTP id d27-20020a67c11b000000b002c86b4e3194so2133452vsj.19
        for <linux-kernel@vger.kernel.org>; Mon, 06 Sep 2021 10:36:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+a05OosEmaf1AUa3FK5vtidgTLGJcrBZj/K8KbUsPU0=;
        b=Fzup4yViaw+o8sQFzNbiTAJgTMdqFTb5JFfNn+HQiuqYHrYI2xufxcZmeuCZEuB9E4
         +9KSeLaV5XxlhPUCi0RXSwwF3mwryAPIvrcN/Q76PtacNPt0Zs25B3Pj5Y9Btjhqhe7m
         J+Tq1WoWJU4yJIm219k2fjtjyZ9+cK1g1O2pVDEzqNDqijZOs0DuqobFnzHrPWgwZ51R
         tHNbonLwDomI7OEiFbAIiej7ohkcswZ3VmYBbBrVEosVFHeq2wM9i/xNq/gvCtSCh14H
         D5S+wjpCiByzq2GgYp1X18c/CjRFReF5OvnrwZ0s5AmEoccHeW7DXJhyYYq/yQNBvaOI
         UaXg==
X-Gm-Message-State: AOAM5332wUw8jNAHC0av3c0h1UFw2YkdPZ4h7O68Pt2WOfvdB0EAz2nk
        VdEMk3NFjVlcPiNoahDYqQMmAM9FyIn9JqRqmZGiCvcEZBeZZpyunKjvUaZsiSkn5K3RQmRXKqX
        S7zQyToOy11rpvPxTKXk0Ej8tguRJ6m+mAPrn1QH/
X-Received: by 2002:a05:6102:21d9:: with SMTP id r25mr7030151vsg.57.1630949772007;
        Mon, 06 Sep 2021 10:36:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw/AHyoVPtNR2gkeux1WVXi3KRa0vVWR6NQBmSyYp32AXvCeXirj6wdV1vgyMm8xZBnFb2qqEod38y4Al68YH4=
X-Received: by 2002:a05:6102:21d9:: with SMTP id r25mr7030141vsg.57.1630949771833;
 Mon, 06 Sep 2021 10:36:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210906163831.263809-1-jfaracco@redhat.com> <56e17907-83d7-7b45-8b0f-5d80d9005c70@kernel.dk>
In-Reply-To: <56e17907-83d7-7b45-8b0f-5d80d9005c70@kernel.dk>
From:   Julio Faracco <jfaracco@redhat.com>
Date:   Mon, 6 Sep 2021 14:36:00 -0300
Message-ID: <CAHtYXivVcodcR5b2aYnFvhgAJ7yEr0+jYzPZ+w-JxRRzuWJyfA@mail.gmail.com>
Subject: Re: [PATCH] block: include dd_queued{,_show} into proper BLK_DEBUG_FS guard
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Jens.

On Mon, Sep 6, 2021 at 1:44 PM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 9/6/21 10:38 AM, Julio Faracco wrote:
> > This commit fixes a compilation issue to an unused function if
> > BLK_DEBUG_FS setting is not enabled. This usually happens in tiny
> > kernels with several debug options disabled. For further details,
> > see the message below:
> >
> > ../block/mq-deadline.c:274:12: error: =E2=80=98dd_queued=E2=80=99 defin=
ed but not used [-Werror=3Dunused-function]
> >   274 | static u32 dd_queued(struct deadline_data *dd, enum dd_prio pri=
o)
> >       |            ^~~~~~~~~
> > cc1: all warnings being treated as errors
>
> This is like the 10th one of these... The patch has been queued up for
> about a week, if you check linux-next or the block tree. It's going
> upstream soon, in fact it was already sent in yesterday.

I noticed after seeing the same patch earlier this morning, but it was
too late to undo.
Discard my patch, pls.

>
> --
> Jens Axboe
>

--
Julio Faracco

