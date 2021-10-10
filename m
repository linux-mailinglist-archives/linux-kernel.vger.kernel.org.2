Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C7014280DB
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Oct 2021 13:37:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231869AbhJJLjR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Oct 2021 07:39:17 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:58540
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231828AbhJJLjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Oct 2021 07:39:11 -0400
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 990D43FFF1
        for <linux-kernel@vger.kernel.org>; Sun, 10 Oct 2021 11:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1633865831;
        bh=3aL2g6ASYJjmJXLGE2td/GKebrEEfp5cYtOVSOPNOjE=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=RatrrUBM0raRQ9o99r5tsntg+AojFT1r+xlDCozpBhnbeWwHh6dk7sgiyeQB9p+RE
         F59A+Xo4Ee9pOJmWnm3ldFzK4rfdF6v2caoSjSGBIiUirB7bre4wavbvdpLL2lNYLr
         Chh5/Rxlm69N9QlHACBT6HdzaD2mn9DIEBII/Wcg4Tuct28Wzj+iIh3kFFaM4dy1LW
         v+Uuuc1RrPCbNJJM5cKsH0oze/RWEq/unwQZPWYu3wHr0tbbOVqBALC/EpGVPJHxiS
         vqIO4SjkN5UKXgXwUofVPt584F+DJ3b/qZwkaNqGq4A6hWHucYrrTomxfXXT6o7PpD
         HSVtr0I3G9IhA==
Received: by mail-ed1-f72.google.com with SMTP id g28-20020a50d0dc000000b003dae69dfe3aso13235333edf.7
        for <linux-kernel@vger.kernel.org>; Sun, 10 Oct 2021 04:37:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3aL2g6ASYJjmJXLGE2td/GKebrEEfp5cYtOVSOPNOjE=;
        b=XwyNTPZdh2WQNgESGiwxehwVxOCe8/XPW3dSdsgZQoryZPa66dZbgpUbCqP0mK2R/7
         RwbXPDRe4NdoRaBQZjUty4a526jjV/IAR18y/WcnVZewKGYCzEkGDKxGt9UVQF060A+x
         fs0JbV4Itt89C6UgoXp9ph0Jrm15yCeZDnoVwG67/ujDfHmMp9CkB6SiRaC0PtBUe+tc
         CEEbWnyCwBBDrXf8Xyxv5ztoKDYQMJO8WOoMPCOS+KbVdu0AcG6jd3mHxaZlHZ5A4GMS
         OisYWksGfMg0WsLDolvVY+20Hi97FjLUxFrPTq0gInCSjTo7uSrhd6pFYXrm+DcfTCL7
         BYxA==
X-Gm-Message-State: AOAM532d91W6NPnwqnxcq+jvS0y4uP9IM2QFUjeMBxYD6V+9Qdp9ZoY7
        Hv3MF14t3Heq61SxQWAo+S9XobyutvftJKGZngzQKZiRRVGVOX3jyZdV9KEsntQLk7KylBu9oPc
        NVwTVjC+jvtLeMERj5LCmNRvS+zknhZ1BN1Zsa/WYjlPwhdjxz/TIv2Dwvg==
X-Received: by 2002:a17:906:919:: with SMTP id i25mr17554113ejd.171.1633865830570;
        Sun, 10 Oct 2021 04:37:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzmGfXRax8w6ByvvioynebBatQTyi+KnMs4IdARMtMQVkKFfh4370Xu091DRaFkuwupjNT9l7lw+PWQutb8gQQ=
X-Received: by 2002:a17:906:919:: with SMTP id i25mr17554102ejd.171.1633865830425;
 Sun, 10 Oct 2021 04:37:10 -0700 (PDT)
MIME-Version: 1.0
References: <20211007133021.32704-1-krzysztof.kozlowski@canonical.com>
 <20211008.111646.1874039740182175606.davem@davemloft.net> <CA+Eumj5k9K9DUsPifDchNixj0QG5WrTJX+dzADmAgYSFe49+4g@mail.gmail.com>
In-Reply-To: <CA+Eumj5k9K9DUsPifDchNixj0QG5WrTJX+dzADmAgYSFe49+4g@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Date:   Sun, 10 Oct 2021 13:36:59 +0200
Message-ID: <CA+Eumj65krM_LhEgbBe2hxAZhYZLmuo3zMoVcq6zp9xKa+n_Jg@mail.gmail.com>
Subject: Re: [RESEND PATCH v2 0/7] nfc: minor printk cleanup
To:     David Miller <davem@davemloft.net>
Cc:     k.opasiak@samsung.com, mgreer@animalcreek.com, kuba@kernel.org,
        linux-nfc@lists.01.org, netdev@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Oct 2021 at 12:18, Krzysztof Kozlowski
<krzysztof.kozlowski@canonical.com> wrote:
>
> On Fri, 8 Oct 2021 at 12:17, David Miller <davem@davemloft.net> wrote:
> >
> > From: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> > Date: Thu,  7 Oct 2021 15:30:14 +0200
> >
> > > Hi,
> > >
> > > This is a rebase and resend of v2. No other changes.
> > >
> > > Changes since v1:
> > > 1. Remove unused variable in pn533 (reported by kbuild).
> >
> > Please CC: netdev for nfc patches otherwise they will not get tracked
> > and applied.
>
> netdev@vger.kernel.org is here. Which address I missed?

The patchset reached patchwork:
https://patchwork.kernel.org/project/netdevbpf/list/?series=559153&state=*
although for some reason it is marked as "changes requested". Are
there any other changes needed except Joe's comment for one patch?

Best regards,
Krzysztof
