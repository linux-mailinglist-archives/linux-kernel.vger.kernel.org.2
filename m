Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A33E137B493
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 05:35:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbhELDgY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 23:36:24 -0400
Received: from esa9.fujitsucc.c3s2.iphmx.com ([68.232.159.90]:38142 "EHLO
        esa9.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229848AbhELDgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 23:36:23 -0400
X-Greylist: delayed 428 seconds by postgrey-1.27 at vger.kernel.org; Tue, 11 May 2021 23:36:23 EDT
IronPort-SDR: J9qao6/jkoHXlrBzzZT/nohOpDcADH1NRX9K2+j8Osa1fVexnYQXqIe8T2Wv+pKPSlwYM89Qg+
 wxOfsYxhk1QfyGQDEEcQC69CHS4y9+2Ip58wTGsoPsNm9Vq72yVQd/xjkbb8WhE5MqjFVv/tSr
 BGT9PstQPF5VcHJy2bXZJCzwZMRQl4kTdtk1EsZXxn74tSw2JNTM4+r1taHsUpnrKz9BiHrfg3
 m606JsSHGA1OFEp8Ujb9bhsfzCa9YucY+n949qy01oG+FfOSBZHvQB7LZUcXFpQ0+rXxzJ4VAr
 tmI=
X-IronPort-AV: E=McAfee;i="6200,9189,9981"; a="31213397"
X-IronPort-AV: E=Sophos;i="5.82,292,1613401200"; 
   d="scan'208";a="31213397"
Received: from mail-ty1jpn01lp2056.outbound.protection.outlook.com (HELO JPN01-TY1-obe.outbound.protection.outlook.com) ([104.47.93.56])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2021 12:28:04 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JQ9XaRShSqJ8MBETTfmH4cX6msu1mxOmPu0bUBYkXRpmQ01JJGdN/5dufUmcenuQLNqQ8gflkr5RpZGp2SBIU9zijHP8kwVcuABij6qHU1n2ecxitAqVYXtos2yvTf18IhxcggW0dbIhftSOzgwDQlp8siPoQigy2eDo/djZUz5zRX0u1rD5Ey0LV/ahVRepApSB01PCn0AA8dTRJeF5z0Hu0C0Q3l6SHoFaZhpdFpSZPEH/7DBD9CEP0RJqtuobUTNIKvMA9SEMMy/bZXgPVTQLPyA21fb5IhmAxtpB2x0EEKsnr0RcZEW49qeHNWyqUBocTUfS8+rBr7+zxoBYPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BHdXL6TUX+6YawpjX/y7s4s/VezdWOZ+HlCbBaDWJA0=;
 b=k5h7ZCBEx/ESjv7cfhaTHK5Zg5trjLKKl0vyTHc8fTSHd/wpe1riugN1okzbxhyphsraL4HmUf6TF8U1fqYoLzHD2NpjYW20+4hvtbr5YxHJEMifcNkKmdJ6IFdjsLVSYxtp0gL+TuyrZEDrSptl34XBFZ4bShWJ8Ej9uArk5ocTwu70jO4tbpK+0sp1XxPk7polONkwpeg1vqWKEbcVrFAoSRhoBaRu8IB3yOXe343eikc/cdwVBwLVK3oBcXt5WlLIpDhppu7DP3mHFzn7tUkYGXShdYug4AWjiZsY7Refw3BEUpirTz617G6IL/PQf45EutFNHHjgFW5MzqmPLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BHdXL6TUX+6YawpjX/y7s4s/VezdWOZ+HlCbBaDWJA0=;
 b=CmzXJqgPX0zLXXaEkl1F0IvlXw1+/CM2eS2iFr8iOXva8wqZS7R3wxi1z0pmdF3KRgiK2xM8Y9N27lpVUHMqP7c0erHzM3RP0x/yyK9+c1UmD8rNyK+pewfooTN8xUYxmRQIRQMxkU52VcF3Uak79ag7J6OpRrTeAkIQ/RPUUQk=
Received: from OSBPR01MB2183.jpnprd01.prod.outlook.com (2603:1096:603:22::14)
 by OS3PR01MB7079.jpnprd01.prod.outlook.com (2603:1096:604:125::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Wed, 12 May
 2021 03:28:02 +0000
Received: from OSBPR01MB2183.jpnprd01.prod.outlook.com
 ([fe80::702e:951e:8f05:5cbf]) by OSBPR01MB2183.jpnprd01.prod.outlook.com
 ([fe80::702e:951e:8f05:5cbf%7]) with mapi id 15.20.4108.032; Wed, 12 May 2021
 03:28:02 +0000
From:   "hasegawa-hitomi@fujitsu.com" <hasegawa-hitomi@fujitsu.com>
To:     "'fweisbec@gmail.com'" <fweisbec@gmail.com>,
        "'tglx@linutronix.de'" <tglx@linutronix.de>,
        "'mingo@kernel.org'" <mingo@kernel.org>,
        "'peterz@infradead.org'" <peterz@infradead.org>,
        "'juri.lelli@redhat.com'" <juri.lelli@redhat.com>,
        "'vincent.guittot@linaro.org'" <vincent.guittot@linaro.org>
CC:     "'dietmar.eggemann@arm.com'" <dietmar.eggemann@arm.com>,
        "'rostedt@goodmis.org'" <rostedt@goodmis.org>,
        "'bsegall@google.com'" <bsegall@google.com>,
        "'mgorman@suse.de'" <mgorman@suse.de>,
        "'bristot@redhat.com'" <bristot@redhat.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Utime and stime are less when getrusage (RUSAGE_THREAD) is executed
 on a tickless CPU.
Thread-Topic: Utime and stime are less when getrusage (RUSAGE_THREAD) is
 executed on a tickless CPU.
Thread-Index: AddG3PD5Dm9CD2RNQ7+TrQrb7bYc8A==
Date:   Wed, 12 May 2021 03:28:02 +0000
Message-ID: <OSBPR01MB21837C8931D90AE55AF4A955EB529@OSBPR01MB2183.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-securitypolicycheck: OK by SHieldMailChecker v2.6.3
x-shieldmailcheckermailid: ed1115fff34a4237a470a5db97d63ca7
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=fujitsu.com;
x-originating-ip: [218.44.52.179]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 00a21a01-3789-4a6c-b95d-08d914f5f2cc
x-ms-traffictypediagnostic: OS3PR01MB7079:
x-microsoft-antispam-prvs: <OS3PR01MB70799E85528D2B03ED3344CDEB529@OS3PR01MB7079.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ISyZpvbu6Ivl+Shsi55jdhsGJjCbwrdNm9DeQCkMm+egOcBSqmMOTlTXqqHzf3+7SPtOjMK76D+xcdjM11umluZ5WUGu0xjZmBKymRmArrJ4SFKrgld+QeWUo3RMz8zRQ0sHpb3kvMgoS6AtH+LhNhYshXnFaXPS87psa1awDLFSxL/gehhIffz3AuXa8j8KINgMmwCPPj+xCM6NvX9aT+Ikf1vFkECvnk1TBO6N8p2vHQZrY6/Mrtee0COxi18euDs3VXqrGA0l5T33NhYsjnt+T+BvT4tMAsT/oiDzCfJbO4AaGV0v15npWLH2dvoV72YSPWqO2y0XULYinQtg856M0iiuH80wegERuxwugEFSJjh0WDxFGVfMJEtCfN3QTIsG81AOxQQDuySekOSfeyw9gtWmgu69n2zgHS7nafztZWSxrqvhg1oGP5d2u7ILuCrnTGJohzM3uAKY2gHvze9uIpEcnV3QsPgncOOth3Y0I81e82PxfEMiTJdiKgwRCRyMItiA+GvKt8OpcjgP4VqbxHwSLr4tNS0xS75nmNhO3RaHkpr917JB6XXYps4i7PldVKEirNcivvI6RSu6SsAPqJx7vXXpCZnUP0nYaZXelxtGHRu3Xrk3aZ1HA7U7WieUQqOhc2jMuxFWfb9ofA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB2183.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(396003)(376002)(366004)(39860400002)(66446008)(66946007)(52536014)(7416002)(110136005)(8936002)(54906003)(66556008)(478600001)(64756008)(76116006)(85182001)(5660300002)(83380400001)(186003)(66476007)(316002)(86362001)(2906002)(33656002)(38100700002)(8676002)(55016002)(26005)(4326008)(71200400001)(7696005)(122000001)(6506007)(9686003)(491001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-2022-jp?B?bEM4YkNnQm5MTGN0Ykg2NktManFGWnVpVURHa0ZuS2FKdmZsUGwxSW1S?=
 =?iso-2022-jp?B?a2VrTXdNNHZzeFlMWkFaVWY3ZG11NFRXK3lFOFNFb1luMVhvakphTE51?=
 =?iso-2022-jp?B?NnczczBPVTlSTUJ5SXE5YjRWYlRTaGt2c2VrMUVHZG5aVWlBWXVGQkhy?=
 =?iso-2022-jp?B?V2tHKzA0ai9xNFlaSGFVMExnWHVSZ3MwQkI1YlFlT3JOWFpERElnb0Ru?=
 =?iso-2022-jp?B?N2hVRmRzTUszeXNsWlVKM2xtcWVCTGNqLy96OHFCcU40NWFyS1F0Ritt?=
 =?iso-2022-jp?B?a2k0UlAreEVzTXY3dVdaeTRKSzJMTHdoeVhrNkRnbmk0NC8zUG5sYmp0?=
 =?iso-2022-jp?B?RnRIZWdrM3RjWXlyaXByOTZmWFcwaERETEV4MDNISUdhenpWejdQeGpH?=
 =?iso-2022-jp?B?amJ6dElvb3BTK2Noc2Q4Y091S1d1bjFKWEEzQzl5aldjTmUzbHFPY1gv?=
 =?iso-2022-jp?B?UU1tYVpOMFZsSzN3bGFJLy9WNEM3V0M2SWduU2FvdXBXZ0ZzZlVic01p?=
 =?iso-2022-jp?B?RUo2dDJXWkdHemFtVFJVSXRua09BZGhMcCtlZWF3MWthT1ZjQ3o1cS9w?=
 =?iso-2022-jp?B?YlpJcXB1aGRJMWFlK005dC8rMFZSbVViRHoyWHBsMUxRdDluUHdFU01K?=
 =?iso-2022-jp?B?QVFVYkh1R2UxZjB4UzBmOEJES3J4bGE1UCtwczB5d0lmUlc2N043RHhN?=
 =?iso-2022-jp?B?WUFHYzlnZUovZWlmS00wVStCbzR1U2xSUWw1MkVvMCtKeUlzd0pDL2dF?=
 =?iso-2022-jp?B?a1ZPRTFrU3B5c1NVQStSL3N6cGZOZlowYWU3cC9BaUVBN2dvMWk5VDNx?=
 =?iso-2022-jp?B?MDhjMmhQcytrR2RHTk1WTndpUStBaFBHUEE4QWtrZGg0M0JselBkeENO?=
 =?iso-2022-jp?B?dEhLRFJ5N28xb1hraHJ1VHBUMzNCeDFxSGN1K25peHd4Vm5hUEZsTWdL?=
 =?iso-2022-jp?B?U2JPcFc0S29EQU1RUmx5RkhjNmJIcFlVYmNadkNTbmhXTi9ERTUzZnBC?=
 =?iso-2022-jp?B?TWprWFRpbFR2R1laTDF0RUdCMWdLMk9mWVZlR2wyd2dKaVV2VmlEZmcz?=
 =?iso-2022-jp?B?eVZMMU9vVTVOdDJkSzVScjhwamRqaXBWNDJDV1NicmdpZEU3VWVKYUtl?=
 =?iso-2022-jp?B?b0lRUno3aXlGZUl5a0hvMVZVdlNraVFRMjB0WVhxNFhseVoyb1JmSWM4?=
 =?iso-2022-jp?B?eTBaclR0cy9XMmRJWVNCUFlXRytnMUdwWmh4YXlpOEtSSkhzUUwxZEFM?=
 =?iso-2022-jp?B?SEFWMEJHcEhjMFhXSTZVUFVRVGJJZExlMVNLK3lTMVJ5cFNqZnFnbUp3?=
 =?iso-2022-jp?B?N1V1dWN2TUY2U0VPb1ZNclRQZnNocFhDcWQzbWNhaW9jNjJHaU9ob3pK?=
 =?iso-2022-jp?B?YVZVbEhvNXpkUzgzSEl4eG9hRk1MdjRQRXZXTU1KWlhUUitIeWZTM1l6?=
 =?iso-2022-jp?B?NlV0M1VBdlRQdnVVMElqMXJBRFVGVjFRSHNzbUVBbkpTTEdPRnZvTGdR?=
 =?iso-2022-jp?B?LzNZU0hma044MVJ1cjFiRmRCVUdLT0lxL2pZNjdUeDlxQVZuSW9sRG1O?=
 =?iso-2022-jp?B?bzZGWnNuc2h4eEF0c3o0Y3lBSHkyUW5LZFdEdXRxTksyUVdiK01wc2lF?=
 =?iso-2022-jp?B?dUdZeDlkRmNlSEtqR0FUYjl4TnZxTnBNczVXdkRoT2dadGZPL3NGQkQy?=
 =?iso-2022-jp?B?aHBObEFuNThUYVYxeWhJVkdYUUZHZkh4aTRoZ0hTRzNDY09RK0hyajds?=
 =?iso-2022-jp?B?STFVdTFNeTZsQ1VlUzRTSjdXeFFzbnNJeUJ0Z3BtZXI4cmg3d0kzOVBw?=
 =?iso-2022-jp?B?OFE5cHlpOUxJSmdXcmRjM0RFbGVjMWlINDM1MThsTnZvRHE4VHN3Unp3?=
 =?iso-2022-jp?B?cHl1WUE3VVZLYytJd0N0N0NtcFprPQ==?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2183.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00a21a01-3789-4a6c-b95d-08d914f5f2cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2021 03:28:02.1792
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tjgl8M3PWroIOHWeu6KuWaL5DLLmmi20CWNTI1Id4AEhX3SFsZyfGMhNNi9q0zvsM8+dxQ1sgA2iTbsXuI0tb5T/hT47U8HbVZgCKDkT7SI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB7079
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

I found that when I run getrusage(RUSAGE_THREAD) on a tickless CPU, the uti=
me and stime I get are less than the actual time, unlike when I run getrusa=
ge(RUSAGE_SELF) on a single thread.
This problem seems to be caused by the fact that se.sum_exec_runtime is not=
 updated just before getting the information from 'current'.
In the current implementation, task_cputime_adjusted() calls task_cputime()=
 to get the 'current' utime and stime, then calls cputime_adjust() to adjus=
t the sum of utime and stime to be equal to cputime.sum_exec_runtime. On a =
tickless CPU, sum_exec_runtime is not updated periodically, so there seems =
to be a discrepancy with the actual time.
Therefore, I think I should include a process to update se.sum_exec_runtime=
 just before getting the information from 'current' (as in other processes =
except RUSAGE_THREAD). I'm thinking of the following improvement.

@@ void getrusage(struct task_struct *p, int who, struct rusage *r)
        if (who =3D=3D RUSAGE_THREAD) {
+               task_sched_runtime(current);
                task_cputime_adjusted(current, &utime, &stime);

Is there any possible problem with this?

Thanks.
Hitomi Hasegawa
