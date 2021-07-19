Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 580553CD3B9
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 13:24:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236501AbhGSKhx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 06:37:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236364AbhGSKhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 06:37:52 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67FBBC061574;
        Mon, 19 Jul 2021 03:29:00 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id my10so11179909pjb.1;
        Mon, 19 Jul 2021 04:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jtGN9wE5doYwbAS2i6O5Ca83ymWdWG1+gIX4VaX3+84=;
        b=O++o3n+t6UWk/1SXOY2/V03gj/0SqS/0GJ2FMoz8JFlv1FAWPaZdwQWdI5srcXmfHl
         byg8lpjs1OFvMRHNCDDbfCk4Pk5IBolrPoCUIc0DU+pxMPpoEqXdySWkMG8k/r1QBssC
         Y7n8IwysNQS6EqFmOLP4/OYSY6JY+GkDdiEAfkbz2G7QtAgxAYlEufGu6sK71yNi01qm
         cHMu0LuVch21ABT5Qz+AZaFF7LQKG1V8NiYLdZG//x61ba+gdaTRzyZmKTOfjxfR5BgM
         6L/jIPzL5FAyTReq2GrbfHs38WF8awj2HtyMzKHTR7n3G/SEJVfmvKwZiqEQWjjbqzOz
         5C/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jtGN9wE5doYwbAS2i6O5Ca83ymWdWG1+gIX4VaX3+84=;
        b=GnuDWDn01GZdPN7bfdkqihpH55nhgbSHcFxntN0ofpS/mUdvkxeeWMm107QlAw/7xD
         gWlBhrc1H7kD6T0/tSGj/hZDaaDf14aehsK6gMKywLTPj2GaCAl4GqERJpi1zwEnngJ0
         0FgqnwyebJxGD9gldUISMdTBv6Y8bhmlYKXHJzZJS9+OqyHuR1kgIUdtPC8PzgOs6j8W
         vdXlNpjIcbmGlS+aprw+jZ5Ihl9O2SHVavImq378mcxqVNHkKbqch14zGPn5USAvmjRe
         6NaRr9NudhYkTI/X9nVCRwRj42ovoI1Ux/8PC8WCz9qHw2gePwxCDwyuQF8Es/G1Z9n0
         UPBg==
X-Gm-Message-State: AOAM532ngOUDIzvq+YNw3YirGh60xn+wNWea7IGLpCz1JROKeoLGL4Vv
        /RX5QodwcLuvr2oEz+7ri90=
X-Google-Smtp-Source: ABdhPJzwCrIsgiHHT9QnO/6iY7EcjRnm6UVntloSqD0V+S18rTqZMBdtkzOV0afirvJCeuFjTTc1Og==
X-Received: by 2002:a17:902:7246:b029:129:dcf5:b583 with SMTP id c6-20020a1709027246b0290129dcf5b583mr18804974pll.73.1626693511519;
        Mon, 19 Jul 2021 04:18:31 -0700 (PDT)
Received: from [192.168.11.2] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id i8sm21192758pfk.18.2021.07.19.04.18.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jul 2021 04:18:31 -0700 (PDT)
Subject: [RFC PATCH v2 7/7] docs/ko_KR: Use white spaces behind CJK characters
 in ascii-art
To:     Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Wu X.C." <bobwxc@email.cn>, SeongJae Park <sj38.park@gmail.com>
Cc:     Hu Haowen <src.res@email.cn>,
        Shinwoo Lee <shinwoo.lee.us@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Akira Yokosawa <akiyks@gmail.com>
References: <20ff8a65-6a5c-c062-fe1a-0f5c5ddc813c@gmail.com>
From:   Akira Yokosawa <akiyks@gmail.com>
Message-ID: <2babf4ef-d3f3-5591-667e-f87b6ea509ab@gmail.com>
Date:   Mon, 19 Jul 2021 20:18:28 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20ff8a65-6a5c-c062-fe1a-0f5c5ddc813c@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In literal ascii-art of Korean translation of memory-barriers.txt,
Sphinx is confused by tabs behind CJK chars and mis-caluculates number
of necessary white spaces in LaTeX code.

As a workaround, use white spaces in such cases.

"html" output is also slightly improved by this change, but still need
some proper font choice, which is out of the scope of this change.

Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
---
 .../translations/ko_KR/memory-barriers.txt         | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/Documentation/translations/ko_KR/memory-barriers.txt b/Docum=
entation/translations/ko_KR/memory-barriers.txt
index 64d932f5dc77..ff36b857ef72 100644
--- a/Documentation/translations/ko_KR/memory-barriers.txt
+++ b/Documentation/translations/ko_KR/memory-barriers.txt
@@ -1364,7 +1364,7 @@ Multicopy =EC=9B=90=EC=9E=90=EC=84=B1=EC=9D=80 =EC=8B=
=A4=EC=A0=9C=EC=9D=98 =EC=BB=B4=ED=93=A8=ED=84=B0 =EC=8B=9C=EC=8A=A4=ED=85=
=9C=EC=97=90=EC=84=9C =ED=95=AD=EC=83=81 =EC=A0=9C=EA=B3=B5=EB=90=98=EC=A7=
=80
 	=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D	=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D	=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 		{ X =3D 0, Y =3D 0 }
 	STORE X=3D1		r1=3DLOAD X (reads 1)	LOAD Y (reads 1)
-				<=EB=B2=94=EC=9A=A9 =EB=B0=B0=EB=A6=AC=EC=96=B4>		<=EC=9D=BD=EA=B8=B0=
 =EB=B0=B0=EB=A6=AC=EC=96=B4>
+				<=EB=B2=94=EC=9A=A9 =EB=B0=B0=EB=A6=AC=EC=96=B4>           <=EC=9D=BD=
=EA=B8=B0 =EB=B0=B0=EB=A6=AC=EC=96=B4>
 				STORE Y=3Dr1		LOAD X
=20
 CPU 2 =EC=9D=98 Y =EB=A1=9C=EC=9D=98 =EC=8A=A4=ED=86=A0=EC=96=B4=EC=97=90=
 =EC=82=AC=EC=9A=A9=EB=90=98=EB=8A=94 X =EB=A1=9C=EB=93=9C=EC=9D=98 =EA=B2=
=B0=EA=B3=BC=EA=B0=80 1 =EC=9D=B4=EC=97=88=EA=B3=A0 CPU 3 =EC=9D=98 Y =EB=
=A1=9C=EB=93=9C=EA=B0=80
@@ -1394,7 +1394,7 @@ CPU 3 =EC=9D=98 X =EB=A1=9C=EB=93=9C=EA=B0=80 CPU 2=
 =EC=9D=98 =EB=A1=9C=EB=93=9C=EB=B3=B4=EB=8B=A4 =EB=92=A4=EC=97=90 =EC=9D=
=B4=EB=A3=A8=EC=96=B4=EC=A1=8C=EC=9C=BC=EB=AF=80=EB=A1=9C, CPU 3
 	=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D	=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D	=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 		{ X =3D 0, Y =3D 0 }
 	STORE X=3D1		r1=3DLOAD X (reads 1)	LOAD Y (reads 1)
-				<=EB=8D=B0=EC=9D=B4=ED=84=B0 =EC=9D=98=EC=A1=B4=EC=84=B1>		<=EC=9D=BD=
=EA=B8=B0 =EB=B0=B0=EB=A6=AC=EC=96=B4>
+				<=EB=8D=B0=EC=9D=B4=ED=84=B0 =EC=9D=98=EC=A1=B4=EC=84=B1>         <=EC=
=9D=BD=EA=B8=B0 =EB=B0=B0=EB=A6=AC=EC=96=B4>
 				STORE Y=3Dr1		LOAD X (reads 0)
=20
 =EC=9D=B4 =EB=B3=80=ED=99=94=EB=8A=94 non-multicopy =EC=9B=90=EC=9E=90=EC=
=84=B1=EC=9D=B4 =EB=A7=8C=EC=97=B0=ED=95=98=EA=B2=8C =ED=95=A9=EB=8B=88=EB=
=8B=A4: =EC=9D=B4 =EC=98=88=EC=97=90=EC=84=9C, CPU 2 =EC=9D=98 X
@@ -1789,10 +1789,10 @@ CPU =EB=A9=94=EB=AA=A8=EB=A6=AC =EB=B0=B0=EB=A6=AC=
=EC=96=B4
=20
 	TYPE		MANDATORY		SMP CONDITIONAL
 	=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D	=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D	=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
-	=EB=B2=94=EC=9A=A9		mb()			smp_mb()
-	=EC=93=B0=EA=B8=B0		wmb()			smp_wmb()
-	=EC=9D=BD=EA=B8=B0		rmb()			smp_rmb()
-	=EB=8D=B0=EC=9D=B4=ED=84=B0 =EC=9D=98=EC=A1=B4=EC=84=B1				READ_ONCE()
+	=EB=B2=94=EC=9A=A9            mb()                    smp_mb()
+	=EC=93=B0=EA=B8=B0            wmb()                   smp_wmb()
+	=EC=9D=BD=EA=B8=B0            rmb()                   smp_rmb()
+	=EB=8D=B0=EC=9D=B4=ED=84=B0 =EC=9D=98=EC=A1=B4=EC=84=B1                =
           READ_ONCE()
=20
=20
 =EB=8D=B0=EC=9D=B4=ED=84=B0 =EC=9D=98=EC=A1=B4=EC=84=B1 =EB=B0=B0=EB=A6=AC=
=EC=96=B4=EB=A5=BC =EC=A0=9C=EC=99=B8=ED=95=9C =EB=AA=A8=EB=93=A0 =EB=A9=94=
=EB=AA=A8=EB=A6=AC =EB=B0=B0=EB=A6=AC=EC=96=B4=EB=8A=94 =EC=BB=B4=ED=8C=8C=
=EC=9D=BC=EB=9F=AC =EB=B0=B0=EB=A6=AC=EC=96=B4=EB=A5=BC
@@ -2151,7 +2151,7 @@ wake_up() =EC=9D=B4 =EB=AC=B4=EC=96=B8=EA=B0=80=EB=A5=
=BC =EA=B9=A8=EC=9A=B0=EA=B2=8C =EB=90=98=EB=A9=B4, =EC=9D=B4 =ED=95=A8=EC=
=88=98=EB=8A=94 =EB=B2=94=EC=9A=A9 =EB=A9=94=EB=AA=A8=EB=A6=AC =EB=B0=B0
 	set_current_state();		STORE event_indicated
 	  smp_store_mb();		wake_up();
 	    STORE current->state	  ...
-	    <=EB=B2=94=EC=9A=A9 =EB=B0=B0=EB=A6=AC=EC=96=B4>		  <=EB=B2=94=EC=9A=
=A9 =EB=B0=B0=EB=A6=AC=EC=96=B4>
+	    <=EB=B2=94=EC=9A=A9 =EB=B0=B0=EB=A6=AC=EC=96=B4>                 <=EB=
=B2=94=EC=9A=A9 =EB=B0=B0=EB=A6=AC=EC=96=B4>
 	LOAD event_indicated		  if ((LOAD task->state) & TASK_NORMAL)
 					    STORE task->state
=20
--=20
2.17.1



