Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A20283A1684
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 16:04:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237287AbhFIOGE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 10:06:04 -0400
Received: from mail-qk1-f180.google.com ([209.85.222.180]:34654 "EHLO
        mail-qk1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232292AbhFIOF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 10:05:58 -0400
Received: by mail-qk1-f180.google.com with SMTP id k11so22096383qkk.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 07:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=sVDNoaWoIPr7Gu4coKMJidA6UIIH0xz9k9qbnaUz7J8=;
        b=iJlKlERUuUveDc52H/UBA4htInK4K98sw+1Ayz5oJXTmrF3qACSyduBsb0JjEwQMbW
         ycrNqdQx56ME5dn/De9p3wL0Y5LDoCl0r1CzB1xal9bZjuZ2Lcycymm2p6t40CRI7EeY
         NAIMSO4IkFVKArQiizkiU7Siv/hUHBEfOzSg1hw/VZ+dQl2xGtKZ0vd77slE0ppBEqet
         VzHufD8GqHZumWetOrjl7FHXX1G5VB0iolsPxAna3f+3qdYYefzPLEY1frWC9Hi1WgJl
         q7gfYQu/rwO3Cb5o5e82+AHRWYP3iex+sMZ1A4Cxu8pZ8O0+G8liV2wJaXQ8tnjE7wTh
         SWFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=sVDNoaWoIPr7Gu4coKMJidA6UIIH0xz9k9qbnaUz7J8=;
        b=ErgNxTkpV0pBSyjLwYihDHOgW9GRCpAcklUfB8BXey33WMqTWifj9w36ZxrkxJTxh5
         mrgnonl23FdqzrKLxQtSE3+TJJveP+1wMwnI/9fv+NaTKvC3YfIwAouS56Kqx+WjdeFn
         ObSQGSmYhqAp9GXlll8lYpSS4pTsH8YOXeBxwbJTfFx8lH1f9E+Z6wloYvCi1DzgcovG
         jArx52Q/nC/bLOIN0fdz64Z+7b7xb9SN02y+R/bVQ83/Or96P3Qqvrjb+p8sOmb84a/W
         upLTNaL2/fiUO4ka1HaWET3dfso5L4dnVXBEdOvonHgX2Qiapiq4go2l3UE8/4zhMXoH
         RQQg==
X-Gm-Message-State: AOAM531R6OS9AAW+r0+l6Pv1Si87e0NZYxmL+fne2Bgk7JlyyE8o7PvW
        GqTR5XDYeGCr7WxYcWyIg+TlxkbmCtnrbOotO4vC/g==
X-Google-Smtp-Source: ABdhPJwlk2i2QGb5aCViuWJX+eoq6tbslIAd6c4NjfiqRzuaqx1Qhw3+Qm2upFCUr66Dek9NsQIgBkV2/OBf55wIx8I=
X-Received: by 2002:a37:a1d5:: with SMTP id k204mr16597525qke.300.1623247370731;
 Wed, 09 Jun 2021 07:02:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210609134714.13715-1-mcroce@linux.microsoft.com>
In-Reply-To: <20210609134714.13715-1-mcroce@linux.microsoft.com>
From:   Marcin Wojtas <mw@semihalf.com>
Date:   Wed, 9 Jun 2021 16:02:39 +0200
Message-ID: <CAPv3WKdhyb=o=v0oj+gVWWH3yfqQ1EqBcR-1y4R39x_-Or72-w@mail.gmail.com>
Subject: Re: [PATCH net-next 0/2] mvpp2: prefetch data early
To:     Matteo Croce <mcroce@linux.microsoft.com>
Cc:     netdev <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Sven Auhagen <sven.auhagen@voleatech.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matteo,


=C5=9Br., 9 cze 2021 o 15:47 Matteo Croce <mcroce@linux.microsoft.com> napi=
sa=C5=82(a):
>
> From: Matteo Croce <mcroce@microsoft.com>
>
> These two patches prefetch some data from RAM so to reduce stall
> and speedup the packet processing.
>
> Matteo Croce (2):
>   mvpp2: prefetch right address
>   mvpp2: prefetch page
>
>  drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
>

Thank you for the patches, they seem reasonable, however I'd like to
stress it on the CN913x setup @10G - I should have some slot for that
closer to EOW.

Best regards,
Marcin
