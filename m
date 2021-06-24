Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C6863B2548
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 05:08:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbhFXDKw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 23:10:52 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:6550 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229759AbhFXDKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 23:10:49 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15O36LQb027553;
        Thu, 24 Jun 2021 03:08:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2020-01-29;
 bh=OtS+u9b8LmwQYXh45YHCoC0x0b5J2XPtKcZReqY1i9Y=;
 b=vg0m181L2PCOSsblhKFAmQaR3JtbmFtvp0l9aIvRipnshrWeGgY317gM+VDBu7uQgsk5
 fl9yiduBjEfY/OA9DYZVJ0m1laLFVmEbsdq+BOtX7UrbvYSLCmxgg9Q4L9ywV7hSN3mG
 RbTJcWcT10fp8egu3A7beWmuHuiCmmN3GR2N6sqFbeGNjVQHdeoqcfia3GRbK3eSTYIq
 x0HffacUhUzr68DChTZrjEdxZ9DrR9g3jbXSY3J68pgTkxEI/EqWesuK5E+KHSAALSIa
 JuKVPtzB3OCq8KI/Wr96YWQQzxyF5fvLV7Wzu9dG5KGO7hVbgQBYN7E+75wLJSjdZvVJ tA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 39cd2krb3v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Jun 2021 03:08:19 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15O31Xug096615;
        Thu, 24 Jun 2021 03:08:18 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
        by aserp3020.oracle.com with ESMTP id 3998d9xm8h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Jun 2021 03:08:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V4AjHq2JMbaV1l86rzdsIq2oRV4hWLVAe3YfQoiFqkKUS3gPzdZU58Ste3U2X82Lr1VmeJTsAG+u4q4Hv6XbeOf3wFBstOn6E76bhm8+CUIw0ilTOFkxDXhIqBfbDgO/r8CWgKKvzfw7GQio49JKYE5L1O4ISwK605+f8FyGnHVXjQxtjBr506f9bYggMvynnI0XCMXThkkkOrR9X74kEw3aP1kY+Df9tRIMr/Bs34qA5/Tbbath6cv2YQHe8FCXkfMaxERG9RN4d3BL8TAYAIBSJ8kpWWYh9+vqQp9yOfqFZU/RwiXyD6txS6DOmvsTC+auIRgSAVSVbtEohZnpJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OtS+u9b8LmwQYXh45YHCoC0x0b5J2XPtKcZReqY1i9Y=;
 b=HOsDxlqmesd6PYtyNc2yn+D6W13GteUC/JowPVA0z9zBmepQcN8/VttWnWF2wRi12SzM09D/5cK/P0CMU0LU0h3gBdmBXujY3Ri+QlbtO4r67C6Xe9WxO9wO+NfVaPo/ZlpEGrhdIaiozETvlLsi57pipVRNuuJQKaprTkFoICL4/0lA0RG6VXKK0Jx4kAXxtuD6n0HACYy71/tG8hZ3j1oJ8NDGE8RwuuLj06eTTXp1yVDZqN4izDM63LW6xkft42PWz6VeEwj58AeEZLihJ33o9C3do3fmHB72o6O53nLzG0ddT6jbVpIyXtd3axt8nMn+4ypBgZ0dByhUL9DA+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OtS+u9b8LmwQYXh45YHCoC0x0b5J2XPtKcZReqY1i9Y=;
 b=WsRyxG/t9XzGxr5Xyu9NecKxIInAA0BQz9xao5IW0cHfI5BGPnpfbT2V1OpN9abQ0pGLiixbBSiTDKqh+LlP1O8CeXZ/aV3VnSFUhI9L1mJ8hhYOaHV4nL8f3kvtyo+h5LJu1cz0cf5NwbJ9Kz0R0LgndYK2PtuRwHHGa8QyuOc=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB3573.namprd10.prod.outlook.com (2603:10b6:a03:11e::32)
 by BYAPR10MB2837.namprd10.prod.outlook.com (2603:10b6:a03:81::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18; Thu, 24 Jun
 2021 03:08:15 +0000
Received: from BYAPR10MB3573.namprd10.prod.outlook.com
 ([fe80::b09d:e36a:4258:d3d0]) by BYAPR10MB3573.namprd10.prod.outlook.com
 ([fe80::b09d:e36a:4258:d3d0%7]) with mapi id 15.20.4242.025; Thu, 24 Jun 2021
 03:08:15 +0000
From:   Mike Christie <michael.christie@oracle.com>
To:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, mst@redhat.com,
        sgarzare@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
        christian@brauner.io, akpm@linux-foundation.org,
        peterz@infradead.org, christian.brauner@ubuntu.com
Subject: [PATCH 0/3] kthread: pass in user and check RLIMIT_NPROC
Date:   Wed, 23 Jun 2021 22:08:01 -0500
Message-Id: <20210624030804.4932-1-michael.christie@oracle.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [73.88.28.6]
X-ClientProxiedBy: DM5PR2001CA0008.namprd20.prod.outlook.com
 (2603:10b6:4:16::18) To BYAPR10MB3573.namprd10.prod.outlook.com
 (2603:10b6:a03:11e::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (73.88.28.6) by DM5PR2001CA0008.namprd20.prod.outlook.com (2603:10b6:4:16::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18 via Frontend Transport; Thu, 24 Jun 2021 03:08:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b9a87bc2-40b1-4208-a711-08d936bd4f06
X-MS-TrafficTypeDiagnostic: BYAPR10MB2837:
X-Microsoft-Antispam-PRVS: <BYAPR10MB28374C04CE0DE060BD80762DF1079@BYAPR10MB2837.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uzlICyCpoRna8A/x37hsLA7/xhwMrunM1QGPcWKuFwerrSR9VtkmXhTwRvsfwSZ83nQKPVVrN7Gik/3SjzJi6ulf7q4Pw9K2S+On/XUdl0aOTd7ln6bFSnPBH+/wQJndAS97hYeTcIEfxOiaqbKwH24+t6yPdSawllD8aP54PQIdU9cmCJG1IAc+kO7tRsOmDk9bWX4bePX1KCFKOK51o6HoFdfAeXPhjozzThYtXnY/1wqv0G1IgSEjsIxDJhrasbKZ39aW6T7sH5ylDDacObb6ti3rFBCxNh8DC4Mz+kdUdWkHJD9f5CeU0CnC7zUIDslPobgLInvbNWAYXv++46agsQITiM2OfSwcQsI5a0DWMzMouxPcCX5ol/l8W72LJyMEWrNOMYKEkdhdY05HKLkbZcTUCHMjpSeO8XgJxeIHfqMvMiAdzKFM7bH53QoyX5buSpzUOSqMHJwiV/Q2tcdYCjCUYRhkJXX+tqbugHzwPOzpiHLP0IgLsgpTncH4c/lyOhuYuT6eCsriO79fz8qrc4NBdsVXNp3uXGXcBCv2MGFP91/wqW+0pfJ8TJIEeWEsAi1XPbHIVRRnRKxOk/aKs6lJpW+/Y6Xq1RnvRnLMUSK1Uu7ht/OhgQpr3/Z8WPeWHqmAyyxSNkhfVV4TTDLGOy6g37yj0RYZmBUxOKOhRFX0S6dMWBXuY2ttfAogdCqLwy3R4PjLmBwX0sDd4w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3573.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(136003)(346002)(376002)(39860400002)(66946007)(66476007)(66556008)(5660300002)(4744005)(2906002)(2616005)(6512007)(26005)(6506007)(316002)(186003)(52116002)(16526019)(956004)(1076003)(7416002)(8676002)(478600001)(38350700002)(38100700002)(921005)(83380400001)(6666004)(8936002)(6486002)(36756003)(86362001)(69590400013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3m+FJEiC0tZNY5nvHI5Lv8sBYVhMgCAtjkeLfyr5hVgoXuHk3/OCmjnCmIAM?=
 =?us-ascii?Q?+4erI8Fei/Sg1NSE/kRuz75e3UXmG7OHyukEh7k+1sm+Xv96XHAjq1Bhl5vI?=
 =?us-ascii?Q?aA/KQCJ4U+eHMQqJyp7dk6WqN8SlY1O68R55XP9rc0mLSTEv5ExeW1aBuevv?=
 =?us-ascii?Q?Qbli9uaUAHW18QppWXCkR1reex9OtW1CGFSNzApAVAi/ky7Bi/HwqtthLBdo?=
 =?us-ascii?Q?/HJNyeCHr0I8MSNXSfNPnxFW1jH+3lDX/+UrFrs44j0bkHH50Oj+kkJQs5zV?=
 =?us-ascii?Q?hJr+nfBR1tL3ct1D+FeClg9bbgbGzg091d/UfHP082uveqiyBTzmDqp/NroA?=
 =?us-ascii?Q?lRcUvU+mGsg4x28LSt8T3ecTrw33Vbm5UdIfeI4ePGU+1UrJrhfXN0SoP5Vn?=
 =?us-ascii?Q?K4gOpREz9EzZ+7thTlUsDKjbeBcUqI+LUTTJhUOv8EtoobBSEQVBvbNnLFoG?=
 =?us-ascii?Q?1zjmC4RRTuwY3y9SCGWvckMl7Ek2lSKZQLZmGJLn7Sep9lz4tpMmZdQ0CM0A?=
 =?us-ascii?Q?ZDqg0xdsWwfzw0PuwRYlMGUxM8Jk8cQ69QpUjFC6gyIx8FbZVQHO1gpw9BYE?=
 =?us-ascii?Q?k3ZkV274zNt676WhUEKF+dYCpC4YvkQMEhBItmh73LCqFwULSrWfJrlGYuOL?=
 =?us-ascii?Q?XodONsDEb0AOxVwroX3Aeq46Dw8iDgMEXFCLHevz/ZUoAAEXqMuemYWWEqc4?=
 =?us-ascii?Q?dS7Ski0Cp0dtE0HNedv8o46ZRdvr/F4OAFrmaPNXCnNpMITnBj56YrQPeGgt?=
 =?us-ascii?Q?SBE8wlohOQKf1m5IPQToRTrxpUIg/cSc+r36zN8QzjFDbE/gd9qFrQ3dzJAA?=
 =?us-ascii?Q?QpzNOUWj1ogeUn0VBADIZwT1yE64VyLo6RKGvmaZESD6FNk9vIYwHVAfikKx?=
 =?us-ascii?Q?WApacLCCcU2sQplm6+Vyju7lBCussvX5ed/FrEgHRyV4b+S8SV9IgyyRXb5M?=
 =?us-ascii?Q?GriIjPju0EKbcBFLXkhPiVKeqS6xop+Osb0MXYMxdV9eHcOJ40ZCGa5ECsnR?=
 =?us-ascii?Q?eOqAL2/I4NMMWG3z82TrLCgdB7fGmg/qpCEV7eBwtRRwZXbZ9tG+I/yAkAVw?=
 =?us-ascii?Q?iL0dapVtiggW2ELww/5sZaH1aKlHR4zkhPQ0b8j8M/hUFL77u8pfKP2QKCej?=
 =?us-ascii?Q?J29Vao1uh8ft3Je7vrGKf0q3DUEN4sooZbkUwv8hkLzyNgUqkenIiXK7SIGL?=
 =?us-ascii?Q?2ermtkwNpIcSABn/r+sSr0cmckg0crj5Sgt8YX1xK+nEa2ZJmENhoFg6NdU5?=
 =?us-ascii?Q?fC5y0PG3PAvYiVuk1L4jERMQgzAmytflTY0ZUp4mVFsbm9nxh1/61aZMYG4z?=
 =?us-ascii?Q?QVhzLKuDaS2rZtrS7EoTDWsX?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9a87bc2-40b1-4208-a711-08d936bd4f06
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3573.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2021 03:08:15.6508
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lFoOVylEKu4sNhSJQorNyLgG6/MFHT5o+Hn75keH9vqjarK+QcmFq4IRmeflXlInbgouVw6C3AgE3ktxSGNxT3/Imzl1lDVmpLkTF9rnvmg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2837
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10024 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 adultscore=0
 mlxlogscore=970 phishscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106240016
X-Proofpoint-GUID: vOqMv72YK3jhLlyhOyPorZn4O9224N5i
X-Proofpoint-ORIG-GUID: vOqMv72YK3jhLlyhOyPorZn4O9224N5i
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The vhost driver will create a kthread when userspace does a
VHOST_SET_OWNER ioctl, but the thread is charged to the kthreadd thread.
We can then end up violating the userspace process's RLIMIT_NPROC. This
patchset allows drivers to pass in the user to charge/check.

The patches were made over Linus's current tree.



