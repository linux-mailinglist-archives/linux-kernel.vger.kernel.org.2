Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FB7834AF5F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 20:33:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbhCZTcY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 15:32:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbhCZTbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 15:31:55 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC0B4C0613AA
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 12:31:54 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id y32so4138945pga.11
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 12:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5y4wrxyxaQbz2q52vNwehIEYnHf9nDITQlvj4U6GzGU=;
        b=KNeFUcGH6ynyK/I5cDYOwaA7AFBqlhTHFC/F6YAVNrY1ctngEm6TyxY4RfczcdmL1D
         BqCGN2BWY+Wj8G9dZbyMjX5X5nc221ASn7OC7xD1FCuO66r8BJ0XacL8hSpT47vU+thN
         5RtG+L2mI426nSsSE6mumL/B979em8FBaQf1bG7CbLkNBcCaVS11OZx0q+LSC8Dxb9SH
         ordZe6AmQnh8YYDED7ugAF6puzcoEa9wvH0PgydBSRKMcuvzFJsOeifpdBcgbZzhWLxn
         6xknOrAr+HMgflZaBmngy3kxnJaT7uUoUjLAtxfUDYJUg+4ShxEntMEgCrpui8ZXkcj2
         4t/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5y4wrxyxaQbz2q52vNwehIEYnHf9nDITQlvj4U6GzGU=;
        b=k58tTBhrJgzVXx7jvn/BFJcsyihAJfndD/qq5Wj2ELLOKpCTzCcw5RGuyQa8c4NhSZ
         bTG4FUJ/61i3vc7ZNezPonecvkkbydfyKZJyybdjC6/8xuWlB6L6SL3HhUkHFp58HGsk
         z8ugo1lm7KDOlLL9scLNV11Mw4AEyCDiCWBKwl2I2J75biaORK0nXsM8TEuk3Lw5LWcK
         zGLQOIbVTVIsncSJdNl6vRhF0pLX30XKeVKgXj7ZDFGs7ZdKhyy9mrTtgCrknPL9nZjw
         Yy5j1BHh325U4VtYnG3pELU9OvYVhOrAFmC/1Dk8KbNhwuoxDOWceWG9/Djyb5vQylzg
         7wEA==
X-Gm-Message-State: AOAM532ng5M+ICkQxyrNb73PHzaobsQC837L65oW8ejevjs5vg27m+bU
        MVovro/hh6xXc7c62VKOqiE=
X-Google-Smtp-Source: ABdhPJxQU5pDeMpZPb16W8XI/PtKmWycv3J/AOTFb84Yme1HRFGiuykBtcdBea8vw2M7vel/hCfZ6A==
X-Received: by 2002:aa7:9521:0:b029:1f1:b27f:1a43 with SMTP id c1-20020aa795210000b02901f1b27f1a43mr14388370pfp.4.1616787114363;
        Fri, 26 Mar 2021 12:31:54 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net ([2601:641:400:9e10:2d94:bd34:41ff:d945])
        by smtp.gmail.com with ESMTPSA id q10sm9086789pgs.44.2021.03.26.12.31.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 12:31:53 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-xtensa@linux-xtensa.org
Cc:     Chris Zankel <chris@zankel.net>, linux-kernel@vger.kernel.org,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 0/2] xtensa: add GDBIO implementation to semihosting interface
Date:   Fri, 26 Mar 2021 12:31:41 -0700
Message-Id: <20210326193143.21016-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

this series adds GDBIO implementation to the semihosting interface and
makes it a configuration time choice. GDBIO interface is useful for
development hardware platforms that don't offer any peripherals and only
accessible via JTAG. xtensa kernel built for ISS may be run on such
platforms using GDBIO implementation of the semihosting interface.

Max Filippov (2):
  xtensa: ISS: split simcall implementation from semihosting interface
  xtensa: ISS: add GDBIO implementation to semihosting interface

 arch/xtensa/Kconfig                           |  22 ++++
 .../iss/include/platform/simcall-gdbio.h      |  34 ++++++
 .../iss/include/platform/simcall-iss.h        |  73 ++++++++++++
 .../platforms/iss/include/platform/simcall.h  | 104 +++++++-----------
 4 files changed, 166 insertions(+), 67 deletions(-)
 create mode 100644 arch/xtensa/platforms/iss/include/platform/simcall-gdbio.h
 create mode 100644 arch/xtensa/platforms/iss/include/platform/simcall-iss.h

-- 
2.20.1

