Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DC3E33DE5B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 21:03:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240762AbhCPUDG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 16:03:06 -0400
Received: from mail-bn8nam11on2053.outbound.protection.outlook.com ([40.107.236.53]:62305
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233502AbhCPUCn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 16:02:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aiA4BAMfWwoS4giVBLAAHcLfH/lFqh66RV0keH0aanYJVWxd0SMA78YkLqe2GPRItOeOAIkh1bUuI4RBoWxF8AOUM9FkqZNJO8KPSCFjsuAmD20wX4fyUUCiF3fmfQsl4pqYyKMT34ROFiqzxh4EjaL12paCU63OUi80omxN5QL07rwNkHUnkt4gwrwEoIXHQ9YXAHhjWUkR6g1lKK8FoxPBow2Q6svDjXXC81doWlShGWI34xpSg6Q0sX+8hxW4H+LKo3TzrcjZsIFdPRM2a8XDPLilo4vB1DPu/FUgldkWm3CLFcKlYxOEUCdgBEfWx1j9BE8ru7eOoPP36DG9yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jSrSlfP4zsD9Ipu4aAG5iGNjP91P59KiBoVqIOnA7Pg=;
 b=bBVS8W+k1p9I1jKHewY0EOWvbOa1HiazbcOFT9niWRNWconV7lSZFGSOhTct2/FmVh/FY2taIxiPKQ2uJVJufz5x30qnN2q4k0wFA5HFQVeKwLSIbV6lC9/OYwCrSjxUruyMBeYoMEq2TmISpgCE47WHghLLYGQLmzu2QQSja9PE1Pi9PBXoJzAHUADm5S78Bxd2og5iMU/xYLvMOf/7FEVUzVn0fs2hHkqIneZhp04s6H0ZhLRz6RbdPUJsae+zRbLdgNc7ihE2VORXCZDYKnhTQZOXjRLOT8li9n5xUmcGUupBuFz3/fWH9lO7V2V9owdlGApJaS3AYnA1Rx8TBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jSrSlfP4zsD9Ipu4aAG5iGNjP91P59KiBoVqIOnA7Pg=;
 b=eFinDKiVdR+zj2bjVOM6LzKet9JSn8TD6CjbvDk+4NQL8cHF0+dSKpKdvy5ci9Zm6E+gFm5XfcNXMRWfGkCxotHhyRBYC8ppaL9PioFDzXNcWKfTSpD9KyJq+UjaLtL5tWZDLEFAXTFjURI4K7lKly39kF0wqP0dpnptelyG5dw=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3505.namprd12.prod.outlook.com (2603:10b6:408:69::17)
 by BN6PR12MB1585.namprd12.prod.outlook.com (2603:10b6:405:9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31; Tue, 16 Mar
 2021 20:02:41 +0000
Received: from BN8PR12MB3505.namprd12.prod.outlook.com
 ([fe80::b136:f10d:4e30:ce4c]) by BN8PR12MB3505.namprd12.prod.outlook.com
 ([fe80::b136:f10d:4e30:ce4c%5]) with mapi id 15.20.3933.032; Tue, 16 Mar 2021
 20:02:41 +0000
Subject: Re: unknown NMI on AMD Rome
To:     Peter Zijlstra <peterz@infradead.org>, Jiri Olsa <jolsa@redhat.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Tom Lendacky <thomas.lendacky@amd.com>, x86@kernel.org,
        lkml <linux-kernel@vger.kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Stanislav Kozina <skozina@redhat.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Pierre Amadio <pamadio@redhat.com>, onatalen@redhat.com,
        darcari@redhat.com
References: <YFDSSxftYw9tCGC6@krava>
 <YFEMpo6GxxJS9Wvl@hirez.programming.kicks-ass.net>
From:   Kim Phillips <kim.phillips@amd.com>
Message-ID: <36397980-f897-147f-df55-f37805d869c9@amd.com>
Date:   Tue, 16 Mar 2021 15:02:38 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <YFEMpo6GxxJS9Wvl@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2603:8080:1540:87c:9f48:efb1:7c44:6c23]
X-ClientProxiedBy: SA9PR11CA0013.namprd11.prod.outlook.com
 (2603:10b6:806:6e::18) To BN8PR12MB3505.namprd12.prod.outlook.com
 (2603:10b6:408:69::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2603:8080:1540:87c:9f48:efb1:7c44:6c23] (2603:8080:1540:87c:9f48:efb1:7c44:6c23) by SA9PR11CA0013.namprd11.prod.outlook.com (2603:10b6:806:6e::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend Transport; Tue, 16 Mar 2021 20:02:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 601d08bd-4097-44a0-83b9-08d8e8b674ab
X-MS-TrafficTypeDiagnostic: BN6PR12MB1585:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR12MB1585828A3DF823E3A0750A65876B9@BN6PR12MB1585.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1Q40OYWRpqIaaji8Uj0EDdJ4JbHgKSRvs3/shQcwS0ntO5vWHEzd4hkPOMNvdnLgjKKFKkIzoPg6umSxYZP/BUsPXTz6EkK/kFRPlQKmZlbyDroFiD6ZOxvNWSLcVpuL7Xa5xjSK2Bp20m5R8SDznOKDAqEcKUTnFv2yzlP6ZckihrPp6L+hEV50YiMtR/Z8KvIyB3KVa/4cT4R0H2lBo22Lrjt7pJOn89K5VKlSYBm70109p71lpxpMMxu1LqfnHJVjJ006SWmQNbx5cVVKUG17U73CiI7ArzNZ8j4aegZR0DSlg9oJmh3T5cjuQE8JnG6oQoeQoLw6Mno3By14TMDMywY5IqfCLGdXm0Cc2gGxa15s/LLMdPTfSTGTnLRnEzDWGOKnAoA5gRnIco8jBZ6oMOUyrQYEVtwBycoMJ8n2EqOUcNu7BYuYlYRYJC+WxnCpTSY+jqGBnIgAV6PCMkzxQyYqPw1p+EvCT0hQkcI/Ierjxu3ejQtK61SSe8ENMW/gGQfxyaKePnR/qFE0mdlcL2SdYl+U1BluYYBqjv21LA9BEo46oAB9nXy9aR6ZPXbl3tg0wIEkxgs/xdZg5uya5hUhhLzbZ5H276W9k7rFMMUdYQaJY58P41xWCnVAt9VWNEyMpIiM+TEUq+/SISB3FqotN7vtgQ2A/RWI0hbjJdrgozYekRt56DbE6ntAGD5mRYf+9s6fXu6bgX/ffjhNTNy7JNYyDGV11JdcE6DrElYFvGtFDwYwVblrBPwGjp+yIK5olkGTmEiXqvANdg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(346002)(39850400004)(366004)(136003)(31686004)(316002)(66946007)(5660300002)(66476007)(52116002)(66556008)(16526019)(8676002)(2616005)(110136005)(54906003)(44832011)(8936002)(966005)(4326008)(2906002)(53546011)(36756003)(86362001)(31696002)(6486002)(83380400001)(7416002)(478600001)(186003)(45980500001)(43620500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?Windows-1252?Q?jxaFS61nma/3op8Y+Dlt5oK11nwTCgY71+6jSJ7YOPoCNrwhkO+meDUD?=
 =?Windows-1252?Q?x1OAcmMfKxHGlHjTPJMDrtEsrPdulHFwKTfh1CXRChow/TZW48nCTBJR?=
 =?Windows-1252?Q?yhWWq7+QzSRHsf8QZMLMO4vn+M/7f9+1hnlT89hjqaKGe29TlteVpScL?=
 =?Windows-1252?Q?WAzwEISi2d9/Z5FboF7bs4Ru5BS7fAB/zc5po7lUwNtRi8EBQ0BrwqHY?=
 =?Windows-1252?Q?JFH8ls5Mm4ObBWvYLxblTG5UTohGndvZV6CzCmblARW8sHi4Au1GvDqq?=
 =?Windows-1252?Q?EiDoLMMfUyxulJPYEncnBPkhO0/lgn6yv69Qx3CmdfJN3e/EZqGy0LT9?=
 =?Windows-1252?Q?9P8Y47PD+OLhC+nPCX38vwskiuSazlqaljAyQEymfhdXc8GgKdCU2dRa?=
 =?Windows-1252?Q?H5hxrFWh+4YcmX1mLv0IOG1nXBbXB0js6j0lKj0SfPxgOQZ460yB8Ter?=
 =?Windows-1252?Q?JzEKDiGwjlG0SMEqo5lSN7XD6Ci8M5nfbYMX6cSF0yMwYXRSAC6dzrg3?=
 =?Windows-1252?Q?wJzqffbVhjQAkLUj+L4PM4C02w7mywa9blt4fbYhF3VM7gMcwcvDr6Df?=
 =?Windows-1252?Q?2n6VosjGDomHf+p7v/Gie90oyyvu45xlFfuYiaKkYdyVG7yYdsDMXTmq?=
 =?Windows-1252?Q?nOpfBGI4OIK3BC8uTd5va3HN1GDVjjZEyBPmHm7m4ixhFde/MC1qOacZ?=
 =?Windows-1252?Q?ESenWDGAwCm5QzWg1J+u2A9/2nw6QsVWCDqveI29j1zqV+S1ETUrbhCA?=
 =?Windows-1252?Q?uvjNTQiY5DrkNwVPgmeMk1L57CK/ajh7ykoYcVfCCyKQVvvGHkOKkT+X?=
 =?Windows-1252?Q?5G6udPX8kQAVr1BHwCXVuGrASUka4UDgD/dLZrZ5KqKNCz6PmG2ie1xF?=
 =?Windows-1252?Q?6XJLqDU91k1qKGJwNVuyKBQ4w4+ztrXoU89cybdV7iPto44SqhZ21h6M?=
 =?Windows-1252?Q?TOFfsYl8yUv5BPCTQEctG65MTZ4nDdcMOFep4D0ePNhjeac1BIuuk1y2?=
 =?Windows-1252?Q?86ZqLaBCnew81bORBgqiFETtAOCe8UPqYRGDjcDrTlrFPguhgk+wi1eD?=
 =?Windows-1252?Q?+JflK/HqpWHyt9oTWttYUID+DAsfLVXQj86M48uBNX/OgsYtjmyzgLeP?=
 =?Windows-1252?Q?pFnyoCAu40XjWhgWu3RLxMz8T/yGM8rYmffHTnh6JqeNv+0+SA6ohz9l?=
 =?Windows-1252?Q?7YhbnOw0PJKNdPovoCB1jWF7woPW5BJdYoWV9vA4CtHtWY45gL2yEQrp?=
 =?Windows-1252?Q?l6oZNR8sPQ1ZA1gIO2z0iLY9CKCgKaVOTxfv4joXmUw2gKYJgjc+LdKZ?=
 =?Windows-1252?Q?8gu0T23YFugbz8352ZB/578/Jm74IMNQjze0rf/b+q8yaeoKbdCNXXRD?=
 =?Windows-1252?Q?uit57yNFzzDldV+lCETVHKYcqAqOaZj67pGLGX3NsHei5cdZLZg4W6q1?=
 =?Windows-1252?Q?mx2huYRk26Y2SjPPum/DSsni5/ptpDIHEmuZNfkKXT7hZjFMQMtjJQzK?=
 =?Windows-1252?Q?N7CN4m7U?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 601d08bd-4097-44a0-83b9-08d8e8b674ab
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2021 20:02:41.3623
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VQDNp4weKZk5B/BxN2JMwyzfi3sas4o2tlfKjjeQ4elyS/4iXW851T1Z5jDaP9QMiwE3y9VxXKi8AqjaP3mR6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1585
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/16/21 2:53 PM, Peter Zijlstra wrote:
> On Tue, Mar 16, 2021 at 04:45:02PM +0100, Jiri Olsa wrote:
>> hi,
>> when running 'perf top' on AMD Rome (/proc/cpuinfo below)
>> with fedora 33 kernel 5.10.22-200.fc33.x86_64
>>
>> we got unknown NMI messages:
>>
>> [  226.700160] Uhhuh. NMI received for unknown reason 3d on CPU 90.
>> [  226.700162] Do you have a strange power saving mode enabled?
>> [  226.700163] Dazed and confused, but trying to continue
>> [  226.769565] Uhhuh. NMI received for unknown reason 3d on CPU 84.
>> [  226.769566] Do you have a strange power saving mode enabled?
>> [  226.769567] Dazed and confused, but trying to continue
>> [  226.769771] Uhhuh. NMI received for unknown reason 2d on CPU 24.
>> [  226.769773] Do you have a strange power saving mode enabled?
>> [  226.769774] Dazed and confused, but trying to continue
>> [  226.812844] Uhhuh. NMI received for unknown reason 2d on CPU 23.
>> [  226.812846] Do you have a strange power saving mode enabled?
>> [  226.812847] Dazed and confused, but trying to continue
>> [  226.893783] Uhhuh. NMI received for unknown reason 2d on CPU 27.
>> [  226.893785] Do you have a strange power saving mode enabled?
>> [  226.893786] Dazed and confused, but trying to continue
>> [  226.900139] Uhhuh. NMI received for unknown reason 2d on CPU 40.
>> [  226.900141] Do you have a strange power saving mode enabled?
>> [  226.900143] Dazed and confused, but trying to continue
>> [  226.908763] Uhhuh. NMI received for unknown reason 3d on CPU 120.
>> [  226.908765] Do you have a strange power saving mode enabled?
>> [  226.908766] Dazed and confused, but trying to continue
>> [  227.751296] Uhhuh. NMI received for unknown reason 2d on CPU 83.
>> [  227.751298] Do you have a strange power saving mode enabled?
>> [  227.751299] Dazed and confused, but trying to continue
>> [  227.752937] Uhhuh. NMI received for unknown reason 3d on CPU 23.
>>
>> also when discussing ths with Borislav, he managed to reproduce easily
>> on his AMD Rome machine
>>
>> any idea?
> 
> Kim is the AMD point person for this I think..

Since perf top invokes precision and therefore IBS,
this looks like it's hitting erratum #1215:

https://developer.amd.com/wp-content/resources/56323-PUB_0.78.pdf

Kim
