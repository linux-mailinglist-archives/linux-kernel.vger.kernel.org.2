Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25F1E3E406D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 08:46:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233434AbhHIGqi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 02:46:38 -0400
Received: from mail-mw2nam10on2044.outbound.protection.outlook.com ([40.107.94.44]:44544
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233266AbhHIGqg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 02:46:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iOFSSPW2T8uReHxft03i+FLtgcfHIbX+smiSZQvIqCdTYqL6dVR81W9MDaVkZNDUXT1SCuPNP9lQAk06xqoWsZCtiiT6Kqn46Q0EunYG2TZboim/KnplCs5k3R5I1lhZ5zu7Fq91+3mufR5lD5jDVeZDnjJYc6pGXagv8wAs/Q55hCzCdQuUroo0bV5J8Tg7DLes9K3dSQX4hwFw/d4zUbdM55Clhd5ZNT9aQfzMeeKl/7I1jgMtUDFKuEuEoWzj4o9ABMeQKGml09t3QzCjaKoNXvE5TGbcvhhnQHjo7tGZXjCb4H8B5wm5XmvdJAwljR+W7oeM1/MMGnHc4odVeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rx3tKlKqWswfrIZU+xPcvaIqyLthUji4ByCjuz1DjfA=;
 b=ahgcgnQRx0/DN28MHuiYjMn9Q0sQEbf8vRg/bYdAY4gLeaFokkR1m9qXY/TQmUB+zKeAkUManVzug1Q7evDefVRz0HcASzZYKV7lnmqIgmg2sPVEZwyf7pIbk1tz4N0NHJOif1ZFrHZor8wJiE+PQeB6FowDyikWiqfbXgRtg+WNKSCd411BnVTb57lrUtUKB8ekVlCHGlXVohS2PApeyIyxeAPOOwZBJB/j+qLylgAbGZGuYMKH3oBoVpHR9ACFXleGg8Pa8fSuTII2ipQ5fTn3tM2NDqVid2/mb/31QrjEYzrEDoOUQ5HCoh8IkYj2kcst4NAa/SV2fSDwfEJ0yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.35) smtp.rcpttodomain=kvack.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rx3tKlKqWswfrIZU+xPcvaIqyLthUji4ByCjuz1DjfA=;
 b=Pu29Oyzm5J95LWvx5uZEylF6FaPPN4QlnUApMO4VbuWZ4Ldmf5ZeKZGHmbV/LkolmErqSJEd+gdbKxpSdcrZ/u176g3JEqtdPlB2I6Vaz6SHvWQPlQstd4c8SReZN9gLC4Cd/ZzHaR6Uwg+ihkPy6Ij8MXPVKypnIvUHJFKHvn0JnHegA8jG0X430h50a8ECwdlxCtshprxHf4Lx8L5RslRSeN3EdvmbgFHBilMugl+5GgwlewxaL/UbDsza2b00utqtHtI1ipfg/zll9J/3+HYulO+1KhIXsUfvBB+utIJ3vEhM1vzuPC4PQoSkZeNXtVt/0OjE3B571Wq43bfiQQ==
Received: from BN1PR12CA0012.namprd12.prod.outlook.com (2603:10b6:408:e1::17)
 by CH2PR12MB4280.namprd12.prod.outlook.com (2603:10b6:610:ac::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.21; Mon, 9 Aug
 2021 06:46:15 +0000
Received: from BN8NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e1:cafe::23) by BN1PR12CA0012.outlook.office365.com
 (2603:10b6:408:e1::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.16 via Frontend
 Transport; Mon, 9 Aug 2021 06:46:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.35)
 smtp.mailfrom=nvidia.com; kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.35 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.35; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.35) by
 BN8NAM11FT012.mail.protection.outlook.com (10.13.177.55) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4394.16 via Frontend Transport; Mon, 9 Aug 2021 06:46:15 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 9 Aug
 2021 06:46:10 +0000
Received: from [10.2.53.40] (172.20.187.5) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 9 Aug
 2021 06:46:10 +0000
Subject: Re: [PATCH 2/3] mm/gup: small refactoring: simplify try_grab_page()
To:     Christoph Hellwig <hch@infradead.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
References: <20210808235018.1924918-1-jhubbard@nvidia.com>
 <20210808235018.1924918-3-jhubbard@nvidia.com>
 <YRDNeZZQxUzbFxrQ@infradead.org>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <e46fbd0f-21f7-9cd5-d216-8ec0b9e2221d@nvidia.com>
Date:   Sun, 8 Aug 2021 23:46:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YRDNeZZQxUzbFxrQ@infradead.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL105.nvidia.com (172.20.187.12)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 12371092-fd63-43f7-34c4-08d95b01626f
X-MS-TrafficTypeDiagnostic: CH2PR12MB4280:
X-Microsoft-Antispam-PRVS: <CH2PR12MB4280472B970EA98FCB9B284DA8F69@CH2PR12MB4280.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /cck3VLkQtWsSRLWth5iDMDks87GpWtzIJ4HXEbpAym3s7cF2pvr95N5LSBQ/ATtXhcPNxyML10WWZf7Lgs9IdRexERrvW+kvY9XS55mSYn02bco49BBUwCCeChr+1m3ViJKDxtgKPnGJX9QedUAscFCMqsznyDjKFUiytTDYkjYBMYsRu5wpwLo1JyRkkw3AiGdjwln3l7Eo/eKD4bd/fpWdZavQGW1NM8Wx1gpSJ/u8E/SFVhg7cT1nbh01JFacveLtASt3iaQvmoJ/CVC5NCWLL8SV4sYRQrXyR5YIlTYU3XsxMPZM1iUPolSIFIPMm4Sxc6Qh2TF3lgZNQW9YST0GwSrJMDe9y0WdkfdrCpplmf2ZjrygVUHtGMCrjAdygZj3JZkOItQ3EjWiC3Khr+Cd7oZ8CyH4oC61l4yPaC3QOt8BhivQAksb5Czy+OhKJXH3PgLmwkwmn4S41xZlJUaazh2wFV9DIJDovCrSV/IM8KpcFh/d6VzrOn/acMo9ZLXMedm/rYJqZW2yNdDvJlTglfy90U3mEcFcE+gV/6Xl6IGk+HNH5pMy3pJW4Kf48neG2LBGE4i/CN5I7oOj0cMXnAFXnQEryD5Dbacrnpby1lxNMUF6V12AQSi75tuTkuQHxx50Po5BZH3Yf666K+2mkGe9GJaViCJXgytZIYcOUFUIaOj84sPJLCUmn0uxB2oCVlCDpnGC2Zevkky6oEi6QjoB4X6bkjXP20zP2Y=
X-Forefront-Antispam-Report: CIP:216.228.112.35;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid02.nvidia.com;CAT:NONE;SFS:(4636009)(396003)(136003)(39860400002)(376002)(346002)(36840700001)(46966006)(8936002)(26005)(186003)(6916009)(4326008)(16526019)(426003)(36756003)(8676002)(83380400001)(478600001)(5660300002)(31696002)(86362001)(31686004)(53546011)(336012)(54906003)(70586007)(70206006)(36860700001)(2906002)(316002)(16576012)(36906005)(82310400003)(7636003)(2616005)(47076005)(82740400003)(356005)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2021 06:46:15.2536
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 12371092-fd63-43f7-34c4-08d95b01626f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.35];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT012.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4280
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/8/21 11:38 PM, Christoph Hellwig wrote:
> On Sun, Aug 08, 2021 at 04:50:17PM -0700, John Hubbard wrote:
>> try_grab_page() does the same thing as try_grab_compound_head(...,
>> refs=1, ...), just with a different API. So there is a lot of code
>> duplication there.
>>
>> Change try_grab_page() to call try_grab_compound_head(), while keeping
>> the API contract identical for callers.
>>
>> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
>> ---
>>   mm/gup.c | 29 ++---------------------------
>>   1 file changed, 2 insertions(+), 27 deletions(-)
>>
>> diff --git a/mm/gup.c b/mm/gup.c
>> index 5cb18b62921c..4be6f060fa0b 100644
>> --- a/mm/gup.c
>> +++ b/mm/gup.c
>> @@ -203,33 +203,8 @@ static void put_compound_head(struct page *page, int refs, unsigned int flags)
>>    */
>>   bool __must_check try_grab_page(struct page *page, unsigned int flags)
>>   {
>> +	if (flags & (FOLL_GET | FOLL_PIN))
>> +		return try_grab_compound_head(page, 1, flags) != NULL;
>>   
>>   	return true;
> 
> Nit: something like:
> 
> 	if (!(flags & (FOLL_GET | FOLL_PIN)))
> 		return true;
> 	return try_grab_compound_head(page, 1, flags) != NULL;
> 
> would be a little easier to read.
> 

Really? Well I'll be darned, that's what I wrote in my first draft. And then
I looked at the diffs and thought, "positive logic is clearer, and the diffs
are smaller too", and went with the current version. Which now is apparently
a little worse. oops.

Well, "50-50/90", as we used to say in an earlier job: 50% chance of either
outcome, and due to The Way Things Go, a 90% chance of picking the wrong one!

I can no longer tell which one is easier to read now, so I'll be glad to change
it. :)

thanks,
-- 
John Hubbard
NVIDIA
