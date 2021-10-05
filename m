Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F10D4221D1
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 11:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233499AbhJEJMX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 05:12:23 -0400
Received: from mail-bn8nam12on2084.outbound.protection.outlook.com ([40.107.237.84]:44705
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233289AbhJEJMV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 05:12:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gSZasx1XGTvziF28WsWE3xnlgBe2raewQV8A6UWQ4SA4WEULGrx0oVkOcEZeq2yu3l1GStCRxleLZChpzrKVv2Z9JVnAm9pwcdrWywXZs3Y7bSRKuNr25rhmdOOvIOrwmoaavhEsT2PaTB1LGgrPzeFWdjpUl3e7WrUWiwz/JnQcKINeFPSFBNJv4Uh0uwDGB4Sz2clLvpS39LQ+WjJonzKVOEsVZg+9JIkeZE4aKNN79nuL+jIXUxzVyTR43WMVSbOMHhzklwuobrFgfxv5XLFvdJNAAd/5NoOQ+hqvEvN8bg5omX6H/fVunmmAfrE2HMkCPLEln9dgJKd5TLhsmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sXzWN5PC1GllIn66QncssEoIpfQGAOBwLCxv8vkFZ4Y=;
 b=eR0b5Igp15j/ZAGTlHWd9/+5Q6gBX4rAvT9gqJl/EWaj/mCRM3Suml8Vnf/lg3BxLSjs5PQsIQa3Rf4dpGOm9ylVXMaIhXIM9py/baeGWxMaFBWZRb+8YjXVVjsiv1ejy38Qrvwam1OW8QMhMHBJNXhY1f0mdlA72rWRVV9aKiZNsRIR/LXYF5gMRNZ5depOACOvU2cZZog3r9Veab/J493afBhYRTCN0dDyQB1JFmIW7pd+/Wu9jj6KK3nd4ZOCXA0ISuxH5XLICekjLbDQrlLYpAQbyTKWtU9UxHHQx00rHu9atTw3ZtZD0xXcTE1kDUKpTBNXr0sWNreHb2/OJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sXzWN5PC1GllIn66QncssEoIpfQGAOBwLCxv8vkFZ4Y=;
 b=O2QQmJPfON84sdQBzcK3es54dx4BxkU21ZYSofeilVIdCVCeqDUGdGwQ1PP8wHYCDZipsJ/w2Sm15mFZwPeQ81l3yXmsvZh74X12jddVF9PsfyUSibusPtp0TN28gWc9JhbdMQSOQQqM+9RbK2Vv+o06W5zWYVd8ehkveXLyybA=
Authentication-Results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB4289.namprd12.prod.outlook.com (2603:10b6:a03:204::14)
 by BYAPR12MB3415.namprd12.prod.outlook.com (2603:10b6:a03:d5::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.22; Tue, 5 Oct
 2021 09:10:29 +0000
Received: from BY5PR12MB4289.namprd12.prod.outlook.com
 ([fe80::74ac:e43e:cebf:6d6d]) by BY5PR12MB4289.namprd12.prod.outlook.com
 ([fe80::74ac:e43e:cebf:6d6d%3]) with mapi id 15.20.4566.022; Tue, 5 Oct 2021
 09:10:29 +0000
Subject: Re: [RFC PATCH 4/4] sched/numa: Don't update mm->numa_next_scan from
 fault path
To:     Mel Gorman <mgorman@suse.de>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org
References: <20211004105706.3669-1-bharata@amd.com>
 <20211004105706.3669-5-bharata@amd.com> <20211005082335.GN3891@suse.de>
From:   Bharata B Rao <bharata@amd.com>
Message-ID: <dbb74941-4d6c-3e5a-2f5c-d18001c2856c@amd.com>
Date:   Tue, 5 Oct 2021 14:40:15 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20211005082335.GN3891@suse.de>
Content-Type: text/plain; charset=iso-8859-15
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0011.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:95::15) To BY5PR12MB4289.namprd12.prod.outlook.com
 (2603:10b6:a03:204::14)
MIME-Version: 1.0
Received: from [172.31.35.137] (165.204.159.242) by PN3PR01CA0011.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:95::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.19 via Frontend Transport; Tue, 5 Oct 2021 09:10:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 985085cc-f661-4c2d-097b-08d987dff9e0
X-MS-TrafficTypeDiagnostic: BYAPR12MB3415:
X-Microsoft-Antispam-PRVS: <BYAPR12MB341570B9488ED3A9B09170BEB0AF9@BYAPR12MB3415.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jb9RL9V3qBhG8S9DEaUzGr0IGpamCtmGkLPoryrPNopkzAdIP1NI6GulAd/Gg4CvTeRm7s/1MZzzR7Ku5B9wGwHrK7JFUCwoL23ufkfegu/4wZ1er/SmDzlb3kdsUPZ/uiOMKMJEJ2OKtYHpCm0fqbWa7qhKWPsjy98sGonoKWhtLXVr0KsmKjupXYpVFwjlFWYicurIQ5AxLtJ7f/H3+nywMzmwIHXvl1A6/yfe1v9q17NOcLF8YFuTALjAye+ZOTPhC2NkrD+6LRD9W4CDH6HT23I+1ul7u44HSiD++Sf2CzPnqvGgtTRlNuX9fg31fHS3gosL4x3HosHQ8ayg+5/zTHMZ5j1iXCwkcLJcjwq7qPl4pxADMYZX5vI0kYoLDP4dI/wJUamN+9BCytPnFBMaWQyMV2KDNslBxbZr7NVt7aP0EN0FGNl8wLgjSFerwRsbhzCgIbl0y66fyq1bBZd97hQ0TnlXObtN+2XnW69f7a8F13LGrpWMqIakWGgx9cpZJgQznOfMXuEAcv7/ZGtfzG4TyR63kt0ryT+J4xaTB4gYa/51H58IPr4juy1Xq55NDzUCIwi5XOt4B7CttNb7Q1lvksaAeqcPz9aZYhtx+Oso7TsDIJ+3O7Vvo4pb4wMDtDN9fH4pR5gg3Rcc4GP5iTkJkSIjp/m288WbpENpAiy8ntcByyXvUwE70ih9o0kIb0af8/0Xaj4NFZTX72qdBGlTu4yPmzoMzyvgCmA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4289.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8936002)(6666004)(6916009)(83380400001)(5660300002)(8676002)(26005)(6486002)(66476007)(31686004)(316002)(16576012)(66556008)(66946007)(38100700002)(31696002)(956004)(36756003)(86362001)(2616005)(508600001)(4326008)(15650500001)(53546011)(2906002)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-15?Q?0g9hfXd9/OBEj85uoxvDI3fXNvv0AMC2XJtK1zklCXMDsHm+NguddyvDg?=
 =?iso-8859-15?Q?XyRCv91dHhGtVQ+lJz50bFxlnewpwft5FG2OBUZMghCCAcYOr0FUdoJwA?=
 =?iso-8859-15?Q?EhdyWllXCY4J7gofa/Pz7h6LAzv2Pk/Y5hITuYDAYHhpYBoepbQFr9JWa?=
 =?iso-8859-15?Q?W5usSeO1Qj1CilCMrhnb2dIvOHE2mMBwFRvRx9o349YkIscBmok9q6jKF?=
 =?iso-8859-15?Q?UCo2m3eMj10SfOT54aeuplHGLLID/Om3rxAhCoLu6qeYjbsuJdilQdUx8?=
 =?iso-8859-15?Q?VncgL2JMpFDVJdzJL2zIOZHB5d4JdqX30p7bCMX9ULj05kfO9fUYWG9Ru?=
 =?iso-8859-15?Q?PfDtGJPBZSq0XbMscOrM9gMqNPFMnx5l6mflPLDtJ1bBOyt3hT9Hk5iPV?=
 =?iso-8859-15?Q?NAr7jxfvEy4G1XILHKYjkTGHcJY9CtzLMPN0HrjDZ/eIIbY6vCcJbBlRV?=
 =?iso-8859-15?Q?/EcWvaKBqyCS+sBvxfAF7oYvDQuJuEx+zoeSEmTeGws7u9Vc6J9JHsqnO?=
 =?iso-8859-15?Q?jHJkFLmkW4MVQItFICNytnwhTzI63zfsw27Cvxed8duIeJ2A/afgwYMae?=
 =?iso-8859-15?Q?ouEopqGRSxkKjBlc5JVIi/pXgE4pRa4bZJM/ztWc19/wMljvB1PagBFaJ?=
 =?iso-8859-15?Q?x0ZbgVELtU5EVutqCHXHMTysUf5Spq599cFYpB8YCpbmr7l7IALXX4u9s?=
 =?iso-8859-15?Q?Uc/UdsY6KjgONXW9MQQpPCxirgTDaSrykxoDneRkd9pBLKHyA6ni3UJ7n?=
 =?iso-8859-15?Q?RxcQh+eMIOka1fg5Y2UV2pfNVaBAIeTx5lX7OCmsTtUqXH8anL+vRe9hU?=
 =?iso-8859-15?Q?q27d5RmhVYKZHAeMg/Wx6yrsMdLFcc2pwRw1+0EoI3uSXsxqAVF7OjM6S?=
 =?iso-8859-15?Q?hm6Dj6HB65g89fCD/DEaY1TyNNgMo5unGq4urbAsTMPCtJ2aLiTSxX/BY?=
 =?iso-8859-15?Q?iucNq8HvXbRRYE89Q4T0xZ/q546Sea/ive45s3iAh3+Q9ACmBtfuiHd0J?=
 =?iso-8859-15?Q?6JqGMUJIOxQ+DB+h5tMDWnTj4VruQTHjFtIHvwd6clciSz+kMM63VKzIV?=
 =?iso-8859-15?Q?z4KD/XN8ZEfblnqJYIsO5MWZum37+3FSv8Tdmyj4AxPwWdbRUgw/B6stn?=
 =?iso-8859-15?Q?pPaV9lhdoByIthTHPzMPGjeN/oBka2jgrj3FQSOfYKgMyd5iL8GJPefPZ?=
 =?iso-8859-15?Q?ga5nP++jlnbaQvcAA1SzqTov2gArK1daXnETGbqrk0CG6eqhxyIfvj2Yr?=
 =?iso-8859-15?Q?Ts3ezBr6aO7QqM+TpdFHMTyT3d28h0nCNxFZedk4C8SKcXB8n8FG2E0LS?=
 =?iso-8859-15?Q?sChD/Aqhtssjdel93/KVGsmNH0aSPUFZIfBn9RGWWwHyzdXP95OYuXceG?=
 =?iso-8859-15?Q?UF8gIAK2n4LGwQu9V4AgqJMSRknz6D/yc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 985085cc-f661-4c2d-097b-08d987dff9e0
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4289.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2021 09:10:29.0008
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B7duZkDu3LDvfjP/JXxCzIAoGZexjknExTwJBTQG5ZIW/1I7tX4shfhqYfKhNsd1xEKEk9VbhGm0EGdfvs+Z9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3415
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/5/2021 1:53 PM, Mel Gorman wrote:
> On Mon, Oct 04, 2021 at 04:27:06PM +0530, Bharata B Rao wrote:
>> p->numa_scan_period is typically scaled up or down from
>> the fault path and mm->numa_next_scan is updated during
>> scanning from the task_work context using cmpxchg.
>>
>> However there is one case where the scan period is increased
>> in the fault path, but mm->numa_next_scan
>>
>>  - is immediately updated and
>>  - updated without using cmpxchg
>>
>> Both of the above don't seem intended and hence remove
>> the updation of mm->numa_next_scan from the fault path
>> Updation should happen from task_work context subsequently.
>>
>> Signed-off-by: Bharata B Rao <bharata@amd.com>
> 
> I believe the update was intended because it aims to reduce scanning
> when the task is either completely idle or activity is in memory ranges
> that are not influenced by numab. What is the user-visible impact you
> observe?

I haven't measured, it just appeared unintended when glancing at
the code, but now you have clarified it.

> 
> My expectation is that in some cases this will increase the number of
> PTE updates and migrations. It may even be a performance gain for some
> workloads if it increases locality but in cases where locality is poor
> (e.g. heavily shared regions or cross-node migrations), there will be a
> loss due to increased numab activity.

Thanks, I will check if I can measure and verify the above.

> 
> Updating via cmpxchg would be ok to avoid potential collisions between
> threads updating a shared mm.

Ok, may be I could just resend with changing the scan period update
to use cmpxchg.

I also notice that in this case of scan period update, we just return
without resetting the p->numa_faults_locality[]. Do you think if
skipping the reset doesn't matter in this case?

Regards,
Bharata.

