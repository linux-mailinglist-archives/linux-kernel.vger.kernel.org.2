Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69EF3442F5A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 14:49:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231251AbhKBNvo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 09:51:44 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:51610 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229530AbhKBNvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 09:51:41 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1A2DPfAA001771;
        Tue, 2 Nov 2021 13:49:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=t6mK7CdNAWeS1TrGnruXIBBD3cRcGk4v7jTcfTxJqIE=;
 b=B/0ved1z2lmFfMHSRWm/pfAP6jSL/xBIAp+O0bzC/RoPUPBcspSZgT6TMNQuuGZu90d8
 8Htn3IPlDu6/kfeCbsyVOyQJJiMWbiFVmbFOvlF/GcgabjhGfr104MN/SvOwpoMCmT8g
 +YOPwYQc2j2T1PGRStMu+kGArdkBc2PnupSo5VvsvSP4Z/cdIbQCV4ZoFiT1FJYe3ZNa
 ISGKX+knqKy+jY3tUh2BWNKLwMA7mcN/Z8Hw3OpJ5MN2bivKC4NDldDGT8Kf4f6J8oqF
 xFJK/yVsav/QRe41e3NQV82aU3W6rKESpWGBmwSDpXDX8jFxl0Ui2X+F9Ks2gkku6oxe fw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3c27r5f4aj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Nov 2021 13:49:01 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1A2DjcTj002766;
        Tue, 2 Nov 2021 13:49:01 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
        by aserp3030.oracle.com with ESMTP id 3c0v3dq9sy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Nov 2021 13:49:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jT7Pb5zcPYwBk6cd6ytxD3jZjmgXrfLypv45lVsWRMcFeK7U5xXkuBri1kXQMsLmyJ4gHipCHtXW1O3teVFrnihUeZoQ9OP8EpNHrEgO66UedYuIduyNDlHewSnbINXLNysFQWwnunSZUo8xWvyvHMvjb5HNoONmqANu8O2JZ4qDH54FmWKz+5FIooT5p0kyrlcgVCZEKTFomXVl/e7GHeVVAVpeo1Nh+lbKvpEB3u8r18LLnh/GMy9C/RqjfarNtuto8onN0PHDEQ7umZ+RY2HxLM3HjlkewmiFRyK79uNhA9QME2GLbISqUQKM8GNWO/LTo3h0e2DdznkAdHlNfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t6mK7CdNAWeS1TrGnruXIBBD3cRcGk4v7jTcfTxJqIE=;
 b=cby2mh5qEEwe2KqTBzHFmaeGsBMzWcMk0eWsLSPsU5U89WzCqnkf5sQ4b/CsreT+fo1m44Se53QE3SPyOioSKb3kuZ5QgiHqFWRjwdqyoXw2BwVd6S3u/cCQUGmUu86K62lqEkFT8zU0F7UAy/zRaUNeh5besQztficB6IE1RkMrO3iMsz3Uapkq9NSrF9imqmO7N8rcZIFSJMvmqBXxdW2XX+Vxvapwh2a7W4TP2+xCGj8pS/b9SoBwm052tJ9MYCbdh/AxqHj21n94feDgQNjeoOm+Dc7i5b6o6MlncfyB2dhEMeMW8pWwSUZFXUpSrle2cCPEYx6sxHygixNC3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t6mK7CdNAWeS1TrGnruXIBBD3cRcGk4v7jTcfTxJqIE=;
 b=yDYdUurCuoJYGJlVg6xqfUDSzcLMGRCWldNAwdwGkIIFZuXfAdpU9/XrkZFwqujBiQpGXyXBMX8rZgf/RI4UpGTjyv2aw6lJ2e13PvbfiDCviPoS7m2JSq6KsHinvFtC2Vz2kq41CJ6Fcb8zcicMf3OLepSP3YbO9iTeDMTXMGM=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1951.namprd10.prod.outlook.com
 (2603:10b6:300:10a::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15; Tue, 2 Nov
 2021 13:48:59 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9%5]) with mapi id 15.20.4649.020; Tue, 2 Nov 2021
 13:48:59 +0000
Date:   Tue, 2 Nov 2021 16:48:37 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Kushal Kothari <kushalkothari285@gmail.com>
Cc:     gregkh@linuxfoundation.org, fabioaiuto83@gmail.com,
        marcocesati@gmail.com, ross.schm.dev@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com, mike.rapoport@gmail.com,
        staging@lists.linux.dev
Subject: Re: [PATCH] staging: rtl8723bs: core: Remove true and false
 comparison and unnecessary parentheses
Message-ID: <20211102134837.GI2794@kadam>
References: <20211020093458.129672-1-kushalkothari285@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211020093458.129672-1-kushalkothari285@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0019.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:19::31)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (62.8.83.22) by JNXP275CA0019.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:19::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.17 via Frontend Transport; Tue, 2 Nov 2021 13:48:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5e678998-76b8-403a-b33b-08d99e078525
X-MS-TrafficTypeDiagnostic: MWHPR10MB1951:
X-Microsoft-Antispam-PRVS: <MWHPR10MB19514ABF60B0FEC76AE34ED68E8B9@MWHPR10MB1951.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:660;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YJkVXYNxEcFmNW1G57wBUCDTk7XmRtremdlh0BSfmZE/GsjRVzHABnck0FN7Wg8Bql4ewePOhG4td9VGJv55YG5msb8JB7a6RHMxU/6GCEMJZF6Jwyuv/LomdwbxSGrybAekGN26ip1LlO6FnqqP9w3jiwDMwjQy9r/mnqfFEw2IMa8Lsd8ytp6sQ6D74lB0MTNDeWnpdeZJpyvOVB9hz7vQVYxcjRt874eDkqU80TQkaglWkhwU9L/m1r3oyqJEvAkprMCwJUit48H2MR15DzBJZhFK4kySoB2VEVQLcM0Sk4PcHw7gtZROWI7E+hyEgpnkE720FxOHAWYpDlY1MkzCMaYHmZSwfNpKkZrj8Mlgfijupi19ATsKyMs6OS26GOuOFyqn9ooa04COeC93kyrfuRlykCpObjfV531BJxJZW07fxednJ0n4neTa7J+S64dNLqqpPEDi5vmzKXjYquH5fLMSkvdWrvX92U1UQ0iZY+xC3mxbvZ7YWbHt7iw52SNEhE2XgiZ++XXSOET+sc+e0fNN/2zn2/aM5SSRbLS/Nt+cpTa9W22nTxm4wHuoj4AuIekvZGPBx1js5bNquj+ddr8h4TSNy0SXNi56aoi+f8KPSyYy/b8rXR0pnILZBKX5if2/08GlAHS3w5LV4b2FHQOnFl2yTi0ScQAlUO578EDcGGjj3fcsVFOK4WZPLRjVek2nbwBY2pdOZ/Ft3w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(316002)(186003)(66556008)(66476007)(66946007)(1076003)(8676002)(38350700002)(38100700002)(9576002)(956004)(6496006)(2906002)(6916009)(52116002)(4326008)(83380400001)(8936002)(7416002)(26005)(508600001)(55016002)(9686003)(33716001)(33656002)(6666004)(44832011)(5660300002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zUy2pT0QEddoC7cwi8FM0tL6mMjxzzScIsLHirqhxIom3jz6PsfzEic1MMgL?=
 =?us-ascii?Q?HuR7D4oLP/xtw5XaznK/atLAiVy5Zd+z0JQU9rGEYqw4MJFFbIy4QoZw0iBR?=
 =?us-ascii?Q?bXCo8uNnDvdUj2b0K/a3uyyb4YBQv2q1S1T9H7dUUMcdoq5OUcMTO5H4GSgJ?=
 =?us-ascii?Q?CNgX8myKikSlmmyhG5libo1AHZbO6iUK+15G39iWmo6esvGF7/tdbuUP+Gsf?=
 =?us-ascii?Q?YH/kFxgGSX35/OH5kDgH6PsxOLlnszSI2FBBRwnpDMPApDDJHTTXqxURGWKD?=
 =?us-ascii?Q?3sME2GVStgN3dPSYLIxHgv+oSB0MbFpF8611lvgHsUBcNNXzY1fuVIKg23Tl?=
 =?us-ascii?Q?VujckQS+Ta9URR3uurbjtNmMTyKH8Oy5Esaev1jIuD8Rm2BvYboW+A9sg+P3?=
 =?us-ascii?Q?hWOYzfcjCjAddQMuJHkH8lYLlG5jBLfW98riwvHpgGX79koNNBfcbMryxCb1?=
 =?us-ascii?Q?OpbUjjcRuoDj8p85P/R2iX3BvG9yAN5R3CZi8+opU1KWZy7hZNJbM38NilJI?=
 =?us-ascii?Q?gzhL/44cMX6ZJ09JKA6ko0cfxES/fNury/aI48qwCfhK7FUXgGhJ4RWBO6ie?=
 =?us-ascii?Q?SqakWpmPOFH/C/XWhg/Jc1UOhBgW5lsVD2ImVWyGR0SGzX+BXz0neEW4cFQ3?=
 =?us-ascii?Q?FN4ExSJVnO3Eev9GpW3ASVRc0+kiV049cGGSl5BqaVjRmY82AMB1wOzm7F/p?=
 =?us-ascii?Q?C/AdMujkJxO+XRto5I6FRDZit8tr0XqfGu72JylcNXcm2k2mJ7EPKgdE7edj?=
 =?us-ascii?Q?RzNnstGqkq1B6cDsr85U01KD9BYozaIcVoqhmhw3bq1W/YctO/HQ8LgThQzn?=
 =?us-ascii?Q?XtY2i7Yco068YLMA+Iwuucw2Z1qUJn1ySH6RZGSA0d6S+hR13nUoBnCcnduH?=
 =?us-ascii?Q?JmN1wLDPbMDHWPkO4it1jv/vIKwJWotSkA7L7enNv1eHFm93+4IZxcir+n3o?=
 =?us-ascii?Q?PrU0gAnjN2oAdKTnEVG6B7/C9qJ/MV2RsDsReOcBkcHBphDleB3PKP2CUeBg?=
 =?us-ascii?Q?z33sh6BV8H40MdZ7oA3C1ZS+DM0cASK2ekfr7BqQTWJmwzpaT58UcAmy0ZT5?=
 =?us-ascii?Q?8k68zwP5kb69leCxIav+fqazShxY1Np6/JImQK8JR6OfO+mvC8kI79YRT+tT?=
 =?us-ascii?Q?I8Cg+Ni15A35FKeCgm+0V5sWgBhS4F6LhtDWRfuID69Uz7W0zx9tbzi+zn7L?=
 =?us-ascii?Q?EY9RYQtEij8fSQWBZnonlLAUH5Xv5I3B88lMgrFDiBsx295EdiXN7mxrfi53?=
 =?us-ascii?Q?K09zGCL/lWJqg6wBXC0h9UwaOzoASDKMLhzAH2ukKpkjrSMJuOVKJzRzt4AV?=
 =?us-ascii?Q?OFI/2Cd6iTwKVD56cgJUDiD6Y/LAXAj80a8vVc+qUR80JahRYGywdUegAAxZ?=
 =?us-ascii?Q?P8GGFRhoBf+p/aCXBJBN0w3Og4nR4xppbigwYE1G9eHeFyxxHEpxpWxOTY/W?=
 =?us-ascii?Q?hELVVKg/m+4McI8piAg9cVVsxnVFo9vrO7frbmw0/Dl8H/fv0WwKF8EVYgRP?=
 =?us-ascii?Q?jhlyyvb5HnH4yBIp8X3u/ALqhDa3Znkb6dtEq9157x1Bz5Ul82jXrjME4a8c?=
 =?us-ascii?Q?DakfnT33q7Zjae/W3NLM/5Qsrh28/qBxVnp2VYmE6x2fV2uFoYwkppAyr7GU?=
 =?us-ascii?Q?o8mtALQPnrkxKLKclpQpIxMWmjvIfjwaZyif0yg5XITaV33n7cbs4hByyKqB?=
 =?us-ascii?Q?CMz6TQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e678998-76b8-403a-b33b-08d99e078525
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2021 13:48:58.8923
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IrktFTPP0vce6wsrbHDW/LEBhoCDocxdlscSzGt3X1vnugDhAhKZr9hIvqvJ6JZ82T23rX7DEC3XPJRiRP4HcXxprdwj/xhsaJpcRFvM7yM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1951
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10155 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 adultscore=0
 spamscore=0 bulkscore=0 phishscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111020081
X-Proofpoint-ORIG-GUID: fsAocce2eMbfQSN5A00kWPbI6GK3EjOV
X-Proofpoint-GUID: fsAocce2eMbfQSN5A00kWPbI6GK3EjOV
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This should be a v2 patch.  There is a specific format for that.  The
subject isn't really correct.  It should just be:

Subject: [PATCH] staging: rtl8723bs: Remove true and false comparisons

Removing the unnecessary parentheses is a necessary part of removing the
comparisons but it's not its own thing.  You can mention it in the
commit message if you want, but don't put it in the subject.  It's not
even necessarily something I would mention because everyone understands
why you're removing the parentheses...  But if you want you can add that
to the commit message:  "After I removed the "== true" then I had to
remove some extra parentheses to avoid introducing a new checkpatch
warning".

On Wed, Oct 20, 2021 at 03:04:58PM +0530, Kushal Kothari wrote:
> Remove comparison to true and false in if statement.
> Issue found with checkpatch.pl.
> CHECK: Using comparison to true is error prone
> CHECK: Using comparison to false is error prone
> CHECK: Unnecessary parentheses
> 
> Signed-off-by: Kushal Kothari <kushalkothari285@gmail.com>
> ---
>  drivers/staging/rtl8723bs/core/rtw_cmd.c | 50 ++++++++++++------------
>  1 file changed, 25 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/core/rtw_cmd.c b/drivers/staging/rtl8723bs/core/rtw_cmd.c
> index efc9b1974e38..3e0b910114da 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_cmd.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_cmd.c
> @@ -309,8 +309,8 @@ int rtw_cmd_filter(struct cmd_priv *pcmdpriv, struct cmd_obj *cmd_obj)
>  	if (cmd_obj->cmdcode == GEN_CMD_CODE(_SetChannelPlan))
>  		bAllow = true;
>  
> -	if ((pcmdpriv->padapter->hw_init_completed == false && bAllow == false)
> -		|| atomic_read(&(pcmdpriv->cmdthd_running)) == false	/* com_thread not running */
> +	if ((!pcmdpriv->padapter->hw_init_completed && !bAllow) ||
> +		!atomic_read(&pcmdpriv->cmdthd_running) 	/* com_thread not running */
>  	)

In your v1 patch, you were more conservative and changed fewer things.
Once you start moving the || to the previous line, then it opens up
other questions like should you align the !atomic_read() correctly and
move the ')' character?  And the answer is probably no.  Just do it like
you did in v1.  No one had an issue with that.

>  		return _FAIL;
>  
> @@ -372,7 +372,7 @@ void rtw_free_cmd_obj(struct cmd_obj *pcmd)
>  void rtw_stop_cmd_thread(struct adapter *adapter)
>  {
>  	if (adapter->cmdThread &&
> -		atomic_read(&(adapter->cmdpriv.cmdthd_running)) == true &&
> +		atomic_read(&adapter->cmdpriv.cmdthd_running) &&

This is not related to boolean comparisons so it belongs in another
patch.

>  		adapter->cmdpriv.stop_req == 0) {
>  		adapter->cmdpriv.stop_req = 1;
>  		complete(&adapter->cmdpriv.cmd_queue_comp);
> @@ -388,7 +388,7 @@ int rtw_cmd_thread(void *context)
>  	u8 (*cmd_hdl)(struct adapter *padapter, u8 *pbuf);
>  	void (*pcmd_callback)(struct adapter *dev, struct cmd_obj *pcmd);
>  	struct adapter *padapter = context;
> -	struct cmd_priv *pcmdpriv = &(padapter->cmdpriv);
> +	struct cmd_priv *pcmdpriv = &padapter->cmdpriv;

Separate patch.

>  	struct drvextra_cmd_parm *extra_parm = NULL;
>  
>  	thread_enter("RTW_CMD_THREAD");
> @@ -396,7 +396,7 @@ int rtw_cmd_thread(void *context)
>  	pcmdbuf = pcmdpriv->cmd_buf;
>  
>  	pcmdpriv->stop_req = 0;
> -	atomic_set(&(pcmdpriv->cmdthd_running), true);
> +	atomic_set(&pcmdpriv->cmdthd_running, true);

Separate.

>  	complete(&pcmdpriv->terminate_cmdthread_comp);
>  
>  	while (1) {
> @@ -407,7 +407,7 @@ int rtw_cmd_thread(void *context)
>  			break;
>  		}
>  
> -		if ((padapter->bDriverStopped == true) || (padapter->bSurpriseRemoved == true)) {
> +		if (padapter->bDriverStopped || padapter->bSurpriseRemoved) {

Good.

>  			netdev_dbg(padapter->pnetdev,
>  				   "%s: DriverStopped(%d) SurpriseRemoved(%d) break at line %d\n",
>  				   __func__, padapter->bDriverStopped,
> @@ -430,7 +430,7 @@ int rtw_cmd_thread(void *context)
>  			continue;
>  
>  _next:
> -		if ((padapter->bDriverStopped == true) || (padapter->bSurpriseRemoved == true)) {
> +		if (padapter->bDriverStopped || padapter->bSurpriseRemoved) {

Good.

>  			netdev_dbg(padapter->pnetdev,
>  				   "%s: DriverStopped(%d) SurpriseRemoved(%d) break at line %d\n",
>  				   __func__, padapter->bDriverStopped,
> @@ -472,7 +472,7 @@ int rtw_cmd_thread(void *context)
>  
>  post_process:
>  
> -		if (mutex_lock_interruptible(&(pcmd->padapter->cmdpriv.sctx_mutex)) == 0) {
> +		if (mutex_lock_interruptible(&pcmd->padapter->cmdpriv.sctx_mutex) == 0) {

Separate.

>  			if (pcmd->sctx) {
>  				netdev_dbg(padapter->pnetdev,
>  					   FUNC_ADPT_FMT " pcmd->sctx\n",
> @@ -483,7 +483,7 @@ int rtw_cmd_thread(void *context)
>  				else
>  					rtw_sctx_done_err(&pcmd->sctx, RTW_SCTX_DONE_CMD_ERROR);
>  			}
> -			mutex_unlock(&(pcmd->padapter->cmdpriv.sctx_mutex));
> +			mutex_unlock(&pcmd->padapter->cmdpriv.sctx_mutex);

Separate.  Etc, same thing everywhere.  Don't fix parentheses check
patch warnings, but don't introduce new ones either.

regards,
dan carpenter

