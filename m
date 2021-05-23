Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCDA338DCFE
	for <lists+linux-kernel@lfdr.de>; Sun, 23 May 2021 22:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231934AbhEWUvc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 May 2021 16:51:32 -0400
Received: from mout.gmx.net ([212.227.17.22]:58495 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231939AbhEWUvb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 May 2021 16:51:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1621803003;
        bh=KVTmpgoFjVPx+6Udo+1s5CN4ImL5TqNHSNSe88hESy8=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=TznAm0SZU0cxxEZ/g6v+OUkCJNB/UD9P1zu9eqJhii5MichUn42+hnP5Lk67q2+vL
         18j0KH2JJkawyZAsdyAqav6VY/t46WiA0I4BraX40acjNWiVIwlnGUkK6opved6ylM
         4R97w/x8BwoIdbr8/ieZK9wPJeifJCTIxO6Xqxg4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from LT02.fritz.box ([62.143.247.63]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MAOJP-1lZbAO1dAh-00BsuR; Sun, 23
 May 2021 22:50:03 +0200
From:   Heinrich Schuchardt <xypron.glpk@gmx.de>
To:     linux-kernel@vger.kernel.org
Cc:     Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH 1/1] include/linux/byteorder/generic.h: fix index variables
Date:   Sun, 23 May 2021 22:49:57 +0200
Message-Id: <20210523204958.64575-1-xypron.glpk@gmx.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Ef5BOabWclbPwSCrRFDTG1CqQ8V5Yd4H2+AkuEb2SALfQor9RqK
 szaVAbTfDCn3lnEDnVlcbQpl8+qiQ8gPA3nRsAOyv0XRakXY2cK/kT3MN/M3cCqMc5ha1Gq
 WN5zSRmjQEVDdCcuF6nu69NapplMn0FBH2zs3m7sHZV/RwQ+c+H6heypm0j2hYe59H2mjAo
 LXyJmUeh2gHAAXlhgidaA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ttHcypUKKOw=:qFktBqsvnp4hkemEsZUnCQ
 2OHsn3fFxx1tMjev9Q1py2MF7i+I0L/Y6gzN3dNsFkm9sgUsM0+ET5GQr2kC91lW4Cjh/ZjE/
 WQZP9pStd+4GFP3YHN7vRmA+UyFHWbry/GmInn3h4TgBQdF3u21Z+WzX5mOQzff+0/j1az3A2
 +33ZZ5I3euMcDA/i97qhrcEhe9oGhVDM3xkdLR3sfCR/hTjCxX/T8MYmMGHfrErnSxc7+oocX
 jx2OpN6ARHmDdSZx+ptovHFmP0NHMvtGJTzEdEvOr/mcyTmR2+LASbQqZN0syftUhrkbOKvrx
 gV9l7CW3CWF/dW+7uNx2tX4EclanXsXZY8TSCb/epdQHcIRr/OLXcm+VKA4S7z1n8ZeFcgaCg
 tAtVhK3M3N9vjqRF0kNBQJ9AbLZLmbLb+qc1or42I5+mF1UuBNyuVWr6MF/6OOdt2dvlHlOtR
 TMmkJ+l9toMJhrKFAzoMCLb6G7Vq/jzFxBbeMJJAPf0QSX29LDk/KnaMysEzHh+ck1PlRs+WN
 /kGa5+6OpR4BeAb5LFW3mquHnL+aQ8Cqumwc0FyT/U13GmGqdF7B/+JGiOOMzFIZBvf6c350x
 AqSguKXpDtKcf7LNu9GeX5GyVNCYK0pf6hrzLyywTPKux/yVn3fao1xI+uKDsM6vqYfjxfTgR
 Yvn2c0K7Y+bUbelg8ue78JSDwatAcTAziwezn4EcDVD646KkrQqP1IJQITefv6ITjY58JGw2O
 8rBch+iTiTayvO8kWUvRTf3t2RW/Egj4LkKU+u4OeT6YvyHhwAs6/XFoD8rcPkX23AALmGrbd
 0E13armYNnDrW5idlEjtIQUuPljDi9/AQA6ziHK4lq759M3Gc+/4xE7EJ6LRU5ZsxN/+WzNYf
 i+5YFKd/uegWgQO1u3zJKwbhrvwgP5bmzYHOFOiz1+uiIpk9wsBmhyuv+No70OaQbjtJUfB4u
 ZbgXQbiT4CXtCjDhHW169KdnBA2Y+LWwzWmPzr9bX6nguZpGNHxAMR94iby3MjI4lIDuHsfQC
 fEJAjp6ftBso67CrS2cAPEaO4wjTXTgYX6JzK6ynJD7dj1f7mvetiscFzXADniWXqSP8C1JHQ
 YDD61TJm0+vlbfG1uEJP9KIkZt08QO/QrlVCt6/WUQ/WH3jw6sIKwcGP+/sMwA64Spl4FZF0Z
 46Ox/mY+1fCYxumZIxu4sLm4bqaoFGNDiRw31HZ7x+9yPO9wJyUGC7at8G2uKtE6krB7U=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In cpu_to_be32_array() and be32_to_cpu_array() the length of the array is
given by variable len of type size_t. An index variable of type int is use=
d
to iterate over the array. This is bound to fail for len > INT_MAX and
lets GCC add instructions for sign extension.

Correct the type of the index variable.

Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
=2D--
 include/linux/byteorder/generic.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/byteorder/generic.h b/include/linux/byteorder/g=
eneric.h
index 4b13e0a3e15b..c9a4c96c9943 100644
=2D-- a/include/linux/byteorder/generic.h
+++ b/include/linux/byteorder/generic.h
@@ -190,7 +190,7 @@ static inline void be64_add_cpu(__be64 *var, u64 val)

 static inline void cpu_to_be32_array(__be32 *dst, const u32 *src, size_t =
len)
 {
-	int i;
+	size_t i;

 	for (i =3D 0; i < len; i++)
 		dst[i] =3D cpu_to_be32(src[i]);
@@ -198,7 +198,7 @@ static inline void cpu_to_be32_array(__be32 *dst, cons=
t u32 *src, size_t len)

 static inline void be32_to_cpu_array(u32 *dst, const __be32 *src, size_t =
len)
 {
-	int i;
+	size_t i;

 	for (i =3D 0; i < len; i++)
 		dst[i] =3D be32_to_cpu(src[i]);
=2D-
2.30.2

