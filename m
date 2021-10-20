Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B62BD4355B9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 00:08:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231183AbhJTWKm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 18:10:42 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:51140 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229695AbhJTWKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 18:10:40 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19KLGtxp020970;
        Wed, 20 Oct 2021 22:08:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=cfhOdlzqOyHfl0JkbLNEAC3QbBhoH5x3zOP+DYgdKD0=;
 b=nPy8MpOTHjlz29NSKAWv34gBtzSG3U8VzMu7GQWQw8B/u1w8dxZ/XPOwP3xQLpFL6WEE
 xsjJmBiev5/gv6O6jCTl0Pp419WazMhhd/vXgm5yM08VAYrk8zF3jTE8Ht10svznH4yz
 UegznNU0ZFeGXJ4kXF4b1T44C8jNYf2UYr3elTKNHGARMZzKeWc8FDQSNcq2IdBlSbfQ
 cWIPTshclZFafU7tJuNHfphN1Y5lVl4RsuWyaRTu9PcEh+nk1b1sUMB5fqa3TqeiVmmQ
 xXGv6pEChIWn3IAOOIAeqin0SEjOlT65mECqsPyVS33it9PIKpJzEB8upJeOHiOztY3t eQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3btkx9u4cq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Oct 2021 22:07:57 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 19KM7D0A196148;
        Wed, 20 Oct 2021 22:07:54 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
        by aserp3020.oracle.com with ESMTP id 3bqpj7rsqb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Oct 2021 22:07:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SJ4AQL4BeWsKAxwfroQokZQmLc8K5SdUbBoGVn4ay3d4p6aVwUFjVr3LoUNZ2ihUay2lkE154n1fOj+g7NQLD4/427Q4b+u/VEJtbjvbgTUhopdBQCchztt4mHrING9XbciTZr5EAY5qKP6fKE1pH8MUp2V8pPXSBtVhCJUye9Qtw5gfal/eagR4a4JoU/pgfhU8bBF7Px5GmBQFQD4dQqZpfDfxtmjvp3pJdvmd44+eyZnogUrRrmIlfUh59ePkJulW4oAHgYiF84Kvokwa3t5MP9c0QsOm6vo3Nt32LzTY8ylYC+53jD5CMP8dKTX5pUpONZBIqyDo9Nsd1Jj2hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cfhOdlzqOyHfl0JkbLNEAC3QbBhoH5x3zOP+DYgdKD0=;
 b=BpJ0UhdM9AAX7GrLTXO+2fafFft5aYULdvU4NN3iI5LsqakSfqRSPIiNa07iweEcFhMJUVB4VZjROOCMwngYqqG2RargTO6S1jnpgnqfuFu5Fv6FTNbHpAa9gIJCmLte4BAdcpTLHLJbevnwpEUeguWDBt6yU61rcCX+21Tltu88RD+dpqAdZVxeFWmWl/Ajdkz44MOyD3ti1N2nswY8z+4kNU/CX12YFyzispdwNwYcgTjZH1vyRD7eOUfPxl0YNO1oWfysgCbPdDfctEjo1f8jEk3XrdaafHjptxPKTSROs/liW97jOmh8nLExrTETX3Fg4h03+Q9EGlNga+wNTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cfhOdlzqOyHfl0JkbLNEAC3QbBhoH5x3zOP+DYgdKD0=;
 b=eKquhEZf+TEAAFV70arbbimq65HIHEHiwJPbS315yqOW0oj94ioa8Bl+9nhpcQlzOorqB1/JtLOypokQ+L5gm2W2XO7rcw6bOpO3jMp8AVQzUF5S+Iu9qvlliizd7grrl6lAnJYmU6YpxAePtCIKNJKipT1QgbGUej3d6+NCN3U=
Authentication-Results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB2438.namprd10.prod.outlook.com (2603:10b6:a02:aa::22)
 by BYAPR10MB3606.namprd10.prod.outlook.com (2603:10b6:a03:11b::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.17; Wed, 20 Oct
 2021 22:07:52 +0000
Received: from BYAPR10MB2438.namprd10.prod.outlook.com
 ([fe80::8057:9886:f19c:a025]) by BYAPR10MB2438.namprd10.prod.outlook.com
 ([fe80::8057:9886:f19c:a025%5]) with mapi id 15.20.4608.018; Wed, 20 Oct 2021
 22:07:52 +0000
Message-ID: <af04bed9-ce2c-ee8d-f322-f3e33c1f6a49@oracle.com>
Date:   Wed, 20 Oct 2021 15:07:49 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.2.0
Subject: Re: [PATCH v2] mm: Optimise put_pages_list()
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Mel Gorman <mgorman@techsingularity.net>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20211007192138.561673-1-willy@infradead.org>
 <20211007123109.6a49c7c625e414acf7546c89@linux-foundation.org>
 <YV9eueky+lBfSWA3@casper.infradead.org>
 <20211007163554.d9088a65f0e293e2bd906a56@linux-foundation.org>
 <YWBS6iJr/4RJ+hNE@casper.infradead.org>
From:   Anthony Yznaga <anthony.yznaga@oracle.com>
In-Reply-To: <YWBS6iJr/4RJ+hNE@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN1PR12CA0066.namprd12.prod.outlook.com
 (2603:10b6:802:20::37) To BYAPR10MB2438.namprd10.prod.outlook.com
 (2603:10b6:a02:aa::22)
MIME-Version: 1.0
Received: from [10.159.138.188] (138.3.200.60) by SN1PR12CA0066.namprd12.prod.outlook.com (2603:10b6:802:20::37) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.15 via Frontend Transport; Wed, 20 Oct 2021 22:07:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 34339b6f-f316-43db-5037-08d994160fcc
X-MS-TrafficTypeDiagnostic: BYAPR10MB3606:
X-Microsoft-Antispam-PRVS: <BYAPR10MB36065E2C9A483ADAC33B112EECBE9@BYAPR10MB3606.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: itxQA+SniZt03HuAzuTs3PeMcYSGiaipFJJuGhYZ0wJizCnRx9KOwajgu4eibnapogaoKIiNQ7bzNmK7z0V9mUknw86VfV5OexXVnoH98BHnDBdla9eSKaiH2CbS4fMG3g6E6e2tsjLzTmGAU7uwcRJMtJke/HjJV8ln0e7xR2q6flhDWR74vubvK2VRLrV1IX6FGnSBI8rEhjHcYqzfhWywN4uITcvFeBysqgY5nvrd3tQnBy0eiktadp1fo+zP8d/jGeE0eaBjFbqnOusC5AhPgPMnyPE73wHhA04SIGzYxNnNW7N7fBkX+dNoIXbwD+xRgihGdGX8yYw4YPfcNkzwcYm4Qaux28q7XlyIDryxkRwvSu6g6zH7S4jtkD0ks1ftOPVcngqJELJs0V1ekB8EcMYw4Exp8PUn61aLWdZ3SF0aucw3g5/D/LB2ZGmiR+w09cgwSvRfFTsk+2nCWI2LQSgdj1TpEekVxIzQYnSFKHKkukkNdKEZJbu7TCVb5o92l3KccKksrKOxmDB783h0oXKgniRv5YWR4zBCHJ97fzlS+/suns65Tfd1CN3qfSXHeUBAoCai1DdlDKKOEhANG8+oatqS1NSTk4rjIsrKwkAC/W0n7QlSq/YMINDmwy2VUFwYtvruBtrJHsi0qIWF9IwASERfELaqR6wrvSLXHd5wYBSyd9YkSiQ9oX3iK4xnNhDDAPcsx9y1WVe7ExMjeQu7dm8WRJmmuZ2qvxY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2438.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(956004)(2616005)(44832011)(36756003)(4744005)(26005)(8936002)(508600001)(31696002)(8676002)(31686004)(6486002)(110136005)(4326008)(316002)(5660300002)(86362001)(66556008)(66946007)(66476007)(2906002)(16576012)(186003)(53546011)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UDlETzExanlQUk5KUmQ0ZC9QdWNTdnlJSG50SnhOdHh1c0IwYm1vM1RQUmRr?=
 =?utf-8?B?QitGYjk4ajdEM3hkZW4ycnVjdG9tWWdIZXBEWlVMc0I0MlNpUGRjbHpIUCs5?=
 =?utf-8?B?MjBObXpzaFJvVXc5bFB6a3dYaXJBT2hxaURMVTRLTDdHdFdRU1l0UWtHUzJ2?=
 =?utf-8?B?N1lSQlQrcjk3SjBGbGVONWVGdGZ0RkxSenU3WGhGSThqcXF1TWo1Mm83ZEhL?=
 =?utf-8?B?ZGVGOGpyeTFsVDNzc3RsNVB3SHZ4ZEtTRzRoN29UbWNlQkh4ak5VSk9HUXVG?=
 =?utf-8?B?c2x1RmR5MExPamQ1c01vaTBad29pRm5iRmVGNTdmdDRVMU9DQlFMMkxTUDZG?=
 =?utf-8?B?UTkzUHdQbkJLQjNvR3hPZXdzOFVhRVNZaFl3TG40bFY5NDRua2RGSnExYnpI?=
 =?utf-8?B?bzRRcE50aXQ2NkpBMjhLME12T0NqSGlSYzQxTDg3N1BVVkpxMEo2VCtneHM0?=
 =?utf-8?B?VEdyemxBTDVUOHN3bmJkZmFNUFBtbXNPWXhtUHZqakQ5dzl3TTlGN0VuS3pT?=
 =?utf-8?B?M2Jtak1TQmtObzBteDlYNmRicVVBdnAzOXRZSUQ2NmYvYmYyakV5SzN3WmVv?=
 =?utf-8?B?SG8xdkhybllzNXcrMVNzL3BkVjg5UG9RNHJ0VTN0TUdBSzQ5UmtyU00wTThK?=
 =?utf-8?B?WnhVRVZzT1lDZmFmTnRuN0pGUzVGZHV3b2ZleThVVm8zZS9MaG80NHk2Y0Ji?=
 =?utf-8?B?OTZpdGRGQU5nSXBoQ0VLTEZwOHNvNTFPWmdTbmgwdE9OR1NvcnJEU3cvWlZJ?=
 =?utf-8?B?WUZtODM3b093ZkErbC9sMFRFYnF0dEozbHZXT2JpL25xdVhQMmhSMWNOc1h0?=
 =?utf-8?B?Y1UxVG5udlc5RnYydVZoNnloOUVDeXZnSEZhSHNJcE9tZ3dVcTlESWNFYzgx?=
 =?utf-8?B?NEFuL2NUTmhhMlNucFpGMDFUdlRZTFpwUm1lRjBib1BSRnRrVDUveGtrSFpC?=
 =?utf-8?B?aU8xekkwNWNxU2Q5WUJjdVZ0NlhJZXQ3RVJ5clZnejcvcXNvcmRENnN0UGda?=
 =?utf-8?B?aDlxNWsyeUlpY2NCUEVSVXBYUVdKaXV6K1o0MkpOOFgyeEdxRUt6RWowbHVJ?=
 =?utf-8?B?WUdZRUpZQ01nUUNyWENOY0xOd3FzNDJ5dEJEWHZoejhraEVuclZ2SWdiTjNw?=
 =?utf-8?B?Sk0yeDRyZHFEVDRtRU5YWkxxUml2Mi9yQkZaSG02QXZvRTNqQ0ZSd1pmSlNP?=
 =?utf-8?B?aXpHcjNCSFlBc2w5MHZtM2prY1RMSG9iWGZ5c0V3NTdsWjc4bTFTSTFlNHdk?=
 =?utf-8?B?SWljTXEraCt0WDMrTU53Z3pPUXN1aCtCT2tnUmxyUGYxNTRXLzhYekFmMFJE?=
 =?utf-8?B?OFBDVkhCT2JrZGZZTTRQN0RlYmtWRTlTWGFRaVVoUFlyakI5R1R1Z2NMeHRn?=
 =?utf-8?B?dmlOZHRENHFVOEhPNzI3WElYL1VYZUQ5elBLOXFuVGJ3RGI0aHpqaThhR2dm?=
 =?utf-8?B?dnBiR0tqZXlMNTFMSDMxVlBCbFZ4aXZ0TnJ3L1lpOW45VDdYSThJMU9yTVly?=
 =?utf-8?B?UmRLekNSREZaY2JsTFdLaHY0dTliaVJMZmtnSU9iQ0pxWDkvcGs5NDI1Z2FO?=
 =?utf-8?B?MUE2STdzUXBYTWdhLzdWZkpJVTdDQWxIUWE2ZEVCOTRzcTArYU1teDFpS0tP?=
 =?utf-8?B?T2xWcGJTSHBkUFpjMnBRTGF2UWFKUFoxNzhVbzJ1YkI4cFBMbzc5WE1PMEVO?=
 =?utf-8?B?RjJ4WkxDTDVuY0oxc1JUQ1VXNS8wbHoxWkkyanJFeUR1ZTFYK2gvNzdONXFR?=
 =?utf-8?Q?8yNCXkTrXgXVsNsPah5cTdm+eGtFgTlFWbCaRIf?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34339b6f-f316-43db-5037-08d994160fcc
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2438.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2021 22:07:52.7044
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ehfhgn/kjfwf2r/GTB2hsqVUI7tnRHxsFwnXINMLOVS5U2djhz4Kc3QB29pkz72EF/dVr2p+glkGY1qFF+rfAF8oVybovajDh3iassxV8TQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3606
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10143 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 adultscore=0
 malwarescore=0 phishscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110200126
X-Proofpoint-ORIG-GUID: 3A-sMfaTiMUzxmPG8CKcpGPigPvfOIX6
X-Proofpoint-GUID: 3A-sMfaTiMUzxmPG8CKcpGPigPvfOIX6
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/8/21 7:17 AM, Matthew Wilcox wrote:
> On Thu, Oct 07, 2021 at 04:35:54PM -0700, Andrew Morton wrote:
>> On Thu, 7 Oct 2021 21:55:21 +0100 Matthew Wilcox <willy@infradead.org> wrote:
>>> My first response is an appeal to authority -- release_pages() does
>>> this same thing.  Only it takes an array, constructs a list and passes
>>> that to put_unref_page_list().  So if that's slower (and lists _are_
>>> slower than arrays), we should have a put_unref_page_array().
>> And put_unref_page_list() does two passes across the list!
>>
>> <quietly sobs>
>>
>> Here is my beautiful release_pages(), as disrtibuted in linux-2.5.33:
> I think that looks much better!
>
>> I guess the current version is some commentary on the aging process?
> I blame the guy who sent cc59850ef940 to Linus back in 2011 ...
>
> I think Anthony was going to look into this and perhaps revert us to
> a pagevec_free() interface.


Sorry for not responding sooner.  I have some cycles so I'll take a look 
at this now.


Anthony


