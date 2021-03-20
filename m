Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B712342982
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Mar 2021 01:40:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbhCTAk0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 20:40:26 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:37676 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229447AbhCTAkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 20:40:13 -0400
Received: from mailhost.synopsys.com (badc-mailhost2.synopsys.com [10.192.0.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id BAFE4C00D1;
        Sat, 20 Mar 2021 00:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1616200812; bh=JiMhpt6vX4T5HFK8d//unr/ymo5nsYxEgXKd6FpC8rU=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=boBwCf//OMa/ZsL0bNDos/dgxQzHDNK2fwoA60AWPB/FKTVGvM0YGix1T8jcY9cwq
         gz/11SuCi1DzF4bX1qKcIsgvM5pJ+K6rDKVVJxHkELTtHI9QvP816elnDJATKU6x+T
         pg71zVzPHw7DWS0QzDrQLKfrmEAb51XrB5Hw8jF+WiDi0pi9KDCx3dsf1LouK+VJHr
         Yhr9bovPVM7yREQgbHn8oeQRGVf6RWhLNPwFWbS2shor4W4kKRMMr7t2NmqKyoeif5
         z4oZbZW1bdCpJcBTMrdV8pk0A6ExEmlDjNtqe4yynPZ2YOdym5Pybtpt3Gvrlh2lUc
         vh33/Lr1xMH3w==
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id EF976A0067;
        Sat, 20 Mar 2021 00:40:11 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 4DA1480056;
        Sat, 20 Mar 2021 00:40:11 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="gxQuT2+M";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rj1S8nGgWBAF7NmLDWywoGvquMbGQ/1u6NlNr8rLPuYfVTjYSST+qMXqse+PgH/2WdqHFAw3EBn9WinjkkrkoZsAVOcjMb+o0xNYM42vyQeub018ytUk3bT+6oPYXGOFR8rSFX5IoqlYc7kz18+7dMs04jPiEJpkmst7UpLitXsrZxQBdltvIu0oG+xEOWHGveWIkSWu0ZCJMfajT8965p/MhNAw5pCNuhQqHE7D4/0RopmXw2HBbAmolTbv8lASx8WPqNTLKlmmNDWimiKOx7pN7jhWXWJB4CE+WJU41fxjpgeHE4/Rf5h+wOjRjLgU2g3uruh0QDdIi597fcNn4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JiMhpt6vX4T5HFK8d//unr/ymo5nsYxEgXKd6FpC8rU=;
 b=asR2AFPh9E1EdsdmT4mZnJVCHqlCJ2pj9COBRUZaPw1c/fd6yVoKQl9m6izsoMTIBtl5SD8RE9Oi5yBbk1mF/aS2GmzGSppvZgiK760IqkhTorkKvZViKhdOWrmaCQsPc803HUH3ILzmPhQrnJVvFWlwCyPmANh44UT0yNOcWTQBZ7ck+jZaLFgKqYZT+axJ1aPyQD7kz2z0h9v9+rd4+pGEB+92F1nM0PDkfOTMOmHuBqolDuzq6JjV2W22mHR7j4ej2AI/kReGpIJD6jVDTM+rRssONwQYt3GUxGOo2HBAIjJvl7RZyupe6O2AenTfljEVq8CucB1RvZqWzg26jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JiMhpt6vX4T5HFK8d//unr/ymo5nsYxEgXKd6FpC8rU=;
 b=gxQuT2+MImrM8ee9+HzQKZ7jNk6xGFIqW5iEnlKLWfkbGO2cECABIMuKe9zXjinnznP27nGz3rmWVlfNC3r6ec6Gz/ncuQfqKvkq+eIy6kJn7FzcTHg0fj5kIbW2K+wKFyiythIOTQ9ZnQpvO/k4lkYvmz9htBM0AAPdqHTa3jk=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by BYAPR12MB2806.namprd12.prod.outlook.com (2603:10b6:a03:70::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Sat, 20 Mar
 2021 00:40:09 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::7c97:6a33:14c4:dd8c]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::7c97:6a33:14c4:dd8c%6]) with mapi id 15.20.3955.023; Sat, 20 Mar 2021
 00:40:09 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Wesley Cheng <wcheng@codeaurora.org>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Subject: Re: [PATCH 2/2] usb: dwc3: gadget: Ignore EP queue requests during
 bus reset
Thread-Topic: [PATCH 2/2] usb: dwc3: gadget: Ignore EP queue requests during
 bus reset
Thread-Index: AQHXHKLL7cdvVEBRMk+XgbJ+0C2uUaqMCeEA
Date:   Sat, 20 Mar 2021 00:40:09 +0000
Message-ID: <eae3f779-acb0-c685-4323-d97c7c5c6296@synopsys.com>
References: <1616146285-19149-1-git-send-email-wcheng@codeaurora.org>
 <1616146285-19149-3-git-send-email-wcheng@codeaurora.org>
In-Reply-To: <1616146285-19149-3-git-send-email-wcheng@codeaurora.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
authentication-results: codeaurora.org; dkim=none (message not signed)
 header.d=none;codeaurora.org; dmarc=none action=none
 header.from=synopsys.com;
x-originating-ip: [98.248.94.126]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4007a542-1059-45ae-f559-08d8eb38b6fc
x-ms-traffictypediagnostic: BYAPR12MB2806:
x-microsoft-antispam-prvs: <BYAPR12MB28066C0936466597BE7250D2AA679@BYAPR12MB2806.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nGWBCsezH4Owwuu5l5GgOwp9ny6sXpjfFqixRpIKn/F9HnZ4A54jUqP3An5hDe5tY84cL470usNNKVbRAhsLEvO+aAIkWaOXLjTyX7j8P06Y+k0bZbZdxgOqoYGDZwNd6a2Ah97eRXjbysOpEI5eR0FXs+VskzAS8Zusr7G+qgYR4GKDOdRaNdKEkkXnA6tQnWZaFNjDhqtFeMER2J+tukvy3uIj6cCTRP8Yg7d1OwWDcdwRFDTLGz4J69PfBqyvynlgwCxdXHYUTD+eVmv80ZzqPoWeP9Inwkq99H/dbsT/x8GpMzcX+qhIzv99X7xAknB11VoGBsd2p5ZPGRLZekP6bZxk+9MqWLnSfXw/zWhYcVjyz3HAATfVTqpA5ETvmmcsMkFKuJUtihdf5OPiCzX2+sZG3p7YuBr3NFalcBd+tXVPFbk0ve6i6c5OGHWZK6iMu4twYBVLxluiTM+gEhJEfePmLmqrSU2jcPhW/RG5Tr2D9oUWEar6lbsrLW+TgKVLhRyaoeWqRpbA2b3J6zDUckZ3/y8CP//0yVRxlDAhsbL7bHcE/yF3P/tUYddfwlB/Y/iX5Uv9WoZLJMavBcrtK9xMQTftveXZQqoB1YclsOaCCu8xZf1RS1GU3OVmzZU8LFtQG+tlptydpsWGY+GmltveYuMLLDsewlpoeT0hINUmIkDv3glLH7nzFA9e771/FZ841oZnQzOlzVK4qiEB61kpexUt50VHgU64/WA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(346002)(376002)(39860400002)(366004)(6506007)(31686004)(66446008)(31696002)(38100700001)(54906003)(316002)(4326008)(2906002)(6512007)(6486002)(110136005)(64756008)(66946007)(66556008)(83380400001)(66476007)(5660300002)(76116006)(186003)(8936002)(36756003)(71200400001)(478600001)(86362001)(2616005)(8676002)(26005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?a3hSTGpGSWZ0ZHZ3ZUp1UlNUWjJtSlg2VzhZajFiTW5vZjFneWRZL1lsVnF5?=
 =?utf-8?B?WFF6TU1GYUpNMXNmZkw0eFVyNVgyU2ozUUR2NVY2V2NPZmtPTWlEOUthaFJV?=
 =?utf-8?B?d3ZJZHBuZTlhYUlneVNJOGF4dmFWbXdlUzltWmZibnZkckd5L2drMGZmZVda?=
 =?utf-8?B?SERZRG4rQ01hM0JBR0RURlZzUHR6UGJrd3hnZUxZUlFieEppYk8yY0hOZ1dL?=
 =?utf-8?B?emR1VUpRWlc5ODczblpRV0pVck4rK0ZxY3p2b0RtOVZLZUJEeU5LQkw5STkw?=
 =?utf-8?B?RlVmTWYvSXVEZ3dMSGtmSXoyWk90dUE5aE1qdHRTRXpyT2IwREhTL3Jzd3lI?=
 =?utf-8?B?SUgwaUo0LzRFSjFGbWdkTDZscmV2LzVtVmE4MWFCOU54N1EyWHk5NTJvZ3p3?=
 =?utf-8?B?bXEwc1d0a0Z5MHBQY1NSa3k3ZncwTjRiQk91d3VtMHJ0OUdJbGpINzdLa2VS?=
 =?utf-8?B?eS82YU5IbFBrbFRteGk4czhSZHBrNTRBYUV5WjBnZ2JQUitvbnF0a1NmMkM0?=
 =?utf-8?B?Z3JUaExGQlpTMmV1bkhPY1JKU0o0aVZrNTFvUVlTWkpPcGV1aHZzNUI5TFZs?=
 =?utf-8?B?bGxId1hxcU5USmpSdzJORkY0b1FJdE9SZ1p3bE8zU3B5bkYwSDRuanV4cmpQ?=
 =?utf-8?B?TUVpWGwvbXYyN0NOMDh6NGJvTnZsSjU1WDI4b0kzclBFejU2STdNTmVhNzJu?=
 =?utf-8?B?dWxFdElOMnNML3JBVjJ6U1dQNHdDN3hzRjNYOE9NNGl3TENrYnlaVi85VjJP?=
 =?utf-8?B?Vmk1T3h5djBJek5uY0JlQW8veU1iRFdRQTFtZ2EwNDZjcUUvazBvVlM5cVht?=
 =?utf-8?B?R0VrN2FZaHNtM1J1Zm9OaUVSU1hsU25xOU81ZkE3R3pXcU1jUUdqalRYUVg5?=
 =?utf-8?B?K3hseXJLUXJPL2xYQ3puWTNYN1FFUG9UMGI5YTI5QVdwa05DdlhNRzdvT3Rn?=
 =?utf-8?B?OTVBSXEyM0dLb2ZlazFwU1U0S09kc2dPZjg0MUQ0emlaUlFQTmdKSXV5OE1p?=
 =?utf-8?B?Sm1FdzJtQitnRU5jNDRFNkZqOHh2K1A0cGhxY2pvbkNWaGQ0cml4M1BwVnlt?=
 =?utf-8?B?MnRaMmI3RllScXdEckk0Nk5BNGVEb3hmVGdUd2FLQW9GdDE1SjZsN25tdkxE?=
 =?utf-8?B?L2dLSnZJakxOemI5REZkUjE5NTRINjRHZXlSSHNOSmE4NGNYVnU4RHZMZ2xz?=
 =?utf-8?B?UmF4a3VrL3RCV3JteFZpT203Q2VYR2plajJmbHdOK3k3b0k2dU4vRmt1TmQw?=
 =?utf-8?B?QmxlZjNZOEZKNHUxRjVNUUFSazM2RGl1Q2dVTFZFdGRWVkFkejNqRHZDc0Fr?=
 =?utf-8?B?YUhJTU1USlNiVDRsRWRzYmxwcDZ2czBUYmVSbHpkNDBsSDBFblVXZy9jNzkv?=
 =?utf-8?B?T05WTUVmWHpadEdVYUlwL2d2MFpqeTUrVmd3MUVZSDhCc29WOEp3T3hLOXBl?=
 =?utf-8?B?N01qZWtIYmNyWEZRVmYwcklyeHNEQi9SUzJETEJtUHVDWUJ0Q21PWjh0ekk0?=
 =?utf-8?B?U3NTeVlWVnlDdEwzUG14UUkzSjRsOUVIaFl1ODFrTnRYNlZOTlE5UFBmWTJ1?=
 =?utf-8?B?N2ZqUEFEZEVIRUlKb3FYTk9VMFluRmpIQlN0d1krVDU2RDFTaVBNcGwrOE0y?=
 =?utf-8?B?YlBEMjB6NFQ2RmM1aTcrVkVGMW4vV2pyZlFJTnlPMDFnalVMeUV0NUw5R2Rk?=
 =?utf-8?B?Z0hpQmpFcnFXU2YybmNiVGtVVUppRUQ0OE04b0VBUHIvU3hQSGU0dlliR0hG?=
 =?utf-8?Q?NTw1/r1QcR7R9yi0rF57ludvGfA0AB6La3CS4ES?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <04AD65D5630FC14680378ECD86A4C089@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4007a542-1059-45ae-f559-08d8eb38b6fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2021 00:40:09.2732
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SbBpUPNCq+4J2U/hE7XBP0C6OU+8tgxTW3fQCQHvE+CwRCHv8hZfdwEeJ861wyO09z/IE9hubCKZpQVe4xriQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2806
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCldlc2xleSBDaGVuZyB3cm90ZToNCj4gVGhlIGN1cnJlbnQgZHdjM19nYWRnZXRfcmVz
ZXRfaW50ZXJydXB0KCkgd2lsbCBzdG9wIGFueSBhY3RpdmUNCj4gdHJhbnNmZXJzLCBidXQgb25s
eSBhZGRyZXNzZXMgYmxvY2tpbmcgb2YgRVAgcXVldWluZyBmb3Igd2hpbGUgd2UgYXJlDQo+IGNv
bWluZyBmcm9tIGEgZGlzY29ubmVjdGVkIHNjZW5hcmlvLCBpLmUuIGFmdGVyIHJlY2VpdmluZyB0
aGUgZGlzY29ubmVjdA0KPiBldmVudC4gIElmIHRoZSBob3N0IGRlY2lkZXMgdG8gaXNzdWUgYSBi
dXMgcmVzZXQgb24gdGhlIGRldmljZSwgdGhlDQo+IGNvbm5lY3RlZCBwYXJhbWV0ZXIgd2lsbCBz
dGlsbCBiZSBzZXQgdG8gdHJ1ZSwgYWxsb3dpbmcgZm9yIEVQIHF1ZXVpbmcNCj4gdG8gY29udGlu
dWUgd2hpbGUgd2UgYXJlIGRpc2FibGluZyB0aGUgZnVuY3Rpb25zLiAgVG8gYXZvaWQgdGhpcywg
c2V0IHRoZQ0KPiBjb25uZWN0ZWQgZmxhZyB0byBmYWxzZSB1bnRpbCB0aGUgc3RvcCBhY3RpdmUg
dHJhbnNmZXJzIGlzIGNvbXBsZXRlLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogV2VzbGV5IENoZW5n
IDx3Y2hlbmdAY29kZWF1cm9yYS5vcmc+DQo+IC0tLQ0KPiAgZHJpdmVycy91c2IvZHdjMy9nYWRn
ZXQuYyB8IDkgKysrKysrKysrDQo+ICAxIGZpbGUgY2hhbmdlZCwgOSBpbnNlcnRpb25zKCspDQo+
IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYyBiL2RyaXZlcnMvdXNi
L2R3YzMvZ2FkZ2V0LmMNCj4gaW5kZXggNmUxNGZkYy4uZDVlZDBmNjkgMTAwNjQ0DQo+IC0tLSBh
L2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMNCj4gKysrIGIvZHJpdmVycy91c2IvZHdjMy9nYWRn
ZXQuYw0KPiBAQCAtMzMyNyw2ICszMzI3LDE1IEBAIHN0YXRpYyB2b2lkIGR3YzNfZ2FkZ2V0X3Jl
c2V0X2ludGVycnVwdChzdHJ1Y3QgZHdjMyAqZHdjKQ0KPiAgCXUzMgkJCXJlZzsNCj4gIA0KPiAg
CS8qDQo+ICsJICogSWRlYWxseSwgZHdjM19yZXNldF9nYWRnZXQoKSB3b3VsZCB0cmlnZ2VyIHRo
ZSBmdW5jdGlvbg0KPiArCSAqIGRyaXZlcnMgdG8gc3RvcCBhbnkgYWN0aXZlIHRyYW5zZmVycyB0
aHJvdWdoIGVwIGRpc2FibGUuDQo+ICsJICogSG93ZXZlciwgZm9yIGZ1bmN0aW9ucyB3aGljaCBk
ZWZlciBlcCBkaXNhYmxlLCBzdWNoIGFzIG1hc3MNCj4gKwkgKiBzdG9yYWdlLCB3ZSB3aWxsIG5l
ZWQgdG8gcmVseSBvbiB0aGUgY2FsbCB0byBzdG9wIGFjdGl2ZQ0KPiArCSAqIHRyYW5zZmVycyBo
ZXJlLCBhbmQgYXZvaWQgYWxsb3dpbmcgb2YgcmVxdWVzdCBxdWV1aW5nLg0KPiArCSAqLw0KPiAr
CWR3Yy0+Y29ubmVjdGVkID0gZmFsc2U7DQo+ICsNCj4gKwkvKg0KPiAgCSAqIFdPUktBUk9VTkQ6
IERXQzMgcmV2aXNpb25zIDwxLjg4YSBoYXZlIGFuIGlzc3VlIHdoaWNoDQo+ICAJICogd291bGQg
Y2F1c2UgYSBtaXNzaW5nIERpc2Nvbm5lY3QgRXZlbnQgaWYgdGhlcmUncyBhDQo+ICAJICogcGVu
ZGluZyBTZXR1cCBQYWNrZXQgaW4gdGhlIEZJRk8uDQo+IA0KDQpUaGlzIGRvZXNuJ3QgbG9vayBy
aWdodC4gRGlkIHlvdSBoYXZlIHJlYmFzZSBpc3N1ZSB3aXRoIHlvdXIgbG9jYWwNCmNoYW5nZSBh
Z2Fpbj8NCg0KQlIsDQpUaGluaA0KDQo=
