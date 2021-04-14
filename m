Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00AE435F964
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 19:04:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234153AbhDNRE2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 13:04:28 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:52324 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231901AbhDNREY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 13:04:24 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13EH3qH7032077;
        Wed, 14 Apr 2021 17:03:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=awpWjuYhgz8FnNkEiqfOLniexuI6YMgpG4dJpaPgIwE=;
 b=DlmePFlm2ONAN55e36xlBdPp6RZ4Z4diGkDurgil1Gq8D/skElQwnngvnzRnqo1oz8Z7
 JcqktcuRwyEZyLqnq6YGIxQEQej6UG9LeNwtTBRV+jI45YCsy576TCS7PCKTXlcE0sJx
 rCUsFHngqVBHQa6oAI6PI5hebGKMimGqEaWfCHsXncCQwuQbh6CtemAjwt9OfDdZm+ri
 O76xuRwLN19kEUOoFdtSkRio84+vR5yVw/j23EHOf+RZQgr3GTitvKYUeD5DrqBhf9fN
 qYiLDdk/nc7+A5z97NE206gjOju/YzzxWHyQi6W19+awfTxR7VGdRKKIjPGn72Yj5zTO nQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 37u3erk72f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Apr 2021 17:03:52 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13EGtXZR010540;
        Wed, 14 Apr 2021 17:03:48 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
        by userp3020.oracle.com with ESMTP id 37unsu96mr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Apr 2021 17:03:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OB5iYTpOp1C0ScT3e+2nznTMEVNWQvLruNy/bOIsJ2r5qAvuk8k9uFXTwxi6Y0Dd0Lhl3z1U5UUcwBp4GHeQP/xomdJQ0X+aI4PzVaWzTGMTXvAhPK37gu3d6zjZIUTCsjVXncAJZzSxaCPRXxeDrvsMDKjZ3tQRt07N0egxHVRFq/BM2VK2p5OXH9ze8IBtiW9FpZrXQ3e+FUCjdsuIrpPZq/SCU0Y4eOV/GsnoTULShaYWvsYK5Q8rqNZCII30hOQ8MnUCYS2DNXHky3l/ya1Ox3cFuL1ZD6SWbz+p5oVAbpvtaRflzF2m8SoMhdrpYjUGgTU6c1N6+Y2Uqj3hYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=awpWjuYhgz8FnNkEiqfOLniexuI6YMgpG4dJpaPgIwE=;
 b=X9kZ3sedxqYjOQtBv6eWgNNTfDTrnuPaq7uTsRk4Iu2s+XgwjAvXMcntpuSwY6gSA0fAx9hOJ6h0Ew8L8fjn629QWCYgA+JL5PM8OdB3XwUBcYoMDvUekv6+NTAyrAvRUXL4h+M4k8mrfwDYRs/oNkhPkueiCghjlvpxQM6rXBRV8N0uBAu7R2gSOevWgJ7jbgjtqEZm6upKbHViyTO97GNf9orSAXx1wAzcyeApiAjz5rDs+llC04BNrMnGztB6Uq8ptAW7mH/2p5uSYRAbO3f1JNNtlBQiW9K23p/SQaSb27Su0id/9vEMKT7F+D17E6qb3QcX+MzEfYaqxPWPHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=awpWjuYhgz8FnNkEiqfOLniexuI6YMgpG4dJpaPgIwE=;
 b=iVKipATtAZlglSUQckfrVOt2vwWv7Cd4/ySrsq6TEsElxLBoYmmGljHHNssFr9YDEuXKHhnR+w5/s6rAPiFW4xqsnYkgbrPC1QzU4wlXvKKRC67zkf+NDHmxzWttgJajbPfZO2n4eLEOBnWyXi3Xis7UGbB/ZcHQakhv0MF0ZaA=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BY5PR10MB4115.namprd10.prod.outlook.com (2603:10b6:a03:213::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.26; Wed, 14 Apr
 2021 17:03:45 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee%7]) with mapi id 15.20.4042.016; Wed, 14 Apr 2021
 17:03:45 +0000
Subject: Re: [PATCH v7 4/7] mm,hugetlb: Split prep_new_huge_page functionality
To:     Oscar Salvador <osalvador@suse.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Muchun Song <songmuchun@bytedance.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20210413104747.12177-1-osalvador@suse.de>
 <20210413104747.12177-5-osalvador@suse.de>
 <94992151-03fc-dedd-3e09-811908d26d04@oracle.com>
 <YHZ2xCeo+aVgD28c@localhost.localdomain>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <c2be0fc1-391a-1796-b8fa-282ce8ac140a@oracle.com>
Date:   Wed, 14 Apr 2021 10:03:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <YHZ2xCeo+aVgD28c@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MW4PR04CA0304.namprd04.prod.outlook.com
 (2603:10b6:303:82::9) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MW4PR04CA0304.namprd04.prod.outlook.com (2603:10b6:303:82::9) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16 via Frontend Transport; Wed, 14 Apr 2021 17:03:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: da05b6a3-384a-4c40-ba27-08d8ff6743c1
X-MS-TrafficTypeDiagnostic: BY5PR10MB4115:
X-Microsoft-Antispam-PRVS: <BY5PR10MB4115BADC2F8766B6E12391E8E24E9@BY5PR10MB4115.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MFaT58OKz29Dw5VW57EgRyrP38DhL/m81qd/flrmex1d9297vYUsZ6bIasbNJOv/XtuqdsrkQ1+rh9WaAPb6OvwNn90ecnkeYUmeHV6QQFCwxqH0plGZv0mTAzUm7kxggRxraOmXzEzAjJf+6iwx9nDjFqD7erjigqWWWCrK5BK4mrncm5IucCbruRdXi94G7SAw5ViFweGLOO9x43yiR7/syG7x7apPLSvja01cfD21gObZqcU8xXluPy0SHEeQvk5vaaUAwtJu5U6Ojs2jDiJYHr59Eq7oPoqcg5an5OO9jTbDXYjkDJjs7JQcqrl2tEqU6Hep8S5/A+klK+kKrQySU1dVsj+UDX98a2KbeL/B3Hg7wQmrJSo0Lkjr5cKxrTO5ikFWNuC+qOWWJ2JHbQ/XLFmAFSXm47GPAhKPYtr/czcLyWZXcYSwB8fkJ9vpltkkYtT9lnQk3suySR8T6hyF6tlt53Mm/AsajaSzdtiXHB17BBxhpQe+BtC6DR3LCJGc0anMZG77oB+lJOElfJdFAZ76jDUmpiKYtNW7sJHL+E/uuIryAgnb7J9JFYCqmBZE2jeSrPAtPlyveTFXMZBW1btBVL2zzcOT1MlHawq/HRT4csBk4ORXTxJHvaVOiQdHYnELcqYFlsZrEznCGDd4HEJ6kP5HEb8ps9VBeJrDoNYXr4KhIiDlW3JWHQV+dwT5jXZ43D47p2TB9M510suddsB8J4IIPwMKf7D+eNaNKkPIujX/67tUAAJRXCD3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(366004)(39860400002)(136003)(396003)(478600001)(956004)(8676002)(16526019)(83380400001)(66556008)(8936002)(6916009)(2616005)(54906003)(38100700002)(38350700002)(66946007)(26005)(16576012)(44832011)(31696002)(86362001)(5660300002)(316002)(31686004)(2906002)(66476007)(186003)(6486002)(53546011)(36756003)(4326008)(52116002)(14583001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 90K/pZPZGtvxEiWuvSa1mMlrBWEpJmrUlrVsvSz19LvYF6Xx1VV+LUYXRhwX43LLsDWcC4wHMbknianE56xqpg2t1GYDa1iHiYt9tTEZUglSc0xyul5cK4RZumNEVLSWG/Pu6KkRgwQW/gl4K3hwBaTSydFpXOTDr3QHykEGbn0+PvbcywvNBO2iesijtf9BiYA3M1U8PJKVQ7Uz4KsPoy6qyzr5rD6oTPlT7xScL//HPOnwqEJoDXVCohcQRlv455+2mV2MW2ztfXqUvZ8hLRPKp0OV1SuT8BQPeGNbrq6mQ6F55if/MuuQWOTKG7pleCuZqZoBbdDYU/2eX1Dp/DIbziHQEUWsr6/q9XH9u6uPWpYBXWEXHKekQ2YIUZpyJ1oPigRokvhSz7q0gYmEYUjNbwDzlqc8dPhgbRTdqrhgFvB15+bSsfOhKRCFqqVX81EQdwZWw0kmhaoxIiorTSiEiZKu6dqPlzf/p80Sf6wyKovXv39wRXjcX12jCsLJmQg+jgLWkesYxuSWjyeUCosf3UgOJLPCMjX8BGmVxEToAtqop+Z+N7/7HFRrrxlEmmjnV+fYRo0EFkEtLE/N/Hb7qsxLbsQHxA0VFWC5kGTvNRpIqZd0KoxqH3ZPlqjoU7+Jv77WZFGl5bUPD6iqhdmxUCRWOyYwGL+QDT1Fg6+43to70zo2F5dsXnORVFyOYlJEiHIvxURdizZpyMEyU60H2/CZfgjVctqeNBz5Z2w=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da05b6a3-384a-4c40-ba27-08d8ff6743c1
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2021 17:03:45.8121
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 40Kp5tsZUXLNe306S3T2bl/wjoLk0eN3tUyiWp5OzeqGtZSHazzNnRqnuaYVL/ym/tXCD9qzavdzKWpKKRmTRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4115
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9954 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 mlxscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104140110
X-Proofpoint-ORIG-GUID: oUswibFRRiiqyGdDjUUmyf1N2rB0DnW0
X-Proofpoint-GUID: oUswibFRRiiqyGdDjUUmyf1N2rB0DnW0
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9954 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 clxscore=1015
 adultscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 spamscore=0
 impostorscore=0 suspectscore=0 mlxscore=0 phishscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104140111
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/13/21 9:59 PM, Oscar Salvador wrote:
> On Tue, Apr 13, 2021 at 02:33:41PM -0700, Mike Kravetz wrote:
>>> -static void prep_new_huge_page(struct hstate *h, struct page *page, int nid)
>>> +/*
>>> + * Must be called with the hugetlb lock held
>>> + */
>>> +static void __prep_account_new_huge_page(struct hstate *h, int nid)
>>> +{
>>> +	h->nr_huge_pages++;
>>> +	h->nr_huge_pages_node[nid]++;
>>
>> I would prefer if we also move setting the destructor to this routine.
>> 	set_compound_page_dtor(page, HUGETLB_PAGE_DTOR);
> 
> Uhm, but that is the routine that does the accounting, it feels wrong
> here, plus...
> 
>>
>> That way, PageHuge() will be false until it 'really' is a huge page.
>> If not, we could potentially go into that retry loop in
>> dissolve_free_huge_page or alloc_and_dissolve_huge_page in patch 5.
> 
> ...I do not follow here, could you please elaborate some more?
> Unless I am missing something, behaviour should not be any different with this
> patch.
> 

I was thinking of the time between the call to __prep_new_huge_page and
__prep_account_new_huge_page.  In that time, PageHuge() will be true but
the page is not yet fully being managed as a hugetlb page.  My thought
was that isolation, migration, offline or any code that does pfn
scanning might the page as PageHuge() (after taking lock) and start to
process it.

Now I see that in patch 5 you call both __prep_new_huge_page and
__prep_account_new_huge_page with the lock held.  So, no issue.  Sorry.

I 'think' there may still be a potential race with the prep_new_huge_page
routine, but that existed before any of your changes.  It may also be
that 'synchronization' at the pageblock level which prevents some of
these pfn scanning operations to operate on the same pageblocks may
prevent this from ever happening.

Mostly thinking out loud.  Upon further thought, I have no objections to
this change.  Sorry for the noise.

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
-- 
Mike Kravetz
