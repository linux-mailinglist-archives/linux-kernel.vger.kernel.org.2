Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12DC839E735
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 21:07:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231360AbhFGTJh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 15:09:37 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:40946 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230311AbhFGTJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 15:09:36 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 157Iua8S082590;
        Mon, 7 Jun 2021 19:07:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=ferFR35qsNG1+lh4Y7XeprnaZaF9qxy/0Ajii4iSdz8=;
 b=gD5SWR9NbzWT7lmWhTKr/GeJQsb1yt8UmSQdcMqzDDfLy6b3vl2FAKsDU9Hszn5tgkqs
 CPAFWH6w11C9JhxFqEjHYp38dvt8yqATNUNSiMGP890GxOPR6H6qHTNBKX6h59JPomri
 putBQKEaRFtk0whWFnOLMZG2nxYKPpB9A7xXjjl1NSinR2MqmuywiASVQFgHQF76H7g/
 ayOYHolcBKnP8Fzd/a3J/Tg5DKyznElFL66rl4Yq+TviFYM5Fp8UAXFhS+1mRqHueGUW
 mq/bTynnlvsxpdmPq0ipvSrrzfsHXuq6tRdyJFKKy239eBbdkVpMNOj0N2ln8/1uZgqX 0w== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 39017nbw4b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Jun 2021 19:07:33 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 157IuxdT040602;
        Mon, 7 Jun 2021 19:07:33 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
        by aserp3030.oracle.com with ESMTP id 38yyaaaxaa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Jun 2021 19:07:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c+2WLCgKDiljh8bvOzbZSEBReZ5fxQmHsRP067CGjpw0smVK4GfWX3rQ1M3jtR1TA0kJrTJAUYkKiFXAepzUDtMYPI7ZnKINT0LkBoSqrz/mMcIvUd6LlIParJpeieQV1yPYnf6Wrq6SSuKr2VfFWaXJ0Cm/x16jsAe/R/8pHvAFi0sNXBo2Wgw5E4IfqCQNM4wceKyrr763oOdMpV79JHV4DCrlO9tesnDdACxyqzmzev79kusPpxpRbW6GBWiBbu8SaRIesx0KqEyDKaHopY96hFgXCz/9xnAWqHWAgr82y1OyzJo2/bRWHom4jLk3DQtST0R/HdxhA0B18BYjTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ferFR35qsNG1+lh4Y7XeprnaZaF9qxy/0Ajii4iSdz8=;
 b=d6N70ZHD4tzrb3hkiyjvO5nfswFcGU4rSDpSs+fhmz3FyBIzpaFGVCafTI7/NfBG/R0/LbkM3SqBNWJJGLmIN7pC5FIAyfcYGOkn2QJM9txRuWjwVNQW+jypfuK6qlddx3RBm6xs+YH4VrT7V05GmWAifIHxXYhSPbZmrmpLOa84JFwZ03fDQqQECbck/QFkuyLEcIgRRM+C2bkl4Vo0namKaKguaF6oX86/AZOakTz/a/lrcNcGKFOZDCU4LxZePK+3FRZSYkc668pXVTMTrzMZzy0CVgytr3qcBlgSpFlE9heIA4YPHpITm5MJo3puBBR95G3SY9vwjedHhNCf8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ferFR35qsNG1+lh4Y7XeprnaZaF9qxy/0Ajii4iSdz8=;
 b=bS5pSRB6tJxTfODwiun+pQ80Yzn7e3/MwsOld3Hi8e0/wqEKZ83fBRrif90L00p8m7tfcl5TrwmlHVF2Y2XX0XN61QqCcwT4J+vJvHOi53L2D5OcjMmaNZH++bkWy88fKTRfZKophEeKmk/PqBFIHnz8u+wviL/DFIyqFqh1peU=
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BY5PR10MB3969.namprd10.prod.outlook.com (2603:10b6:a03:1f8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.27; Mon, 7 Jun
 2021 19:07:31 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4407:2ff6:c0a:5d90]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4407:2ff6:c0a:5d90%9]) with mapi id 15.20.4195.030; Mon, 7 Jun 2021
 19:07:31 +0000
Subject: Re: [PATCH] mm: hugetlbfs: add hwcrp_hugepages to record memory
 failure on hugetlbfs
To:     wangbin <wangbin224@huawei.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     n-horiguchi@ah.jp.nec.com, akpm@linux-foundation.org,
        wuxu.wu@huawei.com
References: <20210607141623.1971-1-wangbin224@huawei.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <3bbe4d2e-1fff-32c1-e85f-bb6227c1d4f2@oracle.com>
Date:   Mon, 7 Jun 2021 12:07:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <20210607141623.1971-1-wangbin224@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MWHPR17CA0086.namprd17.prod.outlook.com
 (2603:10b6:300:c2::24) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MWHPR17CA0086.namprd17.prod.outlook.com (2603:10b6:300:c2::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.21 via Frontend Transport; Mon, 7 Jun 2021 19:07:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a9fb57b3-2965-4b14-f313-08d929e77fd6
X-MS-TrafficTypeDiagnostic: BY5PR10MB3969:
X-Microsoft-Antispam-PRVS: <BY5PR10MB3969222BA462E0CFA728E77DE2389@BY5PR10MB3969.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lVp8SjkZUbJR7/UXadTilooFuDtOMdEDU0ajR8RaeqnnF7JWDoOYzQLsGRTcI0DnihmltKR0agOp0YTVYDBrUTFBWvB0+USyQntCMbSB6S2NMWvw16hUBG/ki7ogASo9zdLsmYpoImC0FsLS5JSSH+CWG9xMxyamyLIR4nlUAwBUYy51rPA0SEsoqy5pxsF23G1zYOCoRWlmL21D4vKTDkQ7r8odx/AjCSmavcnb9+8lzSsHC8MHxn9s/xRWbmc7r0JthfBFVdF5fFhx2ONqjehBg9immMBO0jsNcjJeYJjj16TKqvAw5eWEpPO9TP5pwcBNSTk/PcIagfvGdbvIIi+4MGJehq/LA29l8lMYD0oiCWGtTGlFdaxhzI6GoismugqApIxR8K2BbPf27cltcRSlW34AuE5JncTxEEB+N5vBw1UqdGalyL7QTKK4IG5/oymrFyNH1pj5hv5C1a0p0xOiNXuv4X/pU06o30VrhwSqSH1/E5yeCF8gnUfBWXtdrnaakvbJukCq8Ko3m6nuuyA8GTqCkbEQu04zcoXiwGDIkRdtoNFOfZ1XSUrnjUIDa708PjFdhRSlTKFvSrH8oxtghJb3UivZnjdeoBAbO6cRv1IqKd31PIlJu80Pp1ytvTvlqY13KQi7N12aZQIRKLWoL7ifaW9TDGZtfwEHJRXY1/UgTccCbyTyGa6zkWHJxBc0EFGxf5CUQMR7l8LTVw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(396003)(346002)(136003)(376002)(366004)(52116002)(26005)(186003)(5660300002)(478600001)(31696002)(2616005)(956004)(6486002)(316002)(16576012)(86362001)(2906002)(31686004)(66556008)(36756003)(66476007)(66946007)(4326008)(83380400001)(38100700002)(38350700002)(53546011)(44832011)(8676002)(8936002)(16526019)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?ajBOaXFXOGZGOG1SU3NXczkyTXlUTTZXVXpVazEweG5vY2QxeE9uOUhERlNK?=
 =?utf-8?B?YTN6L3RoZEhuK00zclFtYXJUdFB4NjExV09odldQM2pjVmxEQ09McE5uUGpt?=
 =?utf-8?B?d0Vjd0hvSmc1czBHN1drNDNvM2hiSTNrVVFoRjlhRVFyOHJ2NTN6TDhKb0xL?=
 =?utf-8?B?NzlFVWpMQ2YydmZDSmNlZUg1aDJFL3VzaEFZT1RKYVB0b0QzWUs2bWZrMWdF?=
 =?utf-8?B?R3U5SEJjRTNNaU5oaytJTHNIUC9RK29MTktFdEx4TVJSb2IrUTNKVm43REJ2?=
 =?utf-8?B?OFk3clRWQkYyejE2Zk5INmgwMStkZlArMjIraEROOXdNcHNTTWJjUEV6cjVk?=
 =?utf-8?B?UXl4MDA5eUdJT1Fja3JCQ2oxRUtYMW1OUm9hcnVOQ095T1RTVFNKdldjemNY?=
 =?utf-8?B?MUUyQlY0NERCTFlFbVh4bTg3VmdHakt6eER6WFZCa09VaW1wSmp5blFoUmJO?=
 =?utf-8?B?eGFMY2pZWm8wL2crVlVIaHd2T2xzUitRTVN3STJVTGRxRlRqbVp2eTd5Yy9E?=
 =?utf-8?B?Q2NjR3NBMzFIRzMvZWdhVUNKM0xNbkVaL0lUdUFrT1c0OVpXc0F3NmtBSUdm?=
 =?utf-8?B?OTl4Z0xmRyt1QklkSEdGSHdKQ1lFanA3MG9LalVpbzlxMmFIa3J4U0RzUjhQ?=
 =?utf-8?B?MVdRMEpjK0Y2aWd5Rm9lUng2bkxSZ3BEeSszZ1dsN0tYQmV0cHdyTVhpNVp1?=
 =?utf-8?B?TnlSU2cxV25wcnZSU3YvcUtGUUJ4YlJPYno1RVBnKzRsdC9tSWs5dHpGbnVH?=
 =?utf-8?B?Qis4M2hZWjNmTXNNZlJIVU94R0YvcVhWY2FBbVV5cEJybGJEYVdwMTVoSWs1?=
 =?utf-8?B?UkliUmFqa3JiS3dFN3hZdzU0T3ZiY1dSYWRuWnNIamk1dDdCcHFPK2NGSjVK?=
 =?utf-8?B?Qk01K21ad1N2MVJrMWMyVXBNWGZMSXZDTWZmdDJGM21QbmJUS3BqbFIxajBn?=
 =?utf-8?B?T3lPc3A2VStWeWlSelI0Zll5RXYyamlIU1VaK0Vudjc4VzlUSG1GMzV0OS9R?=
 =?utf-8?B?ZGcxdEVqODl5bVVWeXpDRUhxSmJDdkgyS3phNEFyemhLZnBvbVVuQ2lWWDZQ?=
 =?utf-8?B?ZmJGOUhFRFBETS9LUm1ETFROWTgrZVZrZGxEN3l3T0FHY3g2RUo0a0tKamlx?=
 =?utf-8?B?TFZUSGtzZHFOa0RSMGtZcjRYQjN2Q0hKSVliT0hnNUgwQXVTdjRGMG0rRGJk?=
 =?utf-8?B?TzYvdkpVNFM4M0JhVlA4VVlDVEVpWWlSRXFyZENDQVZYVVF4QWJ5cXRSN3Ri?=
 =?utf-8?B?QXhVM0pMY1JFRU81NWhlT3VrNzNERVlEVE4wL3pSTXpmQnViMGhWUU94RFRE?=
 =?utf-8?B?RlE1T1J4NlZaQXh2allYeEJVS1I0c1BwSXFsM1l5WDE3VGhuS0lqb3F2L3Z5?=
 =?utf-8?B?b3lwVHBLM2xOTXVtTk5tYkd2blBjck5oeUowaVdvU2hDdFQ1SVhNTmNrT093?=
 =?utf-8?B?T2ZKSnZSSC9pU2N2MWp0ZmFhR0UyeW5HL1d0S2gwZ3JId1Jlaml1UGEyMUc2?=
 =?utf-8?B?aXhJWGVyZmg4S0pSL0FBRzd1ZTJCMThyZk1SMW1DZDlvUWhZWWIvbHZYR2Fi?=
 =?utf-8?B?N1JIVGp4UHJCU055VURtaFl6ZEkvaS9HdnEzVjdoVlFuR0F6enkweUV6RE0x?=
 =?utf-8?B?dFdLTGdiM0ZUQUVZR0k1aVdHaHozUlZteVZNYTBmeFRVaURvVG1BYlN1dHA4?=
 =?utf-8?B?S0FtWmt6d1NVaW9WMDh1cjVmYzc0ak5QOUE5aHhwMjRxL0V5MjJYRjJZbW1F?=
 =?utf-8?Q?Mc6oFtR0PaQRM52ftWWwAr3iEfb5XTcc8c2HFBj?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9fb57b3-2965-4b14-f313-08d929e77fd6
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2021 19:07:31.1241
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XA4nrS0OUSHWsye2um77Xn6W10xWCePG7n3xUA4KRyjGETbjaJS8zrIcfJd4+cqO0QuCLwzWW781YST+zCv/Mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3969
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10008 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 spamscore=0
 adultscore=0 suspectscore=0 mlxscore=0 mlxlogscore=619 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106070130
X-Proofpoint-GUID: hpjudxQMlgQ6NWKWTU5uV0NtLZJCYhcU
X-Proofpoint-ORIG-GUID: hpjudxQMlgQ6NWKWTU5uV0NtLZJCYhcU
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10008 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 spamscore=0
 mlxlogscore=863 phishscore=0 impostorscore=0 suspectscore=0 clxscore=1011
 mlxscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106070130
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/7/21 7:16 AM, wangbin wrote:
> From: Bin Wang <wangbin224@huawei.com>
> 
> In the current hugetlbfs memory failure handler, reserved huge page
> counts are used to record the number of huge pages with hwposion.

I do not believe this is an accurate statement.  Naoya is the memory
error expert and may disagree, but I do not see anywhere where reserve
counts are being used to track huge pages with memory errors.

IIUC, the routine hugetlbfs_error_remove_page is called after
unmapping the page from all user mappings.  The routine will simply,
remove the page from the cache.  This effectively removes the page
from the file as hugetlbfs is a memory only filesystem.  The subsequent
call to hugetlb_unreserve_pages cleans up any reserve map entries
associated with the page and adjusts the reserve count if necessary.
The reserve count adjustment is based on removing the page from the
file, rather than the memory error.  The same adjustment would be made
if the page was hole punched from the file.

What specific problem are you trying to solve?  Are trying to see how
many huge pages were hit by memory errors?
-- 
Mike Kravetz
