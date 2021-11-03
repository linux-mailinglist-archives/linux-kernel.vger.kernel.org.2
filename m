Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3A4544438B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 15:28:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232157AbhKCObX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 10:31:23 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:25932 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232077AbhKCObW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 10:31:22 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1A3E173U008315;
        Wed, 3 Nov 2021 14:28:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=AdrTipgVY0e4HgeDrXQ/vMlb5/10PfDAwIyRNkHWIUE=;
 b=UU/0OK5PJT2NWeeu1wTUxzKKj+u2VvLahwIclVx0fmoex/YhAKwi7eNA7omRq45YBmxi
 9hwcuNbLd9npUM+GCNSLeMlkFVqN9gHgvwPGBOXQIJ5XWrf9eKB3H80coLfLRFk6NJ7f
 qaEzbGfjpzD9yP6VLlhWf6dKnzT1EyjYHXq1cp1BAI9T6lHJCCgL74TWFSD+j7YqSDco
 VL9lfd2oZFtBqibgh646D53Z5d5K9Q8mD0bWx4bQzEaWiQRfSdS2gmblK+nnRB613/9+
 mwhycD2kfJZIlbmCk1P7Tg6u6Y9Odbvc01FE7r31nsM+0AHE5b3Ywug6f27Vx2X01OJ/ 1A== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3c3q1n9rsk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Nov 2021 14:28:38 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1A3EP3Sk132661;
        Wed, 3 Nov 2021 14:28:35 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
        by userp3030.oracle.com with ESMTP id 3c27k73r7c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Nov 2021 14:28:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kqhOE1bbJeryoblhrUUOxnqah77NvCLvOhstubpJbDGjTidKfb2T4iTJSvaEoqwcqpXNmjYQpDxX+82GgBKsM168IEb4IekAyNvDN5NNjModJye+3fjmpQE1ae5ty2HS+2b/hrLooT9o8H8qOvMk0zYPTdA2g85iVd/BF7qiYd44XJNz9NmhrTUa+VUdlLTGhr407vskZxxBU72vjJKdrd5ZKCBrcKbLrYBhPf5QNwXRccqGFSHdi1+hKvqemfebwBofCHKtB4tdcjh7gVyuHndPriliARkkQMPpMzvCvl9sJ0MJnQh7KB2k48xYOb9ubp1RNznr3FDG61LIsRrl2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AdrTipgVY0e4HgeDrXQ/vMlb5/10PfDAwIyRNkHWIUE=;
 b=Idx8jbWL/BXKzlcK9A6Z9Ljm1tYTH6Xtzr64S+ZeofVbuePesOflhCPhLKt5hirQK71n8quIn3VexOBvAUibewLEPAN/aqTZEONJJG7Yx5BEJtjxrAnUo8qHdEwTV1KtxNH1FROVLeRVGU+HKs1BelVQlyVOsv3gBUfCAK6V06JEAelgi3sjgkVCCzYCDhUzZ93Lo+Dwl6wqCuRZhYwmlhll4CR8LXblX9g6wymzvA2Qpy8mjkMMoM4QEHnljsBB9yX1oAPiJdNPp8J/i2U+7BdtIybU2gZzO1F05fXKU+OJSYwkmLwnqThwVMsz+JxPAZb4csuWy3k6lmQSJLCgzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AdrTipgVY0e4HgeDrXQ/vMlb5/10PfDAwIyRNkHWIUE=;
 b=FEmw23/sNb6H21EcAfShAOaUyFRP2pCgfE0ALLsv48v34Wrgtdl2YAOjrsMDCS5D4NFlUgnmQCnbnvLzPmzYot90GDoSjTNtsUTRM5NQUc0oA4AX4tZrdc2uNNxh3XiP4udNsGbPrvqILipHL6mY1Wvs7L3Zau1UbieiYSKb/D0=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from CY4PR1001MB2358.namprd10.prod.outlook.com
 (2603:10b6:910:4a::32) by CY4PR10MB1479.namprd10.prod.outlook.com
 (2603:10b6:903:27::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.18; Wed, 3 Nov
 2021 14:28:32 +0000
Received: from CY4PR1001MB2358.namprd10.prod.outlook.com
 ([fe80::e5e3:725b:4bb:7809]) by CY4PR1001MB2358.namprd10.prod.outlook.com
 ([fe80::e5e3:725b:4bb:7809%5]) with mapi id 15.20.4649.020; Wed, 3 Nov 2021
 14:28:32 +0000
Date:   Wed, 3 Nov 2021 17:28:14 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Saurav Girepunje <saurav.girepunje@gmail.com>
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        gregkh@linuxfoundation.org, straube.linux@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        saurav.girepunje@hotmail.com
Subject: Re: [PATCH] staging: r8188eu: hal: remove goto statement and local
 variable
Message-ID: <20211103142814.GX2794@kadam>
References: <YXjXsChOpaTThkxT@Sauravs-Air.domain.name>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YXjXsChOpaTThkxT@Sauravs-Air.domain.name>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0015.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4c::20)
 To CY4PR1001MB2358.namprd10.prod.outlook.com (2603:10b6:910:4a::32)
MIME-Version: 1.0
Received: from kadam (62.8.83.22) by JNAP275CA0015.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4c::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10 via Frontend Transport; Wed, 3 Nov 2021 14:28:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 13526c94-debe-48e4-5509-08d99ed63682
X-MS-TrafficTypeDiagnostic: CY4PR10MB1479:
X-Microsoft-Antispam-PRVS: <CY4PR10MB1479DECD260D8734FDD5C1768E8C9@CY4PR10MB1479.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AQhikp+7W4UZz1CLulbQBeOB5SWneI4BWtqGQXRep8FziyurwbiQfuBMLznERLE0weDoF7cbFhRD/VQsE15V/MwaMZT6oSCfOOB8BbuK1GezKqDolH99xIfqzuhmN9swDZPXPW5kK/tJAbUe+Z4RhdquogrfrPyMufnQm+YIzHQ3FVvwcMecVdCjrlq2BEycb9W89wPh67pgvcXQgV6Z/qxsC7ZXn5DslIF2Dhucx8DXUuB1g3ck7GHgfgOrwajQvTjB+/0Ggs3J0mIgbeeQJTy6092RAer7EWK8JgG+tCiEPCVpfShQKSBbgcw+YKUVneJbt0VH6H5EK/I39dpkRNcEryBm/NAOL1eEVO0R+SJwVGocvC2BIFVBQOckZrQcA2zaSsBdCdU39jEs4pkTJaBkYJFjG80+DRgWJOP8u/AY54hxWdGWsLFoUGwI//cmXhbA0SOERvQMzoau1O/ZVsrNSXfyttOx7qpWsMAzqUuWf1b2pXbH7p0AwyD8vQSaNkgaoMT6EdfjS7ZhbUJDbnlrVj82Mwa4OBblfCX55g8MxAunPtJXMw93sJPk/kQIgj11TY/CYszYCZnE+Jd/oXIVrqxWakOPbjlqW26Mu0MEBO0ENGU1eLk7G2WR0OlbF/TPtMDsC5LBDPfO78tKi7qW6n4RYEr7U2Wf9Fo4ZhvwP3byNJxBfhI3e9Yjh41KOsKqgw7R61Vf8MZjWIB3Yg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1001MB2358.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(86362001)(1076003)(8676002)(5660300002)(9576002)(66946007)(26005)(186003)(8936002)(316002)(956004)(4744005)(33656002)(2906002)(38350700002)(6916009)(38100700002)(66556008)(52116002)(9686003)(55016002)(6496006)(33716001)(6666004)(66476007)(4326008)(508600001)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Pwohrlyt24LQs6DATJLae0y16KJjqywxdycJ39CuxSr14dlgiXkRTBzGE8T/?=
 =?us-ascii?Q?f9t6sntECorHlS8ckkqw046901lSH5QG+dczsEeyCKLC+yZdE6ChjtuFkJKq?=
 =?us-ascii?Q?HgGPD7AgKlme3PMi85i16/zRPdL07ka/KbS7lFx6p6psYG56NIY+yeH0bFCV?=
 =?us-ascii?Q?k8uYG3FqMfxDxyRNw2RYvXr1i6vouQwy8Vc6GKy17egoL1vN3llGRCWcDAtp?=
 =?us-ascii?Q?1DTUAFK05Y2hzuq5caF4aCSoH3uBnRmH9ZKvzlifpQNiyMgmGkG3V6eEcVou?=
 =?us-ascii?Q?+X3jHdjT0etd6zTVPVqZ2g7BlS2iIYgp0q4XJBWDrVtIL+rFBoPAVwUEQKoq?=
 =?us-ascii?Q?kE819VCGF5QEh5VBF2tTdA9Gqp5+uKFe/DTfhWEV2PCjOaY7xdtmF55DbxnA?=
 =?us-ascii?Q?LVgoqsOpBGvJZjA7KMIcfxhPu4m2a3oYrWC8uHKkqex8yFanLS34/EVYoAfi?=
 =?us-ascii?Q?p4/Nsp0mMGlE3WhHqYmwh35GlkWlLDjZR949hIxi6+NP3SLFa7PyeS+JC0Fi?=
 =?us-ascii?Q?qmXnanN44KPFtmXm5AlA12SKHCVEXfEHl9aa6mJ5UXnHBGsStcaxi46DLPCf?=
 =?us-ascii?Q?rIzwMNnWFItywrNLUHWzD8V68I5ZqK905CLWnLzAvFJWQW+x55Y/ouocB3Q9?=
 =?us-ascii?Q?zTjDQjCBaMiiP0QPNA4MO+m4TeEUU1OX3QvFPTJskjf0afxkct3DZIT4IkyG?=
 =?us-ascii?Q?/OVQnttcm4CvYjaL/xn93WjNqGj/2UPgf/oXD2bxM2l0Ivqu//cfKukaGiiy?=
 =?us-ascii?Q?mKte8ck7IAoVVbwkZYcFAPzip6AvEf1WZZymfFEuVKu22n0T9h4XSS4DIbyc?=
 =?us-ascii?Q?Nnz/EfKE7dFvrvbTl87kOGtpyGRhitV56yhYgMFIJoLKJqsVKEIPYn1A5wXe?=
 =?us-ascii?Q?WfbzghbhIGomqaHh/HyGG0xjYpOOW5pFGx38bidjjCaRsdW12KKjhr2M1vbD?=
 =?us-ascii?Q?Bxr4+eor3S1fAQr7W4pfW8UkH5pJptlDmzawkKXes8ta4qpcmeCHqnEip0ec?=
 =?us-ascii?Q?YBeUj39/N1NB2lwwtvY4QVnGCPN4SIzRCvfYTb5IESEN8hfCjjP6t8J4xoTP?=
 =?us-ascii?Q?t9x0XlUP8qQK6jHoAvl97TgQExZ8l1tcuzfu7CdGdyLz5FUphNw105ufbDeT?=
 =?us-ascii?Q?S+f0twszR8qwY8GwP/vTm2m2w76SYZjsUP8RT7NfsBFT2Ly1GUtmKPuOZiEw?=
 =?us-ascii?Q?hJ0StKCi3WLTvqNZR7dLAiG+Ut014iO3xBrFDeFGN1NsNkjBeK2b8CJTCLMp?=
 =?us-ascii?Q?g5dmoMZsCwfzUk+oWq87zUTCO0t+rP9uxnuNt54yWvMnPEYJoYF7m3vd+D+d?=
 =?us-ascii?Q?nawcwE9M9U1aatZUq/pAjiDSgoEIZyWu8Tr6hVG6EtGXE7YuVp2VKHs9gIXr?=
 =?us-ascii?Q?589oxqjYAnVsD+RqvCuixvxv1CqIqJOZ5tMjmxnQg6L6pBboh8C8wEg6ytw4?=
 =?us-ascii?Q?Rj7/Yvkure3ie2dpA3T7XKtkTvkkWJoy0VEvmiVuCoMuM4uxrPsE7/4aXWkm?=
 =?us-ascii?Q?nEfxUlm9wQp4+MOK+cE31sfriK35zb1gDjXILFvXEnm3pUVpDuW8lqaaL8rE?=
 =?us-ascii?Q?PDvuagIXjgASM5xgFvIZFX1oEth629Lykjp3mOQa/RFM421duy7lr6JEH66w?=
 =?us-ascii?Q?bLW3HzZNURJwuOl+j/VMYhkGIOvAXFeswDXeJXA/oQFnGvIcl4pANAlN7pcB?=
 =?us-ascii?Q?qoOheQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13526c94-debe-48e4-5509-08d99ed63682
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1001MB2358.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2021 14:28:32.7255
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PRf3ZSlEQApRz2Nb+yUZuCt81hYK0EPRCsBzDNRZ+TPLBw30q6EaaOSqtb5rFnT4qxBaABlNR53kiTzzuAAUp2TyVXgsGlkAsDGL1Bw5opM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1479
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10156 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 spamscore=0
 malwarescore=0 mlxlogscore=999 adultscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111030082
X-Proofpoint-ORIG-GUID: IetIOVoPpqpHA9snwJexWtQjgWMBketE
X-Proofpoint-GUID: IetIOVoPpqpHA9snwJexWtQjgWMBketE
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 27, 2021 at 10:08:08AM +0530, Saurav Girepunje wrote:
> Remove the goto statement from FillH2CCmd_88E(). In this function goto
> can be replace by return statement. As on goto label exit, function
> only return it is not performing any cleanup. Avoiding goto will
> improve the function readability. After replacing the goto statement
> local variable ret is also not needed. So remove the ret local variable.
> 
> Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
> ---

Thanks!

Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>

regards,
dan carpenter

