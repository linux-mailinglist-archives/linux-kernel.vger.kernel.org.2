Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9A2C366696
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 09:59:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237516AbhDUIAH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 04:00:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235285AbhDUIAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 04:00:06 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADDE7C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 00:59:33 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id s4so2820346qtw.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 00:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vt-edu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:mime-version:content-transfer-encoding
         :date:message-id;
        bh=cJkRJYy2mP9xs3yZpwwbsS4qRW8FNd/4NKo5XFd2bgc=;
        b=hJozwj1tTWRkIFw9UX5dsJ1Z/NyHiOlLoFZLPlmdstYK4bzMK4P4fejlQUIvvLxWrq
         EvszHc/k+31DrZiwaXNXvqSt5eu4nphAVCJ68wDnS3ALnp3LRJXNrbjJcju8kaWurzgg
         +zPynv9y9K/70T0sOS8XgV7D2PBYFXcSyskyYREVEEidHNu7GYKdLy0vnmJh3Wb5m1bt
         rs/zHcPsHT7aULUn8mXGekQ+ghe7X/ZMOzgo+P27RoAO9KTdr6htPX+mE+++OtYTfGU2
         G1/a5FWa0OFlTlgTUfklV2mper2yHeQq0fomu69HW9u3kgcFayN7eMyqoHOKXdMBsx4w
         egWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:mime-version
         :content-transfer-encoding:date:message-id;
        bh=cJkRJYy2mP9xs3yZpwwbsS4qRW8FNd/4NKo5XFd2bgc=;
        b=eFEgLdyraLXZ3LodgEdVr+cPs1rtaw7DI6C55IU8qQVrH2iCb1wgZF1UhGJpA85GTv
         qhOOAVwHo/3Nk6CWMakMtfKcNOL0r18ImqeFuLMJmEzVB21sORFTe17cgH/kPECh8cLf
         iBaHof2bYk83cakiUcxzAlB8q7+kx1sVb0t2MnK2IFXS/JjbmXkCwrOWdA50pepMw7EE
         nNkQ6h7fsBJeerKyufiM1JmwaX5QY4gUdwWyaO+z+ztxKkpYFKqdCFmJutQSBHZbkngj
         AICGBT/FK3iSIYPBzs/ucyoMG1l0bc8hS9T+HzRgc+ns2uHOt2eMxC8Kc4ExXDIsv/KF
         nD0A==
X-Gm-Message-State: AOAM5317lRMxbk+IF8IH3Z66TEPaqLZi8A3MgVVwGMaAHMJGBGejLjcG
        3bl/JKG1NIvCvYEgAxxzhEpSBA==
X-Google-Smtp-Source: ABdhPJznvty6Bj5sYvcZJattKvFsWyLVJYMQ/GkNV3bnS3ZOiuJRekauNEF/KU0llucQKo0wpX1rdg==
X-Received: by 2002:a05:622a:1c5:: with SMTP id t5mr20018694qtw.49.1618991972693;
        Wed, 21 Apr 2021 00:59:32 -0700 (PDT)
Received: from turing-police ([2601:5c0:c380:d61::359])
        by smtp.gmail.com with ESMTPSA id l124sm1496431qkf.38.2021.04.21.00.59.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Apr 2021 00:59:32 -0700 (PDT)
Sender: Valdis Kletnieks <valdis@vt.edu>
From:   "Valdis =?utf-8?Q?Kl=c4=93tnieks?=" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis =?utf-8?Q?Kl=c4=93tnieks?=" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Coly Li <colyli@suse.de>, Jianpeng Ma <jianpeng.ma@intel.com>,
        Qiaowei Ren <qiaowei.ren@intel.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-kernel@vger.kernel.org
Subject: next-20210420 build breakage on 32-bit - include/uapi/linux/bcache-nvm.h
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1618991971_13593P";
         micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date:   Wed, 21 Apr 2021 03:59:31 -0400
Message-ID: <697668.1618991971@turing-police>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1618991971_13593P
Content-Type: text/plain; charset=us-ascii

commit 97d69b16cb973e04ea5309b9cb4356aa6b42c54e
Author: Coly Li <colyli@suse.de>
Date:   Wed Apr 14 13:46:36 2021 +0800

    bcache: add initial data structures for nvm pages

contains this code:

+#if (__BITS_PER_LONG != 64)
+       #error "Non-64bit platform is not supported"
+#endif

This breaks the build on arm and other 32-bit systems:

  HDRTEST usr/include/linux/bcache-nvm.h
In file included from <command-line>:32:
./usr/include/linux/bcache-nvm.h:109:3: error: #error "Non-64bit platform is not supported"
  #error "Non-64bit platform is not supported"
   ^~~~~
make[3]: *** [/usr/src/linux-next/usr/include/Makefile:106: usr/include/linux/bcache-nvm.hdrtest] Error 1
make[2]: *** [/usr/src/linux-next/scripts/Makefile.build:534: usr/include] Error 2
make[1]: *** [/usr/src/linux-next/Makefile:1967: usr] Error 2


--==_Exmh_1618991971_13593P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.9.0 11/07/2018

iQIVAwUBYH/bYgdmEQWDXROgAQJntRAAg072xVR/BfzrIhZTP2+Oa0qii+bD9Ybi
4PLLIVAgkoGdLBGCKuXLq37fTtt53pdzNFBS7V6tRBTj1Q2jIoQVdrOegfGVfsve
NRRC7nD9X5Zyw3RPKWIcHzFF224sVsjWZz325m+v4Hu1/fQt/3gTqYaVRmMArd0Q
PskVvG4FnX3ikEpChhCvN8cXjGC1CXE4RqyGrQxbCp2kF80MGNGFxexBDEP1lQPB
4NraHDmRRYJct+QvH4QVzWBm1zefAJ/HwKTXa4xcSxRYhJ0dftRkTI7SXCXwuH1t
plp3KEHL0Tk+IqH1RftWwyHiZ+302K46FNApaiR7ZCMYF4zpqEo4E2SzT3MxiCB6
r/LqazpdR0SziRqy4gXcsqYwhyS+6Gz4IyGjCAO8gHdrsdAKI9bAct8wOY/b0CBA
nFTVrFB3ANk0SifBulF/CVPsJcxZpwJv5TrIx89tvvsUBjYOsLGIk0TGdEXVwJFv
Lusn9t5+4qHbBijhU3/1/rbUaX18XdjU844kgXmmQO8Rqr2O4sQJYgrXVm094BMv
QrKqZ4zzM/n/Hnsz3LOPgQ1WeeN8PelDxRXCoDLrgnxa7sXhehvGddk223W43P/v
xvYefCrivfkyiBxrYaIF6F3EhxyBxcbnBkue2QFV8QAXmHiUjULpJ+rLIO3u6CBG
MbC3ODLF3DM=
=PkoC
-----END PGP SIGNATURE-----

--==_Exmh_1618991971_13593P--
