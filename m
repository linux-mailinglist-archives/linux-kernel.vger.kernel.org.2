Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F77D3774A0
	for <lists+linux-kernel@lfdr.de>; Sun,  9 May 2021 02:01:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbhEIACN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 May 2021 20:02:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbhEIACM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 May 2021 20:02:12 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3917FC061573
        for <linux-kernel@vger.kernel.org>; Sat,  8 May 2021 17:01:10 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id t1so1853048pgl.4
        for <linux-kernel@vger.kernel.org>; Sat, 08 May 2021 17:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mforney-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=g0la/JQhMAVZpR+/qBdBtenDxzsBy0/Dhn2mh0dOf1A=;
        b=mH+5y5RGY6mn15Qc/g9gfOaLd1Jbwt8/j463Q6HGkSOqK2+jRKmTd5fl2Z9+ukOAPM
         vu3I0BhvC18VxJGecY26ftnq8K14Q2v0JCVfFQ1C0naXaq8P9F1WpsWv1JkVLwv9B+Um
         10IqRpGV70H4bMg+fFjGUoGl1wWuiwiygZWU55hPYQq1ToczIa9686brfyszT/IJS7JE
         c7hxm4USTjN1qfViv7q91jAIups9QoWDMNB7urhYDDIkNBr02IxGUcYtb6N2VMMcwus/
         hs0ViiyNCK7+kmahJX08cU/lPheyLdna2jeg4xe7cnTaKXAhNfEIb4x6wkVivfbvruOw
         V13A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=g0la/JQhMAVZpR+/qBdBtenDxzsBy0/Dhn2mh0dOf1A=;
        b=GYCQIdlarQPP/UCH1ciTLWI7vKU92rGRnnZphZbfqWn1xz20yDmiqVxQZqO8m/X10V
         aqXVh12lusECvD8JZb7diImsPUq1s0KV1aWLZRvZcB/JpwMKjMzb1okVTH8afvXe2CsJ
         7HXSSz1qR8fFsjgWOY7hXEK9wEiyxKhUWVItELRwC2ii1hAZbjfCxP04A11fGjaWdfN/
         oc1aqNFvvVgzPbeSGBjGYw6+dARY60Uks+uLfLxDKK3NFjsuTdf3cI/qicUp6n4EuKVL
         8Q0j1yy+HPkxUkzvecljuTe5IytRc/eoIt5/Ve6vniyhoyiwADz/yaZc7lMpT7uL0E+N
         oEqQ==
X-Gm-Message-State: AOAM531d5EdhbSKYRKFL0nsvWzsKZysCNMrWfHxnsyW2BEzxRPxAOgWX
        UT+rMk5e8TlqzZjLfX5tndJRWA==
X-Google-Smtp-Source: ABdhPJxh6VPBEO5ig0RwulnzCmUD1KoQ8NyNTKBg5oEph38nGPCXB9UXA/Zw4wtt093ZagTUC8FfBg==
X-Received: by 2002:aa7:870c:0:b029:2a1:f060:f17d with SMTP id b12-20020aa7870c0000b02902a1f060f17dmr13651191pfo.24.1620518469542;
        Sat, 08 May 2021 17:01:09 -0700 (PDT)
Received: from localhost ([2601:647:5180:4570:16dd:a9ff:fee7:6b79])
        by smtp.gmail.com with ESMTPSA id 21sm4464276pfh.103.2021.05.08.17.01.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 08 May 2021 17:01:09 -0700 (PDT)
From:   Michael Forney <mforney@mforney.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] objtool: Check for gelf_update_rel[a] failures
Date:   Sat,  8 May 2021 17:01:02 -0700
Message-Id: <20210509000103.11008-1-mforney@mforney.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Otherwise, if these fail we end up with garbage data in the
.rela.orc_unwind_ip section, leading to errors like

  ld: fs/squashfs/namei.o: bad reloc symbol index (0x7f16 >= 0x12) for offset 0x7f16d5c82cc8 in section `.orc_unwind_ip'

Signed-off-by: Michael Forney <mforney@mforney.org>
---
 tools/objtool/elf.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index d08f5f3670f8..b396ee4ab85d 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -953,7 +953,10 @@ static int elf_rebuild_rel_reloc_section(struct section *sec, int nr)
 	list_for_each_entry(reloc, &sec->reloc_list, list) {
 		reloc->rel.r_offset = reloc->offset;
 		reloc->rel.r_info = GELF_R_INFO(reloc->sym->idx, reloc->type);
-		gelf_update_rel(sec->data, idx, &reloc->rel);
+		if (!gelf_update_rel(sec->data, idx, &reloc->rel)) {
+			WARN_ELF("gelf_update_rel");
+			return -1;
+		}
 		idx++;
 	}
 
@@ -985,7 +988,10 @@ static int elf_rebuild_rela_reloc_section(struct section *sec, int nr)
 		reloc->rela.r_offset = reloc->offset;
 		reloc->rela.r_addend = reloc->addend;
 		reloc->rela.r_info = GELF_R_INFO(reloc->sym->idx, reloc->type);
-		gelf_update_rela(sec->data, idx, &reloc->rela);
+		if (!gelf_update_rela(sec->data, idx, &reloc->rela)) {
+			WARN_ELF("gelf_update_rela");
+			return -1;
+		}
 		idx++;
 	}
 
-- 
2.31.1

