Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43300307845
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 15:40:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231271AbhA1Oio (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 09:38:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbhA1Oim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 09:38:42 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA6EEC061573
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 06:38:01 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id q20so4108347pfu.8
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 06:38:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4LE73ezSwns7mEEZC3LY3BMjP0QBXPnuGOU777vzw2g=;
        b=BX04WOkZExv7TRAaFZplmpDGyMPNryK6W9ScA55GjN24CYHEv46zvvWDw7mYkFjInF
         2FFVf4WQRMdpvaPU2s0TM2YBmOgUuXLOPtmSq8MxedzbvHnlMoJra6bJhFVnUycRuLdL
         k7cV+e1raSTGnILRW3G8nidhDBEdJo+LTEeSHWsyAl+cPzSb0CJjXloaPhdxkxVKEZKu
         pKVOQOIP5tLQwlA232B+k4LY3nBBDdIrZjSXoIvA8SSxMVNB31Xp6dIUT7n31KT+V5bJ
         5pWvZRaW5/cfuXcU2I1NOIHQzt/oyDdLGqRRUE2Si4JZ4wltVRs9eZ/+bQAcOGCEGtLH
         ALVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4LE73ezSwns7mEEZC3LY3BMjP0QBXPnuGOU777vzw2g=;
        b=Whm6pYA60AgB1LkM45HCYLDoGPbjzNT+ranqlEa4Qp+v02C5F77KKFb6okwKseZ+lj
         ArgZfQduteRY02wblkL9zmhS9iiU7dfRDNKbI3BlDk5A6GupuzmHlHES0fzLdfB1/nn1
         KCGIIf3zxiGMb+BzjB7i9uBYEceDHrlBmAHhEY3upO1bmH7RiDefZ1TOD1NkMcfD5g3Q
         WkHv7sUeqnLPjRnkUvustTJCaLjg1KgGrsg+3kRJeyjFQgzCOKeQI4XsVeV3RSxaWt9S
         mALievH1uLQWJAahZ8HMBBNc/QvV4qnNFbp3Cpk/0yx4Ri9d1TfolbpxfvwuhJNsDR0R
         fRoQ==
X-Gm-Message-State: AOAM531Is+8XpuAcIRp2fsAFosAT53alOkJ2GLgTu/jqcVCnZuO8/n/A
        LXdSMXtj2Qmx5tAVuxuvUcQ=
X-Google-Smtp-Source: ABdhPJz7LsUNiV8L2CnVB6SELDXnNVbeXfy0SfbPEc/djrRgCQejYLvvqqlN4zgzebatDaEjkTaxbQ==
X-Received: by 2002:a63:1a48:: with SMTP id a8mr16869291pgm.257.1611844681350;
        Thu, 28 Jan 2021 06:38:01 -0800 (PST)
Received: from localhost.localdomain ([2405:201:9004:686d:e9f6:a78b:e60e:9585])
        by smtp.gmail.com with ESMTPSA id w14sm5358621pjl.38.2021.01.28.06.37.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jan 2021 06:38:00 -0800 (PST)
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
To:     joe@perches.com
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        lukas.bulwahn@gmail.com, linux-kernel@vger.kernel.org,
        Dwaipayan Ray <dwaipayanray1@gmail.com>
Subject: [PATCH v2 0/3] checkpatch: add verbose mode
Date:   Thu, 28 Jan 2021 20:07:59 +0530
Message-Id: <20210128143802.15888-1-dwaipayanray1@gmail.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new verbose mode to checkpatch. The verbose test 
descriptions are read from the checkpatch documentation
file at `Documentation/dev-tools/checkpatch.rst`.

The verbose mode is optional and can be enabled by the
flag -v or --verbose.

The documentation file is only parsed by checkpatch.pl
if the verbose mode is enabled. The verbose mode is also
suppressed when the --terse option is specified.

Changes in v2:
- Use .rst Field Lists to specify the type descriptions.
- Add a few more type descriptions to documentation.


Dwaipayan Ray (3):
  checkpatch: add verbose mode
  docs: add documentation for checkpatch
  docs: add documentation for checkpatch

 Documentation/dev-tools/checkpatch.rst | 269 +++++++++++++++++++++++++
 Documentation/dev-tools/index.rst      |   1 +
 scripts/checkpatch.pl                  |  54 ++++-
 3 files changed, 323 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/dev-tools/checkpatch.rst

-- 
2.30.0

