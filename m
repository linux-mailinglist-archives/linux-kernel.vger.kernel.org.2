Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99A1A3D3880
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 12:19:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231759AbhGWJiO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 05:38:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30580 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230046AbhGWJiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 05:38:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627035526;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wAtWjoPMs7b2mfoHjDz+Kbot8us4IZ8w5i6dg1usQ+I=;
        b=bRJ+rGYhu10F5VCA6QcsxBUElfmLVTKn46kyz5D3OU5/DrCbWhAErknma4SM+bBSmzVr2J
        FaW/6R/v04r3Tv2qe1+BnHYUqOCrAiWCfTi8E5TN60V61bQrcYqhGuDe5vuCsVcp90gTfO
        MN8LgHXkQ+pp6KkVK19/zz00AW5dGsQ=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-593-mkmRiEr-MDODR5R7V5TSBg-1; Fri, 23 Jul 2021 06:18:44 -0400
X-MC-Unique: mkmRiEr-MDODR5R7V5TSBg-1
Received: by mail-il1-f199.google.com with SMTP id x9-20020a92b0090000b0290214927ba4d8so770248ilh.6
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 03:18:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wAtWjoPMs7b2mfoHjDz+Kbot8us4IZ8w5i6dg1usQ+I=;
        b=YlhCWUxqrb93xY/NOUxc8u7AM8dX7kbGb24UpYFRCwOxAWPoWnR6SHdgp0RpH+g8M/
         xwY/KQA2WfKkn1KoksT1Oam2Rpmrs0bmGbOsYg9NE3iNX5y8twUjQT6jTZyQR1C0EkBP
         3CewTGQILq7S3Fv8S0DucZb47lZH+H1yF8TSbH2li5iClx3Ego0bb5p95yLjO5Tmx1FG
         5V2FxCJSGxBOADY98l9v79ByQXySc06iO0Ha34ucpMxkQtyfB62mv1DyFNiUKjUM5Xz+
         QtvLVcIlFd+vx1dFVa6Tj4wCkDbOA0TvFFcW08DfgyhOkn1GM7nCZaRTlLh+seAphv37
         JLmw==
X-Gm-Message-State: AOAM533WKNN0ibdfN8goxG8uvFZv6ICOn/q28hWMIXbJOshfujarCjF+
        ewdbqUGjbtJ7wD2u9hKRPAMIEwsYwhWwO5V2mbsH+2YPgccNSb7WM1N/pDhONRqru4VGJSA1RwM
        d+2p4dL0lWda8RssjmFAnDpViwN9tVh3ym1YZ9V6j
X-Received: by 2002:a92:8747:: with SMTP id d7mr3114541ilm.173.1627035524403;
        Fri, 23 Jul 2021 03:18:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxnLBvtdojuHWZ+mNPTTTHfo9sbPOXAPakPJPZrby6KidLaTImlo80uTrFXXtrK0loo+mBtHtFm2LaSGMOgU7E=
X-Received: by 2002:a92:8747:: with SMTP id d7mr3114532ilm.173.1627035524289;
 Fri, 23 Jul 2021 03:18:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210723035721.531372-1-sashal@kernel.org> <20210723035721.531372-9-sashal@kernel.org>
 <CACT4oucVa5Lw538M2TEc1ZNU4mUZms+9fiTxw-p5-7J7xcM+kQ@mail.gmail.com>
In-Reply-To: <CACT4oucVa5Lw538M2TEc1ZNU4mUZms+9fiTxw-p5-7J7xcM+kQ@mail.gmail.com>
From:   =?UTF-8?B?w43DsWlnbyBIdWd1ZXQ=?= <ihuguet@redhat.com>
Date:   Fri, 23 Jul 2021 12:18:33 +0200
Message-ID: <CACT4oudPRf=RjqxncVrWGpMNfYTUhHOEbydtTq1O-R70P47guA@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 5.13 09/19] sfc: ensure correct number of XDP queues
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 23, 2021 at 12:12 PM =C3=8D=C3=B1igo Huguet <ihuguet@redhat.com=
> wrote:
> This one can be applied too, but not really a must-have.

Sorry, I have to correct myself. Both must be applied:
58e3bb77bf1b sfc: ensure correct number of XDP queues
f43a24f446da sfc: fix lack of XDP TX queues - error XDP TX failed (-22)

Otherwise, if there are some left-over TXQs because of round up,
xdp_tx_queue_count coud be set to a wrong value, higher than it should
be.

Regards
--=20
=C3=8D=C3=B1igo Huguet

