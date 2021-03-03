Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 073AD32BE1E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:35:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237392AbhCCRCL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 12:02:11 -0500
Received: from mout.gmx.net ([212.227.17.20]:37019 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238867AbhCCMbs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 07:31:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1614774614;
        bh=AyfrbWOMECCIN32HYOHpFRVWGNqU4udC6MIuB8c7g0w=;
        h=X-UI-Sender-Class:To:From:Subject:Date;
        b=gzxlbvmvNdB14yJi/ntdiiPBfAbnl/OuC9SXFeM/2pbwUq9zmuWcdnzX6KfoVtSJM
         G+OUTao2lMpnvG490apZw3YQQsGsWYf5qBv/5bNEoGd3xJCn/0jPvxxhn4wh3notCd
         hBfr0XioNCwt3Rr/YwDB9k8wLdVsblEkTGGDT9lg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.44.246] ([105.80.250.83]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MtwUm-1m4s011m8a-00uHwO for
 <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 13:30:14 +0100
To:     linux-kernel@vger.kernel.org
From:   "Artem S. Tashkinov" <aros@gmx.com>
Subject: A long standing issue with RAM usage reporting
Message-ID: <6ea673dc-c34b-ff8f-57f3-bce575b989ce@gmx.com>
Date:   Wed, 3 Mar 2021 12:30:10 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:DhUr0e3/POzJ3m1LEIaeE0WwCdj9GJuQMJKLCS7/fZDJBBXif0C
 le9X1G+R5jlWwUBeHVLUbHymepWxQXAyfwNeufPfA/2tFjT1UgVOe+lYA9DHAq7z1bDF1bw
 a7aMc/nlA6U+riQWWM+eTf/BSeiRsvgWUSLgeQTyjW5cEFOPg7UPRDV+uET9hoWOAQHDy6C
 M8uQZTv2y9ZE9Wo84XcUg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:+wQOEY3JZ20=:hIlioP0P89AEAoDL/0ZeFK
 N4p3kbeyUxB0Nf9cuO/z8UV0y/+hpyNLnr2+dIZqnJzAIRe8r1wP16G3q7yoLIjXpllOUkykm
 d7D9cE0Tv7x0361ERpuTYMB4nd/J8KFpf+f2uds8dfyGTaakTC0hf8OdUgDtIgXveU/pWue1C
 bc8B/eu9lZhh87QXh7LqdEOsKLXpBXs7FE5ViEMjEuzlz5Be9rd8PBP1YVK2v9RlJojxSE2L5
 TG6FbiStF6ZqADMF7QGgjpqUo3nv0Oe3dxdnRaZo7m/1ERZYrqD0NvhlqFH2jYOFEzk5j3RcI
 uTDAQBIIW+5KjnA+Zqiy/RKe4x1FPU6YdM2ylT6SOHEpocWMjkWETesdzeeGxxd9XeBD3XAoV
 dWVrbXb3KVhb9EZZ3ZZ4UAq9hutqYgcU7zo3MRppLfryHw3W9FA/Y/Me4sIoHqZjekG6yA1eq
 7goAyy93PE9VYxBmu/5SgVQ/9olmGv14XFDjErmx9tD21nGOJNrZczsmkvKNOyL0xBzr9ur+p
 kkBZ6rbVrQLNzRcJ/0/mxqlpc7RniHhlaqmuVQ/VEuiMq5YoqpiuW4rXf6DqqCY1xL5ZKl+nU
 WJRNsOfsSZ1y6d1+snozHYM5/tKCzpHhWjEPp7kRIkqId8MQUQ6Lo7SeB/w5iFK21JUzS4rEF
 /X3JVCqqmT6d52d6FvPOJuQldNsOCAKj1ZCKp9dgxy6CoO0csx9J5TwLaw9wNrgu719ImNi8y
 xsabegRkG+ExfmBwtOMUEfEEn4pa1wyaVkkxwuLlw02hfSM0YaA2czunleWSIGlpbDCS0Uzbt
 DHY68phTVGaorPmf7eLC5xiIduPg4gfwcsF6YPEkND+rDoWcVz23IBGfunIKknuOhZCEbh9Oh
 +1QYQNrhHJW5NPS6RaXw==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everyone,

I'd love to bring kernel developers' attention to this long standing issue=
:

https://bugzilla.kernel.org/show_bug.cgi?id=3D201675

It would be great if something was done about it because otherwise htop,
top and free and numerous other utilities in Linux have to implement
hacks and workarounds to properly report free/used RAM.

https://github.com/htop-dev/htop/issues/556

https://gitlab.com/procps-ng/procps/-/issues/196

There's also another related issue:

https://bugzilla.kernel.org/show_bug.cgi?id=3D201673 but it will be
automatically solved once the initial bug report has been dealt with.

Best regards,
Artem
