Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34641305057
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 05:01:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237913AbhA0EBM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 23:01:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232373AbhA0C5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 21:57:38 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on20611.outbound.protection.outlook.com [IPv6:2a01:111:f400:7d00::611])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AAFEC061223
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 18:46:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6WxQg9Bz/wg57qJDiFv2vbO+bIc/sJPtLDN5P3QqfLk=;
 b=CAwAHrUe8rBoJCFiAyeIKMicRZMe0mmACPy5jggeRGxz9nUginYdaR5yQ+aNckAzDhYZd94K4z8hlmEvabtjX5lHzszHKoMR34gSrESMGX8TV6r4ErgvkoCeE5Gjs+IXaLxhocez7txcVkuqqCJUzwlZUMRZXnPJbZnRl0Wlx0s=
Received: from DB6PR0801CA0062.eurprd08.prod.outlook.com (2603:10a6:4:2b::30)
 by VI1PR0801MB1950.eurprd08.prod.outlook.com (2603:10a6:800:8c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.11; Wed, 27 Jan
 2021 02:46:18 +0000
Received: from DB5EUR03FT013.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:4:2b:cafe::e0) by DB6PR0801CA0062.outlook.office365.com
 (2603:10a6:4:2b::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.12 via Frontend
 Transport; Wed, 27 Jan 2021 02:46:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=pass action=none
 header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT013.mail.protection.outlook.com (10.152.20.105) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3784.11 via Frontend Transport; Wed, 27 Jan 2021 02:46:18 +0000
Received: ("Tessian outbound 2b57fdd78668:v71"); Wed, 27 Jan 2021 02:46:18 +0000
X-CR-MTA-TID: 64aa7808
Received: from e0ab7be52581.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 44570F1D-7292-499C-90E5-08D473C92595.1;
        Wed, 27 Jan 2021 02:46:13 +0000
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id e0ab7be52581.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 27 Jan 2021 02:46:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WZxzQv5Qx5GRsumYfBuEami/XLPEF/tsIFsR144tI5iyDxQPqu89cUzIkf58ii8CAwnzOAC0+VHOAbTWECcSobhW/xGx9KWZgJEtCYqy+Rjr7I/3j2zJjnCD0TGAw92s/ZclnMwMDOexTdwAV5XPBKX2sksVeuz0AyhOkLxB5udyke8QK2gKSsGo97k4bhfsK/9l2lj/irrL0nuGyF36c5SlWIlXjB2hgge8YeSMpY2SAXnpTRQUaerpcLbCiV6FFAq2mB54qSH58LhZK5B5KSl7kxGAeObCyNJFDPyUUN6Heiwm7KE9u0GeLZI19q/5BbTIwITPycuBkYecnNCrOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6WxQg9Bz/wg57qJDiFv2vbO+bIc/sJPtLDN5P3QqfLk=;
 b=dkEx9t0QSJZCl67Eo2aGfejJEd62m4I0NyHQ8mTHesEHTAVep0ITpn9/psJaRi5oMQGpOUrKfFiCDbqdHNVKFjHKytwrJy3pB6O5GZ8ws6x/gk4fNOVO/fVT8DOsYDtcd4dWe91XYjwUsKVQnZX4Dns9MQbnIpdQWErp4zIozUs/onpVshu0lpwLglzD1wpb6TQRihZnKL6cfFp29RF/Qfb0hXgymBS1G7FVUW7zuz1cTB5ByrDN09kgnzGgi2s63NEiqUmRx+GAFs1S45RdApQ/By1U1ea/DiOjQRFlf71cCT4zttTLHf9pyej4JnjyQNGb2b2m82UtcbmzjKanww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6WxQg9Bz/wg57qJDiFv2vbO+bIc/sJPtLDN5P3QqfLk=;
 b=CAwAHrUe8rBoJCFiAyeIKMicRZMe0mmACPy5jggeRGxz9nUginYdaR5yQ+aNckAzDhYZd94K4z8hlmEvabtjX5lHzszHKoMR34gSrESMGX8TV6r4ErgvkoCeE5Gjs+IXaLxhocez7txcVkuqqCJUzwlZUMRZXnPJbZnRl0Wlx0s=
Received: from AM6PR08MB3589.eurprd08.prod.outlook.com (2603:10a6:20b:46::17)
 by AM5PR0801MB1793.eurprd08.prod.outlook.com (2603:10a6:203:3b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.16; Wed, 27 Jan
 2021 02:46:11 +0000
Received: from AM6PR08MB3589.eurprd08.prod.outlook.com
 ([fe80::201c:d613:b9bd:fa33]) by AM6PR08MB3589.eurprd08.prod.outlook.com
 ([fe80::201c:d613:b9bd:fa33%7]) with mapi id 15.20.3763.019; Wed, 27 Jan 2021
 02:46:10 +0000
From:   Jianlin Lv <Jianlin.Lv@arm.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>
CC:     Steven Rostedt <rostedt@goodmis.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3] tracing: precise log info for kretprobe addr err
Thread-Topic: [PATCH v3] tracing: precise log info for kretprobe addr err
Thread-Index: AQHW8zNhQKRvGbxdckymzuUtTURLX6o4ptSAgAAFXgCAAKEyAIABDbmAgABfZwCAAAtrAA==
Date:   Wed, 27 Jan 2021 02:46:10 +0000
Message-ID: <AM6PR08MB3589EE4B5F1F56B84FE2750598BB0@AM6PR08MB3589.eurprd08.prod.outlook.com>
References: <20210125160108.2147511-1-Jianlin.Lv@arm.com>
        <20210125181926.GA10248@redhat.com>
        <20210125133840.511b1496@gandalf.local.home>
        <20210126131536.f6e3a737a7b948799084fa7a@kernel.org>
        <20210126202058.GC12469@redhat.com>
 <20210127110226.a65b3e8c66eeab6ee63f8aee@kernel.org>
In-Reply-To: <20210127110226.a65b3e8c66eeab6ee63f8aee@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ts-tracking-id: 49FEA6F1FAF38C46BE2DDA24CC58BF5E.0
x-checkrecipientchecked: true
Authentication-Results-Original: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=arm.com;
x-originating-ip: [203.126.0.113]
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 14b3c4b9-3ec8-4484-c462-08d8c26db911
x-ms-traffictypediagnostic: AM5PR0801MB1793:|VI1PR0801MB1950:
X-Microsoft-Antispam-PRVS: <VI1PR0801MB1950976DDF59A6F3352A5C7098BB0@VI1PR0801MB1950.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
nodisclaimer: true
x-ms-oob-tlc-oobclassifiers: OLM:6108;OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: QwLy17cyUZRb7/D+5SlklqljpI4IkWa3XZwgr4dWoYhT9ResgvvB3h2sYdpkncz2lWis7uXr1q8KTmCpbWdzUbyq8m33TaDZhP82ez2mpCABAvOjX5D3OwIqnu4H5qqC/rZMM3GRZGM9AzR9/XmwPWGliz5prM/GieRQkEicRq6Qjv1pIMuiweq3OOIy0HH+LayVlQqfgk9rIqdiL0uA0bLZdsCLI/l7KyL1bkSrOhg1sH2sCa844J3BnQw9QUCmzHuz/LBuOzmBHte28VN8+xSv2bFTJaICyLZubiqSeo7mHaSjnA7IhyMKCSU+p3G54909XYby4Au5dVvN0JjqzOKUzZPZOdXtJB2/GrRlDviM/AfPjd4O6pXWyq77451PsxrUvdfscg8vZz+/0smzrA==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR08MB3589.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(376002)(136003)(39850400004)(346002)(2906002)(478600001)(54906003)(110136005)(33656002)(26005)(5660300002)(64756008)(316002)(53546011)(66476007)(66556008)(66446008)(76116006)(71200400001)(4326008)(86362001)(9686003)(83380400001)(6506007)(8936002)(186003)(66946007)(52536014)(55016002)(7696005)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?cjlrD7nlLF2OC4iewQK58DwZ1KRcrTOwMr5BoFrUJmQKOt1bjxOUrgGXVnGc?=
 =?us-ascii?Q?JcT3hWjRJLaO3RIt4Lno5O6y6e14fBIx/sQ5/2XoXtHMsK+bu7PiHROP1cZo?=
 =?us-ascii?Q?j3kpqqRHCPttcfgTNq56kEXlnc1LoZgSY08bDPWvYHB7ibURq1q3KwYlPiqB?=
 =?us-ascii?Q?MNBtscAy2OtOHMVvryZDX9KxosoWrLCnIn1x+nzh0hZtDVobQW8MH0m0gMD/?=
 =?us-ascii?Q?qfvIIGzWvzekiCTTkWiNXVjr7On1mQog+6ntJCDu7vw4jddmaj9kj9+bNaWF?=
 =?us-ascii?Q?0CjwXIN5PnPxyRajsBn32OfNvOvDXqglK4eNb34NorGuxGHal+vvfCwEQX9l?=
 =?us-ascii?Q?00bo2apuJ2O7n6zypwdRfUkxv24DpSnZElyk0cb/C63ZyXusVgxELeLhXGoV?=
 =?us-ascii?Q?K9bUWrvv6dRmQlJCIALcv/JXlFDTS2Z8wNZV0Ti1D3DlThoVBMskW2MxjcsB?=
 =?us-ascii?Q?wa5i44Loa507nfkrldwvgraVb0EbbhLsEoMqJkCedF7h4bASmrGD0J+LJ2+M?=
 =?us-ascii?Q?ocThqPfQCv1vHBdQKtoeH+gXZxR1jJEpCMX4uUcNs19q51Wh779VZGKVltud?=
 =?us-ascii?Q?DGhtzk/Xt9tqjcEJzrzxoYsyMZiR7eBlybWh8Qqk6x9we7AsFdalxU12MMgX?=
 =?us-ascii?Q?FvthpZJQ9Wu/lJaDdNj7dfPMDNvubCX7OO25g2Nv2sIB3/5iiYImLUuvfVAl?=
 =?us-ascii?Q?6zOoEhKNc3ZME1kVb7kwHPFMfJdvItHRJIAfDckctxTjua4OnzlNAOQf9uEh?=
 =?us-ascii?Q?HPwYjLbEnfEfKWprHpFXdzou8rSNX/TEUtQe3b73ZXmjXIAJsq7EIhxYfyk1?=
 =?us-ascii?Q?CowX4c0vlnwC2VK+mA5BjTN7dl72Jja3XiF99M8KYbr1kpNON0ooJeN8vR6y?=
 =?us-ascii?Q?xuFCYy/eWq6CLrBkXxAi3o42lfmLXFHZTqz1qt3qFsnxC+WWEbzjQIaTaFuN?=
 =?us-ascii?Q?dt2ivjqfOHYs7LVxkPUeMCG/rFh0w/1r377YJpUgJ6VPWU7crmgZSWbc8EME?=
 =?us-ascii?Q?+nanfwnMJRUp8sHcF/sH0J7drhJwaKtcGEEKyT0nUekIayFecXpPBgLfdpoJ?=
 =?us-ascii?Q?UsQpobAU?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1793
Original-Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT013.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: 2636244e-5e39-43cd-d74b-08d8c26db489
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5xlFnLXKgeNg3JoG6rQJjArXWiL7Ue+yvDCrlx4oxbFpywSib3iTU+wJj8w3EyfcjJs5aDD4nNk+E/OPCgm/DUCSX4rlIgoPdaFjKBwcj6x66AwfY0EmagK1ahlgUMjHbAZ0BJjHsTcga+K2MJaAMdl/eB9uKAxwP2++hzyx1yrBvBpcZ+FAWeZeUgbBfucX4W27wNfcJVybH4P4Tyqu3v4HiaHJT3qZso/4ZY3wQsQGGa23ryPq9DQMNMBshs8ydXlUOLAyuDw8lHGRQNsNF+qbfqdVnY0DZJX12+a/EHTiVMWkhqdppqtWrSRTKQZ7BKzCEAb+FRb943PXXzksYCJXbJ0+NZhsVctYsEsdlIxt65DHPDztteNHD1pexGVil7w896HH30s6+6MqIgDQ4aIe6/ZaIlhkSXAQdASkg8ylR0L3uE0fWCqSsAzLSzu0L08CzzBLyWx1npCABPkJgJs7rXGaliaSShlGSTv7VBOwBNtA76EnPQATHg0fbxwsmqgl4cLOkJlYhZ9E2OPTi+yUhfP8SFDGpojNyn+ma4Wbz8GWmcIsArFSuJcpU1CDGC5OpnejFBF7V+g9V1SBKOt0MffohyPO1bsJP+I7dq8=
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(346002)(136003)(376002)(39850400004)(396003)(46966006)(316002)(26005)(186003)(9686003)(478600001)(47076005)(52536014)(336012)(54906003)(5660300002)(7696005)(110136005)(82310400003)(33656002)(4326008)(356005)(70206006)(81166007)(6506007)(82740400003)(53546011)(8936002)(86362001)(8676002)(55016002)(70586007)(83380400001)(2906002);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2021 02:46:18.5028
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 14b3c4b9-3ec8-4484-c462-08d8c26db911
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR03FT013.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0801MB1950
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Masami Hiramatsu <mhiramat@kernel.org>
> Sent: Wednesday, January 27, 2021 10:02 AM
> To: Oleg Nesterov <oleg@redhat.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>; Jianlin Lv <Jianlin.Lv@arm.com>=
;
> mingo@redhat.com; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH v3] tracing: precise log info for kretprobe addr err
>
> On Tue, 26 Jan 2021 21:20:59 +0100
> Oleg Nesterov <oleg@redhat.com> wrote:
>
> > On 01/26, Masami Hiramatsu wrote:
> > >
> > > > >
> > > > > IOW, the "offset !=3D 0" check removed by this patch is obviously=
 wrong,
> right?
> > > > >
> > >
> > > No, not wrong. Even offset !=3D 0, if the symbol exists in the kernel=
,
> > > kprobe_on_func_entry() will check it.
> >
> > Yes, but unless I am totally confused... if kprobe_on_func_entry()
> > returns false, then trace_kprobe_create() should fail with BAD_RETPROBE
> even if offset =3D=3D 0 ?
>
> Yes, if kprobe_on_func_entry() returns false, register_kretprobe() also
> returns an error.
>
> -----
> int register_kretprobe(struct kretprobe *rp) {
>         int ret =3D 0;
>         struct kretprobe_instance *inst;
>         int i;
>         void *addr;
>
>         if (!kprobe_on_func_entry(rp->kp.addr, rp->kp.symbol_name, rp-
> >kp.offset))
>                 return -EINVAL;
>
> -----
>
> Thank you,
>
> --
> Masami Hiramatsu <mhiramat@kernel.org>


If register_kretprobe()returns an error -EINVAL.
This means that __register_trace_kprobe return -EINVAL,

---
ret =3D __register_trace_kprobe(tk);
if (ret =3D=3D -ENOENT && !trace_kprobe_module_exist(tk)) {
pr_warn("This probe might be able to register after target module is loaded=
. Continue.\n");
ret =3D 0;
}
---
As code show, cannot enable kretprobe for an unloaded module.

This is consistent with my test results (no VXLAN module is loaded).

# perf probe -m /lib/modules/5.11.0-rc2+/kernel/drivers/net/vxlan.ko  \
'vxlan_xmit%return $retval'
Failed to write event: Invalid argument
  Error: Failed to add events.

Is this a bug?

Jianlin

IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.
