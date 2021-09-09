Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E26D405CA0
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 20:09:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243353AbhIISLF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 14:11:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242709AbhIISLD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 14:11:03 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9368C061574
        for <linux-kernel@vger.kernel.org>; Thu,  9 Sep 2021 11:09:52 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id f2so4380019ljn.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Sep 2021 11:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AB61zsK+RFLEdyaoe9KR+20N8SgtCfi8JZyiKRinXAk=;
        b=dm0TfN8BgHSqqqVA8lnL7eqFLdStV9hpOtUIENtwBaPaJelVeQD8FrsxB9iMnYGjay
         yyC9P0aLvs1AmIQk6ynvwj4vi5wI9v1MmaGxdKX4R4oeOF2JEI9p1uNjqRzyhzhmo9n/
         U71eXCqRgRDVzs382aOmBOVdJkYmCnnGGkS5opNXKdixs5Q3A4+Vwj9WmUKwEwhG4HQP
         QVGPMwSW14j5LxrZJsPFj+wGlQiSVYpl8dYq92kLL0GgvQD3Tsh7AdIGMCEEGHu48A2h
         rxZOOUSO1TSpRzjcvpRDY/sZZI0dzZBKyeiijvbDPK5SEYTVNHWPqBqeRCjcB+0u81Ud
         whMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AB61zsK+RFLEdyaoe9KR+20N8SgtCfi8JZyiKRinXAk=;
        b=7+bENCN762z3LPBKQeSHHtk+IGs6Ts8hfaQeUFBbNLBZApdr+OagnYpxWN06UIryvu
         W48q0u+muY41ZNA68Ql+EqcxPNMtx6TtWASuY8aOdvT15b+HAQ7nNbh9sk/egczrxxt+
         igICdjmI3IlNjjQKpxf3rex8unBNDrlfC+2gbjk/jDp+tmzCpSGvLdciL1P0yugrlzpL
         63itnkZEPtTSs92T7dTdBdB5RZ8fumNXzVJkJYCty89LF++xzr/GgHB4mB2nI6mpXtiH
         K+xufZi39vVTKZrQrUhmiaZYYtAnkHIiZqnw10rrqMuQm6YBkZQ5JhUcA+LVDCWfJyZF
         y+sA==
X-Gm-Message-State: AOAM533kfTmY4XZPjxstZ2ncfrYC+F2egFx8ZDSfG3RPd+mP94v5sCop
        rLhA0tWBvysUdZH/J4Ge9rw=
X-Google-Smtp-Source: ABdhPJxBD7xsOHwsxthzYDI7T7Q63R6eQMvs8VSCRs4tvENHKqkwTtMJJPEMiLg9XN4JtUX2CD7zFQ==
X-Received: by 2002:a2e:a903:: with SMTP id j3mr911508ljq.347.1631210991177;
        Thu, 09 Sep 2021 11:09:51 -0700 (PDT)
Received: from kari-VirtualBox.telewell.oy (85-23-89-224.bb.dnainternet.fi. [85.23.89.224])
        by smtp.gmail.com with ESMTPSA id u2sm270276lff.238.2021.09.09.11.09.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 11:09:50 -0700 (PDT)
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        ntfs3@lists.linux.dev
Cc:     Kari Argillander <kari.argillander@gmail.com>,
        linux-kernel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH 00/11] fs/ntfs3: Refactor fill_super
Date:   Thu,  9 Sep 2021 21:09:31 +0300
Message-Id: <20210909180942.8634-1-kari.argillander@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Two first ones are only ones that fix something. Everything else
just take off dead code or make it little bit cleaner. They should
be pretty trivial.

As promise to Christian, 10/11 makes one section cleaner as he
wanted [1].

[1]: lore.kernel.org/ntfs3/20210824113217.ncuwc3zs452mdgec@wittgenstein

Kari Argillander (11):
  fs/ntfs3: Fix wrong error message $Logfile -> $UpCase
  fs/ntfs3: Change EINVAL to ENOMEM when d_make_root fails
  fs/ntfs3: Remove impossible fault condition in fill_super
  fs/ntfs3: Return straight without goto in fill_super
  fs/ntfs3: Remove unnecessary variable loading in fill_super
  fs/ntfs3: Use sb instead of sbi->sb in fill_super
  fs/ntfs3: Remove tmp var is_ro in ntfs_fill_super
  fs/ntfs3: Remove tmp pointer bd_inode in fill_super
  fs/ntfs3: Remove tmp pointer upcase in fill_super
  fs/ntfs3: Initialize pointer before use place in fill_super
  fs/ntfs3: Initiliaze sb blocksize only in one place + refactor

 fs/ntfs3/super.c | 121 +++++++++++++----------------------------------
 1 file changed, 33 insertions(+), 88 deletions(-)


base-commit: 15b2ae776044ac52cddda8a3e6c9fecd15226b8c
-- 
2.25.1

