Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0205A3163D5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 11:30:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbhBJK3q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 05:29:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230448AbhBJKRh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 05:17:37 -0500
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F082C061786
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 02:16:57 -0800 (PST)
Received: by mail-vs1-xe35.google.com with SMTP id k9so810521vsr.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 02:16:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=msA+gdwMsQfk3la/W82WyEHallZtYkbf2eSn/foTDTI=;
        b=akng1dCjJvDQ5GGmSb+6B927DpKcLId5PdzJFHYgIDGFIR9XwgZV+3UBewkVw4NDvb
         xTYDxIKMV3iWgHg5EC3LfhF5nz8v/KB96fSNGbVrisg29CJV/y1tg74eJEyRhxlllxAw
         0Hzi9JBIX8o77zUJBqP92z8VvWgm3orvUCG90=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=msA+gdwMsQfk3la/W82WyEHallZtYkbf2eSn/foTDTI=;
        b=gg3M4cOqU82YlWkzdtpshca6E04Z7uLR7ggSHuKad0HVP667IBMTWyPSMxNYDLztNu
         3nqkWWexoRyvlf/BQfF/AKbLnWA9Qd3E1DHslO+6kOcZHBAwpWbJ2+LrJhpawGaX6j1K
         5fPGEygPkWezWQbNhGcxu4Uy2OWhmzdRhQZL95pfSGPVk/31UepCW1xQOtn1ZW4G5LWh
         9Q890H9lqiiNBr001OS4x+Y7TVgapY0+CP6GQl2DpMbrGXO36Lfpf3tUbPmBnvCiIu7d
         HzTlWeNBObl3UK/+997f0uxnWvIwbZQmiGUD8Sx50aGDsT3guvKBU5eMA0MYTZb/9KBG
         VgMw==
X-Gm-Message-State: AOAM531os/MCo1bGO2Uizcxg+a96mmN1uEUGwONhMG7cf7DYexXqai54
        MML+NeeqePTOOFuixWVxLfcVYrqAAp1PETQ2cpJZkkitmqQ=
X-Google-Smtp-Source: ABdhPJxuaIy3etB4q1Qu6NqLANiiMmEiudWH7ucSR0b9uKc7spXfA1hdE3wwn4oSgiRVjcjg3a1OTQ/bCeVkZ5XEHiY=
X-Received: by 2002:a67:c992:: with SMTP id y18mr1103336vsk.7.1612952216822;
 Wed, 10 Feb 2021 02:16:56 -0800 (PST)
MIME-Version: 1.0
References: <20210124232007.21639-1-richard@nod.at> <CAJfpegvN2KdMj_7T-OF1PAs8xZiU3f4233AvigaXwwRAsgQEjw@mail.gmail.com>
 <1507208626.379155.1612906761549.JavaMail.zimbra@nod.at>
In-Reply-To: <1507208626.379155.1612906761549.JavaMail.zimbra@nod.at>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 10 Feb 2021 11:16:45 +0100
Message-ID: <CAJfpegugbvppOKhJ8KjSVGgZOGVuj6NSiy4n18mbD7Ui3wme6g@mail.gmail.com>
Subject: Re: [PATCH 0/8] MUSE: Userspace backed MTD v3
To:     Richard Weinberger <richard@nod.at>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Ron Minnich <rminnich@google.com>, sven <sven@narfation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        fuse-devel <fuse-devel@lists.sourceforge.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 9, 2021 at 10:39 PM Richard Weinberger <richard@nod.at> wrote:
>
> Miklos,
>
> ----- Urspr=C3=BCngliche Mail -----
> > If you look at fuse_do_ioctl() it does variable length input and
> > output at the same time.  I guess you need something similar to that.
>
> I'm not sure whether I understand correctly.
>
> In MUSE one use case would be attaching two distinct (variable length) bu=
ffers to a
> single FUSE request, in both directions.
> If I read fuse_do_ioctl() correctly, it attaches always a single buffer p=
er request
> but does multiple requests.

Right.

> In MUSE we cold go the same path and issue up to two requests.
> One for in-band and optionally a second one for the out-of-band data.
> Hmmm?

Does in-band and OOB data need to be handled together?  If so, then
two requests is not a good option.

Thanks,
Miklos
