Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 218B945D50A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 08:02:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345807AbhKYHFi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 02:05:38 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:1654 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1348450AbhKYHDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 02:03:36 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AP6E4MD032742;
        Thu, 25 Nov 2021 07:00:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=Xf0GpArW/ng6EtBK+87kXWN/blV8rL1KPRdCjGdg1jg=;
 b=VyZA8L/xY341l7NfLOmyl66q6OGjGVKiLnFwAbY8ziVXe8EBqqi8lq/PsqHpfUO8SzSZ
 BYlqTH3YSNkTAORCYhOZq4LvPuo+74t/dZYxKn/ve3emf07zPGnsz6S86/1QQoLpIzlJ
 Y5RFf8dP3j7eijVyskfE8EhItPxEMrGK/eLBpSho6UmvTG1mLG6ZoeoHkIrszM/Rr8kt
 CiZ7CGXQLXOc5GMeqbvz3mPorojWpdtCYsPVmWeEDIFS659zFMWR8j1iIcXG4JE9hNOu
 9MBLboiPyhYrTavd1ZWXSltHYs9v1hQtBeMV9iIt/8i+OlHaKg8Ifi0joF427mfyZ69p aQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3chkfkdmna-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Nov 2021 07:00:12 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1AP6pKic053246;
        Thu, 25 Nov 2021 07:00:11 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2047.outbound.protection.outlook.com [104.47.73.47])
        by userp3020.oracle.com with ESMTP id 3chtx7bvcv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Nov 2021 07:00:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=itN2Z/xbENRkNQyuJRS4cKVMz+ijlfmI51lhJij5SFw6jYxgmQzKmShu3RVMza4v8msXyZzFH6ZyFPdKFdAC+9tjARuNAbJivqZngehNd1+V+GNl8clJ44hkpZkYMocguU4zD4yZEgyLgTBQE7Kmxmp3kqp+T0ftIr76WIm9Pue/zC8ZjYElG8+OWuvxOEGUly3CNTlk9SyjV80MXJB3lsWSbVhesmJMosKb+jnB57/rTYmroRxi+ItmzZCM/E1VnTyczkEA+lKcfs6/oJ6fN+5LTJgGO5949LP8CyZB2/BUMWbBKsoBir3z3PjYjwwRyjQrS3FPiJUdjTFhbTTbBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xf0GpArW/ng6EtBK+87kXWN/blV8rL1KPRdCjGdg1jg=;
 b=np8Dixn0+7kUMpCDIkudAa6+IPwHys9+blV2XutREiA2l0sMSBUYRsbmdHRMJZXmnCjWhIDlOcIPMBC6HGXJk6gJDDkA6VT3kyMOwV6mqcb6jSwLRWM0tUv6muyHe0P3Z2tLo27YCw7b0nsit1t/eUHGc6mLhW6yZTgFUMV7r/gaIuNG970BXmZI3v6WSKMkGnKzw7BPkFx/8XThG8YRWSMilfSc92sJEjGDixOukdL5AJ+hV4Yjz1jC+6zOfSeKBsqgH+tyH0+O9VhBeFO8gSMO/vWK8sAOJUQtYSH99Vt+q1sWZzWc8K8EDoVaGr7Xe4epIfjZERzUOVhNCH+k3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xf0GpArW/ng6EtBK+87kXWN/blV8rL1KPRdCjGdg1jg=;
 b=KuGufHitXW9jjUmel3K2/oPs6iQatgB0sn/YPduqZwur2NXlc8fMTIY7nyDJ55JebsPI3gnM2Z+svSTiQnMqlM5t78selnuRGf2yT3ukQBVgw3xfi4Pwuz53J4j09Oeo00pUEwo5Rlxsy53VymQtRc2KFjLbUB+kVNIKb8TSMfE=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO6PR10MB5789.namprd10.prod.outlook.com
 (2603:10b6:303:140::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Thu, 25 Nov
 2021 07:00:09 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0%6]) with mapi id 15.20.4734.022; Thu, 25 Nov 2021
 07:00:09 +0000
Date:   Thu, 25 Nov 2021 09:59:45 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Vihas Mak <makvihas@gmail.com>
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        gregkh@linuxfoundation.org, straube.linux@gmail.com,
        nathan@kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: r8188eu: use max() and min() macros
Message-ID: <20211125065945.GL6514@kadam>
References: <20211124190436.251312-1-makvihas@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211124190436.251312-1-makvihas@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0032.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:2::20)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (102.222.70.114) by JN2P275CA0032.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:2::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.20 via Frontend Transport; Thu, 25 Nov 2021 07:00:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 65f33a11-05cd-4b8e-8dcb-08d9afe137d8
X-MS-TrafficTypeDiagnostic: CO6PR10MB5789:
X-Microsoft-Antispam-PRVS: <CO6PR10MB578991EC3003DBF6CFF34FCA8E629@CO6PR10MB5789.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1468;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nc24SXitAnPYrIOfmCSXXMZWUPVMNzcA2ZPowD4UMKNmrMWcwC9cb9xe5IfppupZPCSDfI8dCKVmxBNB2xYsp5FPhgrlPMv4VPPJVrXUYZa1s/DqBdymuiqUGt0ThUAIr0fwQteZOAuHOBEiYD4kjCv999bvQ2ZyxsPU8HupVUgYYWDPqBKRDzdVb1waj+WyEE4r8g7uzTuPCc002Db1eRSsbMMY2th882EGiX2I9ZSOB+syv8afBtN20/PexRKoD1+1SzIZPcptGt4zzFKbuxP1XTQYBqZGuvV1Uf8Ab4UyYoaHKoIU5OfWPNl7jwaxd2qhoYgYOU72CqYXgkx3VhDVtvd09dNZkg0WuMMCDTMyMMH/mQwRIJdkov363UvnQXuK7rOWadMp3+jsZuS2Aa/adAEEcFGnKw2DEBVSekHHsd79mF9nU0IwtmM5nU/Ggpce/oqccHFc/18ny01VpfMi9CyspUZ/5CMPm8H/eUbEV9DK0R1oXXwle32KGSltOROVc0il7DRYLY5IZ8c/Z65criRq92RQRNXciTDVDxZtAgFXIkHf9F6U1pdb2E7Q1ZkptIjQgdOIKbUp7sVQWpRqe5waPtBdtOO3Wwa+AcEXt7G0wHj09LEQl6ZNmGtaVrsrotkgdq4LNfdJi7GBqUqThfhbZtGgkUAdc++6UUxvTssGosbCfmIQXHQlFAIKc7SDs4LhTJKJkIPLV9s9LQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(8936002)(38100700002)(4326008)(6666004)(2906002)(316002)(508600001)(8676002)(5660300002)(44832011)(55016003)(52116002)(6916009)(86362001)(1076003)(66556008)(38350700002)(6496006)(66476007)(9686003)(186003)(9576002)(33656002)(66946007)(956004)(4744005)(33716001)(83380400001)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+7GmlPIX+o3c6Q/i4P83FaRF+lmmKSMHHY/nUM4750CVc9euNDCi/N4tC5Mi?=
 =?us-ascii?Q?23KWjOBBgrgh59CyjUX9Mlkgxda0/dQjln9CDS2IR8WVv8r5dxsHjCiulk/e?=
 =?us-ascii?Q?BhKmtXsA7XYuFUeaRaDLjXyBjzTzqjRDsem7PF8jxiY6jbDFhpDzwSSfcxzD?=
 =?us-ascii?Q?mKFl40dHHaIkR0QwXftRUhnbc5WUloUm6Jc8W5kR8gYHvsu85LFOuVg1aR7M?=
 =?us-ascii?Q?eFJR9NFoWliYq9/JLeBR3iHNcr5mXC9QjTkOpW0BCw0E5f3dhiuLzL6E8jvg?=
 =?us-ascii?Q?h0zQAKOVp9OL/MlF8SM+5x6haP2K2lZn2RiNA+tnDTRT+duZlkdlbR2sHTPU?=
 =?us-ascii?Q?Mi+2Ip+6hznrNUsVoFJ3u6A94u90F8m0CPutSfVve5HPiWL6OuXyrZYVfvmI?=
 =?us-ascii?Q?MGtDEj5od+nAcz5Z3kgab0m3a7DnskJQpB0QBbsPafYrb12RHW921wmvjy5U?=
 =?us-ascii?Q?lkje+dQUWlWR4M6avnCmGpIxmyScEVA4EbjJWFoPMInBh8KvQzBd3HbGYe/u?=
 =?us-ascii?Q?daTD48K6JjAhLPto0opm/jxolz3LT6CUnvVMirafN7zU+Xj7sLE0TaZi7q2Q?=
 =?us-ascii?Q?vvFxBHW1GQQWwuVLFQPWyyqCZNHUCGEqKDmw7s//D8w5vQdDcSt+SENx1Xbp?=
 =?us-ascii?Q?mOOlbiy9pyHP/WUOl37HEp5bqDz6KaEbhc9MPQnNgVaj80YuoMMNhFdtheRu?=
 =?us-ascii?Q?szcA4Y8vr6FpBz1mVnzd3CvTuw82G7N7Q/330xYT7DXKvkMWqHi6HlY5N8ko?=
 =?us-ascii?Q?ykSAAiuzXLlJkP+gnSG5qvPa4ZerDzpremD7wHCP3YLes/CST2V7aGOC2XAK?=
 =?us-ascii?Q?ABnf2hvHr1J0wJbH8sR18mJk0LlcQz7HW1Ft/9VOhfUt0Dywkn5fOoWe4jYz?=
 =?us-ascii?Q?BkuCbudo4i+Q/txym/jco+XTlEsduwMDc9sbGlShVI8jjRlogVkJrtb2XVcD?=
 =?us-ascii?Q?0a6uHGcTSUXgV7pngpcAnfN4XmnKl7Oy4rZ9pjX84PvOTb7aGUn15i1bHNHJ?=
 =?us-ascii?Q?k7uUTR5SBEuOy0/EoncijHOgT1M5Drze6dhUFEbK3GJTXHiaF7lUt03K8HQ5?=
 =?us-ascii?Q?aoFFFl8WRJ4sYD0lUkdqx7VPvbHKRATWX0Pb5A3wVyYORmTrdLOa4xCEfe1T?=
 =?us-ascii?Q?xcbjcBujCiyL/VfQF3KNgF/FdyeOWay10f8fYu/mR0xmwWdSzQyFk141Rb/j?=
 =?us-ascii?Q?ZyQEROvWcX7ytaNUoazGzbX8SSZarku5usl4bxGLrApkYUfsFONvY8DPCm7o?=
 =?us-ascii?Q?Zkhx+FSL0DM3VBR1XlN+lm/BY5P5BbwFj4Oay2rZOj9zq+xC6GABZyBJM1rI?=
 =?us-ascii?Q?TbAwPi9GI76lSFKmeQLpw4XWAdErJ+jZwiA6TEm8gsv9havwTPQbEj6nByQO?=
 =?us-ascii?Q?eqbEt0oDxK9Dj73ZGYJXQMA7M1gA1/NjQXkbjqZU7wwhW4hBcxqx2g7N6nnV?=
 =?us-ascii?Q?36I7MJAlIPHwc9CdjOi6zY+b1EMBjEh13MGJuO8Ml/97icYw5vusrPmeYSTu?=
 =?us-ascii?Q?muNusU0ritlD7RyPm/6mkXZXRL5q+/usv0KJbVIoCMq664NHzS32DuVa6sg9?=
 =?us-ascii?Q?tblO3vDMqgD12PmjPpHo0AxXY0Nhxz3zsmBp5To3vlvKDOxAKgHJF7YU9Yie?=
 =?us-ascii?Q?5RygBSA0hvLkIyNax18k2F4c0MRqs9saTgQznFAsO8rEvJx/2bzO8nnognV1?=
 =?us-ascii?Q?pFHHXS78YwqkEve5Sq1l9s6od6o=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65f33a11-05cd-4b8e-8dcb-08d9afe137d8
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2021 07:00:09.4763
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ER01kJIbkB+dGz00X9UDxGM1z3a1d4872tbesFwE3HodCIjkS2XQnrojfsu2mfR9ouFqNapGypG3udH7Zyt5B8AwSUcI+Oq0BHtcm0gTNMg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5789
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10178 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 mlxscore=0
 bulkscore=0 malwarescore=0 phishscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111250038
X-Proofpoint-GUID: 18otvL3Say3oLq3q_S2OO3IjMq4rnGiI
X-Proofpoint-ORIG-GUID: 18otvL3Say3oLq3q_S2OO3IjMq4rnGiI
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 25, 2021 at 12:34:36AM +0530, Vihas Mak wrote:
> use max() and min() macros to fix following cocci warnings:
> 
> 	drivers/staging/r8188eu/core/rtw_wlan_util.c:719: WARNING opportunity for min()
> 	drivers/staging/r8188eu/core/rtw_wlan_util.c:724: WARNING opportunity for max()
> 
> Signed-off-by: Vihas Mak <makvihas@gmail.com>
> ---
> v1 -> v2:
> - fixed checkpatch issues (parenthesis alignment).

Looks good.  Thanks!

Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>

regards,
dan carpenter

