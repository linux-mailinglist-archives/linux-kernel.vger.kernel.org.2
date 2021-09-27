Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23D524199E3
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 19:02:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235694AbhI0RE2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 13:04:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235688AbhI0RE0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 13:04:26 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9298DC061714
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 10:02:47 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id p4so37727425qki.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 10:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tNPetvOupXqRGUiN551DEoj5v4Vq3J9M2I/AbCZn9/s=;
        b=DaJH5fJcZaPTWSS82pjbCuzrmgUbbbI8rDumgBGUwFhl/oYhvIG/pZqFDRqj3etyng
         gynjZU/qESEM03OCs4i9F0KxLfb9njtq1177Zhh6o5nIU4Ak6ZFaHDvNbgLrAZMWuX+7
         /vo8yFf6ik5YAvsKvs/gkABlt5Fb5DP5jWTCc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tNPetvOupXqRGUiN551DEoj5v4Vq3J9M2I/AbCZn9/s=;
        b=cOPHO+P7l6ccj+yBL6bZ4R5z63ZglT7VxAoZIh9nkwROQ9ZC1ebEyInELSa+RhLp7Y
         Nojbn0QDY8UAMCSRiBN3pG78C4wICwQBhUDrIrFyiaYTe1bqRtwN6srrWF3X34cFEXLi
         jzK3O9bw7P9ph1sC1uvJeDVR8rOuB0XxRwkCrD0OEn0fmS4XwaXNlCMuS9xHuwpmj7oh
         6x46n0kmYn2wPiHUtIBj6uFwfiAhcy4wmf12nWCjBt4XvIYc+Xo/rGUe28Udrf7arw2O
         kG40muNNIyoX4VQpLY1/jxXP9qAo7Vwpg+HH0H59rmi8DomROXFXQsfm2QXvwFB4cvVb
         sghw==
X-Gm-Message-State: AOAM530nmbFyYOe/k6802iyhw8rrh6jFExAmySvJK7wUZG9p5GD69ww6
        tRxmnuNzDu9a5EGUAkHd0wDXBJgA1haR6gRz6vk9aQ==
X-Google-Smtp-Source: ABdhPJwBRvTBeyV1410Jpc8AMLHK25Pf6f0uExAdgdt+d7oQNAG2MpwCW4ToDnxi98Sln0HasYsHB8qhK0klEJITwTM=
X-Received: by 2002:a37:a087:: with SMTP id j129mr979840qke.253.1632762166561;
 Mon, 27 Sep 2021 10:02:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210901083215.25984-1-yunfei.dong@mediatek.com>
 <CAAEAJfDOt_GyDPojcj5P6Wou9HC2GC8YzRt2wYyqdrCOjfeOog@mail.gmail.com>
 <3b9463e88d88ce85205da08f8263252da7726ade.camel@mediatek.com>
 <aba7fb4ffe6e45ac90869b5017468386bce64d28.camel@mediatek.com>
 <b7ed8b71578a98704e9b8ca29cac63c67cc14b3f.camel@mediatek.com> <CAAEAJfCHEBFc8B7C0bu7UxtJdffvDarqgA-rset1wPjLOiV01A@mail.gmail.com>
In-Reply-To: <CAAEAJfCHEBFc8B7C0bu7UxtJdffvDarqgA-rset1wPjLOiV01A@mail.gmail.com>
From:   Steve Cho <stevecho@chromium.org>
Date:   Mon, 27 Sep 2021 10:02:36 -0700
Message-ID: <CAC-pXoMR=mOwnKqP5SFAfF3Ka5UrG0F8Mj=sJuEziU=uOKftoA@mail.gmail.com>
Subject: Re: [PATCH v6, 00/15] Using component framework to support multi
 hardware decode
To:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Cc:     "yunfei.dong@mediatek.com" <yunfei.dong@mediatek.com>,
        Alexandre Courbot <acourbot@chromium.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tomasz Figa <tfiga@google.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Fritz Koenig <frkoenig@chromium.org>,
        Irui Wang <irui.wang@mediatek.com>,
        linux-media <linux-media@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ezequiel,

Thank you for reviewing these series from Yunfei!
This series is one of the main obstacles for us at the moment for MTK
so please continue to help & support reviewing this series.

> > According to google's suggestion, it's better not to use v4l2 async
> > also.
>
> Hum? I haven't seen such objection on the mailing list.
Maybe coming from Tzung-Bi?
Yunfei, please let us know.

Steve
