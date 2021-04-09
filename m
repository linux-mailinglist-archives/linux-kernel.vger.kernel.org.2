Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FC8F35A89D
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 00:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234798AbhDIWIM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 18:08:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234517AbhDIWIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 18:08:10 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FAABC061762
        for <linux-kernel@vger.kernel.org>; Fri,  9 Apr 2021 15:07:57 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id b18so3885983qte.21
        for <linux-kernel@vger.kernel.org>; Fri, 09 Apr 2021 15:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=2u0vXKObH3WGsffrNc9fPTVMDfChsBE9GCCsg/H8M68=;
        b=h/Tv8qqDFL0pawJZIOb3zQlQ+7bPo0b1mvHp3yydhAiEGDHgHeLfG3sISim9bRhCSZ
         hC5kLVMVEI2utZ4r+80y7gj+fchkXW3uIQfYa8i+JKXTWL8vF0j0bYufSs9qmykwvWVV
         3Tp1xRn3GEGBNYGyAf5wY79iWL3x9pdNVfqPq7gvzU0EuPEHX3ilmxgqFQ8DhsQ5yJqc
         4IY3nF3mcXHMQl6kl8SlNQK+JoyPhZbHHdjPbVQ8X2P3EjefEmtGLJwmAOXRAQT0AhgT
         ardAIyqTNmu9AOsOLdD72UMBSpKK99aT3KCfFhzpBht6tCR88Ic3hXhxu83lb0iFcLv3
         bgDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=2u0vXKObH3WGsffrNc9fPTVMDfChsBE9GCCsg/H8M68=;
        b=XdnYT8DIge8QzZQy/FMzAD3hQhZXNt7ymTvWJX5WAFi34Msl5vNBvNgoFk+fbFRbHj
         ebvlU+ghaDRJ/gJRIBPQ4qxkWUjens7J/VoJN0X1Ormxzk+tgeIOLWEVv9JJlV0mPXCw
         4zp9VozC6hQgxgXNmUr0m3/aLCUrWqd3tf5F29ChohgioipUvBoZ+trtN+yv2Y3yxLEX
         OoqnytapfXPahnj3W5XFm50+gXrkScBSF6hkzeaAdAmXA4cMndj2s3DI8NlsWZXibqsK
         7c8IYfPIOdGI3u/ZQdkqcaaLEazfsekY50qTLu99A21cuQvLWTQHvtQx/ZRnA9MyfcmP
         iMeg==
X-Gm-Message-State: AOAM530gIeU0W+rNzYjDOPQftfVW3+m7vX3AVoL9eQJtoKzNuvXu7RDN
        Gj1a1yWCkGiXprWrkodnLGzY3ysitAMM1AjXqA==
X-Google-Smtp-Source: ABdhPJwfHO47VlmafTdDfP3AuOncr1qecCve2z/OzMFX/Cn3ARCJoUDeda7GIgCjRlVw6UKUOtKqHc8TiPrAi/TrWw==
X-Received: from riemann.sea.corp.google.com ([2620:15c:158:202:a8f5:15cf:e225:5433])
 (user=srutherford job=sendgmr) by 2002:ad4:4c83:: with SMTP id
 bs3mr16388203qvb.41.1618006076216; Fri, 09 Apr 2021 15:07:56 -0700 (PDT)
Date:   Fri,  9 Apr 2021 15:07:50 -0700
Message-Id: <20210409220750.1972030-1-srutherford@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.1.295.g9ea45b61b8-goog
Subject: [PATCH v2] KVM: SVM: Add support for KVM_SEV_SEND_CANCEL command
From:   Steve Rutherford <srutherford@google.com>
To:     kvm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, natet@google.com,
        Ashish.Kalra@amd.com, brijesh.singh@amd.com, pbonzini@redhat.com,
        Steve Rutherford <srutherford@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After completion of SEND_START, but before SEND_FINISH, the source VMM can
issue the SEND_CANCEL command to stop a migration. This is necessary so
that a cancelled migration can restart with a new target later.

Reviewed-by: Nathan Tempelman <natet@google.com>
Reviewed-by: Brijesh Singh <brijesh.singh@amd.com>
Signed-off-by: Steve Rutherford <srutherford@google.com>
---
 .../virt/kvm/amd-memory-encryption.rst        |  9 ++++++++
 arch/x86/kvm/svm/sev.c                        | 23 +++++++++++++++++++
 drivers/crypto/ccp/sev-dev.c                  |  1 +
 include/linux/psp-sev.h                       | 10 ++++++++
 include/uapi/linux/kvm.h                      |  2 ++
 5 files changed, 45 insertions(+)

diff --git a/Documentation/virt/kvm/amd-memory-encryption.rst b/Documentation/virt/kvm/amd-memory-encryption.rst
index 469a6308765b1..9e018a3eec03b 100644
--- a/Documentation/virt/kvm/amd-memory-encryption.rst
+++ b/Documentation/virt/kvm/amd-memory-encryption.rst
@@ -284,6 +284,15 @@ Returns: 0 on success, -negative on error
                 __u32 len;
         };
 
+16. KVM_SEV_SEND_CANCEL
+------------------------
+
+After completion of SEND_START, but before SEND_FINISH, the source VMM can issue the
+SEND_CANCEL command to stop a migration. This is necessary so that a cancelled
+migration can restart with a new target later.
+
+Returns: 0 on success, -negative on error
+
 References
 ==========
 
diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 83e00e5245136..16d75b39e5e78 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -1110,6 +1110,26 @@ static int sev_get_attestation_report(struct kvm *kvm, struct kvm_sev_cmd *argp)
 	return ret;
 }
 
+static int sev_send_cancel(struct kvm *kvm, struct kvm_sev_cmd *argp)
+{
+	struct kvm_sev_info *sev = &to_kvm_svm(kvm)->sev_info;
+	struct sev_data_send_cancel *data;
+	int ret;
+
+	if (!sev_guest(kvm))
+		return -ENOTTY;
+
+	data = kzalloc(sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->handle = sev->handle;
+	ret = sev_issue_cmd(kvm, SEV_CMD_SEND_CANCEL, data, &argp->error);
+
+	kfree(data);
+	return ret;
+}
+
 int svm_mem_enc_op(struct kvm *kvm, void __user *argp)
 {
 	struct kvm_sev_cmd sev_cmd;
@@ -1163,6 +1183,9 @@ int svm_mem_enc_op(struct kvm *kvm, void __user *argp)
 	case KVM_SEV_GET_ATTESTATION_REPORT:
 		r = sev_get_attestation_report(kvm, &sev_cmd);
 		break;
+	case KVM_SEV_SEND_CANCEL:
+		r = sev_send_cancel(kvm, &sev_cmd);
+		break;
 	default:
 		r = -EINVAL;
 		goto out;
diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
index cb9b4c4e371ed..2c0a60120c785 100644
--- a/drivers/crypto/ccp/sev-dev.c
+++ b/drivers/crypto/ccp/sev-dev.c
@@ -129,6 +129,7 @@ static int sev_cmd_buffer_len(int cmd)
 	case SEV_CMD_DOWNLOAD_FIRMWARE:		return sizeof(struct sev_data_download_firmware);
 	case SEV_CMD_GET_ID:			return sizeof(struct sev_data_get_id);
 	case SEV_CMD_ATTESTATION_REPORT:	return sizeof(struct sev_data_attestation_report);
+	case SEV_SEND_CANCEL:				return sizeof(struct sev_data_send_cancel);
 	default:				return 0;
 	}
 
diff --git a/include/linux/psp-sev.h b/include/linux/psp-sev.h
index b801ead1e2bb5..74f2babffc574 100644
--- a/include/linux/psp-sev.h
+++ b/include/linux/psp-sev.h
@@ -73,6 +73,7 @@ enum sev_cmd {
 	SEV_CMD_SEND_UPDATE_DATA	= 0x041,
 	SEV_CMD_SEND_UPDATE_VMSA	= 0x042,
 	SEV_CMD_SEND_FINISH		= 0x043,
+	SEV_CMD_SEND_CANCEL		= 0x044,
 
 	/* Guest migration commands (incoming) */
 	SEV_CMD_RECEIVE_START		= 0x050,
@@ -392,6 +393,15 @@ struct sev_data_send_finish {
 	u32 handle;				/* In */
 } __packed;
 
+/**
+ * struct sev_data_send_cancel - SEND_CANCEL command parameters
+ *
+ * @handle: handle of the VM to process
+ */
+struct sev_data_send_cancel {
+	u32 handle;				/* In */
+} __packed;
+
 /**
  * struct sev_data_receive_start - RECEIVE_START command parameters
  *
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index f6afee209620d..707469b6b7072 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -1671,6 +1671,8 @@ enum sev_cmd_id {
 	KVM_SEV_CERT_EXPORT,
 	/* Attestation report */
 	KVM_SEV_GET_ATTESTATION_REPORT,
+	/* Guest Migration Extension */
+	KVM_SEV_SEND_CANCEL,
 
 	KVM_SEV_NR_MAX,
 };
-- 
2.31.1.295.g9ea45b61b8-goog

