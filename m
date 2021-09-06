Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9876B401C93
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 15:45:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242817AbhIFNpy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 09:45:54 -0400
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:46740
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242778AbhIFNpw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 09:45:52 -0400
Received: from localhost (1.general.cking.uk.vpn [10.172.193.212])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 3C1ED3F345;
        Mon,  6 Sep 2021 13:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1630935879;
        bh=8DL2qBORypWZtnKc7Sgib1seutdYE18F1Y8uSU1Gt14=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type;
        b=bg9pefK6YpNHhudukgg4nBsh9CuQhtd8PQSQCs9Rv6bvnMP0EXxJIRbcZX53rGKG2
         fyJ262nzAxdT/oR0OZeaFioaiFndcsHIfNl9oLLicdaBJiRyJD4NcbDu5FeetkQmqW
         5wpYAwDBB7/5B4JiKUkPMNsHZNfwv2/pPITV6rvAcXqgI4wGF+iR0RKk15V7y8yC/V
         TXZ8HD4FMVSfG2fhG7Ucnyp/0u+Kw61BXxiJriZ5+UKjKiajQjxX/7HrxPVNoRF19t
         AfZpOY2Sr9RXdvVkJrmGCz7GaKcTqT0OpvbnRrCof7XpgsUmHhkwbZM7v/cA+RTg2G
         xwK4LESjdODqQ==
From:   Colin King <colin.king@canonical.com>
To:     Namjae Jeon <linkinjeon@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steve French <sfrench@samba.org>,
        Hyunchul Lee <hyc.lee@gmail.com>, linux-cifs@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] ksmbd: add missing assignments to ret on ndr_read_int64 read calls
Date:   Mon,  6 Sep 2021 14:44:38 +0100
Message-Id: <20210906134438.14250-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Currently there are two ndr_read_int64 calls where ret is being checked
for failure but ret is not being assigned a return value from the call.
Static analyis is reporting the checks on ret as dead code.  Fix this.

Addresses-Coverity: ("Logical dead code")
Fixes: 303fff2b8c77 ("ksmbd: add validation for ndr read/write functions")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 fs/ksmbd/ndr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ksmbd/ndr.c b/fs/ksmbd/ndr.c
index a476de291f62..8317f7ca402b 100644
--- a/fs/ksmbd/ndr.c
+++ b/fs/ksmbd/ndr.c
@@ -275,11 +275,11 @@ int ndr_decode_dos_attr(struct ndr *n, struct xattr_dos_attrib *da)
 		if (ret)
 			return ret;
 
-		ndr_read_int64(n, NULL);
+		ret = ndr_read_int64(n, NULL);
 		if (ret)
 			return ret;
 
-		ndr_read_int64(n, NULL);
+		ret = ndr_read_int64(n, NULL);
 		if (ret)
 			return ret;
 
-- 
2.32.0

