Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC3F0362BD1
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Apr 2021 01:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234681AbhDPXKd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 19:10:33 -0400
Received: from mx6.ucr.edu ([138.23.62.71]:61980 "EHLO mx6.ucr.edu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229719AbhDPXKb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 19:10:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1618614606; x=1650150606;
  h=mime-version:references:in-reply-to:from:date:message-id:
   subject:to:cc:content-transfer-encoding;
  bh=SygSNkbaMWX+V8Hor2+klt+qQPcK1BBeqBQmRHhHQYs=;
  b=T2CEX+BGcOskCrClbmRmFidv18C42iLUbcdwUyBjoZ/UvV4mpAy0kgi3
   T/MQwRxvw3ZupISf7Z7AtDSjMoa30Jj2CdgCXVnKMZjUOaRST9lf2Zcac
   yL4MXzL88oPuD9hr0EnON+WkQrmdzxkEUcFeaNPfKzTQ329hWACZWLRn7
   /NfNIXBSi1uL113iIbK11J3fxaRAXU+kjTB9cg6RUHFLct6ay0glPPoPh
   maLe9MmJgnPTs67gufk+eDA/uqjISj0cCYqIUEDmxmdwl57NothEeRvvI
   cOCbZnpkjilTNYxDOJ0nPzLQvKLFzItshpbMIaGbyCnB1g5tGHvOC9Qmv
   w==;
IronPort-SDR: l6RpgPhfGy5v3J3AjDT2QllGdzh6LsbT9t0Wi51GYOuS8GgsyKR6d/SwL3tpN2reeypXoFG938
 1XSg/f9jO7W1maGl220Jen8mMkQkBsF1yANBemzY5fHVi+I4Ee/Sc2D23m7ooNKCUZ/0h1wRWE
 bC3Zk45bY05IiXJLRJ+BhFGpGEhyLBiDVu28W42LubtXpqUdZV4cT+p4o5OfzFLLSBOeWHe/Ps
 vQjLyZ76xt4qkvVu10ug9LAJfCjFi1mUEbvtqoR7i0Hd5wHQYqW+iCtbpt/ODsrVWd+HC+nsZu
 4RI=
X-IPAS-Result: =?us-ascii?q?A2EcAAD1GHpgf0emVdFaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T4HAQELAYN3a4RDiCSJTwOaa4F8AgkBAQEPNAQBAYRQAoF0AiU0CQ4CAwEBA?=
 =?us-ascii?q?QMCAwEBAQEBBgEBAQEBAQUEAQECEAEBboUXRoI4KQGDbAEBAQMSEQRSEBYNA?=
 =?us-ascii?q?gImAgIiEgEFARwGARIihVcFoDGBBD2LMX8zgQGIDgEJDYFEEn0qAYcChCiCK?=
 =?us-ascii?q?ieCJ4FJgyqHWYJhBIJILIEtEIESAiMBSYEZAQEBj3WLYIF/gSCbDAEGAoJ1G?=
 =?us-ascii?q?Z0GI4ERo20BlRqeLkKEYhAjgTFmgS4zGiV/BmeBS1AZDlaNVRaOSyQvOAIGC?=
 =?us-ascii?q?gEBAwmMMV0BAQ?=
IronPort-PHdr: A9a23:31le0RNtRW2TV/QvXoYl6naTDRdPi93PFj5Q0YIujvd0So/mwa6KF
 HLW6fgltlLVR4KTs6sC17OH9fmxBCdfvN6oizMrSNR0TRgLiMEbzUQLIfWuLgnFFsPsdDEwB
 89YVVVorDmROElRH9viNRWJ+iXhpTEdFQ/iOgVrO+/7BpDdj9it1+C15pbffxhEiCCybL9vK
 Bi6txjdu80WjIdtKKs8ygbCr2dVdehR2W5mP0+YkQzm5se38p5j8iBQtOwk+sVdT6j0fLk2Q
 KJBAjg+PG87+MPktR/YTQuS/XQcSXkZkgBJAwfe8h73WIr6vzbguep83CmaOtD2TawxVD+/4
 apnVAPkhSEaPDMi7mrZltJ/g75aoBK5phxw3YjUYJ2ONPFjeq/RZM4WSXZdUspUUSFKH4GyY
 JYVD+cZMulYoYvyqVsAoxW9GAeiGv/gxDBTi3/qxK03yfgtHR3a0AEiGd8FrXTarM/yNKcXS
 e27ybfHzDXeb/hL3jny8o7IeQ0mrPGPWLJ/a8zRxVUzGw/YlViQtJDqPymP2usTrmeb8vNtW
 OSygGEotw9/uCKgxtswiobXnIIVzEjJ+Tt3zYs3J9C0VkB1bMC4HZdNqyyXNYV7T8ImTmx2u
 ys0yqMKtJy6cSQUypkqyQLSZv+af4SV7RzuSuacLSp6iX9jZbmxhA6y/FC+xuHgUsS4ylVHo
 ypfntXRt30A1gbf58qaRvZ740yvwyyA1xrJ5eFBOU00kK3bJIM/zbMojZoTtFjDHjfxmEXrk
 K+abkUk9fas6+Tgerjmo4WTN45wig3nM6QundGzDf02MgUMQmSX4+u81Lrk/U32RLVFkOc6n
 bXesJDfPcgbp6i5DBFJ0os79RqzEzOr3M4bkHQHNl5JZROKgonzN1zMPfz0FfK/jE6tkDdvy
 fDGJLrhApDVI3jAlbfuZ7B951JAxAYu1t1f+o5bCqsbLP3tR0DxqcTUDgUlPAys3+bnFNJ92
 5saWWKOBK+ZLazTvUaL5u0xOemMYpEauDLmJvg76P7hk2U5lUUefaa3x5sXbm63HvB8L0Wee
 3rsjYRJLWBf9AY3UuHvoFGLTzNWY3G8Q+Q66y1xQNaqBJnOQ6ihiaKM2SO8EIEQYG1aXBTEW
 2bvbIWKRvUNQCaTJNJx1z0cS+bnTJUun1n6pQjhy7R6LOv8/iweqIKm1cBruavUjx5ksXQ+A
 9+U02yXSUl3k3kOSjtw27pw6wQpxkyK0aVihdRbGMZV6vcPVR01Y9qU7eV5Ftq6eQPKf9GSS
 1fuFta7CzgZTd8rxdIKJUFnFIPxoArE2n+JDq4I35mCAtRg8afV2SCpfu5gwGyA2aU82Qp1C
 vBTPHGr0/YsvzPYAJTExgDAz/7CSA==
IronPort-HdrOrdr: A9a23:nr8KRaiJmuXHg6vhLmpr94MPHXBQX5l13DAbvn1ZSRFFG/Gwvc
 rGpoVj6TbfjjENVHY83e2aMK6bTn/GsbJz648dPbCtNTOWw1eABodk8Ifk3nncCzTzn9QtrZ
 tIXqBiBLTLfD1HpOng5g3QKadD/PCm9+SSif7a3zNRS2hRGsJdxiNYLireLUFsXglBAvMCda
 a0wsZcvTKvdTA2Q62Adx04dtPOrdHKi57qCCRub3UawTKDgj+y5LnxHwLw5HcjeglSyrQv+3
 WtqX2f2oyftZiAu3nh/l6WwZATvNf60NNMCIi3l8AJJlzX5zqAVcBOXbuNuTxwjcOOzBIRkN
 fKqwo9JMgb0RnsV1Dwjx3q1QztlAwr9man81mFmnHuyPaXeBsKT/FMj45YbRfVgnBN0u1B7A
 ==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.82,228,1613462400"; 
   d="scan'208";a="208520890"
Received: from mail-io1-f71.google.com ([209.85.166.71])
  by smtpmx6.ucr.edu with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Apr 2021 16:10:04 -0700
Received: by mail-io1-f71.google.com with SMTP id v1-20020a5d94810000b02903e0f4d732b4so5361636ioj.5
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 16:10:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=88l6LtIMEUkNEl8C8zUnABwqKqB7A3kmZqHpeOxBRYE=;
        b=CVoSXABpBvaqmP7Hz6hei7IdBZVTS2WWXPlp9h0GDQ+oPb54xPhsUCFW2Y2mSWrZIp
         gWvzgJw8h8QvUrfq83woE9mt9aMK3xR13jJV152woBuclfU/keR3briYl4Bn2/ElbOJY
         jmzhqERMLLO97HISjzQUV01M6/0wYMmC7ZR5ya9TMKdFLsF7dK/YNLmdiRz1/8TjBRko
         OVxyl7kQOnjB/6eFG6hjFQZZ0t8bxlDlxngXvvwVyGj91szvoE92owClg0VWe5ls5Rij
         PhBB9ov02HiyGCWeD2mDdUUG9A0xJe0w+6qNhpVlBlTMTbKHY/uusB1d0oprQBCXWC1L
         OUGQ==
X-Gm-Message-State: AOAM533FQzlMO2u5dPeGsnIP8gMerlykqN7TLlrcAbqbWHhqEQ8QTMUj
        Cn2vJGLnLpcKOxsedh5agnobYS+MumMyhOL9YxXmwfE3obcs2B+wxV5BUUS1iXy5w3UgtQ3wZuG
        Af+oCFmoQLu47Ln3JpMXsCZqqnlWFtocb4hpUBGHGFg==
X-Received: by 2002:a02:cd8a:: with SMTP id l10mr6330830jap.6.1618614603283;
        Fri, 16 Apr 2021 16:10:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwr3lRhtzJhnotRcEiH9yE2xvDqRZNCg0O7GzDAlSpbmryVC+AZKvJOlbYNg9721M4RtF/iUB9NGCO+dvXKuiE=
X-Received: by 2002:a02:cd8a:: with SMTP id l10mr6330804jap.6.1618614602890;
 Fri, 16 Apr 2021 16:10:02 -0700 (PDT)
MIME-Version: 1.0
References: <02917697-4CE2-4BBE-BF47-31F58BC89025@hxcore.ol>
In-Reply-To: <02917697-4CE2-4BBE-BF47-31F58BC89025@hxcore.ol>
From:   Keyu Man <kman001@ucr.edu>
Date:   Fri, 16 Apr 2021 16:09:52 -0700
Message-ID: <CAMqUL6YL_c138shGm7qZjA9jbOS3V6qx_k4E=+f0TGkVXOBfbQ@mail.gmail.com>
Subject: PROBLEM: DoS Attack on Fragment Cache
To:     "davem@davemloft.net" <davem@davemloft.net>,
        "yoshfuji@linux-ipv6.org" <yoshfuji@linux-ipv6.org>,
        "dsahern@kernel.org" <dsahern@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Zhiyun Qian <zhiyunq@cs.ucr.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

    My name is Keyu Man. We are a group of researchers from University
of California, Riverside. Zhiyun Qian is my advisor. We found the code
in processing IPv4/IPv6 fragments will potentially lead to DoS
Attacks. Specifically, after the latest kernel receives an IPv4
fragment, it will try to fit it into a queue by calling function

    struct inet_frag_queue *inet_frag_find(struct fqdir *fqdir, void
*key) in net/ipv4/inet_fragment.c.

    However, this function will first check if the existing fragment
memory exceeds the fqdir->high_thresh. If it exceeds, then drop the
fragment regardless whether it belongs to a new queue or an existing
queue.
    Chances are that an attacker can fill the cache with fragments
that will never be assembled (i.e., only sends the first fragment with
new IPIDs every time) to exceed the threshold so that all future
incoming fragmented IPv4 traffic would be blocked and dropped. Since
there is no GC mechanism, the victim host has to wait for 30s when the
fragments are expired to continue receiving incoming fragments
normally.
    In practice, given the 4MB fragment cache, the attacker only needs
to send 1766 fragments to exhaust the cache and DoS the victim for
30s, whose cost is pretty low. Besides, IPv6 would also be affected
since the issue resides in inet part.
    This issue is introduced in commit
648700f76b03b7e8149d13cc2bdb3355035258a9 (inet: frags: use rhashtables
for reassembly units) which removes fqdir->low_thresh, and GC worker
as well. We would kindly request to bring GC workers back to the
kernel to prevent the DoS attacks.

    Looking forward to hear from you

    Thanks,

Keyu Man


On Fri, Apr 16, 2021 at 3:58 PM Keyu Man <kman001@ucr.edu> wrote:
>
> Hi,
>
>
>
>     My name is Keyu Man. We are a group of researchers from University of=
 California, Riverside. Zhiyun Qian is my advisor. We found the code in pro=
cessing IPv4/IPv6 fragments will potentially lead to DoS Attacks. Specifica=
lly, after the latest kernel receives an IPv4 fragment, it will try to fit =
it into a queue by calling function
>
>
>
>     struct inet_frag_queue *inet_frag_find(struct fqdir *fqdir, void *key=
) in net/ipv4/inet_fragment.c.
>
>
>
>     However, this function will first check if the existing fragment memo=
ry exceeds the fqdir->high_thresh. If it exceeds, then drop the fragment re=
gardless whether it belongs to a new queue or an existing queue.
>
>     Chances are that an attacker can fill the cache with fragments that w=
ill never be assembled (i.e., only sends the first fragment with new IPIDs =
every time) to exceed the threshold so that all future incoming fragmented =
IPv4 traffic would be blocked and dropped. Since there is no GC mechanism, =
the victim host has to wait for 30s when the fragments are expired to conti=
nue receive incoming fragments normally.
>
>     In practice, given the 4MB fragment cache, the attacker only needs to=
 send 1766 fragments to exhaust the cache and DoS the victim for 30s, whose=
 cost is pretty low. Besides, IPv6 would also be affected since the issue r=
esides in inet part.
>
> This issue is introduced in commit 648700f76b03b7e8149d13cc2bdb3355035258=
a9 (inet: frags: use rhashtables for reassembly units) which removes fqdir-=
>low_thresh, and GC worker as well. We would gently request to bring GC wor=
ker back to the kernel to prevent the DoS attacks.
>
> Looking forward to hear from you
>
>
>
>     Thanks,
>
> Keyu Man
