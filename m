Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B731241D839
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 12:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350209AbhI3K7Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 06:59:25 -0400
Received: from mail-vi1eur05on2062.outbound.protection.outlook.com ([40.107.21.62]:21729
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1350123AbhI3K7X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 06:59:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DkAKYa1gMIIUByASee1s56jAoSvExuXSp/OZ6nCs8ag=;
 b=hZT0AaFsgzFQ3M6c5tb8Xz3t4CkbK6sQWzU/ZD2U5iHukkW9QZh76jKPBV5Iv3OoAvOVSMvc35rIaBl0/dFgQ66L1CeXUQEF/4y15EgyLl4KnPC0dkPg/Ueh9CGCkckZiYyXUAs5EgCZOQHA17earjIVYf3g6vIlgpsGkjQ8v80=
Received: from DU2PR04CA0228.eurprd04.prod.outlook.com (2603:10a6:10:2b1::23)
 by VI1PR08MB5424.eurprd08.prod.outlook.com (2603:10a6:803:136::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15; Thu, 30 Sep
 2021 10:57:36 +0000
Received: from DB5EUR03FT058.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:10:2b1:cafe::be) by DU2PR04CA0228.outlook.office365.com
 (2603:10a6:10:2b1::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14 via Frontend
 Transport; Thu, 30 Sep 2021 10:57:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.33.187.114)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=pass action=none
 header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.33.187.114 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.33.187.114; helo=64aa7808-outbound-2.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-2.mta.getcheckrecipient.com (63.33.187.114)
 by DB5EUR03FT058.mail.protection.outlook.com (10.152.20.255) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4566.14 via Frontend Transport; Thu, 30 Sep 2021 10:57:36 +0000
Received: ("Tessian outbound ac52c8afb262:v103"); Thu, 30 Sep 2021 10:57:34 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 423bb737f23d2a90
X-CR-MTA-TID: 64aa7808
Received: from 27dc911c7288.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 74E55384-9329-493D-AE39-A57911A5A7DA.1;
        Thu, 30 Sep 2021 10:57:24 +0000
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 27dc911c7288.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 30 Sep 2021 10:57:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nDsBGhxFUBLQ+VgXLIScMxPYTYBfz9yeQsQF7nKN6a07W1xKafSLB60rxeNWRmjs8Up4l1Dm5SPdr24APQYP536MHZBTlLAwx2nXfQ0jl76Xsqgu7la9aQE49Ah/mOWsHqFcyKqCoSLsJAcCCyRzB14tt/3RC33EwcjwfQyNRyMlCXmgTQqLBT2dJ1Xx0sPJOzD1IeIL6Nf94bvFJIRb4D0tuceqpotigZGC0bvtcQ23gzNK16iXEHiOgSQDtLg+JOXdbGD5wCsatj182wjdzXh1oDkVQkLV+DQFF3r/7oLz3VTasK7glC3npBiw7Rpx1OCcIm8HJkp37XdM7Jujvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=DkAKYa1gMIIUByASee1s56jAoSvExuXSp/OZ6nCs8ag=;
 b=L6yzE9aypYjZTyYnfli/o3nD+iiryp7jopL6Ov83MAvPaMNtFY3aqe06wgaq4nnRjYro/j1s3ABJMeFrRdilvxA0ZKV7wbWwkBzzovy9/5Wnbl6oPCpYVpulgdRSjG69q7a8csDFfLYh8MdiLf3NDSHsfXKuqpywyS/1vKWDHAll/8eiZKyp6kh9slAvVGOMkTCjVtoZ7w3PZ93z9pFbAc10usKV9aDD7NfzAjxtgJn3u6U2jQxFPwlpyZMwlCNR/FgPP1wB2e242sJg3ocR7a85lfCdZLRn6meH/S2ZVFMdoq2hkaHr4YHEQ+pItmmwKbIk648Xx94SeBMm2BLOiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DkAKYa1gMIIUByASee1s56jAoSvExuXSp/OZ6nCs8ag=;
 b=hZT0AaFsgzFQ3M6c5tb8Xz3t4CkbK6sQWzU/ZD2U5iHukkW9QZh76jKPBV5Iv3OoAvOVSMvc35rIaBl0/dFgQ66L1CeXUQEF/4y15EgyLl4KnPC0dkPg/Ueh9CGCkckZiYyXUAs5EgCZOQHA17earjIVYf3g6vIlgpsGkjQ8v80=
Authentication-Results-Original: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=arm.com;
Received: from DB6PR08MB2645.eurprd08.prod.outlook.com (2603:10a6:6:24::25) by
 DB9PR08MB6444.eurprd08.prod.outlook.com (2603:10a6:10:23c::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4566.15; Thu, 30 Sep 2021 10:57:22 +0000
Received: from DB6PR08MB2645.eurprd08.prod.outlook.com
 ([fe80::2cb2:fad6:c5f7:4501]) by DB6PR08MB2645.eurprd08.prod.outlook.com
 ([fe80::2cb2:fad6:c5f7:4501%6]) with mapi id 15.20.4544.021; Thu, 30 Sep 2021
 10:57:22 +0000
Subject: Re: [PATCH RFC v1 01/11] uapi/virtio-iommu: Add page request grp-id
 and flags information
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org,
        virtualization@lists.linux-foundation.org, joro@8bytes.org,
        will.deacon@arm.com, mst@redhat.com, robin.murphy@arm.com,
        eric.auger@redhat.com, kevin.tian@intel.com,
        jacob.jun.pan@linux.intel.com, yi.l.liu@intel.com,
        Lorenzo.Pieralisi@arm.com, shameerali.kolothum.thodi@huawei.com,
        Alex Williamson <alex.williamson@redhat.com>
References: <20210423095147.27922-1-vivek.gautam@arm.com>
 <20210423095147.27922-2-vivek.gautam@arm.com> <YUoBHA6NZaz8wlkA@myrica>
 <3b490967-58b5-7c4a-2275-250e26d24aeb@arm.com> <YVV6DD7zmy1MKva0@myrica>
From:   Vivek Kumar Gautam <vivek.gautam@arm.com>
Message-ID: <03a3d20c-732c-b9c7-c090-7b476a277a12@arm.com>
Date:   Thu, 30 Sep 2021 16:27:15 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <YVV6DD7zmy1MKva0@myrica>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1PR0101CA0063.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:19::25) To DB6PR08MB2645.eurprd08.prod.outlook.com
 (2603:10a6:6:24::25)
MIME-Version: 1.0
Received: from [10.162.16.71] (217.140.105.56) by BM1PR0101CA0063.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:19::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14 via Frontend Transport; Thu, 30 Sep 2021 10:57:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 26cacb57-245c-4cbe-8e51-08d984011cd4
X-MS-TrafficTypeDiagnostic: DB9PR08MB6444:|VI1PR08MB5424:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR08MB5424506B22DEE5BAB73E957F89AA9@VI1PR08MB5424.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: MKCU0JCIbc432IEKyjDtK8RvJ3Yt4Zf0hG/R798iXuw3qXiEg3C8GUGguetcmaaM8g1/qWsXnEejDmZsXbALHkJywIwxgPfSrSoCArnmN8jf2yXSr4rp1WHWtdbcVxKRycxH2P8kvp1k0Ipvz6uJOeRRtgTxH1W9Jeg6wWXjKEfXAyU5ANAivbrnAXRFyayD8qXBipMBzBWDQO1J6AS4Kx/oCSOIiiRqR2PvRNPTwjVGWEeEou6eO1mSbAqZVxPKr9FFpTcZfctSvO/x2XiSuH+gvwjhFalLbszYOfsS7fUECYTRPGAOLa5h3gohb4JStW/KRFvvK6FXXZLZ1kYWpHvJjWJAHwmSodD3t49eJLWPGJREEV68znXsfpDUDqJHmILQlnOICaxhavnRqojiFdlfvOV8HRYV6IV+w/RLVBzLatwn4WZwYVLElhuhaBT99c4ukTtO8dV16MDZmoYsbI/mSxOsuXFfO/xBaGxkRIo3XzV3MS65IU1KjaN5i5uHYiIwuZR6pSGbvrBxIFijp3h7k7YvvZHq/9ybqWjbv6V7cJZNJUiwE2oCQB7jpYIBzzQFQPncbP9cmtFXu6vGI7besmv7QPjWRAi6rHm0qBKBR+fpn9fxCu3RKlC8Tkju0iToDiMpXYcUrcdraiADTOVKBlpQSGEkOmOiqmXFD1FvfBFUtj58k11y7HRHs24KD1f1mzfXZOBOfv9JjxsK4NqEqU+2F+KuQqGPRfAcCLHv5qPXssq2CmVoLUNdiL86sSAf5Qhk3wLIFkX5/AOFfg==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR08MB2645.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(4326008)(316002)(508600001)(16576012)(6486002)(8676002)(7416002)(4744005)(26005)(5660300002)(66476007)(66556008)(66946007)(956004)(36756003)(6916009)(2616005)(53546011)(86362001)(38350700002)(38100700002)(2906002)(31696002)(186003)(52116002)(6666004)(8936002)(83380400001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB6444
Original-Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT058.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: fbbc3f2b-bd25-4c4e-a9cb-08d984011437
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NEdcTowNRQjOIIR99qLH75xU2eZlFGDlCgRzyITMIUUeGDQtAQGj1QKYAno2x7UZfyeh/BVDRp45V5TnnEqX0Ly7CxKEl7J5r+7cWKO81gY/FHpkNxJ/Kiil1fuR3Yy8ulJn6ep7YNTNb5Mp4mgoSX/XlDSJf8pyCweIkTppMYo/tRAeomEc/KgjJ3G09ZNqKJKa7YDr7v2i9UH3CyC/TzdYCLEeRptsAFBne+osEyjS07gXgHLOwU/Mns+J71IZKXy/AGkvavQLkyzkxWotIhSPvzF3GiQNhby8p4FvX4QzBg5laF+NDyDrQ1AGwV+1t+cJ+YPotoC/HO7F51Cu64lcRmQ+aFz1NbmBgU1Lh+R5xNopdWzd9ZrWlNNGMhKTHoq09CqN58V3YdyrXtlOd6t5sQUn9C9bKKj9ISguVl/ehwiJA3rVJPseCDnXPxtWq9y1P2P0PtRyudG0w7Vaus1p9wGoJcAm+KztaI6wnz/ueUe10SA1i6PDbVhAi3n6g2Ej0ue3hCAdOrRjX3c+PafetjsGsvBlx/ABYaS/APZ8pXOIGMlhShZVaLNMjnSNzCwcyGn5GLf19kVwde0I14BR2EZrhPAGnA8PVwPWH7ohLMmg8WBM/CZ9GRy4aIbUiyt3pr3eX4/XW8W4obvJtYFQq6vgjNlnnH3hIC9ubcjSpG4WwN6v1VM0J/nFG/uKbN1VYUHFri/ZBy0XfcQ2wXYyfOIgeJD6zVXfLt7iwo8=
X-Forefront-Antispam-Report: CIP:63.33.187.114;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-2.mta.getcheckrecipient.com;PTR:ec2-63-33-187-114.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(86362001)(31696002)(2906002)(47076005)(4744005)(6666004)(26005)(6486002)(16576012)(8676002)(53546011)(82310400003)(956004)(508600001)(356005)(83380400001)(316002)(70206006)(4326008)(36860700001)(8936002)(336012)(5660300002)(107886003)(70586007)(6862004)(186003)(2616005)(36756003)(31686004)(81166007)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2021 10:57:36.3071
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 26cacb57-245c-4cbe-8e51-08d984011cd4
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.33.187.114];Helo=[64aa7808-outbound-2.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR03FT058.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB5424
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/30/21 2:19 PM, Jean-Philippe Brucker wrote:
> On Thu, Sep 30, 2021 at 10:26:35AM +0530, Vivek Kumar Gautam wrote:
>>> I'm not sure why we made it 32-bit in Linux UAPI, it's a little wasteful.
>>> PCIe PRGI is 9-bits and SMMU STAG is 16-bits. Since the scope of the grpid
>>> is the endpoint, 16-bit means 64k in-flight faults per endpoint, which
>>> seems more than enough.
>>
>> Right, I will update this to 16-bits field. It won't be okay to update the
>> iommu uAPI now, right?
> 
> Since there is no UAPI transport for the fault request/response at the
> moment, it should be possible to update it.

Righty! I will add a patch for that too then.



Thanks & regards

Vivek
