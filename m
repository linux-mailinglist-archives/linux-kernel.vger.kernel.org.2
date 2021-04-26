Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0F6C36B2F5
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 14:21:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233392AbhDZMVy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 08:21:54 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33736 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233348AbhDZMVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 08:21:44 -0400
Date:   Mon, 26 Apr 2021 12:17:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1619439661;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=dCWJYtHM95pK/VniFX8rXnCIKHyPPowJIQiIy16SLTg=;
        b=SJGQDK6uJ8VK8sOpUbWQdwE7z/FiCU6wAOJD5+rY6kxQmnCjC3DzDGWoLxx1TkpDASlu3c
        ULpscKQLIL7SD6vFqr6DG5AfRSqsJWymquC0jNA6ZAMS0arIymuRWV7exbmZ8iAJKUVQO4
        coJzur8IHqvJOszImIjNPwh9LSsOBxXbnhSlEtTLff6flq06Fk13oe4ONUgvwgH6r9vVPE
        9q6kMEwyxUv+I1Th2T8zY0xlj7RvTKiDEnvBQ2BCwGvov3q4WZveP3iqvFQQQ8XMPI8Eu9
        GEPLj1gb1+ydG7A8glFIKQKp7JRnQEu6PMSqkcW4zFteBW07Gt8NgrWg0FMaXQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1619439661;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=dCWJYtHM95pK/VniFX8rXnCIKHyPPowJIQiIy16SLTg=;
        b=Q20T8a3gOP6Ev5iF97DTk0skGhJjBQQbgJDBTwR0E1vdBu2KxQMW/KFYrOq81gd+AURTNL
        7b4/+r8N8VJDQWDg==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] x86/vdso for v5.13-rc1
References: <161943945302.1498.9201552430413038175.tglx@nanos>
Message-ID: <161943945664.1498.12541012822712127877.tglx@nanos>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest x86/vdso branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-vdso-2021-04-26

up to:  70c9d959226b: x86/vdso: Use proper modifier for len's format specifier in extract()


A single fix for the x86 VDSO build infrastructure to address a compiler
warning on 32bit hosts due to a fprintf() modifier/argument mismatch.

Thanks,

	tglx

------------------>
Jiri Slaby (1):
      x86/vdso: Use proper modifier for len's format specifier in extract()


 arch/x86/entry/vdso/vdso2c.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/entry/vdso/vdso2c.h b/arch/x86/entry/vdso/vdso2c.h
index 1c7cfac7e64a..5264daa8859f 100644
--- a/arch/x86/entry/vdso/vdso2c.h
+++ b/arch/x86/entry/vdso/vdso2c.h
@@ -35,7 +35,7 @@ static void BITSFUNC(extract)(const unsigned char *data, size_t data_len,
 	if (offset + len > data_len)
 		fail("section to extract overruns input data");
 
-	fprintf(outfile, "static const unsigned char %s[%lu] = {", name, len);
+	fprintf(outfile, "static const unsigned char %s[%zu] = {", name, len);
 	BITSFUNC(copy)(outfile, data + offset, len);
 	fprintf(outfile, "\n};\n\n");
 }

