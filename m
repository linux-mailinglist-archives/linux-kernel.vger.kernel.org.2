Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C6C640DBAC
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 15:48:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235997AbhIPNtt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 09:49:49 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:24194 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236119AbhIPNtk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 09:49:40 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18GDhxtC001975;
        Thu, 16 Sep 2021 13:48:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=k+i9rh4ajbT72yfgqL2i7csDfHqLEY9V/urSnHJTnUs=;
 b=D/lg2tKSR4ZlmII6ScWpVyxShk+j0gQTRhG2YZpigen7210fXH6Y+x0CHRLx8LhYLKYf
 0bx+OXbOyBHRAPv7VjD85EC76E7Rj0QsNomqH4N+7R7r9I+JjFI6zMKSAwPGyCzpiDbT
 ctgMgfFOp70XdN8umYUNkLvTbU0Silfsk0PcAhFDQ424nQMtQd4GSH5soR5Ak9GWAQTp
 Uk55I0lNx6kTzOMxHRO9fk2QjR1+0XUfJo0KJRYw0dPb5Ml49PCG/DAN/NoNNKMynD5T
 3n0cqfAaygTlRfLnoLnKW2gUXDP8VcEB8kXamqMv0ZGF3PIkKVkNISjoMBqWoBAX+bMG kw== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=k+i9rh4ajbT72yfgqL2i7csDfHqLEY9V/urSnHJTnUs=;
 b=UEFiyVCBCGYw9P9J7/W6yhtV7p8iMnKW/IqyNBxq3hqKvA7Xct9p1WGsM1XyPhchoTN4
 00Pl5BokMU9CnHLSxiJwtwfg0r/P+gf9yioR1NAwpg7EMcuZtdkwtzRSJzEMSlyYjl80
 OKHZFK6SYdsSrMTzmf9Sdh925sq9vIuMSQ9rCTLBp3+1bYqxQWuRy0QRHn7nckSX8SVx
 rLHHlPVEPTE8fdrSmp96ttX8tFJqAM1UVy10Ptbmiqgr8+h+MAIs7pR4lt6BPq6Tf35X
 nGeVracALmewmtKjZgoliBIy1j6AIRFw4XVdc3UOOKdI3KlvVqAT3OKz9liQrPwUavBU ew== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3b3s74jbw4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Sep 2021 13:48:11 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18GDkVYJ021722;
        Thu, 16 Sep 2021 13:48:10 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
        by aserp3020.oracle.com with ESMTP id 3b0m99c6p8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Sep 2021 13:48:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QOAJnyRnmqwFGc/qMBVUIGiTtrVTW/+uBhzMbQfGKxCkTS5mdPdkfSAEl4riINZ7UZ5+HH6zdg7zkbN4KuWJ4WA3krG1oqbw4fwdutuAIuBhx/uxaeu3lJBkiPRvAjaxZkKciaPVr8rLXJPayTUEummd89+iR5H4UwJqrLVbJboYiJFHVELkcx8UH8hwYr6NeBlrgn60A1opqaMA2rMowwJHz0FR2aWNKsA8WsQTDQmh41qDu34Pszzo3kkCUI6K6xJ/5GB2vg+KgoFLbi0VBfyLq1GnsTo3xa/2smk2qWqZG7gXfvROEVsbvYB8mWmLDLi486oQHAf5iaBDGKYhaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=k+i9rh4ajbT72yfgqL2i7csDfHqLEY9V/urSnHJTnUs=;
 b=lwVbIW44TNI/DzZH3L0NNNEvAe9jA1MrchdtZOhy7uUGP/SaYz4PX80YKKUCFzP8hLt450ACHL7peVbCGFrx/ZSh3J9cOl2GCuOZMhD1vzhnI5GG8Sh0ewbhLT41fOkp+AbTQ9i6HboHM9zhaKKg6jixqEW79t2B5Z1LlhFKOVdDoY+idgGJp6KqTWPd96xeArDgqNnewGrEFYsyW14dqUuc9nvS5utrt9H2P6E+yn1mGwQXAwqOD2kY+ravS217FlW+ONQX0UdvxwUj39/ZOMFPbQSakxM/lUzNQlNVSQDCYeYMQVhaAG9KfYQeDjbFTFFdmQGd2pYLwhmB+szylw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k+i9rh4ajbT72yfgqL2i7csDfHqLEY9V/urSnHJTnUs=;
 b=zWk8wP6Beta6333mjy7fYPjs/JSCXOehY72/Xhkj/ywIOIE/OuwFr9VenQnWqjG26NfQEUuZIZ03V+BM3Jk49DnsBKLCGxVVhCDW7H7ewcfT0waf4eaH96ulV1Y/yQAEYh0I7QuUJ9bKyQtqtvZW68tNWojnd9L9IMjaeR9I8cA=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1248.namprd10.prod.outlook.com
 (2603:10b6:301:8::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.16; Thu, 16 Sep
 2021 13:48:09 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9%5]) with mapi id 15.20.4523.016; Thu, 16 Sep 2021
 13:48:09 +0000
Date:   Thu, 16 Sep 2021 16:47:51 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     CGEL <cgel.zte@gmail.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>,
        Martin Kaiser <martin@kaiser.cx>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Changcheng Deng <deng.changcheng@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH linux-next] staging: r8188eu: Use kzalloc() instead of
 kmalloc()+memset()
Message-ID: <20210916134751.GJ2088@kadam>
References: <20210916021658.181216-1-deng.changcheng@zte.com.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210916021658.181216-1-deng.changcheng@zte.com.cn>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0016.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:3::28)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (62.8.83.99) by JN2P275CA0016.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:3::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend Transport; Thu, 16 Sep 2021 13:48:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6c64c2c4-914a-4281-ebeb-08d979189dcb
X-MS-TrafficTypeDiagnostic: MWHPR10MB1248:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR10MB1248D63081DCC874DC8BB5368EDC9@MWHPR10MB1248.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:374;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mYmnaZK5pVuwCRs7HWpDxlJyu6V12voArbj34FOwi3XeGlipV1fdIt48kVh306Dpb6sn9CvUb7IsxPpgOZf9Z/9hbsEnd1B4IzlpoHQy0DUBNO+EwxVPzTWVdVUJyM00/vOesL4OS/mrZj/drGfMjnZGUqtYbqoMWfVDqj0/Rur+d91kTzz63BMCf0zasxG1Pu/pLXu63rDPh3D5uCavJPncoSKDGJGx27J31I5qLXWosP4UScD3HhZhUFywCC6YVSB4Ti297XhS2RrxO7ZD+iI0SbGX086/fi9UJxeod68HhHFWs0LPOJIr96NmVXvmxQMBC6G2FDs9ffaZXE1mO+y2iGvgqJARpzZwAOsdmzb/mtXIt+PoHLMUjSrKH7FC6x7kS0L/YdCu3na0dSpRxwkLDj1zBHZXr9pO0nhGaYwegsIPVGD7CjdKcntZPtwDmVq/+LW+RWNr6FYZ2Jqm3nrUynggi4+Ra+zG5pxOY/u24QAuxxO42zzcH0zR3lFXo5ASjM9zizV1wb/HcZvElRVrfCMTUdBVTWlvcpv5rKousRlOYyuK6Dc2uZ8kElC7qPcWRY8BNdepqKk4X21QA0zpv2D8sgO3+lK0ovuhco5itfxpJTZMhlIW/qQ1ag8vpKRdUCCgArSDK6qCf3I2AY+OPvTx4DJrVoc4ptntrBXLmwCCO2yOHgZuvmVEnz4hQr4Rs8sb30XmGn0i3DE4nA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(39860400002)(366004)(396003)(136003)(66476007)(9576002)(66556008)(38100700002)(83380400001)(6666004)(8676002)(9686003)(54906003)(7416002)(6916009)(38350700002)(4326008)(44832011)(66946007)(86362001)(26005)(478600001)(33656002)(186003)(52116002)(5660300002)(1076003)(55016002)(956004)(2906002)(6496006)(8936002)(316002)(33716001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?foT4O5ouovyGq0s44xdRXDrD5CLeGelYt2M2x1sXyiQccKxHLvdYCLQ45mTm?=
 =?us-ascii?Q?Ler/b5HTyzH7gX20As7AQFaKkUVeVj9k3Ca2xGmcO0pk8GNniDzt01sKcroB?=
 =?us-ascii?Q?C497RrWdRYECEJjHv3USV4J+miNFcg20eoEtrcjNH89EJPTWGuNvXhNADWgx?=
 =?us-ascii?Q?tC4uyqG3pLyrwz1HeYVPpDG1myJnpEGir/vmoRPpOwmFgevK8JoMClJxBdHD?=
 =?us-ascii?Q?2eWmiRbQ9HPmtJOqbNKXXGQt/AfMg5JE1c53/ID4HgLjUsuCWTXj1v/kKOkQ?=
 =?us-ascii?Q?HjqRgOLbei5XCDMgWIbG+bdDFRhvpV0qJslJNdY4PtqgE5kxr0m+QpfOkd37?=
 =?us-ascii?Q?v/NAKaLshEtYFONEd5e7tcBzbqWi3bih1QQWsunGyGJyZjUJ+ibhEpIfSNTU?=
 =?us-ascii?Q?e6O+bfZfQbbJcCsdotZ/Imz1aqGYaPiye02s2Jf9MQL1NNWtgC+Dz7yKnoA8?=
 =?us-ascii?Q?aEw02ChjAf+XmORKtmaNhfgJr4QU3TOePT6+DY7TUOPJ/faaPln4oa51Yods?=
 =?us-ascii?Q?ckb/bi3wL90HN7WiKoK118JRLCQpKv6Uic7i9atejKe4ni60Sxnp7me+BHyk?=
 =?us-ascii?Q?HGK640db1gBGSIRNr7XAhDfgmvZUORvTv0ZsnlarZpYWcFjL2jrVeVE5Ym/M?=
 =?us-ascii?Q?dl0rDOlsVuhnfEmVsVPQmzu4t0wOtNwWURYD1F+/jGuwHEhcRTmA5WfGU6G9?=
 =?us-ascii?Q?/YALa4pglOYMl14T8vn1bqC9og23GkdRNhxKdoAUeyD26qI5JaXACk5nkhk3?=
 =?us-ascii?Q?faKLBgqBgYamUOZ4LJQ194tj8FqH6LpWFKT/44guIerGu4ZFLNso9lrFnovb?=
 =?us-ascii?Q?AlKP5wqVax5kPmTQlTrDsZJrSb8QfEq7m+ZjA0juQ7ArS5RcaeseQ+BmcFiO?=
 =?us-ascii?Q?2Ii/zCLdFV4Y+toUibE573i35UE7FBrV9bahcusx+br5WOJ83sx5BAyulB86?=
 =?us-ascii?Q?K5tOx7sgqhJ3IpMtOG1gvKSoQ88Mm9gUAewsHp+roHpuUq+YCw6nrLVTMs31?=
 =?us-ascii?Q?nGMCZsj/Xh34lUSAjN8VNeGuJmgL6BaWhvlfJh0HzPLRLacOsSpOaTx70zCk?=
 =?us-ascii?Q?rNslRpYP8Rdc27WJBlsG1xpJX14zwvbDbEdQ/WeTTWwfpHkz9v4h+NKu5xUi?=
 =?us-ascii?Q?2pocEbtU7+rrstm19+HWMn/LYwkIicIG1YiDzLLBolQfeIQ2ggFgkKHVbg4F?=
 =?us-ascii?Q?pT4P7KpKlxJUA9uMOA0Axj5Mj/VQxaPwBQa5K3DnT7Urwh85V7TWfMh55MTi?=
 =?us-ascii?Q?VYu7Tt3jgwxMXAdQ4Ln9tkYNeSauoyWKbIeF9USyzuXWXTUURViUFTbVUs6H?=
 =?us-ascii?Q?jLz/QhTeE6aw01Ea6rBwrKQE?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c64c2c4-914a-4281-ebeb-08d979189dcb
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2021 13:48:08.8945
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Shv0e56tdTnvQNmov4ejTY1iTpoFP3EcChk/scOBF0bZMr/sbZwg1MZvSAj9YVj5fncioQAgOmsoZvmq3kbOXNSd9lzNMJrfo/KNEz16OWk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1248
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10109 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 malwarescore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109030001
 definitions=main-2109160089
X-Proofpoint-ORIG-GUID: _2zcHImsfrxghEgmoQGR-B2o8eVmj9f0
X-Proofpoint-GUID: _2zcHImsfrxghEgmoQGR-B2o8eVmj9f0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 16, 2021 at 02:16:58AM +0000, CGEL wrote:
> From: Changcheng Deng <deng.changcheng@zte.com.cn>
> 
> This place can use kzalloc() directly instead of calling kmalloc() then
> memset(). Replace them.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Changcheng Deng <deng.changcheng@zte.com.cn>
> ---
>  drivers/staging/r8188eu/os_dep/ioctl_linux.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/os_dep/ioctl_linux.c b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
> index 92b8f2c..9c257c4 100644
> --- a/drivers/staging/r8188eu/os_dep/ioctl_linux.c
> +++ b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
> @@ -463,11 +463,10 @@ static int wpa_set_encryption(struct net_device *dev, struct ieee_param *param,
>  		if (wep_key_len > 0) {
>  			wep_key_len = wep_key_len <= 5 ? 5 : 13;
>  			wep_total_len = wep_key_len + FIELD_OFFSET(struct ndis_802_11_wep, KeyMaterial);
> -			pwep = kmalloc(wep_total_len, GFP_KERNEL);
> +			pwep = kzalloc(wep_total_len, GFP_KERNEL);
>  			if (!pwep)
>  				goto exit;

Missing error code as well.  It should be "ret = -ENOMEM;".

regards,
dan carpenter


