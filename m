Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7A7840DA38
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 14:43:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239611AbhIPMor (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 08:44:47 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:22776 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230299AbhIPMop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 08:44:45 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18GBPGIc008843;
        Thu, 16 Sep 2021 12:43:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=dhn0Uw0w0HV6PJI36254IMXgmAEW+LOMq72zWblNCV0=;
 b=E11GR3OBstaIMc2vAvp93hZDcYM4GeKufI4wBki1KwiSlvKMdvWrvaXAEeTu7Stu02SN
 K41PcSAybvrF7OZIHKR7XKDxGcBa+Y8lqmhWBCSJXAVgWLvnvXn5GV7hEHmK7+g9gzU2
 OZ3XRP7bNpy/9K6IqVIHYNsCwynLmqAFQ+sqcMO6ejeyjRYZbo/Hutfsx4v+2+2lN1VR
 aj1PaZcFo4tJ1x9zXtQEcaJY2Bg3xj54XVT1Kg7VVydyiMsD3xRUN715Evd3ZAQm3dmU
 /yByb6k7t9BROf6ebkjsCb/KPxvNElphJx+pz0FnHL+/LjcOLzighXM+E+Mzy+nZA5OM nA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=dhn0Uw0w0HV6PJI36254IMXgmAEW+LOMq72zWblNCV0=;
 b=c/1mqV9RC1wkUuVQy8a8qRwf2LFb5EcaxGsbbtDxXi/r7eoCc1oPy+IxA/x+gVkrkg38
 w8QfNO/Ed9CJBR2WytfDivDbK6UTlqQJ+Ni+Dvr2rszWkOWJEiQQrF+UDgjqXaq5Tcvb
 miKB6BuPi+2sOsyZQYVZTpeXmOv7ftlXYICWfrWPgNwBpGe+mttLTVHIwkIJSPP1hevx
 8YogHHSRaxihLGnX9dkJS1YgHm/KVMzNkTi/19Bp+yL0s8Iqm1uzS6UrHzxt95h0YgZD
 epMplusY98lgmvVcg0SM5ihp6a6WJW2kqBS5j+lMM+G1ty3yCIHqKAzPLMCvgl4MrVus Dw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3b3vj11p8j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Sep 2021 12:43:11 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18GCfhrH012184;
        Thu, 16 Sep 2021 12:43:10 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
        by userp3020.oracle.com with ESMTP id 3b167v5b70-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Sep 2021 12:43:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SC45FD0TlKjb/J4rtAY4LySxeqAhd5m1ogzqn2kxjFSxrDtBnXV35nbKyZ2AaM+sN7SRYpU+a7u6ATQlk+Yqfh7GqqXfGgttx5DU4aUYgaCrFC4iSiXOD64RW+5egIDRTFjGcN4TN72h8ybeXi1BOWl7f/BXUrtGtzjqteXacl1LPpGM1Ti6TsP1use/Ugw87vo56HTVD8GJEXPDY/x7L79xRFoRWB03/q2V1olJ2Zgbs2/CalI5UJW7ueZgpmQ9fd/LZXNVR0MXb+hdkBjwlRkX3eYAhX5oGByyxknMseUbmj0JxKQTqECVLu+PqL2mmi9wd0ZmgFk7rZhBxNjgLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=dhn0Uw0w0HV6PJI36254IMXgmAEW+LOMq72zWblNCV0=;
 b=e/TgC0uLMS//i1NOtw3qjIhsNi1s4jVQDbBWjw1UVQ3hT2Gdzv/fW3l8PNdp74MAZ4jh6c59okP+6xq6WgkP3GcQyPPOwUUtgPGLg3zVkYCePHkzyNzvOYej7I77BoDWGdMdMMt2GBgjseoxK3EhGxt1NojAzeW/0lHFWKM28Vs2Zv6vQ3rBa2OruFDAGoWvFVEkS2aeH4znQx8rTRlv5yvaEEzp0iU1jTF/lvmaAczYnhW9NdoR/F1SdodZuoa6Fy65mafT7HxekeVWuwue/j6iKModU3b/3NsC7xSkWgWc5FI+Rh3pU/sVHONUjiRAR1v+2uOkPbguw+9fFEp/1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dhn0Uw0w0HV6PJI36254IMXgmAEW+LOMq72zWblNCV0=;
 b=aJp6O88W/CLf6106mbo7MjOZULMN2Su5UJ0qv953PA4ucYAu82JIKGm8z6HbMJG48VwM7pUFiz+Ox4tltxv7IznNCQJpmdrNr2FADkUNOSFk3yQcaUm8o2p5tL2zYqiI2zlXbE5BI7MCNnxU3TewKA+GJyLOWdGYIXcLkJVuZrk=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO1PR10MB4513.namprd10.prod.outlook.com
 (2603:10b6:303:93::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Thu, 16 Sep
 2021 12:43:07 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9%5]) with mapi id 15.20.4523.016; Thu, 16 Sep 2021
 12:43:07 +0000
Date:   Thu, 16 Sep 2021 15:42:48 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     CGEL <cgel.zte@gmail.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>,
        Martin Kaiser <martin@kaiser.cx>,
        Nathan Chancellor <nathan@kernel.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Changcheng Deng <deng.changcheng@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH linux-next] staging: r8188eu: use ARRAY_SIZE
Message-ID: <20210916124248.GI2088@kadam>
References: <20210916015936.180990-1-deng.changcheng@zte.com.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210916015936.180990-1-deng.changcheng@zte.com.cn>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0023.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::16)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (62.8.83.99) by JNAP275CA0023.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend Transport; Thu, 16 Sep 2021 12:43:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ecf43ff3-f39f-4a51-10f4-08d9790f886a
X-MS-TrafficTypeDiagnostic: CO1PR10MB4513:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO1PR10MB4513793CBD72F071D961FCD78EDC9@CO1PR10MB4513.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:324;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZGI3fKWgmi0XBiqeXdxwzBGgxYYBEPp/2bE3OdJ4EwhAp1UHNqet4n/gdOiJG6bkwMXs3iV1w+FovIxMLUKjrFJOVtKhHygVSshKxKc2Mh8vD3HpnG+Y4QEuv9/F5KAaGf2hWBaaig6lVfzBHhSgC6zX4k664utt5XNA8gnPVU882TJ04+ZBV21e77X1XX0DVz09FduFWfZk3sdtxgcBEMOwyixZ+6+u7jrHX7H49akmzlz4+3dcJoDQ+xDwQJSqCu8YtrZzX1L5xCKF5ZaVSJrQnGC+8INjxhiRU5QX0TX38zvJhTsXq3oeM9b/mbC421QzBCOkA78Vx3FiNjTGeRXZo1OEf0wsC65KhFwhPTKYQNXkyaozEkF2yCtJv7rQ4iFhCX6AGczg6Q/VTlIopr+ZyMmEMmt2iTQhck6AKC74TvSBjrwsN3Jy9ETxwZvZolVjbu2Vp9/yx/oh9gX31rt80kah8nJhQj97QofV+iXxY887mHYO7VPzskLXEJrJuEpbn6zStpbSREtDWBdnw7qVLT9K+OPjpFSorB5tYbXqbHf0T3ak4U0tndS96MrZ/cbbHk2X4kJfp+82WmzQRyzVrILNQYOChq2eeT/y+YQYH11FjaJ6+sBJnzw74CvqbM4t5wMi6/JULlR8bUnflrc+lstek6PKVip6PtrLUtdFu5OLYlHU3xn2b8/iqj1EENbwnfFA6FyCgKXOpAseXA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(136003)(346002)(366004)(396003)(39860400002)(186003)(8676002)(38100700002)(38350700002)(33656002)(44832011)(9686003)(1076003)(6666004)(6496006)(66476007)(2906002)(6916009)(52116002)(316002)(83380400001)(5660300002)(4326008)(86362001)(478600001)(8936002)(33716001)(55016002)(7416002)(54906003)(26005)(66946007)(956004)(9576002)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6V+5ahQlEPjjXyyz+nsY9Vi98bTz52Yg49on4DQ1klg3ZDto6Vk7iueBXK4C?=
 =?us-ascii?Q?YlKcXqmKyHwwZOgXLyt2PrNNIgn+ikbyyVCEEvJvGGzof+7xia3fOJ3wd07o?=
 =?us-ascii?Q?qZj3oOaWc7XxbnaVsSMG5HeoOXjdXa7nQbc43YbaxAWJwTcKp3yrE6U71wwd?=
 =?us-ascii?Q?suAb1XmKxrNPNOrZVjJLgfNZpkluG4VP2hTK9ccqwyYo/86D6YvaR8Oosfay?=
 =?us-ascii?Q?vt9FACYLALZDShqpp8m7kpIo7xELku2EDyVd57IGDJBYEgpnPqRedKy2wxNh?=
 =?us-ascii?Q?6fzH+f/BGv1yV+q6D8/ACuI/g7DtirT1Myar9VszSTWCRtPMmY8ogGf10Ov6?=
 =?us-ascii?Q?G3Oh1jII8B3k6lnH0k8StgNGtIBWwAq9g8Tehju5jEOKVrBsyEaGFA2Gg9V6?=
 =?us-ascii?Q?TETb4LMpG/8/MojZG5AkdZVNdCWQ/keLTns8zj4O3l/RmdYZZpujUmJNv2sV?=
 =?us-ascii?Q?jRc8aZom7UfXDPoEcNKW7oROHl5C2RYvqnLXXNRywkOOEVgYky+kDu+0RL59?=
 =?us-ascii?Q?aVUNsJg71ijSPKn5/oCR6a00MDek6LJS/MKOQ+mLiALOFckXelt3HIIjbdoa?=
 =?us-ascii?Q?ogVEDVr88insndJJuoFNWjFoEmvflZmYtNtncbt8ItaGnaziT5xKVj9pxJw6?=
 =?us-ascii?Q?WctKl8qC60ut9IwBcqExA8Ya06PgAubkrcpamiI+eQm5AB8iv6bdXHKz0afB?=
 =?us-ascii?Q?BU0IC/imhAbJ6RYZVM4mD7pDQpsiM2duyq66Ccabbq4WGfgN4toI1uV4uEjt?=
 =?us-ascii?Q?b7o1SrtzoYrSWMmkToxdHIerxS1128qwfLjgbyYT2bhWA7zWGSZ2hStGEgKS?=
 =?us-ascii?Q?vxmYb6ASMgzU86RDfvLBoV0L7C19i4En1l4xz0xL+nSFTXxm7jQ/gjVVBJZd?=
 =?us-ascii?Q?gtwhZpzXh/GgMU0LL2LO+c0oJ5lCSDXw/wLLR7tss/DQNVEp6FD3bUL8ZsNf?=
 =?us-ascii?Q?gE5N96ut3M053LtMN56bUt5lEBxflLq5jDK8AvyY6QV/XpPN88D+F1AXRWjS?=
 =?us-ascii?Q?6omrMaxpGKUdeY+fOiBsPGvYsyExKjbnflwfePvwEL03dNx4Ci8ugdEo9bCg?=
 =?us-ascii?Q?RKJlH1x5jfPTnvM/2BKsD41ZSTIW0E4ZX/OeFxEtC0B+9uFKBNoHie1UxOz8?=
 =?us-ascii?Q?+xzxQlKXFHkm9yymempQcI+VBhM/qacRavlLfgRsKWY2xc/h2qOwAn31AxKN?=
 =?us-ascii?Q?e2gl2FqkpIbIcZz9nZHhG7KUm+zVBKyxN6TeQfw1FhQNQg2MJzhuepayEGnz?=
 =?us-ascii?Q?s1v4LlMm6EfjdGTrlOPVjAB9v9ZzKsc1u9wGx+YyF5zBeNzQ3qwoYLbZoQ2K?=
 =?us-ascii?Q?q7BEhhytljeW74nLTX6lQzlG?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecf43ff3-f39f-4a51-10f4-08d9790f886a
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2021 12:43:07.5655
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8N7hOCwWh9828WihBUslaIBphv64vMldCeqYcSsLSvI4AgMH6g8ZYXTHr/KvrjY2o4m9IeqJAYgSmfRY6QhOnM6QcRj6YVe42mJ7LpM3sac=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4513
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10108 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 suspectscore=0
 phishscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109030001
 definitions=main-2109160081
X-Proofpoint-ORIG-GUID: DpoRIKsF55mggsxzC6oBN7Uo9KHbD5H2
X-Proofpoint-GUID: DpoRIKsF55mggsxzC6oBN7Uo9KHbD5H2
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 16, 2021 at 01:59:36AM +0000, CGEL wrote:
> From: Changcheng Deng <deng.changcheng@zte.com.cn>
> 
> Use ARRAY_SIZE instead of dividing sizeof array with sizeof an element
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Changcheng Deng <deng.changcheng@zte.com.cn>
> ---
>  drivers/staging/r8188eu/os_dep/usb_intf.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/os_dep/usb_intf.c b/drivers/staging/r8188eu/os_dep/usb_intf.c
> index 78c857d..c7de8ee 100644
> --- a/drivers/staging/r8188eu/os_dep/usb_intf.c
> +++ b/drivers/staging/r8188eu/os_dep/usb_intf.c
> @@ -261,8 +261,7 @@ static void process_spec_devid(const struct usb_device_id *pdid)
>  	u16 vid, pid;
>  	u32 flags;
>  	int i;
> -	int num = sizeof(specific_device_id_tbl) /
> -		  sizeof(struct specific_device_id);
> +	int num = ARRAY_SIZE(specific_device_id_tbl);
>  
>  	for (i = 0; i < num; i++) {

Get rid of the "num" variable and use ARRAY_SIZE() directly.

regards,
dan carpenter

