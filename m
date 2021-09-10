Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 635964068D0
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 11:01:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231878AbhIJJC0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 05:02:26 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:55222 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231771AbhIJJCY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 05:02:24 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18A4xwBB029774;
        Fri, 10 Sep 2021 09:01:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=DGtY/GIpZbgFrjkWIv7I5GkmMuNme3i8jcdtD/oCZtg=;
 b=G3CBmPyGRthNjDxl5Hq9wQwSJbCHs0vUP/rVKkWJf1L1a1uRslXachcN3DS+91bJKM4b
 cKDNRt2l4tKQXQx9IM45qldN5VyhDNaZ1xYbzcXmYn4HHNTbVkGZjz7I9fEgANrXQWXI
 sbYRUXcB32/JZQGvHDV7bx8LAR9rkKGitPqRnhLG0++R6m5Ankpa2BzXYe8Ut5Sk0FDK
 WyPJHeVUXE04qifGGOVrQ4vofiiKwSOCFEjySo3VNVdOURRwoHFquIdpnSEXC+nmhq/r
 FLTnkZdm72U/AHIp67PLIyBxdpLyWog9qkbAFpuiik2J55gPjJNmKS/ZeC5RkTR1N6Ko eg== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=DGtY/GIpZbgFrjkWIv7I5GkmMuNme3i8jcdtD/oCZtg=;
 b=yFoyTIlNoB5PgL/uZAo0ctzhRXQFEJw4b8fyOYwNycan0csCb9eal8/C/zq2wojlqCXU
 ad/JLiQcUJJ14bXDVCChKsJapzTxt23RPnQ57fM1Hr0YuKM3ND/eg9OQzwhUq0rsVjtO
 bYZul4kBh/rrPF7G3o4d+qJjTLgW8QAgIm2UDFA5IdzLpFaUrOJWXCqNsLJ5U2VsvcCx
 NnQLgiYEVdcau4LUelKqH3KWbv8xtFwybHa8RLI56pMq0/cs+P4bITCm0eH/l5lFy7OB
 XGkCiVoLFdxKgj+ZcSbTV3lc3B1P9L7dE/38s70HMKbRR96FAZpgpDa9HaT7dYNsT5wu sw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3aytk8s9p4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Sep 2021 09:01:07 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18A90vuf089400;
        Fri, 10 Sep 2021 09:01:05 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
        by userp3030.oracle.com with ESMTP id 3aytftmk7x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Sep 2021 09:01:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ai7RqvC9TOBnePFk3pso1+GmFRQ29RjCV73gqpyWWubPRtGuS2wPKw63x3zEiADwB0ob11xZ4UpRMCX9yEvmdJoGhucnlWtnw2Fq0XHVh0mNvEqlpoEg9hDWzJzV1jwRIFzeRMp2c3zkXeiV+TkQMYmvCOL8tp0vFf7ogZYNwkSbKYFvfvORBtiBCU4wo4SxUL0nwAsBXlTYY1RyiZsNaefwU5pxERL3lf+WZ+UNUeI11kWAnDkX4GaoRFXJVL2m1FRlOK/mj+cSGguUKK9MVBaQS0VBGCquUj9Z9CLNgpsvsDRztJMB9XBUwFthJO/Pr+zzoBvL/v5H6+Zz8x/raw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=DGtY/GIpZbgFrjkWIv7I5GkmMuNme3i8jcdtD/oCZtg=;
 b=VLrrzNKO2B7J4Us3H1Q4Rxx+W6rhNGCBOWahZnXIcXkk4sNxYmba2B7DggaVWHFlp6H/yfNyTfj9TQoTZCk2Bcmy77Y2IzOuetCU3yzOfcFF4W4tmSpUwMNAM7sYInFnCxmAd0g3v0LFenbxjDjkKbP1tBLlNyG5qKkDYHwGwO1+Fz7U+cL+hMCEE+cC8mS9o7zl12uY0CFDRE4MfUHvkfUHs0INzroqqduBUx/Qy7szb5e5o/Y6amzkeBwrwgyNV8eXRVMrrFrCebDwE2fFLvuqg1PZPWu6YhkdbBHCWtx/Xe7nCOVkvPoa0zmH0X3bgimCS1w4JFq4s+oqw0YOnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DGtY/GIpZbgFrjkWIv7I5GkmMuNme3i8jcdtD/oCZtg=;
 b=xtY03AIPitY0DYgx9VIqh0dVAr3pHHCfxssAJMM2NAu3mkC5J2KqJmhCXUGo6VRl4orWyNKxe6KgLMqX7qzZH0cEOtFADXZvTNuCy6F20uv6tiAWkPvtctY9QG8TtK75WWgwgPvjw+HlGaVDJljfSai8SF656HAA3gIsVMOJdig=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO1PR10MB4449.namprd10.prod.outlook.com
 (2603:10b6:303:9d::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.16; Fri, 10 Sep
 2021 09:01:03 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4500.017; Fri, 10 Sep 2021
 09:01:03 +0000
Date:   Fri, 10 Sep 2021 12:00:45 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Saurav Girepunje <saurav.girepunje@gmail.com>
Cc:     Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        gregkh@linuxfoundation.org, fmdefrancesco@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        saurav.girepunje@hotmail.com
Subject: Re: [PATCH v2] staging: rtl8712: Move similar execution in to a
 function.
Message-ID: <20210910090045.GD7203@kadam>
References: <YTsXXxtQn7QN6nIm@user>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YTsXXxtQn7QN6nIm@user>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0033.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:18::21)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (62.8.83.99) by JNXP275CA0033.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:18::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend Transport; Fri, 10 Sep 2021 09:00:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dcc8558e-0c2d-4add-0bf3-08d974398410
X-MS-TrafficTypeDiagnostic: CO1PR10MB4449:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO1PR10MB4449790DA4FB3343DD4264308ED69@CO1PR10MB4449.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 051ZbC3GxYNoJlNFfzZm1q1xUmKz9xzGtCYMucBax6yI6y2z/GP1LQinobA5UFdGeQk6qDfViV9kmS2JK6bFYfYFDMo6xcB33ogxhkB9ADjsNkT+lSdr5ZjZQE/CZaT/Z3wLOnxEKCfGilkSKy6UYaLWnswXIoQgOOxE8+dWYfUWQ/XelIxM2NZuwNq8wrrUXWHZ3Nbi5BLZe4pdnTat9YBX7YNacdyTulwd3TVHw//zjJo/x1mIFsEDbevtpXsBSsIqVu6xRHBf+VxbiJBsICBztMuMmic+Kt94uTtuwa2X9Wm3VdNDime7cnW4tmC1aq7Dk56LZ+eHfOeGENSCYvMUNLpoCpT0QkaYYfEfQuWEWyWijfa6VhsPQenzEvbvC5cbIEZzhM2b+HH2UzTDjPKkUS924D4opSSa6f2oo2n7WG7h80TWks6h9PEGZUujuLUMeqKK5f2cI4Bxb8DqaVQQY3LuCP+vwg+Y0nwCBPAKCfZDlGHbo7C6ovkvFeJep7SoFhCb7m3q7Bog5weopblz80fiLT+KgdWQPDbP62WzyqvECTgj65HrTO/RzE/ifpeOgrwU/shksWMt2QQ7MwnM8sJwDAwXkuzY5kArEHqezUVpqf6paF9Z40yS2V/gEnslKpQ4C0+0rarhDPBfFv2yU0C0wc7MTLbtAQlIpL1+aZS9Yz2b8mf+miSAhxDu1HfUS5oYRP0z4T8WK+4nOA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66476007)(9576002)(33656002)(9686003)(8936002)(66946007)(5660300002)(66556008)(316002)(8676002)(55016002)(38100700002)(38350700002)(26005)(6666004)(186003)(52116002)(1076003)(6496006)(44832011)(956004)(86362001)(508600001)(4326008)(2906002)(6916009)(33716001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lU97j+7d6TRo5Yq1fWgOZVza/+ZIGInpJNZJrKXP+Anmw4kbF/H4wlAOpT6i?=
 =?us-ascii?Q?/kMKs1OshxVuKYKoBhehHKxuXrDtscJho6SbYISMEKtF3bMOa+jzdtZ2QvJy?=
 =?us-ascii?Q?1sTT8KzFmJe2WRa2UhkTHnMDc5bI8ukQwglkQ7/LvoKYYrbY/ZPT2WZYp4RC?=
 =?us-ascii?Q?jL4iAd42BnO2gPMOqt5E9Ezs6TFff2EqjhcijtOS1xtopdaeJEuoVxctz/9h?=
 =?us-ascii?Q?S1NdO/yPYB+1yHobKMwkJNz0L7ANetG0tWL5yNWLgOFUb/j8NCG8dG4M7Yoi?=
 =?us-ascii?Q?dbpnDTJlBlUUK4cx4N9E/MbsgR69jQoyUtDZh5K56m6RapOovlxbb/pdEVLW?=
 =?us-ascii?Q?QyNv7jmA4CwMoYN4gXrUQKqhOaDWkwHEX7ARTaNM/lCQ+6bReMx4ZPnIW0Ck?=
 =?us-ascii?Q?sT+7ZBhJbzi+QPz8mR6vN2tDO/9Grz6PGfewBlK0XL2XaAdpC0Z8op2vMEPw?=
 =?us-ascii?Q?l61JXUpBOL1FQ6KVVkv8EGbKz51Pmj6hREVtAOtHUfhVjRjJQpxjNlYOfBob?=
 =?us-ascii?Q?V7KYzYWYwhSgV2Jp4CrLp0MxnDRIuI/ZmGVpZCEZ6TViVsGb3VMRnO7A/yGp?=
 =?us-ascii?Q?Opvd4KInKo6bRUSV2bN3PZFwSB7U8PBbEboBPaaSQOHLSlYvG+S9kygTr2N0?=
 =?us-ascii?Q?DpPfgXzeVPOkTpP7lzirzeIZvAqpJkl7GMeEHcPjbtBs1F8YVV94Ro2Er3OH?=
 =?us-ascii?Q?iHZ4fgQfF/vKd+mEwn4esyqDMPh4gX3ju9ZghtKIT/xGuFIIQt7HYCvS9oQ4?=
 =?us-ascii?Q?b8lz13d8bjfcICj/3VCHK7m9ILyYk7eFIkJwlNh/uSbuD3tJOgQpNdLBQJli?=
 =?us-ascii?Q?qqeABOaXuJDopkatr2FhpQwBbtD6DqmOWVC+KbMjXOkaGWbfFMIzRkzCCe4A?=
 =?us-ascii?Q?SpREqYzmcqx+A0qdWTpCMQz2i0i3bNoQVsEWFUU02V92gZ3oJnzo1clVlYey?=
 =?us-ascii?Q?iNfdkVFdDYoL8l3umeEfml4o8AiSZYetSS5QtLbLed5MlHpAvvFrDs2IueKm?=
 =?us-ascii?Q?IxfuzdVSPllVtn3YB6atVjF2Oxi1fwBz2+oUg99MYpgxOs4IBcXcgKVEg3as?=
 =?us-ascii?Q?VeqsKcBenwFvqtl4E7n1ovMMNqAXMIlfWp6ZLSQgO7Dsb+GVCRPtAmxJ+4Hj?=
 =?us-ascii?Q?45l6WiGu4jqRlbian77d05dvMDtB5VCyDKTD4uptQR9+FVrv8Cm7+PjOLOh+?=
 =?us-ascii?Q?0uji8sU+O8TLrfA0qi5JNWp+JxXtAiSlKgChkKmkrk5IteHtvl0jIBKPrPuX?=
 =?us-ascii?Q?Kbtuz5PhssQUO1s4E5WJ0dFRD9S9BVNvZSSajT65XV3xv1wY9wY8mMq+wPmD?=
 =?us-ascii?Q?I2iXExSuTmY/0FNXZbQ4Yiwi?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcc8558e-0c2d-4add-0bf3-08d974398410
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2021 09:01:03.1315
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cbP5JCCI7wgvCVgWiwqyGM37/jtrLwadCvTRaDAKOipaoU61sQQrfUaCagg6+vXdX7q2bKZSGLXSpEhy4xiTGzi4ZJCtc8N5exmeNjh4FfQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4449
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10102 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 phishscore=0
 spamscore=0 malwarescore=0 suspectscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109030001
 definitions=main-2109100058
X-Proofpoint-GUID: AarM69_CcaSrfRK1D8h3CM-_NQE2xyrc
X-Proofpoint-ORIG-GUID: AarM69_CcaSrfRK1D8h3CM-_NQE2xyrc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, Sep 10, 2021 at 01:59:19PM +0530, Saurav Girepunje wrote:
> In rtl8712_cmd.c function read_macreg_hdl,write_macreg_hdl,write_bbreg_hdl
> and write_rfreg_hdl all are having same execution.

I get what you're trying to do, because this code is bad and duplicative
but this is not the right fix.

Let's take read_macreg_hdl() as an example.

Look at how it's called:

   215          switch (pcmd->cmdcode) {
   216          case GEN_CMD_CODE(_Read_MACREG):
   217                  read_macreg_hdl(padapter, (u8 *)pcmd);
   218                  pcmd_r = pcmd;
   219                  break;

Then look at how it's implemented:

   120  static u8 read_macreg_hdl(struct _adapter *padapter, u8 *pbuf)
   121  {
   122          void (*pcmd_callback)(struct _adapter *dev, struct cmd_obj      *pcmd);
   123          struct cmd_obj *pcmd  = (struct cmd_obj *)pbuf;
   124  
   125          /*  invoke cmd->callback function */
   126          pcmd_callback = cmd_callback[pcmd->cmdcode].callback;

So pcmd->cmdcode is GEN_CMD_CODE(_Read_MACREG).  We look that up in the
cmd_callback[] array and it is:

        {GEN_CMD_CODE(_Read_MACREG), NULL}, /*0*/

   127          if (!pcmd_callback)
   128                  r8712_free_cmd_obj(pcmd);

So now we no that "pcmd_callback" is NULL meaning it will free "pcmd".
And if you remember in the caller it does "pcmd_r = pcmd;" but "pcmd"
is freed so that's going to lead to a use after free in r8712_cmd_thread().
It's garbage and the patch doesn't really help.

The right way to fix it is to get rid of the cmd_callback[] array.

   129          else
   130                  pcmd_callback(padapter, pcmd);
   131          return H2C_SUCCESS;
   132  }

Getting rid of the cmd_callback[] array looks like this.  In
read_rfreg_hdl() we know that the callback is r8712_getbbrfreg_cmdrsp_callback()
so we can call that directly.

diff --git a/drivers/staging/rtl8712/rtl8712_cmd.c b/drivers/staging/rtl8712/rtl8712_cmd.c
index e9294e1ed06e..51a6abb27d41 100644
--- a/drivers/staging/rtl8712/rtl8712_cmd.c
+++ b/drivers/staging/rtl8712/rtl8712_cmd.c
@@ -174,11 +174,7 @@ static u8 read_rfreg_hdl(struct _adapter *padapter, u8 *pbuf)
 
 	if (pcmd->rsp && pcmd->rspsz > 0)
 		memcpy(pcmd->rsp, (u8 *)&val, pcmd->rspsz);
-	pcmd_callback = cmd_callback[pcmd->cmdcode].callback;
-	if (!pcmd_callback)
-		r8712_free_cmd_obj(pcmd);
-	else
-		pcmd_callback(padapter, pcmd);
+	r8712_getbbrfreg_cmdrsp_callback(padapter, pcmd);
 	return H2C_SUCCESS;
 }
 

regards,
dan carpenter

