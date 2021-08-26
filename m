Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F6063F8DB6
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 20:17:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243269AbhHZSSD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 14:18:03 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:40526 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229733AbhHZSSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 14:18:02 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 17QIEg6e022735;
        Thu, 26 Aug 2021 18:17:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=ciZIWk1Of6npiIry0NIb89HoNuGBE60P92pDJhxT0K4=;
 b=k/ELzpDVXsIpaILhrKN2AOSOTmm3ach/IenrOpMgZGu4vCYqunDPd1xL/DeCXlvcIa71
 ip3pAQZuVkjrHCrh25z3Zz83DLaVxmVjSSH2wFZRB1Q5AcrdYb4CcqL6reKocxDwa1ou
 EnDSdlwie0f1F28jZNB8KGbcwu9IAgRJFLYPc84MLXyMWZu31mJd/bOuMKyFvR7je6OI
 UnT0yYx/cKtzch5N/rK1BwI1aYCBM129sdVHW9V/xnnnOs4zuLQ5TTo9RqeJkFuLYIxE
 +6kI4akEyQdL7Xcryev1FPcDszDTHX4Q5KyuDlrGwRnod+PH5odbeuTetvu77aU4j14B UQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=ciZIWk1Of6npiIry0NIb89HoNuGBE60P92pDJhxT0K4=;
 b=WHH8AsdE1I2Oood3Um25Xiz5J47X1+Iqj8iMl8Jl5ZNRp/9n3kIObY9b7ScCTiq6o/Uj
 /NwacZXSCiVz1l7JunQFVqpcfePkMoaBUcaRBhGrXCMTIJR1Jb75g7FW4p5NKpx2oyPF
 sKRjsP5m8QsCEesoqICQP9Qd33Ruvrxuke3DFtWi+mJN5vP5Z9vZgRta+C/xuKXwrrH6
 B3FBhYFPLOG4zs13WQ1+vPE8kIvPBsI1fcUA/Z3bW8LR1mITQxetpEozkWaZ/jj9RPwz
 q6n7mmdEiM9BAxjvDFbgeoS4KmfZwWx7KU1+rfgIz14ljXJwjOu1cRI9iI6qOOELYYNE zg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ap5529pbu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Aug 2021 18:17:09 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17QIFrd1065693;
        Thu, 26 Aug 2021 18:17:08 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2108.outbound.protection.outlook.com [104.47.58.108])
        by userp3020.oracle.com with ESMTP id 3akb90h5b8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Aug 2021 18:17:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Isi3pAND/GpD+ML33DVCDcLvrt9MXL23vX5yiZyI0BVEORtnS/uf8a0lHgD6fG6S8qclN8XPHXpxuKMS/zgyNpyYFr79DoIYCuw0KOIJIsSr6LYxAKE3SV2oVDbl5SzRyI5jeeaLmenkMP6RTk3fk4G2jW1d4+B+LT2AYCRS6B76+mPBuEu+XZf6mQWsYKjdQB+g/mjVujwd1dwTa4qGD0Z6nTVrLm8oHdiCH3JZdCsRJWCPxE1uAEDxjmCa2ciMGKXKVoHt6rlMMEAB/IwVPLoTu0FGAZsTfpm5/6mrLal+VLRcmisy2Xrxs/F3Rdeg9pJd4WQZmaAHwc+BMN2G9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ciZIWk1Of6npiIry0NIb89HoNuGBE60P92pDJhxT0K4=;
 b=HoevK24JtXLIgivGPBpWzuoFEQW0JIWOrHxXetypvIw0v96NOGF8l83YPS8+PN2kgarJjQSSh/rO6lMQQfSu/EXq8qvcZWZPbDWzZLnlADR+824EW3KWj/JS4KuVITOa5zq15bhMNK/ue+TQIQIZoU8mCZ33h9rY6r2M5rYvY4yCpJ+rNKBMEXP/XQOh9uvGCC6nFedl6wi1pmQ/xhpe8EByZItPgPPEPg/ZvKEgJ71T0C0aSOdsyremENMaCHyCSJ1lmUBV99bfYXb71XPHdiAbqOsqrENCxsncPt16RtmJfVgzXpELCW6R/zJA1nfHJP/HDkZlGen86FLx7Siprw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ciZIWk1Of6npiIry0NIb89HoNuGBE60P92pDJhxT0K4=;
 b=EcuYAO2nk9cTDWhTO/NNUs6mmGHFbAO/ZZsiIm+hJDuyUlnJWYx6j/V8mZO1WYfKlMqUvBgqdjJgFkOTbRFqidTQxc7j3jDQYTbQs4ANv18keB6aOZpkScO2DSFWN43/2ZVx/Jgv5oUNutXHhzdMUQOfnT5GNOHCSRPAQ94i0xI=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO6PR10MB5410.namprd10.prod.outlook.com
 (2603:10b6:303:13d::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.20; Thu, 26 Aug
 2021 18:17:06 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4457.019; Thu, 26 Aug 2021
 18:17:06 +0000
Date:   Thu, 26 Aug 2021 21:16:48 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Fabio Aiuto <fabioaiuto83@gmail.com>
Cc:     Wenlong Zhang <yixiaonn@gmail.com>, gregkh@linuxfoundation.org,
        ross.schm.dev@gmail.com, marcocesati@gmail.com,
        insafonov@gmail.com, cyruscyliu@gmail.com, yajin@vm-kernel.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH] staging: rtl8723bs: prevent ->ssid overflow in
 rtw_wx_set_scan()
Message-ID: <20210826181648.GC1931@kadam>
References: <20210826154622.55361-1-yixiaonn@gmail.com>
 <20210826172618.GB1423@agape.jhs>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210826172618.GB1423@agape.jhs>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0039.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4e::6)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kadam (62.8.83.99) by JNAP275CA0039.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4e::6) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.21 via Frontend Transport; Thu, 26 Aug 2021 18:17:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4ef34d30-b105-49aa-07ef-08d968bdb5ea
X-MS-TrafficTypeDiagnostic: CO6PR10MB5410:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO6PR10MB5410737491C5E842DE36B0618EC79@CO6PR10MB5410.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NGhYe6q0XzMLz/joHRxgWXdKUphPFywOMLVGRWqc6kNNb8M0CGj3bGiXSn16K4sIyGVG/AJRnc0I2vyKstpTDiSK0ZjkNlcOZ55TyCvwfJtLbacbBc5HlfMqEx6avvpE+i5RmkpVDpzLWFTWXK0E1LLzb7B1TWAEGDNYI3iWztBqjhnlAXaosNPGvbojPcM20d/rt8X67ATi7Uk4m5ATNDds7ge13by++Eq/OiRYJjPwE2r7uZx0E7Z6JD3Wq6+B+2y0z73YbnWHcO1o1yesxgAaRaMzBSNIsxkz2+gJRIHaERDoxoqWADfHuqy8kgtHVtBZ1ItTOyFzvKORX8zdkS+klYOBiGyoO/Hj03B1ZqZkua3+CTio6/XK5Ukg/KqWyxiJt8asOiCJZGyIkpd7uR4b79eoYJ3dP1WaHlqpHh0WDeRQfb/BYkyTuwKGuoh1M0BTzqGkWhGY7jj0PAR2aIVcdGxh3IjT4sJDi+LCElckj/+aNvnMDEL3Z07hrpKU+S+TLqB4//BSMxZPJb4DxHOf3Vf/UjUGE2tZuYmEpX4O3Ii8yyOOZS5YfpNRbIEpUQ04kwREpMHMRvdgyR7QFAB0cxI2OxzdpQiYDXzuvJFCMIcU6XLWd7GnCYN3tIxRlTXxNa4WsFACdSxyyKxmjmcl1pPwYLaelax6LslhfUVM/PX2ZSOdz2z3OwZw5KtNXfF3UyHhaBzbALFhQOY5yQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(346002)(136003)(366004)(396003)(376002)(7416002)(33716001)(26005)(6666004)(66556008)(66476007)(2906002)(66946007)(55016002)(478600001)(9686003)(9576002)(186003)(52116002)(5660300002)(8936002)(86362001)(8676002)(33656002)(6496006)(316002)(1076003)(6916009)(4326008)(83380400001)(4744005)(956004)(38350700002)(38100700002)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5cswfYgb6KWqDQ3Yp72wUZ96g7mMPVwEPIKWL8D4vsAFgqpDpQM9QrX2TOdl?=
 =?us-ascii?Q?Yb7GjOSWJ2ZotJJP9AfjFG2roBufEosrHcB/FF5ubqMBuWYko8gqtEJo8xM1?=
 =?us-ascii?Q?u39iKBFqYJFMBMyITe26OQ+WiEYAqpr4j6giWqnXQlWDk8HtnhvzkQZnYqG3?=
 =?us-ascii?Q?DsWpu5oKBgRzgjc4h8MyNNVmpe9IQh75/2rL4rkK+AS7406ZCwXddUS5TW5C?=
 =?us-ascii?Q?sMVWJp5VhVgCJPFWPxWI+V1vxU1STR7Z1krKOsgXVWIOEIiktkKsY7K4KQcz?=
 =?us-ascii?Q?2SqBl7nPx3e3nmHtor7EKhIXLLmgIFFNSJuoKj3IjpXf6pvha/UDyww7TUjS?=
 =?us-ascii?Q?fJRgk8vAoJn2iAdGWo817KIBs0iLo75rQ205hfHf1swc8gtKtOFVluluDgnw?=
 =?us-ascii?Q?KG9mUvGxS+gPRCTK9ptvig0+yJ9q5L9xKKmA3uG1HuMIJ7N72jGML1Yl41ne?=
 =?us-ascii?Q?/67PER/aDwIaostgwEpYCacqJ59zuPHZfe0zbVyDBd3sG69U6QRiMJCnL3kg?=
 =?us-ascii?Q?lyKfsF+YP+iVNTm5Vns73EaWQBnR5P6CSG0lKfyhVhZVVZVDgTRMeKyeZVUp?=
 =?us-ascii?Q?umjGz9OIsrYcg/pOl7gwUg0jGGlA6x4SV/r1N4NEW988oMAHNcNqRdANX9o8?=
 =?us-ascii?Q?xrFekeBPi/qhFmGM9ye/ZnXdcouE8rIRDXLXGmNLZ7PPZTgyIyNtzBCAd293?=
 =?us-ascii?Q?tbVcG+GJV9n/YvABGDilQbeDc0cc90UC+Jr0zzYCvR+CX4iW6y4A9viV5bCv?=
 =?us-ascii?Q?u0ycOr3fXzlC4oa8/f8ItSMnXJEqQYhQtY5KrrzA3N59xICOSWOmKhkAVIhY?=
 =?us-ascii?Q?HFXvd406v1XHQ5HcVQGSEaw7VJhl8EYu6AGrm33lZe7W8aQs5tQxOnj8AJ5X?=
 =?us-ascii?Q?Cs5wQim+tscB9PBHrROprAf8rescJLzpbkBGMWFLLb6riMQv/QPUPsmYhaEt?=
 =?us-ascii?Q?mQSPEZXFmCrw6RJO9o0O35tEaf2vlL09vWe4tFDfhI+7fQf8ub3ju+ssDDf3?=
 =?us-ascii?Q?seWJUKBjNUmtmh5dkE8RF+m48NUzugk+UAUNCnThRWjAPCjo8skgUOW72z04?=
 =?us-ascii?Q?89n3c1yWAmrjP7ghJ4+nh672XfYS7m2j7WF+pkPdapImDF5/AvupbosG4Ji4?=
 =?us-ascii?Q?m4M96NQOIE4IG15+k1bpkKQ6xWSG+IN3t7UqVw/2X8IZOhmdM5AeIP61yJAA?=
 =?us-ascii?Q?SBLpmyuCwjA5cl/U3bkpQEpNIbdLSooP/JiYmRdMhmrpJImfG9Gij1jkz/nJ?=
 =?us-ascii?Q?5zCt6aBDdgNL1Y6NCdLycEFHxeJ+McNcopQ8D2CZeawU0D2abKZNElkeSb9s?=
 =?us-ascii?Q?M3mnCfGX3NHv9maXEmACsXOV?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ef34d30-b105-49aa-07ef-08d968bdb5ea
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2021 18:17:06.2117
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v4R9/GuJcUn+Y0TOICJQXQY6PEqrERvsZrw8jZP6JUtIhmhBeKkE2T2LnzgQTxbdXV6BBXcIeDuMCrywm6EvFX9K3upOifQLNiXxwaN73tI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5410
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10088 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 spamscore=0
 bulkscore=0 mlxlogscore=999 malwarescore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108260101
X-Proofpoint-GUID: kIa9l5QMMedQ6jqUTB0YN3Ze9e73IgyQ
X-Proofpoint-ORIG-GUID: kIa9l5QMMedQ6jqUTB0YN3Ze9e73IgyQ
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 26, 2021 at 07:26:19PM +0200, Fabio Aiuto wrote:
> today the patch which removes wext handlers has been accepted
> (commit 174ac41a7aafb31041cba3fe54ccd89b9daeef5d)
> in staging-testing so maybe rtw_wx_set_scan is going to disappear.
> 

From a process perspective, in staging we don't track things that might
happen in the future.  We look at each patch in the order that they
arrive and either apply them or reject them.

And from a practical perspective this patch might be something that
people want to backport so it would be nice to apply it.

regards,
dan carpenter
