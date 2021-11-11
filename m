Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A3C844DBA5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 19:34:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234044AbhKKSgx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 13:36:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233705AbhKKSgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 13:36:52 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF89CC061766
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 10:34:02 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id r67-20020a252b46000000b005bea12c4befso10431171ybr.19
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 10:34:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=DESeEF7SdR9UNYveOTPLprv35taR3AHUVFjTWAt72+s=;
        b=CanF6peffIh1bkeDS+6QZwFe/gVwt6sqLVD4E3sctTuUDeytoW8gei09i6qvDe/w5h
         /BiyidEWMsr/9HOeW1umDg8GI+uO3wG321IU92JS6wnmCckJmyq3GQpoyaDc5HfV9qne
         g/i9X8+npWWUDwP+aQBSJONS289xpO2ZTH8gu445SeA8O+7NgALvg2iC+WI/erolK0nx
         k51CqxjQ5VZlDzU4cDyI2XVWWAo/MDSSiO7nzJwZBOdlzeMq55lVNLtDojAYZ66P1hgm
         GbOrfftWCJMwXtxTX9nYvt7k8QY4y2HkIto7bjZzKE5qZSMz6/JhydWEBk83ehX13dtx
         1nPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=DESeEF7SdR9UNYveOTPLprv35taR3AHUVFjTWAt72+s=;
        b=N47eEJI0CQwXwA6fphj75ds5eAecCzEuP95ljAnCHhXK1YpMNoy62XvXTTqhRQAscE
         FDtgqz1hpjtMfT/SdPbkQ6FN2w1go98ia7ix13j4dtxMQL7bc/n91qYaksrwZ6/URYFx
         mEZjeisQ86gnpYOtXI6w+V1qFnoCImT197KTKQYVwAJIzrJmjKHx14esZvVsKC1rLze0
         2YfnY2SR1hBKjzz7G1S85qpY+b8nRUX+Jr7ASk/XZb/gGMdhH12tyGx8MtQeyNtvGPDC
         yRw3twDvUxUYZBUznbxdsM58FBVwnoilCJA9UeKara+Bk1Z7YJuX+YiPlYx33utHsvh/
         A/hA==
X-Gm-Message-State: AOAM530DDmdR65aOKc9a2iABqs+AIuy1icCIsxvQUQoALnggGf85rDeu
        lty3st6ZxZjY2+e3z6d5+mv79hAK2Q86Cw==
X-Google-Smtp-Source: ABdhPJwXO3yPskee9ladbnf++H8/0IrZ+7Iv8PD1eTUA6DKosc6VIemY97pt4AkUvE1dOFlq2NyTasuPhgM8Vw==
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:468f:6ab3:7243:11d5])
 (user=dlatypov job=sendgmr) by 2002:a25:bb8c:: with SMTP id
 y12mr10508240ybg.542.1636655642210; Thu, 11 Nov 2021 10:34:02 -0800 (PST)
Date:   Thu, 11 Nov 2021 10:33:56 -0800
Message-Id: <20211111183356.4073001-1-dlatypov@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.0.rc1.387.gb447b232ab-goog
Subject: [PATCH] kunit: tool: revamp message for invalid kunitconfig
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com, davidgow@google.com
Cc:     linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current error message is precise, but not very clear if you don't
already know what it's talking about, e.g.

> $ make ARCH=um olddefconfig O=.kunit
> ERROR:root:Provided Kconfig is not contained in validated .config. Following fields found in kunitconfig, but not in .config: CONFIG_DRM=y

Try to reword the error message so that it's
* your missing options usually have unsatisified dependencies
* if you're on UML, that might be the cause (it is, in this example)

Signed-off-by: Daniel Latypov <dlatypov@google.com>
---

Note: this is based on https://lore.kernel.org/linux-kselftest/20211106013058.2621799-1-dlatypov@google.com/
There's a fairly trivial merge conflict between these two patches (that
patch changes the line above where this diff starts).

---
 tools/testing/kunit/kunit_kernel.py | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
index 7d459d6d6ff2..350883672be0 100644
--- a/tools/testing/kunit/kunit_kernel.py
+++ b/tools/testing/kunit/kunit_kernel.py
@@ -266,15 +266,17 @@ class LinuxSourceTree(object):
 	def validate_config(self, build_dir) -> bool:
 		kconfig_path = get_kconfig_path(build_dir)
 		validated_kconfig = kunit_config.parse_file(kconfig_path)
-		if not self._kconfig.is_subset_of(validated_kconfig):
-			invalid = self._kconfig.entries() - validated_kconfig.entries()
-			message = 'Provided Kconfig is not contained in validated .config. Following fields found in kunitconfig, ' \
-					  'but not in .config: %s' % (
-					', '.join([str(e) for e in invalid])
-			)
-			logging.error(message)
-			return False
-		return True
+		if self._kconfig.is_subset_of(validated_kconfig):
+			return True
+		invalid = self._kconfig.entries() - validated_kconfig.entries()
+		message = 'Not all Kconfig options selected in kunitconfig were in the generated .config.\n' \
+			  'This is probably due to unsatisfied dependencies.\n' \
+			  'Missing: ' + ', '.join([str(e) for e in invalid])
+		if self._arch == 'um':
+			message += '\nNote: many Kconfig options aren\'t available on UML. You can try running ' \
+				   'on a different architecture with something like "--arch=x86_64".'
+		logging.error(message)
+		return False
 
 	def build_config(self, build_dir, make_options) -> bool:
 		kconfig_path = get_kconfig_path(build_dir)

base-commit: c949316af0a7c2103521aaa39be85392e2f02bab
-- 
2.34.0.rc1.387.gb447b232ab-goog

