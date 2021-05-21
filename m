Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FB7B38C231
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 10:44:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233633AbhEUIpl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 04:45:41 -0400
Received: from mail-eopbgr10068.outbound.protection.outlook.com ([40.107.1.68]:55483
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230103AbhEUIpj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 04:45:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AidU8XGaNKH9/VbFO9tNoONb7/fVoN6T9i2yWowyJf1JEKM6jgishqnvpdX1+RfZmc9HdtLjOmakIPUbDtoDkJF6QtbzSfgwBsjB0WhCHcJv4Jug5StlgtZ+/3swZBtUttLlSuLBcjOX7IW/yyL5o4jAgLvcQ91bTue7p4FtwEQV3O8fdYmEsAQmTakwDlcqyduHf7g/ALbFYxcRCTk52MVVFaOkU0/CjqtFf+aAhveU0iGe3e2WL62zvmXQlq6fWxRV7Y2XikGF0xFEbKFt2MutlFA7jr0RTayD4pzP/hZXfot8jLvKW+STXtB0oIf22cu8NbFXXcxBtDV9D376rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=broGwxNwXnfpleURL8fgRw3s61cKBryW71vRh9Oyg78=;
 b=Q6XoaQqHgzy/41azvVS41z0qQEVJILqdFlZoKFcDJP6rLKfpCzn8gOYqhGnTrOKlQfAmoZdHK0U6/2K/2/4O2qJVubZ9UGqsYp3Fl+eK+6t3ds5tNfIawOcVRtq3QuTLicC42Usjsiy5L3Ffwkjy6WvgjKnt9SsyJbtMkn9tcPuwaXfpnV24R40cWwHLeD4JB2n7pM2t+4A6aqpps4aARL09kw9C/bNghoT4FofZsPUJEsXeZJCWSiSnd8eXLrouCkGWg+3meMrDDm2w2DZt3aZ8TqgyBl5RAwP9umLNcGR/yj5mww6xIgFOfwilo6D6JzZj61XDl3eIl8qHSHtc2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=diasemi.com; dmarc=pass action=none header.from=diasemi.com;
 dkim=pass header.d=diasemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=broGwxNwXnfpleURL8fgRw3s61cKBryW71vRh9Oyg78=;
 b=rTbzn8e/PeqeUjx2xBpHTMlWSe1tTb7iep0+lfBo8Yar0XOsOu8L2lzDEiVy2xjFWaeKycE4e8PpYNv+X70s6ptbp1OSqxUsHrNqE2XCdSYGGP/bt20phaOSdCqSBOKBKvNpad6Hs/qBjMXvOPWDj7/ikxAQZdJhaYwUdpYRrgk=
Received: from PR3PR10MB4142.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:ac::5)
 by PAXPR10MB4750.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:dc::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Fri, 21 May
 2021 08:44:12 +0000
Received: from PR3PR10MB4142.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c8ee:3efc:16a5:3d84]) by PR3PR10MB4142.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c8ee:3efc:16a5:3d84%3]) with mapi id 15.20.4129.035; Fri, 21 May 2021
 08:44:12 +0000
From:   Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Guenter Roeck <linux@roeck-us.net>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Subject: RE: [PATCH v2 1/1] usb: typec: tcpm: Use LE to CPU conversion when
 accessing msg->header
Thread-Topic: [PATCH v2 1/1] usb: typec: tcpm: Use LE to CPU conversion when
 accessing msg->header
Thread-Index: AQHXTJZF+W3sWXeUpUmHF3giSUjCIKrtoXiQ
Date:   Fri, 21 May 2021 08:44:12 +0000
Message-ID: <PR3PR10MB4142574B559A4452C99FB85A80299@PR3PR10MB4142.EURPRD10.PROD.OUTLOOK.COM>
References: <20210519100358.64018-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20210519100358.64018-1-andriy.shevchenko@linux.intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none
 header.from=diasemi.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [147.161.166.124]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e9914d47-2fc5-4561-df7e-08d91c349bcc
x-ms-traffictypediagnostic: PAXPR10MB4750:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PAXPR10MB475071D5A95CFA3FBB3B8A26A7299@PAXPR10MB4750.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hQaDvFuMDeWaHbgBVI32fQvJFEEh85q9EjoYt1r3THW4lf1+Pbb12yiZZAlSrfEXVeHW3imOB/a9vo71HjENMc5gDfVJyrMU1M9tIVPrl3Jdqaf6I1HePNZp6zVTyb4QG13+QmGeh1VVd/rHZItGyK2jE6e7yC4vkyEKlJMmM/qe4WOXR2MTxs8UPtTe691lhuJ2xYxnZVSUdsoy6Z5mWAnDuQlcQjVpCFXwBhRYA5zWkWXcZBJ477jX4YGNjF+PTOtjLgoEI4RYsPPlwnqOOEz5RADIkd3j+BNoeiwo5bJDL5otHw+pBKQSGSN8D1vao6uXDRk2XtdG7d7uFwUb9tDTyrTLmZCNYW2gYZ3oKDGx8CVFB2KOv+l5tEzxYo3CLaqyiE24wKPa/Gmpk8UTLWjvdl+wH3TJN4kAX8QblvKGRdP8HWKklhrhxQYw1VAjw5fg1plXBWYB64SYs0vkI8+oGJ9+NwLyhDjQJJJMB+g2846bNK2P2+EX1L8JBTC+DiczRbcoJ3cMvvl6cVxMpdHrYF1N9NmVOjkoFrA4Fa28aswYrEZhRCLJVMuhyIRJ1mGDu2UjzvWYg+hZcwD6whFGykWYW+sRyRPXeuqeaXY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR3PR10MB4142.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(136003)(366004)(376002)(39860400002)(52536014)(316002)(33656002)(122000001)(66556008)(5660300002)(71200400001)(86362001)(107886003)(64756008)(66476007)(66946007)(66446008)(38100700002)(83380400001)(9686003)(76116006)(7696005)(26005)(55016002)(110136005)(8676002)(478600001)(186003)(4326008)(6506007)(54906003)(2906002)(8936002)(53546011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?P2x4BgobSBn/Mew+MC2P/TwFTuVEbVvuRGL2PXPbRN+GPJugogamycvW297i?=
 =?us-ascii?Q?HKIT09skKeQsJSMwQ9yQP5F4SSl0JfdKvzLYITjpoSgSjOLTpISORROB5++C?=
 =?us-ascii?Q?pJ8JZUHniz4bIiSIvehuzyHK5cGf89fSWVlI7PkxYd2SFTAYYHZ1Gsv9OEzx?=
 =?us-ascii?Q?b6uGMmmAFDtKjd3rDAs6yzoRsSmI3vNmofk3NsbT1N/YyL36cXheGZsHLffT?=
 =?us-ascii?Q?FCnIbphXTDLZRNr6TgQ+4wAIgQPkLePd3kX7wOw1zUvNSU3rQFt5w3ro0U+5?=
 =?us-ascii?Q?OUP0SneVRRVxlLmsIt+y5DZQy71o+e0BVC0WbkpHMZWA+d4qT5+lx8NDHUyn?=
 =?us-ascii?Q?JUeSpAtGDeV/3wKzjDvq5/vSPSPW/gc69m52K4MVBbK5Br2dNOnXuKPBb7YX?=
 =?us-ascii?Q?KVqgXBextBdXoqBojkbQ6aZ02FEAGblXPykBb2KI8zowNxKYtwJUZZ1dKx7U?=
 =?us-ascii?Q?Pz6/dW26YHYamm9A4KpBAA5o7mLRT6DAtr2LIR3mHxFG/fkmMfwmp3oGGu7r?=
 =?us-ascii?Q?isVsjV5QgTTxipm7UgUDaADJxLrQSZ1ps4NHeEjxvYl0u1fGTbTb3HvK0WyP?=
 =?us-ascii?Q?hVKx+EdbOBBL+KYamurhjcVcwhWPhIed2BtGsYM+H6HRS5D4Ny8Z9BBjEzFU?=
 =?us-ascii?Q?ZPAgB6D1GE0nF1sxc4QV9ylMiR/t/iHaun3JBId+Kas8mpwB8FmSYgWL2+rZ?=
 =?us-ascii?Q?0PW8mRznm3ncH0qSYPs6wbDpgONgCI06snorNVP/maFGTj9Z0J7dBC5XdJsE?=
 =?us-ascii?Q?2qzTgQOSQSCrEHmVZiX2NgP/oY+3vsDFj7ALYvpKvcAcWhvA80JQ+5UYoshz?=
 =?us-ascii?Q?zsbxE3z6/PQBRAaZ0l96Ta4OzWViAw0Xs1HLCd3tLxTyoY7rCXF/ZIpaVFHe?=
 =?us-ascii?Q?cCLxXhAM2Zl457dBlPEQQDGonPsbwqWXybpi+kwxNx4ea04sPkunLD7Nc6n2?=
 =?us-ascii?Q?6OLf83gwWcrgXGi6H6oCoZqVKCScJgdL3U1POLjEUfYqSjYXESvw8dAiSb/c?=
 =?us-ascii?Q?fB9KIsMRXPS1KZ7OfSmlAjrGGeBrFveHOdEX7jjJonzjY1livaIKNPheDXt3?=
 =?us-ascii?Q?Azcteow7vFMR6+7OPL+rFFS3vChY5tGy9rXr9+syygBZt++Uhe/Z4ZukAv9q?=
 =?us-ascii?Q?bNrF/pkpdnvshyWIiZJ8ctq/XpvSt0s1IZZK1Zf2+j/n4ILbPPNSYPPC9qXh?=
 =?us-ascii?Q?oK6x2zvtA1lTel4KHlk57Y98yhFuptsTAHu0zYy6VVdIIFCFooag7Zbq7/Lu?=
 =?us-ascii?Q?zksjI+CEKdK7aJWZcpOrpNy10ja4pqnq1GtuMgRpgB5sLIndrUpmiPKzU47b?=
 =?us-ascii?Q?lEtsPirsJ39Zco3j11bDB5i3?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PR3PR10MB4142.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: e9914d47-2fc5-4561-df7e-08d91c349bcc
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2021 08:44:12.6452
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Eum4G4n8FRs6QqzhxM6bNuLwzlCOxVenV80ig3QrgoZ9B8Zb8ftQrl6W3kysa8FcuVgDBbbS7So1t4Nvrg0q1WQiJtPjQYcsJECFpg/Iz1w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB4750
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19 May 2021 11:04, Andy Shevchenko wrote:

> Sparse is not happy about strict type handling:
>   .../typec/tcpm/tcpm.c:2720:27: warning: restricted __le16 degrades to i=
nteger
>   .../typec/tcpm/tcpm.c:2814:32: warning: restricted __le16 degrades to i=
nteger
>=20
> Fix this by converting LE to CPU before use.
>=20
> Fixes: ae8a2ca8a221 ("usb: typec: Group all TCPCI/TCPM code together")
> Fixes: 64f7c494a3c0 ("typec: tcpm: Add support for sink PPS related messa=
ges")
> Cc: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>

> ---
> v2: fixed subject prefix
>  drivers/usb/typec/tcpm/tcpm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.=
c
> index 64133e586c64..8fdfd7f65ad7 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -2717,7 +2717,7 @@ static void tcpm_pd_ext_msg_request(struct
> tcpm_port *port,
>  	enum pd_ext_msg_type type =3D pd_header_type_le(msg->header);
>  	unsigned int data_size =3D pd_ext_header_data_size_le(msg-
> >ext_msg.header);
>=20
> -	if (!(msg->ext_msg.header & PD_EXT_HDR_CHUNKED)) {
> +	if (!(le16_to_cpu(msg->ext_msg.header) & PD_EXT_HDR_CHUNKED)) {
>  		tcpm_pd_handle_msg(port, PD_MSG_CTRL_NOT_SUPP,
> NONE_AMS);
>  		tcpm_log(port, "Unchunked extended messages unsupported");
>  		return;
> @@ -2811,7 +2811,7 @@ static void tcpm_pd_rx_handler(struct kthread_work
> *work)
>  				 "Data role mismatch, initiating error recovery");
>  			tcpm_set_state(port, ERROR_RECOVERY, 0);
>  		} else {
> -			if (msg->header & PD_HEADER_EXT_HDR)
> +			if (le16_to_cpu(msg->header) & PD_HEADER_EXT_HDR)
>  				tcpm_pd_ext_msg_request(port, msg);
>  			else if (cnt)
>  				tcpm_pd_data_request(port, msg);
> --
> 2.30.2

