Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 252B93FF319
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 20:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346913AbhIBSSd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 14:18:33 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:5688 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230210AbhIBSSb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 14:18:31 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 182I9rae028702;
        Thu, 2 Sep 2021 18:17:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=VyLIf6Mr4oQDWE9dNzCDWtNTO5HpQ53lcB/8Kta5lJI=;
 b=rzQ/44DN/LD17sUm7zZA7mX5FbnOodxgt8BkctEgDw+1KiHgk/EOV5UXbnTJwuyPKkpt
 mj6SaehJjUtE90gUhMVOznPag8/w9oL5aaJcv+HDy1UEDmHBxa/0KdKvgOne/aupyc0/
 7gOB0jhpm25Fjrhc7goVX0MtBvwxGVtuldi4Pked+G2RxC2RwwSjDEkSlZbcruxdtIlU
 jOjJne4HDtjHyr5nhmcI98LV/pUvrWkVDTDeDwyXHsEHwShyGosCOyD+LDa4qkPHDs0Q
 dJdzmjHjkkEWzbNKnTZ1hx05WexITddzJpmcF/Cv5A5P2oi4cgxoHvSHSedt8hRTwufV Xg== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=VyLIf6Mr4oQDWE9dNzCDWtNTO5HpQ53lcB/8Kta5lJI=;
 b=GxR4hTvNtpOKn2L+FKujh6S02Ix/fPGrwJ1WYnYmIqm/q+USV/ANWrztlHVLeiXW1+zp
 wKQRMncnjaaZy8lYAO22buDC5Oimwmo+Q/hG+a9dTJXL+KlhzqPEGjTIjgyGSNtIK1b4
 sdhoqLaCmA3XJhM2uWs443HWQbo57rjL2ZiEAx84Ynv1HkgMVGdXCflUvHw1YQrIs3vy
 QtC87Bz7IKOmQOmJIfaJj5D76fG+bfiMlh0HZ//Kx0mTaMeoy3Y5WF9s6UQGrlufLlR4
 X9lrxMHX7EsBSNKdA+cKThduFhoUzHYzHAM9fxd1oua895km9jASk7N1izx8KkTgRrhY +Q== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3atdw0km2m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Sep 2021 18:17:12 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 182IG2gI101639;
        Thu, 2 Sep 2021 18:17:11 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2106.outbound.protection.outlook.com [104.47.70.106])
        by aserp3020.oracle.com with ESMTP id 3atdyvxudn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Sep 2021 18:17:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ECwJP5FuMsArszcmW0xXpQs60jqQKg9t+Bp64lPBqCGZZcDc2tqF/+vRxunWOQEHI+3wD/QvmuEiLGPWxr8U2j2MeOC1RwdhKUY6dUCtqj/HmSVX7VmKXix8jJrtzEmD/nA49apK9SfUdVPvAfbyV6VYsEW2Bj8E5XJ4UMHOqu0vMQrFi9CKGrftmiZY6tAZyu5EpPB6Brj4biVzg7lHCtJmJ042rAoS/Bpl22GaOR5Ls2iHRYURDQGaSavzQdojlrbiuh/gyhWhUgZ4VDVaCnC+qzL0VfZxoHxf2/Q7TqI4aR/+efMxwsj/ag8QeIXCIomEv+JYtHi+zpUmNg4g8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=VyLIf6Mr4oQDWE9dNzCDWtNTO5HpQ53lcB/8Kta5lJI=;
 b=aCr0GUSEVxPMMkPJhlVHL+e/ZtiZW0tk++xlau5/YhxRNOHP9T5UOwgB88Oq/mVM3JRDwNsrzMWcvXrF4D+d4wIC10zDDVkHHLao+0++xCsfWWpAhQqRb75Tu4G7F8XaMx13rTZWhRcKZrB4NcPLLFLcx97DCepp8TI+usdzLzRtch0N5HEbRcBm7r4vB1tEe1Q/EGFsm+XxEpUF4vfiKe/7tU0QqQ9IYeMxCDyyj4ykkRgEbeTlHSJSuc6lD0GKtNxT3MDQYODJojwB/sOXXqcIjO2cSFTqwAJcnfwgObRnjMImGX/BC37L3dkZ9nACJK8Q2eOaYG3lJvmX5qanvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VyLIf6Mr4oQDWE9dNzCDWtNTO5HpQ53lcB/8Kta5lJI=;
 b=tpmtA/fAhQu6L+vDH8jEjCuMsa043QkAGYCnz5ivCVgZoI69CURz6/SM9M8Qg+RxdSNs9EEiW2qhGTtNaNWFBF8RJaIgjMBdCvCLu5sbF9dVh4re2EKkOvF6rUClPYBI6fLGjIR0bSmOvU8b6+nnvQJHOUMnSFmz2/knW4AZEVE=
Authentication-Results: sina.com; dkim=none (message not signed)
 header.d=none;sina.com; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BY5PR10MB3969.namprd10.prod.outlook.com (2603:10b6:a03:1f8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.17; Thu, 2 Sep
 2021 18:17:09 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d2a:558d:ab4a:9c2a]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d2a:558d:ab4a:9c2a%7]) with mapi id 15.20.4415.023; Thu, 2 Sep 2021
 18:17:09 +0000
Subject: Re: [PATCH RESEND 0/8] hugetlb: add demote/split page functionality
To:     Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>, Zi Yan <ziy@nvidia.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        David Rientjes <rientjes@google.com>,
        Hillf Danton <hdanton@sina.com>
References: <20210816224953.157796-1-mike.kravetz@oracle.com>
 <20210816162749.22b921a61156a091f3e1d14d@linux-foundation.org>
 <b4401912-b59a-2150-feef-468c2d25ba3e@oracle.com>
 <20210816184611.07b97f4c26b83090f5d48fab@linux-foundation.org>
 <10d86c18-f0cf-395f-4209-17ac71b9fc03@oracle.com>
 <efcf6049-6110-d516-b21f-41bb8775f042@suse.cz>
 <2d826470-d345-0196-1359-b79ed08dfc66@oracle.com>
 <b3b334ea-0e6f-ced9-e444-df4ec49455a0@suse.cz>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <02a1a50f-4e7c-4eb7-519c-35b26ec2c6af@oracle.com>
Date:   Thu, 2 Sep 2021 11:17:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <b3b334ea-0e6f-ced9-e444-df4ec49455a0@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0289.namprd03.prod.outlook.com
 (2603:10b6:303:b5::24) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.123] (50.38.35.18) by MW4PR03CA0289.namprd03.prod.outlook.com (2603:10b6:303:b5::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19 via Frontend Transport; Thu, 2 Sep 2021 18:17:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 405cdc5e-074a-4193-f4ff-08d96e3de0cd
X-MS-TrafficTypeDiagnostic: BY5PR10MB3969:
X-Microsoft-Antispam-PRVS: <BY5PR10MB3969A879C34063163EA76704E2CE9@BY5PR10MB3969.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QBx4xFzAk0jP0bRx5g7cUA2ewRldKUL0JBMhbMyZic6jyDl+lvv/UhbpFttANa8TPzFOtklxsJwPl5Uf9y+0HMGhcEJGdtWU2RlPi+8wkjlWz1wSdipP7P+e7hp2Jepe/QZXIvcB/T/Nn5oZtg/JJpAgONNlgnNAd1Yzkwiq280F8CWCbyg0isTIh8WirWCFhQM+xnExOr7ntgF4bIvMw3i1gi/jfnSf4oDmLv1PhEraHYiAAssnfLoX6sU+7J4f641xUwZVoVNOEKQYz8jxWx/mey5WZyS5njFYhlpys6ohoVZvzW5eHwT5NifKdrB3u2SsbzW+Uham7R/IwhUNMaAZdqCi9mTo/dKxEp36ZuWZGjEPDYnlxWWyaP+KAG+QAXMzYj6VEiNHnOfXxitzeMPGX0pEV86Hrl8MJC4E3JhoRxdzGQbY4NRbnpI+pmAVwXwrSBYchXeovtmB2T/Y4lImrvGRxlPrsd8kV8jbX6vBIDImKrDMeF4Fx399yqQtPA0EVw7rbin8JZ6HGtdh9YRaVykloDLYn+yEo7fyEH1U7vcTSjhjCYdQNA8e9rlOoJlSHqk02EPx4fUr2m1/74ct+saUXt4l7sHHyqrvKsFaci40FwN7QooabjSxuUPBj5ISAip20k3NOzzc5q9lsRFdrXQ9669BD32xA69BMelTaAk9CahfDPJ8R0p9Xh5LQVVJBDuAhPeoHlYtSnWu+Za5hzn4XVt5hI/kufBATG2V0xfk9QALe8mtxKK3Q9jasAFq0Km3La+XbOqBk/lCzA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(396003)(136003)(346002)(376002)(366004)(31686004)(53546011)(31696002)(26005)(2906002)(16576012)(7416002)(52116002)(110136005)(54906003)(316002)(186003)(4326008)(8936002)(38100700002)(2616005)(8676002)(38350700002)(956004)(86362001)(6486002)(44832011)(5660300002)(66556008)(478600001)(66946007)(36756003)(66476007)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NXE3UXdqN0pSZGRtcnBjczNWdmNVV29DM1FDSTE2YzI3TW1FVzdUVWJvQlov?=
 =?utf-8?B?K3JvTVprKzNsaENYOTlJQVBYcDRUNzRQdGdrRDExRmFkaHREbStiNjR0MHVl?=
 =?utf-8?B?ODY2MzZ0Tm05VXI1eDNmOUwrMi9iU0VXWXZJeVdDN1o2ZXRSY214ZzBjMzN0?=
 =?utf-8?B?ZFdmdFFlV2Z4VGM2anJTSjlsWjRGUllKT2wwUVIrZGJyVTdFRkNKclVScmg3?=
 =?utf-8?B?K2pDb3lUaElhWGZ1UTNFaEh5QkgwSGNTeXdPeEROZVFIS1dON09Yd1orL0pY?=
 =?utf-8?B?ZzNGWHBpeUxnU2VJU3lYVFRIbEJPVU9rL2w0QUhXdTRITjF6Tm9uRExiSDE5?=
 =?utf-8?B?TE1XY2ZuRnpubjhQL2pGelZ4dVFHMVltRXArMjkwWjhOWS9KNzBWdk53ekMz?=
 =?utf-8?B?cVZiRDZVSlJWNlhxNW1BWkNkeWpoZ3hPNjFwbGVHMnZhU1FkWGZEM2J6QUhY?=
 =?utf-8?B?N2Z2U21KaTNqMkRINzVDRlpQeVMyNnVCREZPM2pWaUdBSk5WSTVYbG10VGtl?=
 =?utf-8?B?bzFPREZBRlV1RGJJWVl4ZFhnUVo2WnowR29xbUh3SWVXMVUwZjk2elBvRm9B?=
 =?utf-8?B?UVliTGhSaXBsTnJHWGVsckx6Z3BOSjFpenFRdEdJZ3V2U2ZUaFdWVXRxYXNt?=
 =?utf-8?B?bSs3OWo2YjRmRmJlV0RTODJueFZmc2o4b0Y4V29laHFaeFErcWFITjhLSHE4?=
 =?utf-8?B?eURTNm9HVzZLeTh4RittajRPalVnb1d4ZTVPWnZYckdZcURHQXBXZWVTa3hQ?=
 =?utf-8?B?WVA1TjJycXNxRnpTTkNiUjFKYVNObm54YkVKbmtZSlVSVWtNbnNUUXo2MlFw?=
 =?utf-8?B?K3kxTnhaZUNhRUJWclR5NzVNcXJ2MHhBb0FpS0xyUFhMdFJma1FuM2hVckRM?=
 =?utf-8?B?K3BjMytkT2tQaHBFb0t5c1ZxQ1ZpRGY5VkxuTFJOM0p3Z3hQV21xN3JQNHM2?=
 =?utf-8?B?aGtvTk8rWm4wREdDZ1VPYUNhS0ZQUS8zL0xlRXFhaUNiTFRLYzk1LzdUVHVS?=
 =?utf-8?B?V1RLeHlFUlNxUGYzQUZxcmo0alROSzNXOXJzYlpBMjNyNk9iSUFCbjNmZzlH?=
 =?utf-8?B?MG13ZkdWS2ErWmN2T0tmQVZFUEl0MnZ2c2VmV3BndDZOR2JHWTBQNmhFYWZ3?=
 =?utf-8?B?ZS9jRUlhK3MyV2NIYVlkYW5zaFVSV1oyM1dQWHczdDFpT0FxYXdQTnFBdjRz?=
 =?utf-8?B?MGo1WUVaTC82WE1qY1hrWEp3WFcyUzBJUzNhWVhoa1NZd1Y0Y1Jqb2pMUHRM?=
 =?utf-8?B?NWhGTnlkbmtPY3Rnd1JULy9icmxISUxvRXRvRjgvbDRMcHE0Tm43NEwvRWpR?=
 =?utf-8?B?RXJtY3cwdW1NUURvdncwQkVjQVl1M0duZDZoUGJJMWR4WEhQZHFNMmNIS0ZK?=
 =?utf-8?B?UllSaUFabUQwNzFFUWo2bnJPRU84eVJVaWs0UW4yU0NnTDE0dHE5R2NHNGR6?=
 =?utf-8?B?RGRickgvVTRVbzN0MHhWN2x3YjlIZlh0OXh1THRUMUpNN2lZUUY3c2crNVZH?=
 =?utf-8?B?dC9Za2w1dno3L2ovUHlRNFF3RXYvc29EeEJVaXAzUWRPazYwaXFJYUlCWENT?=
 =?utf-8?B?dThaUkFuQ0FkYkNMeG93NkRieENaWXM1UVQ5dWtKc0E4QnJocnBPNGF4VUVI?=
 =?utf-8?B?dDdFeE1XSGtpV2laTU44K28ySVhIdTloVkNKZHBnRStpRittMTRxdjhlWFR0?=
 =?utf-8?B?dGw1Q1RTOWlEOFdRMUdwT0cyVHE5WXp0bHpWUTNoQUttYnAvaDI3ZzNwNytE?=
 =?utf-8?Q?NXjDGrtLN6/2eWwQzb3H4MCOTQkg8BTsUwkpkz9?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 405cdc5e-074a-4193-f4ff-08d96e3de0cd
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2021 18:17:09.6237
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TewdsISW7UWTF4aAc7kPj1IQCYq5tSr9rdq1qfSJ5XJYPt88ja1oTg5zZSua/iVaNsBBhotC1C2cNM3etlfY1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3969
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10095 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 phishscore=0 adultscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2108310000
 definitions=main-2109020103
X-Proofpoint-GUID: aSJRTpnA-Rb1uKiuiSYj8RKdlMHq-fMY
X-Proofpoint-ORIG-GUID: aSJRTpnA-Rb1uKiuiSYj8RKdlMHq-fMY
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/30/21 3:11 AM, Vlastimil Babka wrote:
> On 8/28/21 01:04, Mike Kravetz wrote:
>> On 8/27/21 10:22 AM, Vlastimil Babka wrote:
>> I 'may' have been over stressing the system with all CPUs doing file
>> reads to fill the page cache with clean pages.  I certainly need to
>> spend some more debug/analysis time on this.
> 
> Hm that *could* play a role, as these will allow reclaim to make progress, but
> also the reclaimed pages might be stolen immediately and compaction will return
> COMPACT_SKIPPED and in should_compact_retry() we might go through this code path:
> 
>         /*      
>          * compaction was skipped because there are not enough order-0 pages
>          * to work with, so we retry only if it looks like reclaim can help.
>          */
>         if (compaction_needs_reclaim(compact_result)) {
>                 ret = compaction_zonelist_suitable(ac, order, alloc_flags);
>                 goto out;
>         }       
> 
> where compaction_zonelist_suitable() will return true because it appears
> reclaim can free pages to allow progress. And there are no max retries
> applied for this case.
> With the reclaim and compaction tracepoints it should be possible to
> confirm this scenario.

Here is some very high level information from a long stall that was
interrupted.  This was an order 9 allocation from alloc_buddy_huge_page().

55269.530564] __alloc_pages_slowpath: jiffies 47329325 tries 609673 cpu_tries 1   node 0 FAIL
[55269.539893]     r_tries 25       c_tries 609647   reclaim 47325161 compact 607     

Yes, in __alloc_pages_slowpath for 47329325 jiffies before being interrupted.
should_reclaim_retry returned true 25 times and should_compact_retry returned
true 609647 times.
Almost all time (47325161 jiffies) spent in __alloc_pages_direct_reclaim, and
607 jiffies spent in __alloc_pages_direct_compact.

Looks like both
reclaim retries > MAX_RECLAIM_RETRIES
and
compaction retries > MAX_COMPACT_RETRIES
-- 
Mike Kravetz
