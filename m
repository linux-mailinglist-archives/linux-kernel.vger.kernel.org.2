Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3795E3C3F10
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jul 2021 22:23:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbhGKU0b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jul 2021 16:26:31 -0400
Received: from mx-lax3-1.ucr.edu ([169.235.156.35]:40045 "EHLO
        mx-lax3-1.ucr.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbhGKU0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jul 2021 16:26:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1626035024; x=1657571024;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=knolZgBhatuIwg555Bgxz2YLsAZpb8GlB7yQJDayxi0=;
  b=U2HoASW6SUmQT3q/AqMe6tSMfIRR93zFDAgUL7YO2EOoAY5dUhQHOCGX
   ExEZX373kiYpASysMDAQ+s5QBCVUJcQY1pqKARsEqLkktLeSdn0dmofbB
   08eC7Hxx+jD64Yp2DR2ckkem+BSgLETx2EBANmCvdUAPOI0NZYqBq+GaO
   WbcdwiwFsG/pOQzTrfuW0SqKerXQSfiSRTFfU1MsalnDC9MwsuOssMEC5
   +2pQyoijgGFUqBV561EVj2foo56xPhf1PHfPlnfpZm5vixG5uMbCVWZ/i
   ETL8zNvo/kBVP7Oobmq/y49MRWbfuyz5iYD1B/cOyOSm3eNCC6JLwzLWk
   w==;
IronPort-SDR: iUqMLYwa/0wTZzPpuzErI2hQ/IFf8EuDnPHLVUtBTZCEas0DCho/GAQkzd7ak0SbnyP+M6bB5P
 OwkpwEpotrpF5CWphWUnGPx1QcP30YHUAnzPMtGSHMUDiHsUEvzy3vHocsqVaHZW9cCBSAf9ZG
 k7Ik3cE7InmaFHk2bTHWL08DTSccQPAPLpdw20+FTMGlWZSTMGeqXWMyzwsNttp8YmDCgKmfl2
 CFJIf8cv9FsEj3c+ALn40/nG4uhgmvScfbJsgFj+bPwV4xVd7XtZ9Sp/kFxg/88mR9+WLtvLUn
 Exc=
X-IPAS-Result: =?us-ascii?q?A2EhBwAvUutgf0jYVdFaHgEBCxIMgg4Lg3lVFo1Mhw0BA?=
 =?us-ascii?q?QEGjCIYgQGGeohmgXwCCQEBAQ0BAT8CBAEBhFSCewIlNAkOAgQBAQEBAwIDA?=
 =?us-ascii?q?QEBAQUBAQYBAQEBAQEFBAEBAhABAW6FL0aCOCmDZQsWIAFGgRUBBQE1IjmCF?=
 =?us-ascii?q?gGCYSacPoEEPYxkgQGIJwEJDYFjCQEIgSiIe4UXgRmBEIJQgTN1h2+CUASDF?=
 =?us-ascii?q?3sTg3kBAQGTT4s4nQUBBgKDChyDDpsMRYZgjlmRGAEttjiEHQIEAQEBAwcGE?=
 =?us-ascii?q?COBOIIVTSWBbAqBQVAZDp0NITI4AgYKAQEDCVuLIwE?=
IronPort-PHdr: A9a23:NIwizRXddQJ8HZlO1Ww1BMzIB9zV8KwrVTF92vMcY1JmTK2v8tzYM
 VDF4r011RmVB92dsqoP1bue8/i5HzBZsNDZ6DFKWacPfidNsd8RkQ0kDZzNImzAB9muURYHG
 t9fXkRu5XCxPBsdMs//Y1rPvi/6tmZKSV3wOgVvO+v6BJPZgdip2OCu4Z3TZBhDiCagbb9oI
 xi6sxndutMLjYd+Jao8yx/EqWZMd+hK2G9kP12ekwv468uq4JJv7yFcsO89+sBdVqn3Y742R
 qFCAjQ8NGA16szrtR3dQgaK+3ARTGYYnAdWDgbc9B31UYv/vSX8tupmxSmVJtb2QqwuWTSj9
 KhkVhnlgzoaOjEj8WHXjstwjL9HoB+kuhdyzZLYbJ2TOfFjZa7WY88USnRdUcZQTyxBA52zb
 40TD+oaIO1Uq5Dxq0YSoReiAAWhAubvyj5Thn/t3K061eshGhzY0gI5AtkOvnXUo8vxNKgPT
 Ou5yKfFwSnGY/5Q3jjw9IbFfgw8rf2VQb58bNfaxU0yGw7Fi1mdr5HuMTGI2eQXq2WV7/RuW
 /+hhWAkrA9+rTehy9wwhoTKnI8Z1krJ+TllzIszONa2SFR7YdmhEJZItS6aNop3QsM/Q2Fvp
 S03zb0HuJ+7fCcQyZQr2wLTZvKcfoiV/h3jTvydLilli3J4Yb+ygQu5/ke8xOPmTMa0zEpKo
 TRfktnKrn0A2Rje59WaR/V94Eqv1yiD2hzd5+xEPE05l6XVJoM/zrA+i5ces0vNEyv4lUnqj
 6Kbdlgo9/S15un6YLjropGROolpgQ/9KqQjgtKzDfg8PwQUXGWW+f6w2KP+8UD4WrlHjOM6n
 rHEvJ3bIckXvLC1DgFV34o59RqyDi2q3dUEkXQBMVlLYgiIj5LzNFHLOP34CPC/jEmynzpz3
 PDGO6HhAo3KLnjejLftZbZ95FBYyAo01d1f4ohbCrAFIP7qQk/xtsHUAgY3MwG23errEtp91
 oQZWWKABq+WLrnevkOP5uIqO+WMZYkVtyjhK/U9+fLikXs0lUUecKSpx5cbdm20E/V8L0ibf
 3bgmtIBHn0Lvgo6QuzqklqCUTtLaneyXqM85is0CIO6AYvfSI2gm6GB0zuhHpFMeG9JF02MH
 W/yd4qYQ/cMdD6SIsh5nzwAVLihTZIh1B63uA/51bVnNOzU9TMctZ/4yth16PPclQso+Tx3E
 cudyWeNQH9wnm8SQD82xq9/8gRT0FCGhJl5kfxFEpQH9uFJWwZibcX00udgTd3+R1SSLZ+yV
 F+6T4D+UnkKRdUrzopLPhsVJg==
IronPort-HdrOrdr: A9a23:dz7TnaOBjrsNmcBcTvyjsMiBIKoaSvp037Dk7TEVdfUzSL3iqy
 nApoV96faZskdzZJhCo6H5BED/ewK7yXcd2+B4VteftWHd2VdAR7sSibcKrQeQeREWNdQx6U
 6jScJD4RHLYmSS9fyKmTVQ2uxNruW6zA==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.84,232,1620716400"; 
   d="scan'208";a="53568978"
Received: from mail-pj1-f72.google.com ([209.85.216.72])
  by smtp-lax3-1.ucr.edu with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Jul 2021 13:23:43 -0700
Received: by mail-pj1-f72.google.com with SMTP id ot1-20020a17090b3b41b02901733dbfa29cso8385910pjb.0
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jul 2021 13:23:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aSJsemQuEJggnAB9yPIA6lDwcxwNnBl6SI50zavXFPE=;
        b=sTrXdAR/mvnOZnGc4BytZtPNIVM8PrlZ2Fmf6L5tgmmA10JSf+5PNGlvTQ49AEzezq
         79RKp6ApjM1D8keVSUI4w8qdMSncUEav3M/PWLoEVMzDDQrIkKz/4+iz7fCyPX95+FfZ
         MdJaR+sz6tt+4wXTlSZw6cIwjJYMtcEArELJyXZ112TdVsYIfn9rTB1qRK6PahIki8e2
         UMbAXEKMV7BW+9b180w6Tpb2VuZUA/5k9gMkDT3CaYTVfuKdwc/JVHdUj1tQq8cEJeQY
         X2fnL6vvHqnquORnfBmhs6EfaSpUemp9lzMtNMRjvUEfFZB0e1ha9hSnBCMy2X2xY0O0
         oAbw==
X-Gm-Message-State: AOAM533NVJqMRZPcsbhIPpzgPSeb5fyhrQmqh2w4h43N0xSkCovc9ZEf
        CM0b75yFbwgc3Zb4gtG7wTZ+Hv4HGCp81Kt8rjGqXOjwhG7SBdADRkkg6ltNg9F/GrS937SJUi3
        86UU2S4EpsI0rue54zs9uj5t07Q==
X-Received: by 2002:a17:902:9b87:b029:11e:7c15:a597 with SMTP id y7-20020a1709029b87b029011e7c15a597mr40411347plp.6.1626035022796;
        Sun, 11 Jul 2021 13:23:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxluD4OhWJyegly9NdVTbZoCzN/+hubXRoiMZtpc8eeGRXGkRv8qro8QAoIpFG6fP3ZnpWpww==
X-Received: by 2002:a17:902:9b87:b029:11e:7c15:a597 with SMTP id y7-20020a1709029b87b029011e7c15a597mr40411331plp.6.1626035022598;
        Sun, 11 Jul 2021 13:23:42 -0700 (PDT)
Received: from protoss.cs.ucr.edu (protoss.cs.ucr.edu. [169.235.26.60])
        by smtp.gmail.com with ESMTPSA id b33sm14628997pgb.92.2021.07.11.13.23.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Jul 2021 13:23:42 -0700 (PDT)
From:   Yizhuo <yzhai003@ucr.edu>
Cc:     Yizhuo <yzhai003@ucr.edu>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH] media: staging: atomisp: fix the uninitialized use in gc2235_detect()
Date:   Sun, 11 Jul 2021 13:23:32 -0700
Message-Id: <20210711202334.27959-1-yzhai003@ucr.edu>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Inside function gc2235_detect(), variable "low" could be uninitialized
if ov5693_read_reg() returns error, however, it affects the value of
variable "id". The "id" is used in the later if statement, which is
potentially unsafe.

Signed-off-by: Yizhuo <yzhai003@ucr.edu>
---
 drivers/staging/media/atomisp/i2c/ov5693/atomisp-ov5693.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/staging/media/atomisp/i2c/ov5693/atomisp-ov5693.c b/drivers/staging/media/atomisp/i2c/ov5693/atomisp-ov5693.c
index e698b63d6cb7..a899e806dfcd 100644
--- a/drivers/staging/media/atomisp/i2c/ov5693/atomisp-ov5693.c
+++ b/drivers/staging/media/atomisp/i2c/ov5693/atomisp-ov5693.c
@@ -1714,6 +1714,8 @@ static int ov5693_detect(struct i2c_client *client)
 	}
 	ret = ov5693_read_reg(client, OV5693_8BIT,
 			      OV5693_SC_CMMN_CHIP_ID_L, &low);
+	if (ret)
+		return ret;
 	id = ((((u16)high) << 8) | (u16)low);
 
 	if (id != OV5693_ID) {
-- 
2.32.0

