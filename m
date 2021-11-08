Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E541447B75
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 08:56:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbhKHH7V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 02:59:21 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:35584 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230103AbhKHH7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 02:59:19 -0500
Received: from mailhost.synopsys.com (us03-mailhost1.synopsys.com [10.4.17.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 15504413D2;
        Mon,  8 Nov 2021 07:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1636358195; bh=vXueZ2rVc5sjwG82hvvAjHes2P7usEVAX75blqWahkE=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=N5hPYdJ33gVzGMsWnTluJ9gzQlp02e9SPfCik+y7TFfTUrXr/iuCffXGElKEzd+Xe
         e7A0D7Z5n9t14OUYqi1pzF5+emu/ZEYQTQzRKUxXw1rXBWQHe27mCs1y5VT0KMv8bf
         LEGwerBhQAqiIPJcPoKUcT2Sw/CSMdFEtWxGT5VdJpedsNfn+EWmi5kMdZ8k2JiIeA
         YTbWPZSqioZ8acuu2QBqdLaGWKZJ8lxg6WFi4VgAtWDr2G8etcEsKGZEGhYZbmB78y
         13sg3o3cXbMjmzq0CqDQiiWfMWj9JIfyC2A1k7LU3z0n1XHBEGFIxwPTiawxOq+WMJ
         VOMXiRbpRVvMA==
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id D6225A0080;
        Mon,  8 Nov 2021 07:56:33 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2173.outbound.protection.outlook.com [104.47.58.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id BD8C140137;
        Mon,  8 Nov 2021 07:56:32 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=hminas@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="Py5E37uH";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KIGjNAUCaN3Vf1h9MUpyU7/j8dVVDogUkSMQBDnqyEDSfkrW+jI1vuFpDSHBbTHARNDxd6N6609dA4lRp5nUZEf2UN/7Xhl5De1DDTsMWLn2ZYu2+14g+8jyHULKmBVyfPWTJe6x0pZez6/7BgTQ6ka+pLy7y+ZsIgFTpbL4lfSOO+DOlMrtGDiKjxONHjsyz+Mp+WyWJO5MrXgwWZZl1OSeNpMRR85E21xBqWTQWQS1uH52zWIk2WUiEDG4gRxpI+4GUCOVRpNy4+n5JYZgCy6K5xhul9ulI3JpyfzRkdIPsI3vmxLHmaXf8wa+5GhAYVZKRZgO1D03qj+FWfhTjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vXueZ2rVc5sjwG82hvvAjHes2P7usEVAX75blqWahkE=;
 b=J32vcLjqB2bvpRw9wPCgxGbmGhYCMDvY5J+fSRulQ91NeGgiI24e4T9fdz39DvN6fhm168V4R0yjITVQ5k4VBkgV2LPtkyECo5SrvGO/cbOE6ywpwcEaxsQflff8/N/iNQWeAOakksY+U8QA8j2C24dlQG/grH+A51cgTHY8+OKKDca3LRiDJOR2AFfS3vifefG6rVdefNEJcPTfcY+fntPwGebuJrVKujp5snUmKXZC7zlz0SBtScW4rN7RhFrINLpaWkMWo+mUUDilro/C/DTORdGv/O/O/U3cIDHuh6JX0dWKBXPwuHLNn5sYoj3tJvZW14KV6VKvNTJzGIJo1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vXueZ2rVc5sjwG82hvvAjHes2P7usEVAX75blqWahkE=;
 b=Py5E37uHt0l81evyV/L5C4bqiDLnBUtwvBs06weBalJhlBBJsewc0JEnKjW6Vj5518FZZjnwV2hvfbaGKNV5+ocudq+qwHc9utT66puNIHo/txXAqsHYyR6gqHGVbQ60ixJZOTGrPrCDs7xB6iTTegEt+npBFodqFM1GeG4FuFA=
Received: from DM4PR12MB5390.namprd12.prod.outlook.com (2603:10b6:5:39a::12)
 by DM4PR12MB5150.namprd12.prod.outlook.com (2603:10b6:5:391::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.13; Mon, 8 Nov
 2021 07:56:30 +0000
Received: from DM4PR12MB5390.namprd12.prod.outlook.com
 ([fe80::a0da:c3e5:4562:cea9]) by DM4PR12MB5390.namprd12.prod.outlook.com
 ([fe80::a0da:c3e5:4562:cea9%6]) with mapi id 15.20.4669.015; Mon, 8 Nov 2021
 07:56:30 +0000
X-SNPS-Relay: synopsys.com
From:   Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
To:     John Keeping <john@metanate.com>,
        Nathan Chancellor <nathan@kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>
Subject: Re: [PATCH v2] usb: dwc2: hcd_queue: Fix use of floating point
 literal
Thread-Topic: [PATCH v2] usb: dwc2: hcd_queue: Fix use of floating point
 literal
Thread-Index: AQHX0lYR5tkGu0XaEUWuWRcEBdvKOqv1C0CAgAQ8WwA=
Date:   Mon, 8 Nov 2021 07:56:30 +0000
Message-ID: <6f53980b-cdd9-983e-5278-bdb6f7931ed5@synopsys.com>
References: <20211105145802.2520658-1-nathan@kernel.org>
 <YYVKj/+4snhK6/vs@donbot>
In-Reply-To: <YYVKj/+4snhK6/vs@donbot>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
authentication-results: metanate.com; dkim=none (message not signed)
 header.d=none;metanate.com; dmarc=none action=none header.from=synopsys.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ebb0e312-a254-4f67-15f2-08d9a28d4685
x-ms-traffictypediagnostic: DM4PR12MB5150:
x-microsoft-antispam-prvs: <DM4PR12MB5150900963C1734DF385C75DA7919@DM4PR12MB5150.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2331;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yvnj9lhXu0xolP1Q74cdpH8gW3BS4WVEeZXwdbf5CuvgJ5Yg7BjaPIW6YPNpTygN2edkkZ5iaHfEr5gukMdp6j7kWiO7Cpd5h26ly2bvrRk0Eg85XFhGB2rIoZqM5SMrz3W8mCx/OJPwQKMd2IYKxbLyZk1xC0SBlU2lC8XyecbaHfACHQ083vGEFYn+pYFz5yS/E4pIpgPcbTfIGH4W5GZwtuM9MzRcBBmta/HOReUn3sjHEjJN1Bpglo0KCQ8j1HQRsleyrERRZh0b6Vkbxv/VdkOWu1wYWqulnPfIQm165EEC0FfRqisOe6ct2bIzXBYdmyqwELmJGem+MzmiShdszgBspEYTnJabPVywGEvPvZHbX+hFxuUBPbWKDmCHJnIN0cHQffL8v1T4pN1fs1yhBlri5tS35CzK5YgSU4se9HYg/7jdJOu1h4kyaYjgSyDs3I/U/Ulp3ya98bftlHeRzq8hkCXCrev1DEQnGECTVNRd5B3iMkuXkbTGEeAD/YL1V9oGDuvkzqUMateDQ/IcsJZjwfNeYHpsiqDIwxiltxEzH28UVciIGkq2s5RQoCTXhWfpd0GR6bYisqW8m/Te4Uzk1CeUqiHJt+a9DDovHefS9QOnhJLNsev8HsjxJDSYR/puyS9j83JmBzd8I+ylJtZc7qjIeWN9NHM4P1pyYHr/YrSkp13JW2H3ZTgFToKsj1QJl/rIK8BxuoXCOYg+DbrqUb5MftndgTYa4h6juSIYRBWMXYoXi8bJOMhTLv0rYBCdFhhL/ComdV6d2V0MmIV4j5BYuCAHF+AqcPw5uvldXaLFZvAm5p/GCwr+bLixYws0egAm3l4kE5UID2g+1w1OMv8B6F8Uar+nv0TZgKat4UWiqn0GjzfFQZwe9P6AKQfhZyNR0x3XidMhxw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(122000001)(26005)(91956017)(186003)(8676002)(31686004)(76116006)(6506007)(64756008)(38100700002)(53546011)(66556008)(36756003)(66446008)(8936002)(66476007)(83380400001)(966005)(31696002)(66946007)(38070700005)(71200400001)(508600001)(110136005)(5660300002)(6486002)(316002)(54906003)(4326008)(2906002)(86362001)(2616005)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bVhkWmdaRHhEOE1sY1BKRHdNYnB2MFRwTThqY01yb1h2ZmtjS2VHSE9KYzV3?=
 =?utf-8?B?c25FVGpOUjVneEVxWVZ4cTJaUHdEQUZXb2lWOHBUTHZWR0k3aVJTSTRXQ1ZO?=
 =?utf-8?B?ejlBTlFWNVVxYnlIdExQUUkydTlTQ1RTQmsvM2hDM2V6dU84VVhGWVN1MUpK?=
 =?utf-8?B?bHJmY2hJSFZ5VDdnYW5pV1psWm1BQ3NtdTRzR1d1S1d4QnZVclNmOHdVWXdx?=
 =?utf-8?B?eW0wQWhwU3R0STNUSDZTQ2lsWGxpRUpXSTc4T3dsSTd3Q3VUVE9OV3dJSm1r?=
 =?utf-8?B?bHpyQ29sb0xZN3Q3WWEwa0h0aDlzMVJMdkU1S1pPSzNyQ3l3SVM1ZmFLRWl3?=
 =?utf-8?B?UUtVd3lQTCtMcDZyblJhTGtOb2tpWGlQMFA4Q3ZUT09JU1ZmT0F1dkhsWGJL?=
 =?utf-8?B?WHF5THM2MEVUa3BEWjMyNE00cC82RGJhcDlWdURlTzVxckFQN3RJa01FdElp?=
 =?utf-8?B?Y3gyL0k2QVhrS2xxVXBDZ3d4bmM5TXp6QWNYZG8vMEFISG9sRHhkRVNZa2FW?=
 =?utf-8?B?VFZzZFFyWkk2UVNZa3dvMmlWNklUb2tpMXl6N2MzbjJwSXFmVTRhd3VZdU94?=
 =?utf-8?B?azVEVEtkdEkxczMzbWNSTkpDcWJzWUZoSUdLN3kzbE9JVlVvVUlCcXhEQ0dh?=
 =?utf-8?B?SkdCaEk1L3VhSDNHTUdqUUZyK1dEbURJT2lOTTdrM2tTZFNKTjlqMjBUOXFM?=
 =?utf-8?B?UFNIdy82V3A0WmU2WEJiQWdtTTMvRjU5VVdBYXFEZlpVemNURGN1SkhHTENV?=
 =?utf-8?B?VDhlNFFSRjJ1RjBhSmJ1d1VrVnlJVmxUbmtTRUxWRHdWcWczRWpLc0tMTVFj?=
 =?utf-8?B?blM4NWtMVk12ZkRkYm45VkdlKy92YkhCZmYrQXVsbkRvV3ljMTQ5Y0xiV2VX?=
 =?utf-8?B?Qzk4QVh6T3pUK3lSQWpyRXpGUXNiMi9HZDZZamdLOVpHQXRnN0N2bURsU1Nj?=
 =?utf-8?B?UEQzVVJuVkVsTzZ0VmRPVVZCeFhYSHdTRmliOElNUHVIM2tRNGlVUDdqUlBt?=
 =?utf-8?B?WWZWTG5FL1VITFloVkJCNE85elN1UTRmRU9ZNnpDdnJmWG0wVlBXYWpsUEhB?=
 =?utf-8?B?UlJhMGVBQUFSQ21kNE0rY3NLTlhJaHRGeHNjOFAxL1N5K2xKNzNYNE9RWXhJ?=
 =?utf-8?B?bWxscXdZZ2VnL1dINncyLzA2VEhDS0JNaWpyRVFNSmdIQWhkaW1iUHpPVVYx?=
 =?utf-8?B?WG9Lb29jQVkyQ1VMckZlOVJEY2dITWFNMkJvU1M2eHdLdG1lMXdvYmlyWDB0?=
 =?utf-8?B?c2kvZ1RreXFncG8zWEM5dzRGenlpYVdkYnhPM3I5cERCZWRHZTZRY3BIdE9S?=
 =?utf-8?B?WUVuSHNUTEFpdFhwcDBkVWc3d3Nlekw1U241WGQ4aUpVNjhQaXFhTWlNZjRr?=
 =?utf-8?B?TlZHUkZ0VExJWXMrVEVIMWxta0NiSnM4YmxYd1RDVFc5WlZnNlFLYzhTWFFN?=
 =?utf-8?B?QUMyblFpdkNncnlOcGR3bDRlU0hoQkRoNnRlckJQUjZZeDJuSWxVUW5GajNL?=
 =?utf-8?B?VGd0QVpsK3I4YkxWdlgxa1U2MzIwQ2Frd0RtbnRTQ2ROd2JBS1JMa3FMZ3pu?=
 =?utf-8?B?c0FJeHlwRDRFdkxQb0lVUHl3c0I3c0FwbmZMUmNxR1cyeE1PemplNkl0Y2VZ?=
 =?utf-8?B?cGd6TW4zQkIvUldOTk5KaitaNThSSGVQRGYzVEs0NE03TUZFOG1QZ3JldjJi?=
 =?utf-8?B?K2tabERWNWNaS3Z5MVNCa3JHSzhIS1dWVjlMMVQ3enY5aEVkdWFNN2UzeENu?=
 =?utf-8?B?Uzk5eDZMMitFOTNCS0Nhb3VOc2pMbzB6eFVFUmZIVlRFVC80dmVJVkkxZC81?=
 =?utf-8?B?Q3RNUGFYcElqejJMNWI0NndseXBIdi9KSVIrSkxXUmhxUVVEbFdkREhjTVFp?=
 =?utf-8?B?dUJPMUczMXlPY21PUjFEa1oyYU8zL0xEY0F2UGpiTWxHUnZidmRLSWV5YTRQ?=
 =?utf-8?B?WHdMMko1bDJYVVZBQjV0dUVadGpoL0Nua2I4Rlg2bDM3WkFCWFdxQk9CWVp6?=
 =?utf-8?B?OTAzaXFqRHZuVHgxZUNNZ01QNTJnUW1aUHhEaXF2OTNBNHRCZmtweS9sblU1?=
 =?utf-8?B?NXdTUmF5UlBOME5nRTlMamxoSGN0dXZOZlNjcTFZclRSQ3NTVGwwNm0vcFE5?=
 =?utf-8?B?Z3R0QWp3SjN5MTI3T3RMZGJaU0Q2b1JPNFBnZjYrbWU0eFNocXpRd3RGUTFH?=
 =?utf-8?B?THc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C737F620C4D1AF44B4E0951259740E1E@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebb0e312-a254-4f67-15f2-08d9a28d4685
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2021 07:56:30.6512
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O5/Rfo9vaKfsn8rpiC/pyvuHn87WXjVM692iGOa/O16Nc4ISictu36CQ5JUZffoENL6AqMEDbL+rQOoAJ5oV+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5150
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTEvNS8yMDIxIDc6MTUgUE0sIEpvaG4gS2VlcGluZyB3cm90ZToNCj4gT24gRnJpLCBOb3Yg
MDUsIDIwMjEgYXQgMDc6NTg6MDNBTSAtMDcwMCwgTmF0aGFuIENoYW5jZWxsb3Igd3JvdGU6DQo+
PiBBIG5ldyBjb21taXQgaW4gTExWTSBjYXVzZXMgYW4gZXJyb3Igb24gdGhlIHVzZSBvZiAnbG9u
ZyBkb3VibGUnIHdoZW4NCj4+ICctbW5vLXg4NycgaXMgdXNlZCwgd2hpY2ggdGhlIGtlcm5lbCBk
b2VzIHRocm91Z2ggYW4gYWxpYXMsDQo+PiAnLW1uby04MDM4NycgKHNlZSB0aGUgTExWTSBjb21t
aXQgYmVsb3cgZm9yIG1vcmUgZGV0YWlscyBhcm91bmQgd2h5IGl0DQo+PiBkb2VzIHRoaXMpLg0K
Pj4NCj4+ICAgZHJpdmVycy91c2IvZHdjMi9oY2RfcXVldWUuYzoxNzQ0OjI1OiBlcnJvcjogZXhw
cmVzc2lvbiByZXF1aXJlcyAgJ2xvbmcgZG91YmxlJyB0eXBlIHN1cHBvcnQsIGJ1dCB0YXJnZXQg
J3g4Nl82NC11bmtub3duLWxpbnV4LWdudScgZG9lcyBub3Qgc3VwcG9ydCBpdA0KPj4gICAgICAg
ICAgICAgICAgICAgICAgICAgICBkZWxheSA9IGt0aW1lX3NldCgwLCBEV0MyX1JFVFJZX1dBSVRf
REVMQVkpOw0KPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IF4NCj4+ICAgZHJpdmVycy91c2IvZHdjMi9oY2RfcXVldWUuYzo2MjozNDogbm90ZTogZXhwYW5k
ZWQgZnJvbSBtYWNybyAnRFdDMl9SRVRSWV9XQUlUX0RFTEFZJw0KPj4gICAjZGVmaW5lIERXQzJf
UkVUUllfV0FJVF9ERUxBWSAoMSAqIDFFNkwpDQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgXg0KPj4gICAxIGVycm9yIGdlbmVyYXRlZC4NCj4+DQo+PiBUaGlzIGhhcHBlbnMg
ZHVlIHRvIHRoZSB1c2Ugb2YgYSAnbG9uZyBkb3VibGUnIGxpdGVyYWwuIFRoZSAnRTYnIHBhcnQg
b2YNCj4+ICcxRTZMJyBjYXVzZXMgdGhlIGxpdGVyYWwgdG8gYmUgYSAnZG91YmxlJyB0aGVuIHRo
ZSAnTCcgc3VmZml4IHByb21vdGVzDQo+PiBpdCB0byAnbG9uZyBkb3VibGUnLg0KPj4NCj4+IFRo
ZXJlIGlzIG5vIHZpc2libGUgcmVhc29uIGZvciBhIGZsb2F0aW5nIHBvaW50IHZhbHVlIGluIHRo
aXMgZHJpdmVyLCBhcw0KPj4gdGhlIHZhbHVlIGlzIG9ubHkgdXNlZCBhcyBhIHBhcmFtZXRlciB0
byBhIGZ1bmN0aW9uIHRoYXQgZXhwZWN0cyBhbg0KPj4gaW50ZWdlciB0eXBlLiBVc2UgTlNFQ19Q
RVJfTVNFQywgd2hpY2ggaXMgdGhlIHNhbWUgaW50ZWdlciB2YWx1ZSBhcw0KPj4gJzFFNkwnLCB0
byBhdm9pZCBjaGFuZ2luZyBmdW5jdGlvbmFsaXR5IGJ1dCBmaXggdGhlIGVycm9yLg0KPj4NCj4+
IEZpeGVzOiA2ZWQzMGE3ZDhlYzIgKCJ1c2I6IGR3YzI6IGhvc3Q6IHVzZSBocnRpbWVyIGZvciBO
QUsgcmV0cmllcyIpDQo+PiBMaW5rOiBodHRwczovL3VybGRlZmVuc2UuY29tL3YzL19faHR0cHM6
Ly9naXRodWIuY29tL0NsYW5nQnVpbHRMaW51eC9saW51eC9pc3N1ZXMvMTQ5N19fOyEhQTRGMlI5
R19wZyFLdWhXRWpyak9ROENDQmQ4MUlwWjVHeFA3U2tzcF9WRVNiclEyUVREbkxRQk9XTjdFMVly
RDBpSkNuOWZVQVUkDQo+PiBMaW5rOiBodHRwczovL3VybGRlZmVuc2UuY29tL3YzL19faHR0cHM6
Ly9naXRodWIuY29tL2xsdm0vbGx2bS1wcm9qZWN0L2NvbW1pdC9hODA4M2Q0MmIxYzM0NmUyMTYy
M2ExZDM2ZDFmMGNhZGQ3ODAxZDgzX187ISFBNEYyUjlHX3BnIUt1aFdFanJqT1E4Q0NCZDgxSXBa
NUd4UDdTa3NwX1ZFU2JyUTJRVERuTFFCT1dON0UxWXJEMGlKeUs2NlpIYyQNCj4+IFNpZ25lZC1v
ZmYtYnk6IE5hdGhhbiBDaGFuY2VsbG9yIDxuYXRoYW5Aa2VybmVsLm9yZz4NCj4+IFJldmlld2Vk
LWJ5OiBOaWNrIERlc2F1bG5pZXJzIDxuZGVzYXVsbmllcnNAZ29vZ2xlLmNvbT4NCj4gDQo+IFJl
dmlld2VkLWJ5OiBKb2huIEtlZXBpbmcgPGpvaG5AbWV0YW5hdGUuY29tPg0KDQpBY2tlZC1ieTog
TWluYXMgSGFydXR5dW55YW4gPE1pbmFzLkhhcnV0eXVueWFuQHN5bm9wc3lzLmNvbT4NCg0KPiAN
Cj4+IC0tLQ0KPj4NCj4+IHYxIC0+IHYyOiBodHRwczovL3VybGRlZmVuc2UuY29tL3YzL19faHR0
cHM6Ly9sb3JlLmtlcm5lbC5vcmcvci8yMDIxMTEwNDIxNTkyMy43MTk3ODUtMS1uYXRoYW5Aa2Vy
bmVsLm9yZy9fXzshIUE0RjJSOUdfcGchS3VoV0VqcmpPUThDQ0JkODFJcFo1R3hQN1Nrc3BfVkVT
YnJRMlFURG5MUUJPV043RTFZckQwaUp3d1pndEk4JA0KPj4NCj4+ICogVXNlIE5TRUNfUEVSX01T
RUMgaW5zdGVhZCBvZiBVU0VDX1BFUl9TRUMsIGFzIHRoZSB1bml0cyBvZiB0aGUgc2Vjb25kDQo+
PiAgICBwYXJhbWV0ZXIgb2Yga3RpbWVfc2V0IGlzIG5hbm9zZWNvbmRzLiBUaGFua3MgdG8gSm9o
biBLZWVwaW5nIGZvcg0KPj4gICAgcG9pbnRpbmcgdGhpcyBvdXQuDQo+Pg0KPj4gKiBQaWNrIHVw
IE5pY2sncyByZXZpZXcgdGFnLg0KPj4NCj4+ICAgZHJpdmVycy91c2IvZHdjMi9oY2RfcXVldWUu
YyB8IDIgKy0NCj4+ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9u
KC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2R3YzIvaGNkX3F1ZXVlLmMgYi9k
cml2ZXJzL3VzYi9kd2MyL2hjZF9xdWV1ZS5jDQo+PiBpbmRleCA4OWE3ODgzMjZjNTYuLjI0YmVm
ZjYxMGNmMiAxMDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMvdXNiL2R3YzIvaGNkX3F1ZXVlLmMNCj4+
ICsrKyBiL2RyaXZlcnMvdXNiL2R3YzIvaGNkX3F1ZXVlLmMNCj4+IEBAIC01OSw3ICs1OSw3IEBA
DQo+PiAgICNkZWZpbmUgRFdDMl9VTlJFU0VSVkVfREVMQVkgKG1zZWNzX3RvX2ppZmZpZXMoNSkp
DQo+PiAgIA0KPj4gICAvKiBJZiB3ZSBnZXQgYSBOQUssIHdhaXQgdGhpcyBsb25nIGJlZm9yZSBy
ZXRyeWluZyAqLw0KPj4gLSNkZWZpbmUgRFdDMl9SRVRSWV9XQUlUX0RFTEFZICgxICogMUU2TCkN
Cj4+ICsjZGVmaW5lIERXQzJfUkVUUllfV0FJVF9ERUxBWSAoMSAqIE5TRUNfUEVSX01TRUMpDQo+
PiAgIA0KPj4gICAvKioNCj4+ICAgICogZHdjMl9wZXJpb2RpY19jaGFubmVsX2F2YWlsYWJsZSgp
IC0gQ2hlY2tzIHRoYXQgYSBjaGFubmVsIGlzIGF2YWlsYWJsZSBmb3IgYQ0KPj4NCj4+IGJhc2Ut
Y29tbWl0OiBkNDQzOWExMTg5ZjkzZDBhYzFlYWYwMTk3ZGI4ZTZiM2UxOTdkNWM3DQo+PiAtLSAN
Cj4+IDIuMzQuMC5yYzANCj4+DQoNCg==
