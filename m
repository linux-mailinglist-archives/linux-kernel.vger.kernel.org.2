Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37AB9339552
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 18:45:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232628AbhCLRo7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 12:44:59 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:54722 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbhCLRo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 12:44:29 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12CHdbcw089515;
        Fri, 12 Mar 2021 17:44:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=NFZUcEMw9uakXLZLEwiIKTeCORgFOWHRRLz+Pmk3jJo=;
 b=QNgjYZ79zrUQmjEvYGZzF7LVzd3gHxmeOaEytjYOEj1omzdMj3zAhJy2/J6bX/T8eVnn
 ZGC9V2QS7xb2JXfDvSkAxqYAc+rxRvcyC1GNuvOTgfpEjQe7aRdBW7YXRb909DYgk9xm
 0umWBgLtIP2TEK7KwFkrNa8LDa6qvd8HesF4qSsmbXqgcdA5wHk6SURdBmlHd7lCJ3sm
 MR4tyhxXFfFnA70k1ysQ0auh89EfcRhYgNAamaIVvGJM2vxMYYH7ajFP1pe4Njl6Bae2
 bzrnDLYYILcCKbxrIVMs1vRDkPnhvLR+GGoBmgQwQ5UlRwX9U3kl8tEZwPT7rDGa2FZX Lg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 373y8c2tv2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Mar 2021 17:44:01 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12CHZTce101864;
        Fri, 12 Mar 2021 17:44:01 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2104.outbound.protection.outlook.com [104.47.58.104])
        by aserp3030.oracle.com with ESMTP id 378cb4j00x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Mar 2021 17:44:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UvBKwEatCc1//X9ST/6ijlH+Kcu+8N1GPNjffKn3E1lggioDBCrurFOFFvV6xKVh++2szvkuWEYHfyhXodsktDx+VgNFHZ7nLkkCn+Y+xYzYc3skqZ2SvvxK4uenvBQqP37gb3CPfS3M3CkoAdALRnqZZ6LabOdhDfzA7f+QeVb5BkXV3cCNbE5MIB5AGazfkyFPrElzC77hmMNHAMi8XVbT4qBsTYlQqqch3Pb1IMUW7OvjuL2DVpMCoz6ElPBm5FuDtB+Pfk52mdMZrKzsNCBig4jf1uVNMKJ4Wr07OpzcLaaCZLGGoaK0hvPa/ieCTKM6jmC72Li2r1eQCOmJzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NFZUcEMw9uakXLZLEwiIKTeCORgFOWHRRLz+Pmk3jJo=;
 b=U6J2Z18oMfv5QSXvPt19yZYa1AEVAnT6uuMaKeMS1JpnszOYm+MyZ3Uiz0BpesxnG7anOSV7/qSWvAni30+Q3Lm9j5qn8zvhKEId28CscubK7Wfdc9Zc9+YujtmHumaz45UNzOsKeYrtus4YqU5cPn7w2FfyC09+r47DYw/FWmHrm7KctN7WHAxXpJbbKIG/00ZxiIWCfvOV+CKiG8K56iNCWbebZPAeU9g6PPaNqRaNsaBnPl02qWXborRBnuFMMbr97HlZ/On02XowXNMPCsFu9DUT8bhIreBvSpXnuIUoYd89Udjy63gi54ecI5Xv4unqupTq29i5/wki/dBYeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NFZUcEMw9uakXLZLEwiIKTeCORgFOWHRRLz+Pmk3jJo=;
 b=QLo17JicF25Phx0tBS7u0IoV68pIyc9nIG28GqWtNbrbMUAaBeB7MKa2zze9nziVxYUSkl4ZRz6Z5dyq0iFxdWrrnTieFgRLt5aq+og6fwOSdKM0aL0JlKOVWrCq2gBbw3U4IqVtu3evns5vOEWXgXw5CJ+81tmObYPO9W9HeW4=
Authentication-Results: amazon.com; dkim=none (message not signed)
 header.d=none;amazon.com; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BYAPR10MB3159.namprd10.prod.outlook.com (2603:10b6:a03:153::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Fri, 12 Mar
 2021 17:38:21 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee%8]) with mapi id 15.20.3933.031; Fri, 12 Mar 2021
 17:38:21 +0000
Subject: Re: [PATCH 0/3] Add support for free vmemmap pages of HugeTLB for
 arm64
To:     "Bodeddula, Balasubramaniam" <bodeddub@amazon.com>,
        Chen Huang <chenhuang5@huawei.com>,
        Muchun Song <songmuchun@bytedance.com>,
        "will@kernel.org" <will@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "david@redhat.com" <david@redhat.com>,
        "osalvador@suse.de" <osalvador@suse.de>,
        "rientjes@google.com" <rientjes@google.com>
Cc:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "duanxiongchun@bytedance.com" <duanxiongchun@bytedance.com>,
        "Umesh Sargur, Gautam" <sargur@amazon.com>
References: <20210310071535.35245-1-songmuchun@bytedance.com>
 <3eae8b3e-d6e0-83c8-e9c6-5420767788d5@huawei.com>
 <ED06294F-F046-4B21-9E52-F439C2B32B45@amazon.com>
 <aa3a5951-9dab-d1e1-8257-3569c269e3cf@huawei.com>
 <FE02DFEF-9706-4CEE-8949-89BD13C2AE00@amazon.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <e7ec1e95-5aa9-0147-46fa-91cda70fd4af@oracle.com>
Date:   Fri, 12 Mar 2021 09:38:17 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <FE02DFEF-9706-4CEE-8949-89BD13C2AE00@amazon.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MWHPR11CA0019.namprd11.prod.outlook.com
 (2603:10b6:301:1::29) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MWHPR11CA0019.namprd11.prod.outlook.com (2603:10b6:301:1::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend Transport; Fri, 12 Mar 2021 17:38:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 037c173c-c396-4532-457a-08d8e57da0c4
X-MS-TrafficTypeDiagnostic: BYAPR10MB3159:
X-Microsoft-Antispam-PRVS: <BYAPR10MB3159170B20E719487FE32D40E26F9@BYAPR10MB3159.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +YbxKNfceqTng4lCTZY57qokrOrONd/oszrqBW/xEeo9B4wbxTB+XR0m8ACWSR4+5bJQFj+mq/Uio9su4wzDus6TcM+cBxHDlvI9iot/LSM6RY3Y9E7zoIk25NnVd+1JNLB4jZRroqQThKsbApSNl+VffLMydJJWog9v5TnP38AQOVXKkc3KnOtK2y044zUyLrJqkvXAbroZEcTxu3OM+ZqiBtRWLnZ94brFIjosIuRUM6uBj4XSU1WwdlFj6PcaJfO3OZaMB4x8EefpIk1Z/lSIf34pL94FbpYFoeF2Fsd9S1nmbZ+njH8oBrCTbmanLDc7HR1M54zhUPsSmwlNBq6WIQKO/TsVFB5VYh6wjcSuglmZluf6TbFVT7GeHwVhrkE8DsqhQP4o2DVHNa4ljf2duPotNKo+yKaRPOGDXjDU733Ga6ftmYkWxYPtwNz4nIeBmzAwJ4bFma0/ZbPDDJDnVwBPMHdnCIUpu9B71EsmpFDx2stPJUFV64g5o2Ywz0bsZ8/Nc8Q1+jRi24iNLHmJsZ56RfHjQIRj4t2DEY5uZYYy3IdOFh9Y5VWGVMOY1QDeBpuwchdICx3VSa3cdfwzP1Y+p+QpAhceiRWyb4sAaaVlrqHvdYM/nzNrWnIy7WY2v4obqT/LSve8O+a0MD3I3ZdqWe99i5IUPar3Jcg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(376002)(39860400002)(346002)(136003)(4326008)(66476007)(316002)(478600001)(66946007)(16576012)(26005)(54906003)(66556008)(110136005)(6486002)(8676002)(8936002)(36756003)(4744005)(86362001)(956004)(2616005)(5660300002)(16526019)(186003)(53546011)(52116002)(2906002)(44832011)(31696002)(7416002)(31686004)(45980500001)(43740500002)(4533004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?Q2NoLy9oT2VLbEFPaWpNQkdZMWdac01sTW5Eei8xS2xzS29DM0s4Tzk4MSto?=
 =?utf-8?B?RjVZQVFLaU9VdENCc2dONkF2cG1wMlVmSzZhd2hsbmFpTFlyOUxxREs1WW90?=
 =?utf-8?B?NFVRYmJaWTdPOWZoWHRBNlhHYjh2ZjdXNmtVK0diYkdPbXFPa3BsZnFLbSs5?=
 =?utf-8?B?KzhaNDNWSXQwejdaWXB3M0pLSlZ3U2taZ2ZHYXIrYTB0aFRlcXNqTUFtZHJC?=
 =?utf-8?B?LytKS3FudDVQY1I5YUZTL0dVME5RckRPNjF6QmZ4dTlpNCtBZTBCMzNMZDd1?=
 =?utf-8?B?YlRjZ0ZpblRxTUJXNWQxMjlMSFgwTGpBd3F6K2hJckxMTGhNZXFWaWZmcldp?=
 =?utf-8?B?Q1oyN1ovREN5OG1jSTlhTEVHb3ZnUFdhelNGOG03dkFPMDdMZXExRGszanNB?=
 =?utf-8?B?RlRKclFOQXlmZ3EreUdqS1FBaGFpMncwam9obTU4YWMrdmxScnN4QkQxMlFJ?=
 =?utf-8?B?U29kS2x0T05XWGExT3JISXJ3Nk5tZlpwRHI2OGFSZk9GQ1BTN09Hemx2aUVE?=
 =?utf-8?B?Mmc5WTcybnIyVFZFaWxrR1lvVUdHaWZTYnhOYTdJUklqeGJneGk5dm9vWG9o?=
 =?utf-8?B?MFhlWlR4UjN0NDFEZm5rK2ZTNXFrQStPUlM2STIrek9QOVNjcGpFcmV3dGdD?=
 =?utf-8?B?Nm5SeDRkcGN0ODlWSEc0ZXFJUWlpUG9jcEZrWGtLWmVnYm15VFlrWGNyNndo?=
 =?utf-8?B?VVVKMnRpdkNRcjhoNURyM0xuS0JrR1BSai9oQmpDZFdWZ0E5cVljMHlYdzdL?=
 =?utf-8?B?UGRlOTNaa004Tms4bUlZcFNyYWRyN3dScG0xZlI1bHF1MnFHSVhCdDdDN1VL?=
 =?utf-8?B?Qmw1alE0aGx6SHRLUE01RDh1c3g5QVdZQ1dtbzRIYjQ5elY1ZUVqOHJ2OFZL?=
 =?utf-8?B?eUVreURUdTd1ZTBoMG5Ya1JMYlhVQUZrcWp4OEs3Z2hoN2ZMWW9RcmczM1hK?=
 =?utf-8?B?bkJ5TnluTWYwNWZsYmx1aUUwdVBOUHZJeFhnNkpsWVViVy9FL0JNY0wwVVhD?=
 =?utf-8?B?NHVTaGltcWxXWkdyQ1hQbG1ibWpYMDVRSmtSYlRBTlJMMkhETmNvVTd1NWYv?=
 =?utf-8?B?bStMWWJ5eXN0UkFpQWIyTHFsYmtJVXVRanh3Wklseit5U3JxU05hb1hPSENU?=
 =?utf-8?B?bFlwQjdVMUcyNDVrNE1nUlJsWDF2bnZhelRlelREYTR3Y1RNb01BenVYKzI0?=
 =?utf-8?B?aVZHcTlrdWU3Z3ZKWmx0NUdsalJ3MnI4eGowYVppd1RRc201d1FxSkhtbnJY?=
 =?utf-8?B?Z2loUDU1SGVRSDVjOUswSzVNOUpuZ1FmbWRFM3NNQXVqeSs1ZmgraHN0TWI2?=
 =?utf-8?B?UDNsb204UG10OWp0c1pvSjhKSVA5NEdOSGxwR1RrbWNMcGJlT0huUlVNVUFL?=
 =?utf-8?B?RDgwaUZNYk1MTVE5MEtZTDhGUm9PbGlWSVFMYW1lZE9xNWQxK3grZ25sKzVw?=
 =?utf-8?B?SjFtMlNzVm5PMmRVeVpkRVgwelN3YVdoZHhzRjZDdjBvd0c3anhoWExjVXoy?=
 =?utf-8?B?QnU1czk5bDFNZGpBVkVtZkpZT25hMmdISnRvcUlPdXdYZ1kyclgwMVd1MS9x?=
 =?utf-8?B?VWxYTjFLMXhQT3hOc2ZkSzJyWFhKQlU2dCtKNlJrc3R1Y1g0MnN4L2d3S253?=
 =?utf-8?B?eFFQQW9zVnJuVDdpMXlXTFFLei93WGhJcjZXSGlDcDhUdUxIWi9PdWYyMFpq?=
 =?utf-8?B?VFRLN0xXNDRnU3YzcjVORTQvczFHdE1ubXFPdWxrUllud1hzczdTQWR3WVhW?=
 =?utf-8?Q?sFHmxcEw9xSSBC3aFQV8kDP2whMRhqFT7iWzvAW?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 037c173c-c396-4532-457a-08d8e57da0c4
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2021 17:38:20.9530
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LS8kHwK4E3AkcL9FJZcBLwziximBuNb+J1BJhSBy6zFF3T3ymQojORjyIieofZCf3tj8IjrRaJslgKwqOvxbXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3159
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9921 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 bulkscore=0
 adultscore=0 phishscore=0 mlxlogscore=999 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103120129
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9921 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1011 mlxscore=0 phishscore=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 adultscore=0
 mlxlogscore=999 spamscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103120129
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/11/21 10:00 AM, Bodeddula, Balasubramaniam wrote:
> Hey, thanks for the testing steps.
> 
> I tried applying these patches on 5.11 source tree. These patches were applied on top of the x86 patch, which worked fine. But in this case we don't see the same improvements in our testing. We made sure we set CONFIG_HUGETLB_PAGE_FREE_VMEMMAP=y in our .config file.
> 
> Are we missing any more configuration settings to get this patch to work on ARM? Can you please help with general troubleshooting steps to debug what could be going wrong.
> 

Are you specifying 'hugetlb_free_vmemmap=on' on the kernel command line?
This feature is only enabled if you 'opt in' via the command line option.

-- 
Mike Kravetz
