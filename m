Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EE6642BCB2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 12:21:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239321AbhJMKXu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 06:23:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239259AbhJMKXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 06:23:43 -0400
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com [IPv6:2607:f8b0:4864:20::936])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62A42C061570
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 03:21:40 -0700 (PDT)
Received: by mail-ua1-x936.google.com with SMTP id f4so3424165uad.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 03:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=ktkG2nSXLSEtFrXudmN3sJOX3CYFf8sxFasfdF0cd88=;
        b=CBB7DmWuFVgKNjQToEGIGFUwWYcs8N4xzJ2iHsNa0vSt6u/wu9OWUycCNmzov0Z5Mv
         FvQIpwa4RBazLm12xhj2vInHcqytht5Prm6UAiL11KakY++0AdKiEVB5/JIMn6ld5fv5
         r/YrEBRDvw0lmh2NJNNdXgBC/Imt+bL5Y+M1oZmeSTQaa1rvqcQfdUkS2sH4EEesesJm
         tR3YhDD7y/6qWGNSaG0kwXdvJNrHCC0Wu9VlFI9PKcd3aqF6xB/UpXY84mhE3Q4/mJyb
         RczAe5xHi5S//qE1fZXLMt0SsqVmD4K/qawiiC3F3ytG4a6RByU/dM8+b330CyZIbtUr
         pA5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=ktkG2nSXLSEtFrXudmN3sJOX3CYFf8sxFasfdF0cd88=;
        b=dVyyT6fhBRVpsvLNG0TGMxb88lXvD9FX4WXHmnCA1Ei34cC7Vb0FiO1RrOaSbj9w5S
         TPm66vLeRjJBih8QiSTAXOaifDSJXzv8+PRIW6r5KM1XSq1zWmND4kLeXHay7KxxQWk8
         VyVyD4yu2pxI3HaU4GFugK5deDHBUkz87JFdHSW5dBe76jK/sm57UHhKv7K82++XRUhz
         OTGRWnxhkLaySwg4Bp8jw9B3Ln9gHPICIlm4comN/H4IjaLrdLCUpHcq4xAVKhk1wSYl
         DNUUqaXd9vQwXYz0cJJ3cJRElqa1/fAMuA79LNnTuVvFniCLzE2b8YglJLM+hn0BavFf
         +NOg==
X-Gm-Message-State: AOAM532xbfzUkm46vavkwPpoKCtcVfsy8R/DurfGIni+B+/xnFrYdfY1
        cC2TR+l4SP2MN8GzbmwKhKD95UWRiYZcoJS0WjNWyuQZhg==
X-Google-Smtp-Source: ABdhPJy+6QpUUyTEW43vRVgKEipJ0Pmjleika3xETYL6KqFHXJ2QI+QRjsZtzPRs3bJGBVMdoZ+qh3LXFbG41gjMksM=
X-Received: by 2002:a05:6102:c:: with SMTP id j12mr9822360vsp.49.1634120499410;
 Wed, 13 Oct 2021 03:21:39 -0700 (PDT)
MIME-Version: 1.0
From:   Chris Dams <chris.dams.nl@gmail.com>
Date:   Wed, 13 Oct 2021 12:21:28 +0200
Message-ID: <CAARK4ZH0bm_g-Z69Co00ZF-4LBiVstSzjaOxhzzb_=kKr8fj2A@mail.gmail.com>
Subject: Cannot get com20020 arcnet driver to work on Siemens IPC727E PC
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear All,

I am having trouble getting the sohard arcnet card ARC-PCIe working on
specifically
Siemens PCs of type IPC7272E. It works when I use a Dell Optiplex PC
in the sense
that I can get packet communication going in this case. A colleague
confirmed that it
is possible to get arcnet packet communication with older Siemens PCs
but not with the
IPC727E model. It has also been confirmed that it is possible to have arcnet
communication using windows on the Siemens IPC7272E.

This card uses the com20020_pci driver. When things don't work ip addr shows

10: arc0-0: <NO-CARRIER,BROADCAST,UP> mtu 508 qdisc fq_codel state DOWN
group default qlen 100 link/arcnet f0 brd 00 permaddr ff

When they do work the NO-CARRIER state is not present, instead it
shows 'BROADCAST,UP,LOWER_UP'.

I have been debugging this and it appears that the card thinks it is
being reconnected
all the time. There is an interrupt a bit more frequently than once a
second and the
status code that is read out in the function arcnet_interrupt (file
drivers/net/arcnet/arcnet.c) contains the bit 0x4 indicating that it
is reconfigured
(status & lp->intmask & RECONflag is true). A more elaborate logging
with log lines
that I added myself can be found below this email. Logging has been added to
the functions arcnet_interrupt, com20020_setmask, com20020_command,
and com20020_status. The logging shows what happens when I try to
bring up the card
using the commands 'ip link set arc0-0 addr <nodenr>'  and 'ip link
set dev arc0-0 up'
I am using the same card and coax cable in the case that works as in the case
that does not. Also, it has been tried with a different coax cable.

Does anyone have an idea how this could be solved and/or debugged further?

Kind Regards,
Chris Dams


 Siemens PC:
[  344.277960] arcnet:com20020: CD: read status 8065
[  344.277962] arcnet:com20020: CD: giving command 16
[  344.277970] arcnet:com20020: CD: setting mask to 0
[  344.277975] arcnet:com20020: CD: setting mask to 84
[  345.117128] arcnet: CD: handling interrupt
[  345.117139] arcnet:com20020: CD: read status 8065
[  345.117141] arcnet:com20020: CD: giving command 16
[  345.117149] arcnet:com20020: CD: setting mask to 0
[  345.117153] arcnet:com20020: CD: setting mask to 84
[  345.246614] arcnet:com20020: CD: setting mask to 0
[  345.246619] arcnet:com20020: CD: giving command 1
[  345.246622] arcnet:com20020: CD: giving command 2
[  413.618118] arcnet:com20020: CD: read status b2e1
[  413.618120] arcnet:com20020: CD: setting mask to 0
[  413.618126] arcnet:com20020: CD: setting mask to 84
[  413.618153] arcnet: CD: handling interrupt
[  413.618158] arcnet:com20020: CD: read status 2e1
[  413.618160] arcnet:com20020: CD: giving command 84
[  413.618168] arcnet:com20020: CD: read status 261
[  413.618170] arcnet:com20020: CD: setting mask to 0
[  413.618174] arcnet:com20020: CD: setting mask to 84
[  413.642237] arcnet: CD: handling interrupt
[  413.642246] arcnet:com20020: CD: read status 8265
[  413.642248] arcnet:com20020: CD: giving command 16
[  413.642257] arcnet:com20020: CD: setting mask to 0
[  413.642261] arcnet:com20020: CD: setting mask to 84
(last 5 lines repeated forever after this)

 Dell PC:
[ 3541.586119] arcnet: CD: handling interrupt
[ 3541.586132] arcnet:com20020: CD: read status 7261
[ 3541.586134] arcnet:com20020: CD: setting mask to 0
[ 3541.586140] arcnet:com20020: CD: setting mask to 84
[ 3541.948623] arcnet: CD: handling interrupt
[ 3541.948638] arcnet:com20020: CD: read status 7261
[ 3541.948641] arcnet:com20020: CD: setting mask to 0
[ 3541.948647] arcnet:com20020: CD: setting mask to 84
[ 3542.486415] arcnet:com20020: CD: setting mask to 0
[ 3542.486426] arcnet:com20020: CD: giving command 1
[ 3542.486430] arcnet:com20020: CD: giving command 2
[ 3542.508520] arcnet: CD: handling interrupt
[ 3542.508531] arcnet:com20020: CD: read status 72e1
[ 3542.508532] arcnet:com20020: CD: setting mask to 0
[ 3593.877876] arcnet: CD: handling interrupt
[ 3593.877890] arcnet:com20020: CD: read status 32e1
[ 3593.877894] arcnet:com20020: CD: setting mask to 0
[ 3594.389061] arcnet: CD: handling interrupt
[ 3594.389073] arcnet:com20020: CD: read status 32e1
[ 3594.389075] arcnet:com20020: CD: setting mask to 0
[ 3595.281555] arcnet: CD: handling interrupt
[ 3595.281570] arcnet:com20020: CD: read status 32e5
[ 3595.281573] arcnet:com20020: CD: setting mask to 0
[ 3595.806175] arcnet: CD: handling interrupt
[ 3595.806188] arcnet:com20020: CD: read status 32e5
[ 3595.806191] arcnet:com20020: CD: setting mask to 0
[ 3596.803438] arcnet: CD: handling interrupt
[ 3596.803453] arcnet:com20020: CD: read status 32e5
[ 3596.803456] arcnet:com20020: CD: setting mask to 0
[ 3597.375000] arcnet: CD: handling interrupt
[ 3597.375013] arcnet:com20020: CD: read status 32e5
[ 3597.375015] arcnet:com20020: CD: setting mask to 0
[ 3597.414872] arcnet: CD: handling interrupt
[ 3597.414884] arcnet:com20020: CD: read status 32e5
[ 3597.414886] arcnet:com20020: CD: setting mask to 0
[ 3597.803499] arcnet: CD: handling interrupt
[ 3597.803512] arcnet:com20020: CD: read status 32e5
[ 3597.803515] arcnet:com20020: CD: setting mask to 0
[ 3598.034631] arcnet: CD: handling interrupt
[ 3598.034643] arcnet:com20020: CD: read status 32e5
[ 3598.034645] arcnet:com20020: CD: setting mask to 0
[ 3606.347933] arcnet:com20020: CD: read status 32e5
[ 3606.347936] arcnet:com20020: CD: setting mask to 0
[ 3607.548967] arcnet:com20020: CD: read status 32e1
[ 3607.548973] arcnet:com20020: CD: setting mask to 0
[ 3607.548979] arcnet:com20020: CD: setting mask to 84
[ 3607.549012] arcnet: CD: handling interrupt
[ 3607.549023] arcnet:com20020: CD: read status 32e1
[ 3607.549026] arcnet:com20020: CD: giving command 84
[ 3607.549037] arcnet:com20020: CD: read status 261
[ 3607.549038] arcnet:com20020: CD: setting mask to 0
[ 3607.549043] arcnet:com20020: CD: setting mask to 84
[ 3607.835590] arcnet: CD: handling interrupt
[ 3607.835603] arcnet:com20020: CD: read status 7261
[ 3607.835606] arcnet:com20020: CD: setting mask to 0
[ 3607.835612] arcnet:com20020: CD: setting mask to 84
[ 3608.081450] arcnet: CD: handling interrupt
[ 3608.081464] arcnet:com20020: CD: read status 7261
[ 3608.081467] arcnet:com20020: CD: setting mask to 0
[ 3608.081473] arcnet:com20020: CD: setting mask to 84
[ 3608.392381] arcnet: CD: handling interrupt
[ 3608.392395] arcnet:com20020: CD: read status 7261
[ 3608.392398] arcnet:com20020: CD: setting mask to 0
[ 3608.392404] arcnet:com20020: CD: setting mask to 84
(last 4 lines repeated forever after this)
