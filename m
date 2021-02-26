Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F4D0326864
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 21:21:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbhBZUQS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 15:16:18 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:37660 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230261AbhBZUK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 15:10:56 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11QK4oAc062786;
        Fri, 26 Feb 2021 20:07:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : references : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=H3mKiasUeLuAsoMflgub3ItN0OwWXnzkeSKoOn4I4ys=;
 b=CPieoA/fe690J1ElAHySV93NCUKL6EL9OBarjsx82R7KKNr4TbZW9lDr9rKgPVXyQaxr
 GCPCYSGXg9YNQSNQJtNQUH+c55qFyOrMwUMMFasdOesVYJoNBJgUYSMxwsz2FnsKD386
 VX65oWdKj9hYeuM7u8+dFwXzzhK1zaT4K0gOSQnb/V55AKuSlGDrK7wYUNZx9c+vbBNP
 ozKqjy+T0BIub0az7CU3eVur0cmoG24ZIfxBm9fOogDw4Y5d+yqnVcUPVg2dCIjej/4Y
 Y8+IvTYCOZXHvX7bVzg94zWPpeHZc0iD1vkKp8UbdJWlPXpu8bNFdX4U+xnsiQCnDGGY tg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 36xqkfaqhf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Feb 2021 20:07:34 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11QK6hVK170833;
        Fri, 26 Feb 2021 20:07:34 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        by userp3030.oracle.com with ESMTP id 36ucc3252x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Feb 2021 20:07:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YjANfSnXmCUJhP1zpXQREkvEnebG4Y34Pdl2NLsZsP7pUMO+B69zJ0o4CqULMShpGBjz1/ORjpwRhJCvxjhCy8WHOpQy3X51dMjmN4jRAvPm+cMBatipBt6GLo47/tKxvat3QrUDpzEwOBXwk2oQvZyfWI+A6Kx1zfyKyfhrNzJbnGoFq8KncpiD5kB0sU+ofw4jfe1/SRvvF6hmPfw9evK9j3g1oWCIQsTxJwvfilmvmi4Bng1+0u0vQiPabo/YPsja2ZRrUYAz6yu9DCriiAy6U0Zdzl8lKmCTeMXG8tY84lWPiYN28VYzpXz60/R2oqgClGKolOKKG8+zw8kcaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H3mKiasUeLuAsoMflgub3ItN0OwWXnzkeSKoOn4I4ys=;
 b=P8xFqFKxtBkmNnz7m7pzTRaJDLE/Ym9z+BDvAp1Xjd5MSXCuHp9W7b2V3l6YX3TNrCGHTanN1sFa1D32D+5KMk76wPOPsbus363sT2vfPLqDHVa1NO8E+8/5K4SKX2aWXMcYtSkrPWEeDfPuVwZYiRnpQtd5bYSWEUucch7RDMf6w7rGSkSKw15EDZrBc6Tazms9yGhdgJwQTUmNMkSi+EZcQ8Zqv7BqFGY2xr6EsNcaWb10XeHYvU5YPcEccyGSSS+Mzzg+atufAFrkZoZUOn3eiJkwg/lA/hJDPETQ4mnPFq0h3mrXvfjOuKuSqlgkKD874agxSnwMxVlZg7Wyvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H3mKiasUeLuAsoMflgub3ItN0OwWXnzkeSKoOn4I4ys=;
 b=S36zg+ry37qQbNRjoSVUe6QqtpKIPq/wbCzuroJXgQJyGQEuXZ6C9D1vFz+aAnd3jCwnxbqvKICGTfu9ioEtIaK6k8iwN8kSiagyTRwDQu7w51BoDO4GyVK2mHWEIUBeofNITaM4pB6BADeivZ1uJV2BMYn2Oz5YwaXiin8SZwk=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=oracle.com;
Received: from CO1PR10MB4705.namprd10.prod.outlook.com (2603:10b6:303:96::11)
 by MWHPR10MB1374.namprd10.prod.outlook.com (2603:10b6:300:24::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.20; Fri, 26 Feb
 2021 20:07:31 +0000
Received: from CO1PR10MB4705.namprd10.prod.outlook.com
 ([fe80::28f7:d9ee:ff5a:578f]) by CO1PR10MB4705.namprd10.prod.outlook.com
 ([fe80::28f7:d9ee:ff5a:578f%4]) with mapi id 15.20.3890.020; Fri, 26 Feb 2021
 20:07:31 +0000
Subject: Re: [PATCH v10 2/5] sched: CGroup tagging interface for core
 scheduling
From:   Chris Hyser <chris.hyser@oracle.com>
To:     Josh Don <joshdon@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>, mingo@kernel.org,
        torvalds@linux-foundation.org, fweisbec@gmail.com,
        Kees Cook <keescook@chromium.org>,
        Greg Kerr <kerrnel@google.com>, Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>, vineeth@bitbyteword.org,
        Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Agata Gruza <agata.gruza@intel.com>,
        Antonio Gomez Iglesias <antonio.gomez.iglesias@intel.com>,
        graf@amazon.com, konrad.wilk@oracle.com, dfaggioli@suse.com,
        Paul Turner <pjt@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Patrick Bellasi <derkling@google.com>, benbjiang@tencent.com,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        James.Bottomley@hansenpartnership.com, OWeisse@umich.edu,
        Dhaval Giani <dhaval.giani@oracle.com>,
        Junaid Shahid <junaids@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Ben Segall <bsegall@google.com>, Hao Luo <haoluo@google.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
References: <20210123011704.1901835-1-joel@joelfernandes.org>
 <20210123011704.1901835-3-joel@joelfernandes.org>
 <0e91838e-4cca-4c3b-cb36-226c098f36c9@oracle.com>
 <YDTFWZPdmrDuYd91@hirez.programming.kicks-ass.net>
 <e1ee6187-77a7-dbf2-3e14-adba48460f5b@oracle.com>
 <CABk29NvX9_RxpZ71ihR7Y_Nhpg0TpBfdXzehptO52VuwOmS2Ww@mail.gmail.com>
 <c65bde1e-bac9-e6b6-e6c8-78b93f27b8e4@oracle.com>
 <94f43bb6-501c-2851-de32-6f4356b4a480@oracle.com>
 <ef574666-26f4-299e-65c8-2348948651f9@oracle.com>
Message-ID: <238a7db7-3263-a391-3c57-143e9d422351@oracle.com>
Date:   Fri, 26 Feb 2021 15:07:22 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
In-Reply-To: <ef574666-26f4-299e-65c8-2348948651f9@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [69.207.174.138]
X-ClientProxiedBy: CH0PR03CA0079.namprd03.prod.outlook.com
 (2603:10b6:610:cc::24) To CO1PR10MB4705.namprd10.prod.outlook.com
 (2603:10b6:303:96::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.193] (69.207.174.138) by CH0PR03CA0079.namprd03.prod.outlook.com (2603:10b6:610:cc::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend Transport; Fri, 26 Feb 2021 20:07:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 87e665c5-f317-4255-1dac-08d8da9225a8
X-MS-TrafficTypeDiagnostic: MWHPR10MB1374:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR10MB13746F59DB22D4A64B8102A09B9D9@MWHPR10MB1374.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8Fc0d5pcKKDNH/l0We3MqJpxljSoxrNPbMyVD5F009Y9v/KwmObSz3WOZixUxmUwATySBbaLgCcefGuJPGoci8/xOP9qBYxtfHLs7h0XIfrHbEpCtO2ZmSArWsIUy3TUWsKpOq1u67uRYipNQUMtyih2hHWx/PGy/awcJUEFQkxVF37vv5A7esy7hKvohoji3rHgsd9KKNp2ImKEgvniQQOHaEACkaS1A+H7gIKVKeRUjWi+zVLEeyGlufq5mQrv7X73hW2KhdFyfR4PIWhCicllxWEh6Wsimku6ZptGJwAFjs/Rd8Ks2JHso1JD3kRyb4nh11dkDm37yzdN3teJf7EzKsWXFFJrY7THiDJwLZrNrTz7MbxadQkM5+0D3ohTdEaVOEojTnJ+dElILhzoUzR+Rujw/7b+8f0QZuygtZ4osVMRgWtaWWe7xmD5/9zK5ZsOaya/LRAqJNg07rNQbHQNqWHmCqjx2Ev7Ge6Ito8bSYa80IDv5yKDI7wmqQykhNkqRwetY/Me00Fidx/tPCu7inoh2tJIeF72YtBrXWz+2cMD84zIeGzy0FA1K1XhuIQMKx7ihjNYF59iuIC2v8+WBMG2upR+80wBR7BGnsY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4705.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(136003)(396003)(346002)(376002)(366004)(66946007)(478600001)(6486002)(31696002)(4326008)(36756003)(44832011)(66556008)(86362001)(31686004)(54906003)(6666004)(2906002)(52116002)(956004)(6916009)(53546011)(316002)(7406005)(83380400001)(7416002)(8676002)(8936002)(16576012)(5660300002)(66476007)(2616005)(186003)(26005)(16526019)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?WVZLUXFLaThLSTd5ZlREZFNGbTJpS3I1a04xVEluNExVM3RVT2cyaVU2THk1?=
 =?utf-8?B?cnNSVnRGQ29lWW1tVWF3QjF3ODVuZG5zVUNBVS9CbERYd0NZcWplT1pSSlI0?=
 =?utf-8?B?Zy9sdHBzK0dhSjBSRkNUTEdCWlE0V09nUmpxVncwbVo5ZGIzVHR3SnZLNXZH?=
 =?utf-8?B?d24xZ1hqOUVQV1F2NW4xcVRpVUYwaDM0dTZPRDlIZjY5elgyVjYxbjR4Yzhi?=
 =?utf-8?B?Z1hsb2ZCS3AxdUJEcldJaG0zaUc5QVpKK1o2cURsVS9waysvYnprL0RvMjZI?=
 =?utf-8?B?ZlJWNzNiVWE3b2YxZ01qdlk2Rjk2RXl6dHdFL1pBdHdaMmlITCtHVHhmVnVX?=
 =?utf-8?B?L3FSNHNNQXlFTVliVjBrdkFIL2I3UVpDUVY5LzZ4bzZla0VGMGM3MWF3ODhU?=
 =?utf-8?B?OFM5MzRLMmNhM2s5RnhGd2k0d2UrVm45UlFVSkFVTjVoNVdWditIR0lvNElL?=
 =?utf-8?B?Y0dXbHYvM3hpNmNFSTU1NXdOUHpvOTBuN3JRZWJ0NEd0TmdZaFlwdTZDYmJR?=
 =?utf-8?B?bytCeWJNcHlETmRaM3h2Vm0zUmcyWG9ia3lXUXFDRmh6eVprZy8yd2R2dWR0?=
 =?utf-8?B?VmtXamlIUjNkYXhiZlBlYkhqWFJjUEtWUGNDOWpsbFJrS01GVTFwZW1tejBu?=
 =?utf-8?B?UTVYR285QnhVTGllZHZYek1OZFduL20xYm1oZXFOVkY1ZVNmVDBQRkRkeDM1?=
 =?utf-8?B?Wk1mZGp4T2t0SkVNYTNxdnJPa1c3MW5xUGtINDJVR01kVHVrSkxQeDVOUFFu?=
 =?utf-8?B?b3Jwa1RxeFNYR043V0lLL2RzL0hwYkRjUlJzVWloZGRBWnBNMFZoN2Q4a1dN?=
 =?utf-8?B?RFdrbGd4QTdEckE1T0liR29HcnFmWHlVaFNNMkFjRGpTclMrWk9Deld2T3Jp?=
 =?utf-8?B?bVd2L3Z2QncvbHRwRFFmU0FrcVg4alFGOGxKNTZCd2QxUDYrcUJ6WTM2QUo0?=
 =?utf-8?B?T0dwQzRSOXhGRFJzQzhLNUpsQ28xa0N1Y0pxR2xpVnBSQ0gyWU1LQUNoR0l4?=
 =?utf-8?B?bHBvcS96WVVid0NLTDhBbi85dkp4SXpWV0JKMktMcngrSzV6ME9USkg1WjRx?=
 =?utf-8?B?c0lmdXF4ajhzWmZqWU9rSEt5YjVqQXdwcEVJVDZhVEtGMi9odVNwR0E1Y1B6?=
 =?utf-8?B?QVI4V3pjWTVPWFNnZzdjcGZuRmxvc2pCOFcxQ2pqRnR3aFNiWHZ6QUpyb1Y1?=
 =?utf-8?B?c2Jva2Q2UHUzNjRwcTAxUTYzWkd5eDlocWVtaFpqUGdaS3NUYnNmRFpSNm1x?=
 =?utf-8?B?WHZ0QlhSMlh3ZDhHSTZQTHNnWnd3a29HOUtpQ0V5bytncEo0NlNEbkYrdHk2?=
 =?utf-8?B?Y3JDWFJwR0dyd1lXSWYrdzQ4dkRVZUdFQVNsN0JRK0ZwTFpKT1Zjd1FEd3VB?=
 =?utf-8?B?RUc2Y1ZIY25nYnYwOXlrQXlNVjdRWFpOWmFsYXppL1RFNTRCNE5DK0pZZXo1?=
 =?utf-8?B?bkNtbURaQlpTbEZLM0FLRU9xZmtyUkNWbDZjZ1V4OXRGRXpkUEtlOEkrek9w?=
 =?utf-8?B?dGlDQ1FKcFdIeUYvU2xSR3M3a09pMHZqU1owL3BIdXA4UHVwRkJDS1BXLzEz?=
 =?utf-8?B?SWNWNTM4Z2IvUUhpWnRISjh2Z0ZpMWRxVk44VGQxRjRiNHI2K2VkcWhmc1gx?=
 =?utf-8?B?TlI4Kzl2a2tGbHgyNWxvYUpweWtNbFY4VEdQZ3cydGVuUDdMMlJqNkJ2ekw1?=
 =?utf-8?B?eEdwMnJXNXNZL0RpajVjQzRMRUtTSkV1cm9OR0dSbVY5STNmWGNvdHcvL1FM?=
 =?utf-8?Q?6MGU3neKYraPNCr6ejmRgDG+Ls1V/osEsodSiNn?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87e665c5-f317-4255-1dac-08d8da9225a8
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4705.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2021 20:07:30.7259
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h7ArH9j2xnfq+1yKuL/PL3giRqnVjVW7f5QQoy39ItZl7aeHM8ZSfYG2Kh32SKTRwlDNtAUJVJNMY/YmGfngCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1374
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9907 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 spamscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102260148
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9907 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 clxscore=1015
 malwarescore=0 suspectscore=0 impostorscore=0 phishscore=0 mlxscore=0
 spamscore=0 mlxlogscore=999 bulkscore=0 priorityscore=1501 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102260148
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/24/21 10:47 AM, chris hyser wrote:
> On 2/24/21 8:52 AM, chris hyser wrote:
>> On 2/24/21 8:02 AM, Chris Hyser wrote:
>>
>>>> However, it means that overall throughput of your binary is cut in
>>>> ~half, since none of the threads can share a core. Note that I never
>>>> saw an indefinite deadlock, just ~2x runtime for your binary vs th > control. I've verified that both a) manually 
>>>> hardcoding all threads to
>>>> be able to share regardless of cookie, and b) using a machine with 6
>>>> cores instead of 2, both allow your binary to complete in the same
>>>> amount of time as without the new API.
>>>
>>> This was on a 24 core box. When I run the test, I definitely hangs. I'll answer your other email as wwll.
>>
>>
>> I just want to clarify. The test completes in secs normally. When I run this on the 24 core box from the console, 
>> other ssh connections immediately freeze. The console is frozen. You can't ping the box and it has stayed that way for 
>> up to 1/2 hour before I reset it. I'm trying to get some kind of stack trace to see what it is doing. To the extent 
>> that I've been able to trace it or print it, the "next code" always seems to be __sched_core_update_cookie(p);
> 
> I cannot duplicate this on a 4 core box even with 1000's of processes and threads. The 24 core box does not even create 
> the full 400 processes/threads in that test before it hangs and that test reliably fails almost instantly. The working 
> theory is that the 24 core box is doing way more of the clone syscalls in parallel.

Update:

The clone syscall stress test I have is causing a deadlock with this patchset when
compiled with CONFIG_PROVE_RAW_LOCK_NESTING=y. I am able to get stacktraces with
nmi_watchdog and am looking through those. Josh was not able to duplicate the
deadlock, instead getting an actual warning about kmalloc w/GFP_ATOMIC while
under a raw spinlock in the function __sched_core_update_cookie(). When I retry
the test with a patch Josh sent, removing the kmalloc() and thus the trigger of
the warning, no more deadlock. So some combination of CONFIGs, timing and
function calls seems to have found something in this LOCK proving code.

-chrish
