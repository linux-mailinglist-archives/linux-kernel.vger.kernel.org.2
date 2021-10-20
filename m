Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68304435091
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 18:47:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbhJTQtu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 12:49:50 -0400
Received: from esa3.hc3370-68.iphmx.com ([216.71.145.155]:2221 "EHLO
        esa3.hc3370-68.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbhJTQts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 12:49:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1634748453;
  h=subject:to:cc:references:from:message-id:date:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=OwdSKyUsEDTW4kFc3+02zVHoTf2nOzhRCrY8c1ChS9o=;
  b=K7rndENr/TFflnysJiME9WDS7vDF43af76lEA77sWtjQ5H+e/V3tDwNz
   +f0gTI2yvN/fZ/Az4t0ODCI33V9Ej/pjawGMldZJBtuSWpqworcShdXmW
   Be48n9HuNJfnXXHGxX6fiIoVdR0KQyK3QUqUMPFeVfMy0R/A4G0iT89Du
   k=;
Authentication-Results: esa3.hc3370-68.iphmx.com; dkim=pass (signature verified) header.i=@citrix.onmicrosoft.com
IronPort-SDR: eJa75bPB4yIz5CSu06PAReUuv2cfVfaOxm6UFnVxBVhypwA1e1HmeYuQEIZm5sUkVVevkAxWXA
 rZu0xK5zLxVKP7YZri4ALWKW405A+U/6ooI7EiDe0KXg6qtbfoh/v3QCKGxWEjJCadvYzcSXlr
 eJr7LVLIYSPL+D1YlalUjg8BYry0ODDpHLNa6QD/tfWRkgUmxPq6eRtvgTBplD1Dox71qgvdZI
 +1lRCW3PJP2/pX6+bDJ6LocMqoVXUvuLEgAssDcSAn16cAh+N9OW7EAecyOmEzBKvVjudGfvja
 2//9e1eDB0rnWLbXUSoZCSNc
X-SBRS: 5.1
X-MesageID: 55687663
X-Ironport-Server: esa3.hc3370-68.iphmx.com
X-Remote-IP: 162.221.156.83
X-Policy: $RELAYED
IronPort-Data: A9a23:Bivefaxhc5LnwcVI1dB6t+eHwSrEfRIJ4+MujC+fZmUNrF6WrkVWn
 WAaC2zUPf+LNDP0ctknO4Xlox5UvZeEz9A2TAVq/iAxQypGp/SeCIXCJC8cHc8zwu4v7q5Dx
 59DAjUVBJlsFhcwnvopW1TYhSEUOZugH9IQM8aZfHAuLeNYYH1500s6w7Rh2tQAbeWRWGthh
 /uj+6UzB3f9s9JEGjp8B3Wr8U4HUFza4Vv0j3RmDRx5lAa2e0o9VfrzEZqZPXrgKrS4K8bhL
 wr1IBNVyUuCl/slIovNfr8W6STmSJaKVeSFoiI+t6RPHnGuD8H9u0o2HKN0VKtZt9mGt8l26
 N5us9u8cAcCHPf2w7oTXB5zHRgraMWq+JefSZS+mcmazkmAeHrw2fR+SkoxOOX0+M4uXzsIr
 6ZBbmlQMFbT3Ipaw5riIgVoru0lINPmI8U0vXZ4wCuCJf0nXYrCU+PB4towMDIY250QTamAO
 ZFxhTxHTy7JTQRJZHEuFdEDkcCm3mX4TA1opwfAzUYwyzeKl1EguFT3C/LFKoKiRshPmEuc4
 GXc8AzRGhwGOcaN4TuD/GiliuLGkWX8Qo16PL+g8f9vilqe7nYeBB0fSR2wpvzRokiyVslWN
 kgS+yc0toA980ukStS7VBq9yFaNuhMMVtsWCPEz8gaTzavI5BixCW0NTzoHY9sj3OcyRDo3x
 hqKksnvCDhHrrKYUzSe+62SoDf0PjIaRVLufgddE1FDuYO65thu0FSfFb6PDZJZkPXsHhH74
 DbNoBE+rJdJt5VV2aq81l7+1mfESofyciY54QDeX2SA5wx/ZZK4a4HA1WU3/cqsP67CEQHf5
 Clsd9y2qblUV8nUxXPlrPAlRenxv5643CvgbUmD9nXL3w+m/GK/Zshu6TV6KVYB3i0sKGKxP
 hG7Ve+84vZu0JqWgU1fP93Z5ycCl/GI+THZuhb8NIYmjn9ZL1fvwc2WTRTMt10BaWB1+U3FB
 b+VcNy3EVERArl9wTy9So81iOFwmn5glDuJGciilnxLNIZyglbPFd/p13PVNogEAF6s+l2Jo
 76zyePbo/mgbAEOSnaOqtNCRbz7BXM6GYr3u6Rqmh2reWJb9JUaI6aJm9sJItU994wMz7ug1
 iztCydwlQuk7VWaeFriV5yWQO62NXqJhSlgZnJE0JfB8yVLXLtDG49FKctsI+d6rLA5pRO2J
 tFcE/i97j10Ym2v0xwWbIXnrZwkcxKuhAmUODGibiR5dJllLzElMPe9IWMDLQECUXi6s9UQu
 bql2l+JSJYPXV06Xs3XdOiu3xW6un1EwLB+WE7BI99yfkTw8dc1d3yt36Fve8xcew/ewja61
 hqNBUtKr+f6vIJoosLCgrqJrtn1HrImTFZaBWTS8Z2/KTLeoji42YZFXevRJWLdWWr49b+Mf
 +JQy/2gYvQLkEwT69h3EqpxzLJ47Nzq/ucIwgNhFXTNTlKqFrI/fSXWgZgR7vVAn+YLtxG3V
 0SD/shhFY+IYM61QkQMIAcFb/iY0a1GkDfl8vlocl7x4zV6/eTbXBwKbQWMkiFUMJB8LJghn
 bU6oMcT5gGy1kgqP9KBgnwG/miANCVdAaAut5VcC473kAs7jFpFZMWEWCPx5ZiObfRKM1Urf
 WDI1PaT2ewEyxqQaWc3GFjMwfFZ1MYHtx19xVMfI0iEx4jejfgt0RwNqTk6Q2y5FPmcPz6f7
 oSzC3BIGA==
IronPort-HdrOrdr: A9a23:fGOmXa12QvHhDleUsTCjPgqjBTtyeYIsimQD101hICG9Lfb3qy
 n+ppsmPEHP5Ar5OEtBpTiBUJPwJk80hqQFn7X5Wo3SIzUO2VHYUL2KiLGC/9SOIVyEygcw79
 YYT0E6MqyMMbEYt7eI3ODbKadZ/DDvysnB7o2yvhQdL3AZV0gj1XYeNu/yKDwHeOAsP+tdKH
 Pz3Lsim9PtQwVsUiztbUN1LtQr6ue7267OUFojPVoK+QOOhTSn5PrTFAWZ5A4XV3dqza05+W
 bIvgTl7uH72svLiyP05iv21dB7idHhwtxMCIiljdUUECzljkKNaJ56U7OPkTgpqKWE6Uoskv
 PLvxA8Vv4DpU/5TyWQm1/AygPg2DEh5zvLzkKZu2LqpYjDSDczG6N69MhkWyqcz3BlkMB30a
 pN0W7cnYFQFwn8kCP04MWNfw12l2KvyEBS09I7vjh6a88zebVRpYsQ8Ad+C5EbBh/374ghDa
 1HENzc3vBLalmXBkqp/VWH+ObcGkjbIy32BXTr4qeuon5rdTFCvgslLfUk7zI9HMlXcegc2w
 zGWp4Y342mAPVmNZ6UqY86ML2K41f2MGbx2VSpUBza/ZE8SgfwQqHMkcIIDcGRCdE1JcgJ6d
 j8uG0xjx96R6upM7zU4KF2
X-IronPort-AV: E=Sophos;i="5.87,167,1631592000"; 
   d="scan'208";a="55687663"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NduD8XwDz4apaUmXBSO27tLeCEzY4UrCKF5rnLIWVcmD5uRa0Q/44qs2vyqlnj4X8bOrd9BDGaXUdeWOshwoVAnsQAvct160UBoCW5cjS8fLpI0P2qdrO/UylsRyJLJh9B2iuVdfLKgXUGxuXJb17+tYGVgS9LhPC58Cd4xfqeyWQT7rIED2+vSADvJ5DhhSlJRW0gzb1/zcxSB62ovZ21w86P9i8bnCybgz4aq5PEJHsXiMrB3Q+xC5/t4q9jaJ46jgsC093ZRTGmm5gQFKQ+uAAqQnT2jV/UXH69tKJtpkNADLr3ptqwS3Cu+yjGaf8PZXutMN/2K83dxqhFe2sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TZjMrRgR0E9VuDgmi8kDWWuWgvg8dRhDyo6wT+8Dvus=;
 b=NBeenWXtXNPtVtSWi+N1xf7HwQw//Gmmh3rkrkIR5sA1Qz9m/ztM32zmNNlSFXj4XX3YC5chL9siRwial7e5r6hGI7qLpGXxfuV8mwrzsz1jgOYsu6Rh5r3xN13RSQVj5Oq0d1FbV58nK2LC1m4Qf4JTLliiecUwLS+c1LhaeqyUsovvqVZ+lGqozlJuEl0QR9Ut9yAy/QWXJYk8S1XtoyLIBY1fb1p0LVzpPBZgk6hT/HZM+IpMNBWlnWd+q/UbjR7Aq4Irn9W5ez8xj6LE3wdFKaLiY90o6fYz2cvvtteJ89SW8F3kBt0+5sUNBBm3OxF7fXuoa9K8MBgT7bmaVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TZjMrRgR0E9VuDgmi8kDWWuWgvg8dRhDyo6wT+8Dvus=;
 b=qtpoFuXmyAejcIigHzbuc81cEfd6F4Wl2o9abkrAIE8PlPKee7lrTeLPCRPllg4YqqtCrSEEY++qI2kj/L8IkK7zYVxcODjHQ3rXTf7zqxVIOI2Ai5jvgfzo1n5O6Zw+8pCDyAJ5NRLFhFpLfG03ZSDN/vXBRGwlZmo+Xx+jv2g=
Subject: Re: [PATCH v2 08/14] x86/retpoline: Create a retpoline thunk array
To:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
CC:     <x86@kernel.org>, <linux-kernel@vger.kernel.org>,
        <alexei.starovoitov@gmail.com>, <ndesaulniers@google.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>
References: <20211020104442.021802560@infradead.org>
 <20211020105842.981215247@infradead.org>
 <20211020155750.3u74bkcp66leeyed@treble>
From:   Andrew Cooper <andrew.cooper3@citrix.com>
Message-ID: <f33b9c4e-08c1-f88d-4873-82050a944010@citrix.com>
Date:   Wed, 20 Oct 2021 17:46:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20211020155750.3u74bkcp66leeyed@treble>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-ClientProxiedBy: LO4P123CA0051.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:152::20) To BYAPR03MB3623.namprd03.prod.outlook.com
 (2603:10b6:a02:aa::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c83b86e1-4d32-45ab-810a-08d993e9345f
X-MS-TrafficTypeDiagnostic: SJ0PR03MB6390:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SJ0PR03MB6390857E11D004FD0A31BB53BABE9@SJ0PR03MB6390.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y0fbb4C7RNiCj15X5f0CgJKTxFiz3UFLNbdHs0QtiPaOjp/IYzxoQgmE+mMtns1nF7FV0dD4kgSCdc+uzi8jZoREjDedjgGo6xpl8dvssuI9fILorOWRwOZItkwoVF3mmo4yv/ih3O/B7jiPdM8I4kPbFrsmDBV4jnw4ghp26BYqGl1leaRGJuwYDp/zRqN0RL6H2P+ULg3mZ5ASJ9JLVZyP9sgU6uRnbSFPlzoVlrs/RMnFIRIp5vaCdg4ClGC8SoDCdkPvLzkaQ8+3H7qkeaLZXbD95XhUN3rf/QJLKaCdrlZFOphtmewMoDLka3A+ROxN8OCQ86a2mOuXKn5eQ8YFdruLTNaJD0Otn6PVZK5r+/DBiUEPRCAvbKdqBQTQeeQOIYJA4/uRQ55q/6z2N3LbmG5DtIFIvLNF1U88SFdnSCQ1DcuyTv3WpUV0VQJgG5XXYA9ewcG6F2xNKThdbVrjqyLdFY9H5/37Cwxpdw0EbYFLag++O/HYCOyHtPGO+H0bfIUsvCxzEUIux6KpjKF7ZofQBxT+MWbQ/D87MXIRYv5/yDzQkhNy0vSb3jDodxZFPMoZ0mC0JefpXvzkAtf82ndJLB+A6cvfImahOZbJex1TSZW8OfPtCnzO04ZuUZl9xDM5FYKkUBplZil2/tfxqLqLhgcTlfmY6Tdm3+06RrAUQSqL2U1nuKQKeXxWgPUcKm3QyiXMeAayXgf5CR3eeR6jm/3TtOtUdtMwAjXpl0v6/Hu3j/ZZ0KHCZxO2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3623.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(86362001)(16576012)(4744005)(110136005)(316002)(6666004)(4326008)(31696002)(66556008)(2616005)(53546011)(508600001)(956004)(107886003)(6486002)(66476007)(26005)(82960400001)(66946007)(38100700002)(36756003)(8676002)(186003)(2906002)(83380400001)(8936002)(5660300002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NWN6QWxuaVhDMVZPQ3Y5N05CTjYwWHVIVm5hRXZ3VzM1RHB3M1FoeDNNcmJD?=
 =?utf-8?B?WEtCLzdZZHJ1bzAyVTRDR2s0YndjeTRKcUdJSVpCek14alRUSGdtN3lLUGlH?=
 =?utf-8?B?WnBPV1ZtaXFwQVU3R3k5NkVvb2RQN3dhSzlmZk8wVFA5TkVxMUZxTW91RVJL?=
 =?utf-8?B?UDdwMnBoUE4wTmk1V0JtaEZPYnQ4SlJnaEY4cUF2WnhrdUlITVZqUisyY0Rj?=
 =?utf-8?B?eWd3eEQ4TGhzQU1paWR0SXdkdHpkbnFmZjE4cjJoKzBpTlRaMG8zaFNUUjA4?=
 =?utf-8?B?VjRyUHFoUkdDV1VOakNFNURzR3ZPNnZEcXQydGFiN09GS0s4alhPSlgyTUxZ?=
 =?utf-8?B?SXllWUdvOG05OFVDS0wxVVFmRXFjSDFuWlpkYUVtZngrVG91d2pKMjZmM3NY?=
 =?utf-8?B?MG9KWGhEbGhRU01wWDFwanFZQWdheFJYNVdEQ0xISjJ3ZUtaQlBIMlpFQWZK?=
 =?utf-8?B?a25nOXNrVnJtNEQ0a3J4dmVxYUtRNUs5R0N6Rnpvdy95bG4wODVnNDJlRXFw?=
 =?utf-8?B?QkRWc0pPLzRDbFQvUWErN3A4Qmg3SUluUkl4OGxSSU9zbTFrUWNVTThqMCtP?=
 =?utf-8?B?RENpYmJNRUYrSzkvR3NZVmVRVU1xTDdSdmFCbDBvTWpMcXcrMmMvYjFaZXQ1?=
 =?utf-8?B?TVR4Y0MwRzlST2hQTlNzUy8zaldmeXZNWEtXTnE0QjZ3eW02T1YrbGtJKy95?=
 =?utf-8?B?MEdJUFQ0NUpOZkZrRklXcFpCZm50UjBiYzJJSDMxd1BhUmMrbCt0RDFlanRJ?=
 =?utf-8?B?TW0wVlZUQThjdHpQejE0UW5OT0RVN2dIL2RsQXhlWHNaRXlaRUgvcGluaDdU?=
 =?utf-8?B?eG5FcU5KK0hNUndqM1dHZnpySVBBRkJsWXVMckgrQ2RDTS8rV25xTU1FSVJL?=
 =?utf-8?B?YUg1eDQ3WmQ0VEhacWNqOE9nZVRrNnRnakZIdGJ2WW9aKzFpVUhsd0lCY0ZY?=
 =?utf-8?B?SWZUeHJqMFUydE5jZmJZenlTSk9VbWYrQngxcDMzeW1WVmQwdi9XeUFSbjh2?=
 =?utf-8?B?aHdSR0FjOXFJam1PaVNtNGNVZno2d1V1Nmg5WjVrRzlhYUpnUERpZGZKZkcw?=
 =?utf-8?B?WERhUGNNTFAvWjZLeENCWURFZHFPalNSZHVUdDBOWUdzSHBsVjdYbDM5SGo2?=
 =?utf-8?B?K0FQaHp5cnM4cUNTY2xzeGJ2VWlvZTM1b21scGFuV3c1Y0VlZ3l4Qi9wdmZw?=
 =?utf-8?B?eDVPVXdHNGxNL1pqQ2EzODhnaExrcEJhQmxXRks4L3lKNEtoRjZxbXQ0RmtP?=
 =?utf-8?B?elkyeDBLWXpBVEVSM1hoMXMxa2s3RXlWcHZ1UHo0TlhSYjljd2dHdWZlWDYx?=
 =?utf-8?B?dUsvc3ZLV0p5YmtWNEhmdXd6VWtUOGduTFlEVm9YOUpoaGgyMFU1cmtrakdo?=
 =?utf-8?B?NE5KcXplcS9lSGlxTEJySmdicENTUVh4blNLWkh5aDBjU0o3NGFSeHA3VkpM?=
 =?utf-8?B?cWxGRU0zZG12K1NxZjFTUXR0WFFPZEFFSjZpbFF3bkNURFlTWFpEOVRUc25C?=
 =?utf-8?B?cHRIblN6NTNKWEFPZ2QvaVdsclFlR2tEeDM4c1FxV2k2WktwSkZvekdIQjl0?=
 =?utf-8?B?VlBxM2NKbXQybzZWb3VrRU9oR0VieTdZUG9TK09OdWNNZTNoMi9sZ25YYlpC?=
 =?utf-8?B?NUFFanVYeisxTDNZMWt6UDdacldobFdZaW14eEpLakpaSGNzQjBSUTlEbEEx?=
 =?utf-8?B?QTNFZk5QSUFkajF4TDBBTnAwVlRFTzZzSUNtc1RKNUZoZXNCaytrb09OeW5C?=
 =?utf-8?Q?Mcve3KJ6dfZWIbCmIFyz1qJojYIbye2Xmcpu00D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c83b86e1-4d32-45ab-810a-08d993e9345f
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3623.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2021 16:46:46.6772
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: andrew.cooper3@citrix.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB6390
X-OriginatorOrg: citrix.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/10/2021 16:57, Josh Poimboeuf wrote:
> On Wed, Oct 20, 2021 at 12:44:50PM +0200, Peter Zijlstra wrote:
>> Stick all the retpolines in a single symbol and have the individual
>> thunks as inner labels, this should guarantee thunk order and layout.
> How so?
>
> Just wondering what the purpose of the array is.  It doesn't seem to be
> referenced anywhere.

The array property is what makes:

> +	reg = (target - &__x86_indirect_thunk_rax) /
> +	      (&__x86_indirect_thunk_rcx - &__x86_indirect_thunk_rax);

safe in the next path.

~Andrew
