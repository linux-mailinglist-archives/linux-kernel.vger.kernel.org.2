Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79B6935B467
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Apr 2021 15:16:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235575AbhDKM6E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Apr 2021 08:58:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235261AbhDKM6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Apr 2021 08:58:03 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA97BC061574
        for <linux-kernel@vger.kernel.org>; Sun, 11 Apr 2021 05:57:46 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id m3so11780111edv.5
        for <linux-kernel@vger.kernel.org>; Sun, 11 Apr 2021 05:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hQ3KhKNaIAv65viKNom5ztQKo1tKi9jzie9qsuyWYb8=;
        b=UKuQeDPkM/nzrybImZKMdqYUHtBhYlkZAuQC9Icqm3edP8axICFYup/p0eCwGAih1Z
         kgKqxSnlakZCxaUoagYWFzMYk8L848F/JK4XPH6loJWGIOekP21hZ9e2YFwH632VCcix
         dYZJmSHvs8fVE2MC4Zh019+ien2kPbxw9jJeo9veIjv7sCCKc8nks4/xK/6WVV/oJg9I
         qsfFeSbXjUOE+E2zD4mNU10Q5TMGVWI37FdFK+SUbvxxlVhXO2i4QRdnWrip5e1QHSEe
         uQ0HhA0Z+gO5D8Kz36VuheHUn9ht0fWjwAguAzDTZHMH/aqhFE6CQ1aVTg2H54kHicEK
         G97Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hQ3KhKNaIAv65viKNom5ztQKo1tKi9jzie9qsuyWYb8=;
        b=IPhtmQsc1EzTxN/X7yZ0vkEpr3+SBjKFKN9ym0xRA2foJh6O6KiyRpl3Cyau9iPSnd
         cS0gVwr/VNPYYeGWdjrDs186n5tYUCkxt4nPsk30gAwRwVpaQR74ht0wwFxHZG5r1EZ/
         MBCNq7WmhTu4lmGPOGpo6iMqM3K5MsMa74qP3G1amb8Hxl75OvT1TkZ6HN395vQHfS+2
         cAS7doBjqzafBkukbkQoMn5dZCRJbMouWGcxztT5kn3ZFtY+jNR6op6SUU/tCFGXtDuO
         Zh3mVhNRSInQaPVrCgwmtGL5RUZcov1Tu2QtcBOT++wl2FG0PmBYsZNVLkCaS7kEUek0
         K+7g==
X-Gm-Message-State: AOAM5305tmEitSMP/lgCC1rPl6/K54YNMlv1nAV6E4/Jes+tCRKLdFzX
        2ntBe9ge5fG/Y0ULSeuRL8TAh2mM6xQ=
X-Google-Smtp-Source: ABdhPJymfnWUqp7atG+xzSlCFf12VksRJBn5V/NQeqLTGrgW2XZDVaahFPO9kBu0uRdGCMdhgX9suQ==
X-Received: by 2002:a05:6402:84e:: with SMTP id b14mr25723849edz.194.1618145865398;
        Sun, 11 Apr 2021 05:57:45 -0700 (PDT)
Received: from agape ([5.171.72.218])
        by smtp.gmail.com with ESMTPSA id r17sm4708201edt.70.2021.04.11.05.57.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Apr 2021 05:57:44 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] staging: rtl8723bs: fix compiler 'W=1' warnings
Date:   Sun, 11 Apr 2021 14:57:34 +0200
Message-Id: <cover.1618145345.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset fixes some compiler warnings related to unused variables:

1. Removes unused variable after applying of
https://lore.kernel.org/linux-staging/99b111d2bac822b9dc7ff6e1cfd3d3efc62ef836.1618064275.git.fabioaiuto83@gmail.com/

and the issue was reported by kernel test robot:
https://lore.kernel.org/linux-staging/202104110133.bI35NiNS-lkp@intel.com/

2. Fixes two long lines checkpatch issues
3. Removes unused variable

Fabio Aiuto (3):
  staging: rtl8723bs: remove unused variable ret in hal/sdio_halinit.c
  staging rtl8723bs: split long lines
  staging: rtl8723bs: remove unused variable 'start' in
    hal/sdio_halinit.c

 drivers/staging/rtl8723bs/hal/sdio_halinit.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

-- 
2.20.1

