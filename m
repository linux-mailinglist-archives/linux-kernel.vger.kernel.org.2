Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 909FA4241C8
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 17:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239311AbhJFPuG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 11:50:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239289AbhJFPuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 11:50:00 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67C15C061760
        for <linux-kernel@vger.kernel.org>; Wed,  6 Oct 2021 08:48:08 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id v25so10165094wra.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Oct 2021 08:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ftzLlllyl3Cvz8eT97rYOmOeAlPMvdEchXU1Vd2paWY=;
        b=byPVGGqRgqqp85lR/VHN9Ch5DwTZrcMBEwFulyG9DcFSpyxyzsAq6wF3gzIE9Gd4Gd
         T5c65XjQ2GakMwx7LHc45OZwNjNh76st7dQtU7CvmI4Sm5jgh5Wk41bnz6uZT8nNwXlC
         Ut70qfQciu0pLkxGP0nQysceHNOJw1hwnVcEYjA8NRb8pQpR/YPGJSOwyaUO+eBgonHS
         TgPp523oNd05FJqnD18ya3Cij2amD/Fs8uCGPNUbNt6DRpy6UtGvvHb7ruZW6rgav1wi
         shci0qfB5/whKqCdns36qGedg0k63pdUaoA6NxJ2mwRWny2SKKx57+ewSt6mLmj95s9C
         Wq0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ftzLlllyl3Cvz8eT97rYOmOeAlPMvdEchXU1Vd2paWY=;
        b=mn+4WxoNgRldJo+w4ds8SUaPJpXmzKnCLfoJqawldj7R1LfLeZ7yVe9ivwzwcjqqE6
         bgqhSLwkSJRXguMPNC6+10Ww7kPLRqPbS6ScwQMpox9DNIUWSOr6rCxZyxfpeamtS2jT
         sJXzlK5lT45kpgTssiM2HSEk5Qkbdf3Vs4ug7+2s+MsUaj28pcRm8RHARCUU0tc6kmU2
         T6Nm7kKRBAJAH6ggJWxuWzcQliO6qd1jED/sQqjTLYVjYZu0RoUFXfg5PgvlSf9CavWE
         ArjYVvju/LI8dljYYYSp6Oc96K3NGIatrEDgvpnLu99/UWr0o99nsNDw9XRngPb3QPlT
         Arkg==
X-Gm-Message-State: AOAM530BmqyhvRwt/XLOmoAfCK9bS3gBAAkNGq3FABIs40EHRVHFT1O8
        1hjUD0zkLOYMlW+BSyJJzRI=
X-Google-Smtp-Source: ABdhPJyOxX6ztHk2yLqq0WoHeXNaz8oY/d1LpuSobYK+pQWvLzSdAGpkghkqVmIvsycV7w+A7gHG2w==
X-Received: by 2002:a05:600c:1548:: with SMTP id f8mr10776791wmg.70.1633535286975;
        Wed, 06 Oct 2021 08:48:06 -0700 (PDT)
Received: from localhost.localdomain ([197.49.35.129])
        by smtp.gmail.com with ESMTPSA id j6sm7769854wrh.76.2021.10.06.08.48.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 08:48:06 -0700 (PDT)
From:   Sohaib Mohamed <sohaib.amhmd@gmail.com>
To:     sohaib.amhmd@gmail.com
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daejun Park <daejun7.park@samsung.com>,
        Bean Huo <beanhuo@micron.com>, Can Guo <cang@codeaurora.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Avri Altman <avri.altman@wdc.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Documentation: Fix typo in sysfs-driver-ufs
Date:   Wed,  6 Oct 2021 17:48:03 +0200
Message-Id: <20211006154804.135184-1-sohaib.amhmd@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove repeated word: "the The amount"

Signed-off-by: Sohaib Mohamed <sohaib.amhmd@gmail.com>
---
 Documentation/ABI/testing/sysfs-driver-ufs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-driver-ufs b/Documentation/ABI/testing/sysfs-driver-ufs
index 863cc4897277..57aec11a573f 100644
--- a/Documentation/ABI/testing/sysfs-driver-ufs
+++ b/Documentation/ABI/testing/sysfs-driver-ufs
@@ -983,7 +983,7 @@ Description:	This file shows the amount of data that the host plans to
 What:		/sys/class/scsi_device/*/device/dyn_cap_needed
 Date:		February 2018
 Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
-Description:	This file shows the The amount of physical memory needed
+Description:	This file shows the amount of physical memory needed
 		to be removed from the physical memory resources pool of
 		the particular logical unit. The full information about
 		the attribute could be found at UFS specifications 2.1.
--
2.25.1

