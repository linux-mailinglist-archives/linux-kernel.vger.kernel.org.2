Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B07623E86B7
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 01:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235374AbhHJXvW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 19:51:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235517AbhHJXvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 19:51:14 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72E7BC061765
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 16:50:50 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id r7so442900wrs.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 16:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dgCC0YOf7alekbi8MdvlXK56+sDB+GJd5c/lxkOlPuY=;
        b=Q2xnzjETCg53ufHwPhf5vy+CyZD0S2aQ0xhvEwatgEly2lXL5vzSv4obL/OVqKYZYO
         TkUDycDsHa81Ml2Tz10JMvaDp0P83I6G0eVpOBGCScRPxJL+KNogw/pMddk5Hnj2lqIz
         jpTALSvIm0lPjicGyOiWs9t5F+5y7KF3tH6OylscdI94IHCm1pBrRJULqCagyhdDqezN
         A/E7uJBejjKADUA0YihLAal/tAwQ7mLi6eJH66O1ZA9n8jz6YKs5WHbFgkpwUA7rC341
         PW10LcOH3YHI474zs1RVwdhuUelI+CFPlYuUulpRt5lBAAQHmE4Ouzlru3II8bU5QYmA
         hdsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dgCC0YOf7alekbi8MdvlXK56+sDB+GJd5c/lxkOlPuY=;
        b=qVe6MjSxOLowyOT3pWU9owAMEu1E1pyKlVNIfxAbIsifhTYFt72Liu05C5ijE8TXmQ
         +PGjMybMy8ov2cbR5hOR6pkK8uzgZ25w4Z3DoHzS+hdQ2/WFbRkQW5K8+e0VEkCxugLw
         fm7bOTF9qEf1bqMCeZy6cVPmfubxq8dSC4jGM62VDFq21LkUb4AOjya5Nvdcea3AjZ/b
         +BnpooSOA0xojdfNYhW1qlUz4oTPkDFG46x1+YD8wQyAMQ/Gazf7qBiEQvCwf/Eitgf4
         5IybGj+WjoTjiPmzniZc+HdktzFPw5JjO/42VU6+X/62mfEFG0MdRWwdOfkIthDlMgKK
         CeuQ==
X-Gm-Message-State: AOAM533eM/6exTk+XGbZUUV95rplL2se23ru/Fajs9rqB2j1q0xjNHm0
        ZsSM+9VRLjC3sWjfX6qDg37AQcYFBYW8pTwkNU4=
X-Google-Smtp-Source: ABdhPJzeoZqIhDhczyejSeuRem2SFcX2ZP3zOnekVu2KDDeUdi+VgMktKpXbigx4ZxIQguPP30a45w==
X-Received: by 2002:a5d:5302:: with SMTP id e2mr20151107wrv.47.1628639449094;
        Tue, 10 Aug 2021 16:50:49 -0700 (PDT)
Received: from localhost.localdomain (3.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16::3])
        by smtp.gmail.com with ESMTPSA id p14sm13881220wro.3.2021.08.10.16.50.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Aug 2021 16:50:48 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/8] staging: r8188eu: cleanup several warnings
Date:   Wed, 11 Aug 2021 00:50:39 +0100
Message-Id: <20210810235047.177883-1-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series does a lot of cleanup, and came about due to me noticing
that the Makefile contains several lines that silence build warnings
about unused variables, functions and so on.

It accomplishes does three things therefore:
(1) Removes the unused functions no longer called by rtw_ioctl, which
    was deleted in a previous patch (with the exception of the android
    code, which I will add back in once ndo_siocdevprivate is merged in).
(2) Cleanup all build warnings resulting from removing the offending
    Makefile lines.
(3) Remove the offending Makefile lines so that future build warnings
    can be caught locally before submission as well.

Phillip Potter (8):
  staging: r8188eu: remove unused functions from os_dep/ioctl_linux.c
  staging: r8188eu: remove unused oid_null_function function
  staging: r8188eu: remove unused label from recv_indicatepkt_reorder
  staging: r8188eu: remove rtw_mfree_sta_priv_lock function
  staging: r8188eu: remove unused variable from rtl8188e_init_dm_priv
  staging: r8188eu: remove unused variable from rtw_init_drv_sw
  staging: r8188eu: remove unused variable from rtw_init_recv_timer
  staging: r8188eu: remove lines from Makefile that silence build
    warnings

 drivers/staging/r8188eu/Makefile             |    9 -
 drivers/staging/r8188eu/core/rtw_recv.c      |    2 -
 drivers/staging/r8188eu/core/rtw_sta_mgt.c   |    9 -
 drivers/staging/r8188eu/hal/rtl8188e_dm.c    |    1 -
 drivers/staging/r8188eu/include/rtw_ioctl.h  |    6 -
 drivers/staging/r8188eu/os_dep/ioctl_linux.c | 1538 ++----------------
 drivers/staging/r8188eu/os_dep/os_intfs.c    |    1 -
 drivers/staging/r8188eu/os_dep/recv_linux.c  |    2 -
 8 files changed, 127 insertions(+), 1441 deletions(-)

-- 
2.31.1

