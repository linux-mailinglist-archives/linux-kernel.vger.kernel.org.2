Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0579F3F9BE1
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 17:47:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244513AbhH0Ps2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 11:48:28 -0400
Received: from mail-vi1eur05on2062.outbound.protection.outlook.com ([40.107.21.62]:35232
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234232AbhH0Ps0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 11:48:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lHj6mpFu/4TVFSkZd90u7/zNGcTRLiZ86Xxno5P+NTxxS1xsdSMmWhNvD/0+djEBVf+Q2OABZKTkYEDaKdTJpfmypP0jOKz8Rk7u7G1mY3NFJMT8YGMC66pjqC6GDVFOP9Aq5JBqe8yL8GdsYHlAPoxxTCfWJtSGHSgqf3Ey83+0iLlj6V6j+s3kJ1uJ6uVGj6GPxV26Zvgv5DIR3njSwvdsUr1cCxhS8B5/j0DkQp6dRlnyIhvMMEyfw8p/PSLBAd/trlxdiEgUVQdD80B+O7B/LRjEmxbYtoTkuOmV4Dfvx9e1gfqSY7rC9VMXNgeeFPcC1Jg0d4ZYM+BD7QFLPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CrSmbPDjnqB3EYQazebnOskMUYCMZ3F7fN6uPKqqjQc=;
 b=eXKeIwNOnUm8KPJUqfhnalRHs1pMp9KNEZnL08JZc+5oKY9XgHBYecF3P7uGBsLYQkfEhgN9Th5nJRvsmJL1Dw3zpetmcWLyBzts2s+qavbp1mpzJu4fARN5gGk6jKA6XncZiL1mL3Djh6LEcqmCkCw0/CdL0YuPKpcUMiv+vxx8NBGCbNXQzKA8Jw95Knb3MoGE/pUoN+7CISFoGMt0SOTsX45qhChN2A5HlpFFANWwvjGKtKICkhZv/aEwE8mcdWuaNpCEt3VQthVEkqi3bWjsedfnW+5EBJ+37AGE5E4B88ThmQdTBZQDvpQ92i3jkuhzb9297rFpHO+ps8jCSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CrSmbPDjnqB3EYQazebnOskMUYCMZ3F7fN6uPKqqjQc=;
 b=fCXwA0jXwT9fPquvMCyCTa2t2XjhsBgXAhXgyvkka3fUKzPWGZFbg0RoWauO3jNHwqSiGege6gKRHL/wzIQ7nb2IPcbov8Yxh4go/FThQmsjQqCQ0suu4GtJozYS4e1ne+T53uU/RYEFQT4fyCfM/fRiAj+e5YOaCA1MoXzy7QI=
Received: from VI1PR04MB5136.eurprd04.prod.outlook.com (2603:10a6:803:55::19)
 by VI1PR0402MB2862.eurprd04.prod.outlook.com (2603:10a6:800:b6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.17; Fri, 27 Aug
 2021 15:47:34 +0000
Received: from VI1PR04MB5136.eurprd04.prod.outlook.com
 ([fe80::109:1995:3e6b:5bd0]) by VI1PR04MB5136.eurprd04.prod.outlook.com
 ([fe80::109:1995:3e6b:5bd0%2]) with mapi id 15.20.4436.027; Fri, 27 Aug 2021
 15:47:34 +0000
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
CC:     "kbuild@lists.01.org" <kbuild@lists.01.org>,
        "lkp@intel.com" <lkp@intel.com>,
        "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [kbuild] drivers/net/ethernet/mscc/ocelot_vsc7514.c:554
 ocelot_xtr_irq_handler() error: uninitialized symbol 'err'.
Thread-Topic: [kbuild] drivers/net/ethernet/mscc/ocelot_vsc7514.c:554
 ocelot_xtr_irq_handler() error: uninitialized symbol 'err'.
Thread-Index: AQHXmxIxxp8Lq1J80kCAsxoAermcaquHf46A
Date:   Fri, 27 Aug 2021 15:47:34 +0000
Message-ID: <20210827154733.ecd4viobsbfe3k7a@skbuf>
References: <202108271503.UUJHV4l5-lkp@intel.com>
In-Reply-To: <202108271503.UUJHV4l5-lkp@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 45e7968d-90dd-4848-0569-08d96971fd02
x-ms-traffictypediagnostic: VI1PR0402MB2862:
x-microsoft-antispam-prvs: <VI1PR0402MB286270E603CFF3786A8EFE79E0C89@VI1PR0402MB2862.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2Doz3oq1Hbqk+xyQx0UTb+OiAO3K5y7cK08e5Q6XGe1mHJx6z9jXVrWabcwMcaLfFeEQnZyeowmVsK6gyfGTsbVmsvrPy0X8rcWgbw9xnpih4lsVel3zGqGrNv2hY+L6vB99aV3WCpbkuaVFOldSg3+65tcgsDfWXkd6FFQXagUkLyWIpR3tiytT5P1VYkyFtR3HnyCyEPYd81uSkWt8/d3x6/DhCNvLXfxIZxOr8C9Bti68uhRx0IvYY8RjVI5uDejUOw9o3dLNhj/A7jYObBzgZ3OKfpQ7YehE4P18B2Jsw3fm2by4R721BBjK76q93iysjk/LBeyX4iC7WKUfDiwfJqbeEMWYAibzsmqdrLeuRfZUfcOmv1SX54OdkAZbVn5UfUUJa19D2uUQfAOoV6JQ5EyS8Dyh25z2wFHPlQYsSAJqydgL4d6bKnUiZFvczn7X5D2G4WJclXdCLMiRFUMvSNZiqKB53qHboiX+HGFib93hlk233o6ihr9dEcjCiCj5W3tCkGKl7HDZFzke8NNGfXxSW8M7nVMa80edPmH6Nhv1AZ2v1E6f1oPWl8A7Q2RfRqhzVPPAiUWviNuXHvzwseeGSwyC/fb24JPzSKFaLPoS/MHpnU/6feZ8Evu3v2dCPctdfYgn8fRQ9KtL5CDmo5YaZ+0gDfixaPh113NzCvbvVXRGKVDjwfvP4BVMC3TvqZ3/IjHOyTGorhjKLQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5136.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(4636009)(396003)(39860400002)(136003)(346002)(376002)(366004)(38100700002)(26005)(66946007)(5660300002)(8676002)(66476007)(54906003)(9686003)(71200400001)(64756008)(38070700005)(6486002)(66446008)(66556008)(6512007)(6506007)(122000001)(76116006)(1076003)(478600001)(186003)(44832011)(4326008)(8936002)(33716001)(316002)(2906002)(86362001)(4744005)(6916009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YOIiTunP2FAg28f1NJnYIgOUcINPpi/1QIg80LnT+IcQXAvXWOkGlKmw1JOb?=
 =?us-ascii?Q?KVWkHDazXRrv35Tnj5f44d9Jufmcy/ClVRWBPgad09lLNnUPXOCqVBY8QQS5?=
 =?us-ascii?Q?f9JsVyzJKR7vT/UlItDbow9fa702mowHghbtVUQ6iyLmtaecZYXl2gfjXBEb?=
 =?us-ascii?Q?eECExVO9VRq6YtbTzOtXNvH95FzN4kriotfwkVB7EWqehCE82RrzXPu590MG?=
 =?us-ascii?Q?fFnHqje4KnBBjBtBMBlyEIv258YoYWcmOVSisMCCvwiw2C/JLLoR6Gp6VQz7?=
 =?us-ascii?Q?t1Z8vkafzGK2H5R5xejafyZMfeNCBGCYzGWi8c78kMBwEGArUiiGDHMQVADm?=
 =?us-ascii?Q?ODDi0qW2w3/t39hf+zLXm96XVZyTDNtB8jsJDjAXe1NmDyd3zsfqxdtinOpN?=
 =?us-ascii?Q?rwZy7t+sfHwarERvKzo/fhJQwbLMS1D8IIclHx8A+9qXNK7drJNvhngbvBbi?=
 =?us-ascii?Q?IemF99RrTUN4kmkMe4AyLvsuyDq7I0u44ipChdDr60hI/Lz/9vLvlQosWETl?=
 =?us-ascii?Q?tPz/zT89VWu60g+RX6nxR6HvEGEpX1n23yoPg6MEq70V4ZZ3VcrJvW5s42Wz?=
 =?us-ascii?Q?vCrWZsQFCOrLlUjjkMJPzSSO67IcBJsDgSTYnkTfkkNFYN1VDTwpIMfubFFA?=
 =?us-ascii?Q?XOS/d9IOtvd8531iv08HD/vaF8E6o70qY23+9Nd2/Yb/5q/PhtDhgITs2kaL?=
 =?us-ascii?Q?+vBXvYLfW9ERznXwiTZLoxcZnUGQqWZR8hpCJ8ZEh4gG0Q3sBTdMT8GS/hP1?=
 =?us-ascii?Q?p9vIQolsuHCZGPr1ZNf04vhrLIGeg6QIPqUt6bKTw3yelZfu7xBMo6/8Eopy?=
 =?us-ascii?Q?/XwVSlVpQbxePRbMxaW+jfO/SDvdDEvI/KINmZQNHjPF3jRl6W9tmJ4SOe7z?=
 =?us-ascii?Q?viA5lcFGg5tYIWI+tekYRTOa0ujPwAN8tMPtsac2tsEkC3nkapY2DMdbVXEq?=
 =?us-ascii?Q?zvdP1hhFLQfspofwJ8iF/57Q6MtwOC5lGmTvEBh5PprJ716HsksGTatufiCv?=
 =?us-ascii?Q?RLq/Q3u3t0t+tYlZDAEcvPbufYczuX2LKzPSgjvPmKWYnU77Dmx7ido1LlwM?=
 =?us-ascii?Q?XNZ2Z8ax/9bE5kAWSvl1HHeAYLAUWkRvrCXZoN5dHsn8Z/cADf/arMqzGOGf?=
 =?us-ascii?Q?+nT1BOPQ9qKQ70xvui4k/V45r3xkfcrXxi8JbuVTyDsID1e+O1NMfSfPT9LH?=
 =?us-ascii?Q?gP1sT96c4ojeILMzE6U68rg1I3yJNgzRgS0S9+WpWoha1fcLdAylwOoB/JR1?=
 =?us-ascii?Q?Ox40UBFFUKAYBBdueqUZTbFJqnkgOG0OGnagn0MmejmimEAi2gKbNV3xP/ux?=
 =?us-ascii?Q?MKGuml43vI8ruNPu8S3IaC/S?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <687559FFC5A0EA42B8A0C7191A9F204D@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5136.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45e7968d-90dd-4848-0569-08d96971fd02
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2021 15:47:34.5555
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wu81rbpS0tuctwj3vBtSBqhqal7VwtnC1Fx9IlxcTt9a99uRZLgBzOVUnTurlXAORegm4Zc/Q5yyby8IsuhQiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB2862
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 27, 2021 at 10:06:42AM +0300, Dan Carpenter wrote:
> static irqreturn_t ocelot_xtr_irq_handler(int irq, void *arg)
> {
> 	struct ocelot *ocelot =3D arg;
> 	int grp =3D 0, err;
>
> 	while (ocelot_read(ocelot, QS_XTR_DATA_PRESENT) & BIT(grp)) {
>
> Can this condition be false on the first iteration through the loop?

Functionally speaking, no, but if it helps anyone to initialize "err"
with 0, I guess we could...
>
> 		struct sk_buff *skb;
>
> 		err =3D ocelot_xtr_poll_frame(ocelot, grp, &skb);
> 		if (err)
> 			goto out;
>
> 		skb->dev->stats.rx_bytes +=3D skb->len;
> 		skb->dev->stats.rx_packets++;
>
> 		if (!skb_defer_rx_timestamp(skb))
> 			netif_rx(skb);
> 	}
>
> out:
> 	if (err < 0)
> 		while (ocelot_read(ocelot, QS_XTR_DATA_PRESENT) & BIT(grp))
> 			ocelot_read_rix(ocelot, QS_XTR_RD, grp);
>
> 	return IRQ_HANDLED;
> }
