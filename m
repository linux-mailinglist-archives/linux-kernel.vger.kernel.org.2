Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ECCA41C1DB
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 11:44:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245119AbhI2JqE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 05:46:04 -0400
Received: from mail-dm3nam07on2079.outbound.protection.outlook.com ([40.107.95.79]:53088
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231269AbhI2JqD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 05:46:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zupgz71MqicQ8bXvhgBmv7n2S1JJ1QiQQ0TEncH6N2xl4m54tI+T5wwOO8YE9Ok218sPs0sSarpXV1QD6LNtJxEnUYFi7ZFvL6VzsAlc8yx+nXCVgKcwdUIaaAw4H6cXxMlQfGuHqmosgx/hxK/1cg2a1KQIkiXfMy7yjyXqYqtyMaZc5lO7jGf3ruZcg49M7ZTv5IQBaQhrON1OojdUk0NucMpZaT0L+X8KUO5AzDGBA99PO+nEPwnHX284JWyUqSLx91eoJRUbjiYQqhBx5hkUmHyi8Jg1/bjXpnBDpCe92p3h2HkFTIVB+Nb5KxRMKcdT8TpnNAaKWGd98zyuZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=+3AnSmRwjJmg0uLNKpDn/sQynmBopytZaRLk7c+UZi4=;
 b=JB3qi/vZPyE8RIHcULEy/0BaKM+pIRbWXjvzpcezZeak0/kVVPA5pgpw79aRm63kZAc4W2QIWIU0vwu4ezT7RrOzciLl6VzE6Nj8X1UxYxk2cgYsCRpwn+TG5zzLHXh+LNQY9oFvUrF/u95HumAu53mPkDn9b6+uRRqPxwtHHH2FjBVKOlKYqh8bGjTN+drs1srar1Xii3SaEjSLT7tk9si4rTlif8HBhX5cPf3g3I/BDxe6w48JZ+gOoSXIka1Ob0NjMJBr7i3Ve9tVFIE+L1GP6y1MBCfNSi+hujiILMVDEzyr81gSTXI7t7fVJuvRUW54Q4t/Zy+8+tY9VFJ+WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.35) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+3AnSmRwjJmg0uLNKpDn/sQynmBopytZaRLk7c+UZi4=;
 b=k4VnFzuVC5Cq6ncWz8OU51XHWDv5DDqacD4/yES5tX/ttlloiRSgqYAtX2qriYqj3jad9TwkJUgJgN0w+cDXGiqcLCewF9QGGbnrK5ZTJGUjUaq147qBjnStm6LkyBAluExSAFsLomNzbxp/mt+F2briyY8fdaLkdXcjGFxhKi1GPgVSXPpWfI+74Pc9DNslA0Wqy2m62Iwm4vmCUEbd+uCAh1txRKpEREueNMwJFDJzig08k/Re5JHI30j40yiFJSzQ1u9UFhXSkN+pZFevWGcWuMd3fa8sbT8FyrEIDsX/2UqTY4c4PlfjUXdSXmbl1kG/qHJTCsx8+flNe8sqJQ==
Received: from MWHPR14CA0009.namprd14.prod.outlook.com (2603:10b6:300:ae::19)
 by DM4PR12MB5294.namprd12.prod.outlook.com (2603:10b6:5:39e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Wed, 29 Sep
 2021 09:44:21 +0000
Received: from CO1NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:ae:cafe::a3) by MWHPR14CA0009.outlook.office365.com
 (2603:10b6:300:ae::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.13 via Frontend
 Transport; Wed, 29 Sep 2021 09:44:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.35)
 smtp.mailfrom=nvidia.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.35 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.35; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.35) by
 CO1NAM11FT034.mail.protection.outlook.com (10.13.174.248) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4566.14 via Frontend Transport; Wed, 29 Sep 2021 09:44:20 +0000
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 29 Sep
 2021 09:44:20 +0000
Received: from localhost (172.20.187.6) by DRHQMAIL107.nvidia.com (10.27.9.16)
 with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 29 Sep 2021 09:44:19
 +0000
Date:   Wed, 29 Sep 2021 12:44:16 +0300
From:   Ido Schimmel <idosch@nvidia.com>
To:     kernel test robot <lkp@intel.com>, <nathan@kernel.org>
CC:     "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jiri Pirko <jiri@nvidia.com>
Subject: Re:
 drivers/net/ethernet/mellanox/mlxsw/core_acl_flex_actions.c:2022:1: warning:
 unused function 'mlxsw_afa_sampler_mirror_agent_get'
Message-ID: <YVQ1cE0Ke2cWzB0r@shredder>
References: <202109290245.bpgij5Zs-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <202109290245.bpgij5Zs-lkp@intel.com>
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 079a77dd-374b-4fcf-6b0d-08d9832db66b
X-MS-TrafficTypeDiagnostic: DM4PR12MB5294:
X-Microsoft-Antispam-PRVS: <DM4PR12MB529468A8E48BB0A74659A3C1B2A99@DM4PR12MB5294.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3G8ifmGIuOEfSOwj70zHZCZxQTm5rCUKO3BsSk1AfyIpHncmCF614+SsTYpRLvU6J0mb65Benp3GrbNNSapfeDm3Q61uG1VVAaKKbh9mTg63fN+QJXopEwDxrN+EBUeUqc0zjiX2bV5FtmGXT+Dq+SzSygitaW+GRMuqMHqPn7krD1wDmm1xPNiLggM3pn1A++CnMb/qbt6BqBfO1OKzq4OENZhU9EGNKUcJ+s+RF5XIB+mgfeNjZ2z8lTGngK5loeO07wPZJzCQbfstOd/aGdrRi0zWtul81sFO2QWbs2n8tl5qJp0xLOQUwL7oW4H/Sx9oqxpfPji6MQe/YXwkK/wtgpuyvcCelmzLCQfNzZV7gIx8su/oEK0cqaTzLwVR8E8p7XruJ+aYam9VdocgbplJnki6pWr1zmgtOmScz4g5NmXZ2RFdxh5znwp8B96p2diBnfUYtESXBKEyrB8Dogwq9g2ULP2B3Ap5O/3jef4ez9n+vuaPE03zR8YdUUEcv3tRNOBacB3cmXDAh905jGBzqrmpYaXq3KoHA+U63npqS7jAHIsDdOG5D9casAPqwc3d93mnVZaSeBMXnzLafVmKKCDaXIfnZPlESpd0aIXrN4ne9131+gR5k4QLKlaU+I8yI3gKmoG8UgYIAzFQhxmm4/438Pn2eOkkNMtEJwZdEJLv/Wr5MDt+Shhuq013wNW1JGiCX0rtwnT9/jTYpuiH+gnVHIU+FIIZr8I0gtlkree/zB88Y8O+RE5FN0n+2e/3pQn/L2byAMXF+M/15qC0cfubgC0N4guezlrUTA0=
X-Forefront-Antispam-Report: CIP:216.228.112.35;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid02.nvidia.com;CAT:NONE;SFS:(4636009)(7916004)(36840700001)(46966006)(54906003)(4326008)(86362001)(82310400003)(30864003)(2906002)(110136005)(83380400001)(36860700001)(316002)(6666004)(70206006)(107886003)(66574015)(7636003)(336012)(8676002)(26005)(8936002)(47076005)(33716001)(966005)(356005)(508600001)(9686003)(5660300002)(426003)(16526019)(186003)(70586007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2021 09:44:20.5606
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 079a77dd-374b-4fcf-6b0d-08d9832db66b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.35];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5294
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 28, 2021 at 09:06:54PM +0300, kernel test robot wrote:
> All warnings (new ones prefixed by >>):
> 
>    static inline u32 mlxsw_##_type##_##_cname##_##_iname##_get(const char ^
>    <scratch space>:119:1: note: expanded from here
>    mlxsw_afa_polcnt_c_p_get
>    ^

Nathan,

I saw your reply to a similar issue here [1] and I got the impression
that you are leading the LLVM-related efforts, so I thought I will
consult with you regarding a possible solution.

The inline functions that clang is complaining about are generated by
macros that make it easy to set/get fields in the payloads of
configuration messages used to communicate with the device. It is
possible that sometime we only set a field, but never retrieve its value
such as in the warning above. This is very much intentional and not
indicative of a function we forgot to remove.

The patch below [2] adds the "__maybe_unused" keyword to these macros
and makes clang happy [3].

Is this acceptable or you suggest a different solution?

Thanks

[1] https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org/thread/TIUWC7KZVTHGJKIZ4M3LI3JJYVAAINJX/

[2]
diff --git a/drivers/net/ethernet/mellanox/mlxsw/item.h b/drivers/net/ethernet/mellanox/mlxsw/item.h
index e92cadc98128..d2c8f436efb7 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/item.h
+++ b/drivers/net/ethernet/mellanox/mlxsw/item.h
@@ -290,13 +290,13 @@ static struct mlxsw_item __ITEM_NAME(_type, _cname, _iname) = {			\
 	.size = {.bits = _sizebits,},						\
 	.name = #_type "_" #_cname "_" #_iname,					\
 };										\
-static inline u8								\
+static inline u8 __maybe_unused							\
 mlxsw_##_type##_##_cname##_##_iname##_get(const char *buf, unsigned short index)\
 {										\
 	return __mlxsw_item_get8(buf, &__ITEM_NAME(_type, _cname, _iname),	\
 				 index);					\
 }										\
-static inline void								\
+static inline void __maybe_unused						\
 mlxsw_##_type##_##_cname##_##_iname##_set(char *buf, unsigned short index,	\
 					  u8 val)				\
 {										\
@@ -311,11 +311,13 @@ static struct mlxsw_item __ITEM_NAME(_type, _cname, _iname) = {			\
 	.size = {.bits = _sizebits,},						\
 	.name = #_type "_" #_cname "_" #_iname,					\
 };										\
-static inline u16 mlxsw_##_type##_##_cname##_##_iname##_get(const char *buf)	\
+static inline u16 __maybe_unused						\
+mlxsw_##_type##_##_cname##_##_iname##_get(const char *buf)			\
 {										\
 	return __mlxsw_item_get16(buf, &__ITEM_NAME(_type, _cname, _iname), 0);	\
 }										\
-static inline void mlxsw_##_type##_##_cname##_##_iname##_set(char *buf, u16 val)\
+static inline void __maybe_unused						\
+mlxsw_##_type##_##_cname##_##_iname##_set(char *buf, u16 val)			\
 {										\
 	__mlxsw_item_set16(buf, &__ITEM_NAME(_type, _cname, _iname), 0, val);	\
 }
@@ -331,13 +333,13 @@ static struct mlxsw_item __ITEM_NAME(_type, _cname, _iname) = {			\
 	.size = {.bits = _sizebits,},						\
 	.name = #_type "_" #_cname "_" #_iname,					\
 };										\
-static inline u16								\
+static inline u16 __maybe_unused						\
 mlxsw_##_type##_##_cname##_##_iname##_get(const char *buf, unsigned short index)\
 {										\
 	return __mlxsw_item_get16(buf, &__ITEM_NAME(_type, _cname, _iname),	\
 				  index);					\
 }										\
-static inline void								\
+static inline void __maybe_unused						\
 mlxsw_##_type##_##_cname##_##_iname##_set(char *buf, unsigned short index,	\
 					  u16 val)				\
 {										\
@@ -352,11 +354,13 @@ static struct mlxsw_item __ITEM_NAME(_type, _cname, _iname) = {			\
 	.size = {.bits = _sizebits,},						\
 	.name = #_type "_" #_cname "_" #_iname,					\
 };										\
-static inline u32 mlxsw_##_type##_##_cname##_##_iname##_get(const char *buf)	\
+static inline u32 __maybe_unused						\
+mlxsw_##_type##_##_cname##_##_iname##_get(const char *buf)			\
 {										\
 	return __mlxsw_item_get32(buf, &__ITEM_NAME(_type, _cname, _iname), 0);	\
 }										\
-static inline void mlxsw_##_type##_##_cname##_##_iname##_set(char *buf, u32 val)\
+static inline void __maybe_unused						\
+mlxsw_##_type##_##_cname##_##_iname##_set(char *buf, u32 val)			\
 {										\
 	__mlxsw_item_set32(buf, &__ITEM_NAME(_type, _cname, _iname), 0, val);	\
 }
@@ -372,13 +376,13 @@ static struct mlxsw_item __ITEM_NAME(_type, _cname, _iname) = {			\
 	.size = {.bits = _sizebits,},						\
 	.name = #_type "_" #_cname "_" #_iname,					\
 };										\
-static inline u32								\
+static inline u32 __maybe_unused						\
 mlxsw_##_type##_##_cname##_##_iname##_get(const char *buf, unsigned short index)\
 {										\
 	return __mlxsw_item_get32(buf, &__ITEM_NAME(_type, _cname, _iname),	\
 				  index);					\
 }										\
-static inline void								\
+static inline void __maybe_unused						\
 mlxsw_##_type##_##_cname##_##_iname##_set(char *buf, unsigned short index,	\
 					  u32 val)				\
 {										\
@@ -393,11 +397,13 @@ static struct mlxsw_item __ITEM_NAME(_type, _cname, _iname) = {			\
 	.size = {.bits = _sizebits,},						\
 	.name = #_type "_" #_cname "_" #_iname,					\
 };										\
-static inline u64 mlxsw_##_type##_##_cname##_##_iname##_get(const char *buf)	\
+static inline u64 __maybe_unused						\
+mlxsw_##_type##_##_cname##_##_iname##_get(const char *buf)			\
 {										\
 	return __mlxsw_item_get64(buf, &__ITEM_NAME(_type, _cname, _iname), 0);	\
 }										\
-static inline void mlxsw_##_type##_##_cname##_##_iname##_set(char *buf, u64 val)\
+static inline void __maybe_unused						\
+mlxsw_##_type##_##_cname##_##_iname##_set(char *buf, u64 val)			\
 {										\
 	__mlxsw_item_set64(buf, &__ITEM_NAME(_type, _cname, _iname), 0,	val);	\
 }
@@ -413,13 +419,13 @@ static struct mlxsw_item __ITEM_NAME(_type, _cname, _iname) = {			\
 	.size = {.bits = _sizebits,},						\
 	.name = #_type "_" #_cname "_" #_iname,					\
 };										\
-static inline u64								\
+static inline u64 __maybe_unused						\
 mlxsw_##_type##_##_cname##_##_iname##_get(const char *buf, unsigned short index)\
 {										\
 	return __mlxsw_item_get64(buf, &__ITEM_NAME(_type, _cname, _iname),	\
 				  index);					\
 }										\
-static inline void								\
+static inline void __maybe_unused						\
 mlxsw_##_type##_##_cname##_##_iname##_set(char *buf, unsigned short index,	\
 					  u64 val)				\
 {										\
@@ -433,19 +439,19 @@ static struct mlxsw_item __ITEM_NAME(_type, _cname, _iname) = {			\
 	.size = {.bytes = _sizebytes,},						\
 	.name = #_type "_" #_cname "_" #_iname,					\
 };										\
-static inline void								\
+static inline void __maybe_unused						\
 mlxsw_##_type##_##_cname##_##_iname##_memcpy_from(const char *buf, char *dst)	\
 {										\
 	__mlxsw_item_memcpy_from(buf, dst,					\
 				 &__ITEM_NAME(_type, _cname, _iname), 0);	\
 }										\
-static inline void								\
+static inline void __maybe_unused						\
 mlxsw_##_type##_##_cname##_##_iname##_memcpy_to(char *buf, const char *src)	\
 {										\
 	__mlxsw_item_memcpy_to(buf, src,					\
 			       &__ITEM_NAME(_type, _cname, _iname), 0);		\
 }										\
-static inline char *								\
+static inline char * __maybe_unused						\
 mlxsw_##_type##_##_cname##_##_iname##_data(char *buf)				\
 {										\
 	return __mlxsw_item_data(buf, &__ITEM_NAME(_type, _cname, _iname), 0);	\
@@ -460,7 +466,7 @@ static struct mlxsw_item __ITEM_NAME(_type, _cname, _iname) = {			\
 	.size = {.bytes = _sizebytes,},						\
 	.name = #_type "_" #_cname "_" #_iname,					\
 };										\
-static inline void								\
+static inline void __maybe_unused						\
 mlxsw_##_type##_##_cname##_##_iname##_memcpy_from(const char *buf,		\
 						  unsigned short index,		\
 						  char *dst)			\
@@ -468,7 +474,7 @@ mlxsw_##_type##_##_cname##_##_iname##_memcpy_from(const char *buf,		\
 	__mlxsw_item_memcpy_from(buf, dst,					\
 				 &__ITEM_NAME(_type, _cname, _iname), index);	\
 }										\
-static inline void								\
+static inline void __maybe_unused						\
 mlxsw_##_type##_##_cname##_##_iname##_memcpy_to(char *buf,			\
 						unsigned short index,		\
 						const char *src)		\
@@ -476,7 +482,7 @@ mlxsw_##_type##_##_cname##_##_iname##_memcpy_to(char *buf,			\
 	__mlxsw_item_memcpy_to(buf, src,					\
 			       &__ITEM_NAME(_type, _cname, _iname), index);	\
 }										\
-static inline char *								\
+static inline char * __maybe_unused						\
 mlxsw_##_type##_##_cname##_##_iname##_data(char *buf, unsigned short index)	\
 {										\
 	return __mlxsw_item_data(buf,						\
@@ -491,14 +497,14 @@ static struct mlxsw_item __ITEM_NAME(_type, _cname, _iname) = {			\
 	.size = {.bytes = _sizebytes,},						\
 	.name = #_type "_" #_cname "_" #_iname,					\
 };										\
-static inline u8								\
+static inline u8 __maybe_unused							\
 mlxsw_##_type##_##_cname##_##_iname##_get(const char *buf, u16 index)		\
 {										\
 	return __mlxsw_item_bit_array_get(buf,					\
 					  &__ITEM_NAME(_type, _cname, _iname),	\
 					  index);				\
 }										\
-static inline void								\
+static inline void __maybe_unused						\
 mlxsw_##_type##_##_cname##_##_iname##_set(char *buf, u16 index, u8 val)		\
 {										\
 	return __mlxsw_item_bit_array_set(buf,					\

[3]
$ make -j8 CC=clang C=2 W=1 drivers/net/ethernet/mellanox/mlxsw/                                                                                      
  DESCEND bpf/resolve_btfids                                                          
  DESCEND objtool                                                                     
  CHECK   scripts/mod/empty.c                                                         
  CALL    scripts/atomic/check-atomics.sh                                             
  CALL    scripts/checksyscalls.sh                                                    
  CHECK   drivers/net/ethernet/mellanox/mlxsw/core.c              
  CHECK   drivers/net/ethernet/mellanox/mlxsw/core_acl_flex_keys.c       
  CHECK   drivers/net/ethernet/mellanox/mlxsw/core_acl_flex_actions.c
  CHECK   drivers/net/ethernet/mellanox/mlxsw/core_env.c     
  CHECK   drivers/net/ethernet/mellanox/mlxsw/core_hwmon.c       
  CHECK   drivers/net/ethernet/mellanox/mlxsw/core_thermal.c   
  CHECK   drivers/net/ethernet/mellanox/mlxsw/pci.c         
  CHECK   drivers/net/ethernet/mellanox/mlxsw/i2c.c         
  CHECK   drivers/net/ethernet/mellanox/mlxsw/spectrum.c     
  CHECK   drivers/net/ethernet/mellanox/mlxsw/spectrum_buffers.c         
  CHECK   drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c    
  CHECK   drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c  
  CHECK   drivers/net/ethernet/mellanox/mlxsw/spectrum_router_xm.c
  CHECK   drivers/net/ethernet/mellanox/mlxsw/spectrum1_kvdl.c  
  CHECK   drivers/net/ethernet/mellanox/mlxsw/spectrum2_kvdl.c
  CHECK   drivers/net/ethernet/mellanox/mlxsw/spectrum_kvdl.c 
  CHECK   drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_tcam.c
  CHECK   drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_ctcam.c
  CHECK   drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_atcam.c
  CHECK   drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_erp.c
  CHECK   drivers/net/ethernet/mellanox/mlxsw/spectrum1_acl_tcam.c
  CHECK   drivers/net/ethernet/mellanox/mlxsw/spectrum2_acl_tcam.c
  CHECK   drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_bloom_filter.c
  CHECK   drivers/net/ethernet/mellanox/mlxsw/spectrum_acl.c
  CHECK   drivers/net/ethernet/mellanox/mlxsw/spectrum_flow.c
  CHECK   drivers/net/ethernet/mellanox/mlxsw/spectrum_matchall.c
  CHECK   drivers/net/ethernet/mellanox/mlxsw/spectrum_flower.c
  CHECK   drivers/net/ethernet/mellanox/mlxsw/spectrum_cnt.c
  CHECK   drivers/net/ethernet/mellanox/mlxsw/spectrum_fid.c
  CHECK   drivers/net/ethernet/mellanox/mlxsw/spectrum_ipip.c
  CHECK   drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_flex_actions.c
  CHECK   drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_flex_keys.c
  CHECK   drivers/net/ethernet/mellanox/mlxsw/spectrum1_mr_tcam.c
  CHECK   drivers/net/ethernet/mellanox/mlxsw/spectrum2_mr_tcam.c
  CHECK   drivers/net/ethernet/mellanox/mlxsw/spectrum_mr_tcam.c
  CHECK   drivers/net/ethernet/mellanox/mlxsw/spectrum_mr.c
  CHECK   drivers/net/ethernet/mellanox/mlxsw/spectrum_qdisc.c
  CHECK   drivers/net/ethernet/mellanox/mlxsw/spectrum_span.c
  CHECK   drivers/net/ethernet/mellanox/mlxsw/spectrum_nve.c
  CHECK   drivers/net/ethernet/mellanox/mlxsw/spectrum_nve_vxlan.c
  CHECK   drivers/net/ethernet/mellanox/mlxsw/spectrum_dpipe.c
  CHECK   drivers/net/ethernet/mellanox/mlxsw/spectrum_trap.c
  CHECK   drivers/net/ethernet/mellanox/mlxsw/spectrum_ethtool.c
  CHECK   drivers/net/ethernet/mellanox/mlxsw/spectrum_policer.c
  CHECK   drivers/net/ethernet/mellanox/mlxsw/spectrum_dcb.c
  CHECK   drivers/net/ethernet/mellanox/mlxsw/spectrum_ptp.c
  CHECK   drivers/net/ethernet/mellanox/mlxsw/minimal.c
