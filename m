Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 573A63B8DD9
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 08:46:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234516AbhGAGtJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 02:49:09 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:42004 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S234257AbhGAGtH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 02:49:07 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1616gvSN024888;
        Thu, 1 Jul 2021 08:46:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=hnQnyIwW2WRVfx3tuDC/lRsggumzJKp3eJyByLmCBD0=;
 b=A+A53+zGrH0lEOdSl0kxG7Tygds4CCN4retJsASiB8yaAk7el+ltizxziLMZf72KOEYt
 OT8bcUvl7BvpOZm0IIGjUSOA3nJKgXB79X79VoB5RRNs/lw8btFRmEhCw43UFIE+xGTc
 a6LNXkjr047E03Jzdlg4P1Rd4VM7Wc8Y6yjTI4TQKwUyBh7Q+LG9oa5JaGEIRxVwLS15
 xZSIqyryfrwAHJar4Zi6NtaWRHACYE0Mz32FkIWVCmlzPc0LSP43vmpio/GX5okoByQq
 nMRQ4+dA5BKnfG9DiU71utCssBx9R53TotusncxuRidowtQX0lfgnnaVEGwGmLvoppB+ kg== 
Received: from eur05-vi1-obe.outbound.protection.outlook.com (mail-vi1eur05lp2174.outbound.protection.outlook.com [104.47.17.174])
        by mx07-00178001.pphosted.com with ESMTP id 39gnbptpx0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Jul 2021 08:46:21 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gjlAn+UZCbaf0u545GS2HSB3BI5G0hIGLbUhwPOLDV2NMmEU+y9MEAvV3FgNseLE5CDA6pphYmvQ5ugwCU2E833lwKlWvj8netbzeHVqgEM1V7EhiNRWrgsFYu9LG019ZsbVummriSJ16hgHDFJzOy4cdEaNXLNuy9FqRehxbj/V9jcJ7JNM/CAWZR3ADJStTayuj5/9dYr5zbZ/BzPHimvhucXDPxTCReASV6Hk2RCOMk+uqB+FrMUu18VUGd56GD+jIadNdYOHk2XDTwY7jlnuCt/v6OeQjNgXvTT8/+qmOIuH0O6MKXObPxSGKkTzWxTj2KGnMzE6MduCVPYQyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hnQnyIwW2WRVfx3tuDC/lRsggumzJKp3eJyByLmCBD0=;
 b=KITO/gbnjBFXYQuA5UGAcQtXywsNMHBrbmPr4anZD+RZCJgJ4KsVYWW9uwxP5O1JdoGP2qNEvKMnahSJYma62Pe0SO9eM4D+sxSGREmiHZErnTE4mBnxuBYvdUJifUdskrlxqNZ9HmwJ1VtfdxYbIszDoo+kln0rlKwSWEiZ1SZql7eIABOgSr3tkuL1wKqCydO3QVRtHrRlNz+kooB+Dv8hawqXIpXRR2h4XZyOvb9fVpjd4gin6gcQGrdY6fUT0HYE6o8ek9ZEJojXeNE6089GnfdEPDAStQu74+zrqPVxx/IutKrD2bNdqo8vcuky+qfbGnDAHn4MIiUM+Cu2Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=st.com; dmarc=pass action=none header.from=st.com; dkim=pass
 header.d=st.com; arc=none
Received: from AM8PR10MB4785.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:315::11)
 by AM0PR10MB1985.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:44::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.23; Thu, 1 Jul
 2021 06:46:20 +0000
Received: from AM8PR10MB4785.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2c30:4fb:ceb3:7a1e]) by AM8PR10MB4785.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2c30:4fb:ceb3:7a1e%4]) with mapi id 15.20.4287.022; Thu, 1 Jul 2021
 06:46:20 +0000
From:   Gabriel FERNANDEZ <gabriel.fernandez@st.com>
To:     Stephen Boyd <sboyd@kernel.org>,
        Dario Binacchi <dariobin@libero.it>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
CC:     Alexandre TORGUE - foss <alexandre.torgue@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: Re: [PATCH v2] clk: stm32f4: fix post divisor setup for I2S/SAI PLLs
Thread-Topic: [PATCH v2] clk: stm32f4: fix post divisor setup for I2S/SAI PLLs
Thread-Index: AQHXaHLZwL2Hd+JlqkypJ9Ld/bonWKss7NUAgADLV6E=
Date:   Thu, 1 Jul 2021 06:46:20 +0000
Message-ID: <AM8PR10MB4785545DC980090C1E7D66B281009@AM8PR10MB4785.EURPRD10.PROD.OUTLOOK.COM>
References: <20210623210039.19494-1-dariobin@libero.it>,<162507820040.3331010.117987763331641988@swboyd.mtv.corp.google.com>
In-Reply-To: <162507820040.3331010.117987763331641988@swboyd.mtv.corp.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=st.com;
x-originating-ip: [165.225.76.60]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9362fdf6-3dc0-4f30-4d08-08d93c5bef3c
x-ms-traffictypediagnostic: AM0PR10MB1985:
x-ld-processed: 75e027c9-20d5-47d5-b82f-77d7cd041e8f,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR10MB1985CC3E54656FAFAD910F9C81009@AM0PR10MB1985.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: c/QRWKYmCNENX+FZZIbnAbzMJ4+Y45dikfp3TvJis608F1bKJ5/PwWOqJtbIi7JiUMDhNfMgqsyCEQZeSBl6rCSX6iq7F2FupQCOHLfP7/INHYJn4PE22Jq5IWEHb/jNAMmMi0Sx3MoxIzVfGOvvsia9d5twVPN5Z/pswrHA/E9cmOujVxk1AYBk6AT2l65oUq6my6DziLf6W0WMnWdrnAVpAl/O6h/CZ2KrjHfKaHB3jrp9nZuOGedk+pa521FmsgqXClKbzfVbQh+z/Qw/IDV37HBXuXC/rU7y4GAlkBZGjx835KXZ7NBn9/6za9NeeSu46BWFiNedIFnaSWGnU9RN7VL9eRrN7DeK54JW31nDHpNR7y99n6bz9hvWdV6bknoHGHVhIWTwBQ5ORrOKuuokaFIzgambjUCwagJX41GoX8nNLnmNTx0JX/vHlDa4SWg5xf2Waz7v7Bd/zsnfXrf0LAGF0R/EoJVWTH675cA4Uq/9+UeMvwWTjeEt11PDPl5hM62TJTZZJj3WBNc9vyeY/M7M3XVPrWbj9Re2SsytUsZyxBJsDKS8LBIkvlnqZyhgMZJROcWs5UNCWCsCWQr3OTU6xrbg6670B+VZseRmG5+Cf1hlrJZhOS+p2MM5nz0E8DBNSVSa3byLXmwAcg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR10MB4785.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(346002)(376002)(366004)(136003)(33656002)(4326008)(55236004)(122000001)(55016002)(71200400001)(9686003)(7696005)(91956017)(5660300002)(316002)(54906003)(110136005)(478600001)(8676002)(26005)(8936002)(83380400001)(86362001)(53546011)(2906002)(186003)(52536014)(6506007)(66476007)(38100700002)(66446008)(64756008)(66946007)(76116006)(66556008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?7bERH+iW3oyJ2k4ZTr8GiYLzcgDT5k8rmZfoiP+P5boZFVcF/Pi2dmuxxa?=
 =?iso-8859-1?Q?yKVMo5Ip5CjF9NtcfW0ps26a9xat32pqdsjMQKJNHAT1PodkzGhVpTO8/q?=
 =?iso-8859-1?Q?6lJbx2Zv6J0D//bps1A+0XvlEJMCiXd2li10VWvYPLYWy63DNcyJ3Kphxn?=
 =?iso-8859-1?Q?wuV4kpIqH/AjzM7zHuv4hB7vNslH64moB7AvHnFCjJ1Vb4BS1sxLSN7LVl?=
 =?iso-8859-1?Q?gohYfYRBGGt/yczmSg+ZawY/ERMXX9nYPYFXJ4ntazsvkThBRSaZCEKbb0?=
 =?iso-8859-1?Q?AlguMbpKBfOmq7HkgsOnLNVhZQ6iSAVlKylsV+7eC8YeoiwGC2gfpCiZ4u?=
 =?iso-8859-1?Q?FPOdaqKJzLi6tkm53maCylmOLtDsR7+4D1AM/px170prmXMCCuTMcjyXEk?=
 =?iso-8859-1?Q?Dy6QGufmcvcm6CnpsjTjR8cJAPtAmi8orkhgZqqgo+S6tpdz40UMi4K80F?=
 =?iso-8859-1?Q?NG+ZNB2EUXcqhXUgwSgdnMM3oPEis2vCekktGnN6JtMNxyfqLQAndjeWSx?=
 =?iso-8859-1?Q?hmzA5gkPSnQtIYlf81MncX8tUKokq7URrd4LbSUpr8HWtenyqQ+go8cPmV?=
 =?iso-8859-1?Q?osEkjxV3upLRsR7oWngWoYgPfK4xyf/2vXkPqIXJsMDiDDsaDYuY1sRagS?=
 =?iso-8859-1?Q?/Zm6YLldPDqFIt0ezenGJVk4jqvhJdkG32tIj5xGbQLj5/9CIqGvzyJvD3?=
 =?iso-8859-1?Q?ArfVXIRLFUegw2yz5+uEUWgpyutHKs+frTwYd8rrP3ynHiQ66OrJ7Nl7z0?=
 =?iso-8859-1?Q?lC6iNAk2moClyMNkvDhDCh+v/QSW0xVEDccLtTvJe1gF4ixU4nIh8cmPGD?=
 =?iso-8859-1?Q?fJtdCPTGKvNd2vWWunR+rQx2TIVecb/X/IZPWTRi9WND1MoNMuIzN9G3ke?=
 =?iso-8859-1?Q?Vd7207jnuVyhU2RKVFHJPMoRJUawYLNsgChOF+2C+x2OwmjmrZxL2DIeyC?=
 =?iso-8859-1?Q?BiX0gDGhWXRlKFChcseOQeZp3rEUFhtIGyKzUlnaFlbXjLoTasLjl05qSU?=
 =?iso-8859-1?Q?3QbvEQ75eMC8iZVioejP3WiDX0TyPridv5X2YmWhJsoQQCohGiXNVVqtdw?=
 =?iso-8859-1?Q?2IJ38/WO9VCFYE+ViOV7624BA7PwFSl8RJiUcpuzn+soYDAKqyCJuDbqAn?=
 =?iso-8859-1?Q?xbehePVH4iImvOffrcWZCwnsnwU7GmLYFahKnkUkgeSUG2SiJjnZH4LTyh?=
 =?iso-8859-1?Q?8AIbOKGnlylQlndjXwgdEf3DRv+IaOHz6rwzC37J9vaRI7hXbz0GjG/mLV?=
 =?iso-8859-1?Q?pnegvzR4f05x3wvTQhNJjSHkKrjWy/Mhmkl4tsuS7Z0LszMNz2kvaMc+6d?=
 =?iso-8859-1?Q?M4QOA3IMgREgz/jzcfpz5HhVdznzvgmmuzfNTRKpj3d6pWg=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: ST.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR10MB4785.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 9362fdf6-3dc0-4f30-4d08-08d93c5bef3c
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2021 06:46:20.1549
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LyS2dz7E3DEod6yg4GU8jrCKwkV/G1A5/zGrrnlRRKfOSriB+qUvBZ8X1A9wGJBxrtqo4AtvZo43kzh3jtE94NsvkmvWk8SPnv0qe9aeWQU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB1985
X-Proofpoint-GUID: YMYPiUcrrNO8ASXIR8Tv4ensJjwZ3yOi
X-Proofpoint-ORIG-GUID: YMYPiUcrrNO8ASXIR8Tv4ensJjwZ3yOi
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-01_01:2021-06-30,2021-07-01 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 phishscore=0
 spamscore=0 adultscore=0 bulkscore=0 mlxlogscore=999 priorityscore=1501
 clxscore=1015 mlxscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2107010045
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,=0A=
it's ok for me, you can add my Reviewed-by: Gabriel Fernandez <gabriel.fern=
andez@st.com>=0A=
=0A=
Thank's=0A=
Gabriel=0A=
________________________________________=0A=
From: Stephen Boyd <sboyd@kernel.org>=0A=
Sent: Wednesday, June 30, 2021 8:36 PM=0A=
To: Dario Binacchi; linux-clk@vger.kernel.org=0A=
Cc: Dario Binacchi; Alexandre TORGUE - foss; Gabriel FERNANDEZ; Maxime Coqu=
elin; Michael Turquette; linux-arm-kernel@lists.infradead.org; linux-kernel=
@vger.kernel.org; linux-stm32@st-md-mailman.stormreply.com=0A=
Subject: Re: [PATCH v2] clk: stm32f4: fix post divisor setup for I2S/SAI PL=
Ls=0A=
=0A=
Quoting Dario Binacchi (2021-06-23 14:00:39)=0A=
> Enabling the framebuffer leads to a system hang. Running, as a debug=0A=
> hack, the store_pan() function in drivers/video/fbdev/core/fbsysfs.c=0A=
> without taking the console_lock, allows to see the crash backtrace on=0A=
> the serial line.=0A=
>=0A=
> ~ # echo 0 0 > /sys/class/graphics/fb0/pan=0A=
>=0A=
> [    9.719414] Unhandled exception: IPSR =3D 00000005 LR =3D fffffff1=0A=
> [    9.726937] CPU: 0 PID: 49 Comm: sh Not tainted 5.13.0-rc5 #9=0A=
> [    9.733008] Hardware name: STM32 (Device Tree Support)=0A=
> [    9.738296] PC is at clk_gate_is_enabled+0x0/0x28=0A=
> [    9.743426] LR is at stm32f4_pll_div_set_rate+0xf/0x38=0A=
> [    9.748857] pc : [<0011e4be>]    lr : [<0011f9e3>]    psr: 0100000b=0A=
> [    9.755373] sp : 00bc7be0  ip : 00000000  fp : 001f3ac4=0A=
> [    9.760812] r10: 002610d0  r9 : 01efe920  r8 : 00540560=0A=
> [    9.766269] r7 : 02e7ddb0  r6 : 0173eed8  r5 : 00000000  r4 : 004027c0=
=0A=
> [    9.773081] r3 : 0011e4bf  r2 : 02e7ddb0  r1 : 0173eed8  r0 : 1d3267b8=
=0A=
> [    9.779911] xPSR: 0100000b=0A=
> [    9.782719] CPU: 0 PID: 49 Comm: sh Not tainted 5.13.0-rc5 #9=0A=
> [    9.788791] Hardware name: STM32 (Device Tree Support)=0A=
> [    9.794120] [<0000afa1>] (unwind_backtrace) from [<0000a33f>] (show_st=
ack+0xb/0xc)=0A=
> [    9.802421] [<0000a33f>] (show_stack) from [<0000a8df>] (__invalid_ent=
ry+0x4b/0x4c)=0A=
>=0A=
> The `pll_num' field in the post_div_data configuration contained a wrong=
=0A=
> value which also referenced an uninitialized hardware clock when=0A=
> clk_register_pll_div() was called.=0A=
>=0A=
> Fixes: 517633ef630e ("clk: stm32f4: Add post divisor for I2S & SAI PLLs")=
=0A=
> Signed-off-by: Dario Binacchi <dariobin@libero.it>=0A=
>=0A=
> ---=0A=
=0A=
Can someone from ST review this? Gabriel or Alexandre?=0A=
=0A=
>=0A=
> Changes in v2:=0A=
> - Change  'u8 pll_num' from 'stm32f4_pll_post_div_data' structure into=0A=
>   'int pll_idx'.=0A=
>=0A=
>  drivers/clk/clk-stm32f4.c | 10 +++++-----=0A=
>  1 file changed, 5 insertions(+), 5 deletions(-)=0A=
>=0A=
> diff --git a/drivers/clk/clk-stm32f4.c b/drivers/clk/clk-stm32f4.c=0A=
> index 18117ce5ff85..5c75e3d906c2 100644=0A=
> --- a/drivers/clk/clk-stm32f4.c=0A=
> +++ b/drivers/clk/clk-stm32f4.c=0A=
> @@ -526,7 +526,7 @@ struct stm32f4_pll {=0A=
>=0A=
>  struct stm32f4_pll_post_div_data {=0A=
>         int idx;=0A=
> -       u8 pll_num;=0A=
> +       int pll_idx;=0A=
>         const char *name;=0A=
>         const char *parent;=0A=
>         u8 flag;=0A=
> @@ -557,13 +557,13 @@ static const struct clk_div_table post_divr_table[]=
 =3D {=0A=
>=0A=
>  #define MAX_POST_DIV 3=0A=
>  static const struct stm32f4_pll_post_div_data  post_div_data[MAX_POST_DI=
V] =3D {=0A=
> -       { CLK_I2SQ_PDIV, PLL_I2S, "plli2s-q-div", "plli2s-q",=0A=
> +       { CLK_I2SQ_PDIV, PLL_VCO_I2S, "plli2s-q-div", "plli2s-q",=0A=
>                 CLK_SET_RATE_PARENT, STM32F4_RCC_DCKCFGR, 0, 5, 0, NULL},=
=0A=
>=0A=
> -       { CLK_SAIQ_PDIV, PLL_SAI, "pllsai-q-div", "pllsai-q",=0A=
> +       { CLK_SAIQ_PDIV, PLL_VCO_SAI, "pllsai-q-div", "pllsai-q",=0A=
>                 CLK_SET_RATE_PARENT, STM32F4_RCC_DCKCFGR, 8, 5, 0, NULL }=
,=0A=
>=0A=
> -       { NO_IDX, PLL_SAI, "pllsai-r-div", "pllsai-r", CLK_SET_RATE_PAREN=
T,=0A=
> +       { NO_IDX, PLL_VCO_SAI, "pllsai-r-div", "pllsai-r", CLK_SET_RATE_P=
ARENT,=0A=
>                 STM32F4_RCC_DCKCFGR, 16, 2, 0, post_divr_table },=0A=
>  };=0A=
>=0A=
> @@ -1774,7 +1774,7 @@ static void __init stm32f4_rcc_init(struct device_n=
ode *np)=0A=
>                                 post_div->width,=0A=
>                                 post_div->flag_div,=0A=
>                                 post_div->div_table,=0A=
> -                               clks[post_div->pll_num],=0A=
> +                               clks[post_div->pll_idx],=0A=
>                                 &stm32f4_clk_lock);=0A=
>=0A=
>                 if (post_div->idx !=3D NO_IDX)=0A=
