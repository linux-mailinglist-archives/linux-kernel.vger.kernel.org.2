Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3F5735F970
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 19:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232576AbhDNRId (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 13:08:33 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:55594 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbhDNRIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 13:08:31 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13EH3qM7032089;
        Wed, 14 Apr 2021 17:07:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=HpycqJpCCxTZwIWkFCRTVHB6yxDzl7UpKPSuv0aBvJw=;
 b=kpdl1VgcUl6+CxeKRcPq3ba9stuKtXP+fq/PcvuDxVHoIZgjBBewY1/t5quXYJYNUswe
 zhFfed09XAQ8LtJ7NGZ54VE6pCEbxmnpRuQHmf6bbCaOLHStvdF2/+AEWL3IZyvgNoUG
 mf76XbFkhpZAEsZQr42jTiNu8s/w9vgjG26caDQm4z6l2m3RPmQBBa2OwEd1kG95ygme
 eXYwcGiQdseyaZ0s27EQT19XOmM7Zs2LTswStmTcFsDDshfmwpChaYJlAG5+STeGSvGn
 nXqYEOV2DQj8jBJWaroye7ONiIduiKOlL4sv4XHrRbh9KK4zbC9TF5s9ksNhFJ2rk/47 6A== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 37u3erk7fd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Apr 2021 17:07:59 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13EH5YeJ060856;
        Wed, 14 Apr 2021 17:07:59 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
        by userp3020.oracle.com with ESMTP id 37unsu9du4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Apr 2021 17:07:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kc2s8uQfFCywols4wYhEgxplD4cyFEYx01eDLMNdNMYhswYlI9SZrOAp0uQsKlUkAO5XcgxJ0WbfywH6oRfLrP2E4CgDP/cDkySL9Ptb31UEXJeWbWrt1+5tiDngSKLwZW9+ucQaqpxXzuWDshFr7Cb9ee/SIDGAVU6rs2LEET+WrbVdGFQbdCZIjkKAP+2w0YIOf5aqZ9OBh8qP3b9gJkEYV16fVqOKwZ0pPCLV0vHMTCWQ+0TUchkOB/ypA3fqq55mtoR3mxshEw9F+anZnFOtene50uDCugbPTZhE85KfICN++Gaug6lkDRrHEBjAp+MqtbO3Cva1Emgeqirisg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HpycqJpCCxTZwIWkFCRTVHB6yxDzl7UpKPSuv0aBvJw=;
 b=hOe1nIYXMKHOzJV02mFZrRJ/OXXz02y/ZfO4ReUlJeqjr2j1rbjMQ5eDJj7lXVFfAmgDlvK6NdMCs3aBaDBNzZ66/PNaoMtMj51CghZhWE2863PIGCm0Xmm0TXYNqIdICW3ctM+vGJfnjmZOicV1wqwYCQg9K2tMwuMu2XLi8twAOwhKqkhzY6pshU3+JBrgh0zvHMWLYPpB71VoY6CdIREWssFAG6kMADca2dW6ObCD0RC4MU/rtA/C4fl3OEz4vVvWuLd8xmfXwqe6RQtoau6PDRxC2jj6FiJocXeaLEFWeI2P6nzyWeO8quVMEaeMbuVV/Oc0kNY47NJ3b74uLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HpycqJpCCxTZwIWkFCRTVHB6yxDzl7UpKPSuv0aBvJw=;
 b=kCRZDVyH+iGwyQV/25/rS9efRBfiCgpsNuZ0dka0KMEDpCNBZq8Rue/NrzTMKiYeXXlKsEyjeYXg2XkKZjwZXr2ciOY5FkJS+AMTnjox280IfqzVuKVQY8mBcavk5wdkGUxuoLDUur1pNwrQMOPWBU7R6OYyrBewWoJtOfGxuaM=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BYAPR10MB3638.namprd10.prod.outlook.com (2603:10b6:a03:125::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Wed, 14 Apr
 2021 17:07:56 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee%7]) with mapi id 15.20.4042.016; Wed, 14 Apr 2021
 17:07:56 +0000
Subject: Re: [PATCH v7 6/7] mm: Make alloc_contig_range handle in-use hugetlb
 pages
To:     Oscar Salvador <osalvador@suse.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Muchun Song <songmuchun@bytedance.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20210413104747.12177-1-osalvador@suse.de>
 <20210413104747.12177-7-osalvador@suse.de>
 <722f9a5e-ef0a-508a-e58a-6c3eacb5d1bd@oracle.com>
 <YHZ1A8Wi43DcEv98@localhost.localdomain>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <681fac27-9684-48cd-daec-fb82057f2253@oracle.com>
Date:   Wed, 14 Apr 2021 10:07:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <YHZ1A8Wi43DcEv98@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MWHPR18CA0035.namprd18.prod.outlook.com
 (2603:10b6:320:31::21) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MWHPR18CA0035.namprd18.prod.outlook.com (2603:10b6:320:31::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16 via Frontend Transport; Wed, 14 Apr 2021 17:07:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 88960b21-366f-48fd-f4ab-08d8ff67d926
X-MS-TrafficTypeDiagnostic: BYAPR10MB3638:
X-Microsoft-Antispam-PRVS: <BYAPR10MB3638639A8EA8A80E82BB9677E24E9@BYAPR10MB3638.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Tra1935Kwduqr6o2nUJJUqMSba4KivRP58EhfkUiV2mLfO9Eqn1Y3hjlhMT+ntSzln1mlFoVpa4Nt2W9LzRWpk1uk15rd6pvgdxWYwSS7hJTw4otMVq0tEm1M3FNwQvZGr9njUSBaEyMy6UwqE85NxrbA8eg7taG6YZpm+e9RvzHHSPG0qgiS5wtWKXEtJpLLTfiycj1YZGhJSwvzjiGvs7FaapzGpxf1HNYCi2yOlU7j4E5mPi7CWCk26UP6cJyG5NAMkohlXay2iav1cP+JDQHgPNKhNk17jv7F+Kyndu6FJsQiWJh4BWp72tZacCvngdreEZmmqFy4nvR25ZF8CUYHesd8RHimzoHjz8Gm/wPRdGT3lXGIBIo10J8s8DlC/+5QksISDz96CBU0JbS2kch0ELztxTl/bBhFOktk94+09QePRf8pgz2NelD37bzjBryyG0cEW7ijpXizFnxotTVddzkDy/opGnOY/8QFehVCE6xKXkZuTLlVf76eGWvVU4Isk4l6mcPUvEd9Bql0eU+nEYikq+AkXPF+xsppR0msqXAZWQyKh3sQk6h/XPOyeV8GjEIU16++YF1R3AFWLtwmvfmt8NqutDFmiFoxfPRhh7tRRyxFYQZWK3atelvmvd4I2OX8f/p/mjrakaI57alRyPbapCyU1qDkLz914mdp16WX7TIxZdUfz7/gRtuLfLO7JSacoa2NTocuD1D76GUD9I77f8oooXrkizcCcI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(396003)(366004)(39860400002)(136003)(316002)(6486002)(16576012)(31696002)(16526019)(52116002)(53546011)(5660300002)(956004)(66476007)(478600001)(4326008)(38350700002)(26005)(54906003)(31686004)(6916009)(36756003)(44832011)(4744005)(66556008)(86362001)(2906002)(38100700002)(83380400001)(8676002)(66946007)(8936002)(2616005)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: U/a7XfdqWDeXJScXZjAzgsF3BNMu3ZQulqq/oIvREby0HxQ6yPaQfhNe7Td9dz4m0nAs3S7yAaUEi1HF2RkKAO/aypfSMcfMbnySs6CV5kZkaFUTQf7Yuhda8dxHsgCKk7Y1d1Lra+NH6Q/uPmXewC8SMpqJ+9yV3p9M2xF/wz4tdbQ5PUnCkkGyiiM9gEjsQduCQvGSypKYcWV910kT5e3IFpDW/bos5GhkdFVj/p0BlNVkc+K5z9Xn2/YM1ve4O+36xoNdyrEuv2mtVz4c/axzEu7WPiNWfWaK+B3Pg+B3jcIHbI1Y8u+DVOfBGrhNpuHHYRa4gnEoP7XBKA+imB9np4oRn7bbU1p+HySmnY3TBHeG/0iJU/UQoEC32WIMIXavLlahNCgyRDHvqkW0LCAoKmdAmRMtjOg+5Dzxej6Xl5IST+TL/k7f3FSp07yKmZ9cEKC0hKWyE6/ThPX9eAvFTj10nY+VDp9JWmRCxtCx4cmZqWMZsAKATgtE9P1inzRDa3wbreltFvEGtnrn1ErCDoCN6t5073aZkIfBYSV4EcacFjUX4vEGvRzo6N37kYfRGW/AMmgglufHyHJ4TF/uNw7CvLl4u1F8+u2nlXSlVjmHIElrQA2cZvp6qajDiIaWTkFe+NaLHu4AGZ8Mfb5a7RX++PECP8jn65y55fziyDSdpx1iH/2KxMuBKiqxAfFsKSFi0w6LI7eLUjhy6Ft+LA1Dyyor/dDiATeEyYk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88960b21-366f-48fd-f4ab-08d8ff67d926
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2021 17:07:56.4391
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a/wYQguEy04hb0HdQI8rBlM6F0HcMMjEy/o8O7BKdFrZAlYyVDxpJP97GmcfQ5JcULeFu4iJFh2l0j9wpat0kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3638
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9954 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=971 adultscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 mlxscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104140111
X-Proofpoint-ORIG-GUID: WdQN9G0gPreO5m6aAK53_M_yGNzLuWAe
X-Proofpoint-GUID: WdQN9G0gPreO5m6aAK53_M_yGNzLuWAe
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9954 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 clxscore=1015
 adultscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 spamscore=0
 impostorscore=0 suspectscore=0 mlxscore=0 phishscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104140111
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/13/21 9:52 PM, Oscar Salvador wrote:
> On Tue, Apr 13, 2021 at 03:48:53PM -0700, Mike Kravetz wrote:
>> The label free_new is:
>>
>> free_new:
>>         spin_unlock_irq(&hugetlb_lock);
>>         __free_pages(new_page, huge_page_order(h));
>>
>>         return ret;
>>
>> So, we are locking and immediately unlocking without any code in
>> between.  Usually, I don't like like multiple labels before return.
>> However, perhaps we should add another to avoid this unnecessary
>> cycle.  On the other hand, this is an uncommon race condition so the
>> simple code may be acceptable.
> 
> I guess we could have something like:
> 
>  free_new:
>          spin_unlock_irq(&hugetlb_lock);
>  free_new_nolock:
>          __free_pages(new_page, huge_page_order(h));
>  
>          return ret;
> 
> And let the retry go to there without locking. But as you said, the
> racecondition is rare enough, so I am not sure if this buys us much.
> But I can certainly add it if you feel strong about it.

No strong feelings.  I am fine with it as is.

-- 
Mike Kravetz
