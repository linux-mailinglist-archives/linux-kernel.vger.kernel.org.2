Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0BB645CAB7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 18:14:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231576AbhKXRRk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 12:17:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:52685 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231841AbhKXRRi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 12:17:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637774067;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NpePfdKSV4Sq+uVphqHqV1Aq+JS4cEiF8UpbgtgpCEw=;
        b=Pjex5ip5yalYwWO/dhIkvn9tDdNlaLbYFWr01CcdToxCCSNomxeSO8i0tgyigxp54BQrld
        XaEFangq2ByVTbrS2mNDsf4yZD+jCAVQgHLV2LO9EpFn9++RahGDLrM/ObmHQ/DKA8OyUq
        1IQc/o/Eg3jPyS4Mi9G6jBvJMtjiR6A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-515-nc1zyWZdPG2NP3uFd6yeoA-1; Wed, 24 Nov 2021 12:14:26 -0500
X-MC-Unique: nc1zyWZdPG2NP3uFd6yeoA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 366C4A0CAD;
        Wed, 24 Nov 2021 17:14:25 +0000 (UTC)
Received: from localhost (unknown [10.40.194.62])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AD5A72B1A3;
        Wed, 24 Nov 2021 17:14:23 +0000 (UTC)
Date:   Wed, 24 Nov 2021 18:14:21 +0100
From:   Jiri Benc <jbenc@redhat.com>
To:     Fabian =?UTF-8?B?RnLDqWTDqXJpY2s=?= <fabf@skynet.be>
Cc:     davem@davemloft.net, kuba@kernel.org, sbrivio@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: vxlan: Possible regression in vxlan_rcv()
Message-ID: <20211124181421.154b4470@redhat.com>
In-Reply-To: <1ad77777.15fd.17d4dc9bd96.Webtop.157@skynet.be>
References: <1ad77777.15fd.17d4dc9bd96.Webtop.157@skynet.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Nov 2021 18:13:26 +0100 (CET), Fabian Fr=C3=A9d=C3=A9rick wrote:
>    Can someone tell me if the update is really ok or how I could check=20
> that code ?
> if VXLAN_F_REMCSUM_RX involves metadata checking I can ask to remove the=
=20
> patch.

I don't think it matters.

I doubt anyone is using remote checksum offloading (RCO). It was based
on a half thought-through idea. Local checksum offloading is superior,
it gives you the same performance for free, with full compatibility with
the base VXLAN standard. And even trying hard, I can't imagine anyone
could be using RCO with metadata dst.

I wouldn't object against removing RCO completely from VXLAN (and
moving the "generic" RCO pieces to net/ipv4/fou.c, which would become
its only user). It would simplify the code and I doubt anyone would
notice. I'm serious. Try googling for remcsumtx or remcsumrx and see
for yourself.

And, in case you still wonder, your patch seems fine to me. It's somehow
pointless, since it optimizes drops for an extension that nobody uses,
but it should not affect the code correctness. Probably. Whatever.

 Jiri

