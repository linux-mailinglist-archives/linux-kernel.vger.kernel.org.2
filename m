Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38AD33EDC6D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 19:31:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230468AbhHPRba (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 13:31:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbhHPRb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 13:31:28 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C0CAC061764;
        Mon, 16 Aug 2021 10:30:57 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id bo18so27801071pjb.0;
        Mon, 16 Aug 2021 10:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VP+eubdHmfYuTi6QpmNnL4B6wcDcDfihaHnsfenCB6k=;
        b=TMkvkR3GYovJUP5F0TPoEsu4NRVOZc1VE8bvb6JlO10YYNfewIf/FWtBUDMOBhqPDx
         X4iXPmIYC4luV1lMnqzUqTSmqpqSY0RfM2W9jqLJRYLXJfI4O3uMj8+vatfJJq2gI9md
         ndpD1vOVAYufkLR2vyIIN/48EjVzTnvK4kAitHR9C1phwOjpWaBUVin2iyYHc4RneQRH
         gDjxNQMHd/uktxsNVyOdjJDfKsleAFpRzGBiNHbDtIQLDbUV+D6X+11w1Z4FuWwsr2NW
         FcdxHLdQF4ZzCDItbotw7d1L9HtnQCsIp1nkwGB+y80vdSk0bD0NntqLpFGygGB7MUDM
         wdBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VP+eubdHmfYuTi6QpmNnL4B6wcDcDfihaHnsfenCB6k=;
        b=fPt/pUcpAWgGRciQXZKcIQhKohYTpN9KcFbKcHM+NmuIE8UBV7hHn+PKAJS4vh9Kgl
         J3I47cEOzmNIuo0dGFMZ4hYQ8WvprOiGjj6DsMT6OzytDHnM+RWflvubhgKbXdb1fnhE
         yeOJb8xU+vT04rTI1OcTQHVMuwktcF0TWC2zpn3HOOEXhOS1Z43wgRi5UNX1bnmqlmBq
         7f63jW/A3TnL4EKHkkGsu4oVDWzSMjLWxg/ZgWUTvIIrD+uxL7c+0r50MM2ObzfnQCds
         IT2GiI/nTtff617Eldi2w/ISqJpAPaJa9oshFWnO/9WJm8/zeMwEi6kM5GnE7fg6owOJ
         SecQ==
X-Gm-Message-State: AOAM532ycSYQ+7VeKhGLegUwntb7dtMRX08khtyuxGn8AgOb2d6K3x24
        9nBBkoRRkobm5q3oRVy6Pik=
X-Google-Smtp-Source: ABdhPJzxaxJtLDZgOuqAyKjy/QocGK2rUubx5xbdnhcIVTEmslPpsNW0hjRLF6hu9HkL9yzSh9tE/w==
X-Received: by 2002:aa7:9d84:0:b029:3c5:72a7:bb08 with SMTP id f4-20020aa79d840000b02903c572a7bb08mr17265512pfq.45.1629135056597;
        Mon, 16 Aug 2021 10:30:56 -0700 (PDT)
Received: from xps.yggdrasil ([49.207.137.16])
        by smtp.gmail.com with ESMTPSA id z1sm17146pfg.18.2021.08.16.10.30.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 10:30:56 -0700 (PDT)
From:   Aakash Hemadri <aakashhemadri123@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        Bjorn Helgaas <bjorn@helgaas.com>,
        linux-staging@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] staging: rtl8732bs: Fix sparse warnings
Date:   Mon, 16 Aug 2021 23:00:41 +0530
Message-Id: <cover.1629134725.git.aakashhemadri123@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset fixes the below sparse warnings

rtw_security.c:72:50: warning: incorrect type in assignment (different base types)
rtw_security.c:72:50:    expected restricted __le32 [usertype]
rtw_security.c:72:50:    got unsigned int
rtw_security.c:80:50: warning: incorrect type in assignment (different base types)
rtw_security.c:80:50:    expected restricted __le32 [usertype]
rtw_security.c:80:50:    got unsigned int
rtw_security.c:124:33: warning: cast to restricted __le32
rtw_security.c:509:58: warning: incorrect type in assignment (different base types)
rtw_security.c:509:58:    expected restricted __le32 [usertype]
rtw_security.c:509:58:    got unsigned int
rtw_security.c:517:58: warning: incorrect type in assignment (different base types)
rtw_security.c:517:58:    expected restricted __le32 [usertype]
rtw_security.c:517:58:    got unsigned int
rtw_security.c:621:41: warning: cast to restricted __le32

This can be applied cleanly on next-20210816, and is compile tested.

Aakash Hemadri (2):
  staging: rtl8732bs: incorrect type in assignment
  staging: rtl8723bs: cast to restricted __le32

 rtw_security.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

-- 
2.32.0

