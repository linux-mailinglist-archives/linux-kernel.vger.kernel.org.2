Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48DD0368894
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 23:29:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239637AbhDVVaD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 17:30:03 -0400
Received: from mail-eopbgr60090.outbound.protection.outlook.com ([40.107.6.90]:5604
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237018AbhDVVaC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 17:30:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WJ4xSryzTpD/VOr8zvLL0aC4h9z7xRA/yA/qfb+12M1Qj3l2F2rJDAKAh3e+ecpOeXJZlEfYIuYuIWlUQw1D7jBJUSbg5O24R/IwWITQ1zTlrhXlL/r9ygkDTKQ4M+MYPsZELjoKusvTRrq6RpBs4sSQ097gCFPAehvILVwvGSd3txhUIiiuND3Ygr/RzYo5vwTC+x3q4/c39Bc3KuKP3KxNUGKRibImW9eIScn91fHjHglwMYZGgTi6v7ANKdygtEjeFCpFLPXEUb/xYqbZB3e+sASsd8/ZN/Ju+8IExY6YTt7+v+oQdZJtO2BdryZLs1o2DdJUIZbHf9OvZDunxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HBH5UNm1d8wm+0J/cCay0NSFQa3oQxJNocLJ0p4N9X0=;
 b=P27sFzLMY0yFJfZzguboPPEI6JkKoltvSuomqEhsbSBC1jmku8QK8q34/okqjRrWynAPV5/W/GapzdY05amibDCo46BQ/notWTD15FQpR5r7HhV8QTxCOQj4GI9MWmhTYljHXSHgBazpwZ7aGV9xhTP2vg/J3EyQtu1jXZHZ1e69LohhJej2PwNsDELyAJ2zr9PXpSaV8W96t8HfsMm2DX3KWFk9GHMPyu2BAM6bY+xEAHiSnwkssBwP22GIVRQFVzyfDobXxKPD1uJhADC3bSuKWIi9bPFIKZjr7z93TERONBRQUf84YTWenFJ1NOEmx+hDEp8rCudcQbMr+34Ljw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HBH5UNm1d8wm+0J/cCay0NSFQa3oQxJNocLJ0p4N9X0=;
 b=oipBULU1Aa2Rb6ZImkhMa70xL0vBRjVO9a6ZTvdt/RIjJVg20qifL1xtDNta9L6AnKzUdlAJqQZnmVVsjMXGoA/arhWxTtzsKBOxpAkgDFazTJ3MLYyDFH38Slt9XRGgoRfKCeN5NaATncrsn08Ho5gy/focVq2mhwo7AuD0zEk=
Authentication-Results: umn.edu; dkim=none (message not signed)
 header.d=none;umn.edu; dmarc=none action=none header.from=axentia.se;
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com (2603:10a6:10:eb::29)
 by DB9PR02MB7354.eurprd02.prod.outlook.com (2603:10a6:10:25c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21; Thu, 22 Apr
 2021 21:29:25 +0000
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::d47d:ca8c:4fe6:3908]) by DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::d47d:ca8c:4fe6:3908%3]) with mapi id 15.20.4065.020; Thu, 22 Apr 2021
 21:29:25 +0000
To:     gregkh@linuxfoundation.org
Cc:     axboe@kernel.dk, linux-kernel@vger.kernel.org, wang6495@umn.edu
References: <20210421130105.1226686-168-gregkh@linuxfoundation.org>
Subject: Re: [PATCH 167/190] Revert "gdrom: fix a memory leak bug"
From:   Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <23ffd3c5-0095-6a95-8c30-2b6f67377ce7@axentia.se>
Date:   Thu, 22 Apr 2021 23:29:22 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
In-Reply-To: <20210421130105.1226686-168-gregkh@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.229.94.233]
X-ClientProxiedBy: HE1PR06CA0128.eurprd06.prod.outlook.com
 (2603:10a6:7:16::15) To DB8PR02MB5482.eurprd02.prod.outlook.com
 (2603:10a6:10:eb::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.13.3] (85.229.94.233) by HE1PR06CA0128.eurprd06.prod.outlook.com (2603:10a6:7:16::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20 via Frontend Transport; Thu, 22 Apr 2021 21:29:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c953d7a0-6d69-4068-a592-08d905d5b386
X-MS-TrafficTypeDiagnostic: DB9PR02MB7354:
X-Microsoft-Antispam-PRVS: <DB9PR02MB73547E75AEB7CDDD263D88A9BC469@DB9PR02MB7354.eurprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S/VhS+6LfApOpFGFBO3yjessCZdFg4MO8K/uiX+kKPzJtyjBq5sD2r40klI7oy+5YPnkvgaQdLdNLXwtgMy6BmTrzXOy+BSJ9Xf+SaBd5XL4p5dvGdyItGANEczHNDA2i24efKWZrZbePkAWZriPQheprO4YKybY0Dx317aRj5Uro8zhLJ9CyAkwz6U7tjbO2Ohf6yInXdx96eajObsjnQPjYAS4tdS5bwJCIdcjOuTfrAJzDaEQk5Y0Ss7GoaS9OfUiHd+qnXzZJ1CS3c3l+OH470lhLjSQGUdx+nE9ewGdN0/QLjNsS+5puMYzrFaKe97P96H6xWDtAjQSYv6zelLKAnmR8lLcMl/jfsW7eY4hV63aw/zYm1JDkapDtqwz2+0nrV76xTEGCd3QKtVmWWKmWHUjDX50SiXGLXEgf+UiS5lyCA9YkzW2CeQ65dVkR63mxLHSPOcs9VmtUNfXhNgXDE1MqWlA29fFybs5w/TP2oOHvsXWnrVkibiBKpbWkS7EA7dQwRrhIlgYq3247PMyYTIGz/dOeJINHzqy2FrtLZh6mVl9rJ8Cp6quOohCGqD+M+Tp3+dXZ/NdEJaQ+qWbecHZ/a0DjXf/6Dn4Rdxmp/YXRvwtEPO7lcxuai+J9vM8yQq/gU42Uekp5bh52qZLz7G6OUQ8MKv1rXOLHXGBtTDIlUDMHVoyHxvuzD6m
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR02MB5482.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(376002)(346002)(366004)(39830400003)(8676002)(2616005)(36756003)(316002)(956004)(4326008)(16576012)(6916009)(8936002)(16526019)(31686004)(186003)(26005)(2906002)(86362001)(36916002)(38100700002)(4744005)(6486002)(66946007)(31696002)(5660300002)(478600001)(66556008)(66476007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?VjZCajQxZm1rQ1pvSmJJcTM5TlVrdVlQRVJHRjdXM25vZkZwUVF1cVlaM2p3?=
 =?utf-8?B?MkJNMnQwWWQ4TEoxWnR6Mmo5Z1BISDRIVm1XaTkyc2c5dHNocEVzRnJUQ3pH?=
 =?utf-8?B?TXRsa1ZNS2wrWDYvbFd1Z0s5RnJsNGJOcFFzVHRKZVVpV1pha1hpMFNxTEZK?=
 =?utf-8?B?VVl1M0ZVdjJYZ21SdDJwT2hERXJpajlGcHA4SHFQNHpTRXIzQXNZNkZnK0Qw?=
 =?utf-8?B?THBhV1BtQVZJZWQ0d1RQdUovOS8xSVZwTDdNNCsvTmtWdTZlVXBZTUsvWVFK?=
 =?utf-8?B?bVdrUm5mNXVld0dLbk42Y25WKyt4M1M5TWlQWDIxcXRrZlNPOFUxSjJGV3Rn?=
 =?utf-8?B?QjF3ZXdsVVZ2MnUrQmFDMUR3OVFlWlY3K01FUExGTUFaVUVMalFtWTNzbEVQ?=
 =?utf-8?B?SXFwTHpLYTREbnVwK2F5VUVnT1REWTUzWVdHUU5BR3ZvdVAwdXVrcWN2NUYy?=
 =?utf-8?B?S1JLcWZxZU1wZytpVG1VNEg1V1RVWW0vNmQ1VzZvV2RMTFRRNXFheHpLKzkx?=
 =?utf-8?B?MkZXc3hubW5GaGZuVzlNOUpNcjhyTHcrNVJkQ0h6VlRKTDRHVCtkRUJlQ0M0?=
 =?utf-8?B?ZXhmQ01ibTdVTnJZV21ZZDBnL2s2Tms3VlN0Q0lrR1FRT053bU9KSXY5UExk?=
 =?utf-8?B?UW1GNG9HelFYa0lhblgwaW1hNC9jOUxQNmwzTGNJM3FNa1lyTGxvNjFrcVFN?=
 =?utf-8?B?ZUY5SlM0OElpa0VCT2UreHcvbk0ydGJJN2Vaa0FmT0xpZUkrT1BZL2xML21Q?=
 =?utf-8?B?elUvQzlSWmlPWm1WRnRtQnBiLy9Rbi9lejN2NDVROUhBbnJIalpScjB3SmxJ?=
 =?utf-8?B?ckpSZTd1bm11UzVnV2NhR3pWUC9ySTA4cmFZYzcvZG5oVWppZmRtb08wSEpM?=
 =?utf-8?B?WEs2OGU0UlJhMHhkMGxDbDBxbTIwbnlpbnJIU1VBMVVVdzkzRUZrUEt3OTZa?=
 =?utf-8?B?U1NOdGlkSXNCVG9WalNXR0VkeVR3b2wrV1A1WUpiU1U1RkhydDR0aGdtZzhr?=
 =?utf-8?B?R2lTRktyZ1lTU0pQUnBNTDNlUXEvcWcrT0k2ZXB4TllTYWJGQkVuRFBwVEgy?=
 =?utf-8?B?TDQ5TDFsQmt2amNBakcrZnZGdnhsS1llbEIyc2JGMEJ5QVIwSHViWmNDUGwz?=
 =?utf-8?B?VmMra1hVQU9kUUhCUTJkTGxlQ0JOcTZYdnNISC9pTjQxZHQwdUdhL2c1NCsv?=
 =?utf-8?B?V1lPRGk3dUlYeUV6czZvcHFOQzlTaWdnMGpwWGd0bTJTMHhHaldSeDFPbVI4?=
 =?utf-8?B?RFZ2SjN4N2dNS3hUOGs3VnQ4Qld4dXZCNjlCS1hMT0lzSmx6YThkZWQvN2th?=
 =?utf-8?B?bm1wS2k2NHAvSURoMHduZ2hLSUszL2xkTFN6TlBDVVI1RUpxN0tzaWJqZWpx?=
 =?utf-8?B?bUNpMFBLRUI5WDR3MDl6bTE3emhwUTFKRDVFK1F0SUlpSC94VU8zaXJ0WG53?=
 =?utf-8?B?amowWjV5QngyeEdLR1IzTkI0Z0JEQlI4QW5hbXJrY3VtR1l4TUswbFRaVlI3?=
 =?utf-8?B?N1hGS2lPdmFScVRabnI2NkJhcWdPYXlEVzY1N2tBamd0YnMwZVBDU0JzZTEr?=
 =?utf-8?B?WEhxSjJ5YVJTb20zUmpVUGc3eHRJZUhIMnZLS1R6cDFxbG84MWM4U3ZMV0Ex?=
 =?utf-8?B?Z245SzNjRFR6ZE5sVVFtTkdZVzdwRWhCd1c4TTQxY3pJOVRFWUlHblJkWnZv?=
 =?utf-8?B?SWYzam9OdDgrdC82RnRvM1JCeUhVelFVOTkrYkFvQmp5WHNGUGFqVFNaalZ6?=
 =?utf-8?Q?h5IwESY9Td5IkzsnuSeYn1348xvS2yeERkIviwC?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: c953d7a0-6d69-4068-a592-08d905d5b386
X-MS-Exchange-CrossTenant-AuthSource: DB8PR02MB5482.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2021 21:29:25.0862
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uzX/OTP8jjKvixtnhWYjz2NsGUaFlTPU5iYd4IJODmD/1cSc89VIfMPLh3NzpQbn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR02MB7354
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> This reverts commit 093c48213ee37c3c3ff1cf5ac1aa2a9d8bc66017.

The reverted patch looks fishy.

gc.cd_info is kzalloc:ed on probe. In case probe fails after this allocation, the
memory is kfree:d but the variable is NOT zeroed out.

AFAICT, the above leads to a double-free on exit by the added line.

I believe gd.cd_info should be kfree:d on remove instead.

However, might not gc.toc also be kfree:d twice for similar reasons?

I could easily be mistaken.

Cheers,
Peter
