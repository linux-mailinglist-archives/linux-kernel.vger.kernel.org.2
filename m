Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF9444188F3
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Sep 2021 15:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231611AbhIZNCJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Sep 2021 09:02:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231528AbhIZNCI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Sep 2021 09:02:08 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8725C061570;
        Sun, 26 Sep 2021 06:00:31 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id c1so13159844pfp.10;
        Sun, 26 Sep 2021 06:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JSFOayOTE4Uyc1hI32Lkwa+XwwdJucxTM76xvaMDZA4=;
        b=JNkA9kuYGc5wEyRaiHYqPTiAIG6jyk5XPUK3MKP1K/sDskwtbOKmKzs06bjJsKJxHc
         161P/abz6GuhalZHibwpWUCkMEP/QHd3PO7cl+F3S4e2YIXt4FFrU35Oq3vZkSgzupXD
         HsyuMjculPbeeAEtkju8dTaMZ6eGIWXdT9DSBSCh1Lvg/mSkyc6GSneTnkyWi72D8rTe
         +jv8hoBuUTECdH6JcV/EQwA1BRKowo+bji/pz+2Kd1ssUR2KQyozVcE6mYgByIoBcdLa
         b/rPhL6uMnTzYzQCeJgRQkGCEuQhXzdHvjy2SiGARKb8eMM80vzRqjBR4Ubgdv9l1jL5
         SpFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JSFOayOTE4Uyc1hI32Lkwa+XwwdJucxTM76xvaMDZA4=;
        b=kGPBfhR9ZaXQp01rEXtNeu562UEakIc3np5nuYMjg3hUYfcLGEtYBBfxk6zRvhI1FC
         AivG+QgVoPjtUTS1gPDRKdq6SzYFeqwLd65tiJkTzDC3zuskgFmRKMJY59pItNedpeFv
         sgWyc+CCKh1IgTRsOJiw5RwFhtnpmP5hIdCXcT1sJYcvKxGCDFh/PbU8wxRQRfj7Y+mc
         HWtugvkCoQFamvHwMPdOcEjIiRmB/nKke6DJGydq0M9/U7MAYkvbGgUnQjF90vPbPZ5z
         byonanYcLbHI4gRt3m4QGcl8+TNrxuSZR9z/qU824z0Tc/iLU2j7tBNQHhNi4tbX0wZ1
         ljwA==
X-Gm-Message-State: AOAM530K1rRG6IFPJHLtkGoU0Uwqu94y+3Ixjn4fLjRp2BM4IkxJkvLD
        sPpb4/trMoCsURhAYgrchQnQFfaTWoILTRvEIqE=
X-Google-Smtp-Source: ABdhPJwL5Ay/Ji5j2V/XIM9VJK1N3hblgjJzqq5FFyfyJgS5AtC9pn8zDBTWDONA76Z5+4TS8TZunN0wfOL6fTYsyXk=
X-Received: by 2002:aa7:9e9a:0:b0:43e:d9b:cd93 with SMTP id
 p26-20020aa79e9a000000b0043e0d9bcd93mr18844437pfq.50.1632661231439; Sun, 26
 Sep 2021 06:00:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210801203122.3515-1-himadrispandya@gmail.com>
 <20210801203122.3515-7-himadrispandya@gmail.com> <YUnS/Chgat7vNHO7@hovoldconsulting.com>
In-Reply-To: <YUnS/Chgat7vNHO7@hovoldconsulting.com>
From:   Himadri Pandya <himadrispandya@gmail.com>
Date:   Sun, 26 Sep 2021 15:00:20 +0200
Message-ID: <CAOY-YVk9_8zEXpW8XwTuEPVMxCUwpXemWmNzt2by90bnTv66YA@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] USB: serial: kl5kusb105: use usb_control_msg_recv()
 and usb_control_msg_send()
To:     Johan Hovold <johan@kernel.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        USB list <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 21, 2021 at 2:41 PM Johan Hovold <johan@kernel.org> wrote:
>
> On Mon, Aug 02, 2021 at 02:01:22AM +0530, Himadri Pandya wrote:
> > The wrappers usb_control_msg_send/recv eliminate the need of allocating
> > dma buffers for usb message. They also impose proper error checks on the
> > return value of usb_control_msg() to handle short read/write. Hence use
> > the wrappers and remove dma allocations.
> >
> > Signed-off-by: Himadri Pandya <himadrispandya@gmail.com>
> > ---
> > Changes in v2:
> >  - Fix the caller of klsi_105_chg_port_settings()
> >  - Drop unnecessary use of the wrappers
>
> Now applied with an amended commit message:
>
>     USB: serial: kl5kusb105: use usb_control_msg_recv() and usb_control_msg_send()
>
>     The wrappers usb_control_msg_send/recv eliminate the need of
>     manually allocating DMA buffers for USB messages. They also treat
>     short reads as an error. Hence use the wrappers and remove DMA
>     allocations.
>
>     Note that short reads are now logged as -EREMOTEIO instead of the amount
>     of data read.
>
> I've applied all but the first two patches in the series now. Would you
> mind respinning those two?
>
> Thanks,
> Johan

Thanks for reviewing and applying these patches. And yes, I'm sending
the revised version for the first two.

Regards,
Himadri
