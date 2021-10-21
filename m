Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD65B436489
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 16:41:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231196AbhJUOoB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 10:44:01 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:60848 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230283AbhJUOn7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 10:43:59 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19LEYpQS023668;
        Thu, 21 Oct 2021 14:41:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=vZFk/V47iF4OqRhyV/rUy3jjJE5gmWxCg4G6Gw8n3P4=;
 b=AWK6TFy8Ud9ozl3VpePA1b63NB8qPa9PmaCXz8cTfDPXaOWzXvswUm5+Hodkz4Mi47OY
 AsaQ1WGn1ifT5U8nIwROFjuAfQCjj0Octl+cQH1RptQcfZoYdhHq7Hmt0neGZeXcmJU/
 VB2Dmjk0FrEqGgSRYt8p7lK7pVmE2ermPpQ+AcfO2NN0MfGpxCMZDn/+GuK6wFeyz2kI
 /MT2SnxTLroMBCllqashljOLfPEzAPwEDL2BXrSATTuc28SLqrkDEDIO4rXN8pYB9INT
 74Oj+6xOJGMYzzLHIe2SnKuB8LSQT/mpP8pFA8932IB23US9bCcW9YFyxIFsXD2r2AUu dQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3btkwj6ncv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Oct 2021 14:41:35 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 19LEZNtb173400;
        Thu, 21 Oct 2021 14:41:14 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2170.outbound.protection.outlook.com [104.47.73.170])
        by aserp3020.oracle.com with ESMTP id 3bqpj8wukr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Oct 2021 14:41:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VDrIrGFvJn7QUys+rCZ79sBj0ACUOwqmhwzglxox1AFpUN769v917/6Ea89VkoDfiFXxSsna62p7fNdgY1/54EdOErk9K781qEZ1zZ+LYhcgwog1KYgRa796Dlyj3Spiq10jbIXbPpvcL8Yj6me3c+G556kuq22Pg7ZOdGarHuSZb9r3gvoFF2w4XXb/HoBm1V5UPtKv/ZEY8wNxNx32dlvWkMZsRIyW5B0dn2/MqQffFkpkfpWhqn/0e+T9CN/Qwuz8w+BW9czaYujU+X8/G0Lgx/dKSboEgAmWEAvquZ4CfeTupNE6qN1oV0sqpAVWCYhb188DXAFckDbqJtNPQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vZFk/V47iF4OqRhyV/rUy3jjJE5gmWxCg4G6Gw8n3P4=;
 b=L+VD2dl5N3oX1hnaWTS3FQd2i0vbCN4xCzhbNPS6dU0Z1yiyDvW3/butfWC83iUBXD7hDCpNuA/RnfReWJ2vXX9hvqg1Rc3d2dN56EEfhxQLdm1AZdprU1N50NqcuDex4kryGraxDdZDntIUAjgn6n/FtQb5rhyvJ1cd4c5HfgbgPyArZwhTYofGBdYDQNfBVO60bOSTLD24gy0G26XHfTUNIALDhHhMMTyBVOeaJ1LlDZCg44Ya2ZcDKU1uHvQk6ydBkMd3VTvtqw4ofyQp1TShkbzt6GU+Sg70u070zQCne8HIXETvI9GbpdGjTbItA76Fl93DNIF7Ui0dWsulfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vZFk/V47iF4OqRhyV/rUy3jjJE5gmWxCg4G6Gw8n3P4=;
 b=Xv0ATuDEpi7H2D42kPfvHA34ROQa1j+vkn4EsKsY191J7rxZbP0ciTG9RdPSn/EnxkPjHJ9Z5TB2eARPvbrp+9TImafRq0MU0LlRuLJAYCJtC3eboN/4zQRTAalJFFR2xVHKbE9Yi0CCc80ADT0NMrdZTJ91GEc2XIh+T06O6IY=
Authentication-Results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=oracle.com;
Received: from BLAPR10MB4835.namprd10.prod.outlook.com (2603:10b6:208:331::11)
 by BLAPR10MB5139.namprd10.prod.outlook.com (2603:10b6:208:307::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Thu, 21 Oct
 2021 14:41:12 +0000
Received: from BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::d809:9016:4511:2bc6]) by BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::d809:9016:4511:2bc6%8]) with mapi id 15.20.4628.018; Thu, 21 Oct 2021
 14:41:12 +0000
Message-ID: <c5b405ed-c22a-1bcd-b81f-d93b34e5a9e2@oracle.com>
Date:   Thu, 21 Oct 2021 15:41:04 +0100
Subject: Re: [PATCH v2] mm: Optimise put_pages_list()
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>,
        Anthony Yznaga <anthony.yznaga@oracle.com>
Cc:     Mel Gorman <mgorman@techsingularity.net>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
References: <20211007192138.561673-1-willy@infradead.org>
 <20211007123109.6a49c7c625e414acf7546c89@linux-foundation.org>
 <YV9eueky+lBfSWA3@casper.infradead.org>
 <20211007163554.d9088a65f0e293e2bd906a56@linux-foundation.org>
 <YWBS6iJr/4RJ+hNE@casper.infradead.org>
From:   Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <YWBS6iJr/4RJ+hNE@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM3PR05CA0137.eurprd05.prod.outlook.com
 (2603:10a6:207:3::15) To BLAPR10MB4835.namprd10.prod.outlook.com
 (2603:10b6:208:331::11)
MIME-Version: 1.0
Received: from [10.175.162.202] (138.3.204.10) by AM3PR05CA0137.eurprd05.prod.outlook.com (2603:10a6:207:3::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16 via Frontend Transport; Thu, 21 Oct 2021 14:41:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5a2de3d2-7787-4fbb-2f89-08d994a0d3bc
X-MS-TrafficTypeDiagnostic: BLAPR10MB5139:
X-Microsoft-Antispam-PRVS: <BLAPR10MB5139458292937F3FB4CFF61BBBBF9@BLAPR10MB5139.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CtoxNAlyH1+gOi90lHYi+55GOBvJTUharf7pgCSZqMFascyuaNROJDN8XRNcMgrFBPrAvlWzEoDOJujxc1oiCMpFroDPpZVOdwABGYDScW08y+ucTUJgnI/5Nugis/p3layWnrot0iE353Bzr4+FPj0UwGlSMVlJRTRYI3X8bgJZTsSX+vRZNt+sqh7z2bL77of71A8QMZImKmPAKqCeCr0ReSzWcrZpRnscG7pP1xiApu/iG3/yMuNfy6or2jbh8wh/14CVLa7OyTzn3UzHvQUkZ1kYlunYxLDyzYnmRXuBdoFRnj1rTUZREUKmzYGsRPhx2mv4HWuGMr1QgOoYt8qrbPlyJp3yRCtixnK4Oci7VClH0wEeJKYP3BTmL7Rcsq7qipCXQWwNqcTTgGzkQ4UeMRB6/iflDcqFwAZ/9xBa8fuze0uAfulBpJicI4OKLm//WMwDpjLNDg/F1au2YhSsblfytnT+xYS7Hzrw5Uud41JaQXAcztaeD63TooUDlk8+ZzgsWIL0xFdosU7LZOEkfeEFy2Cxy9MEfeyqW+JvWEYCI/w0S/yn0ffRzsY8RYHtl7W8MBaDMbYjiYnML1DQsRd0Yvv2WMn+HCDHga1JrIzKflcK5SxP1IRu+uGWFiTNplvsvDc3+O61idkH+kOHZ/eqYuoffApYNWGyXnR1t+uvo4RUGETrKek40Pw6jF//jXKS+8tBHjFtmiNgrA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB4835.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(83380400001)(4744005)(186003)(26005)(2616005)(6486002)(31696002)(956004)(53546011)(86362001)(6636002)(16576012)(54906003)(66476007)(66946007)(66556008)(316002)(110136005)(8936002)(8676002)(4326008)(5660300002)(508600001)(31686004)(6666004)(36756003)(2906002)(38100700002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RVpqYi82OXhNL2ZDQmUrR0JUNkFvU01EQnZXTG5XZVRyZ2tNelRYV25xWnJm?=
 =?utf-8?B?YUk5TEJ5SDZwaEk0VTgyNWRiOW1iYmtKUmZEOUF3bG9XZ1VQaGNxQ2lid0VP?=
 =?utf-8?B?c2RyVk95S2cwL2lEZUJRQnlmdE9uNWJrSkJnVGRMTktjWmk1RU5OZmhXeStx?=
 =?utf-8?B?Wi95MjdmOTNmaUtlMVpZeU8yaHY0eUFsNzRBVHVDRXg3WmVlakhtTDF5VWJ0?=
 =?utf-8?B?a2VwVXFZc29LMzZGbHlhZFZlMCtSSUNSbTJpa2F2eE9VOWxKWHVTZE9YRDBl?=
 =?utf-8?B?TVphdWx5TlE4ZTVsZHh4d09SUW1jdTd5ZmF1OW42aE1tVGpPN1lwM0ovV09N?=
 =?utf-8?B?ZlV5VnZnTi9LOXlWdjZYY0Q4K2xzalljcHRzbjg0YmlWSDJMdWZINjAzNFhS?=
 =?utf-8?B?dmFyU0pIU3QxWkozcmhIa2hvK1ltZElaQlJsb0xvdTViZ2pwbDJtNWpaV1h6?=
 =?utf-8?B?bjhVcGdrL28vZ0ZkWkhqbU9sbFA2M1ZubWFFQkw1eW9GbXZxMFR1cUI4c085?=
 =?utf-8?B?aW5GbkkybEU3RHQyejNSc0UwWXFGT3RlMnJoeHhmMTFBYkRDYnVHVko0aWpM?=
 =?utf-8?B?RnFHbUJNTk40TjRHenVVWElxejdCZ1dRNUdyaklmTjZNY0hEaktTMTJ2VTdG?=
 =?utf-8?B?MHZVT2hGemdROExKN2JUd3RiQWx6NmgxbUcyN3lYanRRZ0xuWWRnakdVM014?=
 =?utf-8?B?NzlsT2l1YWlGY3pIYnllTUVQd204bU4rKzBFYWxKUlhhL3p4b01TVFUzeHJR?=
 =?utf-8?B?b2RmQ3gyV0RJU3NCa2NsMXM4OVRiRy8xVjg5K2pOUTlFSlJMaFd2YWpiS01Q?=
 =?utf-8?B?YlJqWjErdGRBSFdKRDZZOEIzNjMvb2hRZGFNY2xRRGE4d0ZNZkUreHplcnRF?=
 =?utf-8?B?VGVnSFlKRnBvM1haMXBCT3RDdXVsd0FqSThxdCthaHZOOHA2bzZCdUhwbC9G?=
 =?utf-8?B?RnhTK2xMWWM2RmpQb1hGSVVMcVV2QnJYMXU0ZHNCU2lRZXg2a09pMlVDakVO?=
 =?utf-8?B?ZVd1QmRaMnR1WGswWnNuVHdHUkx3bzAzVUtCbU5jbDcvOWd0MmhFL1pabDB5?=
 =?utf-8?B?a1FGU2pDMjFCdld4Z1NhWThaa28rSGV3WmpmQ0NxdFJpMVBjRFJwOWp2aDB6?=
 =?utf-8?B?RmhzUW14ZjU1b0pDTG1iNU9YNHU5NSthSWhES3ErOUZNczR3Njc4aCtLMXBD?=
 =?utf-8?B?b004bURjS2krd3ZJbDBOeEYzaHdNcWFraFNkZ2hsYk45TjB0MmtHVllCVXpJ?=
 =?utf-8?B?L3RPbXdEdVB4ZXhOUEljNlpmK2NVcVZKMUZjbGtvRlU4MXFRMU5McWp2M1JQ?=
 =?utf-8?B?dmVTQnNIdmlLRFZMcGJqbXQ4azVqY1kxZDF0S09EVVFUSUxsR2pKd0U0SzYx?=
 =?utf-8?B?ekJKZXdBZXYrYy9RRDc5VUJaWVZKU3FLLzliUTFUdktVODg5QXN4Zm9XSDNP?=
 =?utf-8?B?NlFFekoxOU54OHNMeFZBZUc4OXhsaFg2cmpBSEI1THkrbDdSV3N1Z2ViNXha?=
 =?utf-8?B?ZXVrVlB4d0U3QXBOOHduWVJSYUdZK1kwQVh2N1BER3ZaOUxQVDZxNVpiUjg4?=
 =?utf-8?B?YmZjTFVGRHBkZkFyb0FOOXZhU01KNEVWcE1UUWF6amZpUHhsTDhiR05yRGJs?=
 =?utf-8?B?MGpiV09yNFBXMURSWkhKeXJXZnFkL0p3UWgwMUZpdDlnNjNhWUJsZFBWdnVY?=
 =?utf-8?B?b0lzRkRmQkpZMXdPejZkTUM2OUNyQnJkbnlzTytUK2ROZDVBdmZzT0VPQTV6?=
 =?utf-8?B?d3lpUTQ2dE1WRzlqRHhXQ0loaUhxWUtEUHhuY2Zwdkg0U1pzZGFZUFIvc2xV?=
 =?utf-8?B?bWdmMUsveXdPOWpseVlmZ2tqaThOVFEvajVDa0FXYThCWUJvUTN5MjhBcGFp?=
 =?utf-8?B?NEpEbGxCTzFqN2dJTzkvaUNLQVdsZHM1bjVpaGticVNuazV0dkdLeHova2ZB?=
 =?utf-8?Q?VhjaNP9Md38NWlwKFTDBNe/sPc/vnK10?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a2de3d2-7787-4fbb-2f89-08d994a0d3bc
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB4835.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2021 14:41:12.0865
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: joao.m.martins@oracle.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5139
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10144 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 adultscore=0
 malwarescore=0 phishscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110210078
X-Proofpoint-ORIG-GUID: fD9nWs2w17t-UdQQE1n9WcSbNPQXoesK
X-Proofpoint-GUID: fD9nWs2w17t-UdQQE1n9WcSbNPQXoesK
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/8/21 15:17, Matthew Wilcox wrote:
> On Thu, Oct 07, 2021 at 04:35:54PM -0700, Andrew Morton wrote:
>> On Thu, 7 Oct 2021 21:55:21 +0100 Matthew Wilcox <willy@infradead.org> wrote:
>>> My first response is an appeal to authority -- release_pages() does
>>> this same thing.  Only it takes an array, constructs a list and passes
>>> that to put_unref_page_list().  So if that's slower (and lists _are_
>>> slower than arrays), we should have a put_unref_page_array().
>>
>> And put_unref_page_list() does two passes across the list!
>>
>> <quietly sobs>
>>
>> Here is my beautiful release_pages(), as disrtibuted in linux-2.5.33:
> 
> I think that looks much better!
> 

For what is worth, something that was suggested by Jason over the unpin_user_pages*
improvements series was to apply the same trick to how we iterate a page array to
release_pages(). Purpose would be to batch the page refcount update if you pass N
contiguous struct pages.

	Joao
