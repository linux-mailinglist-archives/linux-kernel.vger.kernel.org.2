Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36C0C3C7765
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 21:43:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234457AbhGMTqo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 15:46:44 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:34072 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229478AbhGMTqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 15:46:42 -0400
Received: from mailhost.synopsys.com (us03-mailhost2.synopsys.com [10.4.17.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 69ECEC0B5E;
        Tue, 13 Jul 2021 19:43:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1626205432; bh=zREO98CJoThiO+ibqaR6r0RdgXVAqU6H7mA0WNucf28=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=lvFcI4f3yi5IVUAPXAe8Iv0uqk2KXaR1aI2LsfaKMikbARbhJgHUgeUzX5v6MpqOJ
         LcqAukp018InkOwcR6RsaFaSBR0PpmS8uClcHPmIAiu/ocUmYya4kO5s0i8g3wgcv9
         azdKX1ze0eFZLlM26R5fn6lgaBfoL0FmvwcSRxrj8urjXIrMpBbWcVoRdzgPSwqCTH
         2amV557ZA5li0P1kMqJWEibr0FcMHpOYDf4blveiyjOxkZ64V1pxzSKlMPP+bOZ+sL
         iNBstwMvuUK9kLQWAWcyXFJifu6jxpugC0DhZ0aSs9oXHHeBM7LbTBtDmah4+SYTug
         D41mcftFnb8Vw==
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 441E6A0081;
        Tue, 13 Jul 2021 19:43:50 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2042.outbound.protection.outlook.com [104.47.74.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id D6A32400CC;
        Tue, 13 Jul 2021 19:43:48 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=vgupta@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="oIpzrbij";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iLzbqcdfCFcBk2m20SXOyUGla2PegqoKdeSynGPbGJOeLw1mkiYdxY+FCQeI+UrxsY0wny5DeLVaNT4BuJpWF4ZjLvEdpqT1X98eWGlZjluOXqOe1kxK9p6upxu9qQJwrEXkCQml86Gl6b1u2aFuH7Bm9Fe3RBpJca7GAJkB0ajdB70VRuyLjAMKnYaIsi1nJrG5EJiC6NqpL8FrgDqIuvLdtk2GH0fJvXflWAockR6UYhhC1+nVWUDonBWJuYqg3aRFx6hy5jkaLH2wdxyquCsE+uxIl3zHtqPju8XQlT+lajtw+oSm6MRJ6nffW9dQXRRAolH1zpioukcxDQgcOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zREO98CJoThiO+ibqaR6r0RdgXVAqU6H7mA0WNucf28=;
 b=PFc6IYclWVR4k0nybFvA5Ls8JYVuoZQtJKPxIKszW3po3SjeL8dmW3NmSZZ6sig0fwaqjg+ZtVuO2EduG7XoRXp2r48RNbiOChSrTwM5rHG52xs6QrrYVQm/Ner3xytoq6oeMo0xMfGjDsk+14dAYOK4QTdy/0a8QpGJpvqUtkGp/f/xNJ/QLYWkMiNpL96PVqq0GoxrhJFARqrqjfn6kHXYEGlpNldyOQleBAR17uc/DvDcv7KdG4RNSGJ14HZGc+i/mPlMdCFQOhuVR9IEXNrfVEC+1v1dCc5vCSOpCE0S4jOWgyhaHwLhbCYNTh/UfLtrY6nPPY8xNWbXDfOa3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zREO98CJoThiO+ibqaR6r0RdgXVAqU6H7mA0WNucf28=;
 b=oIpzrbijuNyCvA2Gc+Cs3Fz36UOruqZNarz+6/ymK1Jf6S9de3VUZJit8gB+dfZsuV6I4jkSa+Yar3VzBcFrAMUNZFrN7TIvnw2f67ycIIbkjM+Fh42lYI093gZGaadLtMGFjioc/du2bu1JfgzsACWuFCiMJyG0Klnf/Vj6tbM=
Received: from BYAPR12MB3479.namprd12.prod.outlook.com (2603:10b6:a03:dc::26)
 by BY5PR12MB3684.namprd12.prod.outlook.com (2603:10b6:a03:1a2::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.21; Tue, 13 Jul
 2021 19:43:45 +0000
Received: from BYAPR12MB3479.namprd12.prod.outlook.com
 ([fe80::acbd:42ac:9bab:39ee]) by BYAPR12MB3479.namprd12.prod.outlook.com
 ([fe80::acbd:42ac:9bab:39ee%3]) with mapi id 15.20.4308.027; Tue, 13 Jul 2021
 19:43:45 +0000
X-SNPS-Relay: synopsys.com
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     Colin King <colin.king@canonical.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
CC:     "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arc: Fix spelling mistake and grammar in Kconfig
Thread-Topic: [PATCH] arc: Fix spelling mistake and grammar in Kconfig
Thread-Index: AQHXcLb0XIClqFVISU6Z8woP/h1rnqtBXVkA
Date:   Tue, 13 Jul 2021 19:43:45 +0000
Message-ID: <d502f16f-d78c-93d3-e261-bf0122713f72@synopsys.com>
References: <20210704092824.34886-1-colin.king@canonical.com>
In-Reply-To: <20210704092824.34886-1-colin.king@canonical.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
authentication-results: canonical.com; dkim=none (message not signed)
 header.d=none;canonical.com; dmarc=none action=none header.from=synopsys.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 87d7e331-e2ac-4c01-dcb3-08d9463686f5
x-ms-traffictypediagnostic: BY5PR12MB3684:
x-microsoft-antispam-prvs: <BY5PR12MB368470B8C1E6AD5A94BBA264B6149@BY5PR12MB3684.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1265;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ph2E8UWM0pn5xRTz+1nx+EUkNJq8DAkA+uveb+bx6kK27kO74vTeyInrljdF2Ifb88+wPAN7Gq3B+/cY3fZ33zm5MWIzwmGeG8lJRVVQ+D89wXiEYsYKtnu1ja9TXiTtlB6JmP76rT9bZ1bpF0iMGnw17LnEm0rjeEW48jEB6yc3VQF9Z19cFQ6SGIwPonLFD2AjodD2hR8ZKayldF4SW12R/w7McfptJeA8wUVopFE5YWrbTl/XXXZfyy4STY7luE7pbOahD5Ufuf8IRVmEsmwCnT903Y+eXf7mYlsh9mrX2Tsh9hIR/zyFJMf3efdudym8ZmdS35Nnwqtpmt+z5a4bIgisBnQS2hxE3AjH/gKgI6Dw+mBIoPLI+f4EWkN9sd/UuO7a8jvlP7D2ZT3LCLiDEpX0Oj+U8XZsIMjvjD2cOAK1zOWCOv88MOC+LpfmGyt/M7J2C9FZz6Hrvp0Fgdu34wL2kb6yYh0IPmR+AfCfRzCK/13bk0FO8HhmXbCTCrRMSh8ZY40l9TwbCQ+L+5Lpe546k2ihwoZGOKtPHmJ5RdarXikowa8nB15FxLeLVpBR8gLNSzUWb36lqa7KBx67hbmiQgh8cbJfm9colGujBnA0qaMuLgHo07Px3e4tMrwIWRPxBa527M0QstU0hbAQ8xMb35mW4ORUveC1mLGPopDS0mUSSap+1B94wnoUVVrcphoG8wf/8UKWz2r71cpkud1yFP8BjJkQI9ms5xo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3479.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(376002)(136003)(396003)(39860400002)(346002)(66446008)(66476007)(2906002)(36756003)(66946007)(26005)(54906003)(478600001)(122000001)(6512007)(2616005)(31686004)(64756008)(86362001)(66556008)(38100700002)(76116006)(186003)(5660300002)(53546011)(6486002)(8676002)(316002)(31696002)(110136005)(4326008)(6506007)(8936002)(558084003)(71200400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z2F6bVBJRHl0Q1dFeVBDazYvbXk2K0hqQlRpekQ3Ym9yRUtwTktHUllpZmJM?=
 =?utf-8?B?dmdZbllnalRFak1MK0VrVDFsMTV2Z080QW5TNStGNXo0Y1V6TzZoYmU3WnNH?=
 =?utf-8?B?dG5RV0ZwQXl2c1ZJSFI1NWJqYVFFTVhudEVHWUI2ZW1BdVRhWGtTekFUQnNS?=
 =?utf-8?B?RWd5OEIxMnZ4V1ZJTUZyck4xcmlEb2tpVWZHUk9ERkhDc1hGRll2cEI1TUQ3?=
 =?utf-8?B?WTBWdFFYcDl0eWROZzZMak1EM1NzZDFKRXdWZjIveVdwOFltZDM5WXU3cWdv?=
 =?utf-8?B?alJ4WVZXVGJiYlhyNS95OGJwM05xTUdjSyt0cFdEMmpPSDRIL2JtNFhTZzFT?=
 =?utf-8?B?NlBENUtnTUdpVmlRMEczQnNNMXM5Z0JJUmFuRGk5Q0VrK0prWHlsMi85azRw?=
 =?utf-8?B?S2RpR3hmWk1nYTlXNzB0VzJmN2RSbFNUUzJ2eXdORDltUjBwbStKbVNSSHBV?=
 =?utf-8?B?a1MwZVdROGgzY094RTMvSjJHYTZhS2Z5NE5qa08rZ1M3VWdxUU5rQTNCU0ty?=
 =?utf-8?B?UFFhM1RnYithTy9jb2Nud1dwOGwxUzc3UjJDMTNRZEc1YnR4RmNka1ZldCs4?=
 =?utf-8?B?UzRmeHdKcDl1R3FQd3YvVkpid1h4QXY4amt2Z2kySWhHTnl0WTJ0cEdzdm9h?=
 =?utf-8?B?aUVlQUU5U2thWllmWmhKRUVKdjZOeFZXdEFFWXV3TC8vY1orT1kzR3BScnZw?=
 =?utf-8?B?M0JiYWdhaXBIR2podDdFRk1nMm1HckhRZVlEVWtUYkc3V3JFaFg5ZEQwVXR6?=
 =?utf-8?B?M0hOR2ZRdWtLc3g4Vm9jS0JrYXdaTVplZmZnSlpTM3M3alFoL0pSeWJ0dFJP?=
 =?utf-8?B?YTU4VEd6MmdhZ3hWZk9ZMTU3TEVLd3E3ejdmbzVrcURla1hmdGdrczBta2ty?=
 =?utf-8?B?aXl5UWlxYmxhZGhpNURYSHZFU2RmaWljQitiaHVVQU5JWHNMSk1HaGd6a0RR?=
 =?utf-8?B?OUxGU3ZoYWdHRHhJL0JHTkVRaEdBMVZ4eUpmMExVOTNnRnpUZnowNHJSUmxv?=
 =?utf-8?B?dG8vd2MyN2V6WkF4NndZYUJCMTlOYkJVa04xN0VvWHFFMjV2ZHozVlNOMGVV?=
 =?utf-8?B?Znd5OW8wbCtraEFEVG9wakNEL2FOdjBJOUhtZC9vTVVLeEdmWDYwSDBiY2tU?=
 =?utf-8?B?ZFg2NHFxYjVzcnhtYTJocFhXcmk5RXFsT1NlRUpSSEVJcU1YUGNJUFoyb3Jq?=
 =?utf-8?B?WWdxNHV0ZTBBVnVGZWo3VGtaQ01xWWxPSjJhZkdDVXgwbXorREsyYURlWHhv?=
 =?utf-8?B?algvTzZjRFovKzkyVlJETDdqY1FiaXYzOEN5Wk5WY0FsRXRoVGpZenZuZWRD?=
 =?utf-8?B?eUFZbFdOczFBcitHbEFMNnNOU1hTV21xOFlKNE8ycDAxNUFkR2FxaWk4ajlP?=
 =?utf-8?B?Q1BQcXlHU3lQbjZTanhRZFZOeExseGdrcEJKWEpBOS9CZ0Q2Tkx5anB3bEZj?=
 =?utf-8?B?eGgyOXJBUjFacDVmZ25YNnZXOWdNdXJuUzBmVVRoT2pRS3NQOFZ5cTR3VkNH?=
 =?utf-8?B?c0tXUWtsWGo0N2tqYkRzeVh4eGNYZWMvVHk5Q2RSMS9BbFBZR3ExdHEraGhv?=
 =?utf-8?B?NFlxRVFwdXJaa0NRY2hIODBNTGNzUHEvME5LQ2NhaHlJbTVIckFUU1VQTkgw?=
 =?utf-8?B?SDJIclloN1JTdUlEMVRJZTJDaHdrd0tTYVFISlJ6SjUrWTFGK0trNVR6OGla?=
 =?utf-8?B?RUtvWmIycEFlWkRSTDFsR1drL1JxUTN5UkVyeDk0d0laS3ZrTytWTmRiSUFn?=
 =?utf-8?Q?IwInvX0JFV4m/gVbzo=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <98D59F3A2F77654AB16F348C34BEAA07@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3479.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87d7e331-e2ac-4c01-dcb3-08d9463686f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2021 19:43:45.4894
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qYVsfk55qrBlOwoBP3oJ4ZUCrAAsMdmPO6n3TsmIACO06QL+vUEq/ZA4gA91lLMR7RI6s/ISLuz//OYvDXxzMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3684
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNy80LzIxIDI6MjggQU0sIENvbGluIEtpbmcgd3JvdGU6DQo+IEZyb206IENvbGluIElhbiBL
aW5nIDxjb2xpbi5raW5nQGNhbm9uaWNhbC5jb20+DQo+DQo+IFRoZXJlIGlzIGEgc3BlbGxpbmcg
bWlzdGFrZSBhbmQgaW5jb3JyZWN0IGdyYW1tYXIgaW4gdGhlIEtjb25maWcNCj4gdGV4dC4gRml4
IHRoZW0uDQo+DQo+IFNpZ25lZC1vZmYtYnk6IENvbGluIElhbiBLaW5nIDxjb2xpbi5raW5nQGNh
bm9uaWNhbC5jb20+DQoNClRoeCBmb3IgdGhlIGZpeC4gQWRkZWQgdG8gZm9yLWN1cnINCg0KLVZp
bmVldA0K
