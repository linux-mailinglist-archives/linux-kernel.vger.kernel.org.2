Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAF3E373C55
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 15:25:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233564AbhEEN0m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 09:26:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60671 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233524AbhEEN0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 09:26:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620221144;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/bpFsXMdn5eaqmMBwGxqc2rlRW2ISNHWpOEm7J8RdOs=;
        b=PGeUyJkGaRWKAS7pRhItsg5qKX8ZxHnk7fbJGIv3k2/YAjzCjFsm8Ta7JCpHxStb1FSMD/
        p2RhQFtB9H4jiXDHADfJcJTXwFX7VSUZZWhIAsSzP8XFa1S0Pa+XraQDHKQDQFpSSm/yHX
        R6uaUHVWxG1YhoTKBg/IZPn0iasUIlw=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-351-IFdsOSmSOKui7__PxJGe0A-1; Wed, 05 May 2021 09:25:43 -0400
X-MC-Unique: IFdsOSmSOKui7__PxJGe0A-1
Received: by mail-pg1-f199.google.com with SMTP id b3-20020a6367030000b029020ed6abb792so1319022pgc.8
        for <linux-kernel@vger.kernel.org>; Wed, 05 May 2021 06:25:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/bpFsXMdn5eaqmMBwGxqc2rlRW2ISNHWpOEm7J8RdOs=;
        b=bEOKCqbTPZH7bUwTCS3vFEZb+mmkGdye7o4yckGOwM6pfFu9yS9YYYBxfFT/hYFde8
         euv9b2U0QSrch77QD00qkyCM/bi0B+Z4mSuJ5zWr37S8eCMQRjxtS4u9oamAzEu8IAZ1
         B1++vYmbgxkG9CARRjPlMU/i8pEulzCBZQb/l5UUPVEsP3w2sfHHsPicAPRrUBT//rem
         lh+pjuG3/nCHt3FXBfi81Ia3vmvUiydv8Mvqs00/OyH1oTD3+OMDJrTCDke64no+T1Zw
         U6bm7JTHFK+SDMuqRkRAde4qvtba6Wc0WrFhpRD1rSicZ27SCPquzxHpuNaF2Aeih8fo
         pzFg==
X-Gm-Message-State: AOAM530KNbrTYpmhiv9mgYhA/nw//rRfwpDpnlojJcC48BvsgC3dFW+f
        3fC/0W2BZG8ycfL6x1/Bt/LwrPX7+uimXVUEbOn9pSoam/gs23hBhZFsqT043d6rcoMxrGSxMHI
        7UAn7MAgfPHzyuoXKJg90CHqf/10RlNM6VYvBhXnV
X-Received: by 2002:a17:90a:bb0c:: with SMTP id u12mr34741902pjr.234.1620221141868;
        Wed, 05 May 2021 06:25:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJynLc8AHCVwjV7sToQg82XsVT77jGKQjpRW3gOLa+Ib3v9yJLpRKhvj1Cf0JJj43ujAwhVuVWLzaINnDBAk/eU=
X-Received: by 2002:a17:90a:bb0c:: with SMTP id u12mr34741885pjr.234.1620221141608;
 Wed, 05 May 2021 06:25:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210425173353.10231-1-mail@anirudhrb.com> <nycvar.YFH.7.76.2105051442120.28378@cbobk.fhfr.pm>
In-Reply-To: <nycvar.YFH.7.76.2105051442120.28378@cbobk.fhfr.pm>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Wed, 5 May 2021 15:25:30 +0200
Message-ID: <CAO-hwJJ4u5NZ-81Tq3PGu-F9r3iUSCiKp=JUsTfuVsyd-Sxsew@mail.gmail.com>
Subject: Re: [PATCH] usbhid: fix info leak in hid_submit_ctrl
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Anirudh Rayabharam <mail@anirudhrb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+7c2bb71996f95a82524c@syzkaller.appspotmail.com,
        Linux USB Mailing List <linux-usb@vger.kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 5, 2021 at 2:42 PM Jiri Kosina <jikos@kernel.org> wrote:
>
> On Sun, 25 Apr 2021, Anirudh Rayabharam wrote:
>
> > In hid_submit_ctrl(), the way of calculating the report length doesn't
> > take into account that report->size can be zero. When running the
> > syzkaller reproducer, a report of size 0 causes hid_submit_ctrl) to
> > calculate transfer_buffer_length as 16384. When this urb is passed to
> > the usb core layer, KMSAN reports an info leak of 16384 bytes.
> >
> > To fix this, first modify hid_report_len() to account for the zero
> > report size case by using DIV_ROUND_UP for the division. Then, call it
> > from hid_submit_ctrl().
> >
> > Reported-by: syzbot+7c2bb71996f95a82524c@syzkaller.appspotmail.com
> > Signed-off-by: Anirudh Rayabharam <mail@anirudhrb.com>
>
> Benjamin, could you please run this one through your regression testing
> machinery before we send it upstream?
>

I don't have a reproducer like syzbot has for the exact bug here, as I
am relying on one real USB device to check if usbhid is not too
broken.
However, the test suite should catch if there is an error implied by
the hid_report_len() change.

Anyway, I manually started the job and will report when it is done.

Cheers,
Benjamin

