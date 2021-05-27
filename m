Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 292473923DB
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 02:37:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234760AbhE0Aie (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 20:38:34 -0400
Received: from mail-eopbgr50074.outbound.protection.outlook.com ([40.107.5.74]:1193
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234403AbhE0Aie (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 20:38:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YTNn8CyfG1e56GvQR79/a8mabo1dPnfV1ocQ1SxVwmtFSlzfSc8ZInHW/sKIho5VLc4Sh4VTS5XrPhVLAXR8cjHqci69V5PM1vaRtYZ9jtwBD1WVuwT5MgO9LGrW776/y55FAztk3b8Weyyrv1m1FC3o1nxYPERTcnkDcaz7KSrEPkwydzFFZOAjBD5sdU+NvdhQGnFXLZNujLxeCMgAcl5nzZX6opa5WKuqz22MQiVlOEn+ZIQyMh5ReVKkFi1Mkl7OJ39X+jgWHSXbNM/FU6C5NfKYwrspLuRNop0T6V30Q9xb8OsL+/18w5iwgdREBQ9pCj57o2GCf2hMwtE9xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5LXeoQuAInYo+Nu3TsbcYvcxd7YNefxQmptIEKQy3hk=;
 b=RXguevvha0SVumPKtNI8zd/X1CW9UYCIW2FdrgoLF5ds0YbMN6XMdGhPzIOPZYeRToalSNYvUiRynNkOjDdEfI3S219iVF41b0Fe62y/24STy3WG49/9TG7l9r22NpBKyhE8zj71CivNnTJXYml5f74OF4gDV1VoHMiKVPoWpIL3twWQlrEKLPk89/23YUX93hzny/dssuNUI1uu/lsJZeJPg07TOmuaTR2Yu/8V7cbChdvFEU554+qASHy+zRUBAPrQkPt4ISP5oZ0/Y0hUvhfehN89KbnSviYvNTQ9wIIKBdaWbu9SX1N3Y+1L68BIo/UlBOITWexl6uh87fp3Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5LXeoQuAInYo+Nu3TsbcYvcxd7YNefxQmptIEKQy3hk=;
 b=eVdpRVQJ5ivu4AlrZjLpH+/Dy+Smu0twr0uq9eUwpIFOLNY2eYyVpn4bdO8mRzRJc4O/i15pwynhoaFmmqq49smxKqz31UJsPp7+onGLEKgKPamOy5NAZk23ZMNA6W4sm+gnnWTRPTPU1R+aqEWLr9QS/OXiL6C7DQFcsH9amXc=
Authentication-Results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=oss.nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB8PR04MB7178.eurprd04.prod.outlook.com (2603:10a6:10:12e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.22; Thu, 27 May
 2021 00:36:59 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64%8]) with mapi id 15.20.4150.027; Thu, 27 May 2021
 00:36:57 +0000
Subject: Re: [PATCH 2/4] mailbox: imx: replace the xTR/xRR array with single
 register
To:     Daniel Baluta <daniel.baluta@gmail.com>
Cc:     Jassi Brar <jassisinghbrar@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Devicetree List <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peng Fan <peng.fan@nxp.com>
References: <20210507101926.25631-1-peng.fan@oss.nxp.com>
 <20210507101926.25631-3-peng.fan@oss.nxp.com>
 <CAEnQRZB25yt7NxUMD22FsuhcOBryo8NS3kJ20xsb0hOvAc10og@mail.gmail.com>
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Message-ID: <3c8e3b3d-70d4-a94e-63dd-eac7cd5054ae@oss.nxp.com>
Date:   Thu, 27 May 2021 08:36:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
In-Reply-To: <CAEnQRZB25yt7NxUMD22FsuhcOBryo8NS3kJ20xsb0hOvAc10og@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [180.106.142.87]
X-ClientProxiedBy: HK2PR02CA0175.apcprd02.prod.outlook.com
 (2603:1096:201:21::11) To DB6PR0402MB2760.eurprd04.prod.outlook.com
 (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.109] (180.106.142.87) by HK2PR02CA0175.apcprd02.prod.outlook.com (2603:1096:201:21::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend Transport; Thu, 27 May 2021 00:36:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 908f84a4-7a1f-4e2e-9c9b-08d920a78877
X-MS-TrafficTypeDiagnostic: DB8PR04MB7178:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB8PR04MB717858048A2DA9528260C034C9239@DB8PR04MB7178.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VrjTjRx1EZnQ5UwJWrJm52+gcYq5HZdi9hUig8dltm7gPfhS3lYSAYPixK9VxYVsf1g7/CqHnSSwq16KcEMEL1POX6siR5kvcVXFTaQFUske7Gm9BxDAMy/elm9F/BZmaEQ43alEvVcz/9F5pxjdYS2qm90maTGuJ5kFsB0XE3Gp0F1yx3+g15SFYKLDc/DWoVb80K3krcOk8k+r7Mk27yGi6CfQ48hdhRLImgSG6zbHB4wgTw8h71709rmAVhEoDFC71WVqFzKG5GkqMY7lGM3WCNFZMUEWlm42/Z4RNZKOqVVCgG1t0pPC2GnYHLUMRRppcNfDoJCxPq3XNle/EJPWQPWdD5g5pDj/Wkly5hgcje0znYtDmsUlm2PAWb+9GXLTLmEvXTgE0GtER7e8PGKNayxbF4oL3NCpCO9sLPCaq23GwEIwMmLgRpItE2oLIjCrF0WnY5DXjuwTJ18pztHDoiUjwCkb756+HG2WG4AHY+0Zixp+Qf6FkOLaqen7FakjJ7bePO/mF+fCt5QCiiV7p0kVP/V+JELDPWE1T1STkq50MuMGf1oiApeyEgCYlpLKxcxoJ40Ho47VDT+ZxxdnCEfeTTzlPyjhrynO3E/BBJtntp/4CWdIRrBRlGt4169su7luzqQwMLr/kK5ScGroFHUCznwHL1IiIUQV+pBvM6Jz2dHxinYfmYcm8QdyRGOm4iwX3Q0qF3ZApXF60Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(136003)(346002)(396003)(366004)(186003)(6486002)(31696002)(2616005)(956004)(16526019)(478600001)(7416002)(6916009)(83380400001)(66556008)(38100700002)(8676002)(86362001)(66946007)(66476007)(53546011)(15650500001)(38350700002)(52116002)(8936002)(54906003)(6666004)(2906002)(316002)(16576012)(31686004)(5660300002)(26005)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?M0JyelI1N0FBMlp0Mzk1QTJDSHBvZlh2MWZHcjBUVUlvQ3FzZzJiaXIzSHhz?=
 =?utf-8?B?NGNJSlBDbVdRdkZzOHQwSk5FSzZTNG9RV3YyUVpuRWhRSVU3KzZVRm1xMEhJ?=
 =?utf-8?B?bmRGSDZYSk1lWXF6SW5uTUVOdmJSRGFwL3B4Y1BWemZNTThHOEZPZUpwcFdq?=
 =?utf-8?B?TjUzdEV0UlhWZ2RXUnRGMHdCRDVBU1NYNmowUC9FeFFCdEpqOTNlZlpHMHI4?=
 =?utf-8?B?WURiWmlCVXU2amZUbnNjMGdjNnhjMk93bFIxRVJIbUQ4V3hOTWtDSnY4QWti?=
 =?utf-8?B?Zkh5bXpaSEk2a04rTUhhT2xYeWJ6c2trV2g0eXA2US9hYmd3TmVubVRnQmhY?=
 =?utf-8?B?T1I3eGNJK2F5MGhabjcvOGV1ai9jTUc0VldXNjBTWnNLdU02YjRleW5BZjF1?=
 =?utf-8?B?aHk2ckJxSTZtZUxkemRnL09iYVRZaEszV3R3QmhRcEducFo0RUxCWURQQ2hN?=
 =?utf-8?B?bDFkUDRnaXQ4NGNoRThmSE5CZHBaUHNIQmJFY1czYUFnL3RpVTg0WEVKcVVY?=
 =?utf-8?B?MU9sSnI2MFhxK0h1M1ZLb0JYWHdKalJ5b1h1aUxDelFMYkxPbHdzeGx0YzdP?=
 =?utf-8?B?L2IrT1d4UmZWQzNiSEI4ODM2eTYyaFVoYzRtM3pCMERTWjRjbUJyTW92UEo2?=
 =?utf-8?B?cFhGQVhiaHFkWnFaZGtZeTQ1b3RnUzk5emVLOWJOUWlWZTZkQTNsQTBiVFNE?=
 =?utf-8?B?MFNkMnBSbkw4ZVVWTStSeWZCZEJsOXg2Q2ZGYnhFUkdUdHVOYzArdUU1RUdp?=
 =?utf-8?B?ZElLN1pXRGdIaC81QkxjNERTNmY3dmdtZTJDTXBESThhNlYzWWNLTG1UaHJs?=
 =?utf-8?B?bXdVRStwZWdxMjQ2a3VJQVNEWnhqZlFDbXBPR2FwQjZzOUw1Z0pUU0llNGIy?=
 =?utf-8?B?UkdqMktTNUI4QTlWcXJGNEJQend0cWtxVEN3OHE5YWN3WUFwbDhhVmtLSDNh?=
 =?utf-8?B?YVFGZldQOW1OS0xDQWNoODJLeTlsUzFrZVNPU1hWcjJQTUM5SVJ5SSsvUyt1?=
 =?utf-8?B?dHR6em42ajhTQXl1d1I4dHorVVJwN09FWS9zZGZzM3dhZW9INStlaHNSVHdl?=
 =?utf-8?B?WmlETmcyalVRUnAyS0NRTlpSUHRKSmxCa3cxQi9icE1reW9HYllPVHpWTVRs?=
 =?utf-8?B?Z3hKaTFvUXpKa3B4anp3M2NWNUlOYzA0ZldoYUZ2RUFIT1VNak5RZnQxR0E3?=
 =?utf-8?B?N3VoVTlXY3pXRGZ1RHJCNkltS3lMeWFSbGowOWVuYWlOajhTRG5PeDRCSlZD?=
 =?utf-8?B?QnZwcVlQMklpbHY5bjZxajEvS3FoeUxUcENZaExGQktRU081QmpybndNbzdF?=
 =?utf-8?B?VFFLbUtabVFNVXNJdnIvSi82RHprMEk3QUsvZURMeGtmWVdFTzZZMENEeGs1?=
 =?utf-8?B?RE9HRDEvK0lMNWpha05ZL3RGRTMyR1lZeTZ6RDY2bC92YWtjVEtBdC83bmxm?=
 =?utf-8?B?bENaR29mdS9DTzZRbWtleDU1UzZoYnZLR3lueThjWFF4UnlabjZ5Ukg5Nm81?=
 =?utf-8?B?ZFRMQmZoVDNSY3Z2cmVUaGxPQWFpa3N0QnJhZ3lDS2NqY2I0Q3EwVUZtRjhD?=
 =?utf-8?B?OW96cVUvZFVSTGJZZlpURmpnWlpqMjBiQW4wSnFsbzdTTWJxWXNJWXRvZXdT?=
 =?utf-8?B?VXRiTG9TSE5hbXliQXVSSWxUVzV6cTVscFdCZlZjUml2aU05aldkelpiZ3RF?=
 =?utf-8?B?QjExbUdYN0tVb3ExblBjeTlMRFdseVJ3dDhpUG41N0RhK1NBb3NDZktIZmR6?=
 =?utf-8?Q?U4HBHAVTPQJB+fSKYTdchM0WH1K3UHOP6lPSOjY?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 908f84a4-7a1f-4e2e-9c9b-08d920a78877
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2021 00:36:57.6350
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wax+rYiTc69chn65/rn59pM/k4qdnDhcA+zQ6LBMedlcmXB8ohi+kfVdTDkP5btw4R/JiDJtR41T3pDRS5DeOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7178
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/5/26 14:58, Daniel Baluta wrote:
> On Fri, May 7, 2021 at 3:33 PM Peng Fan (OSS) <peng.fan@oss.nxp.com> wrote:
>>
>> From: Peng Fan <peng.fan@nxp.com>
>>
>> The xTR/xRR registers are using 4 bytes stride and continuous.
>> Considering we will support more TR and RR registers, use base + idx * 4
>> method to calculate register address, not hardcoding in driver.
>>
> Peng, this means that for imx8ul the Tx registers are not continuous
> right? Please make this clear in
> the commit message.

It is continuous, it support more than 4 registers, so we use idx * 4 to
calculate the address, not hardcoding in an array as before.

Thanks,
Peng.

> 
>> Signed-off-by: Peng Fan <peng.fan@nxp.com>
>> ---
>>   drivers/mailbox/imx-mailbox.c | 28 ++++++++++++++--------------
>>   1 file changed, 14 insertions(+), 14 deletions(-)
>>
>> diff --git a/drivers/mailbox/imx-mailbox.c b/drivers/mailbox/imx-mailbox.c
>> index 2543c7b6948b..bd7758c32a80 100644
>> --- a/drivers/mailbox/imx-mailbox.c
>> +++ b/drivers/mailbox/imx-mailbox.c
>> @@ -76,8 +76,8 @@ struct imx_mu_dcfg {
>>          int (*tx)(struct imx_mu_priv *priv, struct imx_mu_con_priv *cp, void *data);
>>          int (*rx)(struct imx_mu_priv *priv, struct imx_mu_con_priv *cp);
>>          void (*init)(struct imx_mu_priv *priv);
>> -       u32     xTR[4];         /* Transmit Registers */
>> -       u32     xRR[4];         /* Receive Registers */
>> +       u32     xTR;            /* Transmit Register0 */
>> +       u32     xRR;            /* Receive Register0 */
>>          u32     xSR;            /* Status Register */
>>          u32     xCR;            /* Control Register */
>>   };
>> @@ -120,7 +120,7 @@ static int imx_mu_generic_tx(struct imx_mu_priv *priv,
>>
>>          switch (cp->type) {
>>          case IMX_MU_TYPE_TX:
>> -               imx_mu_write(priv, *arg, priv->dcfg->xTR[cp->idx]);
>> +               imx_mu_write(priv, *arg, priv->dcfg->xTR + cp->idx * 4);
>>                  imx_mu_xcr_rmw(priv, IMX_MU_xCR_TIEn(cp->idx), 0);
>>                  break;
>>          case IMX_MU_TYPE_TXDB:
>> @@ -140,7 +140,7 @@ static int imx_mu_generic_rx(struct imx_mu_priv *priv,
>>   {
>>          u32 dat;
>>
>> -       dat = imx_mu_read(priv, priv->dcfg->xRR[cp->idx]);
>> +       dat = imx_mu_read(priv, priv->dcfg->xRR + (cp->idx) * 4);
>>          mbox_chan_received_data(cp->chan, (void *)&dat);
>>
>>          return 0;
>> @@ -172,7 +172,7 @@ static int imx_mu_scu_tx(struct imx_mu_priv *priv,
>>                  }
>>
>>                  for (i = 0; i < 4 && i < msg->hdr.size; i++)
>> -                       imx_mu_write(priv, *arg++, priv->dcfg->xTR[i % 4]);
>> +                       imx_mu_write(priv, *arg++, priv->dcfg->xTR + (i % 4) * 4);
>>                  for (; i < msg->hdr.size; i++) {
>>                          ret = readl_poll_timeout(priv->base + priv->dcfg->xSR,
>>                                                   xsr,
>> @@ -182,7 +182,7 @@ static int imx_mu_scu_tx(struct imx_mu_priv *priv,
>>                                  dev_err(priv->dev, "Send data index: %d timeout\n", i);
>>                                  return ret;
>>                          }
>> -                       imx_mu_write(priv, *arg++, priv->dcfg->xTR[i % 4]);
>> +                       imx_mu_write(priv, *arg++, priv->dcfg->xTR + (i % 4) * 4);
>>                  }
>>
>>                  imx_mu_xcr_rmw(priv, IMX_MU_xCR_TIEn(cp->idx), 0);
>> @@ -204,7 +204,7 @@ static int imx_mu_scu_rx(struct imx_mu_priv *priv,
>>          u32 xsr;
>>
>>          imx_mu_xcr_rmw(priv, 0, IMX_MU_xCR_RIEn(0));
>> -       *data++ = imx_mu_read(priv, priv->dcfg->xRR[0]);
>> +       *data++ = imx_mu_read(priv, priv->dcfg->xRR);
>>
>>          if (msg.hdr.size > sizeof(msg) / 4) {
>>                  dev_err(priv->dev, "Maximal message size (%zu bytes) exceeded on RX; got: %i bytes\n", sizeof(msg), msg.hdr.size << 2);
>> @@ -218,7 +218,7 @@ static int imx_mu_scu_rx(struct imx_mu_priv *priv,
>>                          dev_err(priv->dev, "timeout read idx %d\n", i);
>>                          return ret;
>>                  }
>> -               *data++ = imx_mu_read(priv, priv->dcfg->xRR[i % 4]);
>> +               *data++ = imx_mu_read(priv, priv->dcfg->xRR + (i % 4) * 4);
>>          }
>>
>>          imx_mu_xcr_rmw(priv, IMX_MU_xCR_RIEn(0), 0);
>> @@ -564,8 +564,8 @@ static const struct imx_mu_dcfg imx_mu_cfg_imx6sx = {
>>          .tx     = imx_mu_generic_tx,
>>          .rx     = imx_mu_generic_rx,
>>          .init   = imx_mu_init_generic,
>> -       .xTR    = {0x0, 0x4, 0x8, 0xc},
>> -       .xRR    = {0x10, 0x14, 0x18, 0x1c},
>> +       .xTR    = 0x0,
>> +       .xRR    = 0x10,
>>          .xSR    = 0x20,
>>          .xCR    = 0x24,
>>   };
>> @@ -574,8 +574,8 @@ static const struct imx_mu_dcfg imx_mu_cfg_imx7ulp = {
>>          .tx     = imx_mu_generic_tx,
>>          .rx     = imx_mu_generic_rx,
>>          .init   = imx_mu_init_generic,
>> -       .xTR    = {0x20, 0x24, 0x28, 0x2c},
>> -       .xRR    = {0x40, 0x44, 0x48, 0x4c},
>> +       .xTR    = 0x20,
>> +       .xRR    = 0x40,
>>          .xSR    = 0x60,
>>          .xCR    = 0x64,
>>   };
>> @@ -584,8 +584,8 @@ static const struct imx_mu_dcfg imx_mu_cfg_imx8_scu = {
>>          .tx     = imx_mu_scu_tx,
>>          .rx     = imx_mu_scu_rx,
>>          .init   = imx_mu_init_scu,
>> -       .xTR    = {0x0, 0x4, 0x8, 0xc},
>> -       .xRR    = {0x10, 0x14, 0x18, 0x1c},
>> +       .xTR    = 0x0
>> +       .xRR    = 0x10
>>          .xSR    = 0x20,
>>          .xCR    = 0x24,
>>   };
>> --
>> 2.30.0
>>
