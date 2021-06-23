Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E5773B13ED
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 08:28:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbhFWGa3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 02:30:29 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:29786 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229801AbhFWGa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 02:30:27 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15N6RiD6031528;
        Wed, 23 Jun 2021 08:27:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=xmyPUIi92Z4q76xLZizFlQTJEPz2aMebOJAFbFlMNtw=;
 b=Eo55PIQCVf6aNeCOmknUwDYm9ZCLFw6OZ6YiPsMzM9VSyut3JQXm4wU5knnLRAAcvPmp
 Xl8bMsUM1Sov+0OgwGMB8i/u++X2xOnURnoaV68OBRPRUJuL0dTxsuyi+WlzCzksOsdG
 IYptIeLtPVtHhfHQpvdwykMFaeKiUWkPnKKmfBPkVfe5BkzajgKQWCkZrnnIcKCf2qyJ
 ZMcgcBZ6OfIxcLh8/vnnVuzM4Vc+PAZ3ahJthghbNMxZu0V5N7777eZq52mf5UBM+9lE
 WS1NiJOlKhk3+VbQbrsMtd9a0s3ho+9gDiO/bwlPbeHb3ztpLZn7LZLzpb6jfra8gh6/ tQ== 
Received: from eur04-db3-obe.outbound.protection.outlook.com (mail-db3eur04lp2052.outbound.protection.outlook.com [104.47.12.52])
        by mx07-00178001.pphosted.com with ESMTP id 39bbyvx5p4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Jun 2021 08:27:55 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ejyHv5hOL+h/8oEXgPMT4GycEYIvktvXnnQUhUomz6r7X1dV2pSsBYnwLcIsn32VLGA5r5qUcoY+E/V+8nLjYCENAfKhOhkc9yOo206TIS9aL+MofaIBIz9qvJ8CtqOs2b5RIuzN9NnB14Y3w92Q1YGeec8ICWBTUFNbngekyPsIruRvmPzbdvTcOeIvM/XBRC8yP1viMuyZSVAThtAOuzJbdKiHjsWcN9BkiomaQoB+6i+Cyx8WhofgLh8ygsvTvJxICJ/u9Sk51HCjNiB3FqLxkPr5tj4GZasXheDwGjCxfh7GAMckKWGVaTOVUdORvXX3f5SgvqD+xzkWdvKtyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xmyPUIi92Z4q76xLZizFlQTJEPz2aMebOJAFbFlMNtw=;
 b=YL4vFBU4Zqu3EL+aUAOzq16scuXEQn8TUBpFML5ZuYbf8nlwOabsoiAjrjU6hs9CCZX6tkFrND0K5smyhB4pf2LbRImy+wdfQeQ4yYo0jjF0K0rZePqq8249euVWVQ+RsIxPBBVpyp4g5jkOSpbVqTHDBwuyA+WbcJdJfLI5bJB57B+ebWZXLBEdZPKxSF29tjiezwR8ylDwwomjStmO/+Ll+92Bg6xdQD5ZNzmUeRlte2lbx18gp9pR4fAlFPpE/7UvDejz2Dskta5uweFTT3XPMM8TkH+peLtATccL7H6pPrhlq2AdukS7Y5hChUtAbQUDqSW1Y8deXd6HI+s3ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=st.com; dmarc=pass action=none header.from=st.com; dkim=pass
 header.d=st.com; arc=none
Received: from AM8PR10MB4785.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:315::11)
 by AM8PR10MB4260.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1ed::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18; Wed, 23 Jun
 2021 06:27:54 +0000
Received: from AM8PR10MB4785.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7c24:3471:b4a1:351b]) by AM8PR10MB4785.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7c24:3471:b4a1:351b%8]) with mapi id 15.20.4264.018; Wed, 23 Jun 2021
 06:27:54 +0000
From:   Gabriel FERNANDEZ <gabriel.fernandez@st.com>
To:     Dario Binacchi <dariobin@libero.it>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
CC:     Alexandre TORGUE - foss <alexandre.torgue@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        Gabriel FERNANDEZ - foss <gabriel.fernandez@foss.st.com>
Subject: Re: [PATCH] clk: stm32f4: fix post divisor setup for I2S/SAI PLLs
Thread-Topic: [PATCH] clk: stm32f4: fix post divisor setup for I2S/SAI PLLs
Thread-Index: AQHXZ6uOCktfUfYWYk2+Yi5wSfjGMashH4G3
Date:   Wed, 23 Jun 2021 06:27:54 +0000
Message-ID: <AM8PR10MB47856D4CA879CD0230ED171081089@AM8PR10MB4785.EURPRD10.PROD.OUTLOOK.COM>
References: <20210622211401.25604-1-dariobin@libero.it>
In-Reply-To: <20210622211401.25604-1-dariobin@libero.it>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_cf8c7287-838c-46dd-b281-b1140229e67a_Enabled=True;MSIP_Label_cf8c7287-838c-46dd-b281-b1140229e67a_SiteId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;MSIP_Label_cf8c7287-838c-46dd-b281-b1140229e67a_SetDate=2021-06-23T06:27:53.817Z;MSIP_Label_cf8c7287-838c-46dd-b281-b1140229e67a_Name=None
 (Unclassified);MSIP_Label_cf8c7287-838c-46dd-b281-b1140229e67a_ContentBits=0;MSIP_Label_cf8c7287-838c-46dd-b281-b1140229e67a_Method=Privileged;
authentication-results: libero.it; dkim=none (message not signed)
 header.d=none;libero.it; dmarc=none action=none header.from=st.com;
x-originating-ip: [165.225.76.160]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 383e584a-1536-455a-c47f-08d9361008e2
x-ms-traffictypediagnostic: AM8PR10MB4260:
x-ld-processed: 75e027c9-20d5-47d5-b82f-77d7cd041e8f,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM8PR10MB4260B9B564CD0B6502C8C33781089@AM8PR10MB4260.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +QnItE3Mf0/83UHgCg9j5DKrsoF7a6knkTkN2050ImjqEg52t+rfn3y5M9YomYiOntUuoTpe2BIotzrbkUkkwyT74W4DTQAZAlf2dlhkNqDUgZqQzxZJOK1qfznF5zAblKluNJ9XpYjOH3ZtanScerQgHaajoZSSxSCAbsSUB3NOgKKhlIKxJhLDXp3nH/SZmxPO8ovVClokzAoUAf2xxEUiR+mMqC8Rugp8qF4t2b2EGZ6bbcko1W808Ybe5I+iJw5hS1voahDffzr09kEM2gJCYQ3eDG6E7cErau9diu9P/CnLgYONdr8uildQah9Z5lR6i8KHh7OvEylmWtoChaJE5oAxWYeHm7EI7k/i98T5PvCOXX7Vf3liE0bTFL6td/jKktHy3T0dOEEzbxAJnM6EOBeaEv5rasRjYp7+B6ujuREqsjVVe3j/5eh197SFLK88gVP0tAZx8EEaGb3sdELJR+4wFmmd2VeXCFPf1eSCkhMB8/IosBW0CYh5yNfyoTU0kz8Xiaw2xWqj358hnbo8YdD/3tgEvLcrsgLsE8psAZq+nlLByjGGEAlVcK+m+SOAhg9EJ6RXZbRNMOQZZ06hHkf0e6V1ik5xem0XRJQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR10MB4785.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(396003)(346002)(366004)(39860400002)(83380400001)(6506007)(26005)(53546011)(55236004)(186003)(7696005)(55016002)(33656002)(9686003)(4326008)(478600001)(122000001)(38100700002)(8676002)(316002)(110136005)(8936002)(71200400001)(91956017)(76116006)(54906003)(66476007)(66946007)(66556008)(64756008)(66446008)(52536014)(2906002)(5660300002)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?8/zoVvipa06MCpYGo6Q8kcP9ExxvSaAF5FRijsePozPOryXHQlmIOyEN2p?=
 =?iso-8859-1?Q?spzQM64CguPiqHS/03OO3aM00yIffSQPThUV6rGfgb/bIdr4/gxuc4QdrM?=
 =?iso-8859-1?Q?gH0fwAdU8/UROHOJXad+wCMJY0L4Cm22uh6E+xICERWR7CITxoyDCMcZp5?=
 =?iso-8859-1?Q?kChbanq60ZKu9l+7+9Rw3Gsvi6Uu5FhQ1NRZK3+dlX0wEZLMB/zWY5OaBI?=
 =?iso-8859-1?Q?skYKJyrcRa/32IJE9EM3MrIUM16iLy1NAOZt5S12qo4XwlPmpojhyU1I2g?=
 =?iso-8859-1?Q?zqOhBM0dyCw0ChWcjSWeWxz0AAMtjt6Eh1mf+QZPINLNGuIaL1CZsbSbUv?=
 =?iso-8859-1?Q?urwyS8t/M0UEFyhONzNzOKAUbL9vQJRgCqGDhyHQy33CXEUJii8C+1lwWZ?=
 =?iso-8859-1?Q?qNZX17DyEFwvadUhPXN7sJhJ1ZqLI89XOem5WESOPNYmjczbqCfC7uL9xo?=
 =?iso-8859-1?Q?51Dh24zwj3BMe/fc6qTem5cgYiUCd2kZ2odOwzrxctVDdPD+6hed7jJF68?=
 =?iso-8859-1?Q?0ZEvz8LnKCYX1p4xojlz7v9tPIZlcvLELlkUSNOzufp4ceLLY/+h6ladDC?=
 =?iso-8859-1?Q?aAeS7iHjDhYV43eEVkHQGv/kh7ekI6X/uLGvzgmb1zwDxOAWeufoxgclZu?=
 =?iso-8859-1?Q?lrArDVlwtJWLmhALYl0M9imc5yTgHVI78JeBM17f1+DhWffEXjaAaeW+Bw?=
 =?iso-8859-1?Q?NxARY8yc7mw3GJQU27tN9cVPPWBDV3POrADGxW3F1Aq7sXQqrasHnlzQGc?=
 =?iso-8859-1?Q?GJUmomhUGpA9aIzwp+NibVdcbpzpr3+OPhQ9qFxmo7I4SVpdztERlBp6hf?=
 =?iso-8859-1?Q?Obb1G/ajQGT+rughSMVtwAN5gjwXwYoyipU+G9g4XJAm9FdmidmqUcRt7v?=
 =?iso-8859-1?Q?rWcR5xICw+i/j/krWLCQC9ytgM3TTJJRRy3oSv2D5737aECIFSt/ZuirBq?=
 =?iso-8859-1?Q?ZCjbsQsDD0w17hmXAWw9wevGTb7ZLbgszEz7HTQhAa+uy9waAQ0Mdi/Gmy?=
 =?iso-8859-1?Q?iu/i/fRy8xBsqYYlGlKyacBlkmMZRZfNlZfq3+h1hLBBpUfnM1WHEZoYyv?=
 =?iso-8859-1?Q?Hsm5MJ7TAgpeWaTrYg0TzA2DhgLkeX6KjONrI5ouguHESWvFb7NMf1T0v2?=
 =?iso-8859-1?Q?+dFEYexHITm0i50M8TMymAC1ZL5FoXsbKciaOwnEDsR8AAZDGa2KVMr8oa?=
 =?iso-8859-1?Q?nyjJuMbPmIuohch2tjM7jycQ7DUA792mdzzyU4vteoihgGdI6AwRnwn7fY?=
 =?iso-8859-1?Q?9mzuiCx7mS3FnLiL5u5WRzaQiHdCy5xFtieYoCl8qQbPlrUEdLMxuZ41EW?=
 =?iso-8859-1?Q?tmnRAScxhB5hX0ao3hdgHBeX5XdnnKr1mGo1Wzk3okriOp8=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: ST.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR10MB4785.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 383e584a-1536-455a-c47f-08d9361008e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2021 06:27:54.4867
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 88zTWxzTSkTYKIKTZPUyYsnPoZkU7Qfr3wsxCgazQfdpYrEqXmChkXHKFut50po16ceGyqS5OOnPlyeDNBm/QnVmZqcNNDIfJwovAHYxM0M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR10MB4260
X-Proofpoint-GUID: mv7eMhpvIqvu4qj6q_Z_Fr-ea8fZdYOo
X-Proofpoint-ORIG-GUID: mv7eMhpvIqvu4qj6q_Z_Fr-ea8fZdYOo
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-23_02:2021-06-22,2021-06-23 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1011 priorityscore=1501
 suspectscore=0 malwarescore=0 impostorscore=0 mlxscore=0 phishscore=0
 spamscore=0 adultscore=0 bulkscore=0 mlxlogscore=999 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106230037
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=0A=
Hi Dario,=0A=
=0A=
I agree with your analyse. =0A=
You have to change also 'u8 pll_num' from 'stm32f4_pll_post_div_data' struc=
ture into 'int pll_idx' =0A=
or something like that.=0A=
Many Thanks !=0A=
Gabriel=0A=
=0A=
=0A=
From: Dario Binacchi <dariobin@libero.it>=0A=
Sent: Tuesday, June 22, 2021 11:14 PM=0A=
To: linux-clk@vger.kernel.org <linux-clk@vger.kernel.org>=0A=
Cc: Dario Binacchi <dariobin@libero.it>; Alexandre TORGUE - foss <alexandre=
.torgue@foss.st.com>; Gabriel FERNANDEZ <gabriel.fernandez@st.com>; Maxime =
Coquelin <mcoquelin.stm32@gmail.com>; Michael Turquette <mturquette@baylibr=
e.com>; Stephen Boyd <sboyd@kernel.org>; linux-arm-kernel@lists.infradead.o=
rg <linux-arm-kernel@lists.infradead.org>; linux-kernel@vger.kernel.org <li=
nux-kernel@vger.kernel.org>; linux-stm32@st-md-mailman.stormreply.com <linu=
x-stm32@st-md-mailman.stormreply.com>=0A=
Subject: [PATCH] clk: stm32f4: fix post divisor setup for I2S/SAI PLLs =0A=
=A0=0A=
Enabling the framebuffer leads to a system hang. Running, as a debug=0A=
hack, the store_pan() function in drivers/video/fbdev/core/fbsysfs.c=0A=
without taking the console_lock, allows to see the crash backtrace on=0A=
the serial line.=0A=
=0A=
~ # echo 0 0 > /sys/class/graphics/fb0/pan=0A=
=0A=
[=A0=A0=A0 9.719414] Unhandled exception: IPSR =3D 00000005 LR =3D fffffff1=
=0A=
[=A0=A0=A0 9.726937] CPU: 0 PID: 49 Comm: sh Not tainted 5.13.0-rc5 #9=0A=
[=A0=A0=A0 9.733008] Hardware name: STM32 (Device Tree Support)=0A=
[=A0=A0=A0 9.738296] PC is at clk_gate_is_enabled+0x0/0x28=0A=
[=A0=A0=A0 9.743426] LR is at stm32f4_pll_div_set_rate+0xf/0x38=0A=
[=A0=A0=A0 9.748857] pc : [<0011e4be>]=A0=A0=A0 lr : [<0011f9e3>]=A0=A0=A0 =
psr: 0100000b=0A=
[=A0=A0=A0 9.755373] sp : 00bc7be0=A0 ip : 00000000=A0 fp : 001f3ac4=0A=
[=A0=A0=A0 9.760812] r10: 002610d0=A0 r9 : 01efe920=A0 r8 : 00540560=0A=
[=A0=A0=A0 9.766269] r7 : 02e7ddb0=A0 r6 : 0173eed8=A0 r5 : 00000000=A0 r4 =
: 004027c0=0A=
[=A0=A0=A0 9.773081] r3 : 0011e4bf=A0 r2 : 02e7ddb0=A0 r1 : 0173eed8=A0 r0 =
: 1d3267b8=0A=
[=A0=A0=A0 9.779911] xPSR: 0100000b=0A=
[=A0=A0=A0 9.782719] CPU: 0 PID: 49 Comm: sh Not tainted 5.13.0-rc5 #9=0A=
[=A0=A0=A0 9.788791] Hardware name: STM32 (Device Tree Support)=0A=
[=A0=A0=A0 9.794120] [<0000afa1>] (unwind_backtrace) from [<0000a33f>] (sho=
w_stack+0xb/0xc)=0A=
[=A0=A0=A0 9.802421] [<0000a33f>] (show_stack) from [<0000a8df>] (__invalid=
_entry+0x4b/0x4c)=0A=
=0A=
The `pll_num' field in the post_div_data configuration contained a wrong=0A=
value which also referenced an uninitialized hardware clock when=0A=
clk_register_pll_div() was called.=0A=
=0A=
Fixes: 517633ef630e ("clk: stm32f4: Add post divisor for I2S & SAI PLLs")=
=0A=
Signed-off-by: Dario Binacchi <dariobin@libero.it>=0A=
=0A=
---=0A=
=0A=
=A0drivers/clk/clk-stm32f4.c | 6 +++---=0A=
=A01 file changed, 3 insertions(+), 3 deletions(-)=0A=
=0A=
diff --git a/drivers/clk/clk-stm32f4.c b/drivers/clk/clk-stm32f4.c=0A=
index 18117ce5ff85..42ca2dd86aea 100644=0A=
--- a/drivers/clk/clk-stm32f4.c=0A=
+++ b/drivers/clk/clk-stm32f4.c=0A=
@@ -557,13 +557,13 @@ static const struct clk_div_table post_divr_table[] =
=3D {=0A=
=A0=0A=
=A0#define MAX_POST_DIV 3=0A=
=A0static const struct stm32f4_pll_post_div_data=A0 post_div_data[MAX_POST_=
DIV] =3D {=0A=
-=A0=A0=A0=A0=A0=A0 { CLK_I2SQ_PDIV, PLL_I2S, "plli2s-q-div", "plli2s-q",=
=0A=
+=A0=A0=A0=A0=A0=A0 { CLK_I2SQ_PDIV, PLL_VCO_I2S, "plli2s-q-div", "plli2s-q=
",=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 CLK_SET_RATE_PARENT, STM32=
F4_RCC_DCKCFGR, 0, 5, 0, NULL},=0A=
=A0=0A=
-=A0=A0=A0=A0=A0=A0 { CLK_SAIQ_PDIV, PLL_SAI, "pllsai-q-div", "pllsai-q",=
=0A=
+=A0=A0=A0=A0=A0=A0 { CLK_SAIQ_PDIV, PLL_VCO_SAI, "pllsai-q-div", "pllsai-q=
",=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 CLK_SET_RATE_PARENT, STM32=
F4_RCC_DCKCFGR, 8, 5, 0, NULL },=0A=
=A0=0A=
-=A0=A0=A0=A0=A0=A0 { NO_IDX, PLL_SAI, "pllsai-r-div", "pllsai-r", CLK_SET_=
RATE_PARENT,=0A=
+=A0=A0=A0=A0=A0=A0 { NO_IDX, PLL_VCO_SAI, "pllsai-r-div", "pllsai-r", CLK_=
SET_RATE_PARENT,=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 STM32F4_RCC_DCKCFGR, 16, 2=
, 0, post_divr_table },=0A=
=A0};=0A=
=A0=0A=
-- =0A=
2.17.1=0A=
