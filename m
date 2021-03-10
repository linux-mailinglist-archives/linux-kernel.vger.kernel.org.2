Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8849E334868
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 20:58:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233659AbhCJT5h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 14:57:37 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:35936 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233181AbhCJT5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 14:57:11 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12AJo2Gc120075;
        Wed, 10 Mar 2021 19:56:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=aVdBgvcWq4TvfgIFC6kfCAcUaRvDUAPNCqRLomI9v0w=;
 b=quW9dDzWjUHzhU3EXrX36Iw50s4/a4rloNDeqnszV+P1a5M9Axu5q5e8wiEvDN58RuVX
 1BFM88jkeVeXapAwkBF47sWY1vt4OML6Xirmo9a5pAX2nw4eRY7ogDswLZNdrT5BrkWa
 ZiwWlxxV0i09jYxYSs6DEzsQS0J8iKIaqhYFuuTotfbAFX8B/+jYZZiF8sHNpRRd2oEo
 tpq3vTlJAMG7ugWbS1tYEX+vpCpkbYt1+zKX7B2KuX734Yqo3bhD00zejV330UXHYEuC
 3jL2OTFxZdpHRleuU/x3B1zbM1wbkSvUuC4FXq82yN4A7uT6m+VytJEivAKBpvb1YLGv Ew== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 37415rc9pw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Mar 2021 19:56:56 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12AJpX4P060706;
        Wed, 10 Mar 2021 19:56:55 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2104.outbound.protection.outlook.com [104.47.70.104])
        by aserp3020.oracle.com with ESMTP id 374kn1f2bt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Mar 2021 19:56:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OZ6lT3InJmLBvwEt8wYo8JHKASnH74t/v9//ukNqlZ8+6nCYgo39nCkVf53tIC0NnyvdDXyWfWA1Hncrd9brBd+8DjsxpIwxyX/+Ua4lK3sJ2F5zXix9SrNwUTSGrhdsZGkst49UHZEAo6UDB+UW97L4n3/lVPlW1KREp5Q+7/nial75bbR6v3wjzeaRMELc2d/9g0uyQngRvaYQ5UydPd8rcfDuxh6jPnlJswWKosBJEGkdIVrD463B2+vNgybW18P44MEDAlnAvP58bHg7rB9N2Bu2c6Ml7kuMtEpk7+kmqVY9Ag0KJ1OIVPAp7mhIN7KphV8P4G4ECx0n2dQnWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aVdBgvcWq4TvfgIFC6kfCAcUaRvDUAPNCqRLomI9v0w=;
 b=JPs6ciCBDZwmwkH0PBar6Ss/Spr0QZhxN3haMjJGRoiEwS8g9zoD3G3FH+W+CRW/ELNob96UdsU7F7QC1+fGfiJHYJaJgiRA20PUAGZgTSeBJUOAPnRLXfBvz4vqXdSozyySlfrQC5uxvZYlAs3LRjCc3jDqXO8qBheo5sDovI1inyMBgVYbt7w6oCcL3cqurdwgUd7zy1IM8bl4NcDmVLmw5DDYaAe3cum9AO1+TmUmfTlU0QN2ZG/DqsYjSgAsku5Lb8dvA44fHy+xnmHHGGMvM0n7GvNWSTH5LO6hvsmywjjH+k0XfGVGHbVz4/XX6ta/N4MRSwqKhdaFrQZaxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aVdBgvcWq4TvfgIFC6kfCAcUaRvDUAPNCqRLomI9v0w=;
 b=fx32xsSw0rGrCygyo6YQvgLMDAS0dM7q1nBqdxavY7HjieY7MyJyOWFtZ7J0UTV4dsorVUQpV8X3QfZV4CJRRgoE9TPl88nPpSFTWy/35gDOpgBJwan5qFjmrePjodztTfW7psVyOOlUuVX3O1OjldBiXASzAwlBtDvOOCP8DbU=
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BY5PR10MB4273.namprd10.prod.outlook.com (2603:10b6:a03:205::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.29; Wed, 10 Mar
 2021 19:56:53 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee%7]) with mapi id 15.20.3912.029; Wed, 10 Mar 2021
 19:56:53 +0000
Subject: Re: [RFC PATCH 0/3] hugetlb: add demote/split page functionality
To:     Zi Yan <ziy@nvidia.com>, Michal Hocko <mhocko@suse.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20210309001855.142453-1-mike.kravetz@oracle.com>
 <YEjyS+xyeNlMcW/l@dhcp22.suse.cz>
 <298CE371-115E-4A78-A732-57D7B37DF74C@nvidia.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <a1327057-621a-e5ae-6a9f-6d54e2041115@oracle.com>
Date:   Wed, 10 Mar 2021 11:56:51 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <298CE371-115E-4A78-A732-57D7B37DF74C@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MWHPR11CA0035.namprd11.prod.outlook.com
 (2603:10b6:300:115::21) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MWHPR11CA0035.namprd11.prod.outlook.com (2603:10b6:300:115::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend Transport; Wed, 10 Mar 2021 19:56:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bd042722-b86b-414c-86db-08d8e3fea6e0
X-MS-TrafficTypeDiagnostic: BY5PR10MB4273:
X-Microsoft-Antispam-PRVS: <BY5PR10MB4273D7FD84E4E1ABEA59436EE2919@BY5PR10MB4273.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9vFwV8yieTgZEWlDuRFHDU0YJCmdsYDj2cXNCZKOMEpRkSuzlr+7w4eLPGtM0+Z4w23WKzhFkn3hEb7m3FrantnnLG10uJUReH+SChb4bH/LN56GNCv/jtFDvc+2gN75uLSIQQy4xaqyVN5zuFEu8K3THYw10fn3KY0hNJ5Y2V0Qy6hu5c/8oo05rUexNEPXWSSHhIj/yD6mF28w+eUn2LoihOM2+glu7AncUc4sI/ua7UePHNuyuq43GlzhRnZZyrm2o84ix+r44v4oIsLO3QDLQpotExOzxDLW0oZbkobCDuP3NJhmHDeg8sk2j/Fcw+YI11zabORq8sQf8dHTAzKXkcWyEQan+abOxeGvCHOyu9mRfc7+41svfJHZ4JozOa8vFnsKY0YfUTPrjhhu3Wq4qiLCYXM3zNACiyNUp+ujV5qGrZOLBA9mykZls4oKQFulDOCS97yBW8q4ZJf0fVQmFD3wCc4uSYqJdmv76tLBFB8a/Odk0mJIEqXkmN0Yu+XzsgCiF1EsJjU2wA8Rimi66xZRdH0ieOXQZNixz7ihu18vtcxhEunWg69Yu6K6SyPOM5Aki6DBLxLxO7pHk65hBd83fI8b4NZbtD6n8Vg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(39860400002)(346002)(396003)(366004)(136003)(31686004)(53546011)(2906002)(26005)(31696002)(186003)(6486002)(86362001)(16526019)(83380400001)(44832011)(8676002)(36756003)(52116002)(66556008)(54906003)(316002)(66946007)(478600001)(2616005)(5660300002)(956004)(16576012)(4326008)(66476007)(110136005)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?TUV2TXBTeGc3ZFdnSEpoazBLVStBWTFnS0RmYm5US0JHckV4ZmsxYUU4UkFy?=
 =?utf-8?B?NnE0eVVvRFdWWCs5S3dWZmI0WWxueVFTTXp1LytPMlBSbXE4c3VBNnhwbEpo?=
 =?utf-8?B?d0xBZ3Brb0Z4ZTIrMUJzRVNZRVhUVlJYTzViTm1nVlVRM3ZqbzV5LzJEQm1S?=
 =?utf-8?B?SWZNYnZJSGk0cVd1bEZsZk94blc4bTA0NmZBakV1dHBwSUUrMzdldVMxQitZ?=
 =?utf-8?B?ZExRMnJCbDBuU0NLdkJ2TTRnNHdWUTdFRTNJbVVSZG5tcllDS2RQc2RSZlk3?=
 =?utf-8?B?WU1lMWJ4VUZkMC90VkppVmVIOEpjcS9yVUlNQW1SNzdsZTV4STBEUXpsc3Bi?=
 =?utf-8?B?aHZuUUlmVjFLVTJGRVMwL0VnS25zb3Y2OE9UZUVFVnRnSm1nL2xYZURMTkU0?=
 =?utf-8?B?YnBuUVVoRE9ncFFlNkpiZTZaWlo2RS9OZ2xqWVJFajB2U3p2ekg2T3JGLzRZ?=
 =?utf-8?B?RTJ1TVQzZnR5Y2N1c0NsamFUVXpmVzhDM2hsMURMZjE5QTZWNDBVVzVhTlBh?=
 =?utf-8?B?bm95SjNLUmlBYzJnYTViOG1TRVIrUUNDKzVoSW9DWEo5aHd0WGRUUkpERDlF?=
 =?utf-8?B?c3JXMktoUlFuT0RFSlNybEUzWHFOSkxtNE5QUk9Rai9NVVprTWJKUWhTcWU4?=
 =?utf-8?B?Z2Y4aFVycEE1a0xsSHlzWElkZXlPeC9XblpwVGphM3Zrd3FwYW4wbEw3ZWQr?=
 =?utf-8?B?S2hSZFg2S1FLRG9OVTFBS2NKejJUTlBYb1JLSytLWUdzWjZhN0xGY1ZTaW5x?=
 =?utf-8?B?YXhhaC9BWVZqZFVNWUJCdThYNjRxYnFJeVVLRjFsMVNXMlpEckt6NEEwdmVM?=
 =?utf-8?B?ZkVReU9xUGdvc05UZGxwUUJ4ZTg3TGltRHlVdCtzVk1DSHBJb0NsTGtJK2Nt?=
 =?utf-8?B?VU9WNGxoVXRWWThWdUxudzZRV3poQjlScmh0eUNUUjRYS0FTOVNiTGtBMjdv?=
 =?utf-8?B?MWpKbWtldlUrL2RPZGozNkVWWGE4SzlRUjJWMmpjN3hhMFZaV25nNDArQ0pS?=
 =?utf-8?B?V0plQjZHQ2ZGd1RQMXZpWWM3ZVo3VXFmMUdtM3JzV2I0QmRxbXErRlFQekhM?=
 =?utf-8?B?TlNLa0VPeXdqd1psem41Zi9hbll2dDI3RFhDbEVwcTYyQ1E0SGY2c0J3TE5n?=
 =?utf-8?B?TGRYMG1mU05CSVVrVENyL3JKKzVrbjNISjlTbUM1bE5qd3Bkb0RJalNOa0lM?=
 =?utf-8?B?SWd4V3NqYUxETnRCUm1DVDlGMEcwVWJkZFV6THlYZjZKdUJQUEF1NnF0TDBw?=
 =?utf-8?B?bWxRcFdoYWYzbTJHYXBjL0gvc1FOcjFPRWlRd21sbDBnOTdCN3U4d09yS3ZH?=
 =?utf-8?B?OGxhL3cwUmMzRUdrbW9IZGZ3a1Nza1lPVzY3anp1Rjh5aTUxVU1DREVGT3Fq?=
 =?utf-8?B?N0RsQ0lhTnRXOHNYcGVLRFpiUjF1cFh2VDF5VUlEdXk4d3VTekRWRzNCREVu?=
 =?utf-8?B?VS9vWm9idHdpZ1NGcklwSUxFSzQ1a1JpZE5uREdTd05YVEdCNUl0VVB4b3cw?=
 =?utf-8?B?MXRuRmExWmhLd2FZbjF5WWdNVGU5a1pXRmJteGNPV1pmcHFYblA1TjdRR3Fa?=
 =?utf-8?B?VGg5cjZUc3VrUnl0bmdET2dLb3AyS25Ob2JESElIc015akIrVlZSYmFhMVNO?=
 =?utf-8?B?dGdqL21sWkptQzFDeCswTjJ4RzVtSFBUM1Y1YUF2VTZjVnNrZ0xMSHhxNk0x?=
 =?utf-8?B?VmRCNkpZMzJ4djV0SnRFUktXNzU3ZHloZHJyaUpzWkl0cnN5SzBBK2UxR08r?=
 =?utf-8?Q?gZAhFmx++SBKyoe0u+SrF+QVgYfT0vR/nBaCe0r?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd042722-b86b-414c-86db-08d8e3fea6e0
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2021 19:56:53.7938
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k+pNeF8irX54spcKS3fXaR6ccxOVYNKl/7ibDJM2hou6INSBQjwMzx4uuDGstRoJq/mg+uv6d0w5Js3sr6JcRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4273
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9919 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 malwarescore=0
 spamscore=0 mlxlogscore=999 phishscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103100094
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9919 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 lowpriorityscore=0
 impostorscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0 adultscore=0
 phishscore=0 spamscore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103100094
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/10/21 8:46 AM, Zi Yan wrote:
> The high level goal of this patchset seems to enable flexible huge page
> allocation from a single pool, when multiple huge page sizes are available
> to use. The limitation of existing mechanism is that user has to specify
> how many huge pages he/she wants and how many gigantic pages he/she wants
> before the actual use.
> 
> I just want to throw an idea here, please ignore if it is too crazy.
> Could we have a variant buddy allocator for huge page allocations,
> which only has available huge page orders in the free list? For example,
> if user wants 2MB and 1GB pages, the allocator will only have order-9 and
> order-19 pages; when order-9 pages run out, we can split order-19 pages;
> if possible, adjacent order-9 pages can be merged back to order-19 pages.

The idea is not crazy, but I think it is more functionality than we want
to throw at hugetlb.

IIRC, the default qemu huge page configuration uses THP.  Ideally, we
would have support for 1G THP pages and the user would not need to think
about any of this.  The kernel would back the VM with huge pages of the
appropriate size for best performance.

That may sound crazy, but I think it may be the looooong term goal.
-- 
Mike Kravetz
