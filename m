Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0246E37970D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 20:31:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232591AbhEJScc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 14:32:32 -0400
Received: from mout.gmx.net ([212.227.17.20]:48911 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231400AbhEJSca (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 14:32:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1620671474;
        bh=yed0YzBjgjohaBfaix3PjUoWhDcykU3KCCY0bWzyjyI=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=NnQdoEH/HuTVFV5tPZ0PzGIhI5gPuCLzdAQIxoB8Mg/haTDvsEW0iZN+eRWACUG/C
         0M+AngNCr+Yb67Amt5+fJnJuVh+uJthTkmXPW/kaZdlWBKFGxD+OsCr8kD17yjZoxI
         Zn/xA30oRSKI8SWevDKZsvnsaYoPQiAaAyfo91CU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([37.201.214.126]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MBUqF-1lo6V43WaF-00D12H; Mon, 10
 May 2021 20:31:13 +0200
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Lee Jones <lee.jones@linaro.org>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>
Subject: [PATCH] MAINTAINERS: De-duplicate INTEL MAX 10 BMC MFD DRIVER entry
Date:   Mon, 10 May 2021 20:30:56 +0200
Message-Id: <20210510183056.810753-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Gdl++FMm2DGDZatLRDX8S8izqi+YXGsZEF9cslmYyjjSVWKqrHm
 SS5kn+pR3kFw0Ejl1Fzqm2VHo4tG56kyjyBJUKYSmvvZzPbFL6D7ajCBxhKVw7sb/v7CI6K
 GMordSTDz/t6IXQ/H7gcV37IwtuWLRRl4p1NjSvDYOeuNWhoyaPoaK9gq9y0HjjhtVvRGip
 pBE9dbbEHV2e739ddnnMg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:6QdcJHu5bqc=:CfeMtMctJzrBwrOsoifNy0
 EqhXYrPr2xBJqJEsfhrQ3yMkGdCcoht0ceedqdku+D9XoDwPr+bG+iHFKA+Fas8McwZoy+tjw
 apeTRx3i3/a/sjg0LoOBiX25G0IQvhk38vFeQ3i1wZ78HaI40MZKjd0N0ZRgJ2+n20se15YME
 n8AVCLo6iR8A2RO9JqAYtDW184xmEOXgZfbdumf+fax5ZErKn7h2kHJMfayuA7lEOy/QwLfsO
 B1jOTic0D3POKLd+7IgfTsmIQXRW/Fi/0pMnJe+3QTJHqO1YRTXiU10jU29tlCNKi5/mZWOPD
 aIbDrlE0VNecge3gmW6XeUZqeDmi38QhLS4Ji9r9pq5DXoEyLOmdSmQxYIVaQ5oWniIO7XVlF
 SowsQoKAak4i6CD4V3YUHKLEt/oFJ2QOt5F0h7+j7QHMlrpGiLrI3jsAmbO2E6Q70ujeJa8on
 MFiJRbatQc8PAPRTwmvnipB5SmGdbNyxKzWEW9+sv3dcrII2nOPLdkzs1bpW0XuyC9PsW00A8
 NWS+GP+H+H5pWjBPviPwyy+2gdlX5MfPlSFXd6NdVuneW2M3Qgv5+Y66BA527ad6fzFzz8WWx
 yH9a5eeD/6zatPbdC27PihGu+Dw4vgpmoqjsgKz8N9nUf1x5oGxJQ1okvvXTdxBANGIGmgGXi
 OUFGsDyTEsfKfik3GscqSVoQq7KgkTW2kElheVmfTUlz8xjzqBst4xdrxDGgaiEzY4xULKxdu
 RNrtmkrtpUqKE6CbDz4Mhjtq614WchR7KQUdXYukdhk/EWrytzA8eE0uMllCcJXvaJglWLPPO
 8xVupapHuAY6WKfFMIG61D4BYvMogMOm0gETNn7IU7fgbx5/obImMgSmjTKqOVQ9YPj+x3o92
 7LiisJLS25p2rYf2YhJN+fKMYpp8zvtaU8+ttidZ/t006pwOLY9SpW6R2ymxzfcsYQ0Ry7Gi2
 8/lK1QH7Z4QuxoUPQW+n36D0sNQA+3esSRVV/GRNXJQUDAFifezPmq6q7xS/2NFb1iyM6srIf
 52h6wV06k7GNYb+v3/lHH8J9VBQ7zLB7lcZOevAZNomD+bht9Do98c24XvDDf+eVxQ0M5sWTM
 RZEsDUM7EA6CPQYwW07ZCaWT6VSa542dTD3/sPd32H+STwdzohqm24yiPtsnUaxcD1yroI2/I
 3P7fwnpcS2XOxrFphIZRQQZfzkPhR2JwPtUvY1ezOSgOWbRq3W6qj5oR1uNzJxH3znCMROJd7
 tBSkqt25Z7h/jt9ji
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Xu Yilin's patch "MAINTAINERS: Add entry for Intel MAX 10 mfd driver"
was applied twice, resulting in a duplicate entry. De-duplicate it.

Fixes: 58d91f1c1701d ("MAINTAINERS: Add entry for Intel MAX 10 mfd driver"=
)
Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--
 MAINTAINERS | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index bd7aff0c120f2..7d6e44b9f4664 100644
=2D-- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9299,16 +9299,6 @@ F:	drivers/hwmon/intel-m10-bmc-hwmon.c
 F:	drivers/mfd/intel-m10-bmc.c
 F:	include/linux/mfd/intel-m10-bmc.h

-INTEL MAX 10 BMC MFD DRIVER
-M:	Xu Yilun <yilun.xu@intel.com>
-R:	Tom Rix <trix@redhat.com>
-S:	Maintained
-F:	Documentation/ABI/testing/sysfs-driver-intel-m10-bmc
-F:	Documentation/hwmon/intel-m10-bmc-hwmon.rst
-F:	drivers/hwmon/intel-m10-bmc-hwmon.c
-F:	drivers/mfd/intel-m10-bmc.c
-F:	include/linux/mfd/intel-m10-bmc.h
-
 INTEL MENLOW THERMAL DRIVER
 M:	Sujith Thomas <sujith.thomas@intel.com>
 L:	platform-driver-x86@vger.kernel.org
=2D-
2.30.2

