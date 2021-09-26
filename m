Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 355A14186DE
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Sep 2021 09:15:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231159AbhIZHQi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Sep 2021 03:16:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbhIZHQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Sep 2021 03:16:36 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24D86C061570
        for <linux-kernel@vger.kernel.org>; Sun, 26 Sep 2021 00:15:01 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id m70so16062325ybm.5
        for <linux-kernel@vger.kernel.org>; Sun, 26 Sep 2021 00:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=s1g20qcSNH830RtMZtRpnOZCy3q88nhA1Ng5Qpk6pp0=;
        b=W+6aH9e2hLiOSIlYxiFF98dEGX47ClamZIUZWbaIbq+P0Mv4q+z7yrqWwRC4P8wW7I
         mS5hmVG15a7+JjD7BRYoiIIcwNw7VG+Ry7IBaq9M+IyL+vJd8Yjmwnz/xopGepbNLkDZ
         YhPQcrL9NML7kl3pDfxm+7yE4RoSIhIX1EAfbXIJwgA/G9MwSEoUOb06tQADOh0ChaOb
         WGXpnKF18pJbfeb5wtUlgOnJF1Dc3VOjYeoc8HK8HfNjSR+rUZ8GstafSmsI7Fr+j8ZM
         oUc6YZb8RvaZ5x/AVbxzXd2kl/m4J7aS9xoEQeRzJ8j+Kgib9wcn6DWQ4O+z7y8zAuLN
         1JFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=s1g20qcSNH830RtMZtRpnOZCy3q88nhA1Ng5Qpk6pp0=;
        b=uifq5LDMk5N2cSC+6F8XwlH/FuB+HqJAimqKZQAiB+CUImN99JqHIZOR170sUFWMmx
         aKlQzIaSBsHizEX2au4qn4S4rkE3bJBFkZURHDmHz3Tn7yjb3TRepW3ouow8ElJI8XJH
         CpQKHUqoP29xrWxzexsnGxXZLCmMCLETwg+eu7M5zD14L8xm60rneOUXs7jl4Kd/ybcj
         dIVV2PM8wmtLFSON02A72EMOMnhjt2vu30Nw3FwsOEi98I7YtLiZ6vkW+sxOfWUz2tZ+
         l8Tnmh3y+wjDQ16YG3F+aetTcos07SrWkIoquNQWnCe21IKZv3eegsATvHukg0YbQbG4
         5bww==
X-Gm-Message-State: AOAM530BdrRuUQa2pY+zlKw7ZckVLBhaCb/5Prd/afaOLTUi6NByGaoP
        BdZ3fZLCliJmV2tlmaSIo9Wn/xb3fGooJ0+2oCHWKw==
X-Google-Smtp-Source: ABdhPJwlEBD94uYnxGfImHkndQZbTRG/EoxrtKkSK8AW/Bx1zgjC/nJ6EV5FXl9Q3nAnM9isXWsKDOh+nwofzZYCLkE=
X-Received: by 2002:a25:d8a:: with SMTP id 132mr15204847ybn.90.1632640499900;
 Sun, 26 Sep 2021 00:14:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210913152801.v3.1.I17f57656757b83a1c0fb4b78525d8aca581725db@changeid>
 <D38B22EC-EFC8-44A0-84BE-F3710380C022@holtmann.org>
In-Reply-To: <D38B22EC-EFC8-44A0-84BE-F3710380C022@holtmann.org>
From:   Joseph Hwang <josephsih@google.com>
Date:   Sun, 26 Sep 2021 15:14:48 +0800
Message-ID: <CAHFy41-iVHf9wqBo20gHa7gR2EiXjLdb0faDXQjkekz3YbjMiQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] Bluetooth: btandroid: Support Android Bluetooth
 Quality Report
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
        CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        kernel test robot <lkp@intel.com>,
        Miao-chen Chou <mcchou@chromium.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcel:

  I am very sorry that I missed your review comment! I have used
net/bluetooth/aosp.c to replace drivers/bluetooth/btandroid.c, and
enable the aosp capability by hci_set_aosp_capable() in the drivers.

  The new patch subject is

      [v4,1/4] Bluetooth: aosp: Support AOSP Bluetooth Quality Report

  (https://patchwork.kernel.org/project/bluetooth/patch/20210926150657.v4.1=
.Iaa4a0269e51d8e8d8784a6ac8e05899b49a1377d@changeid/)

  Please take a look.

Thanks and regards,
Joseph


On Mon, Sep 13, 2021 at 10:32 PM Marcel Holtmann <marcel@holtmann.org> wrot=
e:
>
> Hi Joseph,
>
> > Add the btandroid.c file to support Android BQR commands.
> >
> > This module may be referenced by btusb, btrtl, and hci_qca when a
> > Bluetooth controller supports the Android Bluetooth Quality Report.
> >
> > Reported-by: kernel test robot <lkp@intel.com>
> >
> > Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
> > Signed-off-by: Joseph Hwang <josephsih@chromium.org>
> > ---
> >
> > Changes in v3:
> > - Fix the auto build test ERROR
> >  "undefined symbol: btandroid_set_quality_report" that occurred
> >  with some kernel configs.
> > - Note that the mgmt-tester "Read Exp Feature - Success" failed.
> >  But on my test device, the same test passed. Please kindly let me
> >  know what may be going wrong. These patches do not actually
> >  modify read/set experimental features.
> > - As to CheckPatch failed. No need to modify the MAINTAINERS file.
> >  Thanks.
> >
> > Changes in v2:
> > - Fix the titles of patches 2/3 and 3/3 and reduce their lengths.
> >
> > drivers/bluetooth/Kconfig     |   5 ++
> > drivers/bluetooth/Makefile    |   1 +
> > drivers/bluetooth/btandroid.c | 106 ++++++++++++++++++++++++++++++++++
> > drivers/bluetooth/btandroid.h |  10 ++++
> > 4 files changed, 122 insertions(+)
> > create mode 100644 drivers/bluetooth/btandroid.c
> > create mode 100644 drivers/bluetooth/btandroid.h
>
> I am confused now. Did you read my review comments? I do _not_ want it th=
is way; so please read my previous response and don=E2=80=99t send the exac=
t same patch again.
>
> Regards
>
> Marcel
>


--=20

Joseph Shyh-In Hwang
Email: josephsih@google.com
