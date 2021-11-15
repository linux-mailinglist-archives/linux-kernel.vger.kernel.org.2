Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2071245036C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 12:29:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231284AbhKOLbh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 06:31:37 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:2370 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230455AbhKOLbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 06:31:19 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AFAEBCC002809;
        Mon, 15 Nov 2021 11:28:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=wUCzYP8zSD4cBcEaeMQhvmHoKgPdr6P9KEDcnl+87w8=;
 b=c2TSM5+EYvmB6VDXQoMzS7Z1pp7ARIgYvVF3MoWD6UEJdKl8h43bZlv++6HpoSHcKQA/
 AjaVmBXHF2aDh9JOod5pu/jJcn1GGQe2jT/2qTJrbsZ9LAqz70GKQWvZejBroQZvqj0W
 boRJOdbJKVHeotDdnIH/qvmCvcFcdHPoxML4luVz+qgCnqPpeo1ZvgOOV++7zo8W6l3o
 1FojP9C6yjBA4Y3MKqNYUStBe0GGLmg8Ra4sfy3zob4JJmt5W41svsDYtO19J62RMLfe
 xg8L168kJUKu2pmY72YwQivX2pXar5gRTkpEWeuINPkXgUSyhL1arP1rfwWIrR4N4xR+ Ew== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cbh3dsnjg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Nov 2021 11:28:12 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1AFBAwR6155796;
        Mon, 15 Nov 2021 11:28:09 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
        by userp3020.oracle.com with ESMTP id 3caq4qura1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Nov 2021 11:28:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ilo8IRpZ/V+oC4vXIvvzHNS5v7kjugJR3RNFwnjiBlhJ280w6t2OoIvbUpnkilrx8P80IjW4sy85r88Lg8SW9k8et8beqWAxshV8DSAxrEcstL5J/WcR+yIOPHF14cByGTISrf2lrwo/p6SgdxdnbRNzarAtowMqHuAtGYlPZHwsHT7g6O6UL+Xcm2luYFQPDDG0wriD0zlO4KC6b133yrJ7lSXH9DkbCK1ag/r1aU5yhXP7yE6L335sLfBZw3vTpwTWrvhiyTzHgqryHlNsY88CaaMQXTKTax0lf70TgyY4VOwOAQjsWn+A+BJUwfeilncSCdv/VormCIixOybuUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wUCzYP8zSD4cBcEaeMQhvmHoKgPdr6P9KEDcnl+87w8=;
 b=aZAMRPjrz5V+JTL0uVpw3zzeCxyD1pWRHgb8u42FVJwd8DEfieEWPWjU598RThMa3YokXVQb4L8whjTdFgwvnrGXC5nQ8a8C1a4Ie71AHGGIZ6l0WInFHqQ0sVgTLmXxu2OORQ78WSh0pxNhcfhnkOMLYtdLJyaugPDztz/vZvwgaPrjJAgcfiy7NMueTTrRNfmCVps2dAfEt23OXnd/DQF3WdGTBeC8zE4kjRAsi37K+fdkw7jp+AbXy4+p1XwE61eozyI/2RskBapfOREy87BTBRU8CQ52tSm4TejcBzvSDtDmR7UuSlwIspFuePOP1fgXPjkf836HSzX8a+09Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wUCzYP8zSD4cBcEaeMQhvmHoKgPdr6P9KEDcnl+87w8=;
 b=yqDq0J3khuZVKthzVCp3WVCAK+olb6kBvLSnLItr4F4+HXWIZ8AAwbTlxETwnhc3AqzUpPKgw7k5f4BVE9orkBBBbWGNGPbVvqG3RSBwIOwygibnvDK6h0chnGg68vMugnhIlABxzyoEWgm7VSDTDilAejol7KtYOb7a0TJYKuo=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO1PR10MB4595.namprd10.prod.outlook.com
 (2603:10b6:303:98::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.15; Mon, 15 Nov
 2021 11:28:07 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9%5]) with mapi id 15.20.4690.016; Mon, 15 Nov 2021
 11:28:07 +0000
Date:   Mon, 15 Nov 2021 14:27:48 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Martin Kaiser <martin@kaiser.cx>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/15] staging: r8188eu: remove test code for efuse
 shadow map
Message-ID: <20211115112748.GC26989@kadam>
References: <20211113185518.23941-1-martin@kaiser.cx>
 <20211113185518.23941-4-martin@kaiser.cx>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211113185518.23941-4-martin@kaiser.cx>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0007.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:19::19)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (102.222.70.114) by JNXP275CA0007.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:19::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.26 via Frontend Transport; Mon, 15 Nov 2021 11:28:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 94ad91a6-fcfa-4b13-ce4f-08d9a82aff39
X-MS-TrafficTypeDiagnostic: CO1PR10MB4595:
X-Microsoft-Antispam-PRVS: <CO1PR10MB4595290829434DC2A60CEC4A8E989@CO1PR10MB4595.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hPVpfXeiquRDlzp+OhAjd/T/A5RsCsur8R1CynpEYYKi+/RKQ1ga1B2/IXqw9joyoJDiduupKu+tk2rlRyHCtUJci20d67SDqaJ+d+zLtVukxBYYgOJkKZq99TrB/scWnOVeahMlEN5EqInuOkgY+3bUqAo3+ozRhmVNW6XzbehcCoHKz4+CnsQP5/9XCC/G89AgaglRSZPJ8h3mKFz8iuuMOXJhXK3TVsKGkXSRXJkS3RlYWdr3IEY0VdFhKWRXmEqQ+MzGkJspTM1hNgQuSuBD8pxT45zsRSNTgnTtF7VjJlFV/MntnBxQ058rqmZp2ukFM4Xez6ykIIG40Qlmg1kRgjVn+LMwagJ5KQqsbc1g0tuCVsj45LnxeZIk2Fz/5kyVCPHPTMPi0/3A0x4lyr72XWR+a/peTX4GoPr0H4eNdaIHX1L9qlQruCSXgrbk3i4Oo+AFbu/P8/E3B+KUsgoXddi4KcttwiVwsb3WOvUnPWxStN80wHnUeY5ZA3INlLYk2ZMfL2aLjMulNNCauDf1k1NneW1Kyjaod8Avc3KJ1wrLpym6xCb+CQsibHAfsbzKujLpoTiYdzz2vmeZZV02ZqfGiqnHjRvfSH0FxOhOd+tMDOiJfDdU4N63S0BiNSS+X8Yy1Sxo0pdivg3RVhSYSono/jPMotCtGB2A5To27VvvBMK+RtjSmo8zDi3bOdNaTvZY0yd9nrIKZwEGpw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(4326008)(33656002)(186003)(86362001)(2906002)(956004)(1076003)(38100700002)(26005)(6666004)(38350700002)(44832011)(508600001)(8936002)(9576002)(5660300002)(8676002)(54906003)(316002)(6916009)(33716001)(52116002)(6496006)(9686003)(55016002)(66476007)(66556008)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zk9gnzsAjTyGOG9qawklc4PbB9zddVuB9hO19YO4FVu+nPg6GllGmpo+MsLw?=
 =?us-ascii?Q?/RWW4bC8SkbeJPZ1IWPQpJKzZdAqdnC2dNT0ybXxwps2Loo+Ah0JAMQd/etD?=
 =?us-ascii?Q?vZAyqEZceqEPhMp9O+uQl5V7uBNpfoc9DWGCX6vdj/6mHBQ2r7muMd4GpYTF?=
 =?us-ascii?Q?uPiSEYTAZFIuaxLXyfen8n/kUFTLa9l/hRALYdRPIHVosD1xZ4nZ6uBKmxBl?=
 =?us-ascii?Q?W+S1uJ4PvuN108MekpUaLKnCSA4zYlEXvgsFh6fWrB3c6PJ7fWkOcJx2kVzN?=
 =?us-ascii?Q?vmje6MYaUaURBLAMQecf0DvCmQ2OgX5xJhTFLsO1tCL0R5yiqMVdQF5wYLcq?=
 =?us-ascii?Q?2qMuT1cE7bMIjPjquQVxOn9Q4sWmzH1uUQ9JI0dbK/Ase9SdEG83tafl441N?=
 =?us-ascii?Q?mNHqPSJIg2Qb8nsoZP0yCxvGijUc7Y4dNdAT8b32uBMeGoneEqxLFlFXWNe1?=
 =?us-ascii?Q?y0e5mlxJ0zFlPvc+PYHwxDP2on1njbnqFA4A5udEd/9NPhli2XBwMzIsx36m?=
 =?us-ascii?Q?UjLitDbdoe4ZxS5bDVO+q+gRSF4UpfV1icI/P4nGQmspK3yWEH2BOSR0Uwh0?=
 =?us-ascii?Q?QIxeNMZV90wPBRtXAwlRzWzJjmI1tnR3PWjkzSPSztAKwjx1C82Sq60qcF2K?=
 =?us-ascii?Q?bWTogn9ajriUQ6tPLxuX0Aq0VXOohTOPJkwtnOo4OVXhyMSlNbjLUjYx4Sc0?=
 =?us-ascii?Q?LSERYXZ2eEPN+0jqsu9tnDe947l2LwgEyiYUVOis+UMSW7ZQtF/+sFf3TtHd?=
 =?us-ascii?Q?3Z7EKMTkcKT4cIsOZ0VmZn2NP7hH9QAV9yFOALxhs4xLtotKo8BYONM9n0VC?=
 =?us-ascii?Q?y56F/eGVGDE/RvP2HgTRIgmvTYBYk+mo7UwH9CweHihAjx2kkr25ap7fz/2n?=
 =?us-ascii?Q?S10pgRBw3t+V6j51fQ0Ygh7yJHoZlMpUTObTNEY1MsiEKL5s9PiwXmrzCuAH?=
 =?us-ascii?Q?DTjB164HjSRKs5joMs0sFWYoNEKRby/ZjwzDeJjIVyMJtLpsQyCC3ihAfVKD?=
 =?us-ascii?Q?CaJUwTetCwzlNWf1CuRPujqUtoa96ScZGTxDYumzLQjhGcXhpGG8Y8UCPmMy?=
 =?us-ascii?Q?6tW1MVQlGoyNf53KAb9VbU3jI/JofbdkO1Tx8WjzIzouPfSVLBz7CM1gihTO?=
 =?us-ascii?Q?pa65OSR52IPArWxJvlIQXhV3s6+xVv9snsTScnKrJmsm9jNQcXXBdDx/UIpc?=
 =?us-ascii?Q?tE0Nk+fR+VzuL6Rp35prt7cJdPaPbsEqQrfpHfSbbxXimAuX2gnN003CfQ8k?=
 =?us-ascii?Q?pJqAQkEKw0dz9vORz8oD8AbflHL8K5BbwAz0LApYjtsY0e95D0JsAAs3+sHo?=
 =?us-ascii?Q?+jypZUcHmA5FEbX7hSXUllMswp74du1QHaqLOmbPqRhKY0YYhp9d3MTuNn5h?=
 =?us-ascii?Q?70nK6dsLG96/gGWvSZmfe2U/CHT+M6cfqVxvfx77sszoQNGZKQQuTdgba41Z?=
 =?us-ascii?Q?H01UGU46DL4D4X+aTnV33hQvKgN3hILBT485zYqREK/5S9N4dBBdn5eeqelD?=
 =?us-ascii?Q?NEpFEzpynu2GpbLVmuejHP5H0/MLn2iynAZbqEpNMymJYRdcn1BojWsvNFEA?=
 =?us-ascii?Q?TxrdbJr58EzSo8hbLhen7QIUx1o1hNHJ3jPEKoo4HbDHZdFY0aL7D2Mzr1Ej?=
 =?us-ascii?Q?dSThtiSDtSICgNFeS+TbknkiS8Ihx8dHn+s1ECP+7+bwNsss85ohzT4hGH1I?=
 =?us-ascii?Q?jbRFpnp0QR5iL3L3DF18SbPIZBg=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94ad91a6-fcfa-4b13-ce4f-08d9a82aff39
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2021 11:28:07.5815
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NNmhx8NZ0DaBp4nzby4C/3WOJCi+E3iS4SD7oVBfN4hToVuvUFe6gAzBtPRE2r5Q/3iCgaCH17M8ZjYga7beqHDiPe3UqKiZGmgbrwxjMnE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4595
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10168 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 mlxscore=0
 phishscore=0 bulkscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111150062
X-Proofpoint-GUID: Ou5_i_zoZLiLfj3jnt_901mHol7T-mxn
X-Proofpoint-ORIG-GUID: Ou5_i_zoZLiLfj3jnt_901mHol7T-mxn
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 13, 2021 at 07:55:06PM +0100, Martin Kaiser wrote:
> @@ -815,38 +813,26 @@ static void Hal_EfuseReadEFuse88E(struct adapter *Adapter,
>  	kfree(eFuseWord);
>  }
>  
> -static void ReadEFuseByIC(struct adapter *Adapter, u16 _offset, u16 _size_byte, u8 *pbuf, bool bPseudoTest)
> +static void ReadEFuseByIC(struct adapter *Adapter, u16 _offset, u16 _size_byte, u8 *pbuf)
>  {
> -	if (!bPseudoTest) {
> -		int ret = _FAIL;
> -		if (rtw_IOL_applied(Adapter)) {
> -			rtl8188eu_InitPowerOn(Adapter);
> +	int ret = _FAIL;
> +	if (rtw_IOL_applied(Adapter)) {
> +		rtl8188eu_InitPowerOn(Adapter);
>  
> -			iol_mode_enable(Adapter, 1);
> -			ret = iol_read_efuse(Adapter, 0, _offset, _size_byte, pbuf);
> -			iol_mode_enable(Adapter, 0);
> +		iol_mode_enable(Adapter, 1);
> +		ret = iol_read_efuse(Adapter, 0, _offset, _size_byte, pbuf);
> +		iol_mode_enable(Adapter, 0);
>  
> -			if (_SUCCESS == ret)
> -				goto exit;
> -		}
> +		if (_SUCCESS == ret)
> +			return;
>  	}
> -	Hal_EfuseReadEFuse88E(Adapter, _offset, _size_byte, pbuf, bPseudoTest);

It looks like this changes how the code works here.  Originally we
called Hal_EfuseReadEFuse88E() fir rtw_IOL_applied() was false or if
iol_read_efuse() failed.

Was that intentional?

> -
> -exit:
> -	return;
> -}

regards,
dan carpenter

