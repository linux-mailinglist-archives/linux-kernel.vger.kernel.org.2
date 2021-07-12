Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A3413C59ED
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 13:03:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386909AbhGLJQn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 05:16:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386725AbhGLJQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 05:16:06 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B328EC0613B2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 02:08:59 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id x192so27859241ybe.6
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 02:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+FLKeeC9LXR9BXCXlpV9bHuf6gKQ/bKaDBwF05vizkA=;
        b=GoVe1d4LBmx/ZOv+Zuer4+3dyKYo69C4Qe0qmBNpU+wN0VuApYiQ7Dkb47tBlPA8FO
         Nl29BRQEBM6FxiQLd/Wg427d0OzhoYLARVZXwAuErk6SItgXKW6oTupWalr9ePX5Fk0a
         u8NCoS7LA6nVax17GprHL/zMQXIPWF3wfzryCcFrocigCzUknTO9+DFVinXXNeUeGzkS
         J4iW2cm9tl77ChSgi5DGOkNuBVEjbGZXxXQQoS5d633+t4FAEZKvjNuRRenmnSnCv7p0
         /x9HX5KmXZ/+Zv96sxxN+Lif0qIkzOa7KFuF9+Ds/eKHL2QPxy80kjeHnQScmzY2g7id
         ypYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+FLKeeC9LXR9BXCXlpV9bHuf6gKQ/bKaDBwF05vizkA=;
        b=Pkds58Q0ptSIG17obJValcWpCF95NjHOFHBAK30cvzIgk+wXLYr7IoxWKlFtO2JcBI
         j61o816xH6Kl3jpAEqS43g2D5MXKc9cmAMbU4xIswvWwh6KbYjApezfRAcvoEwzwcxVT
         a8Tq6LaCtKnKFS9Vblw368DCYkLIO8scTb6hSkZASzMk+cMAOziSJzMsQrgpvd2R9p/C
         HxRK9EkwscFFI2z/3wqZ9CRTCPlYgxVSmd8c5EPgrwMe93HzaqMGnZvDbg0iQ8MwT0J9
         rou0JS8BRGnQda2/S1R5vi/aDO44L/oS9/TD4ZAqulXHl4VbdInI6qRSl0nRP2A19qOS
         0OBw==
X-Gm-Message-State: AOAM533NaXRDpSkok8YYo2KSu8SLYcJHQ63fXz0pzdOATlY6uJ8zbAQf
        JZtiyjE0dUlYjeLTYZZn+t/qk9Jc6jfyCk0EFPc=
X-Google-Smtp-Source: ABdhPJxDmLChsK6D9Wq/XvlBcgGyTJ/Ge7YFi5bWh4gqm5/6LMEC2isXMrQtU1PIKecObY9Gc38b/rc7kjGKgyQGVZ8=
X-Received: by 2002:a25:946:: with SMTP id u6mr62084014ybm.261.1626080939010;
 Mon, 12 Jul 2021 02:08:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210709122712.42844-1-yaozhenguo1@gmail.com> <872612b5-b9c6-43aa-a167-1c204d0f1c5a@kernel.dk>
 <CA+WzARnFgohHZ=BhL4OaCagB_c1uB6a=Bv7vM_zRUJeANHksEg@mail.gmail.com> <db2410e2-1f1a-b396-10d1-1df3ec061b78@kernel.dk>
In-Reply-To: <db2410e2-1f1a-b396-10d1-1df3ec061b78@kernel.dk>
From:   zhenguo yao <yaozhenguo1@gmail.com>
Date:   Mon, 12 Jul 2021 17:08:48 +0800
Message-ID: <CA+WzARky9K+pATZb5mvOpekYa0jFsE6GQ7pR9XbZ5xoEPTgw7w@mail.gmail.com>
Subject: Re: [PATCH] task_work: return -EBUSY when adding same work
To:     Jens Axboe <axboe@kernel.dk>
Cc:     oleg@redhat.com, linux-kernel@vger.kernel.org, yaozhenguo@jd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

OK=EF=BC=8CGot it.  My patch does not cover this situation.  It seems that
there is always dead-loop when same works are added to the list.

Jens Axboe <axboe@kernel.dk> =E4=BA=8E2021=E5=B9=B47=E6=9C=8812=E6=97=A5=E5=
=91=A8=E4=B8=80 =E4=B8=8A=E5=8D=8810:44=E5=86=99=E9=81=93=EF=BC=9A
>
> On 7/11/21 8:13 PM, zhenguo yao wrote:
> > Yes I hit this condition.  The caller is queue_task_work in
> > arch/x86/kernel/cpu/mce/core.c.
> > It is really a BUG. I have submitted another patch to fix it:
> > https://lkml.org/lkml/2021/7/9/186.
>
> That patch seems broken, what happens if mce_kill_me is added already,
> but it isn't the first work item in the list?
>
> --
> Jens Axboe
>
