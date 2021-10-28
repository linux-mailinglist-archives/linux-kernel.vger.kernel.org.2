Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 057EA43E8B9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 20:58:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231151AbhJ1TAs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 15:00:48 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:52632 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229645AbhJ1TAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 15:00:47 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19SIk69s021602;
        Thu, 28 Oct 2021 18:58:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=OZS+twtcft5wr6hjuRRp9E/3gTstdgRG1JceZBp4DHw=;
 b=H+ppbqhANTXZDUJy/DfKSPap1MUN0I84H5Gq7Po7n+/wM44n+o1HTcD7NA3bZOzBgp9S
 RkW4De1qcg6L0YvVMEIjPnt4QXScC8BthlzPcR9EPIhehLqkuYDYyLS2Aj+mhsLmChO2
 ufXzRZ96P2QIGWo5SCuhfi9Us5Js6u7qU1LzlD/0pRTrG7V407m2I7SbS6gMBBediMJu
 dGy+GaNDrr8FDsoVNvoD1k/n6N/IHq56yZWzOrpdPXavG1Xqu+mMTMKt05KLMGSlkiJK
 XFJfOaqNoheI9adgtK8jH0dPWyfn23BI+r2LbzLuAn/jSfr3+2d1/TgZgzCXqWuXWls7 GQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3byja2caqc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Oct 2021 18:58:11 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 19SIu2oi087288;
        Thu, 28 Oct 2021 18:58:10 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
        by userp3020.oracle.com with ESMTP id 3bx4gt8q1c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Oct 2021 18:58:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m4QnsVBf0YeUO1m/YOf3lbLnRoySOgHThQyXIf6QdubUC+dwRYtkrRObU6RfdfnSJp9PuZyCInZ6BECa3E4Iyjn5CeYtPV/QYZfUl9jlsALe6XQjmslk1JPC5At/F8HPY25wbB89lmo5mt4iqCHpp5DdELJtZqMrUbBhrkhGE5tkNj5ElbYvaitbNf5vNi/9r14ALZAiBU4MaNE0d+60paCwkm1CrYCmKjG1izwRDfAPBCuZgZdmPLJAhDATQKTh2kFnL9QLhgqf2okl277+jebqbSOFLBiyoFzmi0n01ICduLB3zX/oO8R/QLaP+R/ug5RVnJw32TjPaYfyyB0IQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OZS+twtcft5wr6hjuRRp9E/3gTstdgRG1JceZBp4DHw=;
 b=hs5F83905MqL0X71fSRAwA17so/+3boG/cBE0ps65gNiNLtzjvANEeqB3QqBaeqvcNw0rwrYgapNlwtssU8hsrwNJaXge7UlP5d99yHmMQFefBs2G9o9GDOYPyaMlJ0vXrK4vWrPrHnqXu9foRlnIWIpfOYwFeopOMNXa3O+8Bo/pe1tiGzyHqHAU82F1ESldU42t8/EAYRPJG1dSzBivahvec0c+uASTHlxz/3QCRrcXrQINJgPMB+h71abffLCVqIL8B8c1y5NzfUxsdVaYMQ8LZebggtEWrhwJcvlSIAz+51tHCE7FzljbWSbPIFrF5LTmBl1yr75bGO/k6MqDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OZS+twtcft5wr6hjuRRp9E/3gTstdgRG1JceZBp4DHw=;
 b=v+oAF68POPxaaJNd3tbUwIEcVCqgfSSjeoFB3wzHFtPsaB77EtUCfos03uWNPH97cOXPwmmwdXASY5l3o6AI9rfTRoKFrXiVdHi/UBJbPP+5Go5xII4Gu65uZoH6JqMaaCxuI+NHu4Sp4vX8/HenFoDK5GJTdBSbJEl8LxSQr3k=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from BLAPR10MB5009.namprd10.prod.outlook.com (2603:10b6:208:321::10)
 by BLAPR10MB4978.namprd10.prod.outlook.com (2603:10b6:208:30e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14; Thu, 28 Oct
 2021 18:58:08 +0000
Received: from BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::3c49:46aa:83e1:a329]) by BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::3c49:46aa:83e1:a329%6]) with mapi id 15.20.4649.015; Thu, 28 Oct 2021
 18:58:08 +0000
Message-ID: <18766b45-5de5-5978-70b8-8582c30230db@oracle.com>
Date:   Thu, 28 Oct 2021 14:57:58 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.2.1
Subject: Re: [PATCH V2 1/4] xen/unpopulated-alloc: Drop check for
 virt_addr_valid() in fill_list()
Content-Language: en-US
To:     Oleksandr Tyshchenko <olekstysh@gmail.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Cc:     Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Julien Grall <julien@xen.org>
References: <1635264312-3796-1-git-send-email-olekstysh@gmail.com>
 <1635264312-3796-2-git-send-email-olekstysh@gmail.com>
From:   Boris Ostrovsky <boris.ostrovsky@oracle.com>
In-Reply-To: <1635264312-3796-2-git-send-email-olekstysh@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0023.namprd04.prod.outlook.com
 (2603:10b6:806:f2::28) To BLAPR10MB5009.namprd10.prod.outlook.com
 (2603:10b6:208:321::10)
MIME-Version: 1.0
Received: from [10.74.110.188] (138.3.200.60) by SN7PR04CA0023.namprd04.prod.outlook.com (2603:10b6:806:f2::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14 via Frontend Transport; Thu, 28 Oct 2021 18:58:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b3bca456-7b53-4f24-a07d-08d99a44e152
X-MS-TrafficTypeDiagnostic: BLAPR10MB4978:
X-Microsoft-Antispam-PRVS: <BLAPR10MB4978FA82C04EC0CA138A23F88A869@BLAPR10MB4978.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D+PM9H3ZhT/yQxZSXB0E4GguuqEexd0mRtTC8vdRoiz34z/ONada7WPDhViiLxHoYc9TpWXcEQOZDe+PBtK6Vh9jFGPy8V23v3JS6W4+vrCcW4m+39kbvh36qBf0474s1oEaanQTOt+zEjd7w5KfGiW11ewWHf+q082DFXY9jUHKXfwhMrUx0eKgI9jdhDuhA+oR07+l6Tg13jn+la328DjjxLYamO7Lzidp9B73QFy9odT8B5ei0gJBfl43FzhIk5ZNULqgROqvS91Uso7b3O6FawNfSi6zEUVHLAIXnEcM4NU5D9skreZXfFEKAgAIvS/4O2WYfz6KTkrUDYwtJRMNaR/JOPMu4Tr8avlVzhTCbmgO9s9ZUfon3PGPLLMKJ05Wnamz7DONHTERNHpET2cqSotdvaEmM+LyJEJzEiEdK/WRGHkqztABe5iTAQOaQj55yrE7P9MyuUs93z+w8Xaz4FFRgUgGmhkZ1VMSEtT3L/1+OeGeyBUZrZRTjj7uoycMoOHwQ7kJ1p1Caai47WLHvvBa4bJtfdBzucr94EBewNCHJdtf1W5aM8xuhKAXz5mTtiNjWz/puhI8UTfJCbJ/Eee0x0kNyXpca++yMUBlfADZZRJ7pBh7PAVIQ29/3fHEGhK/IHdUIqgSTaiNYn8XzpPyXRyBi2D7rkJYgThMlcLZwAkBvzwUQbM6GzdZm5hJVW8D8iUH1ukoD86zrwPgLixZDKhFocAr9nZ0/ek8dNoTqRw98mkDz2v8WxIo
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5009.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(86362001)(2906002)(31686004)(44832011)(8936002)(8676002)(38100700002)(5660300002)(316002)(4744005)(66476007)(66556008)(186003)(16576012)(2616005)(31696002)(6486002)(956004)(26005)(36756003)(66946007)(53546011)(54906003)(4326008)(508600001)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Nmg4TGZyc084Q0swbHQ5M2xBSkxvRDhTYldLNzRFMTFuWGpZU245Z2lJZTFX?=
 =?utf-8?B?MmI0UHRTcmFPVURSUTJ4bXcvdnF3TEcrclN4azlSRnc4OGV6SG9nRmFuTnRm?=
 =?utf-8?B?b1hubUNQL2RoNUFncXhzNGR6RzZURDBPQTdkOTQrd04zMVcrMlBnS21ZSHBN?=
 =?utf-8?B?SUdvYXJaWFgweVJxNGlWcnRsNkJtODhTaERlSGoyODljRnBvMC9BN2RpN1ZU?=
 =?utf-8?B?MUJaSzVXdngzU2MwK0RjWWcrYUtOdTR4a29SQzY3UWhDdTduMWk2MnJ0bTZi?=
 =?utf-8?B?eFVzdmVvTnFuZHFPLzRPLzhlTzcvVkU5WUZBWEovcXNiSVhyWGZOSFdhZ1BY?=
 =?utf-8?B?TGNoWVhrMHREU1gvTG4vWXZXT0UyaGZMQW54TlRMckpJS1BOSHZlRG1xZHJW?=
 =?utf-8?B?TlBhdmFvZG8zMG5YYytjeEgzUUtJa2NRS0JNTzU0YXFOSWo2YU1sN3VsZGpP?=
 =?utf-8?B?azFObG1UN28rajlaS3lOdk5zckY3N2IycmpMZHBnLy9WVmtReHVsRFRhZ3hJ?=
 =?utf-8?B?UDU4TWRoNDZwbHNoY0ZNTFc4Y2pjTlhmVXI5N3M5bjhvUzNXMGhjRTZiWVJs?=
 =?utf-8?B?SFczcFJIdysxTG5TTGRvRWUvQmplaDhidmtrczBxYmpSOW00N3dOVVRvN2NX?=
 =?utf-8?B?SEVFUXgrV3Y4Vm5CSHZXeFJydFJMejFjVi96bFA2aDcwaDE3VDFFYXVadWZQ?=
 =?utf-8?B?TTRpbkltRDkrakpFMjcwSmFXZkd3NUlIZEtIaHNNSEQrK1Ryc2ttUjZzWlRN?=
 =?utf-8?B?Z3MrQlZTL2JBbzJKMkFUbG1CZCtOUlZ0Z2hOTVdCbUhaQ2ZGcmJoeVZ6bnQz?=
 =?utf-8?B?Ui9DL21IQXhnYkVocHh1YVdYWFhWWFQrNVFnUGJDdjRCWG5KRjR2QmxET1JB?=
 =?utf-8?B?WTQvWk8yNUxiNTc3dTlEREJ1ck1hbjN5NklhWWRMT0VFWWR0N21ybmdDR05m?=
 =?utf-8?B?TlpXRy9jbUkrUmJDSHhIQ0QrekY0WGRqT0RCMElnclBmZ25BeHRjSVBQMGhP?=
 =?utf-8?B?U01YT2E3VWIwTmQyenlYZzVDM3JGRHlsVmlBRitjdGZuZ2w3N055R2RRK2pG?=
 =?utf-8?B?NG1HUEc2cGpRK29WU1FEQ083OStDUHFubUpBbGhwSm9rdGVWak16R3hVSjBK?=
 =?utf-8?B?VTJvNEVuNERzaS9zc1Mrcm5IMFlrSTF1clNoZW11cU1Nbi9DVDY0MVIzQk1z?=
 =?utf-8?B?VDBUclZFS0YzUHZGZzZ1MnpieTd3aS9aUzBaOUU1cVFoR0FaS3ZNSmRXR2hm?=
 =?utf-8?B?ajZnVndwaEc0bVlLNWhvZWcvbERXU2JsYjNneWxEVkFCV0pGemF4R2h2U281?=
 =?utf-8?B?NDQ0eUVYM1dONFdzeWY5Ui9rUHd2aEp6MUtMMEgxS21paUhVWHN4MHlaOWZk?=
 =?utf-8?B?TnBacktQZ2dtalBGdXV4V3ovOFZhcDh3bFVWYllnbnFmVWxsekt6dkZrRE54?=
 =?utf-8?B?MWVKT3pWUldOU3owUGViWkdqN0JaaXpya3pkOUl0ZG9FeDdIZjhDOFlhcllJ?=
 =?utf-8?B?WXpZSFFBU1k1cG9BMXlNamVrZkw1RFg3THRHdU5xNEkraGV0QWlyNEF2dmNG?=
 =?utf-8?B?OU9uUythbDgxcmZ0QVhxQzhsL29QVHk4dmFKRllmRUZmaGVEQWFxdUdia3Y2?=
 =?utf-8?B?dW9nYjVlcE9pRitvd0RRMGRWYWltU0RrYjZDYTFIMkppV1FqOUJkQ21LbU5W?=
 =?utf-8?B?V1ZlUnFwaEdUWUR3S29lYUk1b3liZU9BcjZ5SVExRndkVE9ucVlic05mL3dz?=
 =?utf-8?B?U2x4VytxSGxwRHgzZmc5YVk0bnRsd0dpNFFZVU9Wc2xRcmNQTW4wWFAzQzN0?=
 =?utf-8?B?cnM0TS8yMk42Q29uaHRWUjRXK29BV2FYVi82d1NGMW1FcEZLSlhLNDdWRHNL?=
 =?utf-8?B?eVRjUFp0a2I2T0t1UlBySnBGNCtna1dzbitkOGZ1NXNTbkUzWlAybnl2OEdp?=
 =?utf-8?B?Tit6RnVqWFFGaWFTakszZGxxU0U4OXMzQzVPL2dBaVhpaUJmRy9oeks1UU44?=
 =?utf-8?B?ZWtCN0NsaXpGdkhaYUFTUSttWE5VZlJkZk1qMEZpZ2t1dXlFOTd2T3JUK3I5?=
 =?utf-8?B?dEdYYVdxSjhjem1BZDU0VzNGSzI1N2RHaFlQTW10cUc3bFJBbDhrM04vb20w?=
 =?utf-8?B?aHNMZ0VOZDB5USsvUENDL3VaVW1UQ3huVnI0R2VvWkVBWG9NdlZnODVuSXdH?=
 =?utf-8?B?YUVLdnBUTUtFb1VHMlVwZlZoa1ZGSER4dVdSckxLLzl3U3hyMTV5M2NzNVgv?=
 =?utf-8?B?TjMxTzd1SzZZVDVVR3YyT2IrS3V3PT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3bca456-7b53-4f24-a07d-08d99a44e152
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5009.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2021 18:58:08.0817
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7a84z7jFUQ+s4H0D8f07alk+7cSCs/2BPCuFlCuqXFOnSXo1iKnR2eY7TuvfLmqdaJ9NOaUhXmzL8O8IdEp2XzDT6yjxyGrtzmuIdGgUPl4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4978
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10151 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 adultscore=0 suspectscore=0 bulkscore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2110280099
X-Proofpoint-GUID: _ipTbYQJafJNb5rTTedGLiT93fdy_k7-
X-Proofpoint-ORIG-GUID: _ipTbYQJafJNb5rTTedGLiT93fdy_k7-
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/26/21 12:05 PM, Oleksandr Tyshchenko wrote:
> From: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
>
> If memremap_pages() succeeds the range is guaranteed to have proper page
> table, there is no need for an additional virt_addr_valid() check.
>
> Signed-off-by: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>


Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>


