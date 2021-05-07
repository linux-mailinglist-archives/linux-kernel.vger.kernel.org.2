Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F4AA376203
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 10:31:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236244AbhEGIcJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 04:32:09 -0400
Received: from mail-bn8nam11on2078.outbound.protection.outlook.com ([40.107.236.78]:45952
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231675AbhEGIcI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 04:32:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QdMdMuyP8S47tH5pY8Xu7P2eDl+c7BIxbFplTEt0EFKi8G/lII/YIkYK2ov+guLKfyqJ9kry0EgoAl+IDMvOue00B0jAPkdq7O4L6yICVcTwccIV99WLNWuoZqh3f3/Hmzlz9hx8IxtXdYymwTFTY90OR9TXXrDTacVSTVxLFTw+rXEnpDCQ9HFdTr0da2yWLvmnbgRwbIuEICNfx6xXteDQiIBRRPIqU388fRb0tnTTCNPpe7z6+PGGyXPOJ17t4DJ6mjapXjhatHY6/DXmGS/pKF/DlL0hg592E8J6jgMOtffMuyxlivhgB+EzSHb0uGJ5lZ1dWXet3NJ7Tg/+lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lMthCu/pg8E/LDQbuM/qKz+CyYAwOOcCPiuvVCV7ItU=;
 b=DHGAQmUWVJxIE6DwCyh3uzllAfu1TDWqdABDVAn6HIIA3KYwd8dyUh7aw59hMQRaLdmGGLCdX0EIC31MQt+RIj8fZpazX+APdMW0qdlprqoyecupCKbVQYINY8JxEdhbZVAGl/JZ5vAFsRP7CZsk/Ufocv5O/Or2yk2ae0NPraebKETQ/j2URrFOtR3esvcQjuG9MvVsFCLTlK26nn7crOdUP+fcn1yYYk5AUHFUk52hiWO2ab1/R9q4bNyEGXJPx/BjeVdGKqt5fPo4JgPQVl0XN4yiXzGlTAG4Oq6AGuxGO6v9cOosCH1+BZAWf2yfO3glbYm0O79kT+GqOP1n5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lMthCu/pg8E/LDQbuM/qKz+CyYAwOOcCPiuvVCV7ItU=;
 b=lDV24BYhuBAWRAB+KTgH5z3yY+i15T/+Y7YCMRcn4VI7MCFo/qz8F+PybHaSjZlCGS9cYMBJ/YMEcPKeGc9JAVquwErijBG24HGZ4Qg536nikzAoP4Q6NSbHTeuKjch6L9fcdhlf7Yguwo/zJnqtMRNDOToTEmg7rLle07VVnhE=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=windriver.com;
Received: from MWHPR1101MB2351.namprd11.prod.outlook.com
 (2603:10b6:300:74::18) by MW3PR11MB4524.namprd11.prod.outlook.com
 (2603:10b6:303:2c::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25; Fri, 7 May
 2021 08:31:07 +0000
Received: from MWHPR1101MB2351.namprd11.prod.outlook.com
 ([fe80::c156:455d:860e:ba87]) by MWHPR1101MB2351.namprd11.prod.outlook.com
 ([fe80::c156:455d:860e:ba87%4]) with mapi id 15.20.4108.029; Fri, 7 May 2021
 08:31:07 +0000
To:     rth@twiddle.net, ink@jurassic.park.msu.ru, mattst88@gmail.com,
        linux-alpha@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
From:   He Zhe <zhe.he@windriver.com>
Subject: Concern about arch/alpha/kernel/smc37c669.c
Message-ID: <7b314145-cbb9-b491-ccf5-d6021a574339@windriver.com>
Date:   Fri, 7 May 2021 16:30:59 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: HK2PR06CA0005.apcprd06.prod.outlook.com
 (2603:1096:202:2e::17) To MWHPR1101MB2351.namprd11.prod.outlook.com
 (2603:10b6:300:74::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [128.224.162.175] (60.247.85.82) by HK2PR06CA0005.apcprd06.prod.outlook.com (2603:1096:202:2e::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend Transport; Fri, 7 May 2021 08:31:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 87bf450b-dc34-43cb-a68e-08d9113275a9
X-MS-TrafficTypeDiagnostic: MW3PR11MB4524:
X-Microsoft-Antispam-PRVS: <MW3PR11MB4524A13A8759C038AC8A78C08F579@MW3PR11MB4524.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NfSZGdBm+AChjytyOU5Dtfjrxkn83yY3bspUEsX1yn4/jmrcxrm5QV6PquI3wwzj2V1J7bEGAwh7izbm83ZHBHNl7LcgWNLFvJ2KaT5oZ2PMIOpEVqPVr24GtNw/bBILDdOEk3mOxPvurF52zWNZlIYyiguumVTR/G1n0mAvuuOaINta47ZHx+uC0KqTNX31ZYFBSr2Ff4yj8bcFxsKSZ5frC/RD6ljoWh48rpck5iMkYfr2Wriiuwdh9Zko0G4BrehPTEIlfeYhXUmoVgGZWgjZi0VI7LlKCqaN7K+8tg55d/KLsMzzwyGWnFGe9k4i/UiyMN7AiwqjZjb+5euZ1tbxXsVjfLEVtBY6COddgEPBoqExl3vCnAn03aKU6lFNr54VJ1x8EiLye0n4n84azXaYYsi6rEl7zwgfqK3+fKtFYRjnCCtLJ8xn+a+9xdth9LkDdfilskhsIV8v8koazmm2FFBv3abj5jzGC1sJmsiuMiG/PIBt5giqPZheMY8B+C2WNhujOKhPgjImCfkgX5QSNeJY8PwD9dmBQxiRg1a0Llg6RSo6wrI+a1mUqAfZiO2aLUQsYzNVuzvrB3Keiw9mZj+FShOuBKhvVL5h6jy7P9Hga+OpdFyA1T/mMWhnIspnMNUHsnkOxxXrABzlUNtUiYF5+ckJHMsp3jqqF294wz86k+l7vluyDwNUSK1etNpv7LRlKWkbAhJFL2NioeXw8rVoIXqAhuit3b4X3rw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2351.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39850400004)(396003)(366004)(136003)(346002)(376002)(6486002)(6916009)(186003)(86362001)(36756003)(6666004)(4744005)(8676002)(2616005)(5660300002)(956004)(16526019)(38100700002)(66556008)(66476007)(16576012)(52116002)(38350700002)(31696002)(2906002)(8936002)(478600001)(316002)(31686004)(66946007)(26005)(6706004)(78286007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?N3NHNzRjY25jZktjM3hWdVpWTUdPUlNpWmhXWmE3NER2a01KN05pekRKM3JC?=
 =?utf-8?B?YUxueWhZVHhXM0Vob2t3WkFhYldWcUJMeEwrMGhaNDl2WXY1c1ptNWlNMjdv?=
 =?utf-8?B?QXBTNjkyU0JHT2NqQTJHOXJGaDFUWVp5WHNVVTNid1FNNWM0V2M5bUFQS0Qv?=
 =?utf-8?B?RVFuTitaRVlCQ2RULzNYY0YxUXdwUzlKOVpITWlKbGxzbFhYYlQ0SElWY3R3?=
 =?utf-8?B?ZjhjeGlia0RHL2g4TTNRYWdKcktIM2QwMGxlazROb2RsYnhrM09LU3JjbU11?=
 =?utf-8?B?VlFpL1ZGZjhReTJCNnN3K0NDWThnTVlTTXozdW4veXFQM2NrOWpkTWtIR29s?=
 =?utf-8?B?ODY4eHpvOTZLSzVtTlhwbUhyQzdyRjI5NG9sWnl2eW42YkxWR0lwSXJNQWpj?=
 =?utf-8?B?T0lIRFhVZWhLM0pOdkFJSkhDSkpTQmVvZnZJSDBzUFFzajJKdUhaN3l3RTQz?=
 =?utf-8?B?WERkQ0NJdHhZZkQ2c29aazNqV3FrSnNsSmNhSVM5Y0dyUDVzcWNFNVErMUY5?=
 =?utf-8?B?dUdkTERnbnR0QUtQeExYVG5NS09XTnVsdzg3QmwwMWxjUlhtNWxWaWlCTlVU?=
 =?utf-8?B?N1dUMlEwdWxOSkRaTmx1M0dVMXhOcFhkbzVWR1hmMktnUlczZ0xQZ3c4VnpS?=
 =?utf-8?B?WTZZWTBWaSthTHBnQ3RJbnVDWmZtRURRMFp2MWI3QTdtS0FSaTNUaS94RFhU?=
 =?utf-8?B?KzY5VEpDb0x0bFJNaW0xbTljOTY0cGFKdDBISnFsV21EOUdqamVUL0RMQU5R?=
 =?utf-8?B?UTdCTzQzUDFYS2lrbkkyUFY5dWJXVEs2ajNXNnBkZ21wM3dYNmVQd083d0g4?=
 =?utf-8?B?Vk9GNkVpZHdRRmdJUnJKUEZYOWNEb2pESVVxbWRjRFdlVkUzTXM5emRoZHpK?=
 =?utf-8?B?aHp1Ykk3czFqWEZlNmZtVmJMb1pucU5iSm1xU1hDM21QQlVpZ05CdXVzMTQ1?=
 =?utf-8?B?WXpRb0pRckprbi9DSHljbVplejJFR2RUZzl0bEY3MFNVZGhYK1YxRXRPK21Y?=
 =?utf-8?B?YU92ZWxGN0ljTm9sVjdvK1VBbVZqZE1qSzFFRTByRHN2QWliSUdzclh0S3VZ?=
 =?utf-8?B?RVRqd013aVBBMXRWMk9vZVpJU1Ywek5GbXNxb3k2TS93RzJvY25YM3hsdFhJ?=
 =?utf-8?B?QXZaTnU5UWdYUk41VDRxVW9JbDM1eU9PTzlsWDF2Z1IvcW9idWZIczBaZGtO?=
 =?utf-8?B?QzU2YU1jVW1OaXVZQlZvUDBGcldwUVE1RmxUTm5QZzFRbXkxV1J0K25lWmNH?=
 =?utf-8?B?bkZ6Z3NyTWpkeCtSNEs5VTZSNWJ2ZHZKMmt5bEQ0L3Bqd1RqeUNoVU94R213?=
 =?utf-8?B?anRtTWpUUVBPSHVKZXBMSURDcC9mSHFCbGxJRDVIL0NVNkxTUTRjYS9hTVpS?=
 =?utf-8?B?ZHVOR0tWOGhiVXFpQWNLUE9OK0x4YnVGekxBU0xJWllBV3RrV1RZSTA1MnlF?=
 =?utf-8?B?U1g1anJScU0rTk9qSkR2VWJjTDh2YUtuYmlLSDhJWFJpdXF4YmE0akxKTEo5?=
 =?utf-8?B?Mlo3ZWxCNiszSmpvbTBtY3h0NjJjZUtCUjFOSTZ0SHlMSlp4eVAxVEQxU2xO?=
 =?utf-8?B?L2NsVUN6T0NGekFNQ01ibWIvYVpFMXgzdGJDaDlad3JibHpaY0txNFFwSTQ3?=
 =?utf-8?B?N3RjNHFmWXMwMVNpalBTakJKT3Q3eEhKc21ocE1VczhRK2NLcVpCQmpNZVVp?=
 =?utf-8?B?aFNWcU9pSkZVa0xsMXFaVHhLN3phSVBYQ1hFVlRWcG9Xdi9TOVFPNjBZWTdC?=
 =?utf-8?Q?OIUtxU6YiGjXRRL5z+urdsIqH/xBoaGivIqH1A2?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87bf450b-dc34-43cb-a68e-08d9113275a9
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2351.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2021 08:31:07.1475
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sd/WlNLv5XBO1qJLJKz984Y+FTyAH7mmktEehSOsBo2MHkBegDjz3iYYoqtEoY+UhfZWMBRDq6UaigwIQNr0/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4524
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello maintainers,

There is no "SPDX-License-Identifier: GPL-2.0" in arch/alpha/kernel/smc37c669.c
and the following copyright is found.
"
Copyright (C) 1997 by
Digital Equipment Corporation, Maynard, Massachusetts.
All rights reserved.
"

Does this conflict with GPLv2? Anything else we need to know when using this as opensource software?

Thanks,
Zhe
