Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C416C30BC91
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 12:07:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbhBBLGb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 06:06:31 -0500
Received: from esa4.fujitsucc.c3s2.iphmx.com ([68.232.151.214]:28227 "EHLO
        esa4.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229534AbhBBLGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 06:06:18 -0500
IronPort-SDR: 0Pxr67E2C++lW2Y7zlvPA/r94xJjki19JB6zvRPpTvNJVnYN+MgZXa4z1RS6NRm8oK/WOMWJQK
 eLXTLuMsy9CdXAEHV4IafHFJt1KsBrT4KyQSDfd7QIxO5+4Ztobxc1Y4iRUAb1YzMj5Y9NCfeW
 h2rv4uw1RoFf70vTwRpcRnY9qJiQfRMdydqYOKUM2BVRwG8NpbeySrFl9V6vucsMu0OLiHoBco
 h30Sq9lqSFajXZ0qVLrSDkTm5nPsP1GSMCVpy/ZXrNaJWv7tCUGmhpotgOrf3Lc4d3eMpkHLjX
 G5k=
X-IronPort-AV: E=McAfee;i="6000,8403,9882"; a="33381732"
X-IronPort-AV: E=Sophos;i="5.79,394,1602514800"; 
   d="scan'208";a="33381732"
Received: from mail-os2jpn01lp2055.outbound.protection.outlook.com (HELO JPN01-OS2-obe.outbound.protection.outlook.com) ([104.47.92.55])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2021 20:03:51 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FI/DmEzhNA4Fl8OAKfJcG+EuA9IgtrUyDmce11MJMa/tJsqPVBM6bqpBJ5uG2Ja809O3IEXRX3g7dH8qEIX4kk3mbO11BGddEyGfsGt5sU1Pj2x3YfHMvYp0HdFCnxiltDVZKeKt0/b7rETZHGt6UVfod1VRoHfJi4MvJTk7oMBFKapu2Ge7WX0lUTKWwkJG8yjlxWLmjILFBb0f91s5yzb/fJpAMgiTnTtLv22i1VyQRjvPBr09fCxIIL50Dn4PgpwUcS5yrquwPw+Naab7Adc2QMHJwdodFrR0h74lJlrb/m78WPPKp4+sXeXog63M8tSF9WYxCv8hgSqbBusyHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y9eMVXw5E5QEaLqnqYx+DEgQiu53Pn9aHf/uQCm+sMc=;
 b=BhlLLfsZMW6Fzmap5Fmrr5fBgeIs3Ot4qiMda3EQj0QtA2rrpdEA0XItM/szJQDEYl38Bu1kQ0H7A3FMpfkXRNTxmj/0KGBVzSAjj2FdtsFWnVPRIQCGIV9kx111dgnv/Z6PCNevyJTJ3sQKrJtHBBo3ZY2iz4pgCERf1outfW4mcNKM99i6CRtOSFNk09pvAgrIFOccvQS4cktLZIIl1UGpIicFCGWNzi9eVGqwre4FpdLKwcvnC6DFgl9sruzKYj/SXdm6ZCGtwfgSWL1zf7jGQyUVgaDH69nm+Q2mcCdk/OltC9IMs8/o4c/934xaRJMPDEVstK0IyXaNIzDN8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y9eMVXw5E5QEaLqnqYx+DEgQiu53Pn9aHf/uQCm+sMc=;
 b=UOVKdVmQtlvwEFuBcY0LkdfNCir7hbMAIFRRsh4pbr6sX9f7jBFjJC6t9zqNji8WKmKRA8IgihXUo8ptLXBaz56kEvYPNOFUOB7iUkf7bvdyZVjviiMCnmCoKD8VJdFCD/HefUA2Gcgeo+ipfa0ioWbvcmx3D3HFJvjYgwHtFtk=
Received: from OSBPR01MB4600.jpnprd01.prod.outlook.com (2603:1096:604:7e::12)
 by OS0PR01MB5571.jpnprd01.prod.outlook.com (2603:1096:604:be::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.19; Tue, 2 Feb
 2021 11:03:49 +0000
Received: from OSBPR01MB4600.jpnprd01.prod.outlook.com
 ([fe80::340a:689c:36e1:fedd]) by OSBPR01MB4600.jpnprd01.prod.outlook.com
 ([fe80::340a:689c:36e1:fedd%7]) with mapi id 15.20.3805.028; Tue, 2 Feb 2021
 11:03:49 +0000
From:   "nakamura.shun@fujitsu.com" <nakamura.shun@fujitsu.com>
To:     'John Garry' <john.garry@huawei.com>,
        "will@kernel.org" <will@kernel.org>,
        "mathieu.poirier@linaro.org" <mathieu.poirier@linaro.org>,
        "leo.yan@linaro.org" <leo.yan@linaro.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "acme@kernel.org" <acme@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "jolsa@redhat.com" <jolsa@redhat.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v4 3/4] perf tools: Fix lexical definition of event name
Thread-Topic: [PATCH v4 3/4] perf tools: Fix lexical definition of event name
Thread-Index: AQHW+Iwa56rHnKzsoEqcHYuMoJlUcqpDXXQAgAFEHnCAABH1QA==
Date:   Tue, 2 Feb 2021 11:03:49 +0000
Message-ID: <OSBPR01MB4600965B5DC59606B838C2E9F7B59@OSBPR01MB4600.jpnprd01.prod.outlook.com>
References: <20210201111310.3231469-1-nakamura.shun@jp.fujitsu.com>
 <20210201111310.3231469-4-nakamura.shun@jp.fujitsu.com>
 <b25fe15e-f27b-fdb1-41ce-9728ce78d52b@huawei.com>
 <OSBPR01MB4600CF896542C021AACFD574F7B59@OSBPR01MB4600.jpnprd01.prod.outlook.com>
In-Reply-To: <OSBPR01MB4600CF896542C021AACFD574F7B59@OSBPR01MB4600.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-shieldmailcheckermailid: 187ee4fd324a4dbea9ac9a7d208411b3
x-securitypolicycheck: OK by SHieldMailChecker v2.6.3
authentication-results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=fujitsu.com;
x-originating-ip: [218.44.52.180]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e60e47c0-3948-4390-e7d3-08d8c76a37e8
x-ms-traffictypediagnostic: OS0PR01MB5571:
x-microsoft-antispam-prvs: <OS0PR01MB5571C56A6A04488E2F9A7E89F7B59@OS0PR01MB5571.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: m0YOXy17Gh7VFs3noOamuuraktL0qR83qSsDPc5L4uY8In75Y1PsQSeuVuiIgwZZVcGvIsLAzyIQJrIHMdiDDNuhuP4YdCskT2kxkBlh2b3b2HjdpRScOboCU2bmw8ywfoxdoJhSdGQ3UCNvk5d5S5GwbuEf/jOAnAJV/ZK7+H1+a8up9lS90VE4VKxuIBE475TWPSAp7ZyXvh0jUv+7JwPJfPtNJ77oMEkLFAe8FsEBMrGe9vLs+fMXju3pKzJbqmyKDk5dMhFxOnsPadN8rcm/ZB7fnVMEaJgiHhVwRYYqV5d/qGqGjP6D1qO/PGDxLlJuIs6jjSy/LlsCA/c3MEFn2SoOd4YRbbEoDWEK/w6C9YsTr8RQcoCHGg0T0WrwUD+g+kwxwvaRMOs53VI7lxl3PkmcQhkEQM9QR7puf1Y7lNck0Q9rCkHXll73P6OAC47E1SuG9SOEOmrLfuI73bf4pZ9bZk8y8BFtG+x7KTDcJGMFO90Ee6bdBeltIIYWqnSQxa0b5CRCunZSRM8xoOYfjH9H2WmL+giqZ8MWlDL9bWPedLlymDEfQI8lDplzOLwAdd/07/e6qvxU/4++Gw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB4600.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(136003)(39860400002)(346002)(396003)(66556008)(7696005)(64756008)(66946007)(76116006)(66476007)(54906003)(85182001)(2940100002)(33656002)(71200400001)(26005)(186003)(316002)(4326008)(2906002)(66446008)(8936002)(478600001)(110136005)(7416002)(83380400001)(52536014)(8676002)(55016002)(4744005)(9686003)(5660300002)(86362001)(6506007)(921005)(777600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-2022-jp?B?cHh0NXFxRW1EVGxMcGFMUkU3dlB4VXgxeDh0QlcvWUhlTmtubzZISWhL?=
 =?iso-2022-jp?B?cTBMSS9YWFBnbHVKdi9PT3Ywa0hJemRoWThEOWI0OE9EWjlpQUhZUzhl?=
 =?iso-2022-jp?B?Y29JRDAwam5sSUlwL3VKM2FhdmhsbTg2RHdjZmNabE82T1MrNEJUSVpE?=
 =?iso-2022-jp?B?YTVPUEh2Q0QxdzJJTDZ5bXVZeEdZbGp5MUpGWmdPZ1RRTkZjZzdmMXVK?=
 =?iso-2022-jp?B?R1V6VVFFKzJyVHVOUFgwQVNESDQzUUlHMlgvZFZtbVd6QzQ0eURZNFBK?=
 =?iso-2022-jp?B?RTBQSDVJYmRGdVozQ2ZoR2h6T0tZKzkwRFQ4V01OUWhzWVYzTU5EL05j?=
 =?iso-2022-jp?B?MTNKR3Z6TkhkVVczbkhXcEtMRDVqMkl1TDFJbU11WjU3OXJVZ0NTZkYr?=
 =?iso-2022-jp?B?YkM2TDlqSTkvSHZtQW4wUm5KODJzTkxRbEt0eWo4K0VDUXZaaUNFMG5K?=
 =?iso-2022-jp?B?aS9vR052bDZhSTF1Uk5FVUxVWmErOEVCakQ4eDJSc2QyVmJKVDRFUG5y?=
 =?iso-2022-jp?B?WGN2WHUzcXRHTnlBTFFsZ1hjRU1EaElONDRLcVc3YkVKZjFwRzNLV215?=
 =?iso-2022-jp?B?N3N0R24yd2FlMGZkQnBSNjRqdzIxd2pkbzFxUzU2eGpJWEJxUHI3aDgv?=
 =?iso-2022-jp?B?b3Y0Z1RXZmpFZUJNbXl6Z0lLUDFJY3B0WUxPeHM5emRDSWYza2sxVDhO?=
 =?iso-2022-jp?B?NTVMVDFYYTlGdTRuc25hNUduVW1xWmV4ZnRYTy83blQxYlNROE85N1ly?=
 =?iso-2022-jp?B?Y2krU3QyVGV1TVR0Um0yOVBPWUpLWStJMEdNLzJpTmpOT3ljWmNRd2E3?=
 =?iso-2022-jp?B?UDltZEZTU01USmMrM1B6a1c0Q05lMEl1U1k2Lzc0Q3RRNHNnUFVwRmQv?=
 =?iso-2022-jp?B?TW05WFZQVW9mUXFyUXAyR21rdG0rWUh0aFNmRWNrNVBDcktJWFhZVzZK?=
 =?iso-2022-jp?B?cm1UUkducU8wSmw2MG4wSFpyNTJrVTZQbnR1ak9STU85Y1RiUm1qRnNh?=
 =?iso-2022-jp?B?NHFIcXNwRFFSanhvNVFydjE0NUpnZWl0bEVZcExVbnljekU0VUMyUDZZ?=
 =?iso-2022-jp?B?WS9NZEZmOWZsdzFXdjkwQUk0MWJsb2ViYlVVVGNWL0U4Q0JteW93Zkl2?=
 =?iso-2022-jp?B?cXBHM24xWUovVkpHRG04dm1veDd0cVV3VG8reHlaaE90dU1KSUZBNmxF?=
 =?iso-2022-jp?B?S0lUaHN5N2xvSjIwNXVORk42NjBUMnJtdm1yZHdyOEh1OStiSE9aUHBJ?=
 =?iso-2022-jp?B?b25ZUUErMS9RcCtFWXVTbTFxcWdMbG1hVm05SlFyWWozYkRRdjF2Ymda?=
 =?iso-2022-jp?B?QU1pOE0rOElvUyt3NlBBbVZXRy84TU9DVitDUzI1NGJEalJzRGtRZDJF?=
 =?iso-2022-jp?B?dHo3SXhRMWxlbXMxaXZqUmdrL3kwZUlRNnBxaDl1WmQ0UmthZUl3UjF0?=
 =?iso-2022-jp?B?bzRqVVM5MVl0MXh2bldpZWdpcjRuSUtjY04zdjU2Sk1xLzk3Y3RUT1R6?=
 =?iso-2022-jp?B?Qlo2dEh6VzE2Zlg0a3dNQ242a2FpZGxaVmRESkFUaWo0OVVJaU4=?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB4600.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e60e47c0-3948-4390-e7d3-08d8c76a37e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2021 11:03:49.0637
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3nzmX6vlAB+CPKL2qwmaBYPkhMP1dEAOsuTCOMMjyBIz/ow8lKIYGspX7xD+NxbzxFvybRDy8HxtocZl6oQEimp/BVZAFzxLucOz8ePtobo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB5571
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(I missed to include the quotation in the text. Will resend. Sorry about th=
at.)

Hi, John

> > Fix the lexical definition of event name so that the numbers are recogn=
izable.
> >
> > A64FX defines an event name that starts with a number.
> >   - 0inst_commit
> >   - 1inst_commit
> >   - 2inst_commit
> >   - 3inst_commit
> >   - 4inst_commit
> >
> > Signed-off-by: Shunsuke Nakamura <nakamura.shun@fujitsu.com>
>=20
> eh... I'm not sure if you will encounter other problems, so may be pruden=
t to
> change the event name to not start with a number. Someone else may also a=
dvise
> on this.
I have applied this patch and confirmed that the event can be specified cor=
rectly.
Event names are defined in the A64FX specification.
I want to deal with it at that time if there is a problem.

So I would like to resend the v5 patch and wait for advice from others.

Best Regards
Shunsuke

