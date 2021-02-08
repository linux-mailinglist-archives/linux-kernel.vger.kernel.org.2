Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FB95313D93
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 19:34:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235623AbhBHSci (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 13:32:38 -0500
Received: from mail-eopbgr40095.outbound.protection.outlook.com ([40.107.4.95]:15271
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233746AbhBHQMQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 11:12:16 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YWttHF465vfZEXrX2buHnv9ulW2OgjxhBHD46UI57yuXqui+3PKdeCde4OQ39fwrRrgcLnQzQOAa7eSe3cESnULghMUukW+VhAYWPH16/PRR+XxcySXoaHUyftYKBUEXo45qPCxy1Rw0g9t8pJA8QRtto6zOW7YqLqJOayaJNk85XZHqKdWa8L6+PCrtp71dLwZ7j2j7l/y8Gmqx2yjjOUXZ0KkHcxyO52ybmOJXe3NS/9RFjDu0PoPeqssfgKxthwZwPLY3flHfTZpPb8l586As93OwIhalqSdstkGRk5zACNGqYKeSf/BfpkuEQJm0WWdpmuSYce86VOxXSllghA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DwDLgfyGT5Zu8IuBj3qutorWnFIzmNLMmRYIZtT1plw=;
 b=IpoS23PsoQ3460/aqknkhjCyPwsIHEHDgZK3SqhEhl5wwDgv1kTt9J7zxvy+IO/Sp25qB2itxqAZN2wsOtOXfEdxkocDn1tZGfJbXo3dX06g+05Cl4i3HMSbQNmfZB8c18UMrTALZsN8K4LE9cWfn7ClWq8WjHsU6WCEUGt80yoYsNLzW7G6/cMZAdOQRqur+3bt5xVw4C+5tE/Sn311oE4deYTHedUKOlfeanKCgjdSGj+ZhNWfSCobz9UcnrTmprk6yxulDPX3lZG9ZYx4bm8/QztTX3Tg0H+imTBg8qzGxOr87nwUou/+K+ZhlfMW0wuzPBuy4vV7wlcViKGkPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DwDLgfyGT5Zu8IuBj3qutorWnFIzmNLMmRYIZtT1plw=;
 b=eDrmxnWvY7TamN/C2nyzRRstaX4gVE+Qv0GER+9nLI5ajZPebS7KvhcJ7WkE4uGlK2JstWCE7gw3UDhJMzyQ6J2z2aKH2UqmNfgeVIJsjaWdmQ5RG3zcMR0vs9hFatxHxzgxkJWKS0TJTgqU35fetQaB+ci8jJlBqjt3ubLS4fE=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=virtuozzo.com;
Received: from DB6PR0802MB2374.eurprd08.prod.outlook.com (2603:10a6:4:8a::21)
 by DBBPR08MB6268.eurprd08.prod.outlook.com (2603:10a6:10:202::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.30; Mon, 8 Feb
 2021 16:11:28 +0000
Received: from DB6PR0802MB2374.eurprd08.prod.outlook.com
 ([fe80::6843:a48b:7d7a:ebd2]) by DB6PR0802MB2374.eurprd08.prod.outlook.com
 ([fe80::6843:a48b:7d7a:ebd2%12]) with mapi id 15.20.3825.030; Mon, 8 Feb 2021
 16:11:28 +0000
Subject: Re: [PATCH] mm/list_lru.c: remove kvfree_rcu_local()
To:     Shakeel Butt <shakeelb@google.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20210207152148.1285842-1-shakeelb@google.com>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <c3081f36-d0cc-d407-9188-b9b2b8c02e9b@virtuozzo.com>
Date:   Mon, 8 Feb 2021 19:11:22 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <20210207152148.1285842-1-shakeelb@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [176.14.221.146]
X-ClientProxiedBy: AM0PR10CA0036.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:150::16) To DB6PR0802MB2374.eurprd08.prod.outlook.com
 (2603:10a6:4:8a::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.69] (176.14.221.146) by AM0PR10CA0036.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:150::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.20 via Frontend Transport; Mon, 8 Feb 2021 16:11:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eec22ac0-c95f-4047-b15c-08d8cc4c3097
X-MS-TrafficTypeDiagnostic: DBBPR08MB6268:
X-Microsoft-Antispam-PRVS: <DBBPR08MB6268FB1F1AA017E6221C7E11CD8F9@DBBPR08MB6268.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:407;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 60LiamTv0dhBZDvcuMgmSq3DrhxMzLqP5KkkPPTFHi0TaEqabXqBnFRTaVOsISTe8sJe9Qc4FEOtV0daPyZuEctzNjSBRV9Nk3oBKdTiT4BjO9dNCeHKO6nwtF+vFZi6cu4yUbn45D4M+rbrB0NDZBEvMBfPs5dMovPVRX3b9U1REbLm78d/dAaXkjFlL5WPNBf90e1+8hzgtWWUVespl70OPhmVxF3hFiLm7LYkRjoF7mQLiEQw250wlLFUSXBLS7SZc4a6oDmUqNfKZcWOq29fxI40d5zqHf1aAmqUgGGj6Xb9q4REWoNjxM5IrzbE+B8zlRwKfGkrDrIigbOqKLzJbHHugVhun0bpEwTPbiRcPIqeLSwBu6dDS2VZRyweWFJ/27RqxeV7YyrLVvTP1VsMk+K1HhTz2wfOnH3zOfAl5aVYcGmeZzAhJLABBCCbOFYRsJ5k8C5oobSLqXOV3vuNsON1BXka2wGkMHUUYekQp34CUqYb8+ZlETSMaq5QJs19ZRG0HrFFM/EXGyxoCbPMfw4SjcZyAfIoknIR5qqWlyO8nBg/6JPCG0aI4Sx0Gb7OLTaB6wdmusLNvUqueHKD8VcDkMXMNz2zZGx+pRs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0802MB2374.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(39840400004)(346002)(376002)(396003)(66556008)(5660300002)(83380400001)(6486002)(6666004)(16576012)(66476007)(110136005)(956004)(8936002)(2616005)(186003)(31696002)(16526019)(316002)(8676002)(26005)(53546011)(66946007)(31686004)(4326008)(2906002)(52116002)(36756003)(478600001)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?L2huNTV1QzhsWnNMZ0grSFV4NFNyVjFmQnJ4TU9HUWZxM1E3T0VwR2RiNHBt?=
 =?utf-8?B?UHRMdy9hVWM3WmxqV0hkQ2JFR2o0MStVYU1mQjc2RE8vZW1CVDhGc2lDNi9S?=
 =?utf-8?B?b2c2ZDVNQk5vbVpyNVVKbFNOUk5Sdi9zMk9QWS9MMnZGSWR5S004VnUra1gv?=
 =?utf-8?B?MDdMKzhwcnFJdzlCeXFmRDVGQWlDSEQvQ3JKLzRUbFJsMTFTOE16MzUwS1Ji?=
 =?utf-8?B?ZjFRSjlMc1VkY1RCeTZnejZYTy92d0w1S0dteXJnR1BhL2NYMnExemZ2S05k?=
 =?utf-8?B?VDlDNVYzUjIxM2RoWmNYUjhFTkNrSzlyOFlhSDFLSjM3WmI4cGY1YkZMTStZ?=
 =?utf-8?B?ZnRDSFVCbU45Q1MzSG9qTzR4MFl2bENHc1NMb2R5QUdrWTkwVEpwNEFqcEc1?=
 =?utf-8?B?SkRaZnc4TEg1ZXhsLzNhbmVCYW13T0p4QkY3MmdvSnVFK0l3cHRYUlU0Q3RU?=
 =?utf-8?B?N3F2bmVmQVl0WWVrZndKa1diY3FJcTJBVktqZlEyQmlTM2Y5eXRqREpYVjBZ?=
 =?utf-8?B?NFRjaHRkRm9TWEUzeGZsSnRzY2YvcGhUeHRhWGI1MFBWWXhqY3ZGMVZCZ0ZN?=
 =?utf-8?B?a3NHS3pTK0cyWElKci84MSt6UkhiZThVbEI3eG1zMDZZTnBlTUdyT1o5QmxB?=
 =?utf-8?B?b2JDZFJ0ZC9vSzZFS01oa3AybjVuZjI3VXF0SExyRTFkSnU1cVVjWk5SdWV4?=
 =?utf-8?B?NEp6SDNQa0NjQ0hQbU1abk9TU3hPSmt4Wm1UZ0FobHV0aUFEUXI2b0dmem93?=
 =?utf-8?B?RHdsN1lUdUozUjFWc1VTTXhtMi9GdUF5dU8rOTM5SU1vaVhSRW50ZktrdDVI?=
 =?utf-8?B?S2tvdHpLY0V6NW9KaHhnVGs0VkZ0R2NsL09uTXp1QTd1R3RCMmZ6ci8yOGVK?=
 =?utf-8?B?Y2Niczlua25WZXQwRjl4YmZkUTMzeW50QXhOaEM4ZlJUak51aDRIaFNtY202?=
 =?utf-8?B?RFViV2ljUzdmS0RqanN5R081YWRHVEo4NGhGMG9uMXZNckh5aGFHbDdKbTBC?=
 =?utf-8?B?a1ZOTlk0Qno0WDBWMTNLN1J2SmF1ZnByMVYwcjU4clB1cEpCSmdJMk5TazIw?=
 =?utf-8?B?Q1FRS0RYS1A2UDVlMndMMjBCMXFxeFkvT241bjN4V0NhZVBtUllIczBXcHRi?=
 =?utf-8?B?SnNYcGNHa2tkcHdKWmkyUjMrQ0I3QVI4ZWtiejdzdkdZajVnUlhpRWdkanY0?=
 =?utf-8?B?ZWQzWVg1WllyZHVWWWxha3BWMlBwR2l3NjZUT0ZqaHZ6ZXZLSXB2VXdlN2M4?=
 =?utf-8?B?Qm9JN0xxZFkrM0NkenBqM2hMN214eW40K1BQWTJMZWYwb1Arb215QUlvRmFG?=
 =?utf-8?B?eTdLYmh2SXozZUtNN244QW9XTVpkU3VXajBBdzZCSWlUSm9wdXdVSTAwTHhm?=
 =?utf-8?B?ZkUrQVBUQ0g5QmlyaE9TbjI0a2RUYUJDNUY4WUVScHZjUlo2SHZid2tGSFVN?=
 =?utf-8?B?WmJ4V0UyRU5HQ0toUFBnU2t0NXBkNmZETXErQ2dteGVEaEc1RGxDUlFsdlNC?=
 =?utf-8?B?bUQ1amhFQnJGaTkrRWpCZ05Eb2Y5LzJtTHh0TFRzVDJjeEJnMVRXbm54Qi9R?=
 =?utf-8?B?a1NvcjNQNTJwQlg2bFdxVUNHN0JBV0k4VEcyRGF3VDA3M3hwekxwdEpGV241?=
 =?utf-8?B?OWkvWUxlbVVVYml0SmdTb3hQc2d2SlJGc21QRWZRemxhaEw0OGNVbGJFZ1cz?=
 =?utf-8?B?UHpvekhPbzBGRUZyTGpTMzBtTUp0NzdraTVCUldkVTBidEZ5VDNYQU9sc3N0?=
 =?utf-8?Q?mump8nFxz9r1S0rsVlUZE1fB9MP5UHbevYWDZuS?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eec22ac0-c95f-4047-b15c-08d8cc4c3097
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0802MB2374.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2021 16:11:27.9702
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8CIqU0v1Vd/JYZkQYwliiF0HEI3qzXc9pwiT9nPpc2x/yz5JZKugy3wCLMVbwqYxjW/octlxh2qesdK92SYYug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB6268
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07.02.2021 18:21, Shakeel Butt wrote:
> The list_lru file used to have local kvfree_rcu() which was renamed by
> commit e0feed08ab41 ("mm/list_lru.c: Rename kvfree_rcu() to local
> variant") to introduce the globally visible kvfree_rcu(). Now we have
> global kvfree_rcu(), so remove the local kvfree_rcu_local() and just
> use the global one.
> 
> Signed-off-by: Shakeel Butt <shakeelb@google.com>

Reviewed-by: Kirill Tkhai <ktkhai@virtuozzo.com>

> ---
>  mm/list_lru.c | 12 ++----------
>  1 file changed, 2 insertions(+), 10 deletions(-)
> 
> diff --git a/mm/list_lru.c b/mm/list_lru.c
> index fe230081690b..6f067b6b935f 100644
> --- a/mm/list_lru.c
> +++ b/mm/list_lru.c
> @@ -373,21 +373,13 @@ static void memcg_destroy_list_lru_node(struct list_lru_node *nlru)
>  	struct list_lru_memcg *memcg_lrus;
>  	/*
>  	 * This is called when shrinker has already been unregistered,
> -	 * and nobody can use it. So, there is no need to use kvfree_rcu_local().
> +	 * and nobody can use it. So, there is no need to use kvfree_rcu().
>  	 */
>  	memcg_lrus = rcu_dereference_protected(nlru->memcg_lrus, true);
>  	__memcg_destroy_list_lru_node(memcg_lrus, 0, memcg_nr_cache_ids);
>  	kvfree(memcg_lrus);
>  }
>  
> -static void kvfree_rcu_local(struct rcu_head *head)
> -{
> -	struct list_lru_memcg *mlru;
> -
> -	mlru = container_of(head, struct list_lru_memcg, rcu);
> -	kvfree(mlru);
> -}
> -
>  static int memcg_update_list_lru_node(struct list_lru_node *nlru,
>  				      int old_size, int new_size)
>  {
> @@ -419,7 +411,7 @@ static int memcg_update_list_lru_node(struct list_lru_node *nlru,
>  	rcu_assign_pointer(nlru->memcg_lrus, new);
>  	spin_unlock_irq(&nlru->lock);
>  
> -	call_rcu(&old->rcu, kvfree_rcu_local);
> +	kvfree_rcu(old, rcu);
>  	return 0;
>  }
>  
> 

