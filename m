Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A62DC3D6A76
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 01:57:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234113AbhGZXQd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 19:16:33 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:64584 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233580AbhGZXQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 19:16:32 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16QNkaSF016488;
        Mon, 26 Jul 2021 23:56:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=jfVj24pcPybkBHmJxtPuTjsiHRj5e6A/wRQdzDx84KQ=;
 b=GyjLyX1GjWXY/P2GBQeaI2Z+tExgYiUrN2r6m41ogPCR/nb16QZmr9k00qXn/dtm85dI
 QKXttFfLsOHUILSFgQguJpRB+P263qTM803GXocTH3b/7x3FIPIETfsMIiQTQHjeTwyJ
 FdwD5ngrRrMu4RnEXZj6zDthh4zicv4bgQGQ6L9HGSpihDrShCtI6oeDdkTgmvAEV3Bp
 lVaKgTBdMVkzLtddk61OO388gCW17wjhbjRHkHGKatkB9NLdN9d18YGZZEBcUmgkPLiU
 dSi01R+PXCd50VereKTJSVP0BrP8szMVvNsT/IWPFmva8le3A2yFvi6IBXjxr3FkFrIl eA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=jfVj24pcPybkBHmJxtPuTjsiHRj5e6A/wRQdzDx84KQ=;
 b=H/v5emwUyl39G3mEAaS2GpSGHbfq8n4e8KqE4M67mkaMwZ4gpma0KjObB4DtSelV44kb
 poSK4SuIYtBBU4lQl47GCHWxQTeBHEWUxjj9Wcp9dyFq90RwkRoYGmpnnFaNCI1TNN0R
 U6Zk1S1Pvpr0xWXCUcKuveZpBPkKtBoZDFae1oV1qsN6e/T/ig4mjD2YAsaJX0jI+O1T
 XN840xvoiuDo80Mtkp7N/Y7h8CK2w3gir0ExO9lab914iEc8FXwHak6OnZIaVKXhd3ro
 K5j1dqBNTsZlzqqJEMjLTwSDGciv4tg1V25qAaLjwLr/ikRmYDT9WIf6jr02ArCv+sCz gw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3a234n0dub-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Jul 2021 23:56:24 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 16QLagxl135493;
        Mon, 26 Jul 2021 23:56:23 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
        by userp3020.oracle.com with ESMTP id 3a234ubyqh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Jul 2021 23:56:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SKjJ+nH0TwJyw3DWak8WhL+9jUl+6YpRIr6yt+o78gN/uaxFl81oqd4m0AXuZA44wKGcY/YOzwqVFTnfYz+oTjFB92H3ZTMC0vtAJdQIYvTvaFKm+Ne5Lt1N66dK91k9nSF70gHnmuOfy1kOuddtyR93zxqaQIZZ3pvakaq1dY79rTLqw/0CUWjXUeNJ+ICn9Exg4Z6ejdcba5SWJxiOizwM3qD1NdbA2ljhtVY23v1ArDTBnKVAMn7JxpelE8dDfo4CdOx5Wk8xSycY92p2pHn+QoYC8Ve/xDjcMJK8RLA2YgW+I8GNnSsXiP1lR5Ep3JeobDQbv14BhZFETkesow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jfVj24pcPybkBHmJxtPuTjsiHRj5e6A/wRQdzDx84KQ=;
 b=OjsxWBTBuHxfeuY5IXJROmI8o4TvinZrDkvkGDt24gCMduFqA0UZGpI6wcm9Hce79CCq7yDUtUbmIhQwY20eezY3AjJ8h91VCuWo3NxcoDruUhL8zsFARuvoFjdtaLCZjmKMSDD1OXg0IniI2EV1hBANTeqDPLEkDjxZY8a9jF2bVoNGjoBtXbo+G3DecEpjfqiMMBxTvTXAV0CLgSdb9g0dtlOs4y+d0SUJzqYKG9PgFzl4FqHV2D3E2IzrlAnXqmNIByeYERyMjo4k80yk4Ihyf3HSOydjeXLc6ZYWlbtS1dbp+Evnny0LlM5uvbb51AbaRBScEEsn/XdFL4RtJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jfVj24pcPybkBHmJxtPuTjsiHRj5e6A/wRQdzDx84KQ=;
 b=xbQ0tLK5IDQ5OKs3Y+Cplwh+40Mxvv4ebJ2f25GJlg3bRRDe8Su2RVmdpgtakUYZo+uSeJE7NDcRdN9wSJ70+rpsHB49H6K5P3KBC1x4Ug4H/QMBsYUxMQO+k1aRSyPoGAGoB26ApjGnIjKtoDCxc/QOx3OscOeuS8JWwxdBJPg=
Authentication-Results: bytedance.com; dkim=none (message not signed)
 header.d=none;bytedance.com; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BYAPR10MB2744.namprd10.prod.outlook.com (2603:10b6:a02:ae::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.29; Mon, 26 Jul
 2021 23:56:19 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d2a:558d:ab4a:9c2a]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d2a:558d:ab4a:9c2a%6]) with mapi id 15.20.4352.031; Mon, 26 Jul 2021
 23:56:19 +0000
Subject: Re: [PATCH 3/5] mm: hugetlb: free the 2nd vmemmap page associated
 with each HugeTLB page
To:     Matthew Wilcox <willy@infradead.org>,
        Muchun Song <songmuchun@bytedance.com>
Cc:     akpm@linux-foundation.org, osalvador@suse.de, mhocko@suse.com,
        song.bao.hua@hisilicon.com, david@redhat.com,
        chenhuang5@huawei.com, bodeddub@amazon.com, corbet@lwn.net,
        duanxiongchun@bytedance.com, fam.zheng@bytedance.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, zhengqi.arch@bytedance.com
References: <20210714091800.42645-1-songmuchun@bytedance.com>
 <20210714091800.42645-4-songmuchun@bytedance.com>
 <YP8mKV4wTp5sPIZg@casper.infradead.org>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <63b0f4e1-5d3e-477a-ae8c-ed7e7f47ffd1@oracle.com>
Date:   Mon, 26 Jul 2021 16:56:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <YP8mKV4wTp5sPIZg@casper.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR07CA0002.namprd07.prod.outlook.com
 (2603:10b6:300:116::12) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.123] (50.38.35.18) by MWHPR07CA0002.namprd07.prod.outlook.com (2603:10b6:300:116::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.24 via Frontend Transport; Mon, 26 Jul 2021 23:56:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 59d46188-850f-474a-e5db-08d95090f671
X-MS-TrafficTypeDiagnostic: BYAPR10MB2744:
X-Microsoft-Antispam-PRVS: <BYAPR10MB27443B8B53079DE9C15FC535E2E89@BYAPR10MB2744.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mZJMA3Q+NnzZYEyU1iZDyOS1sUAAy8lNsS3jBVos8vmhE4V3EfEp6upBONGxBz8KgMRVLSTOKQ1dKH8anTLOJflDKdyEK3jHcqLde2eHWdNN0KAtNwu3XuAs9VbYLgoVlPZ0feRnESdXWliaVjNK6mextMDmCYFBfGj0Q9VPXW8MOtLGHQNmtjm8BUJMSx2FrmbcfzeJX/G2SVDcPQLigJLOd9xl4qab5hpdZKiVjAT4ielWLtwxHbRqtdOEXdqeNr37gvh2Bn1McQWdxkdcB0LpC69A5KbngvoplyEscFt4vLhkgrKHvt97utp7JgO7CBPu4FKs1MjRiiiahr1y4BcK7/vRoUMJEVbbOy/6V0uCavChG7uZhXJAGddb28i2raJRggf1J/DF6zzgfVYcm+917HYcFKRtxQRCHfrg0vA69tNfCx2NsG9UwTxw/l3964vdmqF9DQTqHsbW5nqn7PKL9iTW3wi7ojyjZ+oZwfBlMrjCx05F9BMAB0U2AfIreVdHWGREnmZ/YJBB4aoSFPVv8pPfre87tHC9KxhGA9IIiu6HuiPV/FXk2IYlQihB5iKHz+Mm0jfjbf/tvxYlTk0EuB5WnN5thPSfHJNpv1SdSsLbjXYaojFinkjxLg0PE4yQYhh+16aPJSHFWQcr886XQzVcPnK+BcqeO/V/NHxrwExpB6Jj+sTUvqgOeQ+imPJ7Ksb0RQDlzXEVcMim+vJPnWbrtNAVWsK/E78GpXosUhvvIgznnUBokEL1ZZjMqk4eVsleoT0r4/lumrnO+w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39860400002)(346002)(136003)(376002)(366004)(186003)(8676002)(86362001)(83380400001)(6486002)(478600001)(31696002)(8936002)(26005)(956004)(2616005)(52116002)(2906002)(44832011)(36756003)(7416002)(31686004)(5660300002)(4326008)(66946007)(38100700002)(66556008)(66476007)(110136005)(53546011)(316002)(16576012)(38350700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K0VBaHc5NEw5TEoxdVN0T282cFBveEtpaEhjOTEwMzZta2dsenhybkFjNEZW?=
 =?utf-8?B?V1pCUnM3VEs2Z2FaTU5BdE9vQUEyVHZDd2pWbW8xMVJMT2I5OSswRCtwcmov?=
 =?utf-8?B?TWJTajJXNU1hTEgvTktkR3p0RTcwZlo5cFZ4TEF4dVVtS2tOMWwvQS8vQXVU?=
 =?utf-8?B?RithR2dyOHpqdW1MRnRkMy93OUZEc0xSZDlKdk5OakY3Q1lqQnk4WWtJTDc1?=
 =?utf-8?B?UVJBM3Y2dW8xOG1vZWF4SFpIeUtYTW11MzBWVGtmTVlRVVV1Z3doM3VRSi8x?=
 =?utf-8?B?N2p0K0tkRzd6VEk4T2tzMFc5UFRoK1JMN2QyaldYM1NEVWs5aU1yM0s2eE5n?=
 =?utf-8?B?T0haTmE4UHVBUjQydkZ0VWFhMjB0WTRrZGYwZDRTZWhPdTluVHBha3piSVg3?=
 =?utf-8?B?STZoa0pNU2hzRjVMR3IzTDRHR1FiV2NPYXhKdWIwREwrOXNpdm01UklCY2xX?=
 =?utf-8?B?WUNVaTFzTG92aWlXemhleDVxaWN6Y2tyQ0llbXV3NXU5SlBQNEdnbUFrMk9q?=
 =?utf-8?B?Z1l3Z0dnRS9lRmVOZUR0SEtMVElVeGQ1VmVFZXNNZVJEd2xXTlNFeExZRnhw?=
 =?utf-8?B?eHdZUzBNd05JaHhoOTJkNGtmdjZKVHVLa3Y3SGxmb1dxaVRaTWFIRWhpMGVY?=
 =?utf-8?B?VmtPYlBLSW5iWlEvOTVHb1ZhRk9mK1VNQTlWQVY5a1k2eTNxUUliRlVXalNn?=
 =?utf-8?B?UlljekRkVDY2eXYzWlBlaTdjV085d1B1RXBJWHdtcHBPVFZyWGNPM3FMbHND?=
 =?utf-8?B?bW1tc2FHdkZVUm5UMWJoWlRqNnVWVDB4ZWFUZ3c1T1pneXJIczhVWllBeFpn?=
 =?utf-8?B?Sisrbm80ZGRhRlgwR3BrM0hxdDRkc3h5R0dNTEFoSkxDdGFGUVJYRVpNaXly?=
 =?utf-8?B?S2VXanN2SGV3Y3FtdGFuU1kzM2VCYkpiR2xkUTV1SkRxdXN2ZXdLc2c1cE1F?=
 =?utf-8?B?ZU5EVElhcEN3Wi9COVNyMkxhaVIyK0hHTEluYkYxYUpxc0lJcGwzRXhPVlBT?=
 =?utf-8?B?MHp1ck9oSW1HOWR2S3NHVlF6VVpVZ0xvOFBvSCtOZ1JQMURaYktiUkVqUVcz?=
 =?utf-8?B?TE1HWGZjSlg1cFV6TmMyUlRBTit1RngyQzVZc2RhU09Yc05lcE1xd2N5cTB6?=
 =?utf-8?B?OUZvN1RZNEdpZUxzU1V3dDlvSWxkNmY4Z2tMNDYxam1nc2xSL2FMdFNEejU4?=
 =?utf-8?B?eVRybFNkSkpxMnc0b0gvNWhGNGRXeFYvWk80eTN0cVB2aGlGSkI3ZkF4NFpo?=
 =?utf-8?B?ZFFON2RRalpscUphSGE0aDRCSEJscXZtTFh0QW9lWndRQWpZSHViS0J6WmFB?=
 =?utf-8?B?cFpLZE9SSGZXcUpLVkR6enNnbU1DTUhHeW1XR3Q4Skg4S1htSm9TV240bml2?=
 =?utf-8?B?OTZmWUJPRXZVeHhGZnQwVndlOTNuUThHZEdBdEw0bHNRYkVvc215NitRQjRC?=
 =?utf-8?B?SkwvUWZHOWpCUXZ1WUpCVmxJaUowQlZ3NndIaE54UXR3UVRqL0M1czFOVDRM?=
 =?utf-8?B?YXdsMmNsanZRVDlpcU85YVJFNEQ0VzlhTU0vSW83aW9IVEYxZkhLcjd0U1NU?=
 =?utf-8?B?S1crV3djbHh4OU1mWmpkbytDMEQ3c2xDRzcxdndEOFI3blJNSmtKQ2RxWUtw?=
 =?utf-8?B?VTcxalZpdGM3SE1lM0lVZDVGKzh3MWtQbENqU05MUFJZZGlLWkorQmpVZXMz?=
 =?utf-8?B?ZEdsa2RjV1V6NmJyMWR6cmRMcDJsdlYyV0RZRko1NndXSGFvY2xzWjJ5Ync0?=
 =?utf-8?Q?VYnbv1jYn+ki/gAX984Non27nAZ+6HE+dkRQy6E?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59d46188-850f-474a-e5db-08d95090f671
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2021 23:56:19.2964
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7vi/wcS/kTFgxoB/c488d+fCLUB0arMqq7LOqgYGqE+nNFPrJKFnJU0H8/bYQZ50XG4e+D0XYmRA8aZXrLTSaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2744
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10057 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 phishscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2107260127
X-Proofpoint-ORIG-GUID: s-3yS5EzflAOzFK35OtD4zx2PGjDzmcQ
X-Proofpoint-GUID: s-3yS5EzflAOzFK35OtD4zx2PGjDzmcQ
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/26/21 2:16 PM, Matthew Wilcox wrote:
> On Wed, Jul 14, 2021 at 05:17:58PM +0800, Muchun Song wrote:
>> +static __always_inline struct page *page_head_if_fake(const struct page *page)
>> +{
>> +	if (!hugetlb_free_vmemmap_enabled)
>> +		return NULL;
>> +
>> +	/*
>> +	 * Only addresses aligned with PAGE_SIZE of struct page may be fake head
>> +	 * struct page. The alignment check aims to avoid access the fields (
>> +	 * e.g. compound_head) of the @page[1]. It can avoid touch a (possibly)
>> +	 * cold cacheline in some cases.
>> +	 */
>> +	if (IS_ALIGNED((unsigned long)page, PAGE_SIZE) &&
>> +	    test_bit(PG_head, &page->flags)) {
>> +		unsigned long head = READ_ONCE(page[1].compound_head);
>> +
>> +		if (likely(head & 1))
>> +			return (struct page *)(head - 1);
>> +	}
>> +
>> +	return NULL;
>> +}
> 
> Why return 'NULL' instead of 'page'?
> 
> This is going to significantly increase the cost of calling
> compound_page() (by whichever spelling it has).  That will make
> the folio patchset more compelling ;-)

Matthew, any suggestions for benchmarks/workloads to measure the
increased overhead?  Suspect you have some ideas based on folio work.

My concern is that we are introducing overhead for code paths not
associated with this feature.  The next patch even tries to minimize
this overhead a bit if hugetlb_free_vmemmap_enabled is not set.
-- 
Mike Kravetz
