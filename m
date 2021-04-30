Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 925D736F703
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 10:17:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231318AbhD3IRv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 04:17:51 -0400
Received: from mail-eopbgr40072.outbound.protection.outlook.com ([40.107.4.72]:34787
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229575AbhD3IRt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 04:17:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8eXQFf5bPvXNr5hc3vNXZLaxdIE7wkTnUDMi8CfIisg=;
 b=jAng3cdkBt1v3Bg705N/jHHqnGHOyZ+dSDywc5OYCvZoK9F4NO/Md18Mx/HR36GmkFeAf69rQgxakVQUGlxLjcRwunGPjrf0F9CRFu3ea+9i858YP8nZtctP7zaQ90dkoSrOF/7iCf83qzx17XBSSbSfk9Ujp/f4+fd6M+PA0Tc=
Received: from DU2PR04CA0265.eurprd04.prod.outlook.com (2603:10a6:10:28e::30)
 by AM7PR08MB5398.eurprd08.prod.outlook.com (2603:10a6:20b:103::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.24; Fri, 30 Apr
 2021 08:16:59 +0000
Received: from DB5EUR03FT017.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:10:28e:cafe::b0) by DU2PR04CA0265.outlook.office365.com
 (2603:10a6:10:28e::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.25 via Frontend
 Transport; Fri, 30 Apr 2021 08:16:59 +0000
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
 15.20.4087.27 via Frontend Transport; Fri, 30 Apr 2021 08:16:59 +0000
Received: ("Tessian outbound 52fcc5bd9d3a:v91"); Fri, 30 Apr 2021 08:16:59 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 895ae6785afb771c
X-CR-MTA-TID: 64aa7808
Received: from 0f464dbbaa05.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id CFF9EAB8-DE05-48C7-9329-B1A5F4C38D65.1;
        Fri, 30 Apr 2021 08:16:45 +0000
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 0f464dbbaa05.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Fri, 30 Apr 2021 08:16:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XFhCTM9L5NgJQz3qPcJ7EyC7I/peDC2dku3DALACbmtWqNvSaGzF/uTPlPevE2Fv3w7QhUES4/5rC03FoghfqGH3PD5K8gP9QG6JVblZ8bkgQCB9pBH222JSiksfwEjQbOOeAeUqT4kSgFre72vascuT9gcuPAkrVvnfImrS+oSz4lpTLFlLXb8xeXWMqbCjJkQIswn0/W68bZx0mUxqQXETPrnre8f1E1raGKwv9I3LzXIFQcLHDVpxYLNzeVa5Nz8VR0Xf9EPVpqh1A4QnCtUsww+GV/uYPWP8sYJ6dRl6zkLqhOOLFqO3bFs7dfKojW2uWOe9xrn8yeIa8p/YsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8eXQFf5bPvXNr5hc3vNXZLaxdIE7wkTnUDMi8CfIisg=;
 b=AigwPUPkOOy/bnlu6JSSQXWGaU2DXDJ2vMHaQlNclRgCc1Nat5Dp7ya3mcCvA4o2b1dK8a8MStOAxKfTZE25ncRryKbkUED9eNzytNulFM34zdj7IkaGh4mgqHlq1ae8lSe/1hZurqWX6zftgloxUhLeut/8ZMqyHyWPwgCGdbdqi2rjt3ySn219TMnV+VwCjGVQQB85tvZ/IDDoWENWV2o7IzezUVIC2Pvg2/3XRfFbLnLRxnYrN4IxcF6yANnJIeS7BZv2Qz44WN7gw6XDJeAM3eSmDKUY52UOoEy/76fFAxRxPBoM5N7zbqR1pkWphftdUPdLaiRug7xkyipT5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8eXQFf5bPvXNr5hc3vNXZLaxdIE7wkTnUDMi8CfIisg=;
 b=jAng3cdkBt1v3Bg705N/jHHqnGHOyZ+dSDywc5OYCvZoK9F4NO/Md18Mx/HR36GmkFeAf69rQgxakVQUGlxLjcRwunGPjrf0F9CRFu3ea+9i858YP8nZtctP7zaQ90dkoSrOF/7iCf83qzx17XBSSbSfk9Ujp/f4+fd6M+PA0Tc=
Authentication-Results-Original: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=arm.com;
Received: from PA4PR08MB6320.eurprd08.prod.outlook.com (2603:10a6:102:e5::9)
 by PAXPR08MB6846.eurprd08.prod.outlook.com (2603:10a6:102:15d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.35; Fri, 30 Apr
 2021 08:16:43 +0000
Received: from PA4PR08MB6320.eurprd08.prod.outlook.com
 ([fe80::c99f:671d:bb2c:f20b]) by PA4PR08MB6320.eurprd08.prod.outlook.com
 ([fe80::c99f:671d:bb2c:f20b%7]) with mapi id 15.20.4065.027; Fri, 30 Apr 2021
 08:16:43 +0000
Date:   Fri, 30 Apr 2021 09:16:33 +0100
From:   Szabolcs Nagy <szabolcs.nagy@arm.com>
To:     Bill Wendling <morbo@google.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Kees Cook <keescook@google.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Will Deacon <will@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Daniel Kiss <Daniel.Kiss@arm.com>
Subject: Re: [PATCH] arm64/vdso: Discard .note.gnu.property sections in vDSO
Message-ID: <20210430081632.GS9028@arm.com>
References: <20210423205159.830854-1-morbo@google.com>
 <20210428172847.GC4022@arm.com>
 <20210428174010.GA4593@sirena.org.uk>
 <CAGG=3QUATefn9AG+HvnCfEOBv3iRu4fzFwfmA7Djrh2CmP_weA@mail.gmail.com>
 <CAGG=3QUNykCfkS22g+HRWb0Goa8DJ72TUueLtMe5v1YfnStojw@mail.gmail.com>
 <20210429075454.GQ9028@arm.com>
 <CAGG=3QV0kR__23yEmwwXBpcE1gvjLqRNmF667hhVeY0B3urTqQ@mail.gmail.com>
 <20210429095027.GR9028@arm.com>
 <CAGG=3QW9t2zUPYLt_La=qQTZeHzfLBCXgZRbiia8T6K7n=YrdQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGG=3QW9t2zUPYLt_La=qQTZeHzfLBCXgZRbiia8T6K7n=YrdQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [217.140.106.55]
X-ClientProxiedBy: SN4PR0701CA0002.namprd07.prod.outlook.com
 (2603:10b6:803:28::12) To PA4PR08MB6320.eurprd08.prod.outlook.com
 (2603:10a6:102:e5::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from arm.com (217.140.106.55) by SN4PR0701CA0002.namprd07.prod.outlook.com (2603:10b6:803:28::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.27 via Frontend Transport; Fri, 30 Apr 2021 08:16:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 75278bdd-f4f8-4be1-2ca9-08d90bb053a6
X-MS-TrafficTypeDiagnostic: PAXPR08MB6846:|AM7PR08MB5398:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB53987D1B06680B04E48A5FA9ED5E9@AM7PR08MB5398.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 46nyexKQODe3C5SKYWdV1NBe0KgHWC17OhXyvtnAHf6sGsUGUXjpM0aCn50cZSb1PizA4nQbEPdHql/BbMbaOYemPZHyFA6kXhxDQW6Vq77Jo4aHPGb1Z9/2ksLEmrRAtSt0pNVQbv9E/hOclkCU68HRwUeHKzcCTJmgPtPQKl/6GuAwIIFWUg3JjS1ChbsA9ld5VfzMG6pGoWbpQAnn2TNrQWT820lBcbnyK8HZIeo/5PLi+Q051KXQl7O1uiTZeqtkGdfwTysFoeE/EikwqsUnxX3b47rUpxAmq1GVE44dDfnjjcUZJUbZDQ02XWg/q5/WRkwxbp8TmSH2eOhoHsffjYczjp2XXbjE8mMuveBm8IR2UL8JPJSjJ/K5rWDIhV5zF6vAVs02lsmMu6ocfGeV6m1fuhooDU1QCUE+otAbexpQevzOZ2Q+Ccscl2vC8Mbvy9yrESvLuQWAODHPDaA0fO7vgkYI2bVlv0Ml0iKf/03Y7KsJMisGvweWCxfb94/LVt7E3psrl07J53CjbHkG9xPkmd+hRK0M12OAGF+vx1FC1loU7sYVmcqTu+5kI+wy+Si7vjPE6MVXXMJOoIKhSrMs17ui8/z4UVXq6o0pbu17Sc7o3eR5hp911NFQM+tBz0yi8f55oRJiJ+Pv9yAFo8wl1DXrlusF9OtM7QVlw/l5xs7iYAJKs4UgUpiG
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR08MB6320.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39830400003)(396003)(366004)(136003)(346002)(376002)(4326008)(54906003)(66946007)(66556008)(316002)(66476007)(186003)(16526019)(26005)(5660300002)(83380400001)(7696005)(8676002)(52116002)(6916009)(38100700002)(38350700002)(36756003)(8886007)(478600001)(8936002)(55016002)(33656002)(956004)(2616005)(44832011)(86362001)(2906002)(6666004)(1076003)(142923001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?dGI3K1p4dHNXRVJMazZWN1hvOHRHNnExWERQV1ZRMnFyK2lGTjVhQmxBWUVW?=
 =?utf-8?B?eTdqQVVLeW1rZ2w3QU1tNkdYckdqeUlMK3UveDdhS1MxSWQvOGNsa2lkRXpi?=
 =?utf-8?B?TmQzTXd5djkrUUNyVkdoSnl5ajZMRVNDVHgxcDJId1BTM1NxdUZJS1ZEQlBt?=
 =?utf-8?B?eW5IOFVSbzl1SmVlZ0FLeFd3QUh5eXdXWmdSakxyalpYNjlEbnZJdUtNd21B?=
 =?utf-8?B?VWNMNm55M2Z5R1cva2xhSExmSVc4ZlNONk9CMlQzbmcyd2lxZGloK1JxRXhl?=
 =?utf-8?B?QTZBK0c4YXNsK29CZDJkQXhUYmhVSVpIb09Takd3dTJidTE5ekFEbzcxTW0v?=
 =?utf-8?B?U1BpZ3pBNlBaVDgvMVBqVFBnTXhQcy9zVit3YlFtSXEybitOZWZmcktpWU9I?=
 =?utf-8?B?RmJ4Vll5dFNKVjRyRGpQL3pHWWp6eGJJYkI4SVZJVUFMKyt3VE5qNHhWN3Rr?=
 =?utf-8?B?RFBqWFhBMjhab21XZDdVa2ZWYWpHZi9FOFNZK21RdlQxVjZ1WGlmTktsNko1?=
 =?utf-8?B?RWNhTVlPUUxaNE9KOHVtSzNjZ2MzVzdnYjdnTGlRaFBkSjBjYVVzckRLT1h2?=
 =?utf-8?B?S01qZ01DTGlFUktkTy9KY3NDRWtLUnh1Z0VJTTRjV2U2UVJYNStCb1pXNHA3?=
 =?utf-8?B?STdKdjA5bjJlZXlTc1NUa3ZVblhROUYyK0xDaXNSNXZGbVZ3eHBqNUF1VzJx?=
 =?utf-8?B?NlVKZVVlblNJeEwrVFhoMkNxYlowZSszakRZY2FUbWltN0tQWkhpU25JSWFW?=
 =?utf-8?B?ZHZ5ZzlLajdrYURyRnNWMlIxcktDeTBxRGZsZVhoMWxFRDVYSXgzZExNQ1hz?=
 =?utf-8?B?bWhNZFhPTkhjVy9oUy9OcDFzdnNYR0J6NmxZNzF3U0gzTzNqaURSMkxxVWhF?=
 =?utf-8?B?OHI4WWh6NHZ2Tks3cytYZUlHcFhIazNDbitOWUxaVjFnVjh0bW9KK2krZzRZ?=
 =?utf-8?B?UjVSMEM0WXJZbE8wa3VuUlNjYjdKODk2aFFDQzlHNGRmNldlMlZKWWFWUFFX?=
 =?utf-8?B?dFZmYjF3QkVaSkJzTXRrOE9MV25haFM2VFZRZWJtbGJERXJEb0xMcWRvdkpZ?=
 =?utf-8?B?aEVldGdqaU5RQ1VSQjR1V0N4WDlQREVzZUpHbGVRSE1TbXp0Z0NjMlNxZ2tD?=
 =?utf-8?B?RWc2WW9URTlTUDFVUjdoSFdqVFE4NEZQK1h4QWVuY3d4eDBUNzc5RGgwa0JX?=
 =?utf-8?B?NWZFVi9tMk9SOWhkT1Vic2RIcHA4VmI0UytwaWNYeE1yeTc4dWxhbG1DbkRM?=
 =?utf-8?B?RzZkZFFiZEhCcFRJWno1bHZVVGhyZlRiTGU3RzFVZHpWbTJVYzRjUzNtOHVF?=
 =?utf-8?B?YUxFaHE1WDlaN3RGMDI1OXFwMlFQMm1GMnJkS1dqaUhIVDZTSnlSc0FEV1lS?=
 =?utf-8?B?andSTHZCRnVTVmVMOE93aDFIbXQxY0I4dUlkQ3VHOGFLaHdoWHplQWI5TXRU?=
 =?utf-8?B?V3RTaFA3KzYrWkszVytjbHJZdS93UTVPSU9lbENBMms2b2xteUhsNUdlZmJU?=
 =?utf-8?B?Snd6NXZzY295eW81NFlPMUlNUmFHL2dDTXFjZjJUTTZ0eEgxbUN3VVdkK3VR?=
 =?utf-8?B?RTcvOS9yZjZOMWhCcWVKK0NVbHhGUlBIWXZlSWZ6RUd4MEN6L1NWTW9Ed2JR?=
 =?utf-8?B?NEdTMy9yM1piejhVVDVIR1NCdGxTajhCcXNEalRQMTB0ZENBM0JUZlhaaTBH?=
 =?utf-8?B?YnBycFpNVFg5cm8vTXB4QWxWM1NBVXFLNmJiSm1lcnkzY1BSczNwZ1BCeEJL?=
 =?utf-8?Q?dHqLsr/UNh0tJbDsKcIxDyzkbZyRK4ZfPq1XI6I?=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB6846
Original-Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT017.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: 2b21b6e5-81dd-496d-172b-08d90bb04997
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wD0kGU8sS20ndyVL9Hrvn671Ok4mcqMQrfHg3cVim5pzwlSzlA7YPgLXpLfZpqdN9aZr9KKxxuLjw0VPBAthvp6kaExz609p3asSGoY5DLzlo4ho/Krr0hAWHauPj7P2R6hivcXvkqNE/DV6Ttn0M238rHbkS15z4Y9MvZb15Ikxu+U1KLTIw9wjfE9jYTrCW2zigAWNfg+2aTJUdRH6QmgdnlN8DZ+GrcIkRj3yWlFWdJ6J2iyDql5rSbzP+5neW7hXovDRghMN4jz0i1x1tXLLxpjWl0NRxaScuTGOebmC6DsY1RwYUzuwoppqAMvsEdiUiz/tehtjL1QCHye6azg8iQcOnFN8TvCZBo8v/WovSv7KH/wO8uWtRFttrr6rrhD+meMfNmeP1f8bZlnYtD7sB8Pn47SXM/5F5bHONf6HNErOT3jinvqNGlfg+Tg9hhMV7iWucDXscGgcJBwa2wu+hQrtT2uzdf7TR6hL+mAGySlwfWxuAmm3nngCmjPZVn3F9j2v1z7lAHvEEuoAUE7bSj1R0OF5dEQRUXUUiMiH1wpqWVIHUA9OUMV/4pHKrFF4dcIwM9IOe2zDTR/swNKzU4tk1VdwaGNHJEx9WocLT3JpX5RD6jzgEzud5a54R3KH/wazTeimj//LuZWRE5D+4V4flwjju+w1KL+7QZuadASMKPdkKrFhdf1sdqoKKqnwAPG+HnCrdGd8VpowDQ==
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(396003)(346002)(136003)(376002)(39850400004)(36840700001)(46966006)(47076005)(82740400003)(70586007)(16526019)(82310400003)(36860700001)(478600001)(1076003)(33656002)(7696005)(70206006)(316002)(54906003)(34020700004)(36756003)(8886007)(6862004)(336012)(86362001)(5660300002)(44832011)(2616005)(6666004)(8936002)(55016002)(186003)(8676002)(2906002)(83380400001)(4326008)(356005)(26005)(81166007)(956004)(142923001);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2021 08:16:59.5104
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75278bdd-f4f8-4be1-2ca9-08d90bb053a6
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR03FT017.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5398
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 04/29/2021 11:52, Bill Wendling wrote:
> $ readelf -lW arch/arm64/kernel/vdso/vdso.so
> 
> Elf file type is DYN (Shared object file)
> Entry point 0x300
> There are 4 program headers, starting at offset 64
> 
> Program Headers:
>   Type           Offset   VirtAddr           PhysAddr
> FileSiz  MemSiz   Flg Align
>   LOAD           0x000000 0x0000000000000000 0x0000000000000000
> 0x000968 0x000968 R E 0x8
>   DYNAMIC        0x0008a8 0x00000000000008a8 0x00000000000008a8
> 0x0000c0 0x0000c0 R   0x8
>   NOTE           0x000288 0x0000000000000288 0x0000000000000288
> 0x000074 0x000074 R   0x8
>   GNU_EH_FRAME   0x0008a4 0x00000000000008a4 0x00000000000008a4
> 0x000000 0x000000 R E 0x1

this is wrong because the abi specifically says properties
are in PT_GNU_PROPERTY, not in PT_NOTE.

so the original patch that removes them from notes is fine,
but ideally they should be readded under PT_GNU_PROPERTY.

(x86 needs it there too, but also needs it under PT_NOTE for
historical reasons. ideally the section would have been named
other than .note and was not marked as SHF_NOTE, because
properties are merged completely differently by the linker
than notes, so now linkers have to special case it by section
name. properties should have been designed like the
 .ARM.attributes section except that is not in a load segment
and thus has no runtime semantics while the key feature of
properties is the runtime semantics. however accessing the
program headers of the vdso is not trivial at runtime from
user code so dropping the properties might work too, but can
bite us in the future depending on how they evolve: the ld.so
can look at vdso program headers.)
