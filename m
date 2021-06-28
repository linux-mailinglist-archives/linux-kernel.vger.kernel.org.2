Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CEEA3B574C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 04:43:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231996AbhF1CqI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Jun 2021 22:46:08 -0400
Received: from esa11.fujitsucc.c3s2.iphmx.com ([216.71.156.121]:51178 "EHLO
        esa11.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231678AbhF1CqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jun 2021 22:46:07 -0400
X-Greylist: delayed 427 seconds by postgrey-1.27 at vger.kernel.org; Sun, 27 Jun 2021 22:46:06 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1624848222; x=1656384222;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=zzTE/ydWsDIXeZ45ElO3OmU2R8ZlyfwCVlvty4zm3Q8=;
  b=Owo/BgMzrf+2g9pcUZK1wG9wysvYRByno8lVazvmWNVxauKpGe/xx6dy
   CypAE91JMF2hib2nmiBpmOjhE9W+lhSPYXsHtIU7NnBq/guOFzos7ru9u
   uVmXEaZydKc5QtVXOkywt1U/yOLxfU0wdAD8p2EutMJ9tnbqj3pC3+Lkc
   7I8dLq3fY9Y36qVUaU0NaxMwbIn595YRzevpEnH/sDokUsJsLGPIildvx
   5R6IOdUkJJ6/IOqiuluZVei83nVTiGuJz6zzlxt7xmiLWMbtb5GUwGdoB
   055v5PSg6tg5tp1jIfU4fLo7jRYXf23gjuLTMd6eNxVOnTY9mPPgXo4Q0
   A==;
IronPort-SDR: wUwkGQI7X1ft4EjoILev4etQKyyQYEPizfIJntPSOua+bo91VHSNFFC11apg8D6xtOEc636Ibh
 N/5yMRrMZE9LhmSkGaCv7NRbs6m0Iq8ib3ySj2LF4JvcbOWR7lU4gQUAYMpW2HbNPL984sDrLe
 NwAAKVhvi3dZpj2GHPFOjLfl+P99KLEVAXgJecrVDxDfUk0qR6ERsRGKIQKoUy3ids0NG8Mzwv
 n8XaUlLrgfYczrhsen9upDeuN3Cwb8V+62k7ZfgAA5L6BcO60yuRQ7wiPPtu7+fMt0xgmtZ2YV
 Bjo=
X-IronPort-AV: E=McAfee;i="6200,9189,10028"; a="33984839"
X-IronPort-AV: E=Sophos;i="5.83,304,1616425200"; 
   d="scan'208";a="33984839"
Received: from mail-ty1jpn01lp2052.outbound.protection.outlook.com (HELO JPN01-TY1-obe.outbound.protection.outlook.com) ([104.47.93.52])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2021 11:36:29 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jJCZPkChrRbPKBtlK/KoUyzTQs80rohviYrhd8D5GWWakGuAydFeBid8Lao2l4c/aytbBFmmO9o7dEjRTj/+0dLBBf5Kl2u6PNRTo515K2uOg+l2gSsZfbferf04/l9eLLL6CbZWJRMfuVAp+iJZO6yDouDsFPQ+BAmigfusd/FP7E69US22Pd/4GCPkBpUGGEZKTvPCojbgZ5Nnl+kSfUIU+1fEUK2ocEX27ZCpQKOUP7jYQ0a54+aAHn6n1CvVbXI17cwL77FuM17OZVxKTJNEXqlV4J87tZ2tZzh+GwM7lcyaAdFQ0H3k6dXTyCc/dm5D2TUT1rxupBQfCkTMTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zzTE/ydWsDIXeZ45ElO3OmU2R8ZlyfwCVlvty4zm3Q8=;
 b=SZWPg+V2/vo25aHSeDJsz6CW7mHVPVJzovVvK0r80bQO/3kcRR8l623RWtzWrNo9CMfMTAchXleQ4QiKF8FwcTdLmRiB8mZXl3HqA7uz5OnAVXC4L2Rf2E3JIloAyka/kX6a6rzDR3fstRzam4RmoYHXPUHedsxOFBXqHfdTV5gBuuegUlKRjUAU300AqlTgxMkounFAs8iNttNKnONbO8CTvMlZd4mXahwP7e4fwvlX2MgXOeTlO3GxjtSpfJYrexDTEqQaQP7ajkJ9BqqJUAPIfMGfLmNRWPZxi2gGmOPeVx/hMbbRmSaiWmbdIWPEzi9NsdrHZWV2dH7x3cmIOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zzTE/ydWsDIXeZ45ElO3OmU2R8ZlyfwCVlvty4zm3Q8=;
 b=VLb/ViyZ6SWYqlbJUJybv+o+Ab8Go+/X9pz9yPbN/Lv39bdG0bDIAuTEndaHwLgxjjxGIYA9D6Ue3tzxpVCw//ZBZmgghnji3saB6l8c/H9DHl2PS0Jr2VEm6AhwYLUyO7GPuNCnmm0SydtIP2USdqMmYzPNuIwiRHI1ACc263k=
Received: from OSBPR01MB2183.jpnprd01.prod.outlook.com (2603:1096:603:22::14)
 by OSBPR01MB4934.jpnprd01.prod.outlook.com (2603:1096:604:73::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.22; Mon, 28 Jun
 2021 02:36:27 +0000
Received: from OSBPR01MB2183.jpnprd01.prod.outlook.com
 ([fe80::70e1:11ff:3bd1:b440]) by OSBPR01MB2183.jpnprd01.prod.outlook.com
 ([fe80::70e1:11ff:3bd1:b440%6]) with mapi id 15.20.4264.026; Mon, 28 Jun 2021
 02:36:27 +0000
From:   "hasegawa-hitomi@fujitsu.com" <hasegawa-hitomi@fujitsu.com>
To:     Frederic Weisbecker <frederic@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "'mgorman@suse.de'" <mgorman@suse.de>,
        "'mingo@kernel.org'" <mingo@kernel.org>,
        "'tglx@linutronix.de'" <tglx@linutronix.de>,
        "'juri.lelli@redhat.com'" <juri.lelli@redhat.com>,
        "'vincent.guittot@linaro.org'" <vincent.guittot@linaro.org>
CC:     "'fweisbec@gmail.com'" <fweisbec@gmail.com>,
        "'dietmar.eggemann@arm.com'" <dietmar.eggemann@arm.com>,
        "'rostedt@goodmis.org'" <rostedt@goodmis.org>,
        "'bsegall@google.com'" <bsegall@google.com>,
        "'bristot@redhat.com'" <bristot@redhat.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: Utime and stime are less when getrusage (RUSAGE_THREAD) is
 executed on a tickless CPU.
Thread-Topic: Utime and stime are less when getrusage (RUSAGE_THREAD) is
 executed on a tickless CPU.
Thread-Index: AddG3PD5Dm9CD2RNQ7+TrQrb7bYc8AE2IspgAAJjxoAAIq+F+AARwywABYd9iwABIB9liwEkfn4K
Date:   Mon, 28 Jun 2021 02:36:27 +0000
Message-ID: <OSBPR01MB2183D3C6B2BBF25B22DD09FAEB039@OSBPR01MB2183.jpnprd01.prod.outlook.com>
References: <OSBPR01MB21837C8931D90AE55AF4A955EB529@OSBPR01MB2183.jpnprd01.prod.outlook.com>
 <OSBPR01MB2183384B29F6291EB7C0BB81EB2C9@OSBPR01MB2183.jpnprd01.prod.outlook.com>
 <YKN5cQpFSdsgBlBU@hirez.programming.kicks-ass.net>
 <OSBPR01MB21835E55331FCAE6F75E8332EB2B9@OSBPR01MB2183.jpnprd01.prod.outlook.com>
 <YKTZag/E8AaOtVT0@hirez.programming.kicks-ass.net>,<20210616125452.GE801071@lothringen>,<OSBPR01MB21836F532CA384C7378C1284EB099@OSBPR01MB2183.jpnprd01.prod.outlook.com>
In-Reply-To: <OSBPR01MB21836F532CA384C7378C1284EB099@OSBPR01MB2183.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=True;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2021-06-28T02:36:26.821Z;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard;
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fujitsu.com;
x-originating-ip: [218.44.52.176]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8b0b45a3-b806-455f-f9cb-08d939dd878d
x-ms-traffictypediagnostic: OSBPR01MB4934:
x-microsoft-antispam-prvs: <OSBPR01MB4934F92996E0115F6892ED0FEB039@OSBPR01MB4934.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: flQ+uzmdd8g47K1miMWPLY3h74ndmcmjoLy2eP+yq335q8Ph4AHzJ+5QYNJ4tXyQ8j/+856TW4YFLwYrrNTmLbFBykwCsV8IZPIhhtKePxh5r8dbS845M4jdRy0dY6QGYeNa+B2opMu5xU8R4qDxo5RmEB1GUbc1RIjge3MGYmvYfJU8ovzg901L/ZN2wMepqQqKjPOu9h+X1Rg0kBjUA5z/2+varYCkZgQTlYPXMc313c5s8s7gR4Z0TaQdqJwSW+wfA357P5AlqVy4z2u4h0IwdPuzEAl4yjgliPDy8TFQcJIhJ7gMan9eqfiKlWwbqJ+WJ/k8J6Tn52nqAl6STFaKyfGxv0Kf2hsoqr21vJgs4i2S8Hgn3WEYYIoeP8XF4BQN26O79eKdnzGeBZwDyCYRpG1RRC+SM3fMsfcU1VvUm5O/6DSH46FcIho5pNquVWq0YpHOQ2wuxSRccUk6x8sujMI7gmLMoh7Im4T8KgxtE0IhvgmREDzFBTw0VZgxIuc1KzY0SysECVCeNk4C9VXWiSHCUP+n8JuXs6ycgD8IQ3rgTO1sZjdwykd7pGLui6WaMYJI1rpcGnqr7pGzUj2tIbltyvHupfHkzizzu1I1dBVIu2Y7Xy0MkqWc3D4WY4SZPBUgU7EKGRNzCmkdErIE7iVks08gHRZhIQtIw8Q8FzDEnlvQcGiobhK6LbAl
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB2183.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(376002)(396003)(346002)(136003)(316002)(110136005)(71200400001)(85182001)(86362001)(55016002)(8676002)(7696005)(4326008)(7416002)(2906002)(9686003)(8936002)(76116006)(66946007)(54906003)(478600001)(6506007)(33656002)(38100700002)(26005)(66446008)(64756008)(52536014)(66556008)(186003)(4744005)(122000001)(83380400001)(66476007)(5660300002)(491001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?WVM2a3Y2WVRMNWFBSzZCR3pSOFZhVVdocHIrMlljWXlTN1loTGVqWldZ?=
 =?iso-2022-jp?B?eU10UEZNSUpOTWVqVjNUKytGQ2Q3cWxGSTMzL1VCdnJ1Q3k2S2RvemR5?=
 =?iso-2022-jp?B?c1UyVkRRdkZKTmdrVHFEODlFUC9uVXJKWDJva1Y1WXc4QmdSeVAweFRH?=
 =?iso-2022-jp?B?cGE4bVBiQ2JtZGZVZkFnM2R6dXBhWmx5cDJTdWVhOGViL3FSZVBmL1JL?=
 =?iso-2022-jp?B?OEZWMGlaa1NuYWFFV0dKaGF1ZVRjZDVISXQ5ckxoV21KT01hWUtoOGZy?=
 =?iso-2022-jp?B?MUNZRk5RWDE5bGJobWNreG1OdVo5dVRCci9mM2FRWWVpM3VmRXFHdTRC?=
 =?iso-2022-jp?B?OHNFamp6SXo2WXVVMjB1RVR1Tmt3WFJnQ0RMMzlsNUxidmZXVlZvODR0?=
 =?iso-2022-jp?B?Nkw4SDFPcHlNaFpNVXM3aHk1OU9GNWFCT2ludjNRTldyRTVWeDBza2FL?=
 =?iso-2022-jp?B?elBGQjFwWFhYTko5MVV1T2JQZVJYRWV1cG02K0Y2ZjF3YmxYTXlQOTlD?=
 =?iso-2022-jp?B?Z055cVpvNHFLbFN1UktRcVlXdUxERm9MeDIxVnNydFdSUjE5bFZkUDhq?=
 =?iso-2022-jp?B?dWFyT1pXYmp6SXJtT0FBcHM1ejk1eG1HQmhoVVRlY0FYRy9YeEw1VU5p?=
 =?iso-2022-jp?B?M1ZDdDdRN2E5MVd3c3Awb1VMcCtESHVPQzV2Zk4zYkI0eWhSSUtuTUtm?=
 =?iso-2022-jp?B?eVpNN2J0ajdZUndhUUV5Y25HanFFeDdtbU9BWGdXWW9OWllyK1ZkYzlq?=
 =?iso-2022-jp?B?eVZtY3R0akJxNnJRdTF3a09zdEg1UVF3b1A1V0dIVDc5QStLTFpqNmNE?=
 =?iso-2022-jp?B?TStQTnJ4UlhtZndIL3A4ZDRFV0o0TzFPZ3R3dlZXTUU1NDFxVmlRMDJS?=
 =?iso-2022-jp?B?UnBkNzIyclpCRGtZK3drdElsZUtMejFoaDVuRVBPVWRjV1NnZHpUSkJQ?=
 =?iso-2022-jp?B?V2hyWDBvNXNSbWR3enl6ZHAyRzNNdFUzNXd3aTB1cnBwTUdPVXV5Vnh1?=
 =?iso-2022-jp?B?K3JQeFVaRFVLM2hRekVzbmpkTzk4bXg4c0NPV09Kc0x3bGtVcTNDSzVH?=
 =?iso-2022-jp?B?UDFOQnEvdU5kSVhxbExYd21EUHZiNU5ZbUF4R0FLWXFLUTdTcGhRWDZu?=
 =?iso-2022-jp?B?MkFheEUrWHptRGhCRlYvYU8xTHZVM3R6TVBNOXhKbVZDTEd1eFQyckx5?=
 =?iso-2022-jp?B?YStHbXYxaUpTdjJ6SVllbzdRZWY2SXduekdHdS9uOWVKd000bTdjNWRZ?=
 =?iso-2022-jp?B?OHYrQkVrTXhEZW1XdHlZN3lhMWdsWFBTTGNSYm40S3duUXJnTWZJQ2Rm?=
 =?iso-2022-jp?B?U3hYZzdMRHJPMGY3VnNKdExsUTlRU0lOZDY5WEtpWDNWVEh3KzBNQjJz?=
 =?iso-2022-jp?B?TkwreWd5cHg0bnpnSkV3emE5T1IxbEhnSW40TUtIQndaeGV4ZFNxdHZt?=
 =?iso-2022-jp?B?OTljS285VlVad0tseHlRZW10Tzh3MzdkUTZadFdsSGIvZ3hjM2ZLRmti?=
 =?iso-2022-jp?B?UzNydlJVOUZlQkh5cjJMVk5RVXZrTGp2OGY5U1BaeWFQc3J2WXc5UFZS?=
 =?iso-2022-jp?B?VnBidjdYL0huTEtiSVFhdWdGRURuaTVTdDJjbkQzOHdoYjM2RTV1VHpv?=
 =?iso-2022-jp?B?c0JRKzJuN3hIYlQ1b1ZLV0NJOGd0WDBOYWJraE1tSS82ajM4SXdUcERN?=
 =?iso-2022-jp?B?SzlrTEpKSFpwbHVZTm1jaWlZaEpmZ1pRcFozbHNjMk5GYVNxSXM4MzV2?=
 =?iso-2022-jp?B?aUpLK29JZmo3RERHT1RHNFNXMTdqUURxT0hrWkJrREVUcTBiMnJpQVI4?=
 =?iso-2022-jp?B?dmk2TmdVT29QZkpndHY0MHNTV05HZUpWU0I2RkdlRlJqQTJqTXFzVkFl?=
 =?iso-2022-jp?B?Tk5pQlRDN0t6RzRNUHB5SFdhK2FNPQ==?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2183.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b0b45a3-b806-455f-f9cb-08d939dd878d
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2021 02:36:27.3610
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qYp6sqF4K3LEOW5u95ZcV+005sXpU4guMQnDFp364gVTaerY1fJIoFMEa2YW5ZeXf8Nb22nEFxOza8N3xVZ0EsJsFzTqBmGcJsJ1REIrJb8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB4934
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Frederic, Peter, and Mel=0A=
=0A=
> I tested this and confirmed that it gives accurate values.=0A=
> Also, task_sched_runtime () is done only on nohz_full CPU, so I think=0A=
> it's a better idea than before.=0A=
> I hope you will incorporate this fix into your mainline.=0A=
=0A=
I have also confirmed that CPUs other than nohz_full have very little overh=
ead.=0A=
Please consider merging it into the mainline.=0A=
=0A=
Thanks.=0A=
Hitomi Hasegawa=
