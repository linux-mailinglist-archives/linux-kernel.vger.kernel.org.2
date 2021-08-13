Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5C3D3EBD80
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 22:40:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234515AbhHMUkz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 16:40:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233905AbhHMUkx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 16:40:53 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DE6BC061756;
        Fri, 13 Aug 2021 13:40:26 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id n6so17363892ljp.9;
        Fri, 13 Aug 2021 13:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EdjJ5WkYh23R+5q3/cVLvQ2hscpaA4GqqB6R6gmdArg=;
        b=r08iXLqVSjelGTsw/vjC/K6iKbAKENdSr2Xj3kRn5jjWki4T2/0qvLOPAoWWTHAjut
         kw73Ne2EITcwTG96lxq6Dw2T4EXDGMbt3p5I4PyiXpd73D2NPxK8evdnxP7hhtTmFlmJ
         +cCvYeHx/4awvFil5MjqQJ+KMaKYsq0cvpydGZZdDhXtAVmQtZTBs1eQVuzwGz0Xqp+/
         vIf6e4poZX7eG2zFY24tD3hi6ySm9FkANXqFs2HTBR5ZNjiWaNpY5D3vBhZ13E20GRY/
         sSrGUKdyGV9RCh6d/lLp4GJ6f7QouVUT7wMfeZjvZLxPWo/WDOGhY4MAOg20hnMF9I7A
         0Ctw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EdjJ5WkYh23R+5q3/cVLvQ2hscpaA4GqqB6R6gmdArg=;
        b=BDxSaiH5/Ei4uh03Vuylur1QkQvZZDVTMT47rQR4KxT+Z0fHiqjf3OtDQBxxuJt6vf
         8O6puiMsT0sIDk7KMgwZLCk5StigoxhJULB3GB9MXYDiAi2dFRielu+wUJMhRAS9qhnc
         i41LazwEiYTY3NmQJs0kP+3mZgyoRh6PRBjpe3j2tWirMFJUZaRYEf3o7s+UmsD66fKC
         O8dNCyEmRo56iuqx3pz5sEAKB+FxJE2QVF7RU3tqd0Y04r+0MrsW2Oq75bzP4MQ8r6sB
         lomO3oEARqj+jPXLkRUiLZ0IHL4Z7GqCkcc7RBVAif7BnYYt8uMW81FekzdfltRGH+lr
         rsPQ==
X-Gm-Message-State: AOAM532tXx97vOUGyESAXfyPxQDA+zQb6HNel23kOi4idzdSAM+N7/8I
        EfPs7bWW6M3U3p15fqr2omc=
X-Google-Smtp-Source: ABdhPJxEZ6LaVms2MRDEFQgjeuGwuYHCpWDMSbjpnTqRJXbrvOsszilKZuZbv/dfH9D3DwPIC0Kmyw==
X-Received: by 2002:a2e:2f0f:: with SMTP id v15mr3013919ljv.203.1628887224745;
        Fri, 13 Aug 2021 13:40:24 -0700 (PDT)
Received: from reki (broadband-95-84-198-152.ip.moscow.rt.ru. [95.84.198.152])
        by smtp.gmail.com with ESMTPSA id z4sm241695lfi.98.2021.08.13.13.40.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Aug 2021 13:40:24 -0700 (PDT)
Date:   Fri, 13 Aug 2021 23:40:22 +0300
From:   Maxim Devaev <mdevaev@gmail.com>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     balbi@kernel.org, gregkh@linuxfoundation.org,
        ruslan.bilovol@gmail.com, mika.westerberg@linux.intel.com,
        maze@google.com, jj251510319013@gmail.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: f_hid: optional SETUP/SET_REPORT mode
Message-ID: <20210813234022.5d5644ae@reki>
In-Reply-To: <20210813232212.5cba6d33@reki>
References: <20210813114551.72898-1-mdevaev@gmail.com>
        <20210813145823.GA38198@rowland.harvard.edu>
        <20210813232212.5cba6d33@reki>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=D0=92 Fri, 13 Aug 2021 23:22:12 +0300
Maxim Devaev <mdevaev@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5=D1=82:

> Alan Stern <stern@rowland.harvard.edu> wrote:
> > In other words, a device does not need to have an interrupt-OUT=20
> > endpoint, but if it does have one then the host must use it.
>=20
> You're right. Although the actual behavior of the hosts is not different
> from what I wrote - they really just ignore out endpoint.
> I will eventually fix this in the patch description.

It seems that I have confused everything even more, sorry. I will explain.
There are three possible host behaviors:

(1) The host works with the OUT endpoint as it describes the standard
    and transmits reports through it.

(2) The host works with IN endpoint, but refuses to transmit reports
    via OUT endpoint at all. In the case of the keyboard, it will work,
    but it will not receive the status of the LEDs.

(3) The host sees OUT endpoint and either refuses to use such a device at a=
ll,
    or goes crazy in various ways.

In both cases (2) and (3), using SETUP/SET_REPORT solves the problem.
Therefore, I offer this as an option to solve compatibility problems.
Yes, in fact, this is not our problem, but it is impossible to fix the driv=
ers
of all these proprietary devices. Moreover, I have never met a keyboard
with OUT endpoint, absolutely all of them use SETUP/SET_REPORT.
