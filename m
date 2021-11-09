Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D75B544A79F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 08:32:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243654AbhKIHeq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 02:34:46 -0500
Received: from mail-eopbgr1300077.outbound.protection.outlook.com ([40.107.130.77]:26647
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232740AbhKIHep (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 02:34:45 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QxC56d0uDr5GEZp12j7sClAXEvl17mox3SmHd9C51jQqnWYlF6ZZwIuM2aFKi0K4LxLE2VijIKQPn4WQtstyeEKMwbpAKLCGjA+JBsyteljxFK2KFBnqGayv2KGKoP9qs9KbYteQzevE2jtNiqE+pk19FFeLCkElIFMpgG0M1eRTlTNobabCvyrUe0SjaLhbli/YSPu+TlvGKGcQJJNqQYLisw+bWR6dw6k+cLLuAJk8PHBmHZK1uY7oUS1g1Xaxaj/y+D1uXsF+bUKUMdD5iSkyZSL0dgcGM1vERQg8zKtaJPFj2mwcSsQmW1kPZD1F6v4siJnp70vepugCDMxZFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yTvOzss4+SXzbbuke9uD7ABW4YNfTMXY4d6UZrLlKXk=;
 b=Ky1Un8wo39SSE287mQsasQuwMjnpNz57Dj9jJJX88WbfQp9DH2ExF2wbmvdtxOZn826DfGhWV2LXAFaTtLgLE676BzC0onloDaIdNisRzP0N/uBySLrzumuL5jtnENRS5z7eYi9O+l5g4G+cz3w6hQ2SLFuzim9FgSqPLyD2chEHyAlTvsUWayBJ1SQ6RSQ6PJEZXwXEukrYsrvjTZxBZkkGqEfhcShlxa3tlhcDCt/j/XarOIedfNLKqSGg507Aq7PI5gbkkYAWmdD+ACkUtwZDJ8nYpFjyxwkKyzNE/8delFj8y8lJcJxVuJI3eLtH4t8JTlOZgEWk1OGkobBbWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yTvOzss4+SXzbbuke9uD7ABW4YNfTMXY4d6UZrLlKXk=;
 b=LjDHHoVU0Ee0rJVps0loxlas/x6Ep9CTtgCpDxhEhXUNUV35drZm0Hal1QyH1epPWg85x0/MnVU/NaLsbQV4vVIE7U8pfV68JlBphJHqyJ6zLtVNZhgPsAEbClhblnvBMjwI7f7rWtTiJFhiuWQT1b5nyRsOtJgdh/hq38wMpC0=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oppo.com;
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com (2603:1096:4:96::19) by
 SG2PR02MB2557.apcprd02.prod.outlook.com (2603:1096:3:26::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4669.10; Tue, 9 Nov 2021 07:31:57 +0000
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::7e:59ef:bec3:9988]) by SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::7e:59ef:bec3:9988%7]) with mapi id 15.20.4669.016; Tue, 9 Nov 2021
 07:31:57 +0000
Subject: Re: [PATCH 1/2] erofs: add sysfs interface
To:     Joe Perches <joe@perches.com>, linux-erofs@lists.ozlabs.org
Cc:     guoweichao@oppo.com, guanyuwei@oppo.com, yh@oppo.com,
        zhangshiming@oppo.com, linux-kernel@vger.kernel.org
References: <20211109025445.12427-1-huangjianan@oppo.com>
 <cc9807eb594b042ec2cd958f0c70c2f3dd12d58b.camel@perches.com>
From:   Huang Jianan <huangjianan@oppo.com>
Message-ID: <a96677ff-dad0-9baa-00ba-ccc89ac3fb49@oppo.com>
Date:   Tue, 9 Nov 2021 15:31:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <cc9807eb594b042ec2cd958f0c70c2f3dd12d58b.camel@perches.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: HKAPR04CA0012.apcprd04.prod.outlook.com
 (2603:1096:203:d0::22) To SG2PR02MB4108.apcprd02.prod.outlook.com
 (2603:1096:4:96::19)
MIME-Version: 1.0
Received: from [10.118.7.229] (58.255.79.105) by HKAPR04CA0012.apcprd04.prod.outlook.com (2603:1096:203:d0::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.13 via Frontend Transport; Tue, 9 Nov 2021 07:31:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9c2fca1d-4270-478d-7ae2-08d9a35302cd
X-MS-TrafficTypeDiagnostic: SG2PR02MB2557:
X-Microsoft-Antispam-PRVS: <SG2PR02MB25571F98F79F980BC01D0AA0C3929@SG2PR02MB2557.apcprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fNBDTpuu6zclHuIKL4JLJLUCX9aVHDd3sJhcAsI5AszVtTRaGki7aEecps4nNwnV5yKqriiz9UYLVocpMbZgM+d7Ww4jPPMvcRiJQmVjA1FBu+8/thEhkr7iokbDAs5cJ+OZGBPsFN+TrR44nS98+X8GwjKpeZ6pnPyScsgPL/VIoReOfKb1T98GVvBlDYIsLt+CQmLwaFVQ0xo7SiTQoZm31ofhg7lK+EsYdR4J7mhzVgKCCziw1KzPYgn3RDj/hrDTw58deCPik+qFE63UKOZSkvtA1R6Ej53v5lBRNvcMrBPn2hBJ90jvtFSbN6YjG4uBOUsM01nWKE6uWh4S7GDOWqk7hon2FejrM0k/rH56Jee8za2OZlO4WHe4ORx6SnrGpFZT2cT6nm4wTjOmGHhz1d5bDd7ukbuKbkPtpOhYqr0n54FveRt8wmK2qt8d7375A3l5hXAdeuWtVKXzbOCAd2e6UT260vjIMWDS4D3Bw0U2vTDiqyQJMqKj8oVV84/D9+dmchuX4hAnBaY10J0l+7etNCDSXiGf82lZdnXSEEAUgNqUicBeOMIHuU9O5ycPreHl2w2BrmdqNHvMjWOfHJ+jfN0fQNTtXG8VkB0zGUOi3OpPW9RiOgyNINY7dRwAY0xB4VXWXU9+ywRzrTcqcuB8kEMHTUFLKk/0d7e//P5w4++wl9NdrKJljl9zsbh7BA67TBm84L3dy/GKkE8AS+nElUS2hm37yznhxRITDg5ShiD2qfOonVGEfNPMJUPM/ydBZQylYhezcXa3Y7pRBKlPojrZKQ39aiPcX3Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR02MB4108.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(38350700002)(186003)(26005)(956004)(2906002)(31686004)(16576012)(38100700002)(31696002)(36756003)(4326008)(6486002)(508600001)(5660300002)(66556008)(66946007)(316002)(86362001)(66476007)(52116002)(2616005)(8676002)(8936002)(11606007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?gb2312?B?U1hXTUJZMU41OSs1OGM4bWI1dHk4TUFmRHM4ZTlaY2ZYZks5SHZsSjIwRThH?=
 =?gb2312?B?d3oraHJCQUpVZ2EvOXEwWGphcnRDdlRPSzdVSzJ2QVNvdHVMVjNRRThwV3JF?=
 =?gb2312?B?V0hFaTdJTzJ5MDV5YytQeE9QVGtYTE1TeUI3TW5qWTRGYlN0b1hyQXBobDJt?=
 =?gb2312?B?ZUh4SDEzVEJnYkRjM3hpVTBFTkRJLzZHNm12dWZsNDhRaCt5M2RISjEzQUJL?=
 =?gb2312?B?bm14cHY3VGF1UTdIM3k2ZUxpNW41SUcxVEEyUDdySnZIcnlqaFhSbEpYZmpE?=
 =?gb2312?B?MjlSRUp0MVZ2ZS8yR2xtUXFoNGd1aFRYdGJ6Z1U1TzJidUxCZ3VFNEw4bHUw?=
 =?gb2312?B?bkwvQ3pNaFo2M0wwMDBVTlRHN25idk0xQlFTSzB0WDNxTXBQR0dBbEVPTGpo?=
 =?gb2312?B?azVvRmd1bUtMVHRHMkRUOG1RaTk2YngyNTNrMzFMOEs1QU13eGpTU1dzeEVL?=
 =?gb2312?B?cHUxU1JNb21yS2J0Y29DbzZkWG1hdFhSa0pPVXNObnIyQzBkSHVkVXY1NFky?=
 =?gb2312?B?WUlnbTU1UzFjL1o5TTlibTJTUllxcllOaVZ3V2oycVlKdG9QTElTakU0UDUx?=
 =?gb2312?B?aWc2c1Z2Q0tLZG93eEJUc3A1emhOYndZM1NFNk82TVRodEdNa1gvWG9PZWRn?=
 =?gb2312?B?QmFHWmFsOStoSlgvbFZJSHFzTG9SLzMvSjh5QnFSenlldFZWTXp4NGkzV2ZD?=
 =?gb2312?B?YjZuMTluL2VscCsxMC84OWwxa20zYmw0TW8ydzE5OU9MZEpXNUNQYllZb29Z?=
 =?gb2312?B?WEx1RWtUc0RxbjVTWTVKMmtUM2h4S1JoRE42TkR6NVIzaHNWOFlZbllaS3R1?=
 =?gb2312?B?ZG5qZ3lVVzdabFh3NEgybHQyQ0IzTnZCSXI2UTRlcGpJVGtCR0kvME1SejM0?=
 =?gb2312?B?S0t2RFNNQm1uRjNzVHhOZkIrcVhuTnJlMXB3eVJBK3NuOXJVYnc3SHI2Y0xh?=
 =?gb2312?B?Y2hycHc3TXNkQ016YzhML3dqR1F3K1VRdGlpcVdHbElrMjJQTFlYM2dzZXE1?=
 =?gb2312?B?ajh5TjV2MU1VbUxGSzBPNExuVjdqMFVmZVdzOFB0eVhud0RibS9Dclp2cmRO?=
 =?gb2312?B?VXJhbFd5c01QUDF4TDRNM3Bqa3lYSHd0aE9yUFNZY0hEWUsrcFlZZzV3MURE?=
 =?gb2312?B?SmhyM1NEZ1A3Z21JaXNYelQ1Yk5HVWpjYXNRVE52RUpUNWtCSFIzcW9ORXV3?=
 =?gb2312?B?NGE2Z1NERGk5Q0R3RURDY2VBdWlKVDNtdUQvN29wZHhHK0dQWGswTjFNdmlP?=
 =?gb2312?B?RC9oN0FhS3czbEdtTGlDVE1kTFV5ZCtQNkM2TGpBcHlpUC92bnN0T2NVenB1?=
 =?gb2312?B?ZFlGY0NLVmxsUTNVU2cvallwOEZKWmZkM0U1NUhKanV5S2xjRUtOQW5SSUlQ?=
 =?gb2312?B?TEhPZUVNZC95aXlTMEt3MFRZVG5RMTZLTERHTVdncVdiRTBlazRZMy9BdUVa?=
 =?gb2312?B?S09NeU5teUxlTFlDdzNWQ1ZaTnB0d0l2OXZNc1FWSUFaMzVPMEdiYTQ4QnYx?=
 =?gb2312?B?Y1VlT0pmZFZ4c00wTFp4RTZDQk9rREdIYTJaRTFpTnNYdFlUOG54eEt0UXJr?=
 =?gb2312?B?QmNhNUcvcEF6azRnSEFRNHgxelcybEVkV1F4YWU1WGpZMkZxcURQdURIeWdY?=
 =?gb2312?B?Qzhod1FtZUFzaytidnpvRlVhK283SG1RWGx2Y1l1VmhXdXh5VDR4dnNMWEcw?=
 =?gb2312?B?ejJEZXliNEwzd3RwWnU1eTViOXRRNHRXTXR5Q2RMSk5LK2FJQmoyRXFZN2tE?=
 =?gb2312?B?emdtZDhMQ0NxZk5EMzgrUzl2UUNoLy9Sd2puNVErUFc1RXVrbHc4aE1YbVBn?=
 =?gb2312?B?dDBPWEU0T2lmaUJ5elpZeGRjTHA2UzljWUl4cHVPM0U0Umo0dXM1ZkJab2ZQ?=
 =?gb2312?B?eGJzc0xWc0dqM2VRWFVKOW5WRDZPdnozZHB0Q29KUEw3Wm52SWNvU0IzQ2RN?=
 =?gb2312?B?KzBZTUYwS2owbTJSZ01NemNPZHNLRlFQa2ZjSVlBM2lqQ2R1TEI1UFZBOWR3?=
 =?gb2312?B?dFRXbGZaZkV0SUpiVGlDMjg5SzZzWk0wUXN3WUFyMzh0L0pwa2lNU0YzMDV2?=
 =?gb2312?B?RzlqamgrdXNUV2ViZ0VOaDRCYzF1Q0l3WWs2RkFmb1g4b24yU2wyZjlCUzBr?=
 =?gb2312?B?M2RaVHNRYmJld09qQUJXRTRJYVF1M3YvSlAzT2U0QjFHSU5sUFFITHk3NDBT?=
 =?gb2312?Q?7FPo0rdqyFO+/pklykDGEb0=3D?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c2fca1d-4270-478d-7ae2-08d9a35302cd
X-MS-Exchange-CrossTenant-AuthSource: SG2PR02MB4108.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2021 07:31:57.4989
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pe/f3B8g+E9TpB3lxbWM/6PgU9zReydVy2+nZ8oakHKVP0wR7q9WiKei9UzJ9SZV43aLq9Pjl+ZJ2adOrjG59w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR02MB2557
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ÔÚ 2021/11/9 11:14, Joe Perches Ð´µÀ:
> On Tue, 2021-11-09 at 10:54 +0800, Huang Jianan wrote:
>> Add sysfs interface to configure erofs related parameters in the
>> future.
> []
>> diff --git a/fs/erofs/sysfs.c b/fs/erofs/sysfs.c
> []
>> +static ssize_t erofs_attr_show(struct kobject *kobj,
>> +				struct attribute *attr, char *buf)
>> +{
>> +	struct erofs_sb_info *sbi = container_of(kobj, struct erofs_sb_info,
>> +						s_kobj);
>> +	struct erofs_attr *a = container_of(attr, struct erofs_attr, attr);
>> +	unsigned char *ptr = __struct_ptr(sbi, a->struct_type, a->offset);
>> +
>> +	switch (a->attr_id) {
>> +	case attr_feature:
>> +		return snprintf(buf, PAGE_SIZE, "supported\n");
>> +	case attr_pointer_ui:
>> +		if (!ptr)
>> +			return 0;
>> +		return snprintf(buf, PAGE_SIZE, "%u\n",
>> +				*((unsigned int *) ptr));
> Prefer sysfs_emit over snprintf
>
> 	case attr_feature:
> 		return sysfs_emit(buf, "supported\n");
> 	case attr_pointer_ui:
> 		...
> 		return sysfs_emit(buf, "%u\n", *(unsigned int *)ptr);
>
> etc...
>
Thanks for reminding this, I will fix it in the next version.

Thanks,
Jianan

