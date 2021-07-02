Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9209E3B9AEE
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 05:13:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234924AbhGBDQJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 23:16:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234675AbhGBDQE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 23:16:04 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8B9DC061762
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jul 2021 20:13:32 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id mn20-20020a17090b1894b02901707fc074e8so6995823pjb.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jul 2021 20:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4YObhcC5bySHXsDyUQk5glFoVkF17iUHMGsgPLSvLws=;
        b=AipvaE0LvmeqoSROhkCYkHCnYKglatDP/rqX+bgniQAT7JRXaUsKv1gwgbXUL8BO7u
         BSLN9NxVOuAjqD8quQRdZVIlnP2SLD1ccvKNAMPJNvNtF5dKR6dazM0WWa/sM2sRjmg2
         IY8d5GLS5U4O3lLZZoan4G74vtS/b8VdnQjZAJhzl3uj2QCFabmfxRrede6oKHA8/DQ2
         Cqrixv2M+F38FDqIsBRnW8y0E6bn4GPvELCKOqUbCpe2jmgjuvr+ZGbL0PsFB1ZrY80F
         CZzDfn8r8RSckhGUnslU4sueJzFqWztKV/sftYhJsbBVs5IFi19BxI1UYx0W6TtnumAp
         mceQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4YObhcC5bySHXsDyUQk5glFoVkF17iUHMGsgPLSvLws=;
        b=VueuaBMrYh16VDph+00zWpewXbZUiKDlbPAd9/Vzup/09s/nCbamXZoWkmOlHy+tmB
         3wfWI5xLC2pYiZ6zqnUk5je8GAY0sLx0TPq5eaE/BojHHbgDzfzxoHNsBpHw30Ra+aRk
         4vMyPlzEnM6LRH1gjV/zZqW3iF9pDehlgU/ztEJEvEOjj9R47FKV409Iyi50XwUHuSwW
         kUHojMVL4EghfRiLuTGA6XKPCgAI/c57+gnVADiam3qt3RjKE6Qbr6+SWfvYVXXsa4Ex
         gSA71DzjBWUel0aK1gSbAxkQIPEB9+l5NSliIwQpGt/haSpbpepnhLnlQcco1KxPHKFW
         RbGA==
X-Gm-Message-State: AOAM531rCrji0KXeRiELEJHGgTx4WlWWCirK9uvOzNVVxzrcdVFJgBbX
        ufOBfyh3lAuSuwFbqHyAi853PHqAibN0WSYj
X-Google-Smtp-Source: ABdhPJwthcwYp5yuJqE3KSIHzMu/gRi+bf6zFjkf9Y/hbjCotAmVT3+xPKfqx0AKd+so/C8h24CTlg==
X-Received: by 2002:a17:902:e848:b029:129:2e87:9944 with SMTP id t8-20020a170902e848b02901292e879944mr2467846plg.27.1625195612248;
        Thu, 01 Jul 2021 20:13:32 -0700 (PDT)
Received: from ubuntu.localdomain ([218.17.89.92])
        by smtp.gmail.com with ESMTPSA id q24sm1460440pgk.32.2021.07.01.20.13.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 20:13:31 -0700 (PDT)
From:   gushengxian <gushengxian507419@gmail.com>
To:     jpoimboe@redhat.com, peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org, gushengxian <gushengxian@yulong.com>
Subject: [PATCH] objtool: avoid Memory leak: orig_alt_group
Date:   Thu,  1 Jul 2021 20:13:27 -0700
Message-Id: <20210702031327.559429-1-gushengxian507419@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: gushengxian <gushengxian@yulong.com>

free(orig_alt_group) should be added in order to avoid memery leak.
Reported by cppcheck.

Signed-off-by: gushengxian <gushengxian@yulong.com>
---
 tools/objtool/check.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index e5947fbb9e7a..deb48b1bc16d 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1097,6 +1097,7 @@ static int handle_group_alt(struct objtool_file *file,
 				     sizeof(struct cfi_state *));
 	if (!orig_alt_group->cfi) {
 		WARN("calloc failed");
+		free(orig_alt_group);
 		return -1;
 	}
 
-- 
2.25.1

