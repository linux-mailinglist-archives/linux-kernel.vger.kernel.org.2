Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4670D3E0ED9
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 09:04:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236162AbhHEHEx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 03:04:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230180AbhHEHEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 03:04:50 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A5DBC061765
        for <linux-kernel@vger.kernel.org>; Thu,  5 Aug 2021 00:04:36 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id i13so4088413ilm.11
        for <linux-kernel@vger.kernel.org>; Thu, 05 Aug 2021 00:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8OHXExxtDwOoQLWpw5qKeYWpDd/wE3WEDJewZmrIO40=;
        b=SNyh52+RN1RrKXgLlxVfz7kcXrdsHqrbacEOmQ5w4MvubZE2x+fb1EKKWBGq04t0m6
         0ocTTD2u2Jkd2k8VOfjftapFYwQgkFXbbd0JKMVvlOWRb3LwYt/QBeLJGECinQO/bk8A
         MugGWPBAClM2LNa9gfr/BKWulJ3YXR1ZFaBV0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8OHXExxtDwOoQLWpw5qKeYWpDd/wE3WEDJewZmrIO40=;
        b=PGUwIu4phwKp4D8D96K1p16KFXawrsIlKCzU4xRTzrEWHU0zn2A967CuK1F8Z6ge/m
         OW2tLYNM+H1X+YUSqxAm9NWjca+GL8NyHb8b6bWjgnD0v8YGEY4M4bOQgqKvGw8nbmYu
         IrhizO7Uv9AE1SOtaganh2D9YmoMGTfZ1/pabeqruTkm+YcegqLBnFszBroR/g0qkAub
         eNJqgyv1VL/psRe6p+QQ7hsd2aF/4v8V0sAAYIoVEARVjFb9R46HhEaIKe862Iwn5Wqj
         Jg32bf1G4vzUPfCKyNA5TOYZ8tLmkWuf8g+MQpJVLoCohm5vsy631klQYGFiisXKL5L5
         3ghQ==
X-Gm-Message-State: AOAM5303Ib+s41+nPQijXRyOeo02YHNiSj/mAiDoJIYtiGx4MWcEaeZp
        ZBIPsT7iMuEsgY7Lf60iBLFdJsvxpbCF5alJnZCzkQ==
X-Google-Smtp-Source: ABdhPJzvmCC1+omzWmIHtr7zHneB7lOU5G6A3f5e07pXOtHfTQdwbgU4n5OtcGK6QRP5yXIINmvYUYUtbw8CjFDh+qk=
X-Received: by 2002:a92:c8c1:: with SMTP id c1mr577209ilq.106.1628147075759;
 Thu, 05 Aug 2021 00:04:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210514071452.25220-1-kai.heng.feng@canonical.com>
 <20210802030538.2023-1-hdanton@sina.com> <CAAd53p4NO3KJkn2Zp=hxQOtR8vynkJpcPmNtwv2R6z=zei056Q@mail.gmail.com>
 <CAJMQK-gT4e_xTc8WY+n52DJPUagPGce-0FJEtqZSwPm3U=LViQ@mail.gmail.com> <20210805070114.2803-1-hdanton@sina.com>
In-Reply-To: <20210805070114.2803-1-hdanton@sina.com>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Thu, 5 Aug 2021 15:04:09 +0800
Message-ID: <CAJMQK-ifNH7hoU-U3EzzrvqBOSG1fq9t=xvq8ry24zJXKPfNVA@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: Shutdown controller after workqueues are
 flushed or cancelled
To:     Hillf Danton <hdanton@sina.com>
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Mattijs Korpershoek <mkorpershoek@baylibre.com>,
        Bluez <linux-bluetooth@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 5, 2021 at 3:01 PM Hillf Danton <hdanton@sina.com> wrote:
>
> On Thu, 5 Aug 2021 14:12:10 +0800 Hsin-Yi Wang wrote:
> >
> >The original patch 60789afc02f592b8d91217b60930e7a76271ae07
> >("Bluetooth: Shutdown controller after workqueues are flushed or
> >cancelled") is causing the tx fail when downloading fw on mediatek
> >mt8183 device using QCA bluetooth:
>
> Want to know if reverting 60789afc02f59 is a cure.

Reverting 60789afc02f592b8d91217b60930e7a76271ae07 can also fixed the issue.
>
> >
> >[  225.205061] Bluetooth: qca_download_firmware() hci0: QCA
> >Downloading qca/rampatch_00440302.bin
> >[  227.252653] Bluetooth: hci_cmd_timeout() hci0: command 0xfc00 tx timeout
> >...
> >follows by a lot of:
> >[  223.604971] Bluetooth: qca_recv() hci0: Frame reassembly failed (-84)
> >[  223.605027] Bluetooth: qca_recv() hci0: Frame reassembly failed (-84)
> >
> >After applying the fixup to allow tx, the issue is solved.
>
> Feel free to specify the fixup and its link to 60789afc02f59.

The fixup is pasted by Kai-Heng here:
https://lkml.org/lkml/2021/8/3/103
