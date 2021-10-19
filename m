Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB48B433CFB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 19:07:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234549AbhJSRJR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 13:09:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231956AbhJSRJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 13:09:16 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 089AAC06161C
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 10:07:03 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id p6-20020a9d7446000000b0054e6bb223f3so2499549otk.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 10:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tRUzeHjn1JScYsy8o3opbyIOuIsB/FtwNfAyTowowWw=;
        b=F832Pj/VWsWXq14tuowyPd+60g+tsKelOOjTQIFcBFAP/emkcy+rJkb3RhvyHAMBQx
         oTaTU7qmIcc+o6biGXLnm8ai3mBaEULu/q1CiaNG+LvPn11thXJ0j2jxR87BY6MN2kcF
         aXv8rFCEi9eHsCol+2ZxiCrh7kVm4do4XZHz0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tRUzeHjn1JScYsy8o3opbyIOuIsB/FtwNfAyTowowWw=;
        b=A8z9ZG1gu4XlRPOVuZJD4BFuflUonVJIyGnui8NmgwTwRIRYAK5zo+KljQ/dqy5dHX
         g6wtEa+957E3IPpAVyNGaDyOY8QUt8FdjCSYejbKEcTG18C4C9wG0cmvVn5ELwxrWLXy
         UXuBDpPvOnwQv+s/dfGCszrUnR5He3uXsK1n2MJk+wTsjC9PK80+XUgS+uMJygBHZDcL
         xBI6uvCW5w9QH+sPwpsVDcPJANvmFU1ocC5mkT0N32iNxMpE5tCq8R7hoTwIoGCz0l6O
         oBWmPP3DgFN41xD2GOg63OX+zoo1tipOlvG6/9s4K6e2oHEdPghTPN0JqrxR6/xARWm8
         wZHQ==
X-Gm-Message-State: AOAM531b34E5inbun2O86xtPMgywt7eIXDlKaP4rqQdLdGpeRSjLDcSm
        JDEq0U5lqeuK4dSNeRcaCLPqOVI2wjPWiA==
X-Google-Smtp-Source: ABdhPJwk0P4Fe+KxnjpZWkrUn5VqW5n6yN2Df5qzajc/pwapVAosirWuM06osAOdB8ZUNgJVraG9fA==
X-Received: by 2002:a9d:3e4a:: with SMTP id h10mr6211995otg.147.1634663222092;
        Tue, 19 Oct 2021 10:07:02 -0700 (PDT)
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com. [209.85.167.173])
        by smtp.gmail.com with ESMTPSA id e7sm3783624otq.4.2021.10.19.10.07.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Oct 2021 10:07:00 -0700 (PDT)
Received: by mail-oi1-f173.google.com with SMTP id o4so5931064oia.10
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 10:07:00 -0700 (PDT)
X-Received: by 2002:aca:603:: with SMTP id 3mr5184997oig.117.1634663219994;
 Tue, 19 Oct 2021 10:06:59 -0700 (PDT)
MIME-Version: 1.0
References: <20211019033101.27658-1-wanjiabing@vivo.com> <1ae64510-0519-4852-a2a0-5c32490a195c@gmail.com>
In-Reply-To: <1ae64510-0519-4852-a2a0-5c32490a195c@gmail.com>
From:   Brian Norris <briannorris@chromium.org>
Date:   Tue, 19 Oct 2021 10:06:45 -0700
X-Gmail-Original-Message-ID: <CA+ASDXNbLHDJ4Z8DNzNuxVJuqgKoKJynedXdnUP_1_Vvxgvc+A@mail.gmail.com>
Message-ID: <CA+ASDXNbLHDJ4Z8DNzNuxVJuqgKoKJynedXdnUP_1_Vvxgvc+A@mail.gmail.com>
Subject: Re: [PATCH] mwifiex: Fix divide error in mwifiex_usb_dnld_fw
To:     Eric Dumazet <eric.dumazet@gmail.com>
Cc:     Wan Jiabing <wanjiabing@vivo.com>,
        Amitkumar Karwar <amitkarwar@gmail.com>,
        Ganapathi Bhat <ganapathi017@gmail.com>,
        Sharvari Harisangam <sharvari.harisangam@nxp.com>,
        Xinming Hu <huxinming820@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        "<netdev@vger.kernel.org>" <netdev@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>, kael_w@yeah.net,
        syzbot+4e7b6c94d22f4bfca9a0@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 18, 2021 at 9:04 PM Eric Dumazet <eric.dumazet@gmail.com> wrote:
> On 10/18/21 8:31 PM, Wan Jiabing wrote:
> > --- a/drivers/net/wireless/marvell/mwifiex/usb.c
> > +++ b/drivers/net/wireless/marvell/mwifiex/usb.c
> > @@ -693,7 +693,7 @@ static int mwifiex_write_data_sync(struct mwifiex_adapter *adapter, u8 *pbuf,
> >       struct usb_card_rec *card = adapter->card;
> >       int actual_length, ret;
> >
> > -     if (!(*len % card->bulk_out_maxpktsize))
> > +     if (card->bulk_out_maxpktsize && !(*len % card->bulk_out_maxpktsize))
>
>
> Are you sure this fix is not working around the real bug ?
>
> In which cases bulk_out_maxpktsize would be zero ?
>
> If this is a valid case, this needs to be explained in the changelog.

I'm with Eric here. This was a bug reported by a fuzzer, which throws
invalid input at the driver. The right answer is likely that we should
reject such invalid input when we receive it -- i.e., we should fail
to probe() the device if it has invalid capabilities. In particular,
we should fail to probe if wMaxPacketSize==0.

I was thinking of sending such a patch myself, but I don't have any
USB mwifiex hardware to test, so I deferred. It's probably pretty low
risk anyway, though.

Brian
