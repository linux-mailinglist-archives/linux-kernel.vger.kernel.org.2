Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93B633A4F0C
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jun 2021 15:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231384AbhFLNEA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Jun 2021 09:04:00 -0400
Received: from mail-pf1-f172.google.com ([209.85.210.172]:40666 "EHLO
        mail-pf1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231308AbhFLND4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jun 2021 09:03:56 -0400
Received: by mail-pf1-f172.google.com with SMTP id q25so6757527pfh.7
        for <linux-kernel@vger.kernel.org>; Sat, 12 Jun 2021 06:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xeSBCu+uwcJ05fSkhJHXg1zNQzVlfMfV4I6++0CIf8c=;
        b=ZKBZFM50TisO/aqQFJWnR5GVRJnLFYduYkIWGaG/z7z4Ib4YnR4m299m42eK39a6gz
         cjxk5PesKYwRfHZviurcymrzUOGhUCevqJEkAVZmwGDUQUUJc5m7qkrIZrG2/4jTysLA
         N6kjK86TQ8GAAyq0XFO/SGmIm+YQU8OAzJWUV516DWBceIc7g3illi4aRlQNHSTNpexO
         h1zW59OQ/A9W8GxspUU9xzYvxzj7wi44c9iXBqKeLjIrn/TE80pNV+R3CsHT1wC60syc
         2yVeh5phFd7a0iZRwjvbB2y7LmBihTYhzmlabKLI18VxgoX4RrHv2235/mAI265EPpAx
         +quw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xeSBCu+uwcJ05fSkhJHXg1zNQzVlfMfV4I6++0CIf8c=;
        b=XFF/luEOnX6L2KBE0XW6CkJ9P2RP65kewzaJ53NKCuC1bNWWN6xsEsZY4xrzPMaKfS
         lWiJxL+ln3gPL187+l0GoOa+KHQKOJd3nWXVwnkvYey5WBOh9tKIAc1bwZumwdoyeZMz
         jfBcerfQgLiAsYvKpACJ5j33cprMl18Jgp545YzvhvA29UTslsdmBz3KagbJE88wpbGP
         veuj1Hr0cSvq4QP8yVUCPNcbD9C+x8S5T2qyFZw/A+LdPuWTvPcz1Zm+xI4npEGZJVAy
         Tmi4/eLg2QJsh+h0ZYcc3ebr8NwmDyL/aAs658olvp5pjC6bOToVhFefPSBa45YXZqVt
         B2iw==
X-Gm-Message-State: AOAM532BN6Gb+AdPV0OFsHqYnS3226V4QqR6+TzinMcSTTP5hzzDNwhR
        fIcg3vshEHxQgJl/sUYEdl8=
X-Google-Smtp-Source: ABdhPJzrVrNNjgCV7VEDzyZYSenC/pNROhy5Ou2U2iNywG2ATntpjXcizwpoW81F/Jm3ssQIYkmKVA==
X-Received: by 2002:a62:31c7:0:b029:2e9:2c05:52d3 with SMTP id x190-20020a6231c70000b02902e92c0552d3mr12954760pfx.78.1623502843431;
        Sat, 12 Jun 2021 06:00:43 -0700 (PDT)
Received: from localhost.localdomain ([117.222.175.26])
        by smtp.googlemail.com with ESMTPSA id r6sm12595107pjm.12.2021.06.12.06.00.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Jun 2021 06:00:43 -0700 (PDT)
From:   arjuncr <arjuncr00@gmail.com>
Cc:     arjuncr00@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH] fix for kernel codig style problems line after variable declarations
Date:   Sat, 12 Jun 2021 18:30:17 +0530
Message-Id: <20210612130017.7955-1-arjuncr00@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

checkpatch.pl detected kernel coding style issues (blank line after variable declarations)
in drivers/accessibility/braille/braille_console.c, so fixed the same by adding the black line
after each variable declaration

Signed-off-by: arjuncr <arjuncr00@gmail.com>
---
 drivers/accessibility/braille/braille_console.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/accessibility/braille/braille_console.c b/drivers/accessibility/braille/braille_console.c
index 9861302cc..a0656c6b5 100644
--- a/drivers/accessibility/braille/braille_console.c
+++ b/drivers/accessibility/braille/braille_console.c
@@ -225,6 +225,7 @@ static int keyboard_notifier_call(struct notifier_block *blk,
 	case KBD_POST_KEYSYM:
 	{
 		unsigned char type = KTYP(param->value) - 0xf0;
+
 		if (type == KT_SPEC) {
 			unsigned char val = KVAL(param->value);
 			int on_off = -1;
@@ -264,6 +265,7 @@ static int vt_notifier_call(struct notifier_block *blk,
 {
 	struct vt_notifier_param *param = _param;
 	struct vc_data *vc = param->vc;
+
 	switch (code) {
 	case VT_ALLOCATE:
 		break;
@@ -272,6 +274,7 @@ static int vt_notifier_call(struct notifier_block *blk,
 	case VT_WRITE:
 	{
 		unsigned char c = param->c;
+
 		if (vc->vc_num != fg_console)
 			break;
 		switch (c) {
-- 
2.25.1

