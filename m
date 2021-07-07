Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F91B3BE47A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 10:33:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbhGGIgS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 04:36:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:57473 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230109AbhGGIgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 04:36:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625646817;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gsCgBjZOBNs8GkUNl/mNs2MJS9/AFWcuZUWnlsWxVR0=;
        b=ZyGCjClW+8dfsG1T1FLKIOUzLAjmoL8H0HVwZoYm/UNlk9+wzhm8eujOIip6xoq/noPawD
        YKcqVOVnI39rqVqJLKtOGfQ/RR0KBC4t762pJCW6xorTWCsUjJPfDZI098mUGTflXHkx5q
        2lJFNe1UeKVQkk8sWZ5FZ6dDxO9LWAU=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-420-ySNjkmSeNQCaegY7JV5IyQ-1; Wed, 07 Jul 2021 04:33:36 -0400
X-MC-Unique: ySNjkmSeNQCaegY7JV5IyQ-1
Received: by mail-io1-f71.google.com with SMTP id p7-20020a6b63070000b029050017e563a6so1179393iog.4
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jul 2021 01:33:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gsCgBjZOBNs8GkUNl/mNs2MJS9/AFWcuZUWnlsWxVR0=;
        b=dQhjpwfeCb5ID8sXhzLc4z/LjSJdtf5ckiCuJP1Yinq4Efn4/bOyxxIXK8quyvVmbI
         OoWqnfXEuGOqC5Do0rmnLkrWR5TWUl8LV9PtQ7hGd/8XnO1pJ/f2/O7cF4XynXACakon
         ahUlSMeq4mLVLcc6V3nIz5optVDJjB7XHrtGLazYyAvOAo55GXAZ2Zvvg+W3y731QvE7
         e+b1H8WPkVZCCy29XU8buEu/Kl9J4OK70VMXfAaK0S/c0fnkkTZAq76369W4x4YYVpSW
         ME5QiwaD5O9V74KQ0duNZcq2JcgKiPi3QW6cO21kbH3Tw8Q/yQLzSfi5A58mqKcg97RZ
         eyqQ==
X-Gm-Message-State: AOAM533d221B1P7anml6yvuh18hv0R6zHQiyXCLQ+VTad5BJbF4F3/Zn
        LK5feIxT91NSdmQVNraA12GrsU7c6Y9xN89PYGMuWs+5XPBNk2aYV1S1YsTkCAKDUbyDW5e850O
        WSWu30tbPQfIlPXF86Kr0yQKyGEGV2BcVdPT+1bpr
X-Received: by 2002:a05:6e02:921:: with SMTP id o1mr18424297ilt.57.1625646813916;
        Wed, 07 Jul 2021 01:33:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxjADIFFE8x66m44Qg1NdRzaMJgQ7eb1Hz+C+bh0cFgtAJbVgNwE4FSxW0Kh29twnqMKUFm/lNIaXceqGkzzWQ=
X-Received: by 2002:a05:6e02:921:: with SMTP id o1mr18424282ilt.57.1625646813772;
 Wed, 07 Jul 2021 01:33:33 -0700 (PDT)
MIME-Version: 1.0
References: <202107070458.FO35EqwU-lkp@intel.com>
In-Reply-To: <202107070458.FO35EqwU-lkp@intel.com>
From:   =?UTF-8?B?w43DsWlnbyBIdWd1ZXQ=?= <ihuguet@redhat.com>
Date:   Wed, 7 Jul 2021 10:33:22 +0200
Message-ID: <CACT4ouf-v+G7oCAFRqZWYQUqs8o1GdSKRbqJwjjP_cNuPFKvgA@mail.gmail.com>
Subject: Re: drivers/net/ethernet/chelsio/cxgb4/sge.c:2571 cxgb4_ethofld_send_flowc()
 warn: missing error code 'ret'
To:     Dan Carpenter <dan.carpenter@oracle.com>, rajur@chelsio.com
Cc:     kbuild@lists.01.org, lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 7, 2021 at 9:37 AM Dan Carpenter <dan.carpenter@oracle.com> wro=
te:
> 0e395b3cb1fb82 Rahul Lakkireddy    2019-11-07  2564     if (tc !=3D FW_SC=
HED_CLS_NONE) {
> 0e395b3cb1fb82 Rahul Lakkireddy    2019-11-07  2565             if (eosw_=
txq->state !=3D CXGB4_EO_STATE_CLOSED)
> 52bfcdd87e83d9 =C3=8D=C3=B1igo Huguet        2021-05-05  2566            =
         goto out_free_skb;
>                                                                         ^=
^^^^^^^^^^^^^^^^
>
> Are these error paths?
>
> 0e395b3cb1fb82 Rahul Lakkireddy    2019-11-07  2567
> 0e395b3cb1fb82 Rahul Lakkireddy    2019-11-07  2568             next_stat=
e =3D CXGB4_EO_STATE_FLOWC_OPEN_SEND;
> 0e395b3cb1fb82 Rahul Lakkireddy    2019-11-07  2569     } else {
> 0e395b3cb1fb82 Rahul Lakkireddy    2019-11-07  2570             if (eosw_=
txq->state !=3D CXGB4_EO_STATE_ACTIVE)
> 52bfcdd87e83d9 =C3=8D=C3=B1igo Huguet        2021-05-05 @2571            =
         goto out_free_skb;
>
> Here too
>
> 0e395b3cb1fb82 Rahul Lakkireddy    2019-11-07  2572
> 0e395b3cb1fb82 Rahul Lakkireddy    2019-11-07  2573             next_stat=
e =3D CXGB4_EO_STATE_FLOWC_CLOSE_SEND;
> 0e395b3cb1fb82 Rahul Lakkireddy    2019-11-07  2574     }

I'm not really sure, I just added the skb release in the exit path to
fix a memory leak.

I think it might not be an error path in this case, maybe just no
actions must be done in this specific cases. CCing Raju Rangoju from
Chelsio to see if he can confirm.

--=20
=C3=8D=C3=B1igo Huguet

