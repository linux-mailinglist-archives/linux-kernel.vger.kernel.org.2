Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA8C9306696
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 22:44:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235774AbhA0Vni (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 16:43:38 -0500
Received: from mail-co1nam11on2134.outbound.protection.outlook.com ([40.107.220.134]:20865
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235579AbhA0Vdk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 16:33:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jom9wT7cq+ORuQP6Fxmk5Kv3R3bM57s9jdT1+58CDO/mOha52Y/2KYLNhKpkr5voQgZ5Wc5Qs6rjc8cWJUrAT10LSU0k4p2+W8bZPWD2qDFXR2YQNpES0d54mAj+aF+W2rGZQn5tUsLts/POz6HabhxyOgUTJfpZwBxSMOY7M9o1oYMk4gJLS7TMlBSUWCx+JOBTQhKdTS1GlX0IMJbHI6cAgDSxWzr/FtcW2oIs9XQC1B8sjBkYEqfPtyAYHTrRyuysxxHP+RzIhnrpjT+65kQ423SGyiZRpDRkLYTj15OUmNXQhqWpozy8DLImb/hDK5nChDTs0HRHiP3wbumSaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PcVaB2HXisPlfifQVPR/jOH3RVQOIP4THOw70Ghjems=;
 b=cu9rTS3LHKzxQtOMKbxVRf1FI3CnT3YC6V6BmK9GjDxziQBPPVSV0MLw+HHOeWS2RKagynoFywMMrhQTAM7ZPXA/KZEEJDOTH+UJmpcpt5D/m8V74WKqmNxPsoDd1uKj+iQwKdj8ZeF1S0PIRyunDofaZLfj57VCAqtNGntkLfTGNkLy9vhyV5DdL5wWPrPhhbf7Vb5GNwTyoRgAqgEy2ZJp74uloLItVrcDLMYfZX7rMByGcx6gvZKX7WXq7511nCBMeEUk9FOx/q8gNJV6Ycqzvf7UbSc4IGB/L5UBc2VfVhFQSieR1deWnwWo7QoBZN7eQD/RXhCgIqgSkhBJ9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PcVaB2HXisPlfifQVPR/jOH3RVQOIP4THOw70Ghjems=;
 b=RWbyg746gIargMjAAwiD3mvaONOEPgHaTT/EobDIi8CkUR5z47p7MqUTYtwEQewfN7Ea4Ur8+vnhfcBGbCxXgXkA5eegN6b+koPT1oot3pNCMqxnmxjJjG7osHFFZldHLzYIL/SyfCjfX/Y5+T0VC8lZH8OdQslUs1rBV7JEwsU=
Received: from (2603:10b6:301:7c::11) by
 MWHPR21MB0157.namprd21.prod.outlook.com (2603:10b6:300:78::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3825.4; Wed, 27 Jan 2021 21:32:52 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::9c8:94c9:faf1:17c2]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::9c8:94c9:faf1:17c2%9]) with mapi id 15.20.3825.003; Wed, 27 Jan 2021
 21:32:52 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     John Ogness <john.ogness@linutronix.de>,
        Petr Mladek <pmladek@suse.com>
CC:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH printk-rework 10/12] hv: synchronize kmsg_dumper
Thread-Topic: [PATCH printk-rework 10/12] hv: synchronize kmsg_dumper
Thread-Index: AQHW9F252dQj+rE1lUm0s6QqITWwRKo7/bVQ
Date:   Wed, 27 Jan 2021 21:32:52 +0000
Message-ID: <MWHPR21MB1593C37614E7F1334EB0AA7FD7BB9@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <20210126211551.26536-1-john.ogness@linutronix.de>
 <20210126211551.26536-11-john.ogness@linutronix.de>
In-Reply-To: <20210126211551.26536-11-john.ogness@linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-01-27T21:32:50Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=e43fff33-6593-401c-b660-b963e89c7fdb;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: linutronix.de; dkim=none (message not signed)
 header.d=none;linutronix.de; dmarc=none action=none
 header.from=microsoft.com;
x-originating-ip: [66.75.126.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 24be4b7e-bb6a-4d7f-deba-08d8c30b1a17
x-ms-traffictypediagnostic: MWHPR21MB0157:
x-microsoft-antispam-prvs: <MWHPR21MB0157F65F85B8EABC27352E8DD7BB9@MWHPR21MB0157.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: C2Y21zBJuYmwUJ/zrGhjqxsN/HrpR2ikBdgjnd4GuQhUQ4vUn6/FR4ctBmodwLU5dVClf3gOH+vJ8aDV8CaxqyyYv3ydm8+7xU0Ui45lU3uBbqtNwLIg4c/M6fAppuQcsxGoNGtr2XTPgirU3JXffRHxgRs2UMPDgR+labRvw5GWp43RHwAXlkfhRfbbVf1gkqdg/d5aNamJ0q3dfpj5ZTDwUtI3utvAfW56NoYGpeT6ryUrjV7zOVOCUGW7Hjli0odlp5r3N0zZOGcF/tI9SVfzMdDEe+Glsqh82Q53xtCkEMxIzmg4HyiJLT40opGGppDiOnK49ZH2A2yMWdojIWY84qj7BlJj9jORfUElixGKlXLX1k2YYwCodwgGo+Q3wLHza/DKttvxHo639HsGsD+Dlg8UfV58mWHTxo2CxupPNbI578V56FDDWeAiP6iiRJH28CiGIQOGwt72wjGNncpy4DRsYmS/q1LhSR9XzwmJZaln3XrABLP1IfkX/tTPYCAdmp1BvvFV0kEUXSj9HA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(346002)(376002)(366004)(136003)(54906003)(86362001)(7696005)(8990500004)(83380400001)(10290500003)(110136005)(82960400001)(82950400001)(33656002)(4326008)(5660300002)(26005)(186003)(55016002)(71200400001)(8676002)(66476007)(316002)(66446008)(66946007)(66556008)(6506007)(8936002)(52536014)(64756008)(2906002)(478600001)(76116006)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?4CmO6E0LT0D41bzvOywm+YDhCMhKCNvwRzczCZQ51JkdQMoymaRq55geKxkX?=
 =?us-ascii?Q?K+BqVR26ZYIzAfcPJ16sgl9u2KvihxXsoBdMaJoJuAOuKxW/J2bmakmWCtSN?=
 =?us-ascii?Q?+U8N9htH1+s5zxXi8Ov7GXGfeoh3zXw9vb0kB+3CvsJLRX1f+Ma8t2G64fg5?=
 =?us-ascii?Q?Top8/kExN8wZiDNcCy7Ug5K2aQnHjYRcdqIFIT5Ck2YsQR1QWGgtGh+89pHx?=
 =?us-ascii?Q?gWu5PZiKQ1J0BROo1ZduCV6JQc4x2fmLdEZidvA3+u2ha8p7BiF1yySXDPdf?=
 =?us-ascii?Q?efLZGNBGrninsxffWi/Sk27/cxIWACNGDSNEJ485vZyujOCJCfb0KctPuHBW?=
 =?us-ascii?Q?QTTKbqCibwqcepJ9aaErfcRMADuLy0Xfqiwn18uyqi99Uw8jH/ap6nZpf+Nu?=
 =?us-ascii?Q?S+KWk3W+LDolTBfy97547cN9JNRJ3LPBDlcbh+BSxgvExtq6hDH9h66Z6lj0?=
 =?us-ascii?Q?+Y/O1x2o5KckQV2bfHMeNTv7V+ZFU9hQgdnaobefkC2TS/5HfSdJ0AMWJkRF?=
 =?us-ascii?Q?XFLqy6K4nFqS9BHZ7hjbxoUEXPtOc4y+U861yvX8MYsZghzjLqTI/ok3eV/f?=
 =?us-ascii?Q?LfjQj+ZMHBSnScXigaO6IduJ3ltxr9Rf9zop/9u2G6F1qN50S8+t8kVnqexr?=
 =?us-ascii?Q?WHlvv1e+zkGYb1vWpHmpeudQAyjydKP5bgLAKpiiGqhdl+TRFXJmbm0+3FHl?=
 =?us-ascii?Q?KTaskgxrW9vVIc7HFgeuurt/nqFv8j7T0mXWbn0Nk9Y2gDPOA1//fU30E2tC?=
 =?us-ascii?Q?xk0TIJYUADIESjB8exts9pe1sxIhiwqQQVA8yTaYGiEAWIUcMI6+Ouc/ytQM?=
 =?us-ascii?Q?hW4BdNUU8KTZHOIPglPv+rwvjv1dzpRSA0x5zI4xi07XzeapglngNL0Ug4mt?=
 =?us-ascii?Q?BgqIXlkdh+h++5+m5cjVbjJrn7srrgPkR+f2iEZeajpXkbeYFWe75mvxaZ1+?=
 =?us-ascii?Q?U361GpeXkD0PiTFDu9fA8bP2oSpz8nc9UGCH56IU0duE4WNFJ8/ymlcP86tL?=
 =?us-ascii?Q?2cAxVz2fHDg2kKyMphsfhXv7ToGO1kpyag/BlaYcnsLuqKckmiT2aA2xBdLK?=
 =?us-ascii?Q?lxi2jr1y?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24be4b7e-bb6a-4d7f-deba-08d8c30b1a17
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2021 21:32:52.1314
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BGKM2MNnxaNU/fjF8iW3lyaPfsOxM7fd2+GCPUbDIqzayulnicQWaKzcYnVz+2RMX4OFyYy+I7bMCc0PbYJ0G4yY+K+rDcZIVI/9y/C/YTE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR21MB0157
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: John Ogness <john.ogness@linutronix.de> Sent: Tuesday, January 26, 20=
21 1:16 PM
>=20
> In preparation for removing printk's @logbuf_lock, dumpers that have
> assumed to be protected against parallel calls must provide their own
> synchronization. Add a locally static spinlock to synchronize the
> kmsg_dump call.
>=20
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> ---
>  drivers/hv/vmbus_drv.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index fbeddef90941..08db95e1a139 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -1362,23 +1362,27 @@ static void hv_kmsg_dump(struct kmsg_dumper *dump=
er,
>  			 enum kmsg_dump_reason reason,
>  			 struct kmsg_dumper_iter *iter)
>  {
> +	static DEFINE_SPINLOCK(lock);
>  	size_t bytes_written;
>  	phys_addr_t panic_pa;
> +	unsigned long flags;
>=20
>  	/* We are only interested in panics. */
>  	if ((reason !=3D KMSG_DUMP_PANIC) || (!sysctl_record_panic_msg))
>  		return;
>=20
> +	if (!spin_trylock_irqsave(&lock, flags))
> +		return;
> +
>  	panic_pa =3D virt_to_phys(hv_panic_page);
>=20
> -	/*
> -	 * Write dump contents to the page. No need to synchronize; panic shoul=
d
> -	 * be single-threaded.
> -	 */
> +	/* Write dump contents to the page. */
>  	kmsg_dump_get_buffer(iter, false, hv_panic_page, HV_HYP_PAGE_SIZE,
>  			     &bytes_written);
>  	if (bytes_written)
>  		hyperv_report_panic_msg(panic_pa, bytes_written);
> +
> +	spin_unlock_irqrestore(&lock, flags);
>  }
>=20
>  static struct kmsg_dumper hv_kmsg_dumper =3D {
> --
> 2.20.1

I don't think this patch is needed.   Per some of the unmodified code
above, and the comment, we proceed to the call to kmsg_dump_get_buffer()
only in the panic path.  Code in the panic path prior to invoking kmsg_dump=
()
ensures that we are single-threaded on a single CPU.   So I think everythin=
g
is good here without the new spin lock.  The subsequent call to
hyperv_report_panic_msg() also assumes that we are single-threaded.

Michael
