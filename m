Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C94533E9E33
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 08:00:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233072AbhHLGA6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 02:00:58 -0400
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:32976
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234415AbhHLGAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 02:00:55 -0400
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com [209.85.161.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPS id BE91540C98
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 06:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1628748029;
        bh=uSyAF47q0itw6OVpblEuV2uLIqpCFYTPDCy9JiOpRIc=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=PxM3GUApzqo0SpbORipt7su56tmXvbzXrl3UFaPZp9Dn2TEwjvx7oTijLf5LzzrYn
         oAxib/HZYwxKKYh9U1/5H3KIqVizMyrG9P4wxihZvqJv0kQ/CmBIghFQZY6n6L8MPt
         eYTXVNNeqfC/kj7VhN/yTjSWjqWiwB3Ot1peqLc8amrFS5EwDXc+6XjFEBUHmhGFzq
         GgZ7A2Tr4qEPjNOJhKj9lFEcsi7LfqG4Hu3j4X9rclkpEu/BU48Lvjqj+2cbrU4jFI
         H852TpsMlaQfzwLUYRtz54ganixUYj6sD8gF7az0NieDQFBjdT8cg596SkQGRoGDwE
         gGua22uqTFHbQ==
Received: by mail-oo1-f70.google.com with SMTP id p68-20020a4a48470000b029028a81bd8ddcso1519675ooa.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 23:00:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uSyAF47q0itw6OVpblEuV2uLIqpCFYTPDCy9JiOpRIc=;
        b=VMu56zJ5armezizcFwWXFSr0BbvuqY33j+V/Lg784g/wQuWlZToYSn9ooCrMHDphFa
         q2Ijup5fxjbkevOkhQARHLQrQmLaxpANfGwuQ4XZiPLDhkjPTdP7zkaQvQ+XGX7ZTPIv
         nvkckkUDmKPmJaWa2CGwpe9jz7TMdUpucwd9zzAQ/ipyWYiI9rKTqnTIDwryFnktXQRb
         wEBh10aA3POnHFz77UVvwAXQhqyxaahcwgQ9Jq12hsdvl/OHFGaNYLMZaIYP8XW8sQYe
         P1v0tWuynMsrXel7HRsgslHX6Sdn7gUMJYSPPEiPb8ipxGEucsuFH0p2HcC6TLzx6rEP
         ZTjw==
X-Gm-Message-State: AOAM533WpIx2wWWwoc2AjKsknCEGJVwnWBDw6AjZ5jOpEwUDdzJWPQ48
        FW2Sw9gNldYh48oWv90g2rL/tcj4dXAUMc/cSqohzxxr8+vUaKKjMtRv7lYQdZdByMJ470Q0o3g
        bX64OZ8gRXZ0v/dCxY8bx2zbcEl7Wu1/ZzCkoEFNyriYY/LT05uTooSSmHQ==
X-Received: by 2002:aca:3488:: with SMTP id b130mr10247233oia.17.1628748028548;
        Wed, 11 Aug 2021 23:00:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxXhhG2SxUfgm+yVgS/aK64lQbCtRd+iUDMRGDW6JE10MyaZ3+ynuD3BkcBngesBnZoHpJmZrA1KMjs5pO57Fs=
X-Received: by 2002:aca:3488:: with SMTP id b130mr10247225oia.17.1628748028261;
 Wed, 11 Aug 2021 23:00:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210812042305.277642-1-koba.ko@canonical.com>
 <4374EE78-86B9-43BF-B387-8C51C15CB943@holtmann.org> <CAJB-X+W22r8sDhKj0LwtLCu9h2f1f=mX65nQtAN9nr=UujjDSw@mail.gmail.com>
In-Reply-To: <CAJB-X+W22r8sDhKj0LwtLCu9h2f1f=mX65nQtAN9nr=UujjDSw@mail.gmail.com>
From:   Koba Ko <koba.ko@canonical.com>
Date:   Thu, 12 Aug 2021 14:00:17 +0800
Message-ID: <CAJB-X+WEDyQUpZwbWnS7mHOZvNmsnCJ=PJnuTTUjdmJpKDCzfw@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: msft: add a bluetooth parameter, msft_enable
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        BlueZ <linux-bluetooth@vger.kernel.org>,
        "open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Archie Pusaka <apusaka@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 12, 2021 at 1:37 PM Koba Ko <koba.ko@canonical.com> wrote:
>
> On Thu, Aug 12, 2021 at 1:29 PM Marcel Holtmann <marcel@holtmann.org> wrote:
> >
> > Hi Koba,
> >
> > > With Intel AC9560, follow this scenario and can't turn on bt since.
> > > 1. turn off BT
> > > 2. then suspend&resume multiple times
> > > 3. turn on BT
> > >
> > > Get this error message after turn on bt.
> > > [ 877.194032] Bluetooth: hci0: urb 0000000061b9a002 failed to resubmit (113)
> > > [ 886.941327] Bluetooth: hci0: Failed to read MSFT supported features (-110)
> > >
> > > Remove msft from compilation would be helpful.
> > > Turn off msft would be also helpful.
> > >
> > > Because msft is enabled as default and can't turn off without
> > > compliation,
> > > Introduce a bluetooth parameter, msft_enable, to control.
> > >
> > > Signed-off-by: Koba Ko <koba.ko@canonical.com>
> > > ---
> > > include/net/bluetooth/hci_core.h |  1 +
> > > net/bluetooth/hci_core.c         | 16 ++++++++++++++++
> > > net/bluetooth/msft.c             | 30 +++++++++++++++++++++++++++++-
> > > 3 files changed, 46 insertions(+), 1 deletion(-)
> >
> > NAK.
> >
> > This is for the Intel guys to figure out. Otherwise I am going to disable MSFT extension for AC9560 completely. What is your hw_variant for that hardware?
> Would you please guide to dump hw_variant? thanks
Found it,
Bluetooth: hci0: Found Intel DDC parameters: intel/ibt-19-0-1.ddc


> >
> > Regards
> >
> > Marcel
> >
