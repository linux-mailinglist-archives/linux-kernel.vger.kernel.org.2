Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94AD7407B4C
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Sep 2021 04:19:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234686AbhILCUw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Sep 2021 22:20:52 -0400
Received: from mout.gmx.net ([212.227.15.19]:47677 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230212AbhILCUs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Sep 2021 22:20:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1631413162;
        bh=YEjdbrUDhZg9FOnRCoqOoesT9SweAvxONdGBIklXH2g=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date;
        b=IoB0YAVqKZRTOvd0xKwdnFHJV81fsA2Odld+YsLrK0wwBE6EZzDaUfSzSMlCjwMkF
         em6bpWWQX8fgetO9YMJhgz6S/wv3NpvPKfNh8/QaB1fwi3qSce3hModNrw+gG6X4pI
         AAlWGdmqAwqR2hQyd0csX3nbbN0ghf86IzgSoGF0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.191.217.102]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MWAOW-1mRueu2DcY-00Xf7i; Sun, 12
 Sep 2021 04:19:22 +0200
Message-ID: <425df999d02a62af13da8e77dbed0f2be750cda8.camel@gmx.de>
Subject: ksmbd,transport_rdma.c: Don't include rwlock.h directly
From:   Mike Galbraith <efault@gmx.de>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     Hyunchul Lee <hyc.lee@gmail.com>,
        Namjae Jeon <namjae.jeon@samsung.com>
Date:   Sun, 12 Sep 2021 04:19:21 +0200
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.41.2 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:JZrr8PrkidXHrZSm8bx+R30zaqYJc131TIX06AIJiFh2X0ZfTgx
 cnbMpLkqLTGRypNUMFmqVjjEpOe+xj9moEn8rJEc/PwMCpmTeCFtfY+0HFFUzqbBGV9SMY9
 9FHegZmqlAWOENUkgGx2hmgQKwnChVMHIkB0v7E6ytQba6FwdEg62H/HBhT8wYHvwKyc45B
 JNwXyqqNhc8qxEMOLNOYg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:YcxXYPw/B7A=:GTcyOjIs8Y2ruAW2+/BCFP
 nMTJX61nAXvrvBqF2LhGZuXrE8l+uBiS46QDF8R/kKyJb9mcgRIsEGhgIpfP+224vhzMoRygD
 /2JSIZnGnxjwSwMmrEqDtyo8F5m1DK0t4PDz5W8wxJ9w3K+WYi7Nz9gJ0000ItMzaT2JV8B5l
 npN5UHZSjgyCjQhzvjOEuzNm19BAEtVQSVL3CizMG8R91BJseOZuv/3QE6SmfPriqkhRbTwm2
 METvkOObPj0hM4BvvHGKNPEKA2nA+ee3gTJ8AU9UuO3Sfbsbzmsy5ZtUxX5324yAP6RJF4xmy
 qmbEK+o9RA2yTxX7xCvj4ImKLxdO/cvz8O+PYl+hI9a89W1MrvXtlRUUvT9eh5xk3pzdN9zA2
 WiID3dIEZl6iGtjUBwid1vkMcH21W2wKKnfsk7FIQuSgyncw4E8kat6vThzjOVgTSKPUGKWpT
 tkMv0FtektWc6cfSYe/DSngc/UeCN085HTEcReTOAbIK25ct4sArRQi0Oon2Xrt7kCEpaptVf
 CYxO04te3Gm7IMcRVh1ctvR82AmzbjFXtYQqB+xIY+FO4xXrpRv3gwy4z+OdGKrA6Thuk7Sn3
 GchfrBgXoZypYD0X2dokrIknPfe+7Mxx3hszKTMoouux6kGxnYPaimaG3ktAYcNgKdzHR1Pxm
 pUDHFVj22YytWyFstHfUz7w/jzmBdoUAW8tnmbV/pVhF63D3oVeHue2cAfdHbGtiNsvJv5QW/
 Soi1AzkUO6bzsS2H5kC8eSwB5RkEKUc7fEl2gIuomyqNXtY8FQGS3Oazhp55N2/xEhgUZmocl
 Bkuk1xBNkf+SDIaH+BxrjV1myJcEKaxHLKlj8QVqc6JM70hTKfa/BmZ2bolE89W5WFNJnYT3I
 8rn9OWSLpnR1j0Ro4X9MnaQMI0hxjkJyokXVBheTcwaJBi2gOFJC5AZqUvq+5qprYM+Q/3+DR
 AdkYMCDmEaod9BE8BuQAMBfOay1GXGXNa0ZBP6r48diQgLal44uJdyGkEEyc5NdBpbAXpFhdS
 X10/8Gp9R8TYeVUyxmfi8WgTRxoIPlO00RRMtJgr4KKA7Me/KRzbydmFGC/l8iEdE46Fqv/IX
 iZQAqnXTAsilu4=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


rwlock.h specifically asks to not be included directly.

In fact, the proper spinlock.h include isn't needed either,
it comes with the huge pile that kthread.h ends up pulling
in, so just drop it entirely.

Signed-off-by: Mike Galbraith <efault@gmx.de>
=2D--
 fs/ksmbd/transport_rdma.c |    1 -
 1 file changed, 1 deletion(-)

=2D-- a/fs/ksmbd/transport_rdma.c
+++ b/fs/ksmbd/transport_rdma.c
@@ -20,7 +20,6 @@
 #define SUBMOD_NAME	"smb_direct"

 #include <linux/kthread.h>
-#include <linux/rwlock.h>
 #include <linux/list.h>
 #include <linux/mempool.h>
 #include <linux/highmem.h>

