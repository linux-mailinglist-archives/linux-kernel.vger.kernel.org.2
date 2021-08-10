Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C89823E869F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 01:40:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235538AbhHJXkc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 19:40:32 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:59688 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235493AbhHJXka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 19:40:30 -0400
Received: from mailhost.synopsys.com (badc-mailhost4.synopsys.com [10.192.0.82])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 3E50041282;
        Tue, 10 Aug 2021 23:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1628638808; bh=GEDMsW0Mb4OTJL4B/U45oYmj244jLOdAF4K52WzBulE=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=e1bIvTaNqmGU+fKzgx5oRhziq3o8+bawx0Ogfcjind5mPfjAE2cBKNgbmiFBgLBGV
         bk572qduHH3ZnviKbu3yaP+SRPUbHZ/LPRwErC2jQAljbIcu3Ktl/DvTfzL2Ux2izc
         vJ01noG+Sem4RV+wNROLyjjX5KqhmCqNzqNlE1n5Zl5kA40qEDpNC647Vk9xEVhFo9
         EqvVgHH0KLQ8iFrWCEN5OJUZk7vK3rcOnH4n+AuANEmzPwBJll14NA66oKPdtQTFUb
         FtqbFOII90zPMged3RBYiBgQEFXT92c25xQMt36alq7Sl+5ICTyuIy9WgSg5LEJ8kh
         umQm7wmzVDRRQ==
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 79D17A006E;
        Tue, 10 Aug 2021 23:40:06 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 6E8EC400D8;
        Tue, 10 Aug 2021 23:40:05 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="NW3F/z7y";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l8U6PUcY11vRevNshjVQDBY28Kzl8pKhC3AItKaYtTlZH+MsnyBxUhYtEPoXX8HxT33Le6pd0QGB1VbV+K6Sk8VEcx29aKSSvtjdj3jQbiyEG2ofYgCqhRbZbnHGNhJQO9Hw3a5YPdJmQl+TNthw4F3uDAOyeQdQWzx/2Q+dovXw+aPkzwT95BWXP84K8OhIjf2wK0KAT33NoKPAk+lgiDrcx+MV2vckJCdDt2deUd7U8lHwwCr8UGk473HgAkGmTyk361x8s3Tqs9j4b4i2qLy90LQS8ZqIcgX5aTpU1LMZixf/4UCGZw0ZKBtQQfbaVEqjDEkkVhdA5mNCUQ1O9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GEDMsW0Mb4OTJL4B/U45oYmj244jLOdAF4K52WzBulE=;
 b=Ew+Uh46EnRBNUWXC21uPJ3vI7tfKtJgQ6uyBRziIVkVeJszAflZc/6lrz/z+6B3AWbvxt7kdc37y8TmsFED6wzFxgO51c0ZD3xTiIN5ODaZPki09wXlkzUfjMt99F/WLYS0sqdTiz5OEJH57q7ToRPGN49cyG3AGEH2Z3NxTwI08Ys3t3eq+54hBpkYkuPD3fyO59sB+mQoC0TdPhM/fx6ovPnX5WgIw/N9+1GFhWQknxLakzktbUlhzwuvMKfj5iYRvBA4lr949qPlAXqaxEP9bxPvMy0gnJjBcqeEQHXoqj2WLb47vcGjicXwtJ9uJ2BpF6fqCZsDGs4+ndwG9vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GEDMsW0Mb4OTJL4B/U45oYmj244jLOdAF4K52WzBulE=;
 b=NW3F/z7yf0wpWX9LxQ7tuDTdaq144RcyO4iOId6rohv92WpAL4CYftMB3+DEhix4SmOT27m7Om6f3jbsKINdrFnUjN9ITcARy/eVxWJxKRzSovcRDBJ2rnCcqycGuLjtq4ik2FFFnQG+WAiqJgImjjfoKJI2np2JtS4NEfigxEE=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by BYAPR12MB2904.namprd12.prod.outlook.com (2603:10b6:a03:137::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.21; Tue, 10 Aug
 2021 23:40:03 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::163:f142:621e:3db9]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::163:f142:621e:3db9%7]) with mapi id 15.20.4415.014; Tue, 10 Aug 2021
 23:40:03 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Wesley Cheng <wcheng@codeaurora.org>,
        John Stultz <john.stultz@linaro.org>
CC:     lkml <linux-kernel@vger.kernel.org>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Jack Pham <jackp@codeaurora.org>, Todd Kjos <tkjos@google.com>,
        Amit Pundir <amit.pundir@linaro.org>,
        YongQin Liu <yongqin.liu@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Petri Gynther <pgynther@google.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Subject: Re: [RFC][PATCH] dwc3: gadget: Fix losing list items in
 dwc3_gadget_ep_cleanup_completed_requests()
Thread-Topic: [RFC][PATCH] dwc3: gadget: Fix losing list items in
 dwc3_gadget_ep_cleanup_completed_requests()
Thread-Index: AQHXjW5ko6qYUR8aokekS5eRbPy7oKtrxUWAgAACvICAAAD6AIABMcaAgAAy+YCAAADCAIAAOLoA
Date:   Tue, 10 Aug 2021 23:40:02 +0000
Message-ID: <89bb9ef4-f85e-5ccf-9288-780efec72f5c@synopsys.com>
References: <CANcMJZCEVxVLyFgLwK98hqBEdc0_n4P0x_K6Gih8zNH3ouzbJQ@mail.gmail.com>
 <20210809223159.2342385-1-john.stultz@linaro.org>
 <4e1bef57-8520-36b9-f5cb-bbc925626a19@synopsys.com>
 <CALAqxLXPGt69ceiXkGT-nDjeP72mmCUgEzDdMpXr=rSNwpespw@mail.gmail.com>
 <0dfa8cd6-99b6-55c7-8099-0f6f1187b7fd@synopsys.com>
 <b025412f-c27a-a59b-cd8f-aec0faa98928@codeaurora.org>
 <a2139dcd-2512-2138-66b4-311056d92afa@synopsys.com>
 <915337ae-07d4-6a19-ec98-a8b88c5d9743@synopsys.com>
In-Reply-To: <915337ae-07d4-6a19-ec98-a8b88c5d9743@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
authentication-results: synopsys.com; dkim=none (message not signed)
 header.d=none;synopsys.com; dmarc=none action=none header.from=synopsys.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ff733032-8d85-43b3-57f0-08d95c582cf2
x-ms-traffictypediagnostic: BYAPR12MB2904:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB29047BF6513FA71F3D79EAD3AAF79@BYAPR12MB2904.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mVQfKr1naddWh9OLrlQQdm7bfrXTmef+vaTpQFIsJwZwx+kI/tNhmu5rAkrHi0FYlv6utZljRqk0uktYIY6qrYSScyNNz6OVZjNYlTG+pVR6U8TobFy7Bepbxow0NlQRnQdnq6aXb3ruxZtZk+Dlzzu0wXrHKHTEhWZtqVQlo4K7fW1Q9/SLU8kcZpRuEaducKKIDRgWdB3w0L0V0bf9++MRe5uVLboZHFZ4jBq76K/j2oUrWJIv5mursU3P0l2aK1xoYpAXyrGSq4qO+zXv9B8IbeA5giu5qeI5CONbz3TDn7ya94jZWGJqp+wXudmVZaA2UHWTl2SN5O6uPtV/luU6ZnjmjXwLbhJUfRsHvS0SM41smhMiliaMG2f6qg5idi7GwqAw4Xy4ERz3t3/EjWv3D6lhUKNYNy/TWQ/ombRT3BSIBe0K3gA1BIM4SC5e6PoZEup1kkXdPBXqINc3q3pWnZQhIC4tiUT6Vwl/cFKYf7nWFof/reuhBOTQtr+/hTkzfD2qYtwtX37lPWBY/dvGnoDhlvHhDIDHehLiwTIQBanHzrcxTpAyILq9pkAomahwYwRzoJ0oSB7n5W1W8UCNevZEEN7fU67ctz5+YsayNYDp2JrMkHiqwCV7AFCTJRa0zjzDvpnspdvMFQST8bSCVpjLQFIyXRNiBJpth5FlXHkv4VMnLoCtZvFmYoZxDkkjunxqy1/iSBROlu6HkeXGLnUys4bqrnYh/QlCmGdJnc6Wrzv4HY5MlVapPi5cJsAyEotYwIxmI/voOBhoT9ZtaHtAypAHh+OJizGZiF14YzFOh+Jq7RspWaibRCwyPmxkUcJx5EPkDMQyzsfNwIs7PKo580PPjUk1qTIllV4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(31696002)(4326008)(83380400001)(966005)(6486002)(316002)(64756008)(66556008)(66446008)(86362001)(66476007)(8936002)(122000001)(110136005)(31686004)(36756003)(38070700005)(6512007)(38100700002)(8676002)(2906002)(508600001)(54906003)(66946007)(76116006)(71200400001)(6506007)(5660300002)(7416002)(26005)(53546011)(2616005)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WDdNeWpqUEhZeDAxczE1YjBYdlNYV1NZRnlKd01iYVRRZVpxa1VEMitVV1Vk?=
 =?utf-8?B?bzZMMmU3R1l1NDRLdEFyekh0bFZVekUvM24zRE9zcWNUMWVTdnRSR1hEUTcy?=
 =?utf-8?B?SmdqcVhhV2ZnWlRWYk16aVRGbTBEck53RG1sNHVwTWpWa2pvK0NUSDh4OXp5?=
 =?utf-8?B?MXRaYXNGbTFrc2R5S00rdHJyMnZDY21hSldjQm44QWxiaS9OWHhtZ00zeFc4?=
 =?utf-8?B?QjNHZ25oc2VWZG1jWktUY2luamVidGhqVUpYODJWQ2Y5YkVyeG9ZK25zY3lk?=
 =?utf-8?B?QS9Eb2t4WUppQW9tMDJuNVZHYmh2MWxOMFg5aXh0WTdrd3VwY3hkUVRFRStQ?=
 =?utf-8?B?UUNVNWZuTytlRTdmMmgwVGI1QUYwczRxTVRJNDhrT2EvSERWbG9tU1RaMFFT?=
 =?utf-8?B?Zzgwd29pZEM2RTc2UGVocjVCSm9RSElTL0I5OWJEZWM1Ym54NmVZNmpLTjRZ?=
 =?utf-8?B?TktIZHI4azkyS2I4UWRWNWtVY2YxUDkxVzN2UFhKZlhJWURUYXBNYjVuTkg0?=
 =?utf-8?B?c3JhSGxNMG1oVnVaVGFaNFcrQmZIdWttQ2dwQkUxNzFmMnZROHcyOEFoc1RX?=
 =?utf-8?B?cHBpS3dxVCtkSytQckI4QlppT0U0bnFnNlVHTTc3VnNPMGdnVUt4RXcwMVdM?=
 =?utf-8?B?aG9wWm9uRXVmMTB6S3lkeXUzc3VpTldhd1BYSngzM2VITXRUdFhRQjdkNGZE?=
 =?utf-8?B?RFNuayt1bk5TYnIzYWczZmh3WEdOM2xWWUpxSW5YdjBkc2sxTTg2UWdYTlls?=
 =?utf-8?B?eUd1TDVla1U0MEZ5bTdqMVJJVDY4MU41eVB5OGVmSmo3dFFoWkhGMkNwSkJB?=
 =?utf-8?B?RkwrZ21oQzQ3N2pEd1haendzaDQrSGxsOEFqK0Z4bW1KcFVadEZWZEFIU1dX?=
 =?utf-8?B?bkdsVWZuVXI1dEU3cFprSjVjWkVRbjIzZGliUmk1dklCb0NYVUdHQUY2VTYw?=
 =?utf-8?B?L3BtUEtDdURieWJUUTlJbWt6ZHpMQ3VnN25OcTZaNjZaVUptS1ZwUkkzNlA3?=
 =?utf-8?B?ajgxdWlQU21peFJnN0dISjdSdENMM3RGRmgwTTh5MGFYbXBMcnAxVXRmZ2Fy?=
 =?utf-8?B?dHhsRTI4aXc4SGR0VlF0dGdnR2ZWMkxURUFDYURuVEVUS3lNcFNrNjg3MUhh?=
 =?utf-8?B?L0N3ZVBmQWxRdU5PQ2lHRGVBdXFFejhhQUFIM3dHQ0ZvV0d6ZmRlM2NjSUJH?=
 =?utf-8?B?Sjl4eUFWTmhaMTZSRGVoRzY1dDhEcDd4VDJrVGxxU0xZQVU5ZGQ4ZnFZRC9E?=
 =?utf-8?B?NDFDUy85RjNFNG9pYm5GQXh5ck1jV0taNGtDeUxuM01xWjBvTW54UGt2RXlz?=
 =?utf-8?B?TEU2cTRPV2IvM0k2ZXJCKzBhMEpHZmk3dnc1NXF0czlGTlg2NS9NUUovU2sw?=
 =?utf-8?B?MzB1MmNGQmlWbFI3S2dnWWtjd0xxZFVYMW1XOEh2MFFjU0RiZW1UVSs4UXQ0?=
 =?utf-8?B?bitmQnk2NUpySjkrcDI1Z1h5ZWZVYWxpWUswSWp6OUVPQjhmdWVGeGQ4THBo?=
 =?utf-8?B?eVRZZHFRc01CazdheXJrdENrSUFqcDQrbTNlT2NlaHY0cjRhRVdrYmV1ZzNR?=
 =?utf-8?B?dGdXY1lOTWk4VnBrR0lnbXpXTnluUytKem1qYkR2N2RXeEVCK2JkOUQ4WFdv?=
 =?utf-8?B?TEcweFpZd0NIZXl4WUsvSjRMbitPU3VLSmFYWndpTXVmQjMzRytIYVlKKzNh?=
 =?utf-8?B?aE5JNnF2Z1Q1aEdDem5JZTRHMWpXWkp0ZXh6OEd2Zzc1aXRUbTJhd3owWk9H?=
 =?utf-8?Q?DKfAKBaCM/kyEw9pl8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <402E3627C380AC4A93347D306EAABAF5@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff733032-8d85-43b3-57f0-08d95c582cf2
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2021 23:40:02.9253
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PtVSwUFbVEasqDouGQX/we6SgRqIwRQ0K8D6j1sPPO4o6sMcWtElCOA9S/HM+oLV2VbPNVsoSNnbA22XCKamYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2904
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgV2VzbGV5LA0KDQpUaGluaCBOZ3V5ZW4gd3JvdGU6DQo+IFRoaW5oIE5ndXllbiB3cm90ZToN
Cj4+IFdlc2xleSBDaGVuZyB3cm90ZToNCj4+PiBIaSBUaGluaCwNCj4+Pg0KPj4+IE9uIDgvOS8y
MDIxIDM6NTcgUE0sIFRoaW5oIE5ndXllbiB3cm90ZToNCj4+Pj4gSm9obiBTdHVsdHogd3JvdGU6
DQo+Pj4+PiBPbiBNb24sIEF1ZyA5LCAyMDIxIGF0IDM6NDQgUE0gVGhpbmggTmd1eWVuIDxUaGlu
aC5OZ3V5ZW5Ac3lub3BzeXMuY29tPiB3cm90ZToNCj4+Pj4+Pg0KPj4+Pj4+IEpvaG4gU3R1bHR6
IHdyb3RlOg0KPj4+Pj4+PiBJbiBjb21taXQgZDI1ZDg1MDYxYmQ4ICgidXNiOiBkd2MzOiBnYWRn
ZXQ6IFVzZQ0KPj4+Pj4+PiBsaXN0X3JlcGxhY2VfaW5pdCgpIGJlZm9yZSB0cmF2ZXJzaW5nIGxp
c3RzIiksIGEgbG9jYWwgbGlzdF9oZWFkDQo+Pj4+Pj4+IHdhcyBpbnRyb2R1Y2VkIHRvIHByb2Nl
c3MgdGhlIHN0YXJ0ZWRfbGlzdCBpdGVtcyB0byBhdm9pZCByYWNlcy4NCj4+Pj4+Pj4NCj4+Pj4+
Pj4gSG93ZXZlciwgaW4gZHdjM19nYWRnZXRfZXBfY2xlYW51cF9jb21wbGV0ZWRfcmVxdWVzdHMo
KSBpZg0KPj4+Pj4+PiBkd2MzX2dhZGdldF9lcF9jbGVhbnVwX2NvbXBsZXRlZF9yZXF1ZXN0KCkg
ZmFpbHMsIHdlIGJyZWFrIGVhcmx5LA0KPj4+Pj4+PiBjYXVzaW5nIHRoZSBpdGVtcyBvbiB0aGUg
bG9jYWwgbGlzdF9oZWFkIHRvIGJlIGxvc3QuDQo+Pj4+Pj4+DQo+Pj4+Pj4+IFRoaXMgaXNzdWUg
c2hvd2VkIHVwIGFzIHByb2JsZW1zIG9uIHRoZSBkYjg0NWMvUkIzIGJvYXJkLCB3aGVyZQ0KPj4+
Pj4+PiBhZGIgY29ubmV0aW9ucyB3b3VsZCBmYWlsLCBzaG93aW5nIHRoZSBkZXZpY2UgYXMgIm9m
ZmxpbmUiLg0KPj4+Pj4+Pg0KPj4+Pj4+PiBUaGlzIHBhdGNoIHRyaWVzIHRvIGZpeCB0aGUgaXNz
dWUgYnkgaWYgd2UgYXJlIHJldHVybmluZyBlYXJseQ0KPj4+Pj4+PiB3ZSBzcGxpY2UgaW4gdGhl
IGxvY2FsIGxpc3QgaGVhZCBiYWNrIGludG8gdGhlIHN0YXJ0ZWRfbGlzdA0KPj4+Pj4+PiBhbmQg
cmV0dXJuIChhdm9pZGluZyBhbiBpbmZpbml0ZSBsb29wLCBhcyB0aGUgc3RhcnRlZF9saXN0IGlz
DQo+Pj4+Pj4+IG5vdyBub24tbnVsbCkuDQo+Pj4+Pj4+DQo+Pj4+Pj4+IE5vdCBzdXJlIGlmIHRo
aXMgaXMgZnVsbHkgY29ycmVjdCwgYnV0IHNlZW1zIHRvIHdvcmsgZm9yIG1lIHNvIEkNCj4+Pj4+
Pj4gd2FudGVkIHRvIHNoYXJlIGZvciBmZWVkYmFjay4NCj4+Pj4+Pj4NCj4+Pj4+Pj4gQ2M6IFdl
c2xleSBDaGVuZyA8d2NoZW5nQGNvZGVhdXJvcmEub3JnPg0KPj4+Pj4+PiBDYzogRmVsaXBlIEJh
bGJpIDxiYWxiaUBrZXJuZWwub3JnPg0KPj4+Pj4+PiBDYzogR3JlZyBLcm9haC1IYXJ0bWFuIDxn
cmVna2hAbGludXhmb3VuZGF0aW9uLm9yZz4NCj4+Pj4+Pj4gQ2M6IEFsYW4gU3Rlcm4gPHN0ZXJu
QHJvd2xhbmQuaGFydmFyZC5lZHU+DQo+Pj4+Pj4+IENjOiBKYWNrIFBoYW0gPGphY2twQGNvZGVh
dXJvcmEub3JnPg0KPj4+Pj4+PiBDYzogVGhpbmggTmd1eWVuIDx0aGluaC5uZ3V5ZW5Ac3lub3Bz
eXMuY29tPg0KPj4+Pj4+PiBDYzogVG9kZCBLam9zIDx0a2pvc0Bnb29nbGUuY29tPg0KPj4+Pj4+
PiBDYzogQW1pdCBQdW5kaXIgPGFtaXQucHVuZGlyQGxpbmFyby5vcmc+DQo+Pj4+Pj4+IENjOiBZ
b25nUWluIExpdSA8eW9uZ3Fpbi5saXVAbGluYXJvLm9yZz4NCj4+Pj4+Pj4gQ2M6IFN1bWl0IFNl
bXdhbCA8c3VtaXQuc2Vtd2FsQGxpbmFyby5vcmc+DQo+Pj4+Pj4+IENjOiBQZXRyaSBHeW50aGVy
IDxwZ3ludGhlckBnb29nbGUuY29tPg0KPj4+Pj4+PiBDYzogbGludXgtdXNiQHZnZXIua2VybmVs
Lm9yZw0KPj4+Pj4+PiBGaXhlczogZDI1ZDg1MDYxYmQ4ICgidXNiOiBkd2MzOiBnYWRnZXQ6IFVz
ZSBsaXN0X3JlcGxhY2VfaW5pdCgpIGJlZm9yZSB0cmF2ZXJzaW5nIGxpc3RzIikNCj4+Pj4+Pj4g
U2lnbmVkLW9mZi1ieTogSm9obiBTdHVsdHogPGpvaG4uc3R1bHR6QGxpbmFyby5vcmc+DQo+Pj4+
Pj4+IC0tLQ0KPj4+Pj4+PiAgZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYyB8IDYgKysrKysrDQo+
Pj4+Pj4+ICAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspDQo+Pj4+Pj4+DQo+Pj4+Pj4+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jIGIvZHJpdmVycy91c2IvZHdj
My9nYWRnZXQuYw0KPj4+Pj4+PiBpbmRleCBiOGQ0YjJkMzI3YjIzLi5hNzNlYmU4ZTc1MDI0IDEw
MDY0NA0KPj4+Pj4+PiAtLS0gYS9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jDQo+Pj4+Pj4+ICsr
KyBiL2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMNCj4+Pj4+Pj4gQEAgLTI5OTAsNiArMjk5MCwx
MiBAQCBzdGF0aWMgdm9pZCBkd2MzX2dhZGdldF9lcF9jbGVhbnVwX2NvbXBsZXRlZF9yZXF1ZXN0
cyhzdHJ1Y3QgZHdjM19lcCAqZGVwLA0KPj4+Pj4+PiAgICAgICAgICAgICAgICAgICAgICAgYnJl
YWs7DQo+Pj4+Pj4+ICAgICAgIH0NCj4+Pj4+Pj4NCj4+Pj4+Pj4gKyAgICAgaWYgKCFsaXN0X2Vt
cHR5KCZsb2NhbCkpIHsNCj4+Pj4+Pj4gKyAgICAgICAgICAgICBsaXN0X3NwbGljZV90YWlsKCZs
b2NhbCwgJmRlcC0+c3RhcnRlZF9saXN0KTsNCj4+Pj4+Pj4gKyAgICAgICAgICAgICAvKiBSZXR1
cm4gc28gd2UgZG9uJ3QgaGl0IHRoZSByZXN0YXJ0IGNhc2UgYW5kIGxvb3AgZm9yZXZlciAqLw0K
Pj4+Pj4+PiArICAgICAgICAgICAgIHJldHVybjsNCj4+Pj4+Pj4gKyAgICAgfQ0KPj4+Pj4+PiAr
DQo+Pj4+Pj4+ICAgICAgIGlmICghbGlzdF9lbXB0eSgmZGVwLT5zdGFydGVkX2xpc3QpKQ0KPj4+
Pj4+PiAgICAgICAgICAgICAgIGdvdG8gcmVzdGFydDsNCj4+Pj4+Pj4gIH0NCj4+Pj4+Pj4NCj4+
Pj4+Pg0KPj4+Pj4+IE5vLCB3ZSBzaG91bGQgcmV2ZXJ0IHRoZSBjaGFuZ2UgZm9yDQo+Pj4+Pj4g
ZHdjM19nYWRnZXRfZXBfY2xlYXVwX2NvbXBsZXRlZF9yZXF1ZXN0cygpLiBBcyBJIG1lbnRpb25l
ZCBwcmV2aW91c2x5LA0KPj4+Pj4+IHdlIGRvbid0IGNsZWFudXAgdGhlIGVudGlyZSBzdGFydGVk
X2xpc3QuIElmIHRoZSBvcmlnaW5hbCBwcm9ibGVtIGlzIGR1ZQ0KPj4+Pj4+IHRvIGRpc2Nvbm5l
Y3Rpb24gaW4gdGhlIG1pZGRsZSBvZiByZXF1ZXN0IGNvbXBsZXRpb24sIHRoZW4gd2UgY2FuIGp1
c3QNCj4+Pj4+PiBjaGVjayBmb3IgcHVsbHVwX2Nvbm5lY3RlZCBhbmQgZXhpdCB0aGUgbG9vcCBh
bmQgbGV0IHRoZQ0KPj4+Pj4+IGR3YzNfcmVtb3ZlX3JlcXVlc3RzKCkgZG8gdGhlIGNsZWFudXAu
DQo+Pj4+Pg0KPj4+Pj4gT2ssIHNvcnJ5LCBJIGRpZG4ndCByZWFkIHlvdXIgbWFpbCBpbiBkZXB0
aCB1bnRpbCBJIGhhZCB0aGlzIHBhdGNoDQo+Pj4+PiBzZW50IG91dC4gSWYgYSByZXZlcnQgb2Yg
ZDI1ZDg1MDYxYmQ4IGlzIHRoZSBiZXR0ZXIgZml4LCBJJ20gZmluZSB3aXRoDQo+Pj4+PiB0aGF0
IHRvby4NCj4+Pj4+DQo+Pj4+PiB0aGFua3MNCj4+Pj4+IC1qb2huDQo+Pj4+Pg0KPj4+Pg0KPj4+
PiBJTU8sIHdlIHNob3VsZCByZXZlcnQgdGhpcyBwYXRjaCBmb3Igbm93IHNpbmNlIGl0IHdpbGwg
Y2F1c2UgcmVncmVzc2lvbi4NCj4+Pj4gV2UgY2FuIHJldmlldyBhbmQgdGVzdCBhIHByb3BlciBm
aXggYXQgYSBsYXRlciB0aW1lLg0KPj4+Pg0KPj4+PiBUaGFua3MsDQo+Pj4+IFRoaW5oDQo+Pj4+
DQo+Pj4NCj4+PiBBbm90aGVyIHN1Z2dlc3Rpb24gd291bGQganVzdCBiZSB0byByZXBsYWNlIHRo
ZSBsb29wIHdpdGggYSB3aGlsZSgpIGxvb3ANCj4+PiBhbmQgdXNpbmcgbGlzdF9lbnRyeSgpIGlu
c3RlYWQuICBUaGF0IHdhcyB3aGF0IHdhcyBkaXNjdXNzZWQgaW4gdGhlDQo+Pj4gZWFybGllciBw
YXRjaCBzZXJpZXMgd2hpY2ggYWxzbyBhZGRyZXNzZXMgdGhlIHByb2JsZW0gYXMgd2VsbC4gIElz
c3VlDQo+Pj4gaGVyZSBpcyB0aGUgdG1wIHZhcmlhYmxlIHN0aWxsIGNhcnJpZXMgYSBzdGFsZSBy
ZXF1ZXN0IGFmdGVyIHRoZSBkd2MzDQo+Pj4gZ2l2ZWJhY2sgaXMgY2FsbGVkLiAgV2UgY2FuIGF2
b2lkIHRoYXQgYnkgYWx3YXlzIGZldGNoaW5nIHRoZQ0KPj4+IGxpc3RfZW50cnkoKSBpbnN0ZWFk
IG9mIHJlbHlpbmcgb24gbGlzdF9mb3JfZWFjaF9zYWZlKCkNCj4+Pg0KPj4+IGh0dHBzOi8vdXJs
ZGVmZW5zZS5jb20vdjMvX19odHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC11c2IvMTYyMDcx
NjYzNi0xMjQyMi0xLWdpdC1zZW5kLWVtYWlsLXdjaGVuZ0Bjb2RlYXVyb3JhLm9yZy9fXzshIUE0
RjJSOUdfcGchUDBFMXB2M0MwUFN0RGVwS3l5OGlxS2dVYU9oRHkwWkRoWWR6LV9jWnduSlJRak5q
dncwTWRKUUNkVTZYd250M1lBc18kIA0KPj4+DQo+Pg0KPj4gVGhpcyBzaG91bGQgd29yaywgYnV0
IHRoZSBhd2t3YXJkIHRoaW5nIGlzIDIgbG9vcHMgZnJvbSAyIHNlcGFyYXRlDQo+PiB0aHJlYWRz
IGNvbXBldGluZyB0byByZW1vdmUvZ2l2ZWJhY2sgdGhlIHJlcXVlc3RzIGFuZCBtYXkgcmVwb3J0
IG1peCBzdGF0dXMuDQo+Pg0KDQoNCkNhbiB5b3UgdHJ5IHRoaXM/DQoNCmRpZmYgLS1naXQgYS9k
cml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jIGIvZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYw0KaW5k
ZXggNzA2MjQ2ZDkzYTAwLi4xN2IyZDhkNGVmYjQgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL3VzYi9k
d2MzL2dhZGdldC5jDQorKysgYi9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jDQpAQCAtMjAyOSw2
ICsyMDI5LDEzIEBAIHN0YXRpYyB2b2lkIGR3YzNfZ2FkZ2V0X2VwX2NsZWFudXBfY2FuY2VsbGVk
X3JlcXVlc3RzKHN0cnVjdCBkd2MzX2VwICpkZXApDQogICAgICAgICAgICAgICAgICAgICAgICBk
d2MzX2dhZGdldF9naXZlYmFjayhkZXAsIHJlcSwgLUVDT05OUkVTRVQpOw0KICAgICAgICAgICAg
ICAgICAgICAgICAgYnJlYWs7DQogICAgICAgICAgICAgICAgfQ0KKw0KKyAgICAgICAgICAgICAg
IC8qDQorICAgICAgICAgICAgICAgICogVGhlIGVuZHBvaW50IGlzIGRpc2FibGVkLCBsZXQgdGhl
IGR3YzNfcmVtb3ZlX3JlcXVlc3RzKCkNCisgICAgICAgICAgICAgICAgKiBoYW5kbGUgdGhlIGNs
ZWFudXAuDQorICAgICAgICAgICAgICAgICovDQorICAgICAgICAgICAgICAgaWYgKCFkZXAtPmVu
ZHBvaW50LmRlc2MpDQorICAgICAgICAgICAgICAgICAgICAgICBicmVhazsNCiAgICAgICAgfQ0K
IH0NCiANCkBAIC0zNDAyLDYgKzM0MDksMTMgQEAgc3RhdGljIHZvaWQgZHdjM19nYWRnZXRfZXBf
Y2xlYW51cF9jb21wbGV0ZWRfcmVxdWVzdHMoc3RydWN0IGR3YzNfZXAgKmRlcCwNCiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgcmVxLCBzdGF0dXMpOw0KICAgICAgICAgICAgICAgIGlm
IChyZXQpDQogICAgICAgICAgICAgICAgICAgICAgICBicmVhazsNCisNCisgICAgICAgICAgICAg
ICAvKg0KKyAgICAgICAgICAgICAgICAqIFRoZSBlbmRwb2ludCBpcyBkaXNhYmxlZCwgbGV0IHRo
ZSBkd2MzX3JlbW92ZV9yZXF1ZXN0cygpDQorICAgICAgICAgICAgICAgICogaGFuZGxlIHRoZSBj
bGVhbnVwLg0KKyAgICAgICAgICAgICAgICAqLw0KKyAgICAgICAgICAgICAgIGlmICghZGVwLT5l
bmRwb2ludC5kZXNjKQ0KKyAgICAgICAgICAgICAgICAgICAgICAgYnJlYWs7DQogICAgICAgIH0N
CiB9DQoNCklmIG5lZWRlZCwgeW91IGNhbiBhbHNvIHVzZSB5b3VyIGNoYW5nZSB3aGlsZSghbGlz
dF9lbXB0eShzdGFydGVkX2xpc3QpKSBhbG9uZyB3aXRoIHRoaXMgZm9yIGZ1dHVyZSBwcm9vZi4N
Cg0KQlIsDQpUaGluaA0K
