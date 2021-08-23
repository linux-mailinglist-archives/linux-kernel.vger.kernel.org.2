Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70ABB3F5278
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 22:54:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232644AbhHWUzL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 16:55:11 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:18344 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232237AbhHWUzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 16:55:10 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 17NHjgt9010655;
        Mon, 23 Aug 2021 20:53:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=oVKpWPiQz2bniAgVrj4h8zbJgFS00aZujx90pIJtBTQ=;
 b=xNdqqeXcSjxPOFYAhgFLHW/STn+bCumOmeWCXNx0KNF3R8k1xF82gmlhyKzd/+gHdl/v
 4N49RQisPtzAaoup4/UgGfz3yIkShCa1w+rVZso4SgDv2fosn3roHPs2p8CAzV8NNdRW
 h36TIqjcaKux7RX7ae2V7bIMb0boXq5NDdP3oXRCfehETo6prSNq636WaX8620qbCwf/
 zo3hAD9wAa5Af5OrWWAR6PIXnCaoRxSJueNjRmHuN7rBF2B27YGEFogARsIMNnI3tp92
 Ea0p3zOe4VfzL9Rwy3UyMFJEp89swUuWYnJEVZWB1k/FzvhI6PmV/+wTrM3OUq6ZRDAu pw== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=oVKpWPiQz2bniAgVrj4h8zbJgFS00aZujx90pIJtBTQ=;
 b=m5ay3i3hePk8n/yvomUvZmdGb2N1fWGcVPFkQrlQNCq8rxNooy+BcD23MlGnks3PSE4j
 nSEz36/QUAu71AVMcETKHdtGLnnr0X8d9m91sNJscJ36GZ8iCKs71mqyVKor+VYIlmza
 opl+c1SO7p5mD/P+3MtD2vh8fquAvTbZBWXOzwDPuBhqGKyFo2B7rFkDae+nT5mkqO3N
 +Gu9b698msaiD/zl/YPmNleWN3jc7pRcJGJyjW8LF6iYPv/F9fNHa7JuJp9bAp+TYlDe
 IoDEHTnjphUboMQc5Kv/PMTMmqfj9QXKjFk16/oQZTm49NKF+knDVJ8uqCcF7FxQTbz8 DA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3akxreahgk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Aug 2021 20:53:30 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17NKpXSP023915;
        Mon, 23 Aug 2021 20:53:29 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
        by userp3030.oracle.com with ESMTP id 3ajpkvx06g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Aug 2021 20:53:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LdaFygNq+pLJOZPzcumoAqu6XVwF1JpufhwCLA8K80AB7Q4tTiGyVCBw3JdOSLWRJCIegaX4WUb8xkCe23ejuc4qGq3oo7Tgrb2vESIa++6ovjeRjf6iPQerBZFQwSCRUo0CkvrpEvyK7N6Ka1LwzYY/KbLfbNPxh+g7ZB1yud4quzlG+HvAaTGYJ7BttfJcxofKUBekrAvZMZCN0ujjhzdG9PYyZ7mlb0iU6cf9HaiXLudNkv8z/ILC51yLfKjc2yhBQvk//zJ5ClqcywmaIlY+1GHNiQRp2fvbUnQ85ElixhddH6FyO1zgWi/7DhXh7pIWPB3bbJ8hcM871NO+pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oVKpWPiQz2bniAgVrj4h8zbJgFS00aZujx90pIJtBTQ=;
 b=cqiX2zH6dyu3idFOOzue1uXsOjO8yxAwLdZoCvA1iUTPg254KHJyFAHZJP57O5r7K0HTk9u6un51PZwjv5YKYfi/CfHZ1R8JQtYxA7XmJeuVd9ggkcI30hYTSquGywqfw1Z87IBq/yNmBvClxOL/uLLTizgcEYAEB2VVJiAUChA6vCzOJF72iyq0fzXE4Eu8F8jgMYFUgL2O1R6+bWBfGyR8KTnBIHzXXo+a2qz5sLWjkpMUGYRPexhA8AjZhj7Lr6bt6OgM9ajcC+YviwLm5uhNIjn2SvOQK+kZyIFN7VqX+KwnaIA1OQoJqeElC1NSfH+FROpfCl5BI/M5a+s6xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oVKpWPiQz2bniAgVrj4h8zbJgFS00aZujx90pIJtBTQ=;
 b=A2rq5TV1xsqS/W1eZnkRrgzTFnFFLL5ycSrGbVy0MkHcccdsdQRjA8zsUO9MeunxHUK/+HlIB0p9TPPST+0O56OW+/AwG+ViqGJZcIViPah+Wvt9QxhYs++yEbciZyMyEIcbbqUoqCToRXSn1g31bbGbKiZTygYems7CPu1dito=
Authentication-Results: linux.alibaba.com; dkim=none (message not signed)
 header.d=none;linux.alibaba.com; dmarc=none action=none
 header.from=oracle.com;
Received: from BYAPR10MB2966.namprd10.prod.outlook.com (2603:10b6:a03:8c::27)
 by BYAPR10MB3557.namprd10.prod.outlook.com (2603:10b6:a03:125::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.22; Mon, 23 Aug
 2021 20:53:26 +0000
Received: from BYAPR10MB2966.namprd10.prod.outlook.com
 ([fe80::203c:7f44:c562:b991]) by BYAPR10MB2966.namprd10.prod.outlook.com
 ([fe80::203c:7f44:c562:b991%3]) with mapi id 15.20.4436.022; Mon, 23 Aug 2021
 20:53:26 +0000
Date:   Mon, 23 Aug 2021 16:53:21 -0400
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     Huaixin Chang <changhuaixin@linux.alibaba.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        anderson@cs.unc.edu, baruah@wustl.edu, bsegall@google.com,
        dietmar.eggemann@arm.com, dtcccc@linux.alibaba.com,
        juri.lelli@redhat.com, khlebnikov@yandex-team.ru,
        luca.abeni@santannapisa.it, mgorman@suse.de, mingo@redhat.com,
        odin@uged.al, odin@ugedal.com, pauld@redhead.com, pjt@google.com,
        rostedt@goodmis.org, shanpeic@linux.alibaba.com, tj@kernel.org,
        tommaso.cucinotta@santannapisa.it, vincent.guittot@linaro.org,
        xiyou.wangcong@gmail.com
Subject: Re: [PATCH 2/2] sched/fair: Add document for burstable CFS bandwidth
Message-ID: <20210823205321.vpr67zysxzf2uhoh@oracle.com>
References: <20210816070849.3153-1-changhuaixin@linux.alibaba.com>
 <20210816070849.3153-3-changhuaixin@linux.alibaba.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210816070849.3153-3-changhuaixin@linux.alibaba.com>
X-ClientProxiedBy: MN2PR04CA0026.namprd04.prod.outlook.com
 (2603:10b6:208:d4::39) To BYAPR10MB2966.namprd10.prod.outlook.com
 (2603:10b6:a03:8c::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from oracle.com (98.229.125.203) by MN2PR04CA0026.namprd04.prod.outlook.com (2603:10b6:208:d4::39) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Mon, 23 Aug 2021 20:53:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9fe6ffd8-76f4-46e4-f308-08d966780dc1
X-MS-TrafficTypeDiagnostic: BYAPR10MB3557:
X-Microsoft-Antispam-PRVS: <BYAPR10MB35574C8BB31B5F6F924CE5EDD9C49@BYAPR10MB3557.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Bv7mGN4ZqeFCUPZz6R5JZpiDno3L0/To0ZxzaqQCDsPTRJ7XMA884r64xCMyHuyYsSm+tqxyCMrBF4uDdCdy+ZVZDsoo7xkT5JI2K20yKBuksQ4jYhIOi+SrcmCnQNbBkY5TZ4+2aLEE1NUiE2nqXy/naC0gr+6V6Zm3keCaAP0bE36+QtzAO5suHIuIAdRht1KhnW7VFzD3Itomo5zJwo9Xv2b8WruT14BTj5fJwSwus6stdUfOwCR+0Iaj+XFUuj8af3OmiyWoxEwTQI4EskcNBVvP5oufEZJpP2xrkSpQgy4w2t81CUD5pujEE1kNOHjiPwzgVnpSum/kZfk0Tqacs2r+3TfoHReyrIe6dP+akHCVcIO6N4mrNVBbCDsgVbChalodyIW3bq/uGiTX3c/uGVIKTCyHOKvtOdbLnhl1p6zrsRlPBoIwya91WNptvFmnUeMKKkn53YcCq9Ddpm5qK9e0V7D+LcZBHUZdJ9q+GwnVUKdeXhc12R4kkZRTmEWcRctVIJIHu3YKcK6ymFlcWiXVK21/VugGJQv8sLi/bzURzmP0zx9khuzZSYmsmxB5sXQNSPslKLPI31cBx6lfnEDHrGCk7249Hu0TsfETZeBpvNNGDyP02nh4cm9tQ9tJSyGIZPA81+a1rI3r9+GSdRwPBTGx4vSsf4K3pERSTVKFiFdPxy/xmCiKd68U19UWCsgrPnFa+Nn7w9+0Ag==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2966.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(366004)(39860400002)(136003)(346002)(396003)(4326008)(5660300002)(36756003)(38100700002)(55016002)(956004)(66476007)(66946007)(2616005)(66556008)(316002)(38350700002)(1076003)(6666004)(2906002)(7416002)(6916009)(8886007)(186003)(8676002)(4744005)(26005)(86362001)(7696005)(478600001)(52116002)(83380400001)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8EcBjr7dSXhq8KvYSOl+R6PvtBHLVlet0e3v/tT2LoBfeCURL79kUAkkvIAk?=
 =?us-ascii?Q?UQhMjKPAY9IoQVLZtcOaEX1YOm9uKpXLYQCFKeoxY6RlC6yqkgjkdJlXFu39?=
 =?us-ascii?Q?L1n/PyLdBEfD7NtuBkCCaYv5IYOfCotaY3fC2nIVVQk6cXhUP3PVFJ7rkk0D?=
 =?us-ascii?Q?jPi38NMHjntg+sQwlKG2IYVXnS5r+FAwt0+sFtlsGi8QxKZboKp/cylZkFER?=
 =?us-ascii?Q?A2LthzzbjQb07W2XOfdMDPnQxoVR8rjHL+hg66jBj9nub2hpnCkwqIYXgehQ?=
 =?us-ascii?Q?1FIzKiSXmeY0VYVKK5IKpL4ar5WbIP2gPX2m0TMiHqzQgCI8rbnsTNbW0lfJ?=
 =?us-ascii?Q?UYFOyV2rEvYiv0+VWrfSYwXorgnkUWAcRZRHqAiGfxSBN7Kh+n/vY4mb6QCj?=
 =?us-ascii?Q?dmJxdFSVF5j9sPLAGQGFCkAAgwk3e3tVW6KZ4KQ8+ngqB+t2T474ELIjCjMg?=
 =?us-ascii?Q?thztMma928bGA36JwEih+/gIsL9q0zi340o5Dqd3rt97zP/P753uXpF2Ux1H?=
 =?us-ascii?Q?zZ4LPabYRPChbt1mtx0hA5EQBXZLkoLBcxTtDD9Ow+eH2TKBctZfMPPCA7WZ?=
 =?us-ascii?Q?gbQT2FwGVpg53AvbgVxHKCHOCgpTG7XvA9LjI65Ua1jGJv57xIAUBvSiwKoh?=
 =?us-ascii?Q?denmFzBSl6ir8Cc6mag+zCW1vkzbmtMfdktNyb3/5krgNiHhZieQPDG7blnd?=
 =?us-ascii?Q?1wE5OG5iQGaIqs+HKLl4XAax7YzOa46P6fNjp/sHps7gBbIGlxcrrTtV1Qha?=
 =?us-ascii?Q?m0jo9eFbk79joxGvgs/7h5ge0r7mJMmY8hzXgW5KYsDQKnUzw2sWQcL7xm42?=
 =?us-ascii?Q?M8YXaKGbmARkfcT/kD7ksQ/2DF7r2MJc5qnTI4Isd7WLnZrZ982B6qZZH2va?=
 =?us-ascii?Q?osshcfiILEjFUFjZVYT6OVQcL2VDWUuuntJTaNug3b+zjAAS+YTdatyODfFI?=
 =?us-ascii?Q?jYSfcPrrNqAeExvaoLW2GqU0extyj4KcFIal4c62JpwcQY/3Fovxe2JzY97T?=
 =?us-ascii?Q?CAqx2W9pRtDVYt+wQNyzjYW6qQZqgenrYnVoR1Mwu09FgusYIfzv+cQ+6z5l?=
 =?us-ascii?Q?rxCeztLiYcgGCPOnmdVZAk/I/Ma12pFrOx2L1CpqINJ/q97pVUt6KwkorA06?=
 =?us-ascii?Q?pjCl2+pEdF+kwUb/5cz7lFFxtAEAXuUjU5BUtTRI2M+3b4fMyZjk14bFZo8g?=
 =?us-ascii?Q?5K7dCTNn5F6Ktlt2onM8ucDNgjF8wjaM85oE7hdSHeOIWkQ3U1Hr29Hbqdx5?=
 =?us-ascii?Q?3m3vh8AkEmakPAgBF9dfYOp+Fcq9bT2zGOpeFHckZoqQQs9FUg+LXCh3Wiln?=
 =?us-ascii?Q?V5gX3I3xxcE4jovxPjxi+Nqm?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fe6ffd8-76f4-46e4-f308-08d966780dc1
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2966.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2021 20:53:26.8145
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g8C/do6foy9CelCug2hPJqVRcqHR8dY8oCy8cwzhX7k/7KP0d7K2MKBBhiT7vs7K/NVnbtYBHw0PZhl7aNXwIa0PnPWNQWyFvzum88EK3XQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3557
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10085 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 malwarescore=0
 mlxscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108230142
X-Proofpoint-ORIG-GUID: AvGoIqbCiliDqqtvtpi_er-rO3a3-7h1
X-Proofpoint-GUID: AvGoIqbCiliDqqtvtpi_er-rO3a3-7h1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 16, 2021 at 03:08:49PM +0800, Huaixin Chang wrote:
> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
> index 5c7377b5bd3e..c79477089c53 100644
> --- a/Documentation/admin-guide/cgroup-v2.rst
> +++ b/Documentation/admin-guide/cgroup-v2.rst
> @@ -1047,6 +1049,12 @@ All time durations are in microseconds.
>  	$PERIOD duration.  "max" for $MAX indicates no limit.  If only
>  	one number is written, $MAX is updated.
>  
> +  cpu.max.burst
> +	A read-write single value file which exists on non-root
> +	cgroups.  The default is "0".
> +
> +	The burst in the range [0, $QUOTA].

FWIW, max/$MAX are used in this file instead of quota, so it seems
clearer to stick to that.
