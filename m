Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16DCF31FD67
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 17:51:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbhBSQvY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 11:51:24 -0500
Received: from mail-bn7nam10on2090.outbound.protection.outlook.com ([40.107.92.90]:53537
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229577AbhBSQvW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 11:51:22 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I0tEldLJgt3bHdIEl8lNNlUbedUKlyC42FMFwRbIWks6uqstIQ0EJps5MWOgxay5TBJjWacyow01eUTp4f1zqmszouTZDlqQ6fVvzm7ibsz/It+27vnpyR35OPm3u7jOXRtDoS0upDtt6Mp7H7MarHpwN9QMgTNtmz3sWL6HgR8obVZxPEJXxeM8OAX2o5YfYqFrj7yV7sR9PNRuQgBBXwqQ5KIC4NFXnLjVhbYtaeib5Z5Oeq14FWDXBAU5YyBLceAghorTgyw8I9s+2c9+NKawj9DfRnETJg994tM3XayfEffRmlDQVoxCumH6kRwmevPMQfyiNL+DDRpeF8O27Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IjiwUY6k1aEldeHPfX5gECsZmfWDtPG1DTMAfknCfdY=;
 b=EBEVcBeXZEvqlTJfIZjqqt0ELWm3YkpSWmfA4GX/Nk0wiHOcJ64oKIU3oBt09EYpUEVwPPcDHc8y/9YmJvz4kfWOsxYEIft0HOlyGTZnez1DR6gs8EdfQ2nkoqU0Mei62p4nbfJwWjkD2NStkWsm+XxVkXcGO4rpk2IoLviosIsY92nX/GTCxW+YU/e1UjaeJfBgA6w7SccLTdI2Yqqo8vrGYmXGijgwsuCoLFUygkjFdtIii0jHijDUENlAXX3QKHnhgfhNSIhRlRULwvXnCsmS/FkIGGbkaOxbetnnKZx6x0lkizlNoHTV9Ht1jlcT20HeECVXGkwmbDfXDIfmmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IjiwUY6k1aEldeHPfX5gECsZmfWDtPG1DTMAfknCfdY=;
 b=G3+ympNJvk2kMKQj33s/i2HtO1QjvXLnVmlu4EdwrHQjXvj+4Qdp/RVeTvwB3rHNXO6G4ycGK3Au7gvX89+2Ix/e++CibMSqhGK4OuWPaznXgh94NcR9B4hCwQFautVk735qwiYfLfJKWsE1CKlhvwXXoQd0HjL5roqywG22wBQ=
Received: from (2603:10b6:301:7c::11) by
 MW4PR21MB1988.namprd21.prod.outlook.com (2603:10b6:303:67::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3825.8; Fri, 19 Feb 2021 16:50:34 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::9c8:94c9:faf1:17c2]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::9c8:94c9:faf1:17c2%9]) with mapi id 15.20.3890.013; Fri, 19 Feb 2021
 16:50:34 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     John Ogness <john.ogness@linutronix.de>,
        Petr Mladek <pmladek@suse.com>
CC:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH printk-rework 09/14] printk: introduce a kmsg_dump
 iterator
Thread-Topic: [PATCH printk-rework 09/14] printk: introduce a kmsg_dump
 iterator
Thread-Index: AQHXBdzzkF8aTk1AUEGg8F+FBXwAJqpfseOw
Date:   Fri, 19 Feb 2021 16:50:34 +0000
Message-ID: <MWHPR21MB159301E1A1914D6CB642CDEED7849@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <20210218081817.28849-1-john.ogness@linutronix.de>
 <20210218081817.28849-10-john.ogness@linutronix.de>
In-Reply-To: <20210218081817.28849-10-john.ogness@linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-02-19T16:50:32Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=a747dd1d-9594-4720-85a1-e837713152fd;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: linutronix.de; dkim=none (message not signed)
 header.d=none;linutronix.de; dmarc=none action=none
 header.from=microsoft.com;
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b43801d5-9dce-486f-dee0-08d8d4f679eb
x-ms-traffictypediagnostic: MW4PR21MB1988:
x-microsoft-antispam-prvs: <MW4PR21MB1988CED256D6CA469E5FA90CD7849@MW4PR21MB1988.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2958;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Q8mW5eKlVMoQywyRRJh+RbVa97W7zuHfdkYDuTj/53yLQD/31MK9HQtP/uRbGvHzY0zSICkgeHF39e76/XXoHN87F/gRTodlOMFRuioX86xUI8moWzDt5cJPPx6hshEZ209/zQ0wBhx0Hx2vhZMLsjQ6oDBk3frktjtjPmnUf0L78ynj9lwEHAOpwPG41qtHAzBCY5pvUh7M9v634PMDv9BVYG1S9rJDs55c1LHnTuy3JtYSLbvAY1QxK9dFP+uRNNi6+OldpRkfC98t/920x5tr9ySwFsjgf5rjoKqT0rz4mOsFqx0Adw4xRXfOW43g4cWbjGyGc8wSsAZmSpTT0nWTSYTMEnlkuBPluCBK4z6am8AKbh1X9IAVSGVu11tUbArXGIueq9fVWfXmTBEHFKbD9QCmUonM4Iya0XLzbPujfOOkbu+zPSBaHlCqj3wzbid9sCDwBlfdlitqJgqJNU/AvBAFxe2yFalc7LtBZ/0/+z/wTv2iLKFnq9LAM/Zz1OHlingb5cFq2k0UVxAcWg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(346002)(39860400002)(136003)(366004)(66476007)(316002)(5660300002)(76116006)(52536014)(110136005)(66556008)(26005)(6506007)(83380400001)(186003)(66446008)(54906003)(9686003)(86362001)(64756008)(2906002)(8990500004)(55016002)(82960400001)(66946007)(10290500003)(7696005)(82950400001)(8676002)(33656002)(478600001)(71200400001)(8936002)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?Ajcwym0femF7cgi5eurvoANvOZiz5lO7D328eaDwDTMkQInp8BODf3yBEV7x?=
 =?us-ascii?Q?0l2vvX6wFuwmQQwz6U1XVXPrs76baqAIkOzGqtFzcKtVjCzi490m9FVSUty6?=
 =?us-ascii?Q?kYeIog6NCTCwJHGL//DHBN5v5KpOtGOEoMfra5zraxxHKMN1O/53S2Mie80S?=
 =?us-ascii?Q?0dDz8uu4wtSfy/tF18VzlGM06QAgjONgLfLo9VAZbtSszGawwLZsl8IdiSOt?=
 =?us-ascii?Q?rU/8+NsIQganJ1MRnb/5KtS2pCoGhpyZ9I0B7CUXGvmkqQ+m0jUCmBDH6CKP?=
 =?us-ascii?Q?cfzd/DLXLpAJP4njW2LkNKKd2m5SUl0WQwtlDaYLlFP0Spy3yTlC/4g1fYu8?=
 =?us-ascii?Q?YIs5sZGFCUeVXa9JhtV7D4nc9WsZ6I0TqljS7O3MI4qT1JiGNjxEFrUyYoTK?=
 =?us-ascii?Q?FFcBGqNnSwTBWwoM4oFVB4AOq+vgn2QPSOvz1OEcP7/e9T6YEFpTpSbWnL5W?=
 =?us-ascii?Q?2Kg6qPp4fE+mB4sd2OXmZAbvxGHCEeCQ0A4SQllZl9jXyXg4ryBrcc90FWHN?=
 =?us-ascii?Q?yAulbHjARrjHDXgm8whhzA/uR3Sys/KM8stHONLbyLLCr2xqQk2zS7Jt5Uhz?=
 =?us-ascii?Q?ggzql/D3yk4d2JjrvJWK2NhkBy63R9ul0ZeV9HuKa5h0FM2x7U8z2W0UugPZ?=
 =?us-ascii?Q?PxjuazGMBSrYs7tBcD0S/Hzem8OhfhKjgKv679m7OxTJg7/4WVuoJRT9OkuL?=
 =?us-ascii?Q?wwsYrBmmI+6VR64Qug60FmpyMvwMHv3ny/4+sLDMekpxY5TzugwPnq7Inh3P?=
 =?us-ascii?Q?vLnj7SP1DWvKMLXxLJiW9srXL/YjB8t+QpSMaa8xZuv/x8/5z8nQN0fWr4BN?=
 =?us-ascii?Q?KWzazKk7WHYNOZJHOCkFX2h8fvsnx9ACEbECtjFssh3qlUc2pipJEUdGf/zu?=
 =?us-ascii?Q?PHHQbcBzFz8Qj4eQq4vGEthUGAyEyKRdX9XAgVXH6dVL3vHCR2/y/vZw3Cc8?=
 =?us-ascii?Q?Szx8dOwHzcEGqwCoqeK5IfCl79gvElwbgWMieRzrpmcvoCQX8hkaxqCcgx9b?=
 =?us-ascii?Q?wEmdy+J81xlEjR3jl+llmYl6/OrgThPB1AT9rQ/RF+58/qO+Yu530H1SCGkB?=
 =?us-ascii?Q?EspAjdW8vcMVIIE1I6oKmJe/DuUUf7W9xmQcGj4X4LepKMn2XTXiSFhL3zWQ?=
 =?us-ascii?Q?pQTxGmEdi4pqsOx55i/HqfPmUsQoPc9PHLUeDDr3lppyGOPc+e+GYAij7mrC?=
 =?us-ascii?Q?hVd9dRig0agWr6JDI9t2YQIpj7G91O7JC8BwoVSLXlZUJpZQuBnHZcH6rjAG?=
 =?us-ascii?Q?FVyanqyk5B1pGkK4T1L086sjUfnmej5AtFxavEcqjQfExSFIrFYr1Ym/oGhr?=
 =?us-ascii?Q?yb/ZtjwvGkejFcuZVygdeCZt?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b43801d5-9dce-486f-dee0-08d8d4f679eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2021 16:50:34.4130
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3oAASpmPKUPdP7simCE01WQmYjzQZSikphPNQY0JfdQ8CkLen9CP40p0PBmBy9+aWTQtBP+QgXqcSb9t9mQjpudPhMkJfSwdycz8tXoMTkw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR21MB1988
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: John Ogness <john.ogness@linutronix.de> Sent: Thursday, February 18, =
2021 12:18 AM
>=20
> Rather than store the iterator information into the registered
> kmsg_dump structure, create a separate iterator structure. The
> kmsg_dump_iter structure can reside on the stack of the caller,
> thus allowing lockless use of the kmsg_dump functions.
>=20
> This is in preparation for removal of @logbuf_lock.
>=20
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> ---
>  arch/powerpc/kernel/nvram_64.c             | 12 ++--
>  arch/powerpc/platforms/powernv/opal-kmsg.c |  3 +-
>  arch/powerpc/xmon/xmon.c                   |  6 +-
>  arch/um/kernel/kmsg_dump.c                 |  5 +-
>  drivers/hv/vmbus_drv.c                     |  5 +-
>  drivers/mtd/mtdoops.c                      |  5 +-
>  fs/pstore/platform.c                       |  5 +-
>  include/linux/kmsg_dump.h                  | 43 +++++++-------
>  kernel/debug/kdb/kdb_main.c                | 10 ++--
>  kernel/printk/printk.c                     | 65 +++++++++++-----------
>  10 files changed, 84 insertions(+), 75 deletions(-)
>=20

[snip]

> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index 4fad3e6745e5..fbeddef90941 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -1359,7 +1359,8 @@ static void vmbus_isr(void)
>   * buffer and call into Hyper-V to transfer the data.
>   */
>  static void hv_kmsg_dump(struct kmsg_dumper *dumper,
> -			 enum kmsg_dump_reason reason)
> +			 enum kmsg_dump_reason reason,
> +			 struct kmsg_dumper_iter *iter)
>  {
>  	size_t bytes_written;
>  	phys_addr_t panic_pa;
> @@ -1374,7 +1375,7 @@ static void hv_kmsg_dump(struct kmsg_dumper *dumper=
,
>  	 * Write dump contents to the page. No need to synchronize; panic shoul=
d
>  	 * be single-threaded.
>  	 */
> -	kmsg_dump_get_buffer(dumper, false, hv_panic_page, HV_HYP_PAGE_SIZE,
> +	kmsg_dump_get_buffer(iter, false, hv_panic_page, HV_HYP_PAGE_SIZE,
>  			     &bytes_written);
>  	if (bytes_written)
>  		hyperv_report_panic_msg(panic_pa, bytes_written);

For the Hyper-V portion,

Reviewed-by: Michael Kelley <mikelley@microsoft.com>
