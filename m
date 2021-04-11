Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1B9735B6D6
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Apr 2021 22:07:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236529AbhDKUID (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Apr 2021 16:08:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235486AbhDKUIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Apr 2021 16:08:02 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6DC9C061574
        for <linux-kernel@vger.kernel.org>; Sun, 11 Apr 2021 13:07:45 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id b139so5928811qkc.10
        for <linux-kernel@vger.kernel.org>; Sun, 11 Apr 2021 13:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vt-edu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:mime-version:content-transfer-encoding
         :date:message-id;
        bh=vVteGm197WS+Pak+/03TURfJdtAKD0/wWNPTtY/GWDI=;
        b=wDsEMJNSELb4D9d8wRNn0MbMRRWFXjdzSA7q/kyUPTt3sHrv50eaai5yZPPumSweIa
         8k4TpNFR7hd5n/U/hYnGJKKf5i2WNXrMADJ6Rj8Y1hYcxAoJzZy1toNQIiK/LsK2uqjN
         P0Ap0VXL/4IBAmXsSfE3DH6XcmAGg9K2vwkQTEY5jTdV46N/1V4N8e+ZcBjkhba2cRJ3
         3XTmKMtGmdIzxN0AOoYZTMJi8K4UYLQHfQLAT0TGPTL74HtmFg6iXerq83xQUFzwxAu7
         DS1vav5shfWwDpe4P8O2p0b4mPaUtEAo9ByGkiX1MApQr4YCviRVtvO1Q0wUuEmmGavR
         b9HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:mime-version
         :content-transfer-encoding:date:message-id;
        bh=vVteGm197WS+Pak+/03TURfJdtAKD0/wWNPTtY/GWDI=;
        b=RQFOqnzKz1iKGtwEdAIbKsgw1s0RJhBTsEWpVF5wjZlRaFb8onbsIiAju/1DaG0hIm
         8PHPfdkVLJ3iNw3C7944I1fj98vnwWdaJqWIDmtJY+h+kxzClX3isCZaPndhB7NBD8pZ
         i3nW0GXb98IuQxiJVZ+sS9fbSBnqsce/n3L7ah4tnPOVcVwA8Yzc0A/2ogCwx4AzogPZ
         7/FxUlqKw8NfPTH9eLJ2sxdrb5ibiTLWSuMBkW7ecIfAni1sFsPGq7+2iJgwutgldYP6
         w69PGGuVGK46C0ljjTV4BDRO8eAkPfYJRY9Hj5FQ1/46EYxIkPcW0yWeD7HuR7fQAKsx
         b0Jw==
X-Gm-Message-State: AOAM530kg7+s5szGOkdYuRCA+lduyi7Pw3pgWJ8Osz9gT953kIJVEKcW
        3h+SQR0dh8GZT4+AaCGB2UzIJg==
X-Google-Smtp-Source: ABdhPJyAChITVeE/MPh85xPT3C4GtprBydVBUFkQXQgUgMw/idzip7Ea7PWDwcBBiq0rEPbkfjkx2Q==
X-Received: by 2002:a05:620a:110a:: with SMTP id o10mr1706986qkk.148.1618171664926;
        Sun, 11 Apr 2021 13:07:44 -0700 (PDT)
Received: from turing-police ([2601:5c0:c380:d61::359])
        by smtp.gmail.com with ESMTPSA id h9sm6275557qtk.6.2021.04.11.13.07.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Apr 2021 13:07:44 -0700 (PDT)
Sender: Valdis Kletnieks <valdis@vt.edu>
From:   "Valdis =?utf-8?Q?Kl=c4=93tnieks?=" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis =?utf-8?Q?Kl=c4=93tnieks?=" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <jroedel@suse.de>,
        Will Deacon <will@kernel.org>
Cc:     iommu@lists.linux-foundation.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: next-20210409 build breakage in drivers/iommu/mtk_iommu_v1.c
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1618171662_13593P";
         micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date:   Sun, 11 Apr 2021 16:07:43 -0400
Message-ID: <14335.1618171663@turing-police>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1618171662_13593P
Content-Type: text/plain; charset=us-ascii

This commit:

commit 8de000cf0265eaa4f63aff9f2c7a3876d2dda9b6
Author: Yong Wu <yong.wu@mediatek.com>
Date:   Fri Mar 26 11:23:36 2021 +0800

    iommu/mediatek-v1: Allow building as module

changes drivers/iommu/Kcconfig

 config MTK_IOMMU_V1
-       bool "MTK IOMMU Version 1 (M4U gen1) Support"
+       tristate "MediaTek IOMMU Version 1 (M4U gen1) Support"

Unfortunately, this doesn't actually build properly as a module, because:

  MODPOST modules-only.symvers
ERROR: modpost: "of_phandle_iterator_args" [drivers/iommu/mtk_iommu_v1.ko] undefined!
make[2]: *** [/usr/src/linux-next/scripts/Makefile.modpost:150: modules-only.symvers] Error 1

There's no EXPORT_SYMBOL and drivers/of/base.o is a built-in, so
the symbol isn't available to modules.

--==_Exmh_1618171662_13593P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.9.0 11/07/2018

iQIVAwUBYHNXDgdmEQWDXROgAQI3Kg//UWC6smWytHYy158jtuNo7OaHGa9t9z7H
lAii0QD95wLc+gUO/BnzXGuNubA9NdVlesFcQv2U9oIdKcAZ3fZCJPf/u8Rr97Zc
a5+au4AJza/4tYVU8z0+W/xqGU6vqv/vA7dJgyN8BbOZLD+rjHUj97ZPm23vcnd+
5NQI42xXvbCREQi9xy1JwGd+7TAZsht27XaUbU+2es69bmDfW0g3O+sDqqn6mt4+
sExSalCV+F75JENIYpPV/xd2FU7naYSngtOASLFr5jzcQmaRf0HJsplnpzdm2da+
FskOg2KzHVybqM458G6hZhoTS+Z7DGVAY/COLV35ino9JWVnfO0u9Gid0uFeQes+
VVtXumGlnTuKgIQbIIBJ3pfX6DT3tTUbgSe3Z/0eI4L4xi6yQCCS4zlwBCnl10ry
gH1sCvYC9FQivqIoEBmM3MCXG06AwEbRkEHtdhLOrFCzRq7RWaHug0yvT9QGKHWe
e34rB6PHzKKSPGMinaOyqHcLS5L0va1W5v8LSltW2xtElcqahI7eCNZXI72i2aZH
TB6APLeQqlCStsDLWGVGWBFO2c8mYH/Ww42UyI7YSTVpQOf4O7oLrkG/5d2WZqGB
8qYnaoomGsCl6Npi9wzDZ9FWK6PTa2KaovEp9EiwzA9NHVZ2OyHg5IXZBwMiz8BY
GvvNXIphQXU=
=yc6U
-----END PGP SIGNATURE-----

--==_Exmh_1618171662_13593P--
