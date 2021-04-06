Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2633354CCD
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 08:25:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237572AbhDFGZE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 02:25:04 -0400
Received: from mail-eopbgr130081.outbound.protection.outlook.com ([40.107.13.81]:32321
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233173AbhDFGZB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 02:25:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YvNmeqL0Bq6OSamAyd7ezaVIhzuimC2bKTFp3qxiqx0=;
 b=BK+nlQr9SOmDQ2wwPD3nZCU35vgoujGc//4qDA3VjwhLdGnZYvgdqtMlkrC+WHoXLer9lI4v27mjMfrcekqK8/dcb+9jH1UmIOwWpB3KrA2hISPSK9pZqr/2Dj3FM+we+bfttOUq4T84dRjiIh4IpjLqRj4fiW7KNyPe2ufRRZg=
Received: from DB6P193CA0004.EURP193.PROD.OUTLOOK.COM (2603:10a6:6:29::14) by
 VI1PR08MB4544.eurprd08.prod.outlook.com (2603:10a6:803:100::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.32; Tue, 6 Apr
 2021 06:24:49 +0000
Received: from DB5EUR03FT017.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:6:29:cafe::e7) by DB6P193CA0004.outlook.office365.com
 (2603:10a6:6:29::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27 via Frontend
 Transport; Tue, 6 Apr 2021 06:24:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=pass action=none
 header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT017.mail.protection.outlook.com (10.152.20.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3999.29 via Frontend Transport; Tue, 6 Apr 2021 06:24:49 +0000
Received: ("Tessian outbound 34291f7cb530:v90"); Tue, 06 Apr 2021 06:24:48 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 22a016380f7dc85a
X-CR-MTA-TID: 64aa7808
Received: from 95b4e39d71a7.3
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id F20BFF28-FA88-4F24-8A6D-7F6E08B88FCA.1;
        Tue, 06 Apr 2021 06:24:39 +0000
Received: from EUR03-VE1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 95b4e39d71a7.3
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 06 Apr 2021 06:24:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K4o07OlOfbeuGNiPoOuY/j7ioaWEnQfbUS/tsM6hrSCxxtw8p5Lt+p9BLNeZ4JQJ/O1bYnQgb71seWIbGJwH9rVXjAkVY8Eenf+/gzPLGAeEiwmQi13WFNbB3941667Sp7K2OELs12SJ7UYu0KExEywl34GnM5QMJT5hl8IcrROUdk0WXGEMwPGNQUlSvmY2/iR6YF7h/obhNl9xFNHRkayfvsLCJgzQq4QlhGRaiDfJztwR4GAo9dEeWofuF9Cmczc+i7DQ3ny416ZWbPeKrcZ+qmWSltV6Xi6d01dK+CDkcPUDzsbJ/kvfKx38beZaOhvzJO0YJhGZoJs86sMpkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YvNmeqL0Bq6OSamAyd7ezaVIhzuimC2bKTFp3qxiqx0=;
 b=alngMIspZktN/8ibnuiwbBEg7kC0YZFrqyOiv6M/LtrnUVZGTHvqFkZi2XJY1P4EA6dK4Wx7CbAtYsWseu1Nlxa4RCLy3OOUvqngi0GJpXDR3Iiy36sRKI3whuqN1stMm+eHkirHuZWXDDcAg6nzu1UcKNQHCfwZIyC3PGbQl6aZdaE7QsbTilyxsqmW9dsIElqGh9jxxa9WpbMMyydaSRaTHdxBunkmZgzZg6+07v06UDd7Ti8SIionPuDiWaSJjB3kbJa4X+VsR5q3rxXymbtuXW8qSSwxmiqEjb72CpQyaZhhB+2EFz1wxy44kze3BOck6vazlNe+J9kExRsf0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YvNmeqL0Bq6OSamAyd7ezaVIhzuimC2bKTFp3qxiqx0=;
 b=BK+nlQr9SOmDQ2wwPD3nZCU35vgoujGc//4qDA3VjwhLdGnZYvgdqtMlkrC+WHoXLer9lI4v27mjMfrcekqK8/dcb+9jH1UmIOwWpB3KrA2hISPSK9pZqr/2Dj3FM+we+bfttOUq4T84dRjiIh4IpjLqRj4fiW7KNyPe2ufRRZg=
Authentication-Results-Original: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=arm.com;
Received: from DB6PR08MB2645.eurprd08.prod.outlook.com (2603:10a6:6:24::25) by
 DB7PR08MB3339.eurprd08.prod.outlook.com (2603:10a6:5:1c::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3999.32; Tue, 6 Apr 2021 06:24:36 +0000
Received: from DB6PR08MB2645.eurprd08.prod.outlook.com
 ([fe80::c0b9:9af:f4ab:768c]) by DB6PR08MB2645.eurprd08.prod.outlook.com
 ([fe80::c0b9:9af:f4ab:768c%6]) with mapi id 15.20.3999.032; Tue, 6 Apr 2021
 06:24:36 +0000
Subject: Re: [PATCH RFC v1 15/15] iommu/virtio: Update fault type and reason
 info for viommu fault
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org,
        virtualization@lists.linux-foundation.org, joro@8bytes.org,
        will.deacon@arm.com, mst@redhat.com, robin.murphy@arm.com,
        eric.auger@redhat.com, alex.williamson@redhat.com,
        kevin.tian@intel.com, jacob.jun.pan@linux.intel.com,
        yi.l.liu@intel.com, lorenzo.pieralisi@arm.com,
        shameerali.kolothum.thodi@huawei.com
References: <20210115121342.15093-1-vivek.gautam@arm.com>
 <20210115121342.15093-16-vivek.gautam@arm.com> <YD/GjQIKkaJ5+UJM@myrica>
 <d8a81406-12c6-a5e1-7297-49c1a0a800ab@arm.com> <YGH+5pHtR6gWnimB@myrica>
From:   Vivek Kumar Gautam <vivek.gautam@arm.com>
Message-ID: <248424c9-04ab-18b1-50f7-b995b6d7b1e2@arm.com>
Date:   Tue, 6 Apr 2021 11:54:08 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <YGH+5pHtR6gWnimB@myrica>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [217.140.105.56]
X-ClientProxiedBy: PN2PR01CA0114.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:27::29) To DB6PR08MB2645.eurprd08.prod.outlook.com
 (2603:10a6:6:24::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.162.16.71] (217.140.105.56) by PN2PR01CA0114.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:27::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.28 via Frontend Transport; Tue, 6 Apr 2021 06:24:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bf9fbfcc-aae6-4c70-ef1e-08d8f8c4ae0c
X-MS-TrafficTypeDiagnostic: DB7PR08MB3339:|VI1PR08MB4544:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR08MB4544FAF4F452DB1FC60477F589769@VI1PR08MB4544.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: civFlU/UEJg+51rIMYLYhlT2OEI5wZdqb0gEPVav1fJH6FA3tVxyc3+2AtjLalgza42p/41Hyf5hRLqEsYRx05Zv9rw0anwM81cDVGh23jNqYZO5Z3fjp/5GUyjeCb/dVpDl+xIk2o9HrBgOM0ohmEeJn6g/YXqx42ulOevaMRi9M5Th33qmUD5h8DR41u2EIeX0OwWvplGjdwN5SHTt85MMCOvep6/jtEolqUYBO270tbm3ibRdtqZlJ6MZsInpo9gQ953+8KxGZjm1c2HK2ZdssGejQN+XhKPS2rkJMUFqIQ1LUyWklod+ju2ksqtaYNC0TW70QixcWR31hRmz94/S2FEyk67pn8UgLZ96sJ/0lp5dC/2YyBLqo63fOzwZ6u4FvgyBB4UO4Yb37O/wAEZDiHCAB4bmK6R62MoOY33nSqloekFvFblyKCG1dgMFvMcETdkjohzkxgv9mb3lGsjEJCT7AUHqlgDyUQ/EC2ffsP6QTcuz+cV8vuB7FdsGvtIoB5T8NBFwIDGcD8GFDtTP9XYROzPWX9/SDQN9SZ/8ZT2ucb4dC8qNyaEiC8uCVZa4SDoi85Ea7YnZWy2WF2dM0sqeyT4KOCg8t0QtTbFwh86IWYeZcklXfHhN7JJjqh6gyJ8rclO7iShkReDXUpo48R54lTfJFc2cyLHwAXWEjIyaSweHcw5+LSEdYGZz1lhrzEuMmq4RyzTJjdeVx3PqvBFndygna1vtFr0zAQGWxMbOBAOd6P/wxem8Uc53dJxzIhqX2Yqum+pj7FASpzYZMyM5S3Gg5SNTOY7oLtgxbxbrs6T2Oi2HH645uMOjlu1F/MFhm8HYJ1im22qcgw==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR08MB2645.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(136003)(376002)(346002)(366004)(8936002)(31686004)(86362001)(956004)(2616005)(83380400001)(66556008)(5660300002)(966005)(478600001)(4326008)(38350700001)(66946007)(53546011)(186003)(6666004)(38100700001)(26005)(16526019)(31696002)(52116002)(8676002)(2906002)(316002)(7416002)(16576012)(66476007)(36756003)(6486002)(6916009)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?cGZwSmVUTzBxcDRWeWRxemFzSnBVRXZHQ1c2ejE2WU16OVpLZXdwTEt1aDgv?=
 =?utf-8?B?c2FaUVdEd2NNVnMwOU9HWmhWK0JBcjhQZU1SQUtGemptNCs5K3AxZ2tCT3V5?=
 =?utf-8?B?Nkhhb0lWeGtkVkw0V2dTSU9FTW13eHZBSWJENk5rT3FNWWsyUFNCcW5QZGlI?=
 =?utf-8?B?NXZiUFhrRnEwampCbjJLaGR3V3k3OGI3V1Zib0xnVXFKeWF0d1dzeG0ya1Jp?=
 =?utf-8?B?cE02MU0rVlRiYm1Nb2F4aW9oZ3Q3cHM4eDFKSElFMk5PODNvSWlOU1E3Y1lU?=
 =?utf-8?B?ek5lMEpnTmZ1ejJxZk5oVnhoYXNiODNlL3R0WkpRYTJHdmkzWlRsc0xlVUZX?=
 =?utf-8?B?SkJpY3BXWjRYTWNMWk1KMzdGMDUzZ1A1a2pXMFpMNnhWNlhjUVExVVBTWExU?=
 =?utf-8?B?d2JDTFFjQm1VYkdiM2xtaTVtWnlnUkhBVzI3UERyVnlBQ25HVW9ZTGdDSjlk?=
 =?utf-8?B?alA3K3l1dEdqZkVQdWZqQVVpTzU4OC9IN3NKY25XSnQ2MHpuRDc1WlAzWCtP?=
 =?utf-8?B?cGhBT2QxdS82ZmdRNCtzRVFUcFgzamxrTzRQTEVFbTU0dmdEaDkyVGxhekNN?=
 =?utf-8?B?WlJwQ0N4YmJjODBpempWcnFxSjFzTVpKSllYOUtFd3VlUjNhWVZXc3BnRGZC?=
 =?utf-8?B?eGRHMjExUmdJQTRtdFhaZHZsRHIyQ0hFc2IveENCUmcyaTBzVEE5RTJnUWZ4?=
 =?utf-8?B?R3IySjErdStLVXlZT0VJUTY2T2ZUYzFlRjFOdTdDQUxCaVNVMUhEMDNKR2w3?=
 =?utf-8?B?U0ErMEVScCs1R1JSTlZqbXRMWGYxTHlqNkxNa3RoVGNxbS81UEp3ZC9xVEtY?=
 =?utf-8?B?dGRLZHBQcURXRWZjSmV1VkM4N055V3FsdWQwZENwdDIyd1BkbkNBb2lMUVVl?=
 =?utf-8?B?T2I2UnFGdkpYYWdQeDB6ajQ0a3pveEw1VTFETmNIR054L2FhS3ZzdlUyY3ox?=
 =?utf-8?B?cTh3WTJXSU0vZXhzQml3UjZMWFlFMHFCUzVQWElqODh3LzlLci9qY0Y1dVcw?=
 =?utf-8?B?V2w1anlWLytnVmZvbGhjRHgzRDFHZnAxWGovR3d3Ym1UWCthS2tMTmxjQW51?=
 =?utf-8?B?b2Z0WGpuazhucEFPYWRrSndURGl5V0hSMG5WV214dEZuR1ZheHU5aU5xRTU3?=
 =?utf-8?B?RHJycHVtTnNEREtnVEhhZDU3WEhiQ0dHbm5nWG5PS29KMHJIVCt1Z05KODAv?=
 =?utf-8?B?VzVLL1dNRW11UUdVUXNqd3ZRR055NVlmK0dPbjNIZVNGNzlHWllFeG9WRkV4?=
 =?utf-8?B?cU5JUitmK3YrNjc1NHZjeGUrdCs4Yk9MeWZlaW9hZ2FQZysvd1I5U1FFeDFa?=
 =?utf-8?B?N0lkV0JiZnRKb04wNjZFbjdrSmxNV25qSit6YnR5RXJraHQ5REdzSUpnRUg3?=
 =?utf-8?B?MFNoU3BvekZQY0lha2M3czE0U3o5ZjY3ZmlMZmJpNGJEb3h2TVhLYmQyQXlM?=
 =?utf-8?B?SDBaREI3b3VHYjVHTFJFdWRKSnFGZjFTalllM3oyZkJoQVFKTmZkQjJzZWJQ?=
 =?utf-8?B?UmV2d0xZSTU1cHRqaXNrTlhFTDUwc09ic2pqdzlaaUFKUW9xQnNyb1RwcE53?=
 =?utf-8?B?aStrb2FZNWVCQTgxYWJuUGlnc2NCQWpmR0lHcmtmcExHOGxTZmtub3NMbmZn?=
 =?utf-8?B?MmlWVThuR1c5RHQySmxjYTgraXRJenVYRlJacnVJQ0lTeW1yZnR4UTBiWnpl?=
 =?utf-8?B?K0xDaml3YkJlWFVnaEVJVXNyblc5T3EvVWNnYWtjZGJFWjdtMG9uOGt3d0FM?=
 =?utf-8?Q?xJQ4wyC4kn8xyKn3s5p2a+GuvZjA+9id5l0CsyR?=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3339
Original-Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT017.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: babf0510-8ae3-47b5-9ed5-08d8f8c4a609
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fGHhXgkP7/XEPkV2q33dELlt9f2e4IkOLrnlqVBRYcL55XujOUIHVW4vxy4UQUeI5pmBILdOWaNASKDSXYyq+lEfCToc/35S5vg4vhe8GALkgFbpkjzWGXlUWkmvvgpltvCZeUa7GbzKXZFVcGHsQiyG8gDdbm8doFJB/1nfbTqbnjcdEl+RtAjS+JYWegak7SESEaXlzGp3BlU6ZKetwjI21i/c/nNNdmcWdoyRWeqO3uJWwtFvSs9Zqvi/clp3V+CUbVvSAz9BHpPQsmROH2XAn2AhVImBFuyDiYYNz4M9mxc7G4sGLrsybAgL/7u8ILoYHNiOlw+4df+nUTLKiMWqi77O/Ai5KZ31a8n/OcE++sOaqbLOxfVWvnEmZ5LkGsbFLGYx7TR3qPiHFnmU+oYCQszillMTJXx9dCx4P9Noza60q77a+epPVKDRsm+3doCO2t85XBsQ+lgokVYrAZ8whxE587BJZPL2Lgvu+lOtrgrel+liyVmd0s3tTAd5vBZoPbuSmJetdRjBsfRbiv2dTKoZAHjY73akzFke3iDU5iOf+McLjJiUZUtQ3AXNb+NsAjPcMwz10qIhVCeUr/YQXqbxOMA6BKz/F2VIMJoACFjN8GH3YfEiiB3WLBEMwBszAJcJTH4B0qsk4iZ5wNOqILskv2Lnuu/yGf172y8LIbp2PdCN6yXnhqELLV11K4Kyp0hpCRne1F2FtEAFfoOi28evbCPtmofPUnc8g1nqj2mnB3aOigb1ZVt3Wz7be7yOZHCCA9vFBmIsH9uNaQ==
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(346002)(136003)(39860400002)(396003)(376002)(36840700001)(46966006)(70586007)(70206006)(356005)(478600001)(186003)(81166007)(336012)(83380400001)(956004)(53546011)(86362001)(82310400003)(26005)(2906002)(6486002)(31696002)(31686004)(82740400003)(966005)(316002)(2616005)(16576012)(6666004)(16526019)(5660300002)(4326008)(107886003)(6862004)(36860700001)(8676002)(36756003)(8936002)(47076005)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2021 06:24:49.0216
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf9fbfcc-aae6-4c70-ef1e-08d8f8c4ae0c
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR03FT017.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB4544
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/29/21 9:53 PM, Jean-Philippe Brucker wrote:
> On Fri, Mar 12, 2021 at 06:39:05PM +0530, Vivek Kumar Gautam wrote:
>> To complete the page request we would also need to send the response back to
>> the host from virtio backend when handling page request. So the virtio
>> command should also be accompanied with a vfio api to send the page request
>> response back to the host. Isn't it?
>> This is where the host smmuv3 can send PRI_RESP command to the device to
>> complete the page fault.
> 
> It looks like Eric already has this in the VFIO series:
> https://lore.kernel.org/linux-iommu/20210223210625.604517-14-eric.auger@redhat.com/

Right, I have taken this change to work on getting the vSVA with 
virtio-iommu.
For this I am adding a new request for virtio-iomm - 
VIRTIO_IOMMU_T_PAGE_RESP, and related struct virtio_iommu_req_page_resp 
that would contain information such as, pasid, grpid, response_code, 
flags, and endpoint. This is inline with struct iommu_page_response.
I will post out the patches for this soon.

Thanks & regards
Vivek

> 
> Thanks,
> Jean
> 
