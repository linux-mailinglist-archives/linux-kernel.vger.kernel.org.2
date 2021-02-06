Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB209311AC7
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 05:19:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbhBFETM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 23:19:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231699AbhBFCuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 21:50:44 -0500
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 588ADC08EE1D
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 16:09:10 -0800 (PST)
Received: by mail-qk1-x749.google.com with SMTP id c63so7299935qkd.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 16:09:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=KdjKwQSV8R49hhF8YBTPAsSenCKV1XvSoMIimz2f7Lo=;
        b=u8ilAwjsWp1UN91pf1gmxM/49s467/eLrcvHS5yAiHMELI/fEaJ+bctfICqIJTIqQ0
         x2MEI3eltGnZrdyvOIyhn/u8pufdJ/vJg40YGrRTQP9pcn7qBt2H4kCyAFEG4LC70+3d
         QkxEyeeoH1Q6nFYtrGlqM/Ui7oIXkLQRIxExK5IXuSrsBZYrSfSkXszNhmzrugIUEqni
         UYzzZxDDz1Vkz+GsrlaA19tIqwiqyQh6YpntT0tEk6h1VFSt6UwJzVFgHNkeYHQUP6TW
         RVTJa3R9/oIf+sjqsGuH1rnbZo1nMZZdkYZLrDqa5BDKSkksYaPu3e8w5CwhW9y3F2Gi
         hP1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=KdjKwQSV8R49hhF8YBTPAsSenCKV1XvSoMIimz2f7Lo=;
        b=hLDjjXH+vQlRIfNne2+DaFc3Vrs+89JSz61LkPmWJ2+48+r/WhQ7daXa6Rq1CglZv9
         APeCSy6ACGv+ukbNuYb31eYCuloeY0XR4Fy8x+S55/Zof9lbSC/GzqtBOYU5L5e48QLL
         L+N0+Fz7uepH4oe7Miw/wGzypeCUc3jzuJTcD45gid6Rq94yxVa7bdx6GNVqn9gJ5f2K
         TXt3W5ootCc0D+rsY4nZVTjaOcH8lP+4KYTbgkJNmcOIog8hBd3DLVsh1hp5shxLCKcx
         mQOhLXI996UsJyyBroENc2YCB0n2GZf+3yO5p5AhYY2yoNc9yX8gcW9JWTEWg+9m+U9c
         pkIQ==
X-Gm-Message-State: AOAM531anylQ5/WnecgjctKNJFgjfF0RJSD0bnYiMypXUqZ6FifOuI0d
        R7QOcaWt2sqpGPPT1PlYbwbqaDjfkxf0gA==
X-Google-Smtp-Source: ABdhPJzuVtOEBEdpMg+xANPjOgnrC323ecoJ6yJGZv45bT7+rm2SAUoHCScRms23l0Pw2ZbX3BaxS/NuT6ttMw==
Sender: "dlatypov via sendgmr" <dlatypov@dlatypov.svl.corp.google.com>
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:a8b1:128a:69fa:86fb])
 (user=dlatypov job=sendgmr) by 2002:ad4:47b2:: with SMTP id
 a18mr6953341qvz.1.1612570149583; Fri, 05 Feb 2021 16:09:09 -0800 (PST)
Date:   Fri,  5 Feb 2021 16:08:54 -0800
In-Reply-To: <20210206000854.2037923-1-dlatypov@google.com>
Message-Id: <20210206000854.2037923-4-dlatypov@google.com>
Mime-Version: 1.0
References: <20210206000854.2037923-1-dlatypov@google.com>
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
Subject: [PATCH v4 3/3] kunit: tool: fix unintentional statefulness in run_kernel()
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com
Cc:     davidgow@google.com, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org, Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a bug that has been present since the first version of this
code.
Using [] as a default parameter is dangerous, since it's mutable.

Example using the REPL:
>>> def bad(param = []):
...     param.append(len(param))
...     print(param)
...
>>> bad()
[0]
>>> bad()
[0, 1]

This wasn't a concern in the past since it would just keep appending the
same values to it.

E.g. before, `args` would just grow in size like:
  [mem=1G', 'console=tty']
  [mem=1G', 'console=tty', mem=1G', 'console=tty']

But with now filter_glob, this is more dangerous, e.g.
  run_kernel(filter_glob='my-test*') # default modified here
  run_kernel()			     # filter_glob still applies here!
That earlier `filter_glob` will affect all subsequent calls that don't
specify `args`.

Note: currently the kunit tool only calls run_kernel() at most once, so
it's not possible to trigger any negative side-effects right now.

Fixes: 6ebf5866f2e8 ("kunit: tool: add Python wrappers for running KUnit tests")
Signed-off-by: Daniel Latypov <dlatypov@google.com>
Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
---
 tools/testing/kunit/kunit_kernel.py | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
index 71a5f5c1750b..f309a33256cd 100644
--- a/tools/testing/kunit/kunit_kernel.py
+++ b/tools/testing/kunit/kunit_kernel.py
@@ -203,7 +203,9 @@ class LinuxSourceTree(object):
 			return False
 		return self.validate_config(build_dir)
 
-	def run_kernel(self, args=[], build_dir='', filter_glob='', timeout=None) -> Iterator[str]:
+	def run_kernel(self, args=None, build_dir='', filter_glob='', timeout=None) -> Iterator[str]:
+		if not args:
+			args = []
 		args.extend(['mem=1G', 'console=tty'])
 		if filter_glob:
 			args.append('kunit.filter_glob='+filter_glob)
-- 
2.30.0.478.g8a0d178c01-goog

