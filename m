Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D61974241BD
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 17:47:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239213AbhJFPtb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 11:49:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230014AbhJFPta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 11:49:30 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CFA1C061746
        for <linux-kernel@vger.kernel.org>; Wed,  6 Oct 2021 08:47:38 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id e12so10201327wra.4
        for <linux-kernel@vger.kernel.org>; Wed, 06 Oct 2021 08:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=f1b/nLUqBTIAqw2CYGf778oWxnnzueUfCpfxffs+nMY=;
        b=E6qzapzwH/PqRlUTm1YokUA35hWXCC2tSZtFeWtqyCJR05JPWJipOQ+JKouSVvpbRI
         +nGSQViJ1oa6jzlGWsWYLBo9DV9wcpVuo9ZQYwgzP+pejKh6tz2/vLbTyEZqQii6YTYX
         Htdz2J0bkzelzTmsZNs52O0me7p+8BWennIOPbqWDwKr2c3OkdrlVBWjyvGamTxS4Afq
         RyWgb7AvCxHDwA8TVoXQjijkBpCA8H2Km5Gs4pBklF1ozhzr+/mAxxeOoJPOgTOzkuxu
         inatar1XjrTF7U31D4gHMGUMBQaDSC8TByTF6t95pZBQHFm+k3I6Eu/cyFLyEbS12BwQ
         Tpgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=f1b/nLUqBTIAqw2CYGf778oWxnnzueUfCpfxffs+nMY=;
        b=Y5d28c5lk9TAUL219s2l5wfmB3+CozJ+fCaxsmukmgrkWjtSgWDeTONQHkoXoSHu/8
         4qXwhNLSzS3WBwuj+O842WD78jwtt1zoSoTPYQTl/I+LB0dFtbEYPLanBw+72Ov9P7i2
         yyH3CU3AstQEcCUf5cNZwtOJmb41C0BgZfWCBj0+yNfA7O5N5mvWQxdoz40aBRt1ckJV
         uRnjnHEHQg594eshDQu7r1KfZLXRRk3Phyf2aPKOpElC+ghWSMaJe+k190Ii7rvdhJTb
         ocednQBVluL3R/oHlOgaR6XiekCHa1X24jGiA3PXlLSXh1hXOvqHrKBqIxxk+FZvRbn/
         7q1g==
X-Gm-Message-State: AOAM532HE8zhACMVdBr4dqLUhbfARlOJlUjoZnUJuPgTZZFILTmb7AJT
        KfI22mJWMAy8N75lC4wbgdE=
X-Google-Smtp-Source: ABdhPJxs+cykwEoGc3tLzEI4FcCvKnDoYeKL5bDttLmn/0jXBXChIPqyYQcZ+IKuVqvEeSYjaCz6tQ==
X-Received: by 2002:a1c:7704:: with SMTP id t4mr10783512wmi.167.1633535256712;
        Wed, 06 Oct 2021 08:47:36 -0700 (PDT)
Received: from localhost.localdomain ([197.49.35.129])
        by smtp.gmail.com with ESMTPSA id z6sm8936054wmp.1.2021.10.06.08.47.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 08:47:36 -0700 (PDT)
From:   Sohaib Mohamed <sohaib.amhmd@gmail.com>
To:     sohaib.amhmd@gmail.com
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Documentation: Fix typo in sysfs-devices-power
Date:   Wed,  6 Oct 2021 17:47:33 +0200
Message-Id: <20211006154734.135100-1-sohaib.amhmd@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove repeated word: "the the children"

Signed-off-by: Sohaib Mohamed <sohaib.amhmd@gmail.com>
---
 Documentation/ABI/testing/sysfs-devices-power | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-devices-power b/Documentation/ABI/testing/sysfs-devices-power
index 1b2a2d41ff80..54195530e97a 100644
--- a/Documentation/ABI/testing/sysfs-devices-power
+++ b/Documentation/ABI/testing/sysfs-devices-power
@@ -303,5 +303,5 @@ Date:		Apr 2010
 Contact:	Dominik Brodowski <linux@dominikbrodowski.net>
 Description:
 		Reports the runtime PM children usage count of a device, or
-		0 if the the children will be ignored.
+		0 if the children will be ignored.

--
2.25.1

