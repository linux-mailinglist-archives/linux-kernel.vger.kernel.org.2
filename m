Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2161936E9B0
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 13:40:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232048AbhD2Lkp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 07:40:45 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:40978 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230148AbhD2Lko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 07:40:44 -0400
Received: from mailhost.synopsys.com (sv1-mailhost1.synopsys.com [10.205.2.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 861DA40461;
        Thu, 29 Apr 2021 11:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1619696397; bh=UJChwqX6dL94nHg5wNmxzJIUWv+liIE0cSZkIGWi17Y=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=IP9fs5dN0KXrU/PbFtFtLCVMdMlSMk/RcriUOm4sM8Q3onj+FWWCPSrT3z8AJbZJG
         CuaQO5if3U7pPrn91dpw6zSeNYOvKwrCu+9crnBc9eIQQXP+ITQCApE3x58z0xtsQJ
         PFvviBZOqfrFwX4kOeqjl33QYuKRnsVEeNxeSx8GzhIyyuYZz9q3/GzzQ/fcS+O/Ou
         jSjdvP+YWLpLxmD9ZGRpAf77kFfOXuhjdrLoIuxgZhjWrAjZ/OPWK8mXjWkbgzvuMx
         rHAEVc3WxKe7Pd+NF8vtWnBs3t/l2enpwIF85AJaJefA7WpGfA6izUf8iAdu/K0mKZ
         BlmUQhbicTDeA==
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 3849EA006A;
        Thu, 29 Apr 2021 11:39:56 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2176.outbound.protection.outlook.com [104.47.73.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 6D0C240099;
        Thu, 29 Apr 2021 11:39:55 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=shahab@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="Z+A2K3OF";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YkbnSLZ58MdwdGYi8elHezgtcrgd4OpMkglUtZOjUG8iQ6FZjXVkDdQC7p4yVZcE1xiARuZ4EaAgSKvZLkRe3HZU1DY3ofH9FWwo/1+/dzLbZDUUGAISXUwDJYI9AUUUMpXST3tg6xuqO8CVzjL8/29/lzydN+ZLM/3gjhzBc8oOzymbpr6ypBJxTHJTENE+dZYU+IzjX0twZiNqRBXohLpqiKWBSygMxeBusnAxM1XF5L7+3SJO/7iakBxMIDvopLjXng4ElkQTRaRPeCimmx4qJSKop3m8eX3WUiJT6/sA7S2KyKVz+iHROlqp1ysFCBKjm8RM3SB8KgY1tijEqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UJChwqX6dL94nHg5wNmxzJIUWv+liIE0cSZkIGWi17Y=;
 b=NPX4ik8qj5W4g4BaPyu7Zhb1bxQd8cYcxicokTFmS4F62jf5pYBijDkzxK0LmgO1qObh28PaR1EhxoiEq5Aq4NLLGy266WUXSvY1FZMBjQfQt2wZMbd7Mec96IQmdw5T1JR1Qx0kYg5JDpDBZOsGaLmpLJdH9YT8Hq6wdTmAHS68MkIJr44VFU4xobeOPBWjuJ710fYrOLbYvFAfuBTD6Sd5ag4jUoXN6yXqgAbs9VxSTWMqVYV54qHvkNIHW5gONk7Q+P9G14ohPvhP4wPjSj/Spjk5ld1RuUtarQG67JH+D22c1tdR7QQHYzY2GOUB6pPQRx6U4o1a6hfcJKxQ8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UJChwqX6dL94nHg5wNmxzJIUWv+liIE0cSZkIGWi17Y=;
 b=Z+A2K3OFjt9UQCIITGTJPeH0pWj1vqZFjTw4P0cl9Xp80rPfIt3ZpGOs48wIUMZjZT1GRwZlf9IpEkan8yfdhYmgJUZWbFDbSwqOSHsIhmjCC7fco8/pbd4f3SJx7bWVeVSf48lO2kj4cLvK90XMBEbeVSJahQjGyiQAKt1/XN8=
Received: from DM5PR12MB1580.namprd12.prod.outlook.com (2603:10b6:4:10::10) by
 DM6PR12MB3995.namprd12.prod.outlook.com (2603:10b6:5:1c6::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4065.22; Thu, 29 Apr 2021 11:39:52 +0000
Received: from DM5PR12MB1580.namprd12.prod.outlook.com
 ([fe80::a565:da8c:3790:20b0]) by DM5PR12MB1580.namprd12.prod.outlook.com
 ([fe80::a565:da8c:3790:20b0%11]) with mapi id 15.20.4065.026; Thu, 29 Apr
 2021 11:39:52 +0000
X-SNPS-Relay: synopsys.com
From:   Shahab Vahedi <Shahab.Vahedi@synopsys.com>
To:     Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ARC: entry: fix off-by-one error in syscall number
 validation
Thread-Topic: [PATCH] ARC: entry: fix off-by-one error in syscall number
 validation
Thread-Index: AQHXOHpElcuKnU9ZSEqu7vDIz0TRhKrLZ8uA
Date:   Thu, 29 Apr 2021 11:39:52 +0000
Message-ID: <8d154e49-d77e-012a-81df-c1946b669bb4@synopsys.com>
References: <20210423195257.892560-1-vgupta@synopsys.com>
In-Reply-To: <20210423195257.892560-1-vgupta@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: synopsys.com; dkim=none (message not signed)
 header.d=none;synopsys.com; dmarc=none action=none header.from=synopsys.com;
x-originating-ip: [2001:983:21dc:1:fc9:f284:50db:dc0e]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 85f8462b-daa7-4f0c-4166-08d90b0380ff
x-ms-traffictypediagnostic: DM6PR12MB3995:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB399553A52855F1EDF67FDBC7A65F9@DM6PR12MB3995.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: raFq1N/RRRMu9SXNvGu1AhC3hhNj2QDAO8bsL4AAj1oH33kjYNfXQktRCIkJGbmTn8uRpUKBWspEdfMTPi6NbzyEXMfb5TrLdanbjYs1zxy0WCPVkBCgu6v9ATcY/H9HAJe9VfidgozQ8aQ8JcnnJN2gVH5XFBCX+6xN03HAcxJFuPu8CHO/vtqyUPjB4LGISQCtapq7n2fg2hvpoDewA5QEAfov2dZMVkZkdiNpBMNHjui22Eo+81oSsqq22iCvfslrGMAWBYI2xUBY/QiilPgRUC4RN7I9ZBD+oy8zW4TgSHWoSsVqijLi54pye9B/ouDdLkdXiB6PxHLf7Rzv/JZzeDNIQbHJone2gvVPXq7f2TBbKt/LDH+3letuLQR0VH09c5BqNG71deJLnPjaCZzUn6/0zMMXj+R6+iYyexU/UAPsxBW80+b2Hk0kBc+9uDEgXGU9LextpD4dweLFDNYS/C4ZnKYhnkZTmrEw+buyLvXqluDqhOR+0fbXcvIo3ZroJRv3GnG0FLiTwzgLiwd+iuOn/WJtAjoaPQ+R/wfsaIgpdF+J7fwDykNd1xJnhnP7Eu4vHq4zReGgQSkASa+GX/pztOr7EFOVmD9pEWbG0pdJ9JiTuBXd6sCONHuRIaXC59iiB4mt7mHTAz2YubwczbXAjVdqDTJDXpieW/A=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1580.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(346002)(376002)(39860400002)(396003)(366004)(38100700002)(6512007)(122000001)(4326008)(83380400001)(2906002)(186003)(110136005)(71200400001)(31696002)(36756003)(2616005)(4744005)(5660300002)(6486002)(91956017)(66946007)(86362001)(66476007)(76116006)(316002)(8676002)(66446008)(66556008)(31686004)(8936002)(53546011)(64756008)(6506007)(478600001)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?QURKUWsvOUp0NjRiVDF0SjZvZFJPYjA4RUN1bldpOVlKOVh1MlpkbUJwMTJN?=
 =?utf-8?B?bzhOa1VUQTBmUFozZG0vS01zUnB4aHMyajN1RUVSM2lReTBuUGppczNjNTAy?=
 =?utf-8?B?cWJLUVgyVFBPYm10YTVwdjI3eUFmZHlTVFh0ZGVCTkl6Uk91YnU1WUJSQUR2?=
 =?utf-8?B?SWpzeDQxa01hWFJZV2tEb0pycVpibkF5Q0JaZWpFcHpwa0J0WVpBWkhOKzRs?=
 =?utf-8?B?ZnBWd0FvZ09ma1FjeW5EL3UzanF5RGVWK0ZjRVVNbnpnalovU1RpMTJtRWg4?=
 =?utf-8?B?Ni81NG5jMFdPczdwQkd1TG1SWGZnMmZ5VTd5cmx0MVhnVC90VUdoZGd5NnBQ?=
 =?utf-8?B?T3pObC9JUVhmOTU1NXFSWUluNkVGRk9WMWdnV0cvYkEzY0J5cTRUY0I4VHJp?=
 =?utf-8?B?SHNTQitzUVE2b0I0MDNPdnM1aVRzaDM4WmhrdzNiOGxQUkE1RUh0WDlGVWpp?=
 =?utf-8?B?ejliRWN5amxEODZyQmsrSkc1WGlNMElVR1QzVlJuOGtOTFNGQS9kanFaRWw3?=
 =?utf-8?B?bGVxZGw1UW1telJFOFRNZ05GaFN0WHVTU0JEcmpaN0dPdlhrbjlMMnYwcUNn?=
 =?utf-8?B?dWVkV2YxMkk1bGgzOUM1aXJPZC93WUJiQkxQSWNlWm8rUVhBdWJYSzU0R2Yw?=
 =?utf-8?B?M0RSZlAraFpvakJoekpoV0I1aHo0dmJIUEtlNzFuQ3dGNHUrQnhFbU4zOGx3?=
 =?utf-8?B?ZnJKWTRHdnZ2dUR5eW9tU29SUktBZTVoTXhFb21tUlNnZDA2Q3lnRnE5UUNy?=
 =?utf-8?B?NDlCRjV6VitkeXpueU00Q3pFYlIwL1RRR1hoaitIVHpnb3lNdHIwSGtoblFG?=
 =?utf-8?B?eUxxOHhld3FvMVpZQ2dqeGtsSytRMnFlNGRzZk84SVlXOUI1bnBuVEFaUjhI?=
 =?utf-8?B?S3pOUDEwaWV4NU4yck1sdnVvaGVGWWFVWTAwdWZqUHBGYVc2d2ZzQ0x4VHVa?=
 =?utf-8?B?R2dOcS9NZ0NMMjU3VnM5UzV6M1FuaWRDYmUvaTlXVGYvMlVWV0hsS1NjV2Vy?=
 =?utf-8?B?RDNpejV1akxhK1R0V3NIQm9MYnFxanhoSnVOZXdSMjVkdnh3U1BSa0xqcnRk?=
 =?utf-8?B?VkFEZnBDU203eEplV294RTI4M3dGa0Z5UHdubytEMmQ3RUlPUWFqenVUVGRi?=
 =?utf-8?B?SkZ0dXh0eTFCNFpVMU1hZFF5OENaakRuMHJlQ0czQVZCWEVIT241cDRnYlBI?=
 =?utf-8?B?ZGZSNmNLdU5UNmsyYUlSV2s5cUFLTFp5N2VJQkxZUUc5K2hzUmd5RFBXNFkv?=
 =?utf-8?B?MmlkMWQ1amhWbWtOV3BNZmYwTGZQZEtRWUUrNjhHbkVxYnlaTlEzRVYrOUV4?=
 =?utf-8?B?b0ticTZsSjNTbHE3MERjSERXaitUL1Q3b051UWNQTjRxYmZ4eUhrTUlvWnJR?=
 =?utf-8?B?MHBqa1l0bDQyMjJMOUUvN2hSQzROQVRPVDduL3RoM1NWck1pMXJhclFQSStV?=
 =?utf-8?B?NUNPRkRQVWpYQnBCQzJweGFTZzZwQTlpZnk0dmZRNGh0Q2RRMEs2cVMraVJY?=
 =?utf-8?B?WnFvNXJMS1ZCclEyVXcrWTZaN2tzMHJFemdiZ3NMcmxDWFNKVThiZnZ6dHZn?=
 =?utf-8?B?RFZ3WlI1dHlDVkhLcjlsS1lGcmdhV283eVRTYjZqNTV5VDdQOTZMV2c3TjUy?=
 =?utf-8?B?clZROUJJQ2xoMmhGWktReFlxZTY1NGRQQ0lEeGZBaDdrbkY5KzhIdjEvbzgv?=
 =?utf-8?B?Vzd2bUtGcVZqcEFkNk9vM3UydS9uMlo5V1Q4eVBPSEJoWldOcXE5TFlDREE4?=
 =?utf-8?B?MjUxUS84MnVxdXFxVGlrMGhpTnN2MUpQbGNIaW9iYUJ2cTVnMkZueWd4T2Vl?=
 =?utf-8?Q?F9y61RVqBUvQNJzjU8buANuMYiqpdGeK9ava8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <97E7D0839A584A4EB3659079FEF9C83C@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1580.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85f8462b-daa7-4f0c-4166-08d90b0380ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2021 11:39:52.4936
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Gst/FlsNclxZ3FdMHWIn//YyUKEPCTJlrtslTxSY/j/mREbeRdYEiIQIqsld/HXKAu6TVooN1NYWh8hmh+zgiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3995
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNC8yMy8yMSA5OjUyIFBNLCBWaW5lZXQgR3VwdGEgd3JvdGU6DQo+IGRpZmYgLS1naXQgYS9h
cmNoL2FyYy9rZXJuZWwvZW50cnkuUyBiL2FyY2gvYXJjL2tlcm5lbC9lbnRyeS5TDQo+IGluZGV4
IDE3NDM1MDYwODFkYS4uYWVhOWI1NTg5OTNkIDEwMDY0NA0KPiAtLS0gYS9hcmNoL2FyYy9rZXJu
ZWwvZW50cnkuUw0KPiArKysgYi9hcmNoL2FyYy9rZXJuZWwvZW50cnkuUw0KPiBAQCAtMjU1LDcg
KzI1NSw3IEBAIEVOVFJZKEVWX1RyYXApDQo+ICAJOz09PT09PT09PT09PSBOb3JtYWwgc3lzY2Fs
bCBjYXNlDQo+ICANCj4gIAk7IHN5c2NhbGwgbnVtIHNoZCBub3QgZXhjZWVkIHRoZSB0b3RhbCBz
eXN0ZW0gY2FsbHMgYXZhaWwNCj4gLQljbXAgICAgIHI4LCAgTlJfc3lzY2FsbHMNCj4gKwljbXAg
ICAgIHI4LCAgTlJfc3lzY2FsbHMgLSAxDQo+ICAJbW92LmhpICByMCwgLUVOT1NZUw0KPiAgCWJo
aSAgICAgLkxyZXRfZnJvbV9zeXN0ZW1fY2FsbA0KDQpTYW1lIHByb2JsZW0gZXhpc3RzIGluICJz
eXNjYWxsIFRyYWNpbmciIHNlY3Rpb246DQoNCjsgRG8gdGhlIFN5cyBDYWxsIGFzIHdlIG5vcm1h
bGx5IHdvdWxkLg0KOyBWYWxpZGF0ZSB0aGUgU3lzIENhbGwgbnVtYmVyDQpjbXAgICAgIHI4LCAg
TlJfc3lzY2FsbHMNCm1vdi5oaSAgcjAsIC1FTk9TWVMNCmJoaSAgICAgdHJhY2VzeXNfZXhpdA0K
DQoNCi0tIA0KU2hhaGFiDQo=
