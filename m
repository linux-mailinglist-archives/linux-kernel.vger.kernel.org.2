Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A9A3382AA9
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 13:13:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236668AbhEQLOV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 07:14:21 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3718 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236622AbhEQLOS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 07:14:18 -0400
Received: from dggems705-chm.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FkGd46XZqz16QNM;
        Mon, 17 May 2021 19:10:16 +0800 (CST)
Received: from dggpeml500012.china.huawei.com (7.185.36.15) by
 dggems705-chm.china.huawei.com (10.3.19.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 17 May 2021 19:13:01 +0800
Received: from huawei.com (10.67.165.24) by dggpeml500012.china.huawei.com
 (7.185.36.15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Mon, 17 May
 2021 19:13:00 +0800
From:   Kai Ye <yekai13@huawei.com>
To:     <herbert@gondor.apana.org.au>
CC:     <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <wangzhou1@hisilicon.com>, <yekai13@huawei.com>
Subject: [PATCH 1/2] crypto: hisilicon/sec - add new type of SQE
Date:   Mon, 17 May 2021 19:09:59 +0800
Message-ID: <1621249800-11582-2-git-send-email-yekai13@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1621249800-11582-1-git-send-email-yekai13@huawei.com>
References: <1621249800-11582-1-git-send-email-yekai13@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500012.china.huawei.com (7.185.36.15)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add new type of sqe for Kunpeng930, which is the next generation
of SEC accelerator hardware. The hardware adds a new SQE data
structure.

Signed-off-by: Sihang Chen <chensihang1@hisilicon.com>
Signed-off-by: Kai Ye <yekai13@huawei.com>
---
 drivers/crypto/hisilicon/sec2/sec.h        |   5 +-
 drivers/crypto/hisilicon/sec2/sec_crypto.h | 174 +++++++++++++++++++++++++++++
 2 files changed, 178 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/hisilicon/sec2/sec.h b/drivers/crypto/hisilicon/sec2/sec.h
index dfdce2f..28679cf 100644
--- a/drivers/crypto/hisilicon/sec2/sec.h
+++ b/drivers/crypto/hisilicon/sec2/sec.h
@@ -38,7 +38,10 @@ struct sec_aead_req {
 
 /* SEC request of Crypto */
 struct sec_req {
-	struct sec_sqe sec_sqe;
+	union {
+		struct sec_sqe sec_sqe;
+		struct sec_sqe3 sec_sqe3;
+	};
 	struct sec_ctx *ctx;
 	struct sec_qp_ctx *qp_ctx;
 
diff --git a/drivers/crypto/hisilicon/sec2/sec_crypto.h b/drivers/crypto/hisilicon/sec2/sec_crypto.h
index 9c78eda..3b64e17 100644
--- a/drivers/crypto/hisilicon/sec2/sec_crypto.h
+++ b/drivers/crypto/hisilicon/sec2/sec_crypto.h
@@ -44,6 +44,7 @@ enum sec_ckey_type {
 enum sec_bd_type {
 	SEC_BD_TYPE1 = 0x1,
 	SEC_BD_TYPE2 = 0x2,
+	SEC_BD_TYPE3 = 0x3,
 };
 
 enum sec_auth {
@@ -63,6 +64,16 @@ enum sec_addr_type {
 	SEC_PRP  = 0x2,
 };
 
+enum {
+	AUTHPAD_PAD,
+	AUTHPAD_NOPAD,
+};
+
+enum {
+	AIGEN_GEN,
+	AIGEN_NOGEN,
+};
+
 struct sec_sqe_type2 {
 	/*
 	 * mac_len: 0~4 bits
@@ -209,6 +220,169 @@ struct sec_sqe {
 	struct sec_sqe_type2 type2;
 };
 
+struct bd3_auth_ivin {
+	__le64 a_ivin_addr;
+	__le32 rsvd0;
+	__le32 rsvd1;
+} __packed __aligned(4);
+
+struct bd3_skip_data {
+	__le32 rsvd0;
+
+	/*
+	 * gran_num: 0~15 bits
+	 * reserved: 16~31 bits
+	 */
+	__le32 gran_num;
+
+	/*
+	 * src_skip_data_len: 0~24 bits
+	 * reserved: 25~31 bits
+	 */
+	__le32 src_skip_data_len;
+
+	/*
+	 * dst_skip_data_len: 0~24 bits
+	 * reserved: 25~31 bits
+	 */
+	__le32 dst_skip_data_len;
+};
+
+struct bd3_stream_scene {
+	__le64 c_ivin_addr;
+	__le64 long_a_data_len;
+
+	/*
+	 * auth_pad: 0~1 bits
+	 * stream_protocol: 2~4 bits
+	 * reserved: 5~7 bits
+	 */
+	__u8 stream_auth_pad;
+	__u8 plaintext_type;
+	__le16 pad_len_1p3;
+} __packed __aligned(4);
+
+struct bd3_no_scene {
+	__le64 c_ivin_addr;
+	__le32 rsvd0;
+	__le32 rsvd1;
+	__le32 rsvd2;
+} __packed __aligned(4);
+
+struct bd3_check_sum {
+	__u8 rsvd0;
+	__u8 hac_sva_status;
+	__le16 check_sum_i;
+};
+
+struct bd3_tls_type_back {
+	__u8 tls_1p3_type_back;
+	__u8 hac_sva_status;
+	__le16 pad_len_1p3_back;
+};
+
+struct sec_sqe3 {
+	/*
+	 * type: 0~3 bit
+	 * bd_invalid: 4 bit
+	 * scene: 5~8 bit
+	 * de: 9~10 bit
+	 * src_addr_type: 11~13 bit
+	 * dst_addr_type: 14~16 bit
+	 * mac_addr_type: 17~19 bit
+	 * reserved: 20~31 bits
+	 */
+	__le32 bd_param;
+
+	/*
+	 * cipher: 0~1 bits
+	 * ci_gen: 2~3 bit
+	 * c_icv_len: 4~9 bit
+	 * c_width: 10~12 bits
+	 * c_key_len: 13~15 bits
+	 */
+	__le16 c_icv_key;
+
+	/*
+	 * c_mode : 0~3 bits
+	 * c_alg : 4~7 bits
+	 */
+	__u8 c_mode_alg;
+
+	/*
+	 * nonce_len : 0~3 bits
+	 * huk : 4 bits
+	 * cal_iv_addr_en : 5 bits
+	 * seq : 6 bits
+	 * reserved : 7 bits
+	 */
+	__u8 huk_iv_seq;
+
+	__le64 tag;
+	__le64 data_src_addr;
+	__le64 a_key_addr;
+	union {
+		struct bd3_auth_ivin auth_ivin;
+		struct bd3_skip_data skip_data;
+	};
+
+	__le64 c_key_addr;
+
+	/*
+	 * auth: 0~1 bits
+	 * ai_gen: 2~3 bits
+	 * mac_len: 4~8 bits
+	 * akey_len: 9~14 bits
+	 * a_alg: 15~20 bits
+	 * key_sel: 21~24 bits
+	 * updata_key: 25 bits
+	 * reserved: 26~31 bits
+	 */
+	__le32 auth_mac_key;
+	__le32 salt;
+	__le16 auth_src_offset;
+	__le16 cipher_src_offset;
+
+	/*
+	 * auth_len: 0~23 bit
+	 * auth_key_offset: 24~31 bits
+	 */
+	__le32 a_len_key;
+
+	/*
+	 * cipher_len: 0~23 bit
+	 * auth_ivin_offset: 24~31 bits
+	 */
+	__le32 c_len_ivin;
+	__le64 data_dst_addr;
+	__le64 mac_addr;
+	union {
+		struct bd3_stream_scene stream_scene;
+		struct bd3_no_scene no_scene;
+	};
+
+	/*
+	 * done: 0 bit
+	 * icv: 1~3 bit
+	 * csc: 4~6 bit
+	 * flag: 7~10 bit
+	 * reserved: 11~15 bit
+	 */
+	__le16 done_flag;
+	__u8 error_type;
+	__u8 warning_type;
+	union {
+		__le32 mac_i;
+		__le32 kek_key_addr_l;
+	};
+	union {
+		__le32 kek_key_addr_h;
+		struct bd3_check_sum check_sum;
+		struct bd3_tls_type_back tls_type_back;
+	};
+	__le32 counter;
+} __packed __aligned(4);
+
 int sec_register_to_crypto(struct hisi_qm *qm);
 void sec_unregister_from_crypto(struct hisi_qm *qm);
 #endif
-- 
2.8.1

