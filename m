Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 672AB3AF7A0
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 23:44:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231645AbhFUVrE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 17:47:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231127AbhFUVrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 17:47:03 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09688C06175F
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 14:44:49 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id t13so3433001pgu.11
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 14:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5SQkML+us/TzTvjNIUpTTZK1LcWvPmhVJh6s0rRl9Qk=;
        b=UzZcLSqTmHn9LZBav80swfVHG2/jblmUTnekXNiK7ceuCkj0abzDMDndwp+Ld4OqUV
         41Hql9ComICSBqnWmm5gEi0WTe/BHG12NCvqhsHLOCgCJzBQbLV1rhDjSE6EkdO/HISo
         UnQjzjH1bkfy23XkK8BDDE+IcOVPF14ToJBeM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5SQkML+us/TzTvjNIUpTTZK1LcWvPmhVJh6s0rRl9Qk=;
        b=goHf3uOOsOs706uyUie22nAm6wpF/AZkMQT6Za9YDTjlzhzWtDnirP0+1ewXp4bSdq
         pSqrTHmHFKvA7w8aA9k0EVnaSbjCQhVqUMarpEYN0gs2yVH7kzxKVt1MQgoqWGER7n7W
         6Zb09K3QYt8RFcmIAvxAChjSiCWfEZHF2gnKKmXCyZKSyEBWuz97g4JctSClibgA5sdj
         cWJiFm/hQvgGE3ABmUB74jAMRTBpyQkVLc7VyCowJVHu5ty5WGbOaxMmiy21go4jqCDT
         V/YvugEYOT5Aq8zrOoDKNDHchVBVm7ZVSzdO8R0DO6z6JKfixj4bnLdpRFC137Y6uVgG
         EpAg==
X-Gm-Message-State: AOAM532ww/x5VKiPAhR0it8XZ/yjI6k5ZFYCPNFHlC+Oo8wLFiS4dc0Z
        lfMsyLjML7ijQ90H9krYCcmiGA==
X-Google-Smtp-Source: ABdhPJzz1K6S0azoxavM8zBd3FzUas7iHfXieyJ/64wJfnuk5oRfGU2oMlhigbghP7JxgPgA66efDw==
X-Received: by 2002:aa7:808b:0:b029:2ef:cdd4:8297 with SMTP id v11-20020aa7808b0000b02902efcdd48297mr269068pff.27.1624311888484;
        Mon, 21 Jun 2021 14:44:48 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y34sm15722960pfa.181.2021.06.21.14.44.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 14:44:47 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Steve French <stfrench@microsoft.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH] cifs: Avoid field over-reading memcpy()
Date:   Mon, 21 Jun 2021 14:44:46 -0700
Message-Id: <20210621214446.1406159-1-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Patch-Hashes: v=1; h=sha256; g=e5cadb56c3e7514cb994ed54287fb706e50000e7; i=lOfZOHXQfQA4AvwHsS+g6pzIoRRUmxml/Q0Cvo8KZSY=; m=zkKCsU1v75EihiOwQ8Ntag9WswPCcnp82PKmei5UNOM=; p=zOANoTiXhOGaMHs/B1FA5Z7/pOmXr16srI44FQ2R2hs=
X-Patch-Sig: m=pgp; i=keescook@chromium.org; s=0x0x8972F4DFDC6DC026; b=iQIzBAABCgAdFiEEpcP2jyKd1g9yPm4TiXL039xtwCYFAmDRCE0ACgkQiXL039xtwCZeThAAkm8 Ibpq7BRnzvOr7DbcYSl91e4mhil+ltMX7OPs/Nz+5ueKoW27hIDKK6d1GLs68V+4qYzzu6V0GKwC/ KanQm7Y2y9MzjSMXNAbHnSTUOVvNhzrgNbmk/jfieZM3RTtexTl8Pfp2BSrLhOm7scyA/AMy+PHW5 83M8hrv4iCKSG6884R6txHIh8Krm9i2U5rU2u2zK1TQbUnIaNO2LLBw/eqb+qdvNiwzPiXI4+Heqv PcDK9edtrbLeIr7xvrsQRWJmDprxUAzJYGSknqhxKnPDFMDJM91jrhapIhaIWB6A8bQ8KvbkhFoOv PO9I0u2ncu/Qr+q6SmwQGHiWlmrMwYIDQAipYDiurdO8mQin36W/z3s9o5cDCJeFqXwZgQDC83/Sr 06mEueHkHrQx6QL2SMZLfNngeQ/XjghIcOq5ERZazU/uWlqAyl+fV0YA7oGnQ2OPZC7C0tkfA2PA+ cRZoWIPA9psiurFiDBhxZIhQugBR6dzEgcy0Yt9AhzxX0SyMdSvab481VUrxjAab2jeOZtFw8lEPI 1EoI8pDr5+0Bcjkgntbh3u0oDKZoJpx0aDS+AzKgS2OrZgK9M0LPjTREc7ub2Zqwb0a8XrkPMpeL4 fOrj4XnPY864J7vUN9b01QffAJ1XCOTkpMu+ngnzxjsylwQ5sZcgcKC0GP5LGSBk=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for FORTIFY_SOURCE performing compile-time and run-time
field bounds checking for memcpy(), memmove(), and memset(), avoid
intentionally reading across neighboring fields.

Instead of using memcpy to read across multiple struct members, just
perform per-member assignments as already done for other members.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/cifs/smb2pdu.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/cifs/smb2pdu.c b/fs/cifs/smb2pdu.c
index 31784e3fa96f..962826dc3316 100644
--- a/fs/cifs/smb2pdu.c
+++ b/fs/cifs/smb2pdu.c
@@ -2892,7 +2892,10 @@ SMB2_open(const unsigned int xid, struct cifs_open_parms *oparms, __le16 *path,
 #endif /* CIFS_DEBUG2 */
 
 	if (buf) {
-		memcpy(buf, &rsp->CreationTime, 32);
+		buf->CreationTime = rsp->CreationTime;
+		buf->LastAccessTime = rsp->LastAccessTime;
+		buf->LastWriteTime = rsp->LastWriteTime;
+		buf->ChangeTime = rsp->ChangeTime;
 		buf->AllocationSize = rsp->AllocationSize;
 		buf->EndOfFile = rsp->EndofFile;
 		buf->Attributes = rsp->FileAttributes;
-- 
2.30.2

