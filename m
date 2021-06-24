Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BF4C3B2EB5
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 14:14:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbhFXMQ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 08:16:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbhFXMQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 08:16:25 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1430BC061574;
        Thu, 24 Jun 2021 05:14:06 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id g4so3383061pjk.0;
        Thu, 24 Jun 2021 05:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XGU8ouAgZGtXgu7rpRjNOy9ykeVF8eLx0WEUkoloQXM=;
        b=WPf+eestIQxzzxWZWJsev7T/1CCODr0YCChOR2k+wsdhv7ZIeV3G0Ya1yyI/f3KLTc
         4AFx4SnJ+gRmJXWCY0gx2DnW5/6lNwHnkE9PBp/CMlftY6TPB5yXbDRMjk3aYlRx51mi
         nbtrMDYggjFHkXDzW4CFSfZZxWYiLdHvSrVJbtJnL7yxIDLyDRGN/FtQDFiSo4zjtSzS
         zNlq2UpHjrOnY9Ot9r+bvwqdAbv/hfS6tuwioWEawdx/IF+B0fefZEev8Tie21IzvzwC
         KQmKEIoP8ZQ61pEQJvJQSZVOahNA+PdbN22cbk+Je+s5QzY0prCCkxWfbI+tKRuOJckS
         KLfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XGU8ouAgZGtXgu7rpRjNOy9ykeVF8eLx0WEUkoloQXM=;
        b=VOVTBityYC7jH8TVk3KTn9WfFe5/j+o9FrmqnLEiJ14LPuzX9REEFkuSN+lLxjG3cH
         t0erbttHZU1Ma5efHt9XRxEG4VCaf34e7WSA3j7eo2ChJxFBAgJyxSuBBk0FzweAJLj7
         O+DSTOQoUDuqg2VM3TwAvHaYIlpgNJCu9KnPns99feCwla7kD3ECsOXzrgbfWBaD1ZWU
         BLalxdnHnOHs75IprDbfrQ7z2rEZCpR7hEgGnhuYq8fnerRLHSvd2yFi3uXYBcZOkor4
         D2VO7EHHEIJc6Z08LysMaEcoWyjQMbMktVKyYKQBAipVaEf7ZIyjs5pzOJnn2aYou490
         SoFw==
X-Gm-Message-State: AOAM5323lyeVZ5ocV5+3VXkxXqyaE6bfKmlkYmzKfW6EW5FuWEAFWOsf
        pdbwWo2QxPVrBUq/XznCop8=
X-Google-Smtp-Source: ABdhPJyvjSIB1Y/6P304ntlxGZXdymuABxYHsjJ7Ajh6tYsj4l6ERAwM60TsWbE8WScBCRNAET9yaQ==
X-Received: by 2002:a17:903:304e:b029:11d:75ff:c304 with SMTP id u14-20020a170903304eb029011d75ffc304mr4002257pla.33.1624536845665;
        Thu, 24 Jun 2021 05:14:05 -0700 (PDT)
Received: from [192.168.11.2] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id 143sm1260636pfx.46.2021.06.24.05.14.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jun 2021 05:14:05 -0700 (PDT)
Subject: [RFC PATCH 3/3] docs: ko_KR: Use white spaces behind CJK characters
 in ascii-art
To:     Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     "Wu X.C." <bobwxc@email.cn>, SeongJae Park <sj38.park@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Akira Yokosawa <akiyks@gmail.com>
References: <386938dc-6290-239c-4b4f-c6153f3d98c5@gmail.com>
From:   Akira Yokosawa <akiyks@gmail.com>
Message-ID: <1152c06c-c4b7-d8a3-e9f1-2f5ddbd7a892@gmail.com>
Date:   Thu, 24 Jun 2021 21:14:02 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <386938dc-6290-239c-4b4f-c6153f3d98c5@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In verbatim ascii-art of Korean translation of memory-barriers.txt,
Sphinx is confused by tabs behind CJK chars and generates wrong number
of white spaces in LaTeX code.

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



