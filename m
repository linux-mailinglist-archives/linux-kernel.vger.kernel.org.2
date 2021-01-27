Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 642C13060C5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 17:16:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343915AbhA0QPb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 11:15:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235078AbhA0QNz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 11:13:55 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6AB1C061756
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 08:13:11 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id z22so3095002edb.9
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 08:13:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yCJr5LaWhWMU0GEv1VBLBRwE+7yrkKij+9EAYt1Xy1Y=;
        b=bPf2zHTV4+wJn2TwThn/ciUqtN5J+OBKLsllaBgPD9jYr7oo+SFzuqeWtlZyojcvxx
         0Z3iEq8J+5enD78FQ4TqXtZen+55GTxa2Eg9espAPPmehigHIEbAnPLLan09hbTWaUYk
         zMs9FosvenRGKAXIdYMno2Fi8MfUjLuxPedQX0yXrdv/a4Mvi0acS81fB5jTtbPOv3Bg
         A9hdVjuOnlbd1ykNcWiZNKI2DivE2fxjHkE62bZJBMgcxsZITg6wz6zqfLT4AYyzH+pS
         o7OUrr4JZYb4U4h0DXZsWAZOtzStcCwsX6SCTrx3a//Mm0cJD7Npa1ZeOgJe27NVCpUL
         JEEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yCJr5LaWhWMU0GEv1VBLBRwE+7yrkKij+9EAYt1Xy1Y=;
        b=WisK+vu+fPsoBuDOXSznHd3MnERpIXTu/BBuW40LmqRBdBP2n7QYaUyVz4EkDGd86X
         zyQgVYXMHvfAJMd1I3TKFwkjWjwc5a0VJS4/+lGQ5zgMnh6ggNL/dBXLicryXt2kVNyK
         RkofVWGBeoSvH3kBxM1aUYMG2TNE0D+OGyAHkRx+7zrC6fmYRAmpGxR/pHjjDTpy3SV4
         I1HILZeZFgzNYyQTLW6y0ETA07ZIHrQr9Hkms+XgHXFTL3rwXoUMd0gSmxjd0HAvLxdj
         lWZao4A82yIt9F+Ss8HLxXv9A9tLApMuz+xDS6urvkBdWwBmUON3a/Ytjga/VyuUd+P2
         QAUw==
X-Gm-Message-State: AOAM530Ga4IoI1DlswTIkyAEqIvaLNViZgbuKSyZUdhaat7s6ivAZezV
        oAJCcmtZxLbRjsqABzfAJ7K5TDn+3ELYJX7A46MirA==
X-Google-Smtp-Source: ABdhPJxx5owWBx3b1CUl8+dsHwfcv0N4UFWJBm3EBtbpVbarbqqVzqrRDi4HH2oGoHcMmLrl2KO11jdURI5j8PiP/5c=
X-Received: by 2002:aa7:d803:: with SMTP id v3mr9489359edq.153.1611763990574;
 Wed, 27 Jan 2021 08:13:10 -0800 (PST)
MIME-Version: 1.0
References: <20210126144630.230714-1-pasha.tatashin@soleen.com>
 <20210126144630.230714-2-pasha.tatashin@soleen.com> <daf21294-f51e-3f03-8a46-d0181104d9e3@kernel.dk>
In-Reply-To: <daf21294-f51e-3f03-8a46-d0181104d9e3@kernel.dk>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Wed, 27 Jan 2021 11:12:34 -0500
Message-ID: <CA+CK2bBvKpWFtPz+OmjX5SJuAfL4hAaLbHmfRok4Ueo2toeTiA@mail.gmail.com>
Subject: Re: [PATCH v4 1/1] loop: scale loop device by introducing per device lock
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Tyler Hicks <tyhicks@linux.microsoft.com>,
        linux-block@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Sasha Levin <sashal@kernel.org>,
        James Morris <jmorris@namei.org>, lukas.bulwahn@gmail.com,
        hch@lst.de, Petr Vorel <pvorel@suse.cz>, ming.lei@redhat.com,
        mzxreary@0pointer.de, mcgrof@kernel.org, zhengbin13@huawei.com,
        maco@android.com, Colin King <colin.king@canonical.com>,
        evgreen@chromium.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 26, 2021 at 3:09 PM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 1/26/21 7:46 AM, Pavel Tatashin wrote:
> > Currently, loop device has only one global lock: loop_ctl_mutex.
> >
> > This becomes hot in scenarios where many loop devices are used.
> >
> > Scale it by introducing per-device lock: lo_mutex that protects
> > modifications of all fields in struct loop_device.
> >
> > Keep loop_ctl_mutex to protect global data: loop_index_idr, loop_lookup,
> > loop_add.
> >
> > The new lock ordering requirement is that loop_ctl_mutex must be taken
> > before lo_mutex.
>
> Applied, thanks.

Great, thank you!

Pasha

>
> --
> Jens Axboe
>
