Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D10030F9D3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 18:35:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238576AbhBDRfB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 12:35:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238641AbhBDRcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 12:32:25 -0500
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FD9AC061223
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 09:31:02 -0800 (PST)
Received: by mail-qt1-x849.google.com with SMTP id d10so3143786qtx.8
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 09:31:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=/SVhbM2uQkfhx0nM8S6aEm/0ZcJ7ciNGwmg4LfVvDlo=;
        b=Thvd174F9a+GsewOT+nlcPKlXmhil/8YBJC6kx0cQirSj3kOEGPIWE8+idsYw/Jt/D
         4+BPW1mdGFi0Rkh5ZAT/GedqQOr8xgFt+rmK97J+dp+Ochcs4qZnfIIE1BJB5LPaFcYp
         JfwwAlORU8NGAtvPlQAJhvBr0yfxL6C5EA0+gFdlv6DPwNhxYkDiwPn14I0E+SAX+CPH
         WX/TaymNi6HCVBh/ogLhTWVwiIFPrq4HTnAo9nEPSmB3O2Zmf/E1M8UIRSOLYarJAEEo
         7kq6GemeNytdIJxjXaMhUk5RYqcoJhRBPQav2eRcI+KM+xDVwl1nJO1V74nDIQw0ooeK
         N5XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=/SVhbM2uQkfhx0nM8S6aEm/0ZcJ7ciNGwmg4LfVvDlo=;
        b=Tb85rI8jF8/t08zWeLTbQD/TscKzTBDBfJznsX/3Es+dS6HT4jBSk6EDP8cqm6e8np
         zCmiqidHHkE61mIeBZRUlQOqwutZZGEPSJZLVAjMgxoOMB5YfPPKY+NihIMn0xJe+vkI
         71uTf3OlCTRgrpi6uRYFvxC4STUKA3Lt9+Ixp+Hf5Hy3iYkmYBN4+PNstgGQOqFP1Cv8
         DrYU3TM/sf68cfV8URv5Jsq5yxTTlsvOyc1BbR8N4X/KNnZ1iLUvv489iSiQrmzgClLS
         RuPYOWaL+0ERG63G21xIPkc6yqmUWe6goYwqZrpvxBJbTuv6eh/LXKLES5dx3AM4XFXo
         rUnA==
X-Gm-Message-State: AOAM531rPO48I0odOjantr+evO2f9oLf43OE/2et73UZzGc2ixX396aJ
        U3I1JeohPr0IRVsbatunPjJB547eLok/ew==
X-Google-Smtp-Source: ABdhPJxeiBQhDE8ipCm5Yam3J5DXGKIM5RehWcKf6aRy7SPNSKUDJBO2mDGDRSy/Rz3KEXmTwZZRGuB2CbHeqw==
Sender: "dlatypov via sendgmr" <dlatypov@dlatypov.svl.corp.google.com>
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:bd7a:7717:5b5b:de27])
 (user=dlatypov job=sendgmr) by 2002:a0c:ee89:: with SMTP id
 u9mr514981qvr.40.1612459861632; Thu, 04 Feb 2021 09:31:01 -0800 (PST)
Date:   Thu,  4 Feb 2021 09:30:45 -0800
In-Reply-To: <20210204173045.1138504-1-dlatypov@google.com>
Message-Id: <20210204173045.1138504-4-dlatypov@google.com>
Mime-Version: 1.0
References: <20210204173045.1138504-1-dlatypov@google.com>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
Subject: [PATCH v2 3/3] kunit: tool: fix unintentional statefulness in run_kernel()
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com, davidgow@google.com
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
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
---
 tools/testing/kunit/kunit_kernel.py | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
index 71b1942f5ccd..6dd3cf6e8efa 100644
--- a/tools/testing/kunit/kunit_kernel.py
+++ b/tools/testing/kunit/kunit_kernel.py
@@ -199,7 +199,9 @@ class LinuxSourceTree(object):
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
2.30.0.365.g02bc693789-goog

