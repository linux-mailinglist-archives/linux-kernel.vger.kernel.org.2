Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09FB6311408
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 23:00:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233039AbhBEVzq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 16:55:46 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:54332 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbhBEVyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 16:54:45 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 115LTdhH092587;
        Fri, 5 Feb 2021 21:53:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=4/pQYpsH8JyeIeX1UHPzpqox1tkV/hiuCoeLAuxkjBM=;
 b=eHoQHbnBglmQ+EyXd5/i7SQcRJ7/d+G8teV3mvG9XY2dt9AwMUDLyqfVa+CK278K9lnr
 /KRVSBU4TzlA4x3/cTQUcquKbBK+K1q9FePQ12Q/aRyvD0DtR3zjEiZQFgF60tiBRsF6
 TcJJpVtgh2F/sDL4cgVqhZyO0qUnMmkGJGvEptBmAL1pY8Q9FPgSDWLeV2o0CCJP1nxy
 5n+pBz9vlsy8h9Fq2nrBVHgEyZpwzhwfLR4VyfpuWuVV+k0KfUTH2mjl7drBJwDi1Pup
 5fmVHwAUyH3TybkPAJXfXhit4ZJo0RrYOyxcRYWeTFc79b7sHNvSvf7PXfwv1UosV9R3 Zg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 36cydmb78j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 Feb 2021 21:53:38 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 115LVPA6187537;
        Fri, 5 Feb 2021 21:53:38 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
        by aserp3020.oracle.com with ESMTP id 36dhc4rh16-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 Feb 2021 21:53:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JGsDMEua0kJjNjjmkqXwBT0fVS3V2nJ+qHu3XrHrnl4aipBxEu7siB7C5aWtQZCjNo9OL0/kNM64/zfMfvmzIKrwBOB0mM2KViRCpJHn7W23P+SVsGw0VTBMeq3pMWboUvDr9etzq23hxmDnYJPCuqHnGq81nVsVP3AmeVy9HP1dOtbI14u5OH0cT41p8Wctws/SdBWp1XxUnaWfZgCyNg8elYl5T+4QIVMKqNeQdaJ1f/m2DfZxwE0sp5mLDr5z6yTrtEfWM5mePKPLx0LNBtPQxACzmXKqYlf6U+ROfhoX8+3xfFaRbb1+MhyhDLFvnqp17S4/WZq0pZbIuTUJog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4/pQYpsH8JyeIeX1UHPzpqox1tkV/hiuCoeLAuxkjBM=;
 b=Np2EHlUMG1EjFD3Ww66zlV7njwjuiI+cJYgKAI6ZuKiq9YxHVnCyBO7ECZ9yeojsc4MLDSjT12lCz3ONUmLGEPzrQwVTwJ4xIcyPdzGdMlLOwkkaqw7FWUtEt71pSbMWWHTqOAY9HUh1K8YpFYfhFaVnzxbv8RFnQQl1csbbPJyxjG0pF23cFpAsRxotSBlH0afpAWLBEKUC5VmdZyDs+R8g4Zs5rxwP4xdEp2aR0p6LXGp4rAykGhbMWL0gThZ5STnvIvzbVrhPEtmgIeby4crxiQwPJ+++MwsPt+IZ8Oj44BfLzn7MogzwrKp8vESl9aifql6O97qyYDvf0/jFqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4/pQYpsH8JyeIeX1UHPzpqox1tkV/hiuCoeLAuxkjBM=;
 b=wxLRz0VRooKuovOhEIdtUy+ONnZkkQWhGGNRnXZFpqruMEMAlGn9gtKoXdThRbn2I6duXiZqA9q8Ibz6LRX9g1bC4MtHqmfVRC3G+C/bjLDThbOoamKloIU73uw7Ltw2nV9Rgbew2fB3lMZo97oQpHi2HahOJeRtmcnELDgj8a0=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR10MB1389.namprd10.prod.outlook.com (2603:10b6:300:21::22)
 by MWHPR10MB1694.namprd10.prod.outlook.com (2603:10b6:301:9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.20; Fri, 5 Feb
 2021 21:53:36 +0000
Received: from MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074]) by MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074%5]) with mapi id 15.20.3825.020; Fri, 5 Feb 2021
 21:53:36 +0000
Subject: Re: [PATCH RFC 00/30] userfaultfd-wp: Support shmem and hugetlbfs
To:     Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Cc:     Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Jerome Glisse <jglisse@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Hugh Dickins <hughd@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>
References: <20210115170907.24498-1-peterx@redhat.com>
 <20210129224938.GC260413@xz-x1>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <339d27e8-9f34-3e80-2910-46f46d58e9a6@oracle.com>
Date:   Fri, 5 Feb 2021 13:53:34 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <20210129224938.GC260413@xz-x1>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MW2PR16CA0032.namprd16.prod.outlook.com (2603:10b6:907::45)
 To MWHPR10MB1389.namprd10.prod.outlook.com (2603:10b6:300:21::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MW2PR16CA0032.namprd16.prod.outlook.com (2603:10b6:907::45) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.17 via Frontend Transport; Fri, 5 Feb 2021 21:53:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5c1acd7a-5c86-45e0-b6b3-08d8ca207d00
X-MS-TrafficTypeDiagnostic: MWHPR10MB1694:
X-Microsoft-Antispam-PRVS: <MWHPR10MB1694618315B4B16AF838C678E2B29@MWHPR10MB1694.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KP3Uur86h3GyPPOP6iwL980iIdww0NVzlmzofz+TnBp4V+h84/FexL+QKZbGb/vJKWvs2gFZVTl+2A2EijJfd1di7zkRFYa5SUVD1Vbv13Naj7SDE1JwZNApRL0PqPLkZkpoX4KqYEyNq+mri5OxbDfwNInCCm9/EEPfD9GADvA6n273o6ZhbA8zIFcAcn2ckHzSSUcqB60zUeU5CqEjIkDJG9HNwD+tEqz0MSwfb/1INuyywZWiHOJJHn6oItw81WK4sCBnmQ2J0t0QhjnPDAh7l+C5kIgyUuBduGlwNYaipHKjpJlJcZfh0LhOnDf5fDUFzo/7TzmrbyfgfCqFmV0orFH4Dq2I93vOppa05pAl6AjYao+tMI9RxMkXvlPL9EXjcRE1KZRsYnohj1uD+GvKdJZg4r52Vt+CtbJZ/iWRa4Pn1QXZR/iyVxwRvcK2NcrDE2e6y6Lyy3jnSOpKZrrJpCY9T0glWHgCnNjSVzCtnFsDWXCwSKHo37+YbwpOhFZNCePEnSgnT7utiWlLLyRp7tNIa9X1ae+1mgRqewtNinsy8cOLRTGuHq6uAwCiLZr1Xb/Z8rU7+3V/Z+CTNODzrP9GMjs7ylaZxYYQ2sI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1389.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(136003)(39860400002)(346002)(376002)(4326008)(186003)(316002)(66556008)(31696002)(16576012)(66476007)(83380400001)(66946007)(16526019)(478600001)(6486002)(2906002)(44832011)(26005)(52116002)(7416002)(86362001)(8936002)(4744005)(8676002)(54906003)(36756003)(2616005)(5660300002)(31686004)(956004)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?dkhvRkYxOUdZanZVS3hjZVFxWCtjRndGRnFFWTlWOXAwaWJ4N1R0K0FRd2lp?=
 =?utf-8?B?ck1sY2JWYndJZGw1UkxIcWRvNmZrUTkzN0JxeHhZcFVBWCsvS2VwQVU3VkE1?=
 =?utf-8?B?ZHc0dnllVUpDSlhDUDFQMVNXd2ZwQ1hhSGkwRHlvV3BKaUw2S0hDSWZIZ3VF?=
 =?utf-8?B?eGRQQlRzY21zb3NRQnRLZFlWWDBmUysxbzliZG14ZWdUS2IraUh2WTdWeUVm?=
 =?utf-8?B?enI2cHVOakRTQ3RKc05CbTZ3VVlUblMxMlArYnpTaXcwRVMvRWVZaHBDei84?=
 =?utf-8?B?Z2hvSU5kMmQzZU5DT3VwSFY1cGVIREZ0djJnamMyOUZTZFFDdXdsUXhtRWNa?=
 =?utf-8?B?WDY2ekNTSFRxWEFiVlpuV2lrYmtmeGQ4a2ZoZURPU2ZTUE5Da3VQNWNMTksw?=
 =?utf-8?B?YVRaclZ1bC9xSlJsL0dOMzVoM09XR2lOeE51KzQzSjQzY1BWbHptODhBUVRr?=
 =?utf-8?B?eVQrNGxDMURMeE5JUlBVZHlNTW12bUVxYzJEOTNIbXVhVDAzYjVDUmdEM2Nm?=
 =?utf-8?B?aTlkdlpUMDZOeG83VzhnZnBBWU9yb1Z3Y0NPWm9BMGF0RGpVb2Z3bWZmU1hI?=
 =?utf-8?B?elV0QXY2NE54cWRZMVNsVXR5d2tYZzRRN0lITUs2cE1HeGtGakY4b3pCWklx?=
 =?utf-8?B?cnQ4bXBrcmJNSmhDYjVNUitrZ3ZtNFllVGZjeHVtU3phRTVnWWprMkExUEdZ?=
 =?utf-8?B?b1NIRGdwOGJpQm9IeTdRQjA5eVpESFpkMHh5a2tWYWdnWmdoWlIxYzFmM3dY?=
 =?utf-8?B?OHBxWXhXakRvZ0duZHoxeFlDVmJUVjFoYm96MjdMdVRvL2kxN2xubk9MaEJT?=
 =?utf-8?B?RkhlUHg3d0JibjZPWVhsQlZRY3pKYUhMdVR6NXFzQ2xKam1nZ2ZUdUlFRGUv?=
 =?utf-8?B?QXdkeFQrNWxIMi9reUU3R29XaU9OWERpVFRraDd4d09KTlRYN3FiWkkrbUVx?=
 =?utf-8?B?QTdCYWpiZk9Ud2VyT2oyM2J2SFlHNzJ1U1hpbUhSOGllclV4YTRUajlIeEYz?=
 =?utf-8?B?ZGlhZkRDQURJc2dPNGxwTitlOEJzNjVQdHB5NlNhRmdDMjNibm9YaUtPa0FB?=
 =?utf-8?B?Qk5VeG83UFpKWnViaEttMElpQ2VFSzNycDVUM2RMVjI3TDhuLzM0ZTYwWEVa?=
 =?utf-8?B?L2JQTzQyeUR3bUFLa05SZFBQNkQ2dzdhTVRkZ3B5bVpRamxuQVlWTzErcE15?=
 =?utf-8?B?UEw0dHB6c1dLYVdja3FETXRuMGRmTEtBbFlQZWZWbFlFQVozZlZsK25zUW5t?=
 =?utf-8?B?czhvRkJIRUZ1cVludXZQMi9lNGZ6eTUyT1ZsTDJ5WW5IMk1xYjV4bGxLT3ZN?=
 =?utf-8?B?MWZJS1VtSWdBbWJrN0RVYWFOSkdoZVFjZTlDY0x1aW5zdC80NGRVSU84Yit0?=
 =?utf-8?B?UWdmYmZpRk9QZzVpdmNVdFBpMi9LYkZIUk9uZkZqMWRHYlRNejNTcnZZQkcv?=
 =?utf-8?B?WmcvaFo1RGxrZ2F4TnA2OVRrd2pGeVYzaUZYcUhId0xTazhueVJnRU5CcTR4?=
 =?utf-8?B?dE1YenBtZjZsMXR5M1dUUkxtai96TDBLam9WMGVVQTJuOFF0a29LcStMaDVN?=
 =?utf-8?B?OE9TdGV4T3lzTXBCOHpOUkpSN2F5b2tvOTgwUEM3aEg2RHNrMTRNTms5VGVU?=
 =?utf-8?B?NVhiRkVNMlR4YW5Lemovd09SOUlLMWJOVmZIaXArTUNyRmdrRlFVOHJTSHFh?=
 =?utf-8?B?bVd5RjY2WEVUWDBsWUNsVVdTMitkb3paLzdRbXpmOVR5UXhySHdsQXNWS1l1?=
 =?utf-8?Q?3ZFUSasvnD0tzQPeesTTuoKlT87or18SygZ1hYc?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c1acd7a-5c86-45e0-b6b3-08d8ca207d00
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1389.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2021 21:53:36.0816
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GErJtdwbwVGHlixwTo1PDRkZNlZxfhJkGliU/uvdk4vUD4Rgbaz0lnP7ENqG2MwIpJMTgz19QDLctPiqcSpP0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1694
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9886 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 suspectscore=0
 spamscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102050134
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9886 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 clxscore=1015
 spamscore=0 lowpriorityscore=0 phishscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102050134
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/29/21 2:49 PM, Peter Xu wrote:
> On Fri, Jan 15, 2021 at 12:08:37PM -0500, Peter Xu wrote:
>> This is a RFC series to support userfaultfd upon shmem and hugetlbfs.
...
> Huge & Mike,
> 
> Would any of you have comment/concerns on the high-level design of this series?
> 
> It would be great to know it, especially major objection, before move on to an
> non-rfc version.

My apologies for not looking at this sooner.  Even now, I have only taken
a very brief look at the hugetlbfs patches.

Coincidentally, I am working on the 'BUG' that soft dirty does not work for
hugetlbfs.  As you can imagine, there is some overlap in handling of wp ptes
set for soft dirty.  In addition, pmd sharing must be disabled for soft dirty
as here and in Axel's uffd minor fault code.

No objections to the overall approach based on my quick look.

I'll try to take a closer look at the areas where efforts overlap.
-- 
Mike Kravetz
