Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 737473DD613
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 14:55:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233771AbhHBMzq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 08:55:46 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:18372 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233665AbhHBMzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 08:55:44 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 172CqFTt022929;
        Mon, 2 Aug 2021 12:55:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=DMhPBbB9HsVjWPoR/Ct9eLEdunDaMgcdQClkb4SpWGU=;
 b=BU+CeSb1nwc18fVlIU0nJP1y2x+4Crip8KQbufx7tCCJIkLl0oNRyBnffT/KOaqyKpEq
 GQpG2TSRp31ZcvDKFQUa+aAURXBPoxZnnB3Q7+Y+tbOqnJsUvfn6hWf3fajHHwLCLgeE
 GCeFDY355Gm/kvvHFfMx48yaF94rQJALWh+4u8OfY8ieszDgfA9rVRdne6nsfdpP77YT
 XZoh87DZ/uz0OX0DIMEZ8gwgiNVBRA2cAQ+xAfVLP5aBlz5uy7gdH7sJtJKmTPwWGLor
 L/BX/9TT2752LQUjbA6eBPcqXmSK8pWRFU4KOEZcU/0lWnGY/7xBY9gKhAyFmmr2uk7g 5g== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=DMhPBbB9HsVjWPoR/Ct9eLEdunDaMgcdQClkb4SpWGU=;
 b=EYE6PdXeDjZdCOYEil3f0KDMdMcEYJPndn1ttFtcAxLI0w+8P4+QmAFQZYtg02ce3A0Z
 0OHHsEjyRx76EroSqRBZZWu4cTmClSjqu2YsxkCwMtHPzx43c91Erzxyjok+CNLc2fF0
 CX4hCuEK9kQM5whvbh/L9Hp+KfdrbnZ9U/oIzejMAK2KERm8arMbGh7MLHr+QChDvtVg
 XJ6HgXJn8klg6Eu4Aq42kgCPlAYpKLX9TI/rNf7PzOdAt/Td2MGLImtR0LLpdNpCul5M
 PynzyhssePlexJgh3lr0TLHFNHY6xC+4P8fjG12OJdsTXKPYHv5zxthzjAUYcjFv8Y5N AA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3a6fxh8566-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 02 Aug 2021 12:55:30 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 172CpFHO074970;
        Mon, 2 Aug 2021 12:55:29 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2173.outbound.protection.outlook.com [104.47.58.173])
        by userp3020.oracle.com with ESMTP id 3a5g9t1w1n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 02 Aug 2021 12:55:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GH6wLkkJPbTrX+LH1zIvEBY29O6XZa3NXr6dtosi7LOQFdWsqxkHqud54XNouYoLiHNoZ74K7RxhzRXlB2WiW9dB8fNSUuoztBIMk/S3sZuDNJRMuUGdlccx4U/K3a6rC6DACiye6FblyKGBZZbvE9B8v0Tfp6WPF+nHipfGyOowCrNlTXM7B5HhU0bXGGjcNGPYP3bpY+pFzPQ9+esKhCfb4xKTVcDui/I8M7BwOk9hFICBkSYAvbmDNlXxQxSxWiI3EoWcmIwODcv50qR0ZyPYVQgID9fpbAbwWtguGX2XhZRGkB9xTSaiVP/g+rcaMTxUrirEPy9XXUFsWD9bZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DMhPBbB9HsVjWPoR/Ct9eLEdunDaMgcdQClkb4SpWGU=;
 b=eIPF9v5cNVzyY/s8bAR1IcZVKWcSDERF0e09HG/E2tCvMOepmayg2VskZZpldh2oN3UY0iICGXRpQBB7M/uOn2a0deyuQ8qMolQS1Rmzkgum5sjbmQEvC+ptyP/ii6KuKcdnnsZSnPhNKPqgsrS5zqHwjMANlYVvN6M0ivWzUsqJN9wpJwKgavp+ROLItcbRmlBVyidpvkBoQZWnl3ORO4OoSAwT5AvH/yTuwdwOYeWrfzk2JeyVD4p/KBFdll3zHljLxBsu/fVql81/zzcfAyU9J3EfX9uXF43z8jaGwu8wBuJEjcLCakVGlnhx+VX86yM4iCT/GRtvKKz6rxJvWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DMhPBbB9HsVjWPoR/Ct9eLEdunDaMgcdQClkb4SpWGU=;
 b=dwD5r1KifCvkW306IgBGxy/BwAO5GGmobVe9zHGFqlhaaYhGhOmLR7tSfT5prTOMUtbYSLVnbqEanSne5GEsHj8d3hCZEiqM07JEB2jsDZlWGRJ6CJzMBkQTqir7TdZxlpmX9TGlX8v31WCwVw9qqRmrxdUp/v3+8ADcvxXq9Ns=
Authentication-Results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1902.namprd10.prod.outlook.com
 (2603:10b6:300:10d::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18; Mon, 2 Aug
 2021 12:55:27 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4373.026; Mon, 2 Aug 2021
 12:55:27 +0000
Date:   Mon, 2 Aug 2021 15:55:07 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     "kbuild@lists.01.org" <kbuild@lists.01.org>,
        "lkp@intel.com" <lkp@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Sean Anderson <seanga2@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [kbuild] drivers/pinctrl/pinctrl-k210.c:970 k210_fpioa_probe()
 warn: 'pdata->clk' not released on lines: 962,968.
Message-ID: <20210802125507.GJ25548@kadam>
References: <202107302010.QfgLffbI-lkp@intel.com>
 <DM6PR04MB708187FE0B622791011BEEB7E7EE9@DM6PR04MB7081.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR04MB708187FE0B622791011BEEB7E7EE9@DM6PR04MB7081.namprd04.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0065.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::7)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kadam (102.222.70.252) by JNAP275CA0065.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18 via Frontend Transport; Mon, 2 Aug 2021 12:55:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7209275d-0fbd-42ed-e27f-08d955b4ccc2
X-MS-TrafficTypeDiagnostic: MWHPR10MB1902:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR10MB19029FD4F6AD23C0A8E36C548EEF9@MWHPR10MB1902.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /pFoIKAkFtbSmJlV7Dp10CltUpQk61s0J3X7i7Z/DxsICfO/myfRSCyGwFQSkP+2UeQtBLykJYDW3ijdFtcbEXIPsGyIX2ErbeZIyhcwSoaQqZ/08haxSMhnnw4ra0Onx6UVuu/dTVAbsMBHF+IifqPiavWLHmxHTQQCBG48MBExDnm45r/dWmKg1TZ/bl5Dqzpp1oNoiHe+L7frPZlclJ08MFplFF7SNYb3xYGbVDY49q7Vv1digalg7LVve4d1tufsdph7LuypAmQpEyte2bxVLK4Zgzt5WejC1E2u6Unin4wHnrYMlFDc13rchNU1g4ZuTcYQ8fhmt3rx8DJ6XfRJB8AlFao8TH+YRWiqCcr3PvJ4C4bTA4hjkG6bXAtlhNbwXeUp0XdsmPQo+r8Utx7+qHVY77/M0rlvFA9rvfzMlEBwagY0RGDetMxwYzAWduTdUqHRQ+52IwBtjdWYe1Y8A+G2idbb50YbLvuTEuakG6uG2yJH9uJl3oCj8U/0hOMFJK75iDb+zSzrlA/CgppBk8g2Sr63MVethKbU+jeYw7q3U2KWV/yXsqojtEJlBZuDsPEt4Ks4zfeZThaBVuS/0fBgUVUeRjjq/0t0QkVmH3i5IxkTzpt5HtZubiP82nPS7LPe51wLmmZkdHXvKu7TftzCdZkAJ0sgtHRAy9tr5na+d/xaQWXisCeE5usKCUyuZm3c4QpIO8PSQUFRtg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6916009)(55016002)(186003)(9686003)(1076003)(8676002)(54906003)(33656002)(26005)(38100700002)(83380400001)(4326008)(5660300002)(38350700002)(508600001)(9576002)(66476007)(33716001)(66946007)(956004)(316002)(6666004)(6496006)(44832011)(2906002)(52116002)(8936002)(66556008)(4744005)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LBKmxdzeuV0ourfNWLMG2+bt44ExwPObGdj/DR29TTRED3zgoOZV2PBWy53U?=
 =?us-ascii?Q?yS6n+kolEiA7KqVqQwvfx018HZYECG2i6MJ7IhQMT8UZ8FMeKGDMhiE5fE+x?=
 =?us-ascii?Q?GuHktjSO73wV3Biw79myIFCoBJ9fSe1ebdfZKrChTlqWoMsVGBiWIHfOme1u?=
 =?us-ascii?Q?4BIbxS6pUz7KTgisvyqxAjQcnhRhDPk3ZjrKCvAnjKVH7OjwifKxd1gGPxFq?=
 =?us-ascii?Q?plmKCDeGLMU90p9w4PhV5h167fc8PlUXHzP/xq9Quv08AT/6kb9Rs02om/2t?=
 =?us-ascii?Q?TEPA3R1scXiAYjeHgNGnoPSYe1xIsjCBZkcteEMDVIfC8VkziA0RZi4nE4R0?=
 =?us-ascii?Q?fBDszxn1sX2EhXHK7QP0krT8ShgLRTFdS8GFpCCNWajQiOSp/00v7DnieV7u?=
 =?us-ascii?Q?GrNcnzG1jMPu3BOaLHTYVVrf6A/c8EbN8MrkQnQFnyTrklQaaEdf3loMLGMc?=
 =?us-ascii?Q?H+/Q/aa/A7uJtI5e0yXTDG16tOpHVSrMmgifEkhmOen+bzvp7pPj4MzFv7cE?=
 =?us-ascii?Q?bMyz2s6z/d4QvOcwvujnXd6I5Z2cZQVouqKPhVHi7qDX2V8v/4XUmGa+La2v?=
 =?us-ascii?Q?DhTXpD35SxCt1UVkMRiWEPCM4djkNSxr0XXGHbv42Q+fVpB5Ny3iUXlSWuHk?=
 =?us-ascii?Q?3YgJXT5D/02fcKFvQRAtDuXubKxWtFhg7f/GRgQrw/uSi+k86W4vO1OuYFXV?=
 =?us-ascii?Q?jx0HA2jHsh730mjOW08me8UGtJ3Odpi1OfBdlhbLQUpRW4nX6Xu05P7NiGfu?=
 =?us-ascii?Q?Ikj/pOp2wmpmwRWvlHUMA7ra6RSmkUPTBFMKxgtMnPefUEC/ODFEn8gMJAxE?=
 =?us-ascii?Q?xNxxhrfLHqmQvF4aJ8HOVxyXZWhfVkrdnBhbBXN3aLUR77mP6md/Y58glx0e?=
 =?us-ascii?Q?9yu7mgAQTt6Z113gC748QFSN6E+G5eI43JZuKBxqCJmhj6tm8jm6rGy+OfM/?=
 =?us-ascii?Q?KVkb2TpWBiH0eUPc7kFkDY7Ykhq3zU2CAC5V7MUhVpcBEkoo1JMdqS4mAdR3?=
 =?us-ascii?Q?RINui1/YaYhbeFNKKoYl2X802bVF3DZApS4LRsfBhpGfr1+2ZK2cgwzQlkA7?=
 =?us-ascii?Q?pmSzZ535zX4BXc78qD/X8UmlerBAMna2wdJfqFvlu9t8xy2gLdaSwq9aDidP?=
 =?us-ascii?Q?sR80649/1LlL1KQlUraJPyUAjrKEEdhC6W6BIvRAJljBYt6Ke2KxIo6kF3wR?=
 =?us-ascii?Q?wNb5A1430jWZjpUvP5H1TfWRk/5xxGw6ofbicUetYsN0R9aRyI7ztAq42ZFJ?=
 =?us-ascii?Q?TJIM5Vak848TpKVJVftF66c26OF8UPL3DeQoGTBpVzEzutN0ih0gQqyjQtm4?=
 =?us-ascii?Q?g1PoQRco5x5MLjPUSt4WWuGm?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7209275d-0fbd-42ed-e27f-08d955b4ccc2
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2021 12:55:26.9263
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VuyVad8+GSgFGFKlf7el4dJ9XKTEUOV244Pqg8u2XmalYSIGCva21xjGmlNUjnC+AgwRCbbyIuP8f0qs76kSDox8FuKrAU1rvW2Vgw+0pwQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1902
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10063 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 phishscore=0
 spamscore=0 adultscore=0 suspectscore=0 mlxlogscore=921 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108020086
X-Proofpoint-GUID: mPCWoypuYgrfZiJXmtIR3g_9yEGAZTwr
X-Proofpoint-ORIG-GUID: mPCWoypuYgrfZiJXmtIR3g_9yEGAZTwr
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 01, 2021 at 10:50:51PM +0000, Damien Le Moal wrote:
> 
> I can add the clk_unprepare_disable() call to avoid the warning, but that is
> rather pointless as the system will not boot at all if there is an error here.
> Thoughts ?

These static checker warnings just a one time email service.  If you
don't want to free resources then that's fine.  If people run Smatch
manually then they'll still see the warnings but the kbuild bot won't
email about it again.


regards,
dan carpenter
