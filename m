Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 850303D0AD0
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 10:56:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236203AbhGUH6O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 03:58:14 -0400
Received: from esa15.fujitsucc.c3s2.iphmx.com ([68.232.156.107]:25286 "EHLO
        esa15.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237237AbhGUHve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 03:51:34 -0400
X-Greylist: delayed 459 seconds by postgrey-1.27 at vger.kernel.org; Wed, 21 Jul 2021 03:51:31 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1626856332; x=1658392332;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=VomIt7tZGaTqGtI2mwtfKkJEhVDN67OHNZr4EFT588c=;
  b=DSEKkVuZN+qoi3d8nOu3AAKejGrrE1vCJduOacJN57fgedZy8wbZpmZ2
   m94C+cOnbj5XQjKrYFWYxLy8HoHBDgW7SDdz61xOeyCLmUVHN6JfHjkLq
   Ye9xgJ7OW62JrduP8NVV4YhwXF7i86ThNculjHYs4Rltb5EJrC3vW90/y
   nQQxQwT4X+nUnNV43fA5Gq4u9i4nVRfGG7+GiK6ELhMHU+EWaKv3J8dvs
   K1uYrTPiKmRv6OfRUXuTeyaueImHzMxz5OcqWHxXK4QR56pUzsbutrU39
   Ix4kpQSfIW8lsNJILqVg91q02UuArO3plgaOIjX/oDvI3x7jvj72xhSVV
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10051"; a="35262267"
X-IronPort-AV: E=Sophos;i="5.84,257,1620658800"; 
   d="scan'208";a="35262267"
Received: from mail-os2jpn01lp2056.outbound.protection.outlook.com (HELO JPN01-OS2-obe.outbound.protection.outlook.com) ([104.47.92.56])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2021 17:24:08 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QSxHvkYjlhX5HpRIHliPj2DTtO4zvFiFJ40NvYTWjv6o/cTW6PAdLfCKHlxMWtkf7KccwH0Q2plkdZ6ohjXpZVul6zhzqwqTtRYlwz3JeqNlJDiUd79ms1k2JaVAM5qfStw57x25MCiXvV1BMIKdNAFcXXK5fiP4+uTPgikypL/5wa4+SAT2beQMNwkrxsDr7ngyXI8K4X/XgnW89hGkT911U67h5VtP+PU3+BbvXEK8CrZqdnt5EOFFJTomQKGCyrYs+dSiWcwPZLZsroRf9nwlYvEE/nangH3s3av4B5nmKFbORP068C/xCfCGf8OYlKMpsEarmCuccHTIIuhUZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VomIt7tZGaTqGtI2mwtfKkJEhVDN67OHNZr4EFT588c=;
 b=gwZtNNgCs8Ju0gg7HdXcuc0Mq2VlGuH+8/kfcbBj8+Tet+L6WDiexq521Z7Q7qJJ2rD07MSm10yP4GqWSNE7vHvCeLuQeLzDyqHA3uLy+U6KDraZsKlttfPYJwpcft/8VUrV/6Ow9uQRgcksn619jDejTu54/hshcqSz10Er78WZd/eCh1B72LhXtfOJMB3WbR0YOC8L8RoFZ92mYRX7X0bXAJJwdiJ0l2SiTE7TqhLgeHBMVL/R87krcdDizi+A+42a98nyd/yvQ0fd8wbqhZmotgqho8GaYOwv8JE56izqX5lp6Y5QLcTlygeyMZ+OJ4tB8Ss71FHxCEp42qtTyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VomIt7tZGaTqGtI2mwtfKkJEhVDN67OHNZr4EFT588c=;
 b=qSn+dxWncxhqeZ/5knyKeBvnyU3f4hUhWBiUmNhTOdUDuuNM4whsXfw56d068h7J8N+ddP0CVI3DHknbJZOg93hnHzu2FfEKbHOzBEfP5Lz0HIOsfCE1/g7FomiK0BeMWsRwksdzsEIRpWn1o0SQkoBVkENuH8PYguK2Z+XWtNM=
Received: from OSBPR01MB2183.jpnprd01.prod.outlook.com (2603:1096:603:22::14)
 by OS0PR01MB6148.jpnprd01.prod.outlook.com (2603:1096:604:b6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Wed, 21 Jul
 2021 08:24:04 +0000
Received: from OSBPR01MB2183.jpnprd01.prod.outlook.com
 ([fe80::3070:eecd:73b9:fbbb]) by OSBPR01MB2183.jpnprd01.prod.outlook.com
 ([fe80::3070:eecd:73b9:fbbb%6]) with mapi id 15.20.4331.034; Wed, 21 Jul 2021
 08:24:04 +0000
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
Thread-Index: AddG3PD5Dm9CD2RNQ7+TrQrb7bYc8AE2IspgAAJjxoAAIq+F+AARwywABYd9iwABIB9liwEkfn4KABmb7AAEd/XUBg==
Date:   Wed, 21 Jul 2021 08:24:04 +0000
Message-ID: <OSBPR01MB2183EDD7935603BDD26825D3EBE39@OSBPR01MB2183.jpnprd01.prod.outlook.com>
References: <OSBPR01MB21837C8931D90AE55AF4A955EB529@OSBPR01MB2183.jpnprd01.prod.outlook.com>
 <OSBPR01MB2183384B29F6291EB7C0BB81EB2C9@OSBPR01MB2183.jpnprd01.prod.outlook.com>
 <YKN5cQpFSdsgBlBU@hirez.programming.kicks-ass.net>
 <OSBPR01MB21835E55331FCAE6F75E8332EB2B9@OSBPR01MB2183.jpnprd01.prod.outlook.com>
 <YKTZag/E8AaOtVT0@hirez.programming.kicks-ass.net>
 <20210616125452.GE801071@lothringen>
 <OSBPR01MB21836F532CA384C7378C1284EB099@OSBPR01MB2183.jpnprd01.prod.outlook.com>
 <OSBPR01MB2183D3C6B2BBF25B22DD09FAEB039@OSBPR01MB2183.jpnprd01.prod.outlook.com>,<20210628141300.GA5710@lothringen>
In-Reply-To: <20210628141300.GA5710@lothringen>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=True;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2021-07-21T08:24:04.046Z;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard;
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c9513d0e-2d38-4520-e1d1-08d94c20e6e0
x-ms-traffictypediagnostic: OS0PR01MB6148:
x-microsoft-antispam-prvs: <OS0PR01MB6148A84666B972DE52F9CEFBEBE39@OS0PR01MB6148.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XlWzcR3fODHC63gZyGKy7JwtuoX9+Ual6/fdNG1rQHSEozq+GayU1043E0yi4W6qdl1VQ3efglMtd9cq830EIyNurxPPxIWxxu1LatZMstfKaPZZNgBBY/vdU7Bnbql/Hp1ECAHH/BtKzDHF8WPXtlHVCfSdx6fbsvvnBdw+kjO88IXlxul0RFNn8E453ujBqIwWAJyMhWbUGTb7rj7Yob+znU5trIu5xBIIZfDOTboi4TeZcH4CUyhrThgonmbgTp6aja5xvcOyh1okaT0XBiM3VFUOLdSW7DE3pPGAVuRtcHa6bU3bKJ2gzApVFKkpeur6G1l2zn+2OPmNTgtQjg9dpItAD/KUjATsLtfsaOSp1vtxnM0/PX6Q9WYh6X5bjhm9D5vLSV2VYSoYHRAtsEiUAG7/60WSocJpVxQdhSTn8s0EXeURvmM6Ev2ArzVPd4864YUcKU7qYAqVGr+R/ddAbDXlpCSQoPwgn5LEa9WQgJv9UifmZPc64ULd1MI9KyFdlXSk65cLYlQBtyjYy54DQfrYsTt0ALExgwICk/OH4MqUJEZFpkQHtzj/AYi3+rCWQ5/CXXGW4XX5UUsyzbr9K1ZByzvElc3P08P6vFMayoyrIPfoKZy/UmhMAeZyUAk50TZxSZdztfjI729ZAZA07gJD8ENL96N3y8if7k9Cf9ivk+ctClml9V7/H+9YyKmPlmaM0RjMlR7SZ0GWjj1kwNoIo64ASwaJB1HtTwk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB2183.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(366004)(346002)(39860400002)(376002)(2906002)(8936002)(5660300002)(7696005)(9686003)(8676002)(66946007)(71200400001)(86362001)(6506007)(52536014)(7416002)(54906003)(85182001)(4744005)(26005)(66476007)(478600001)(316002)(66446008)(76116006)(33656002)(110136005)(186003)(55016002)(4326008)(38100700002)(66556008)(83380400001)(64756008)(122000001)(491001)(38070700004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?TEFFYkt4UEpzb0ZEZzBVam42RDIrUWcrR0dQOXFxandDQU04RVorK1o2?=
 =?iso-2022-jp?B?dXhaZDVoTkxISm9URlRHUjk4TW1BS1kvOHVpRVFwT1huUWFtNXFKZzlK?=
 =?iso-2022-jp?B?MXlZUlZpYTBWZ0xSN2RBVmhFMmEyWDA5WGxKbjRiQisvWXcycWtYVEFw?=
 =?iso-2022-jp?B?Uy9XOE5nWVByLy9MVEkzVHFnMEpBVkp4SWdsZFlQYzRBdmUrZXJ2WktJ?=
 =?iso-2022-jp?B?bEZ5VGFZemRTMTQ5blRGZWM2SnlwdkxGYW15UXdWb2ZvN1Y1V2RwUThJ?=
 =?iso-2022-jp?B?ZElBODEzNXV2cFZZbGl4ZTl5UVBaRkpqL0RRSUZIYVFZbmM1S3dwU2I3?=
 =?iso-2022-jp?B?bnlOZnFra01PUTZmRUd6RjdLc3BPSW91d3dFajZIS1VNOTRjN3NuQ1RW?=
 =?iso-2022-jp?B?NUVpUGt1RysrZXVmWWNCeVVld2M0QVAwckFWckFrV1UvL0tkUC80Y1V5?=
 =?iso-2022-jp?B?RlI0Y3Q5b21ldlgvblZ0am1pV2gxWk5raWVrcTBHalp2MEthbU5xYjlD?=
 =?iso-2022-jp?B?Y09KOFo5RzVkUUxPbXFSRWRqeXlqd25lTDhhaHJTYmpBY3QzUEh2UU94?=
 =?iso-2022-jp?B?eWUxRHYva2d4YjJrOHdiWitoYzh4SElKSWw1R3F6OFJMekgza3ZuRm1D?=
 =?iso-2022-jp?B?TFhyS1Q0TGM3YUNuZVY5UDJTbGV6MkVCWXpzdUNDNjV0aHZpUjBuOTNp?=
 =?iso-2022-jp?B?aHlGRVV5RmhBcXI3REpTckNWME9Jb0RieDl1NHp2Qm9QQVRiRHIxQU9D?=
 =?iso-2022-jp?B?Z21PMFFCUFUyTzJnNHBWbDJmcDgraTY0Qnd2bGN4MjkvN05zVkJrdUp3?=
 =?iso-2022-jp?B?dmo0QTBOOGtoYzAySzIwV25KOW13UytjYUluMU9sTmEySkRYSUl3c3hH?=
 =?iso-2022-jp?B?QXZRR0R2ZHY0UWwwL2R2dXRuUWlQU3llU2V2SVpjTThabmlLMUVXL2RX?=
 =?iso-2022-jp?B?R2wwUm5wMkxJVGJ6RVFaZHFXWXN0bUh1UmlvRkNoajYzZ2JmT1BYQkV0?=
 =?iso-2022-jp?B?ckJlVVJuT3BDNTdDQnFBZCtWS2g1UXJJTlc5NHgvcm4zcE1GZ05FSFZS?=
 =?iso-2022-jp?B?VWF2WXdQa0h1ckw3NlJwZXhDK05YaHU0c3BNV3JnNFFVOXN3bzZQVUdh?=
 =?iso-2022-jp?B?dDJCRDE1ZGRIUmRKWDZDZFlQSU9jdWR4ZFN4QnhtdTBiVXErQk95azJu?=
 =?iso-2022-jp?B?SFJJK3l4YXFjUVlyZmhJeEZvQnFDdDVaRHQrTzFMeFFtMjRUVG1LNXh3?=
 =?iso-2022-jp?B?YjdyVVpoZVRBM29Vdzg0dTNibWJCZmdwZXRBbVdUUmNsempPbWlnNy82?=
 =?iso-2022-jp?B?VmdGSFJYT2JIY0IyN0dLRjNOQVQxT3MyZDZGbTJhU2EvQ1hjTHJqa1ll?=
 =?iso-2022-jp?B?MVMrZi9mQ2NhYTB2VnVVd21vajUxc2FxU0ZjY2kzS1NKNkk0S2tPQkdE?=
 =?iso-2022-jp?B?RXBMMHZ3eGNZZHlMbUc3bjdzd0hsVy94blgybUNFdXRmMlMwN2NZTFZX?=
 =?iso-2022-jp?B?V0RiUE9NS2ZNT2Z0SnF1NU02cVdIdDF6L0pHa2I5Sm9TRHVXUmtCZjdx?=
 =?iso-2022-jp?B?T3Ixa0hWMVNZNlIyV0ZLZHc3QjcralROckM5QTNvbVRwelYwcmFXcGUr?=
 =?iso-2022-jp?B?bTgrYkZScXJHVDF2VnJxQ21ZWENTcWZHcGdBNUk2UXU0YTBtZGFSMEVF?=
 =?iso-2022-jp?B?dXZRTXRVeDdQRlhZV3ByN3pRajFmaFVGS3RDelZXUFhRTWdZdmdxYmlj?=
 =?iso-2022-jp?B?U3NPR2xQK3AxWGtXTVBZUmFmVytBcUFuL2tpRG45V2dMK2NSVzRoTVJP?=
 =?iso-2022-jp?B?NU5DMkhmNjdzL2pEQjEzYmR5TkF4UzUxdGlQVHd1R2psVExxWThyem9v?=
 =?iso-2022-jp?B?S3QrR2VkVzl1WmM5d1hZZXhYZ2lvPQ==?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2183.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9513d0e-2d38-4520-e1d1-08d94c20e6e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2021 08:24:04.5088
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jXJgsECiHRzjY8TXBp6KXNTotGAUj24gQPeTda76xuLWoququCNqjFXd9XdNgY2/Z2LwbNvzEQXYMyWus043wlKsCFJZ7syEOWtkl6zLzRE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB6148
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Frederic=0A=
=0A=
> > I have also confirmed that CPUs other than nohz_full have very little o=
verhead.=0A=
> > Please consider merging it into the mainline.=0A=
> =0A=
> Ok, I'm going to submit a proper patch.=0A=
=0A=
I'm looking forward to posting your patch.=0A=
Do you have a specific plan? I would like to know the rough period=0A=
until this correction is made.=0A=
=0A=
Thanks.=0A=
Hitomi Hasegawa=
