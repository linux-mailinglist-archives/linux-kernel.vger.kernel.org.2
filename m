Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF58E4369C9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 19:53:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232288AbhJURz5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 13:55:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231727AbhJURzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 13:55:53 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 690ACC0613B9
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 10:53:37 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id o184so2087234iof.6
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 10:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BSUIDgpzpqsYVy+UsL6p5KgT+iXdUFl7ePAjLERRehc=;
        b=aYWRc3OaRlQvlr1ibHgtUDDZ4eO6sny6EhdR3s1sJLjGQx1BFDxg39mac7wS4hYZDy
         xuFYQa2tbl8CfiLlrgVXjiQAQHpyYU/B3UWDvqBAygxD19OV/mtpsbB4KVVCAuLh2+9J
         nhINpHVoUHpGlIrbDXHY86emqTueCjqMgGjsI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BSUIDgpzpqsYVy+UsL6p5KgT+iXdUFl7ePAjLERRehc=;
        b=7mN0PLZo0WrA+HZqgjSOC778PsZF/uGhD6LP2efNEy3J73Pdew6Q+A/2A+IgSfRYhu
         Ig/62sawMFiG7cnb92stjfoX9LWEIsxd3YQHt6+p7uWiQHm9/0Lm5tgBl3sBm2l2BwPE
         U9eS7sU1ktD/acKWKzLAhfij/S0VOSrDK5BXg/5B5/cnwcGHb87zEQmzAv4lNsMLdpfs
         zn+ncXXyoiBzM+6sALZ/Gpr2SZFNYeQUV+1XZQYbT2CwHI6+Y60WU2R9VITUY5kSU9g4
         rKVtRM2XPTyDYXnd+1u0lg7H8QZJcdC62G+1fB8TnGTjhGFgnPUSbOGzzhF8EsgfFCdN
         q1DA==
X-Gm-Message-State: AOAM530Mx5Ib8XLO96xGXvI+J8KbV/aHLgMAAw4XAd9ABTYpEXV3/Jx8
        0PY7R9Yq9uyLsOQlJeilsFT8ng==
X-Google-Smtp-Source: ABdhPJzNGgVr8gnBkRRULC3PTN6A3OPu7JaiM3nqixArW44OkmMCowQKJBOQlXDMuioDE+mPxeVaOw==
X-Received: by 2002:a05:6638:293:: with SMTP id c19mr4889841jaq.21.1634838816816;
        Thu, 21 Oct 2021 10:53:36 -0700 (PDT)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id s6sm3252573ilv.18.2021.10.21.10.53.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 10:53:36 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     pbonzini@redhat.com, shuah@kernel.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] selftests: kvm: fix mismatched fclose() after popen()
Date:   Thu, 21 Oct 2021 11:53:34 -0600
Message-Id: <20211021175335.22241-1-skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

get_warnings_count() foes fclose() using File * returned from popen().
Fix it to call pclose() as it should.

tools/testing/selftests/kvm/x86_64/mmio_warning_test
x86_64/mmio_warning_test.c: In function ‘get_warnings_count’:
x86_64/mmio_warning_test.c:87:9: warning: ‘fclose’ called on pointer returned from a mismatched allocation function [-Wmismatched-dealloc]
   87 |         fclose(f);
      |         ^~~~~~~~~
x86_64/mmio_warning_test.c:84:13: note: returned from ‘popen’
   84 |         f = popen("dmesg | grep \"WARNING:\" | wc -l", "r");
      |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 tools/testing/selftests/kvm/x86_64/mmio_warning_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/x86_64/mmio_warning_test.c b/tools/testing/selftests/kvm/x86_64/mmio_warning_test.c
index 8039e1eff938..9f55ccd169a1 100644
--- a/tools/testing/selftests/kvm/x86_64/mmio_warning_test.c
+++ b/tools/testing/selftests/kvm/x86_64/mmio_warning_test.c
@@ -84,7 +84,7 @@ int get_warnings_count(void)
 	f = popen("dmesg | grep \"WARNING:\" | wc -l", "r");
 	if (fscanf(f, "%d", &warnings) < 1)
 		warnings = 0;
-	fclose(f);
+	pclose(f);
 
 	return warnings;
 }
-- 
2.32.0

