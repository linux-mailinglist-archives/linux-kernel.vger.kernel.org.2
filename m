Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B159459D77
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 09:07:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234598AbhKWIKF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 03:10:05 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:65522 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234199AbhKWIKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 03:10:03 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AN6Z4XS031836;
        Tue, 23 Nov 2021 08:06:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=b3cwEePmPAptyyiFR2PyspCI/+7WkzSxiB1LJszw/XY=;
 b=fltPXathy2R92uPFtlUkRaMagvbZGAZtw2nM6IhTRV5PvB2PpSht1iteFCpoXz1oCD/I
 c+RXMkkF+gcKecoisd8XR9ZePQvbc61Wn4PZmA681zRAE2kTLxwOkgMMhAhJMPXvpLDD
 FGCtkshzhnVhN9gyrYDUhQlC9rTtIEcSsi2BHeULK8i+biUwSIi9wqkVNr319JOyoUNC
 6ufAQwHKIyu6g0mfePNIK0ukSXlxNQ+scFY9AbsHkxVH3cH/uZ1TO7TxUlZg4p7ADEMT
 hxHGdrwOvbjfa7Elo4jY0hmXjnPnNE+IXWdenPh2Ow2j8PS0IPdZxjEbSHVlP6OxTLs3 tg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cg461fg7x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Nov 2021 08:06:46 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1AN80aWU134840;
        Tue, 23 Nov 2021 08:06:45 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
        by userp3030.oracle.com with ESMTP id 3cep4y0mqa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Nov 2021 08:06:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QjbLO9lo94UKko/QFrxEkJiIfGrN7WAfgYzNadgAiHuknkXJvmwpgXn3YD1Jal6TKiswlQYpdMu+lt8i+yEZimZm94LyFqjUHD9FLmlMqgtIdkvsyZ3DwZor/zNqLKLstxq0RPzfc+EvGPBi917o5F1trscL+t0xuyZfuZ2/TWAYePAQlhw78wQ+KzQXVLPvKLRfLiZMtJ0mG+afsiZeK56nb6/+wBNzzndeR55gm4CCN/rl0hZfJ4ddchGIGmvfkSNZryIT2GxYn6ZRkRZs0j22s/0A9QFc32bOuMScqDgNqdWyKRhyyi47GbxlOMeQWsO9SUk4iDAQbggEo0zzqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b3cwEePmPAptyyiFR2PyspCI/+7WkzSxiB1LJszw/XY=;
 b=BpvjcpY3bxnRBFWIFi8J3YutHoXUfpYcoCFC9JvT0y/ppb7YqAdN0r3/UMl21DuXxAnPGgo7Zm9EzG6YPGHLWgJ1c+CAHdNwyNBTa0rHgcJyPZcQuepkmE8M5jgiS6RJ88ym3duAKEByBOUyYtF5xETMr4LmICzB/XD6uyTK0KbAKaI1I010MAWt7RUZEJ1hgYrCDgVYNjKitIrDDv40bWUbzilof1dqiyaRMiuMi/nbfTvxavoz4OPCca5qp2HqgiIDBvidGYE5jGRTzLH5kn92L4jKxLeVaP7iTEnKfjG0+yVF435M3nImiWV3nt65qCvyGipVUGRyWkoCVCFDJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b3cwEePmPAptyyiFR2PyspCI/+7WkzSxiB1LJszw/XY=;
 b=vX6Br9ETwDS6ZrbRrZKnfc7LBRul6WK7MfOpkfMlqL330fpLpbFlLQ3oCfuwiA/LXkLZ+duX5OAIvRB1vPUYBG+2I3hJhHfayPb+NRIBtdWEdtGWCrZKV+idf5ew5hOEy/BRnkw7Zb5Jgs9Sl4IinE0ehNryvc7HM3S2/ygpHAE=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO6PR10MB5553.namprd10.prod.outlook.com
 (2603:10b6:303:140::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.21; Tue, 23 Nov
 2021 08:06:43 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::495f:a05d:ba7a:682]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::495f:a05d:ba7a:682%6]) with mapi id 15.20.4713.026; Tue, 23 Nov 2021
 08:06:43 +0000
Date:   Tue, 23 Nov 2021 11:06:21 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Vihas Mak <makvihas@gmail.com>
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        gregkh@linuxfoundation.org, straube.linux@gmail.com,
        martin@kaiser.cx, paskripkin@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: r8188eu: remove unnecessary NULL check
Message-ID: <20211123080621.GC6514@kadam>
References: <20211122195350.GA166134@makvihas>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211122195350.GA166134@makvihas>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0034.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:2::22)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (102.222.70.114) by JN2P275CA0034.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:2::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19 via Frontend Transport; Tue, 23 Nov 2021 08:06:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3bfb3ad7-0dae-43d5-24ca-08d9ae582f6d
X-MS-TrafficTypeDiagnostic: CO6PR10MB5553:
X-Microsoft-Antispam-PRVS: <CO6PR10MB5553579346164D811D542A958E609@CO6PR10MB5553.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fil94GZjvh5zqFHaToqsFJNkKOBAT9uozhX/divu7qQrh1FPfC/Xoh09SGQn8cHYdzOt5PlyyDjrhLM1cwYzuNeG5HRc/tcMAJW0+P6uZt4nhnIIlyfszsQgEN/59nxtkr456/KBQPoujnc2W7buZk1SaTXb0qw4iPpTXfXNcwylegPCxlrglUjnUZIKuETV7PyvSk/lyirMAxB1oZBuf+NBktPOS0RhMh9TmPsEa6MGC74wHy5+XDX6kfNSLC/grvxbo4GyKSWhve6kfgfvI4UmsiBlVTo97WAUvunN/vnn57eEk60J1H7sWAa/RRyGebb2+lU71RFuZeA+R2s56O5B7Qgz6x0t/MP4NIxqYRhc/mJaDPsmzEikV6+eS7k++nZTwNB7rFwte1ZT46Ar6RSDL7BgLEW/xue/9D1EMzLGvneJghV0iDGwDYaZK8Wcwhigk78fksC+lamwzoeKZALp2WiM2rNMGFhpaQrozqZJ2OyjNzD805ABatEftAdUE8CFBz8WWbYLayC+Fc7OhrnBW0hGg3H46JCC7IEUtikeE3scADWm4keevgqm94WDj+bZ6PdxJPh15uRgisphteNWIefIr8LJORSnN9KpK2t6EJMVK15HSwHuT38PPSGBYdgYGwvi6vXhXxWsproCGc8xChjgrKfkd/IMLhVoU79ltDO4caeuA2oYSFnoYcO8ePOkh0shG7nTRMl29KdJUQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(26005)(508600001)(33656002)(86362001)(38350700002)(38100700002)(1076003)(5660300002)(9576002)(83380400001)(66946007)(956004)(52116002)(4326008)(6666004)(316002)(6496006)(6916009)(66556008)(186003)(44832011)(8676002)(9686003)(33716001)(2906002)(66476007)(55016003)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Pbk17Qmwg+XOuY7zCZKXuzE9t7GSlZm5PPrSps4wdIBu33fh+g5V98KXPL5h?=
 =?us-ascii?Q?fYovxo2ZuUv9kS6a93+C/LPG9I9ifJizhuYDGPnHMQkdL2RdcawYdm5AbWAE?=
 =?us-ascii?Q?GvLKb4V2sw8CWHjLLqNA12UU8aV9WzlMNrKHYVfBRYR3CYYxbMJYqX4Y0TbB?=
 =?us-ascii?Q?ejBic3kMi81WlQmjGr9twKr9KXN+MOkjATFiBoLP38SzWfWAZe4GYPQI/p2Y?=
 =?us-ascii?Q?iHEUBxzJGUTnIuhZpvp7Xl6PF7hPGWhsJzrckZ+VJkS27ETQgUhcXGdsTBz+?=
 =?us-ascii?Q?dMlNetl02xq1ys246OcjkKHfHYWnUE/tVBtcQEPA9sto191P06isUCQTsOgn?=
 =?us-ascii?Q?8sk3dxyl6uNo3AALzf7V9VPI23yPSnd3+/XgnXvuKWYVuMx5cLpw7gAyCkag?=
 =?us-ascii?Q?7Q4uSh1L/IsbNmy5IzP4GcnIfWR38EifHnuzYVAaFElAyoBuZwZsnMVMJAUs?=
 =?us-ascii?Q?IE4iVOyYNsu3xh6lPpe1yXMo4omVm9cAlgSSakuPamybfaQJZWSMI4jBGsua?=
 =?us-ascii?Q?2kWVX0G22T1mOXIfxjJ2jC8g0LXNU6QHc7I4QLfX3lAFW5c6v4Y7/jbTSpzH?=
 =?us-ascii?Q?lXXsK5bYNwyWVSDjZmy9pOV9Fv/4OgcgV3VqtAFij8rpelPlFT5RkB1bf0dZ?=
 =?us-ascii?Q?fFHh8SeaUSXBgXbjW5kkShqWOzS/q9lx9kwnp21mbQXvJeU1mUl5f8FA5Vt/?=
 =?us-ascii?Q?Th7SrVyRLb5C5NujIp3Dy1tb1CZ287s4xdle06Bhk3XCB2fnZrpEF8eMd6j7?=
 =?us-ascii?Q?WbSYCfv9BcmuZh7rkr67nZSAD0iC4ONxMA9E2yrtjyyTLyOKU8oOR77udsGr?=
 =?us-ascii?Q?HfvxKoLtdSb4NpUC1YNWEciz/ItI+TrS5UOfgt7HkD0x9idtAEAH/RMQLKkv?=
 =?us-ascii?Q?DAZAHgP8xk0loQrC9SIljyX1Pnqdk6hhvRJWOfMEnMinFEwDWrWx4FpALRKQ?=
 =?us-ascii?Q?kk+xDy4YdNx2z1Wh4L1jX7EFeiO3SzhwIVY/kCYWI+FI7HIKZ3315wFhnW8K?=
 =?us-ascii?Q?vT0oQMNxa6qGB2y+S/zJTnTIdwnQ4YDLbK/Lfu6wOxy92ZI9PvSsJvfrKDby?=
 =?us-ascii?Q?6f3K3lTyOXxt4H5VeAkEcwUMUi/Do1OFn3vwtL8jDc5hZCynwP+zL/0pCChN?=
 =?us-ascii?Q?GXzHYes/MbvEJaBvhfaxilugU//xDi6roY3tPMF1oMKW6FPaxue7rlo4VFXN?=
 =?us-ascii?Q?t/U6kbv5n1Rg7lx1PtV+2oTC1tLtGf0LHFuDK8uc0UZ3t+LYPc4hQaRdH4Dv?=
 =?us-ascii?Q?adsni9gooYWe622UTks5yO8Jox6x2iZXNFG0YyovM8zUeOfhtzprFghQTABW?=
 =?us-ascii?Q?pnO4otb2Yh7Kx6w7nWehYXkjAg2orQthgaElOoaxHJp35kKpdGsuppB/2daK?=
 =?us-ascii?Q?t3J3Yi/x+Zf/7eojBTYUxtXNwCHDBDSNLY3YCRxsyfaZZVhK2qzYUxh33nDE?=
 =?us-ascii?Q?Tje6QXorFFnqofvxcRMzMizqS1rlJLN/mcW4wbPLqR5/QGjIRwVEWVaR1ecw?=
 =?us-ascii?Q?n5VauAaEWJgLyKTc4ZLDhR2QMagEOvKz+8qRoDqBYIMAwy4o0m+CrEfvoIEm?=
 =?us-ascii?Q?6tcJhbIBLP0gGgW/57cADPkpEGv8x8Ha0i/rEANqzkc+R1JdoMPdffHt/V36?=
 =?us-ascii?Q?tYpnagcjbZw14ac4NKYXM7kEB8stXplK+UDj8McTlBPTOH6JklmC5x6PNAXp?=
 =?us-ascii?Q?1HIGYGXNy7ShCWfHfP8oK2oy9Ms=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bfb3ad7-0dae-43d5-24ca-08d9ae582f6d
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2021 08:06:43.1219
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GMoHl4RNgr80F3XVuBqiCh7A+/A7mi9T34a3MDsCoKrX4HssIqQnml02CxVfCUiP5dWGql22PwlyStu3cB3OwhHKwAmwCZI1w5UjLtp8ENc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5553
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10176 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111230042
X-Proofpoint-GUID: AgK8zNLX9DVWJ9kaGrofdeFWHmd2qk46
X-Proofpoint-ORIG-GUID: AgK8zNLX9DVWJ9kaGrofdeFWHmd2qk46
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 23, 2021 at 01:23:50AM +0530, Vihas Mak wrote:
> remove unnecessary NULL check surrounding rtw_free_netdev(), as the check
> is already performed inside rtw_free_netdev() in
> drivers/staging/r8188eu/os_dep/osdep_service.c.
> 
> Signed-off-by: Vihas Mak <makvihas@gmail.com>
> ---
>  drivers/staging/r8188eu/os_dep/usb_intf.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/os_dep/usb_intf.c b/drivers/staging/r8188eu/os_dep/usb_intf.c
> index 5a35d9fe3fc9..392bd7868519 100644
> --- a/drivers/staging/r8188eu/os_dep/usb_intf.c
> +++ b/drivers/staging/r8188eu/os_dep/usb_intf.c
> @@ -466,8 +466,7 @@ static void rtw_usb_if1_deinit(struct adapter *if1)
>  		if1->hw_init_completed);
>  	rtw_handle_dualmac(if1, 0);
>  	rtw_free_drv_sw(if1);
> -	if (pnetdev)
> -		rtw_free_netdev(pnetdev);
> +	rtw_free_netdev(pnetdev);
>  }

I'm not a huge fan of these sorts of patches.  They don't make the code
more readable because they hide the complexity.

Occasionally we will get a forest cobra in our yard and everyone is
screaming and panicking.  I'm like, "Calm down.  Once you've spotted the
snake, even a deadly snake, then the danger has passed."  You can just
stay two or three meters away and you're fine.  Call a snake catcher.

What you're doing here is you've got a potential NULL dereference which
is the snake.  And this patch is saying, "Snakes are so messy!  Let's
hide it in the bushes next to the sidewalk where no one can see it."

Hash tag, folksy wisdom.  #snakes

On the other hand, it might be worth checking if "pnetdev" can even be
NULL at this point, and then deleting both of the NULL checks.  That
would be a very good clean up.

regards,
dan carpenter
