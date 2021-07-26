Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80B9A3D5870
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 13:27:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233365AbhGZKqq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 06:46:46 -0400
Received: from mout.gmx.net ([212.227.15.18]:40195 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233278AbhGZKqp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 06:46:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1627298823;
        bh=vZleZWIqfzP05PzxCCp/6U1s9aHGWqbfElJ3uiz9AOU=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=kSQuDKXX9c1mMwluZ0HYgkJgvE8mKAgh7o52SXqLEF3oZN9906Jx2dqEc85MfSC47
         4t4kXi43twIPD46Ezv66xpHro3XmQ9nMEBR0gdOI18plOg4tUBzI7AHQYIllq9SRqu
         F72u1iSC2R4qb+4CT2lRA5NOrlYmYiVa9KUVm/mQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from workstation.fritz.box ([88.152.144.157]) by mail.gmx.net
 (mrgmx005 [212.227.17.184]) with ESMTPSA (Nemesis) id
 1M26rD-1m62xD3zHF-002WNl; Mon, 26 Jul 2021 13:27:03 +0200
From:   Heinrich Schuchardt <xypron.glpk@gmx.de>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Atish Patra <atish.patra@wdc.com>,
        Anup Patel <anup.patel@wdc.com>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Sagar Shrikant Kadam <sagar.kadam@sifive.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH 2/2] riscv: defconfig: enable NLS_CODEPAGE_437, NLS_ISO8859_1
Date:   Mon, 26 Jul 2021 13:26:47 +0200
Message-Id: <20210726112647.78561-1-xypron.glpk@gmx.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210726112511.78350-1-xypron.glpk@gmx.de>
References: <20210726112511.78350-1-xypron.glpk@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:s59V+JRRw4AVH2/7Y1aj9wuxkZntebT8SXNlG9rUnZK+pCRyYRE
 oKfxgb4/9VoiSkAd8vhTyo8nefWwURkAUnd5HXnlc7lzrlWvybAl77Ei7FxHD8FY7lpSvf/
 LyWNAbCpfs0u/42GSVq6DQtaQ9HNFQiqL3psuhI8W695tl2q21ew6gAZYkh6ixMkIiQd7fs
 /8WISPTXb3oXxWtb0CLDQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:7JdTz5Gze70=:tZqGADFJqJMjMYUF1bRUWm
 Pc7dHL3CECegDXQLkVeF/KktDUTqy3cbHqABJNuXM5mb57J2iNZg8OPfZsq1fH8MRl0QLjUm9
 kOYEjYPKs8pAwWBzPN6J2ypMV9bTxSs+BTVdCAFAIZDUUewigQq00RCial9eoNI6QqljPNttG
 vkogN7RRAnDbwYWsPZhkOY84eIxCpteJfI2cJdfW3XSUM5UnzdX6gs8534EN+iK4QCl3C2/wv
 ShhdbYzxv7UoOsbsj2YbOqAjlONFBpAESUtsj3Dnv1xopR7jiVQRBpULtxEQ/3TUxjCwlnZbr
 2mIUVxNx5D1l9PX/spsQopliaTqJHExXi6LXxvZo3KNMth/IamzRKaJFIR9RjVla9LMODHalC
 3pQ5SDmtb8SUK9g/iFN1BtYcT/+HT/pFfrX7YXlgkBkAa4umSwIgRM5WLrU3raOhf91KNrg4I
 dkdnA9oh71BP2NdaHeNHsQr1iJGPZLqhIJULc7n9NmVMu49BCkN4WcYR+oAQb2BHMdEg7iluK
 gM0162EmG8IOzllaEpLe8/D4YwoZcjqhRUf00yFmdMii2koH5wbdddJEhoXkrOf3wjzE+xohZ
 FaX4Wt/YyMnn4Y8VHrztvqemLrVTEE9d4Omh5p9FnmNwaiYNQYAWMlCSmv6fqKIwWvpBCj8HI
 M/uvsfamGnjz0RrKUyOPJJj93nJ+kA8AxgD9oC7bjBAT7iHgoVO5I9vT6kT5NrGmsbyhGGnib
 uH/R0ZNzO15BORJK4tP9qNqdmdgkDwO7en2L39RmrgR5Y+EXRREZaQAsa/a/9lCtu1dZoUkDe
 r+vnxzUQcRkGS6ChzF5P1wD721T2zypuCWAoLs9ZTMhzLwa50ikFyK0cv1A2tMHvwf1e4Xc+y
 cZyUHnY+3yavUh2iafHNbmA7eXXrksdqlKHxS0amIcTCr1LC0sSx6bdrcylucGwcSH6boUilW
 EvcMw3BZDqLXc9Lty4rME2/cZSqbF2EQSGlLnkcIfGCgvM3OJp7NnC5di5MYnDdzMTvdr2YVJ
 lBBPSpxpqbLkGs+MatuBY0n4fgU2XFlQMX0/QO8yt6N9cgwf8brp/q5Ary9kbfPWpocQ1wEEX
 gtpYf5pSdWSRf6Rq10jo8ab+SKmYMqM5svy
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The EFI system partition uses the FAT file system. Many distributions add
an entry in /etc/fstab for the ESP. We must ensure that mounting does not
fail.

The default code page for FAT is 437 (cf. CONFIG_FAT_DEFAULT_CODEPAGE).
The default IO character set is "iso8859-1" (cf. CONFIG_NLS_ISO8859_1).

So let's enable NLS_CODEPAGE_437 and NLS_ISO8859_1 in defconfig.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
=2D--
 arch/riscv/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
index 393bf3843e5c..1a3170d5f203 100644
=2D-- a/arch/riscv/configs/defconfig
+++ b/arch/riscv/configs/defconfig
@@ -110,6 +110,8 @@ CONFIG_NFS_V4_1=3Dy
 CONFIG_NFS_V4_2=3Dy
 CONFIG_ROOT_NFS=3Dy
 CONFIG_9P_FS=3Dy
+CONFIG_NLS_CODEPAGE_437=3Dy
+CONFIG_NLS_ISO8859_1=3Dm
 CONFIG_CRYPTO_USER_API_HASH=3Dy
 CONFIG_CRYPTO_DEV_VIRTIO=3Dy
 CONFIG_PRINTK_TIME=3Dy
=2D-
2.30.2

