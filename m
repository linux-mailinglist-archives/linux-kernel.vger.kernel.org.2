Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2220644C27C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 14:49:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232200AbhKJNve (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 08:51:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232290AbhKJNvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 08:51:31 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E710C061205;
        Wed, 10 Nov 2021 05:48:43 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id r8so2834979iog.7;
        Wed, 10 Nov 2021 05:48:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DsNkDrlFTjDpTJrNyj+v36Bk4REnOZZnZdBfSjhgQQ0=;
        b=RibtsAqFjmrlf2bUcmbHqY5oBKJKHB0XXhlv9sexKgT8OiZOd79kq+WX/opliew3DI
         7jNe9Jm2vL79FJuZ25t/iNihiM7NeysDByXUP8Xt41STlohF6deQw7Ww8RvFLJ8Uzh+W
         uBmQsxkfeLIzfClEil1qe//ov0kexgEinwCZkqSgG0SDpXFDBOTKYUbuEi6SxlauTDYk
         q8qugyI8trA7wAmqSx9XBuH5yCLPMtOIAitKx6EtHfWGjMzmuCONqzsbHj8/8H3vGchj
         vj+L+Fg4/VvkVb4ShGUbsG9HnhDhq4LeeOP0F698eLBzAr8viYk2RjBTibTU4+gy69A+
         4Www==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DsNkDrlFTjDpTJrNyj+v36Bk4REnOZZnZdBfSjhgQQ0=;
        b=BHU6HPqpxCn1oRGrylv9f7wxWizPE1Q8P2MisARanAEHpf23FTIymX5t2sNzPIw8zi
         HmCHwCtg2PECr6LTo9NNuVof3VypW92IGiz+Oewd+ulsEnBIJ+ljXKIUu3OFVWH5uR1E
         KqWl+D9OspywOQ30sCx6uiAp7eYEV34BEYCVvOoaLXm63Tsye1z1ZVIa0XmkPyKXDBih
         Eobe2n+iM/D08mxkkVbyT+cFNZu78Icw1JMza86tlqhRQzVmbiuFp89Z+K86DA9namFc
         JeQahgR5lcDR72U05oMFD1gZjQpXbT4ufRlc3hip6nXeG+xTu6oab66nu7ddPEZqVFA7
         EhVA==
X-Gm-Message-State: AOAM530IjFUneBkfNref7ir93p8bHz6ze8+pEf0wj50RAZ8aM7A5inzZ
        Nwr+2VZfC5ULka7J2rLpJxA/OySQIFYkONfrHPU=
X-Google-Smtp-Source: ABdhPJylS9N2ODO2pFmCDAWbtFf8rrF8PHCdYmGzUdE4J/3mFxbIYZP3OX2I8yPCaubhQ1X4G3ecMQGLBsOK5d2cCfI=
X-Received: by 2002:a5d:9d92:: with SMTP id ay18mr10739778iob.130.1636552122761;
 Wed, 10 Nov 2021 05:48:42 -0800 (PST)
MIME-Version: 1.0
References: <20210923081951.261281-1-yang.yang29@zte.com.cn>
 <CAJy-AmnDr-i6E7JPAGpt6EgVDTSxgFtygzriKJeOmuLd061P+Q@mail.gmail.com> <618bc88b.1c69fb81.9fc2c.1d65@mx.google.com>
In-Reply-To: <618bc88b.1c69fb81.9fc2c.1d65@mx.google.com>
From:   Alex Shi <seakeel@gmail.com>
Date:   Wed, 10 Nov 2021 21:48:06 +0800
Message-ID: <CAJy-Am=mHUhU9XNyiaTkmLJo27qTkLrgAm7PzX6LeU=BBgrQ+Q@mail.gmail.com>
Subject: Re: [PATCH v3] docs/zh_CN: Add zh_CN/accounting/delay-accounting.rst
To:     CGEL <cgel.zte@gmail.com>
Cc:     Alex Shi <alexs@kernel.org>, Yanteng Si <siyanteng@loongson.cn>,
        Jonathan Corbet <corbet@lwn.net>, yang.yang29@zte.com.cn,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 10, 2021 at 9:26 PM CGEL <cgel.zte@gmail.com> wrote:
>
> On Fri, Sep 24, 2021 at 11:41:52AM +0800, Alex Shi wrote:
> > On Thu, Sep 23, 2021 at 4:23 PM <cgel.zte@gmail.com> wrote:
> > >
> > > From: Yang Yang <yang.yang29@zte.com.cn>
> > >
> > > Add translation zh_CN/accounting/delay-accounting.rst and links it
> > > to zh_CN/accounting/index.rst while clean its todo entry.
> > >
> > > Signed-off-by: Yang Yang <yang.yang29@zte.com.cn>
> >
> > Hi Yangyang,
> > You  could pick up the 'reviewed-by' conveniently when you update to
> > new version.
> >
> > Thanks
> Hi Alex,
> I had sent patch v4, see:
> https://lore.kernel.org/all/20210924055135.262327-1-yang.yang29@zte.com.cn/
> Is there any other problem of this patch?

Uh, it looks fine to me.  may it don't need my ack again, since it's
with my reviewed-by. :)

Just ping Jonathan is fine. guss the patch just covered in his emails flood. :)

Thanks
Alex
