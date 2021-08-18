Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A6DC3F05A9
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 16:06:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238474AbhHROHO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 10:07:14 -0400
Received: from relay-us1.mymailcheap.com ([51.81.35.219]:54306 "EHLO
        relay-us1.mymailcheap.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235121AbhHROHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 10:07:13 -0400
Received: from relay5.mymailcheap.com (relay5.mymailcheap.com [159.100.241.64])
        by relay-us1.mymailcheap.com (Postfix) with ESMTPS id B299A20F4F;
        Wed, 18 Aug 2021 14:06:37 +0000 (UTC)
Received: from relay3.mymailcheap.com (relay3.mymailcheap.com [217.182.66.161])
        by relay5.mymailcheap.com (Postfix) with ESMTPS id 6D0A1200FD;
        Wed, 18 Aug 2021 14:06:34 +0000 (UTC)
Received: from filter2.mymailcheap.com (filter2.mymailcheap.com [91.134.140.82])
        by relay3.mymailcheap.com (Postfix) with ESMTPS id 6AE413F15F;
        Wed, 18 Aug 2021 16:06:31 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by filter2.mymailcheap.com (Postfix) with ESMTP id 4C6F42A915;
        Wed, 18 Aug 2021 16:06:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mymailcheap.com;
        s=default; t=1629295591;
        bh=uq0Qy9clsCfmvFSP9mENOFYxEY3dDC0jH48pNRC/CqM=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=tWxmAURRG4KjTPTg+Dmp+1Twu3e5Tbt9Nlrw9A1qbO2H5xfA2vR8OE9BZP0Ma3hXX
         nkgClaiUuDpWp/AqhKNonq4BHYbfvE8lyiyuYejDJY9JnfwMjiczldD9cLtx/V+fqG
         cB9ZMysRoklX7QLgtqzS92adEdXjgUuuKLG3EmpE=
X-Virus-Scanned: Debian amavisd-new at filter2.mymailcheap.com
Received: from filter2.mymailcheap.com ([127.0.0.1])
        by localhost (filter2.mymailcheap.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 8eT0KW-N8YDI; Wed, 18 Aug 2021 16:06:27 +0200 (CEST)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by filter2.mymailcheap.com (Postfix) with ESMTPS;
        Wed, 18 Aug 2021 16:06:13 +0200 (CEST)
Received: from [213.133.102.83] (ml.mymailcheap.com [213.133.102.83])
        by mail20.mymailcheap.com (Postfix) with ESMTP id 0CCDA412DF;
        Wed, 18 Aug 2021 14:06:13 +0000 (UTC)
Authentication-Results: mail20.mymailcheap.com;
        dkim=pass (1024-bit key; unprotected) header.d=aosc.io header.i=@aosc.io header.b="qP0/Druw";
        dkim-atps=neutral
AI-Spam-Status: Not processed
Received: from [127.0.0.1] (unknown [59.41.161.108])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail20.mymailcheap.com (Postfix) with ESMTPSA id BA15A40097;
        Wed, 18 Aug 2021 14:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aosc.io; s=default;
        t=1629295463; bh=uq0Qy9clsCfmvFSP9mENOFYxEY3dDC0jH48pNRC/CqM=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=qP0/DruwHg+J7YseMCMbbn04gRfcBLe+esmnrnFu/5WETuzFjZrQg22BhvzmT0tTR
         yo5GoS/z76wJnUWnUcZnDd1fe6Ma/Jf6f/dTnxWoKpukAJdIY19qQKJ0WwaxzwtUir
         L5sZ5prpKtI8z/c2Jc4soFOSZXiz1qoID6ABl5Lc=
Date:   Wed, 18 Aug 2021 22:02:24 +0800
From:   Icenowy Zheng <icenowy@aosc.io>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
CC:     Guenter Roeck <linux@roeck-us.net>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: typec: tcpm: always rediscover when swapping DR
User-Agent: K-9 Mail for Android
In-Reply-To: <YR0Rlj+jk9dnoG6N@kroah.com>
References: <20210813043131.833006-1-icenowy@aosc.io> <YRuDG78N2mB5w37p@kuha.fi.intel.com> <E91C97D0-7DB9-4455-AED2-4C25B7D2D22D@aosc.io> <YRuW0fENBEcIVkZb@kuha.fi.intel.com> <YR0Rlj+jk9dnoG6N@kroah.com>
Message-ID: <E1804EE0-CBA1-4BE8-875B-57E82EDECDBE@aosc.io>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 0CCDA412DF
X-Rspamd-Server: mail20.mymailcheap.com
X-Spamd-Result: default: False [-0.10 / 10.00];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         ARC_NA(0.00)[];
         R_DKIM_ALLOW(0.00)[aosc.io:s=default];
         RECEIVED_SPAMHAUS_PBL(0.00)[59.41.161.108:received];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         DMARC_NA(0.00)[aosc.io];
         R_SPF_SOFTFAIL(0.00)[~all];
         RCPT_COUNT_FIVE(0.00)[5];
         ML_SERVERS(-3.10)[213.133.102.83];
         DKIM_TRACE(0.00)[aosc.io:+];
         RCVD_NO_TLS_LAST(0.10)[];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         ASN(0.00)[asn:24940, ipnet:213.133.96.0/19, country:DE];
         RCVD_COUNT_TWO(0.00)[2];
         MID_RHS_MATCH_FROM(0.00)[];
         HFILTER_HELO_BAREIP(3.00)[213.133.102.83,1]
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



=E4=BA=8E 2021=E5=B9=B48=E6=9C=8818=E6=97=A5 GMT+08:00 =E4=B8=8B=E5=8D=889=
:56:38, Greg Kroah-Hartman <gregkh@linuxfoundation=2Eorg> =E5=86=99=E5=88=
=B0:
>On Tue, Aug 17, 2021 at 02:00:33PM +0300, Heikki Krogerus wrote:
>> > >Why is it necessary to do discovery with data role swap in general?
>> >=20
>> > I think it could be possible for devices to expose different altmode
>> > with different role=2E
>>=20
>> OK=2E FWIW:
>>=20
>> Acked-by: Heikki Krogerus <heikki=2Ekrogerus@linux=2Eintel=2Ecom>
>
>Is this conflicting with https://lore=2Ekernel=2Eorg/r/20210816075449=2E2=
236547-1-kyletso@google=2Ecom ?
>
>Which of these two should I take, both?  Neither?

Don't take this, it's against spec=2E

Thanks,
Icenowy

>
>confused,
>
>greg k-h
