Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 814FC3E406E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 08:46:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233440AbhHIGqt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 02:46:49 -0400
Received: from mail-mw2nam08on2047.outbound.protection.outlook.com ([40.107.101.47]:22401
        "EHLO NAM04-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233244AbhHIGqs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 02:46:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C4D+IkMV5P+uHGTgI6OalzUv8eHpegDaLnID1tmQCaEwk5TLcRpH6iTC3rBrK5c3owy8HmScEf8Ei4Z5TS7UASdjXaDfnoE7fQ3zrOjCGqJXCP0l7wvgySBrdWmUGoHkDuS8VtzT9wDcjH4Owm/h9iApfP/ThrpX1TUWW7YoTOw2WxpeqFzf2hvr4wFr0OSzhZ+qlTgkmhh3N7eMkWyAJox5jgGjOgrisaWhujdmsv3YSUnAZMrKpVetdZLKJVP9BZmvbnt0F8ZLfkl5JjxfFfHUXWc6S9wgJnusX2AaDK1oyYGUvXpKmUB13lymMRIrVnj25Uj/mefiWeF3dqwcSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=182BdK9qCEGpLdZM845Jeu/tUcen8s7scL7fM/Rr/W4=;
 b=iH9IMjYc3sl4TI+iftgFw43XHGtW2zg2DYI7gDb8rWo8TR5OWeltgnWz8vEQ2diAA8DsBnXfGHEoHgW984SPAMWVPgDEfzcjPc/sCQBjH8ljFnWHEoNTk56MAYgPWf2WfxujyKt4T0BHWH4ZGL5/IxgJlu/EykkTJYPhffM1I9s31flFBxkGaFygGnt8t8NCvQ2df5CPrFgHJM/8WLhm/f1ZzKADCi4JlbbCQcHesH3x89JPx+eqxa10I+yj493CPiLtN3LeVl4qVsY7e9lJk618MiYr0/wVU2L+hQdznn2HpzvsCD1d+dwhg/lLVuOGqAUN9sEyddc+wR7aOKf6Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.32) smtp.rcpttodomain=kvack.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=182BdK9qCEGpLdZM845Jeu/tUcen8s7scL7fM/Rr/W4=;
 b=HUYq6kaHPma6z9csAwsVejo5/pZdOvk/GigccyRLerReKG7c7yqIdFMFxEuYvhdTQxfbq3f5Ifbs4E73yZWmMO7OLd+u1Byuftz9sbRkSKRW5TGAS592QzQSxHx7N/i+WD/Wh/7L9dpvDLJNOz26d9gAKvHhu1zmVW5Okn7CxYBQj1PssIQzFOzzboU3bFS1IHOeTr1J+tInDIJ8eJxWvlukVhylkSNlVAD5OBSk+V4XOFDkjztKiwxUx/JGSxD3U0bmNyQuHlwU8HRPIV2UTIVHF8DQbVuy43As9vw1hg26+1gCWlLoD1REHGbXBxu9wR/ptUYMw3qE1UmDXkr6zw==
Received: from BN6PR22CA0038.namprd22.prod.outlook.com (2603:10b6:404:37::24)
 by CY4PR12MB1848.namprd12.prod.outlook.com (2603:10b6:903:11d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.21; Mon, 9 Aug
 2021 06:46:27 +0000
Received: from BN8NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:37:cafe::91) by BN6PR22CA0038.outlook.office365.com
 (2603:10b6:404:37::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15 via Frontend
 Transport; Mon, 9 Aug 2021 06:46:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.32)
 smtp.mailfrom=nvidia.com; kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.32 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.32; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.32) by
 BN8NAM11FT064.mail.protection.outlook.com (10.13.176.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4394.16 via Frontend Transport; Mon, 9 Aug 2021 06:46:26 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Sun, 8 Aug
 2021 23:46:25 -0700
Received: from [10.2.53.40] (172.20.187.5) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 9 Aug
 2021 06:46:26 +0000
Subject: Re: [PATCH 1/3] mm/gup: documentation corrections for gup/pup
To:     Matthew Wilcox <willy@infradead.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
References: <20210808235018.1924918-1-jhubbard@nvidia.com>
 <20210808235018.1924918-2-jhubbard@nvidia.com>
 <YRCHZObkj/BJgCmR@casper.infradead.org>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <eaaa8340-d736-e6de-cce0-7d717bee7f7a@nvidia.com>
Date:   Sun, 8 Aug 2021 23:46:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YRCHZObkj/BJgCmR@casper.infradead.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL105.nvidia.com (172.20.187.12)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 695c84f3-dd83-4221-266f-08d95b016954
X-MS-TrafficTypeDiagnostic: CY4PR12MB1848:
X-Microsoft-Antispam-PRVS: <CY4PR12MB18485395173B44E477F7402BA8F69@CY4PR12MB1848.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s1/l3NDiWNYdcQWmTAj5u1tkwC76veJ76tXx6sJiEK29syw918146lIIDI/u2DNbIaoim7pGschXCQ8lckuacBjm8PFD64OqavlxMhTJ17DW6/mfKQtScdcRd1tGQp3DOQbxcbGiTQA60rvF6rPBGmIFoNSvo14spTjdsFkFN+Bjm+BBxcKGrL0VyKjrge9d3OzepXw5jyJN2d55ptSX7z/qWuDb52ebIpQuj4EDyyXR+fGu24jWfh+JXez83XGQ2YvGzMZ7+Jp7ADq5fNOGiNxwPAaGx329W78vmyh8e045GLcvkqG0SwwzwgBJDEP5MzlwdpxK9zQRG7YjK+/gYgQdSNM74MBuNfKf8g421eNSHvFkUmyFF7ygO5qySPP2XhMjOolMprMikrI9AEBPLI5pXnBiltmDD+3ms/NkkYZZFd5u5figRllCNPQFVjtSuPkS64ivRYD0es2OJSDtJDD2K0tz9zMcPzAEl/+5hSV4urfvD2BM2NBFq/OCiCHPqiaPcXTzGIOJehk1C7oE7lV3IjQZ8TBs2bmlXMfurGwm9em34H/WHlDUbstTuK/cD+AK79DuH5ZMjh23kW0t9K7Vjt7KvEGz594Rb53ZaJGM3NE6wG+v011nceRX63xPsBvRiagFMUBc3RNCDygYDjQZuGOXSgP1hZxI7lgdjET+zF3kDTdaIy6Z0C0O86eQ2/SPJLiRZcXG0XTsopU5byhSPpXphyKmCsWG1tZjY8Y=
X-Forefront-Antispam-Report: CIP:216.228.112.32;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid01.nvidia.com;CAT:NONE;SFS:(4636009)(396003)(136003)(39860400002)(376002)(346002)(46966006)(36840700001)(54906003)(2906002)(478600001)(36756003)(7636003)(5660300002)(47076005)(26005)(31696002)(16526019)(336012)(86362001)(16576012)(186003)(82740400003)(82310400003)(316002)(356005)(36860700001)(53546011)(8936002)(83380400001)(70586007)(70206006)(6916009)(2616005)(4326008)(8676002)(31686004)(426003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2021 06:46:26.8194
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 695c84f3-dd83-4221-266f-08d95b016954
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.32];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1848
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/8/21 6:39 PM, Matthew Wilcox wrote:
> On Sun, Aug 08, 2021 at 04:50:16PM -0700, John Hubbard wrote:
>> @@ -103,8 +103,14 @@ static inline struct page *try_get_compound_head(struct page *page, int refs)
>>    * same time. (That's true throughout the get_user_pages*() and
>>    * pin_user_pages*() APIs.) Cases:
>>    *
>> - *    FOLL_GET: page's refcount will be incremented by 1.
>> - *    FOLL_PIN: page's refcount will be incremented by GUP_PIN_COUNTING_BIAS.
>> + *    FOLL_GET: page's refcount will be incremented by refs.
> 
> I think this would read more clearly if it said @refs (throughout).

OK, will change that for v2.

> 
>> + *
>> + *    FOLL_PIN on compound pages that are > two pages long: page's refcount will
>> + *        be incremented by refs, and page[2].hpage_pinned_refcount will be
>> + *        incremented by refs * GUP_PIN_COUNTING_BIAS.
>> + *
>> + *    FOLL_PIN on normal pages, or compound pages that are two pages long:
>> + *        page's refcount will be incremented by refs * GUP_PIN_COUNTING_BIAS.
>>    *
>>    * Return: head page (with refcount appropriately incremented) for success, or
>>    * NULL upon failure. If neither FOLL_GET nor FOLL_PIN was set, that's
> 
> Did you run 'make htmldocs' and see how it renders?  I haven't looked,
> but this might work better as an rst list?
> 

Hadn't occurred to me, due to my own incorrect mental separation between
comment kernel docs, and rst formatting ("rst == Documentation/"). I'll give it a try.

thanks,
-- 
John Hubbard
NVIDIA
