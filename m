Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AD8C34F72C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 05:06:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233607AbhCaDFw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 23:05:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233483AbhCaDFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 23:05:37 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EC4EC061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 20:05:37 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id j25so13539645pfe.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 20:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o2CBj8aFkD6HZJFT9cK5QMPP0MPRnNkZyzH7XW5FD4Y=;
        b=aodshCd3cBJ6QGDyNwsh1cvHY7aldXxAttajT3hnJA8ijnOej7tDTcgdYCDrMMI8nF
         pejO0XyMFDjqKGQxRR3hg00fYn8O5WXKT22TgsS3TJWlwHmlDXL5zIrFKx4saZIry6Rt
         DTi3rL87IolC7BYpIm2+RFY+bnYn833MPsgWs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o2CBj8aFkD6HZJFT9cK5QMPP0MPRnNkZyzH7XW5FD4Y=;
        b=RgpObTLq4I3dc+8zXlfF0VNI6/hji/zpWD/IbYluwZWYJidaCIcl61IOAkoMOba6yJ
         VEOAigitHrn4W0E7mVD2d0OhuQu0pDQHAXDl5xLNHmaooBYnXXbwP4XmfpY6zcQZ0DlL
         JGVbgF9FJwALuhl6uL6WV4xz06o6f62CQ6rdlyy4dH+3pl6AXMLpYwQwKlsgZTurKb2h
         PsXPwrHZSLu0taPvf3skb/s3+2pc6FsXVEcNKkL3N7ahKDzLxwqNW8/xqnzKIovruHyN
         xgmwZU+1VRyAYsHcUgouzR2YRGcYYm1PC7Wn2uFJdSic9ZBEN/tjKyJzrQvRzvRySsCQ
         +SJw==
X-Gm-Message-State: AOAM531WlT5Vn0A6SGmQxWZS2eqofikI72v1mM+UZPc9K6TzPgQJ4Q1l
        o65aN+qVfm8cRUT8xo/Uy7luaQ==
X-Google-Smtp-Source: ABdhPJym0iu//3mpLKbOAj0W6snEPyewTpgKXij/ias/r8rHV5tLKsnGUR8OVEEzUQ+4OFmfd2WKIg==
X-Received: by 2002:a65:41c3:: with SMTP id b3mr1114228pgq.332.1617159936676;
        Tue, 30 Mar 2021 20:05:36 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:c8c2:b814:df0f:253f])
        by smtp.gmail.com with ESMTPSA id c6sm389024pfj.99.2021.03.30.20.05.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 20:05:36 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Jessica Yu <jeyu@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>
Subject: [PATCH v3 11/12] buildid: Fix kernel-doc notation
Date:   Tue, 30 Mar 2021 20:05:19 -0700
Message-Id: <20210331030520.3816265-12-swboyd@chromium.org>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
In-Reply-To: <20210331030520.3816265-1-swboyd@chromium.org>
References: <20210331030520.3816265-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel doc should use "Return:" instead of "Returns" to properly reflect
the return values.

Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Jessica Yu <jeyu@kernel.org>
Cc: Evan Green <evgreen@chromium.org>
Cc: Hsin-Yi Wang <hsinyi@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 lib/buildid.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/buildid.c b/lib/buildid.c
index e8a473f2b023..483abf71eeec 100644
--- a/lib/buildid.c
+++ b/lib/buildid.c
@@ -120,7 +120,7 @@ static int get_build_id_64(const void *page_addr, unsigned char *build_id,
  * @build_id: buffer to store build id, at least BUILD_ID_SIZE long
  * @size:     returns actual build id size in case of success
  *
- * Returns 0 on success, otherwise error (< 0).
+ * Return: 0 on success, -EINVAL otherwise
  */
 int build_id_parse(struct vm_area_struct *vma, unsigned char *build_id,
 		   __u32 *size)
-- 
https://chromeos.dev

