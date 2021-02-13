Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 695D431AB8B
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Feb 2021 14:16:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbhBMNPw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Feb 2021 08:15:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbhBMNPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Feb 2021 08:15:49 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C7D4C061574;
        Sat, 13 Feb 2021 05:15:08 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id fa16so1157486pjb.1;
        Sat, 13 Feb 2021 05:15:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Cn+ObC8FkHI1hXVsmi4O7zBtv2tqUAnYZVVASPYbG78=;
        b=Q/O0U2qxvyScJpNSCcH9bMDBaAgpuKjf4PYuf3L9D7a38xWtwY1s4ZpqRu3OfAmtb0
         IYKyZCMkI+4pvDLUeZEs4NfITlAYBCFQzRz/zm0xKcUOhKirSwRYOO/JKlUcDuwtT/mm
         UuoKxl6fCpqLw2SpPZjxdm7t4pWM/f9+iI4GksF6q70qp7PFovPVSDLAv0vc+3/tWEzY
         yvbIIV6HNVry5UjT/11HzwcnHZHcaXDEAEOIL8b2NKJ2lagNqoG4WXWbBJp3MYZiq+pc
         Sw+77COZxg/MiaEu4O6gdqxM06o9EprxWUaJ85woe8oMRIlBRk5oRStW0beEKozYF7kk
         ZxWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Cn+ObC8FkHI1hXVsmi4O7zBtv2tqUAnYZVVASPYbG78=;
        b=EZJEGtIXU1PkTT46YTTjt9urJdxur/DAV/kVtA/Xe4OarU7O5k3jpy87Oq4gbyp1YJ
         y5fN+DZauWf72A3RxJNSyvNeUkxWagON8eLXcBkHmS30GYOC0Ov1q4zCmQ/PaquYnrZo
         ZMQ4W3aagGQnKKAbmSazSlcLo0l6taG07YrRuCNp7fKfygplILGFTiy18IpMgcgbN0xz
         HF2d3Op63Wnx8LlTCAjqGXb2mkcfoYfnZ6YLznH4SoWTXoNmz699gObJPB0vPm5WCa9+
         9onUfZxUQt8EL8EbVw3gL3zQMCnNQKA8W4eiFi+9+ZUkubOFvwiODl8ymgYtSCNnpoNZ
         GaSA==
X-Gm-Message-State: AOAM5305895PRD66+QvTaWQmMa4eKFizz80bDr4/AgKePok/C58vf88s
        bG8x5qklpIO+DRy0gKX4Drw=
X-Google-Smtp-Source: ABdhPJwd77/eDp3WtWfgfrvnO+EJmxx+mN8I88ZjGkp7BnLxSYYuuo8U2G7rTG+LRZ+05Tym2GY1zw==
X-Received: by 2002:a17:90a:d3cc:: with SMTP id d12mr7164295pjw.202.1613222107708;
        Sat, 13 Feb 2021 05:15:07 -0800 (PST)
Received: from localhost.localdomain ([2405:201:9004:6ab4:5c97:80e6:be35:2e49])
        by smtp.gmail.com with ESMTPSA id p11sm833533pjb.3.2021.02.13.05.15.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Feb 2021 05:15:07 -0800 (PST)
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
To:     joe@perches.com
Cc:     linux-doc@vger.kernel.org, lukas.bulwahn@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org,
        Dwaipayan Ray <dwaipayanray1@gmail.com>
Subject: [PATCH RFC v3 0/3] checkpatch: add verbose mode
Date:   Sat, 13 Feb 2021 18:45:10 +0530
Message-Id: <20210213131513.51386-1-dwaipayanray1@gmail.com>
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

Changes in v3:
- Simplify documentation file parsing in checkpatch
- Document a total of 33 message types for checkpatch

Changes in v2:
- Use .rst Field Lists to specify the type descriptions.
- Add a few more type descriptions to documentation.


Dwaipayan Ray (3):
  checkpatch: add verbose mode
  docs: add documentation for checkpatch
  docs: add documentation for checkpatch

 Documentation/dev-tools/checkpatch.rst | 494 +++++++++++++++++++++++++
 Documentation/dev-tools/index.rst      |   1 +
 scripts/checkpatch.pl                  |  55 ++-
 3 files changed, 549 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/dev-tools/checkpatch.rst

-- 
2.30.0

