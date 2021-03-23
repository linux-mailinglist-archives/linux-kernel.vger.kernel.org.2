Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91353345EB9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 13:58:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231494AbhCWM62 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 08:58:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231370AbhCWM6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 08:58:14 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED3D0C061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 05:58:13 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id bx7so23311715edb.12
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 05:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hWRwPMPyX/TOjV6wMeQIWCYqUEDrv7MaokSiTNE+z1Q=;
        b=EJX4dEYfgttXfvSIYC3NixLUAiCTc92+Wfpj0ft0JiMAppD2byG9JeeSGM+DmCV6vf
         Pu0C+a6ExiF8+/z+dwGxAvvIFOlwW5unWlFgIMS6jf+UO+DZsa/lZMgJfBM0nVhNOmnm
         poiY7wotFZVup44kG21ZBD/IzztcIDusNimsb+4IYrUURH7Nz2EU01d/KkKBU664gd9I
         GG/Xp4reD9X8lGf2LOZkQiv+HoLqD1H8I73Fsc+L37+910t1dBA6eVVfGVtbOY9J5PSU
         x3/av06lPkGLjxW38/VyKjFRBTNAx4faJrNRz7Y9NPeK1HMdz7qdjhd2gILywUYiSwlt
         oYBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hWRwPMPyX/TOjV6wMeQIWCYqUEDrv7MaokSiTNE+z1Q=;
        b=eVX0YhYOZAXgMhxEsWo1iShAxCm9O10y9dP34GKqwAkA4esstmF4qAcRNlpJ2PsR57
         Nj7jgnldbv0QKWzgbW4KKWlD19yj24VSpbjZuZOR0qW7SvR84d2y5CN7yjcSUM9RQ2F+
         rcvar6nSwlKTB785GOgku0qcYbH7Z+zw5ASPFZCYDbvo1llodfopFgzq5VLiQz4HY9QZ
         /vpI2Zdth6Ks+DOXj8tHgTUE6xkLPrvDodVPqwE06Iw1L+qyOcDYzfPQ+hgf3EFZ9oVm
         z2SDpAtxSl2SH9EhVNhBc60RilZW4MBPOCI9PeieWDoHc3eAsLv1ZgVfnzamunFvBpMZ
         DYAg==
X-Gm-Message-State: AOAM5305xECssbZHcfSAjNzOCgib4mtx7tYcaZtViqclzLItm5bE7Kiy
        Qp1+DbzYbQtLRXjAmcEJZLc=
X-Google-Smtp-Source: ABdhPJzlh9pl/Zz4UK/qFA8OMPYJ9G2G4rQRzaY5UlJCiSqDlwnk8XIKW8oH5f5cuppgrRpHjSQjTQ==
X-Received: by 2002:a05:6402:b70:: with SMTP id cb16mr4521183edb.11.1616504292747;
        Tue, 23 Mar 2021 05:58:12 -0700 (PDT)
Received: from agape ([151.57.211.10])
        by smtp.gmail.com with ESMTPSA id q26sm11184723eja.45.2021.03.23.05.58.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 05:58:12 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     joe@perches.com, apw@canonical.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH v2 0/9] fix extern declarations checkpatch issues
Date:   Tue, 23 Mar 2021 13:56:27 +0100
Message-Id: <cover.1616503354.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <YFjBHNkQFlFzZKpV@kroah.com>
References: <YFjBHNkQFlFzZKpV@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix extern declaration issues warned by checkpatch.

Changes in v2:
	- removal of prototypes when function can be static
	- move of static function defs inside file to let the code compile
	- split last patch in two patches (one patch for blank line removal)

Fabio Aiuto (9):
  staging: rtl8723bs: removed function prototypes in core/rtw_efuse.c
  staging: rtl8723bs: moved function prototype out of
    core/rtw_ioctl_set.c and core/rtw_mlme.c
  staging: rtl8723bs: removed function prototypes and made statics in
    core/rtw_recv.c
  staging: rtl8723bs: delete extern declarations in core/rtw_wlan_util.c
  staging: rtl8723bs: remove function prototypes in hal/odm.c
  staging: rtl8723bs: move function prototypes out of os_dep/int_fs.c
  staging: rtl8723bs: remove undefined function prototype in of
    os_dep/sdio_intf.c
  staging: rtl8723bs: remove unnecessary extern in os_dep/sdio_intf.c
  staging: rtl8723bs: remove blank line os_dep/os_intfs.c

 drivers/staging/rtl8723bs/core/rtw_efuse.c    |   14 +-
 .../staging/rtl8723bs/core/rtw_ioctl_set.c    |    1 -
 drivers/staging/rtl8723bs/core/rtw_mlme.c     |    2 -
 drivers/staging/rtl8723bs/core/rtw_recv.c     |  441 ++---
 .../staging/rtl8723bs/core/rtw_wlan_util.c    |    3 -
 drivers/staging/rtl8723bs/hal/odm.c           | 1717 ++++++++---------
 .../staging/rtl8723bs/include/osdep_intf.h    |    2 +
 .../staging/rtl8723bs/include/rtw_ioctl_set.h |    2 +
 .../staging/rtl8723bs/os_dep/ioctl_cfg80211.c |    2 -
 drivers/staging/rtl8723bs/os_dep/os_intfs.c   |    5 +-
 drivers/staging/rtl8723bs/os_dep/sdio_intf.c  |    3 -
 11 files changed, 1038 insertions(+), 1154 deletions(-)

-- 
2.20.1

