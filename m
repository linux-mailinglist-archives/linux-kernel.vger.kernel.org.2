Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 700EB3E4882
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 17:17:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235369AbhHIPRT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 11:17:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231793AbhHIPRS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 11:17:18 -0400
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AD5BC0613D3
        for <linux-kernel@vger.kernel.org>; Mon,  9 Aug 2021 08:16:57 -0700 (PDT)
Received: by mail-vs1-xe34.google.com with SMTP id y1so10271475vsc.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 08:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GOSKNwf05g1MpWg0eVgUOJZSEVXpTZQYh4Rcb2+bib0=;
        b=BvrSE6y4lB467MecTrmXOiHn24QmAVxtQrtWhbgA+RHrNJDXF6imPTlNPgvrLCYtJ/
         YbdBjzYcg+FMMuoFOsOCeMTRakMkpW8cNBWGCZg6rCDJvGuxdyeI1d9EqJwHuo3fmyNi
         ZwFgb3VcTfSnmOW5I6YF0liyVb0COsk7Je0gIDxCLg4XlweTaQ7iMsxTc8P73fCHBX8N
         ZI823Q+KASuZbAoW+hhmpCyXkeWtcIqyoXf+HRAt7yR1jS2T/dc1wAcb3/BzTwntFOrr
         8eypaJSwwQhKt1ANqLkwO0j+r3r3F811Ppb0L1Q5Xe1gnmsiDO+bJKhaYU39NrDlxTzk
         Ps1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GOSKNwf05g1MpWg0eVgUOJZSEVXpTZQYh4Rcb2+bib0=;
        b=MMGRbZ/dDsjrenzEUYejR1TFmigQZKz6rnTu0bURZU6Q+v6i9GWRWscLfpVqCUZyKk
         DIVi7O8j2wA001twZ9pgQbvnG+KjiX1SJiYIG4rXQFgQzvWAOCLrKzpO+13x0aOoDNLy
         P1rQRQt4vfLYCOKsJo+nth1+xZlThPmQdDx8Sii6H47KqnY6Iv0U/CPDG/6N9a1hkStf
         2yAF/nxspdjdBKSX0Tg8huu9TG9UP/esfXHOM9sjLhZor4obcyCsrTS5NmEoOKHKF3LR
         AxodOQuzoz1DHKbbr72evk3KTLn0PKMKquZqiPxujJHFivWb8l8eU8BsYok7oQVWpbAf
         wUOQ==
X-Gm-Message-State: AOAM531LhOJ5BCyGumbCdfGdlv+qAG8MmPNluKbtH+Fr8EjtZdAFtk4t
        VlKXYoabVN3StAC/8yIsNbfeB58byFCP9V20UBDIZw==
X-Google-Smtp-Source: ABdhPJxAH+cC7JK8Q80vgqSzfviat/6jY6THJaEgQIvnMBTlRBvDA2nYCofWVX7zDCpLCVIMn2KrVaC7hU08g7copaA=
X-Received: by 2002:a67:e901:: with SMTP id c1mr980287vso.42.1628522216743;
 Mon, 09 Aug 2021 08:16:56 -0700 (PDT)
MIME-Version: 1.0
References: <CWXP265MB268049D9AB181062DA7F6DDBC4009@CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM>
 <CWXP265MB26807AC3C130772D789D0AABC41B9@CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM>
 <CAPDyKFq44ZuXXUDQV34NSW-ixB9GAZfDx+dx-Kb8O7=LQ1TSHQ@mail.gmail.com>
 <CWXP265MB26803EFAC659676EC0914F97C41B9@CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM>
 <DM6PR04MB6575B0049B98254E77BA447EFC1A9@DM6PR04MB6575.namprd04.prod.outlook.com>
 <CWXP265MB2680575489E508DC75D84857C41A9@CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM>
 <CAPDyKFrCtRTHZYRjUecvrqr=YyhrTw+HXtdLRHeOTxoK94iSRg@mail.gmail.com> <CWXP265MB26804E1F676F532D08A9BBFBC41A9@CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM>
In-Reply-To: <CWXP265MB26804E1F676F532D08A9BBFBC41A9@CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 9 Aug 2021 17:16:19 +0200
Message-ID: <CAPDyKFoU11viht4jbK5OVfW_o2e1shB4DWLT5_Jk0gMSBXwgNg@mail.gmail.com>
Subject: Re: [PATCHv2] mmc: block: Differentiate busy and PROG state
To:     =?UTF-8?Q?Christian_L=C3=B6hle?= <CLoehle@hyperstone.com>
Cc:     Avri Altman <Avri.Altman@wdc.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hch@infradead.org" <hch@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[...]

> >> +       case MMC_PROGRAM_CID:
> >> +       case MMC_PROGRAM_CSD:
> >
> >Let's discuss these, since they have R1 responses.
> >
> >Although, according to the eMMC spec, the card moves to rcv state, not
> >the prg state as you refer to in the commit message. Normally, we
> >don't need to poll for busy/tran completion of these commands.
>
> Why not? Sure they move to rcv first, but if data stops they move to PROG.

Yes, I guess they could.

> >
> >Have you observed through proper tests that this is actually needed?
>
> No, seems unlikely to hit this, as PROG will likely be shorter than getting a second command through.

Right.

In any case, I wouldn't mind if we start to poll for these, it sure
sounds a bit more robust.

> >
> >> +       case MMC_SET_WRITE_PROT:
> >> +       case MMC_CLR_WRITE_PROT:
> >> +       case MMC_ERASE:
> >
> >The three above have R1B, please drop them from here as they are
> >already supported correctly.
> >
> >> +       case MMC_LOCK_UNLOCK:
> >
> >Again, this has an R1 response and the card moves to rcv state.
> >Normally we shouldn't need to poll, but I have to admit that the eMMC
> >spec isn't really clear on what will happen when using the "forced
> >erase" argument. The spec mentions a 3 minute timeout....
>
> Again I don't know why you would not need to poll.
> The force erase has a good reason to remain in PROG for long, but whatever, a card may decide to just take 5 seconds in unlock PROG. (to prevent bruteforcing passwords lets say)(Not anything I have seen or expect to see)

As I said, the spec is not really clear here. So yes, polling sounds
more safe/robust.

>
> >
> >> +       case MMC_SET_TIME: /* Also covers SD_WRITE_EXTR_SINGLE */
> >> +       case MMC_GEN_CMD:
> >> +       case SD_WRITE_EXTR_MULTI:
> >
> >Are these actually being used? If not, please drop them from being
> >supported. I don't want to encourage crazy operations being issued
> >from userspace.
>
> GEN_CMD is extremly interesting for issuing vendor commands from user-space.
> Not sure if anyone uses it (yet), but if so it's unlikely to be seen in the wild.
> SD_WRITE_EXTR_MULTI is simply too new to really say.
> MMC_SET_TIME probably not used.
>

I am worried that it looks like we encourage doing "crazy" things from
userspace, when we add explicit checks for these commands.

In any case, if you strongly think we need these, please add polling
for them (or a subset of them).

>
> >
> >Overall, it looks like we need to add a check for MMC_LOCK_UNLOCK to
> >poll for busy, but that's it, I think.
>
> See above.
>
>
> >>         } while (!mmc_ready_for_data(status));
> >
> >I don't quite understand what we accomplish with polling for TRAN
> >state in one case and in the other case, both TRAN and READY_FOR_DATA.
> >Why can't we always poll for TRAN and READY_FOR_DATA? It should work
> >for all cases, no?
> >
>
> Well in theory you're then dropping the buffered writing feature of the SD spec if waiting for TRAN, too.
> I'm fine with that, especially since it is not desired to be used through ioctl anyway?

Well, I think you are misinterpreting how the buffered writing feature
is working in practice.

The mmc core doesn't write one block at the time and polls for
READY_FOR_DATA/TRAN in between each written block. Instead, it's the
responsibility of the mmc controller HW, to monitor DAT0 during a data
transmission, to understand whether it can continue to fill and write
more buffers.

Kind regards
Uffe
