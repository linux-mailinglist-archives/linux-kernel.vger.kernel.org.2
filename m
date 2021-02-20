Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A01AB320294
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Feb 2021 02:36:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbhBTBfE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 20:35:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbhBTBeo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 20:34:44 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93F67C061223
        for <linux-kernel@vger.kernel.org>; Fri, 19 Feb 2021 17:33:13 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id j4so8735451ybt.23
        for <linux-kernel@vger.kernel.org>; Fri, 19 Feb 2021 17:33:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=fRH0suW5jtV5qAv/9hzDuKsmxWRmfZBdn7mAB9P2pvE=;
        b=byWiim3QE0knNixnCWua94fMT6ZqVaWQM7DAWjI8sOF/A9MCSvBI6ckmBOAEqHssGM
         hpLvNfDbwchtlEaPziik0j00EJn1EhPQk4wQUt/FWCjsuQgvAPEeh2uyAlyAi/Co0kpd
         m6CT/ChIegkXc7m/O1waQRYP5baJ8f46ge3bnlerhAbJDgF3JJ0eQl1bvEJ8n3N/jbrC
         HZMRSqNOxfjhL4xt8gsd0Simd6OUQORBeFGGMI4s14aGQBg9KvIfER7H6GYbM6QIoXV9
         THpQL8ebNwL2FyISBYTqsO1UKoPJRceLP+HROMTfo75rQ1+MmQFON+Fmj1G4VZPDBvqx
         MWeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=fRH0suW5jtV5qAv/9hzDuKsmxWRmfZBdn7mAB9P2pvE=;
        b=hN/euwc+3/GHRE+v7SxPVz1TmiiJVus946v2SIKOdNukJhJPqQzEpaTJQMgemAxPq4
         gO9QLY0aSDiBOFJ3tdBf1ePsB2t97yPGlBxOk1Ey8L/suHHk9d6qrG0mxbJLmHSKJPmY
         LgihkcaO3wsOkJLoVzB/E8oU9E4rkr0JsaXIsVhw3t2wceOCvZyCTk+v1hXCbzOG6Plr
         U4XmoeNAHPoHGiQzcHeU7owSIRbJWusseZ+Heg0zHoNUc72vgWy124uupkkYOXwDIGNq
         HmKJmEMIqP4idTlInxDxTVFfYktV1jgDlhch9BB6zSu465/zIhp1/uWEuqvroLucfgR+
         9dKQ==
X-Gm-Message-State: AOAM532JXHvYRa9Jvq6KYcDitKKeXbGel7/X7V94PaK9GUJvY1Vzh47W
        dnyVbBX8w4eIN2Yg/hEVuSTa9hgN8bMcxlDwEHf2AijXsmGvvot7sj3QKFZkicl2vszecpxRxXY
        f/ph+VAOzRKUBqR8W3sa22/6gxKwxZ0P8xOscVRJ/0mtwv/j2Tz+eDwwXBdHyo2vx3mYhutoIuy
        5IwTAHFG/oDAGnwr4=
X-Google-Smtp-Source: ABdhPJw0f5aK68gYqHj2EspA/X0qmwp/7lJNqvTB5aZ184iu3WsFJpaXKjgNIwrLodBt8D7h3iRs7a9ti+SgjWOQKlOogw==
Sender: "matthewgarrett via sendgmr" 
        <matthewgarrett@matthewgarrett-tmp.c.googlers.com>
X-Received: from matthewgarrett-tmp.c.googlers.com ([fda3:e722:ac3:10:7f:e700:c0a8:1081])
 (user=matthewgarrett job=sendgmr) by 2002:a05:6902:1003:: with SMTP id
 w3mr17858695ybt.445.1613784792782; Fri, 19 Feb 2021 17:33:12 -0800 (PST)
Date:   Sat, 20 Feb 2021 01:32:50 +0000
In-Reply-To: <20210220013255.1083202-1-matthewgarrett@google.com>
Message-Id: <20210220013255.1083202-5-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20210220013255.1083202-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.30.0.617.g56c4b15f3c-goog
Subject: [PATCH 4/9] security: keys: trusted: Store the handle of a loaded key
From:   Matthew Garrett <matthewgarrett@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-integrity@vger.kernel.org, linux-pm@vger.kernel.org,
        keyrings@vger.kernel.org, zohar@linux.ibm.com, jejb@linux.ibm.com,
        jarkko@kernel.org, corbet@lwn.net, rjw@rjwysocki.net,
        Matthew Garrett <matthewgarrett@google.com>,
        Matthew Garrett <mjg59@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Certain in-kernel operations using a trusted key (such as creation
certification) require knowledge of the handle it's loaded at. Keep
a copy of that in the payload.

Signed-off-by: Matthew Garrett <mjg59@google.com>
---
 include/keys/trusted-type.h               | 1 +
 security/keys/trusted-keys/trusted_tpm2.c | 6 ++++--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/include/keys/trusted-type.h b/include/keys/trusted-type.h
index 020e01a99ea4..154d8a1769c3 100644
--- a/include/keys/trusted-type.h
+++ b/include/keys/trusted-type.h
@@ -21,6 +21,7 @@
 
 struct trusted_key_payload {
 	struct rcu_head rcu;
+	unsigned int blob_handle;
 	unsigned int key_len;
 	unsigned int blob_len;
 	unsigned int creation_len;
diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
index 6357a51a24e9..a3673fffd834 100644
--- a/security/keys/trusted-keys/trusted_tpm2.c
+++ b/security/keys/trusted-keys/trusted_tpm2.c
@@ -272,11 +272,13 @@ static int tpm2_load_cmd(struct tpm_chip *chip,
 	}
 
 	rc = tpm_send(chip, buf.data, tpm_buf_length(&buf));
-	if (!rc)
+	if (!rc) {
 		*blob_handle = be32_to_cpup(
 			(__be32 *) &buf.data[TPM_HEADER_SIZE]);
-	else
+		payload->blob_handle = *blob_handle;
+	} else {
 		goto out;
+	}
 
 	rc = tpm2_unpack_blob(payload);
 out:
-- 
2.30.0.617.g56c4b15f3c-goog

