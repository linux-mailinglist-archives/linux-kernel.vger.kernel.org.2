Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B6B544210D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 20:50:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbhKATvd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 15:51:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbhKATv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 15:51:26 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 039C0C061764
        for <linux-kernel@vger.kernel.org>; Mon,  1 Nov 2021 12:48:50 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id s24so2214045lji.12
        for <linux-kernel@vger.kernel.org>; Mon, 01 Nov 2021 12:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lucidpixels.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GmJzh+r2vs3BTmTAVFgVsO0MVkelX+6GuKQ6EGdb1cI=;
        b=TmPIKX9NNvJqj4SrgROA48oo6SOhtftv+RKGLalsKpAW7sr2Ezg+bXv9qbgTGOCIeR
         AUn8g0XkLohOk5s50h2N8/r/uOPMX1GYc/xeHgyoofGE/ws3YAnoQh9tN5Z2q7oIgJrE
         mYazBvAKPxGpa5XSeCuxSUaKCpE5Mg++eNlrM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GmJzh+r2vs3BTmTAVFgVsO0MVkelX+6GuKQ6EGdb1cI=;
        b=Q5BElglimjcJNLMCkiQMv8Pq8XLv6GhOdZZGIaehEI2wpecLlx8gJ7Out5XGM2pI3j
         SiE2pdJIjoYPvOIX+D8kI2SFRZLt2BZh0rgAXNd4RqIfLZBYNGAXeenI86F0WYFK3gXQ
         8koWOgQqBEZ2venuTJLbe9MzZ6AbXgQ0sP/gxA3JnXxyNStG+FuDQaFWAtQW0MeyCJGf
         KdzD2mk156YQ0z5BEohYYNAKitteHrLx9yEL0nmcTSdrTuFEkGHIM/aDAhtj+fkDt1I/
         wEPRMh+jMb2DdqfZdxCI1G2Tu0zU2W3HDUMmyFpt0dWilyV5olWEOl9mJqd3Ura01+N5
         TtzQ==
X-Gm-Message-State: AOAM531MXJdRN51qUmw2okAwuVQYkHLuQoZpATw9gl3keysPgCKA+5Ke
        2snJlvsog67zp1G1TG7lL90p4HPjTsNMJeiVDoCcv4r2F9BrMQ==
X-Google-Smtp-Source: ABdhPJxhkRazbfbeNlKo5DuvdYvbx+ATxGSawkEvsHLQQJAW+LEIk2xb8uaoSRaBNomx8Mz4jODU1ZJdeWO2iJlR0VU=
X-Received: by 2002:a2e:9c0b:: with SMTP id s11mr34090946lji.259.1635796129061;
 Mon, 01 Nov 2021 12:48:49 -0700 (PDT)
MIME-Version: 1.0
References: <006a01d7cead$b9262d70$2b728850$@lucidpixels.com>
 <a4a88807-8f52-ef9a-c58e-0ff454da5ade@acm.org> <CAO9zADxiobgwDE5dtvo98EL0djdgQyrGJA_w4Oxb+pZ9pvOEjQ@mail.gmail.com>
In-Reply-To: <CAO9zADxiobgwDE5dtvo98EL0djdgQyrGJA_w4Oxb+pZ9pvOEjQ@mail.gmail.com>
From:   Justin Piszcz <jpiszcz@lucidpixels.com>
Date:   Mon, 1 Nov 2021 15:48:37 -0400
Message-ID: <CAO9zADycForyq9cmh=epw9r-Wzz=xt32vL3mePuBAPehCgUTjw@mail.gmail.com>
Subject: Re: kernel 5.15 does not boot with 3ware card (never had this issue
 <= 5.14) - scsi 0:0:0:0: WARNING: (0x06:0x002C) : Command (0x12) timed out,
 resetting card
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-scsi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 1, 2021 at 6:36 AM Justin Piszcz <jpiszcz@lucidpixels.com> wrote:
>
> On Sun, Oct 31, 2021 at 7:52 PM Bart Van Assche <bvanassche@acm.org> wrote:
> >
> > On 10/31/21 16:19, Justin Piszcz wrote:
> > > Diff between 5.14 and 5.15 .config files-- could it be something to do with
> > > CONFIG_IOMMU_DEFAULT_DMA_LAZY=y?
> >
> > That's hard to say. Is CONFIG_MAGIC_SYSRQ enabled? If not, please enable
> > it and hit Alt-Printscreen-t (dump task list; see also
> > Documentation/admin-guide/sysrq.rst) and share the contents of the
> > kernel log. If that would not be convenient, please try to bisect this
> > issue.
>
> [ .. ]
>
> It appears at this point in the boot process the keyboard (USB and
> PS2) are not yet available and/or do not respond in this scenario (I
> do have CONFIG_MAGIC_SYSRQ enabled+have used it in the past).  I'll
> build the prior 5.15-rc(1-7) to check where it stopped working and
> reply back to the list when I have that info.

[..]

I have tried all of the -rc's and they all hang at boot, keyboard
input (USB/PS2) is not working at this stage in the boot process.
Are there any thoughts on how to debug this further?

[9.305954] 3u-sas: scsi0: Found an LSI 3ware 9750-2414e Controller at
Oxfb760000, IRQ: 45.
[9.6179701 3u-sas: scsi0: Firmware FH9X 5.12.00.016, BIOS BE9X
5.11.00.007, Phys: 28.
[30.498007] scsi 0:0:0:0: WARNING: (0x06:0x002C) : Command (0x12)
timed out, resetting card
[71.4419581 scsi 0:0:0:0: WARNING: (0x06: 0x002C): Command (0x0) timed
out, resetting card.

# lilo
Added 5.14.8-1
Added 5.15.0-1 - hangs with the error above
Added 5.15.0-rc1-1 - hangs with the error above
Added 5.15.0-rc2-1 - hangs with the error above
Added 5.15.0-rc3-1 - hangs with the error above
Added 5.15.0-rc4-1 - hangs with the error above
Added 5.15.0-rc5-1 - hangs with the error above
Added 5.15.0-rc6-1 - hangs with the error above
Added 5.15.0-rc7-1 *  - hangs with the error above

Regards,

Justin.
