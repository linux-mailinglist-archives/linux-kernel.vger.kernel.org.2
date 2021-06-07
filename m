Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23EB739E747
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 21:13:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231519AbhFGTPK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 15:15:10 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:10818 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230282AbhFGTPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 15:15:08 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 157JD8Ps024541;
        Mon, 7 Jun 2021 19:13:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=QPl8EIiYuiIgs+l+zgXtwN5ACp2gOulnh7GHL0Vhs50=;
 b=IzYC/ZA8IsvdYFs1o4aVgkm5MwyKAB35IfDyjvMbcZoUK6YjF80wabVUfx6VlzRZg5VX
 N+92DkyA2vLSGMRkjq+cqHhanLjNeVhTJ4irg9c6MknR5Ndt92jwISd2QbB5u21nREQ9
 WJF9JqeXPtYQwNj8Qp5dd/ZNfvttam5rkRJggh/BwtOPZOPmRVbZTO8xM70dC01Dch+v
 MeQCeKUTC0XEKlXVmRaZxQYxMZ4Ep7g20bd9IennNmvLebjF/LGBFXt7L2faOtTbTB7O
 ofuP3FHLKcHOgcAR89E1qmbDt0il1ifExltSgym5XRJYYr6jUlTw5FK2BxxS+ePLeTE7 6A== 
Received: from oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3917d4gbq0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Jun 2021 19:13:08 +0000
Received: from aserp3020.oracle.com (aserp3020.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 157JBfga143949;
        Mon, 7 Jun 2021 19:13:07 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by aserp3020.oracle.com with ESMTP id 3906sqpgp6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Jun 2021 19:13:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TQ/DStLDZEmYrMUgSleU0lHUfaMLfGOtZD4cAncdSGlo8exvfMWNa0vNDHPHbB7ANsG8l983IW4AjFgqgY3NrnY8C+84V044aTd9OoU7afAhD3DHqHK1gW7akB7z0qewEZHghRNey8IDPOGZ8WijHvi0Ll+R/ujMKi1TDZ8ukunmGRHnt2/1S9T2S5ts0vnvBRAyOScq25DfooMwlF4lNL1GG5LGv7FKOa7qIxFWaNS78yBZyWzMLdXiZ1iHTJBbGs3EfJb2PoB9Xqlm64TdYzEmhg59bxZlYncln/Lkq2xVr029SJuVXQ9M2xLXqa2G7Q2sjlW7vitkEccohA+uxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QPl8EIiYuiIgs+l+zgXtwN5ACp2gOulnh7GHL0Vhs50=;
 b=RviIzZwfVjUPmBoOOxwLpyn3DuQ05BGl+L+eRfdorVKfthWMJiqDqgZ9uXViGqwqTJ2MhOapdc33khPVLtNqcUb3FfYFzaUMK2LkEHXLk4wxPophSxN6zS0Yc7mik/y0YocN5vurMwXdxhEmhCRBmxymjEs/qmFbX3pUocPUP625IfN8Ua7zKTsQRo6oD2Ib5A+VOwyI9yC7wbXLkk4mCIxJ3riN9mLWJhaRFg5qvPOcNUV+wLvxhPlBlCjd4GY8bZaaJ8mlESIzSQYiPJ9uRPEfTfdEAg0dEqLl7qvUv1eA8MCuFoYjl5xz6xYkij9S1L/IZVNz2+c0Ns/Px/p57A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QPl8EIiYuiIgs+l+zgXtwN5ACp2gOulnh7GHL0Vhs50=;
 b=SQd1FMK81DWU57iXDnIJH1bBkjjVX+b5YRrDKeNWsRMmfCIu7q73lZNp15Y5F34BaJCxshevoJ7NSEtKba9HkC1y3W8ni5bpJsC3GfWBO+/WshW7pZdY7hiQUn06jdn8wXTUNiLwKbenjQ+ea3hO6iW1MNimw1b4z+alw7zjKvo=
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BY5PR10MB4371.namprd10.prod.outlook.com (2603:10b6:a03:210::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.24; Mon, 7 Jun
 2021 19:13:05 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4407:2ff6:c0a:5d90]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4407:2ff6:c0a:5d90%9]) with mapi id 15.20.4195.030; Mon, 7 Jun 2021
 19:13:05 +0000
Subject: Re: [PATCH] mm: hugetlbfs: add hwcrp_hugepages to record memory
 failure on hugetlbfs
To:     wangbin <wangbin224@huawei.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Naoya Horiguchi <nao.horiguchi@gmail.com>,
        akpm@linux-foundation.org, wuxu.wu@huawei.com
References: <20210607141623.1971-1-wangbin224@huawei.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <b4a6c7ee-5b0c-2390-35c5-3a5255d77f5d@oracle.com>
Date:   Mon, 7 Jun 2021 12:13:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <20210607141623.1971-1-wangbin224@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: CO1PR15CA0066.namprd15.prod.outlook.com
 (2603:10b6:101:1f::34) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by CO1PR15CA0066.namprd15.prod.outlook.com (2603:10b6:101:1f::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.24 via Frontend Transport; Mon, 7 Jun 2021 19:13:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 101d3d6b-759b-4d49-03f2-08d929e84744
X-MS-TrafficTypeDiagnostic: BY5PR10MB4371:
X-Microsoft-Antispam-PRVS: <BY5PR10MB43710F85A5166D8A8FD3433EE2389@BY5PR10MB4371.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nH2mF3FXjr7/FkktrkMLSZTVNXIDb/xWDbhBZNMoGOCli5aziMZ12pQ7rRKzMfHlsjwVwyS2sxY/tI7NLCs05V3RdHZyldCdrMKZ2lWCFagK68gScDaKFdpdSYobpoWXJUpkn1dIux5GIXHgDWqpCEYyPN47EsPgk6b3x1Rrdfx+1yzsH90YpgJjAFZa8Bn7407MoqvdU+Lpo4yTcqiFdxezMqa/UkC/Il3kVbevYy8gtWgwmZXj/MdMcYZJC7qgWh48n9pK51wHrg4l8b0DII402+i1pppY/nO0El11qRaPRbHhqmlnY+mGP6wfkUmBnRc3ngo2G3juD8d6/1phjt/hS3KppFV+eoXyLzMs0IbiKZlOrLndDKHiudv7GtsZHIe6n6CAg5ieXRqETAh4F6xsXLL5AWF++X7Cc4Bw8usJmygS/fRmOUBnIqn598bkBoQyf/dKDHmSHTLLJ5GBkbKDTt3D3BUpUFlIch8Qkfd9I0ze6rmXSKUhTdxYx+IuJXvetfElvzmZOUwBlEmUFwIZAM07fG1s8+6Ej1x+04I6ncBBTvSlhWEeZ+QX+hKzpOTCRCTdVt7Zc23ri2G1Dnp8oo36aHuvQKLwu1jYw9NTEQOVx+nMYKDREa2wspMbJKHWdkCY/dNXAU+azWsQa1ahcJuU66AE+N54Zroa5oFbVMPQiBdTK7HpJ+rYgF1AI7+cazt7h6oVRfkyvUD6Kw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39860400002)(346002)(396003)(376002)(366004)(52116002)(4326008)(5660300002)(6486002)(86362001)(16576012)(316002)(2906002)(31696002)(16526019)(31686004)(83380400001)(36756003)(26005)(186003)(44832011)(8676002)(956004)(2616005)(66946007)(8936002)(478600001)(38350700002)(38100700002)(66556008)(66476007)(53546011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?RWFKNUplbUFkYXNEOGpiUDdTQVZXdm1ZT0VCR3lMQ3QvU0VIWHppZC9yb05m?=
 =?utf-8?B?VDFZT3BNbEpRdno5T2xYREtNRVYvQ3ZnWjdMT0pFbEo2bS9PRFBINWJnYXU1?=
 =?utf-8?B?RC90WElSdWFVaVR6WGl0QmlqMkYxVGM0N1pSc0sxMjRPK29xTTI2QlczUjBO?=
 =?utf-8?B?K2RydlVVTmE5RHBTZHhyL21lNmk5bjNxZkpqeWhPMnpRQnRrMGVMZW5GQUZL?=
 =?utf-8?B?Z0c3cVgrR2JoOFhUUzg5c1dseHk2ZE5GaVN3M1diM21xRlB6T2FJVG9Tajlz?=
 =?utf-8?B?Q3N5MDg2SWpNWGNDMUY3Q1BkanVxeW1iU2NLTXUvZk9HamNTWkFkOG1ZNzFO?=
 =?utf-8?B?My9obUc3dlVzeHJWUjN0bEsvbE4wWitRY0dmQkQ0SjlOTFdzTGZQc3VqTFps?=
 =?utf-8?B?K1hHclBVRmRxQWc0VnZMRW5QOW9NZXd0TSt1ZUlzQkRMSnV2YURyeXJXbzJY?=
 =?utf-8?B?M29HMndkWWJpRURHYUJlY2M0TzBOQmNKc2c0V25MLzdLcGNSK1c4UUwvVVF0?=
 =?utf-8?B?SDBOZ2psTEhYSHJNS2kyY2RaYUk0RE9CekZoY2xFdmJuNDY3ZXpua01DekhK?=
 =?utf-8?B?RFFJTVlBWWJqNDJsVWcvK2x6YysycnVReE1ObTAwd0U2ZGJQcEp3YVlKWWNC?=
 =?utf-8?B?L21Zcm9qazdVNTRhYjZRa3l5L24xRlF3bTkyZEhmdnAydXJodXQ4TFZwaXg3?=
 =?utf-8?B?NnhwTnFRd3llci9nUGw4Ym9nZHJmamhaNnlXSUpJR1o0eksrSE9GZWhLR2l2?=
 =?utf-8?B?aGJSeHhhdThoRFcxYkNlMVNUZ2M4RkJHcENBK1liN0tEM0hVaHF0YS9rNURG?=
 =?utf-8?B?N0xYY0lTci96ajJsdG9ZdHlqKzdId0RBdVJOVE41Ujl2d216WWlTMVNDVW9u?=
 =?utf-8?B?bVROMThXVW85L2xGQkNzeVlmYlBBQjFsU1R6Y0djRDVzWXdtRyt6Q2ZCTUVw?=
 =?utf-8?B?Ukd4N3E5ZnhzeWQzM1cxRU12OHJwcFlmaVZ3V0h2amNMN1FheGt4eldtaGYr?=
 =?utf-8?B?RHVBaTFobjQrV0EwWXZEaklzQWpOQzY2SlMwUU8wbjRmOC9IbUVTc211ME9X?=
 =?utf-8?B?d3dJeW8ydVRHT280WXRoZkZnTVlMaGxJWWExNHpsTXlXcSt0WVQ0VTdSakww?=
 =?utf-8?B?NFUzNWY5NmdDTmozNjl6WFUwdG5JaFpBakdEcFhKaGxPRlBRSC9zMWR5VjFF?=
 =?utf-8?B?aFJHc0NSaFNqMG84Lys0OUNsT0RGcDR1S2t0NXIyc250WUNMT1hTazhTNnk2?=
 =?utf-8?B?aE4zZU9WSGJ4Z3pUVGd4Z3gwb1BxaUZNdWtic1g0MlFHbUFNdDBaM2xRM1Fv?=
 =?utf-8?B?cWoxTHJMN2FoMUYwSmw1QjBPWkE1Z2hTa1FqdEs2a3dRSEtrQXBjUXlVMDlZ?=
 =?utf-8?B?YXF4VEJRVkhsN1RSS0VZSVVSdFZNcjIrSFEyL3ZKWW5oeklPMnJGazNNWUJN?=
 =?utf-8?B?TUhQUm80Z1NSWlVDditEcERvR0NIcVhJVmlCaGs1bTNSNzhvWk9FK05EQm50?=
 =?utf-8?B?Z2E3cGN0M28reHNJL1p2c1RhcGFGaldPSUpBZnFiOUIxY0RpWXRidk5SKzR3?=
 =?utf-8?B?akN5dHREaUtLa0pZcnRPUmxmcy84dHd0RDkwa2cybWtrekxvTnFHYk52Q2hj?=
 =?utf-8?B?NUVXWGNzUW1ReEpiZG9DcDZYaWtFTXhYN2NETi8yTGNZckZhVkV4WGlXbjB3?=
 =?utf-8?B?dDBCQUZxZzZEMGJoVWNaTU5VczFEWkIvZlNoN2lrOHVDLzl3ZW9kR2xlUGg1?=
 =?utf-8?Q?wrOJlJB2DfKRfYAAwUg/vpmYlFEDAPpQpTgbRoE?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 101d3d6b-759b-4d49-03f2-08d929e84744
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2021 19:13:05.5542
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dc5P4iif7ri+A282+0ffg6lbbsQrTrPgqGsydd7/JcBPaxrSbGz7asU8AbyD11sK9gQPukY6iFScuwVDGMCbxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4371
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10008 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0
 mlxlogscore=572 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106070130
X-Proofpoint-ORIG-GUID: _a8C7F9jHYLmJnIbPON7x-W0wa-kewto
X-Proofpoint-GUID: _a8C7F9jHYLmJnIbPON7x-W0wa-kewto
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Resend with new e-mail for Naoya

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
