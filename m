Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A27773EBCB1
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 21:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233770AbhHMTuq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 15:50:46 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:58582 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230440AbhHMTuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 15:50:44 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17DJQKqu004213;
        Fri, 13 Aug 2021 19:49:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : subject
 : from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=IvUIUgZTPdlmf0mibzc/ihjC0WcmnD0xBDxQTKtkW4A=;
 b=s49H7SUumoujcY4CA/cJ+u/IspxN8sD7w0YWpHcgZE1RXDtPhjDBcjDkpeNVM64Uv+Xd
 APqPJckw9KsfOZEs3OmA8zNlN2Ar0rHsyvP8WhfuDnzpkqKpxnq+oSsfQHcdnqEWckIg
 h746XAoejABmDSdT2zlbqSL5kh91fRx/FYbS0fS5m6VkFPlRTYQpkPlc//UdIeQAACBz
 VT42kAHnuYrV9vMW9s/FoU1CxLBxLLbEmh9F8+VNzSnXlp/3fQSilXVJaI75fu8GXBC+
 fvWChYWCupt8XQ1/TukyYA9edeTZLaDl40ZXUlokIvHD/ECp5iyCV02GzK1iiashFovL Ug== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : subject
 : from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=IvUIUgZTPdlmf0mibzc/ihjC0WcmnD0xBDxQTKtkW4A=;
 b=GB0PW7UlNfw9GyzheueXcz0WOVJhjFDwIHRKeyW2Y99pfuO3dk4eTAAHOFGHQrlxFkPn
 LFxawHKnGhdxIDcYTKmAyVmWP4jzhs0nIo9PMrt4TsqBQ/BxwJWKswvTJgoSKMQZdynW
 oHP8+nGvDLnt4OCYDYNu5coD+pIewZQ5uEfZffldr65gAxIQLqBble4fBm+eQynj60MC
 p37kU4N/lxAi5eIwIOEqmSyT0wdz8PzUC4Nl/hL8BIlv1lsHvpG9bq1uVqAarWY9NBBa
 K4pghasf9dHxDTKdg4L6DH9+ybFhSkagqDYqNx2Efrsxt6LgBaQQmEw0H5AliuDQGzVy qA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3adsja8wpw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Aug 2021 19:49:51 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17DJQevX013391;
        Fri, 13 Aug 2021 19:49:50 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
        by aserp3030.oracle.com with ESMTP id 3abx41ajur-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Aug 2021 19:49:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M0TpT77iv7EBEYnusXaCLatEw0/or/bEbSqUmF/b8yE49oOY07KUjsMWa5BwLkkHbeHN42PNC+eANzM41f+rhblSG6yr1R9C36bAU+7Q9TG4iLjQrTjpV/HxaYhAZt9+2tWhmx+2HwDu2htxemUMnj7cXgNgzyqkXgRg1Phf0fmcAahVP4oLBFz5Xbbwz7+kflLrpYZbTHwjWQcrjkDNNsNNSk/39LxXDm9nj6uUhSCCgcmnsqmTqIZZAZs2VRLgmNrhhbJGzDcK2duypd5gh59AVk06xu1nYL5ZXHb0S2PLmSE6feI17IxWqrgeGU6xOKKqeI6VDKIbLpnIYDw2sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IvUIUgZTPdlmf0mibzc/ihjC0WcmnD0xBDxQTKtkW4A=;
 b=Cv/w4L4oeEnI1pIlq9CmisgXBlau5mOTP+0sD3rRJkkWaSWQphaMbglGbsTyMbgfZyLgFUP6wF1WLIR4d0QSYm4QJ8UPNGmvs+wncvxacviQybc3+bW7Qc49gG67ZklSlM/suqC14upBJ2VnV680OK4xnIMg9K6MhnnGhQpB2bNdfs+YZp7oNhAxzleuccEv3PvGyKhSXxTacBtViMLe9z9MmVuFEJrrvpT89c6N+8dGDbO/RoJNM6A3qfvLq4wPjBJayxkEk//nE5LwQyCJSd0YpfSOjU6ETY3txF70xanIk+hiGumXeJ3HpcL/1MB1WDkUChGjlurxFAYI56ejzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IvUIUgZTPdlmf0mibzc/ihjC0WcmnD0xBDxQTKtkW4A=;
 b=RCt2v2ra6ahBXF8Gt2n+FZu0Kw+0Dtt940fg1cssKkq9r+qIDCS9mCx02QmkY5RsWha9+7CCmPZopnYdQc84GCb0ElnnUVrlCL9RULNa6ZzbAtHLCoeC6Ptrwt6HsG3juSjou8SWE2WDn/N2ALyn52RvFstie/I9zMkus5s/eaM=
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=oracle.com;
Received: from BN8PR10MB3220.namprd10.prod.outlook.com (2603:10b6:408:c8::18)
 by BN0PR10MB5191.namprd10.prod.outlook.com (2603:10b6:408:116::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.17; Fri, 13 Aug
 2021 19:49:48 +0000
Received: from BN8PR10MB3220.namprd10.prod.outlook.com
 ([fe80::b049:95da:3548:61f8]) by BN8PR10MB3220.namprd10.prod.outlook.com
 ([fe80::b049:95da:3548:61f8%5]) with mapi id 15.20.4415.019; Fri, 13 Aug 2021
 19:49:48 +0000
Message-ID: <55720e1b39cff0a0f882d8610e7906dc80ea0a01.camel@oracle.com>
Subject: Re: [RFC PATCH 0/5] madvise MADV_DOEXEC
From:   Khalid Aziz <khalid.aziz@oracle.com>
To:     "Longpeng (Mike, Cloud Infrastructure Service Product Dept.)" 
        <longpeng2@huawei.com>, Matthew Wilcox <willy@infradead.org>
Cc:     Steven Sistare <steven.sistare@oracle.com>,
        Anthony Yznaga <anthony.yznaga@oracle.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "Gonglei (Arei)" <arei.gonglei@huawei.com>
Date:   Fri, 13 Aug 2021 13:49:24 -0600
In-Reply-To: <a94973ab83ce48bd85c91397f82d7915@huawei.com>
References: <1595869887-23307-1-git-send-email-anthony.yznaga@oracle.com>
         <cc714571-4461-c9e0-7b24-e213664caa54@huawei.com>
         <43471cbb-67c6-f189-ef12-0f8302e81b06@oracle.com>
         <a1dbf12e-9949-109e-122c-ba7ba609801b@huawei.com>
         <YOubKmDwxMIvdAed@casper.infradead.org>
         <a94973ab83ce48bd85c91397f82d7915@huawei.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.0-1 
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN4PR0501CA0099.namprd05.prod.outlook.com
 (2603:10b6:803:42::16) To BN8PR10MB3220.namprd10.prod.outlook.com
 (2603:10b6:408:c8::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from dhcp-10-154-149-72.vpn.oracle.com (138.3.201.8) by SN4PR0501CA0099.namprd05.prod.outlook.com (2603:10b6:803:42::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.9 via Frontend Transport; Fri, 13 Aug 2021 19:49:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0bf33578-1e79-48c6-991f-08d95e9381b0
X-MS-TrafficTypeDiagnostic: BN0PR10MB5191:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN0PR10MB5191495A7E078F3F6EC860F886FA9@BN0PR10MB5191.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gE9JKuZpDXdhbs69mXM0Rgra0BldU/9oo+hvvDIAdZKcSf/tD3xffBsrlEFmbcxRH6LYiCJO5XqzW52lr8/l/nHmO2v+y1UIUI6eUXQZdKbct2H+7L8NqoAY25reGwIDQkCEojXGDnoSa1RPH/1XsO+tsl0al6QA03B0BJc0ERJvuvV4xxsraQbVzfHHoukPUhUrAp7oUk60tiJZ7nvcIYkg1hpJH6UYvLUHjpHZHt2FMgrzVSdTjH1O3d/7WOHs/ofccTmrQl83hgwB4aMbWbgSy/g1iFmFwtEa67SEIgQhsY/2nyg58z9Gm+C59XO345+0sr3l7n6VXp5VQfVo3/D/TefTJ0JaKpRo6bWZCtw9nHDrM7oM+O8U2EB6zf8qMyG50MrvltDmq6q8WksbdgNR3q/JX6hEDsPcOd53xZJYYNtSSNUU5Wxr/0Hf84LnvZVv0sMMWRpUo89X4WMdi/koyhcy34vwBkxihyOJC/L7Hl8UXopbYVlhoOlBwxlls6BZUs/y90KRZAN0RUvZXo0ECWIRSt0p483JEZr7nRbYrtuZuZ2IvcPDZmBcGWrmhXs9Q21l/otYz3ss/XMU5YhyHlzf6UKfwnxvh56gH7lI0bivPXQibB+kc9mGkE/XRLYDptlQSPBwf/Gw6MXtxA/cUgscsO3EBiiQr4bV/ikd9PvE65HcSD8vb7eoN2wHVW+55v+J0bBijK1B6mbH6E8zzCD98i/yw69M/91R6gWrqlnW8f8vusz8q+QlylJ3JyQ5qgAWjSJv6Yic08vKnJp8CHwn7DXpcpONOWodagA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR10MB3220.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(346002)(376002)(396003)(39860400002)(8936002)(6666004)(66556008)(186003)(66476007)(66946007)(8676002)(5660300002)(38350700002)(38100700002)(478600001)(7696005)(52116002)(966005)(4326008)(86362001)(316002)(83380400001)(44832011)(2616005)(2906002)(956004)(36756003)(6486002)(53546011)(110136005)(54906003)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QitPK2JnR1l1RE1DZ3J3Q3VKRFdqZWdqSWNWL1VGWlU3Y2FnR1VxY05ueHFP?=
 =?utf-8?B?bnNEZVNZUWltbWFhU2g2WW5pT0lKdzgwUXhDdEJFWXE4aWxnSXdWODB4MW5S?=
 =?utf-8?B?Rmh5WjZtcHdoMFkvRy90T29yaklVVWJSb0dXQ2lIOWxkeTRJYW5jeVp0SThZ?=
 =?utf-8?B?dzA0My8vWjN1dHpIamFXR3lVQ3M1V3VrQ1JQUFhDdVErR1diOHZKUmVKZTla?=
 =?utf-8?B?NS8raFdGS1d4Zm1kS0x3bks0VlVBdnNNMzNlMDhDS2RCVWY1YmttblkxV0Fz?=
 =?utf-8?B?d00wYnJ0VGJ6ZzIyc2ZnenBlSTd3dm51RWlOQ0VXV3RmNE1FdkZ4bHdudjJJ?=
 =?utf-8?B?aUJVOXFYQTVxeGxDUXpQc3d1OW53NWZjSm55eHB2OXE2L0EyajFDQ2psRUxI?=
 =?utf-8?B?SGFZc2V5cVVOZXlmZVNpVkN2M2xXMnZIVGZMUGdUbG1lYlhCdEpCL3NKNzMy?=
 =?utf-8?B?NFNId0lvRE9wbkF0UHRGV2duUGZ5NjczMTdNb0RRZmdqeURnbjZ6ZlBpSGxa?=
 =?utf-8?B?L05lc3Ftb3cyZjRpUTFKeDdxejBJSVl1OERUeHNlZzB3Vy9yOW9sTmxvMnc0?=
 =?utf-8?B?bGJsRTJMUy95K2I1S3NaZTkrMFNQZml6MHlmMTl0Zksxek5yclpCVEtXNCtE?=
 =?utf-8?B?c0NIOVJLbTk2ZmVZSC9xbUdnVzJNenZVN0UzQUZjamY4aGc2c0dzU1VrVUF5?=
 =?utf-8?B?OHppUFhTL1pReG9PN3grZUFBRFZkZW1WOGZIbkl6SjhWaWRQVzMxMmFRa2Mz?=
 =?utf-8?B?cFFxUWpaOGhSZ2Z1LytwZDNtTGkwdmNwODNvU2JBZEV5OWtaYWd6cXRudFho?=
 =?utf-8?B?a1BJcHpDbXF5MFdvY2M2WVAyMkJ4bWpFZVZOT3F1cW9WWFFFeTJWbmJYT1ly?=
 =?utf-8?B?R0wzL0Q4aVNJOWF3S1JwOFF4aSttZ2t5RlZYenFFWnFSUW01UzdQZEluZ2th?=
 =?utf-8?B?TTRCUElNSkRBcGJCYnRhSVNWVk1TbWd0QmZ6MWQzejZoTlhpNXZkeEVLanFH?=
 =?utf-8?B?NUUyREhlVm5GcEp0RFByMExNS3lPM1YrVWRaR1UzUk5yM1NGOUdmNmRYYXJE?=
 =?utf-8?B?bUxuTnBDdC9FRFIvL0hGcnBnK09zOWlHMGdQbmQ5R3hvek5FZFcwN3M4cDBk?=
 =?utf-8?B?RnhTYWRPZkcvMEgxdHlSeTIzUkNRU20rZEszeGN1cGk5aHRJMUQzZGRpVndG?=
 =?utf-8?B?QU1vWTZYVnJBdFV1eDJYblZsaUdhdXZYTVNadzRCazBrOWJiSGt2OFlYT0RS?=
 =?utf-8?B?NXhybFF6Z25HaHBPK0cxYURaZnNTcUNSYkQ1TnlkRGo3NXgwMkRteWZHOUJZ?=
 =?utf-8?B?aFBocllqRjdtZEx2SVpHcVl1UzJkcWxhS3hCcDdrY2gwaG9LSEU5Y3pTRGFS?=
 =?utf-8?B?eGhwUDlFQXB4S29kYXljcmtXWkp2b0k3TWEzQW0xaUgyZ3F3Rk1IQVpPWldr?=
 =?utf-8?B?TFpYcTFBZVNDblI5YnBnbTEzRFZGQTNpc0JyTlMwK2xLbXowYThyQ3R0WXJT?=
 =?utf-8?B?TmtuSElBdjh6OXBJSFhBT2ttU2pPamFuMWRJMFB0d3gvd2Y5MzhJSkJZYitp?=
 =?utf-8?B?ZU0zeFZaWFkyZzNDcUxCMVdNa1R3bzdrNE8zcy9SUUIwYjA2RXVJNHB6c2F3?=
 =?utf-8?B?dEpOR1lSbG0rMXVwa2w0RVdBWVpEWmZPRCt0ajUrUzlkYUs0bVBCSDVVOERW?=
 =?utf-8?B?M0hXZzVBaVNNVm5BRVJVQUxmSy9zcllsT2YwTFdXNnhwMWphMXhGRG9kWGN1?=
 =?utf-8?Q?Nxg2f+hn1GTx7q/mBdwsAfajmnZb+rtmIDOhUoF?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bf33578-1e79-48c6-991f-08d95e9381b0
X-MS-Exchange-CrossTenant-AuthSource: BN8PR10MB3220.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2021 19:49:48.4240
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QK6rTkNjZJRT5ZKg86Z1ZpfYBNgUgVUbENgh/9FSAkjcaD1VnV8ZNWERfV05XxFHlqdL6LUH4GRSmybOxo5enQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5191
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10075 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 bulkscore=0
 spamscore=0 phishscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108130114
X-Proofpoint-GUID: MqRMor7RB661RdA1noy9Gpr7qHsJHXLM
X-Proofpoint-ORIG-GUID: MqRMor7RB661RdA1noy9Gpr7qHsJHXLM
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2021-07-13 at 00:57 +0000, Longpeng (Mike, Cloud Infrastructure
Service Product Dept.) wrote:
> Hi Matthew,
> 
> > -----Original Message-----
> > From: Matthew Wilcox [mailto:willy@infradead.org]
> > Sent: Monday, July 12, 2021 9:30 AM
> > To: Longpeng (Mike, Cloud Infrastructure Service Product Dept.)
> > <longpeng2@huawei.com>
> > Cc: Steven Sistare <steven.sistare@oracle.com>; Anthony Yznaga
> > <anthony.yznaga@oracle.com>; linux-kernel@vger.kernel.org;
> > linux-mm@kvack.org; Gonglei (Arei) <arei.gonglei@huawei.com>
> > Subject: Re: [RFC PATCH 0/5] madvise MADV_DOEXEC
> > 
> > On Mon, Jul 12, 2021 at 09:05:45AM +0800, Longpeng (Mike, Cloud
> > Infrastructure Service Product Dept.) wrote:
> > > Let me describe my use case more clearly (just ignore if you're not
> > > interested in it):
> > > 
> > > 1. Prog A mmap() 4GB memory (anon or file-mapping), suppose the
> > > allocated VA range is [0x40000000,0x140000000)
> > > 
> > > 2. Prog A specifies [0x48000000,0x50000000) and
> > > [0x80000000,0x100000000) will be shared by its child.
> > > 
> > > 3. Prog A fork() Prog B and then Prog B exec() a new ELF binary.
> > > 
> > > 4. Prog B notice the shared ranges (e.g. by input parameters or
> > > ...)
> > > and remap them to a continuous VA range.
> > 
> > This is dangerous.  There must be an active step for Prog B to accept
> > Prog A's
> > ranges into its address space.  Otherwise Prog A could almost
> > completely fill
> > Prog B's address space and so control where Prog B places its
> > mappings.  It
> > could also provoke a latent bug in Prog B if it doesn't handle
> > address space
> > exhaustion gracefully.
> > 
> > I had a proposal to handle this.  Would it meet your requirements?
> > https://lore.kernel.org/lkml/20200730152250.GG23808@casper.infradead.org/
> 
> I noticed your proposal of project Sileby and I think it can meet
> Steven's requirement, but I not sure whether it's suitable for mine
> because there's no sample code yet, is it in progress ?

Hi Mike,

I am working on refining the ideas from project Sileby. I am also
working on designing the implementation. Since the original concept,
the mshare API has evolved further. Here is what it loks like:

The mshare API consists of two system calls - mshare() and
mshare_unlink()

mshare
======

int mshare(char *name,void *addr, size_t length, int oflags, mode_t
mode)

mshare() creates and opens a new, or opens an existing shared memory
area that will be shared at PTE level. name refers to shared object
name that exists under /dev/mshare (this is subject to change. There
might be better ways to manage the names for mshare'd areas). addr is
the starting address of this shared memory area and length is the size
of this area. oflags can be one of:

    O_RDONLY opens shared memory area for read only access by everyone
    O_RDWR opens shared memory area for read and write access
    O_CREAT creates the named shared memory area if it does not exist
    O_EXCL If O_CREAT was also specified, and a shared memory area
        exists with that name, return an error.

mode represents the creation mode for the shared object under
/dev/mshare.

Return Value
------------

mshare() returns a file descriptor. A read from this file descriptor
returns two long values - (1) starting address, and (2) size of the
shared memory area.

Notes
-----

PTEs are shared at pgdir level and hence it imposes following
requirements on the address and size given to the mshare():

    - Starting address must be aligned to pgdir size (512GB on x86_64)
    - Size must be a multiple of pgdir size
    - Any mappings created in this address range at any time become
    shared automatically
    - Shared address range can have unmapped addresses in it. Any
    access to unmapped address will result in SIGBUS

Mappings within this address range behave as if they were shared
between threads, so a write to a MAP_PRIVATE mapping will create a
page which is shared between all the sharers. The first process that
declares an address range mshare'd can continue to map objects in the
shared area. All other processes that want mshare'd access to this
memory area can do so by calling mshare(). After this call, the
address range given by mshare becomes a shared range in its address
space. Anonymous mappings will be shared and not COWed.


mshare_unlink
=============

int mshare_unlink(char *name)

A shared address range created by mshare() can be destroyed using
mshare_unlink() which removes the  shared named object. Once all
processes have unmapped the shared object, the shared address range
references are de-allocated and destroyed.

Return Value
------------

mshare_unlink() returns 0 on success or -1 on error.


Example
=======

A process can create an mshare'd area and map objects into it as
follows:

    fd = mshare("junk",  TB(1), GB(512), O_CREAT|O_RDWR, 0600);

    /* Map objects in the shared address space and/or Write data */

    mshare_unlink("junk");

Another process can then access this shared memory area with another
call to mshare():

    fd = mshare("junk", TB(1), GB(512), O_RDWR, 0600);

    /* Read and write data in TB(1)-((TB(1)+GB(512)) range */

    mshare_unlink("junk");


> 
> According to the abstract of Sileby, I have two questions:
> 1. Would you plan to support the file-mapping memory sharing ? e.g.
> Prog A's 4G memory is backend with 2M hugetlb.

Yes, file-mapped memory sharing support is planned.

> 2. Does each mshare fd only containe one sharing VMA ? For large
> memory process (1T~4T in our env), maybe there is hundreds of memory
> ranges need to be shared, this will take too much fd space if so ?
> 

No, each fd can support all VMAs covered by the address range with a
size that is multiple of pgdir size.

--
Khalid

