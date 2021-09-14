Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 739D440B868
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 21:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233142AbhINTy7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 15:54:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:49596 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232552AbhINTy4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 15:54:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631649218;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dkmQm8W6bvbG86Wt4h4OqHW+/RRUFwTqElupwuosMGw=;
        b=QSUOfjXgROxrJ6QbPez4RTDfcz2IZfZEUz0MIme2TT8xt9X44VTyxWSKtYcaGAoAh8slmx
        nkOavWcHj9npvNDoR7gIpN5IpA9+5nncvjr2eBuirnOwFKpyPZuhReykc8jnAMsZJwVa6+
        rg+0thLsgol+PiH7+WnbLPmGqORTI8M=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-210-CxhpntGENTiypthuDNBDmQ-1; Tue, 14 Sep 2021 15:53:36 -0400
X-MC-Unique: CxhpntGENTiypthuDNBDmQ-1
Received: by mail-ej1-f72.google.com with SMTP id q15-20020a17090622cf00b005c42d287e6aso175892eja.18
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 12:53:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=dkmQm8W6bvbG86Wt4h4OqHW+/RRUFwTqElupwuosMGw=;
        b=jbDYKIkIhuxF4qSOifvKdbhpOdaLWysziY2U3ajz8SSt+PdFvyYckmO9sqAIvQNtVV
         si69x9Y5UvgP6ZgUY2bwhSlfpNk48Z1DDChCtIotjqMMmNHDMa2tx3ZKVtCcUY73JXzw
         L+lYIKXlJIC/ykNMEnq14Wu427IPJZwjj8YgqHr/MiJBPj07clJHwAmsnmf9hCKCy0zY
         gylFj2Dl2mZbpsIX3hheTEE0FMuJMt9qqgeYE+sW0GkagLvKikYJcgwUO5xpT7GclCRm
         ddA6ZgD6r8d8EmObHIRn5prYkCN/KB8HRe+Fy8D2ezmmxFr1vD8KxF75KyUQRkny+v9X
         BvHQ==
X-Gm-Message-State: AOAM530UcEdleosbX4O7g03ic6Qz+WZ7mRPswVOJHs8KLugBVJhTO1vd
        G0zLLAOd4rbgIYBmruIz25JqyLDUJYnB1H3woGHWLzH0QeuVG0dfiJVunlJx0bvdNMhrjm3kyw5
        9ZJ6BbMpkH79wizU0I+4ROApR
X-Received: by 2002:a17:906:31ca:: with SMTP id f10mr20060761ejf.73.1631649215719;
        Tue, 14 Sep 2021 12:53:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxM/UIv4EzPb+rSyq8EubqXE2rc9ZXZPKXWi2tuR39YigTtmGpcgA9b+50W9qR7lb08qZkbcg==
X-Received: by 2002:a17:906:31ca:: with SMTP id f10mr20060745ejf.73.1631649215382;
        Tue, 14 Sep 2021 12:53:35 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id gc19sm2566172ejb.35.2021.09.14.12.53.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 12:53:34 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 21A8118033D; Tue, 14 Sep 2021 21:53:34 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>,
        Kalle Valo <kvalo@codeaurora.org>,
        Felix Fietkau <nbd@nbd.name>,
        Sujith Manoharan <c_manoha@qca.qualcomm.com>,
        ath9k-devel@qca.qualcomm.com
Cc:     linux-wireless@vger.kernel.org,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        "John W . Linville" <linville@tuxdriver.com>,
        Felix Fietkau <nbd@openwrt.org>,
        Simon Wunderlich <sw@simonwunderlich.de>,
        Sven Eckelmann <sven@narfation.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] ath9k: interrupt fixes on queue reset
In-Reply-To: <20210914192515.9273-1-linus.luessing@c0d3.blue>
References: <20210914192515.9273-1-linus.luessing@c0d3.blue>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 14 Sep 2021 21:53:34 +0200
Message-ID: <87a6kf6iip.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus L=C3=BCssing <linus.luessing@c0d3.blue> writes:

> Hi,
>
> The following are two patches for ath9k to fix a potential interrupt
> storm (PATCH 2/3) and to fix potentially resetting the wifi chip while
> its interrupts were accidentally reenabled (PATCH 3/3).

Uhh, interesting - nice debugging work! What's the user-level symptom of
this? I.e., when this triggers does the device just appear to hang, or
does it cause reboots, or?

-Toke

