Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C16A309412
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jan 2021 11:11:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231149AbhA3KKK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jan 2021 05:10:10 -0500
Received: from mail-eopbgr40073.outbound.protection.outlook.com ([40.107.4.73]:40278
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233214AbhA3CI4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 21:08:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NztnBRYB3XGqOIC2pAm5gix+1jrX0PRMfbOd1E1YeYE=;
 b=cpvCLMOvin2Nr3imr+MVCiwfpuIa3T2QdEAvW6jGJAIBucLlec4FyDMihfNXRu3mjhqnVaXUyUgmXZIYfrlBuXioW84yvzz7tAh5LzPhZGps3Jk5hgPNN1hzSnwq3j3LuWcuay2brpdBdnazUFxZroJOo9crhq1iyBXo258I2Jc=
Received: from DU2PR04CA0042.eurprd04.prod.outlook.com (2603:10a6:10:234::17)
 by HE1PR0801MB2108.eurprd08.prod.outlook.com (2603:10a6:3:51::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.17; Sat, 30 Jan
 2021 02:07:22 +0000
Received: from DB5EUR03FT010.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:10:234:cafe::a6) by DU2PR04CA0042.outlook.office365.com
 (2603:10a6:10:234::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16 via Frontend
 Transport; Sat, 30 Jan 2021 02:07:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=pass action=none
 header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT010.mail.protection.outlook.com (10.152.20.96) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3784.11 via Frontend Transport; Sat, 30 Jan 2021 02:07:21 +0000
Received: ("Tessian outbound 2b57fdd78668:v71"); Sat, 30 Jan 2021 02:07:21 +0000
X-CR-MTA-TID: 64aa7808
Received: from d48c00d9036d.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 486417E0-A2C5-44AD-B552-D00A1579BD07.1;
        Sat, 30 Jan 2021 02:07:16 +0000
Received: from EUR02-VE1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id d48c00d9036d.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Sat, 30 Jan 2021 02:07:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lDrkNb74U5fhf9zQ5TLORPFlWE5940G038IrPsUrJWtJFamOJMHvYdgp8Dzs8Qd1BATbN6Z4T5OMAUztiVbubi0KFjIao7XzN8OoDUeayypPlzHNfbJ0ByZx0OCSjR9JYVTDHN3iqE7Wyk5BWZauFQZarzX5Za7Iu8i1gRT6/5mOPywdNOn824IwI7PPHW6/gbptLIW2Hirp4xpF87w90+enfs1WVy1lYLlu1a06MHTNLVTMalKfXoPwrBDpUz5ryj421Azh5fHQn6dMhvOX+lEJxIOdaA26/tMB66RcvRD0mEBnE9GDNFqgo8dFh8PXknH+d5zvZ8/UNygMz4IyQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NztnBRYB3XGqOIC2pAm5gix+1jrX0PRMfbOd1E1YeYE=;
 b=UrrGxVi3U+p3rQeSgG47ArJg64Arv+5nS+QE9soI0Sy888B/TlUWBPM+DRhcGzqtf5k+2CV2YiDfkCrCdn0nnSdAd688KhJHbitHqmott3exoUrDF+cQWX1qLa6u3YByN5E4GCdAKqS8Q+IgbteZs6I6c62R2S8VGyccxGnFiHDto9zITdPy633FpZ7VrLtpwywwcsWiVJYYkIo6fOI3sOJcRA+KrVqQct1Y9AMtNoxrK1ByBCQb2ANZaZshDocbeclVpctEvACCfK5l4EmknuHYuf+sAcp/pwfmzls8nQM40roGhG059PXDViWOPesdIPckfHEguVRX5ye3+IDu/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NztnBRYB3XGqOIC2pAm5gix+1jrX0PRMfbOd1E1YeYE=;
 b=cpvCLMOvin2Nr3imr+MVCiwfpuIa3T2QdEAvW6jGJAIBucLlec4FyDMihfNXRu3mjhqnVaXUyUgmXZIYfrlBuXioW84yvzz7tAh5LzPhZGps3Jk5hgPNN1hzSnwq3j3LuWcuay2brpdBdnazUFxZroJOo9crhq1iyBXo258I2Jc=
Received: from AM6PR08MB3589.eurprd08.prod.outlook.com (2603:10a6:20b:46::17)
 by AM6PR08MB5047.eurprd08.prod.outlook.com (2603:10a6:20b:d5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.13; Sat, 30 Jan
 2021 02:07:13 +0000
Received: from AM6PR08MB3589.eurprd08.prod.outlook.com
 ([fe80::201c:d613:b9bd:fa33]) by AM6PR08MB3589.eurprd08.prod.outlook.com
 ([fe80::201c:d613:b9bd:fa33%7]) with mapi id 15.20.3763.019; Sat, 30 Jan 2021
 02:07:13 +0000
From:   Jianlin Lv <Jianlin.Lv@arm.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
CC:     Steven Rostedt <rostedt@goodmis.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] tracing/kprobe: Fix to support kretprobe events on
 unloaded modules
Thread-Topic: [PATCH] tracing/kprobe: Fix to support kretprobe events on
 unloaded modules
Thread-Index: AQHW9MJs+vYjq8+NoEaLklcIBcQCxqo8DlQAgAAb34CAAg1+MIAAaKwAgADKnoA=
Date:   Sat, 30 Jan 2021 02:07:13 +0000
Message-ID: <AM6PR08MB35892D543FE56BFC7A2F0C2498B89@AM6PR08MB3589.eurprd08.prod.outlook.com>
References: <161176187132.1067016.8118042342894378981.stgit@devnote2>
        <20210127172950.7911317a@gandalf.local.home>
        <20210128090935.719ac21fbfa2b6cfc91dea9c@kernel.org>
        <AM6PR08MB3589FAFEE0CDE17DEC647FAC98B99@AM6PR08MB3589.eurprd08.prod.outlook.com>
 <20210129224502.d0b293d0a4e0f18658d60957@kernel.org>
In-Reply-To: <20210129224502.d0b293d0a4e0f18658d60957@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ts-tracking-id: EB0FB6EE89ABDC41B23E4EAD87D718B6.0
x-checkrecipientchecked: true
Authentication-Results-Original: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=arm.com;
x-originating-ip: [183.192.76.131]
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5c9b3666-8c4c-45a7-2556-08d8c4c3c75a
x-ms-traffictypediagnostic: AM6PR08MB5047:|HE1PR0801MB2108:
X-Microsoft-Antispam-PRVS: <HE1PR0801MB2108753E8CD1B0B398D2892898B89@HE1PR0801MB2108.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
nodisclaimer: true
x-ms-oob-tlc-oobclassifiers: OLM:10000;OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: qODk52er8HMKCF92up0Tid/x/n9XtURLcOvCwgnBiUMJQL59g4LYEMN5ciby7CUpwJOOkbkIWpVcjjiB0VUFuQKi/KMHTg2gKdI3WPbibEQcWwwlJ1O4q5fgmNQl0GPd0M0P2MErBrAqZHLG/y4JCSJja8KncsVpcPYze0k8LERjPjAuYMHwXFeb8pfvtYzwzWjkRV6+Rhx8oYW0skzouVzjVB84k0OVMKCi4nAatvtV0mbD82kc+9QeRnXql7Z4jXQSp0mjRIhL2uoNwf4ElGj8aQ+MNeslodw4PgutLPXWZP2imnpvl6wkQ96+wtMq9lVwH8ybOAAOmIA8uqCCoI6xcrCsSrNDVzsjqbE2/ejHh5AvC9Sq+yjKwUYaa9NrxoSdU9rdpw8Q8csbDjYzaCxPI/1NjHbnAbf1K6VeeFU4eqJZg5sPah3XA6xHjwPJGDL5kYbcePcetjKvHZs06i8565NX4q4J/9o1fU7nVciTirl0K2EwnECR8g3K7tItCf5Rl/Z+y82iVAKFzUy/kXseDQvNGwQpcbo0IY4+t7QhYOE1+bzhq4I5xltmVe35f+RPDXgfllCXzB43s3OVKJZLZmwt1AqtM2ulHQwuo2LsQHinHVLoVL+x6zH6IzvIag0/llsT67J1CnzICvCrIQ==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR08MB3589.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(396003)(376002)(39860400002)(366004)(7696005)(64756008)(66446008)(66556008)(54906003)(9686003)(966005)(66476007)(8936002)(76116006)(8676002)(5660300002)(33656002)(316002)(2906002)(478600001)(53546011)(83380400001)(186003)(52536014)(71200400001)(6916009)(55016002)(4326008)(66946007)(6506007)(86362001)(26005)(21314003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?vfgb4BZJ79jTJP2yWg5HFlOiyk+rOCHorGrYzAInpis8g9i//HIOO24+6D9e?=
 =?us-ascii?Q?ux7i40UX8mhDOdD+m4pXFsC1R3HcGUrO1PO2otJwsOD7FI3Xd5h1MS5oIQdn?=
 =?us-ascii?Q?EE5IRm9EBcCiXvaOSexjArxJK0cH6QJSHBiNzr7TnSBdYocFjtvzTCBYPVw2?=
 =?us-ascii?Q?e7mlR7H+04eavyYqrzm61q78qVdqrOH9O2WYqzCGwrKgFcUAy4vPxsL46jF1?=
 =?us-ascii?Q?Ka+T4N3dhsq73hd1Uue6t1y0vucMyoD2tYWIigocg4kgXWAZ2k+ZKlCM27Jj?=
 =?us-ascii?Q?tsl8kVzg5V+AQrsEfFIIn5kIOXzF7zJurBkMTqKvkDkGBL0E33wOpB7Weq5X?=
 =?us-ascii?Q?rjN+qAJAQ1dCSKP701hNO+s9iTIyyfsOwgX37vkBiT5I+mjCvPK3UqifjucJ?=
 =?us-ascii?Q?T3ma6RAL+MTbpvocSaQrKI9RSmacPnXzK4nVA+eWjjoxvew7SRS3tc9kt8+1?=
 =?us-ascii?Q?1ofDp18EkVu8qV7fGzNALsy1rmtb/kQgMeLxce7a5/JDmfBVZlfXV2+RYZVo?=
 =?us-ascii?Q?FjzHGcGDAOl9LgIAmDXbO1hEGokn3mmWdBah0EhtRw+3Lm9Gy27b/bTD6+PY?=
 =?us-ascii?Q?PbgVeJs83SEfzDmvuDTgvznhwACatK2so+/owBknt1Hj9Y8boaUPOSyHGEw7?=
 =?us-ascii?Q?mXEVLyV9WSFEvDcDNNuvPcan2k9xTTOj18xryESUL99WxkJWnU6OjIhKD1UK?=
 =?us-ascii?Q?PAJyxwFRoZQdgxg9bUI79yIxkv45IN0+Dn3LDG1jpWSDq6xLEDBPKl7K0cnT?=
 =?us-ascii?Q?CvaV5qpw5FV7ORccQ44d0QDhoCAHGgznqibogdDrQ8ueQSeRdwF5lgO4zUld?=
 =?us-ascii?Q?zbuE6Zih1lo/TNosAK4nlTjVpedb9wtc2h37zKzOpVa4n2N7eWd9rMCWZa09?=
 =?us-ascii?Q?QC6FFezyeAWSDJ3ue3fvACu5xe+1fJnKsyXcAeO+DrcXur7N3DL6BaAXvJON?=
 =?us-ascii?Q?QeXY5quQ5P2YJZeYWSaLMzrQBj8kDASu4CmeofexFo2hrLlq7xcvvcjgFKnT?=
 =?us-ascii?Q?15kmR2rOJm0NKK3NIoEqsPGEmlfV41Q1gxdu1Jd8taKzZLp+L3esnzpQoGDp?=
 =?us-ascii?Q?bexyp/z9?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB5047
Original-Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT010.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: 26d69196-c930-4ab2-6a9a-08d8c4c3c2b3
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fmezkBCN76alx26QHsJxbNxgms4lzTvLJW8zGMpFRU3uUflbOI9WWX3/2mC660tCwjhBOypSGHnGOD3dmQnfyE13gBu8cTV0ilKGjZI5qvuZy32Tzbzyc6Fqnmb4TiD7Cy+cvRII6CgHQiUWInZrwQsOuuDAzdHxfGrqomZA6LrRyb1e6UxyCvAkKIIFA2Mkljhzd5ZOu9KpPOvqXq/V599VQ3R+TG96LtR1mQvaedXQUAkfS5p5cVOxDfDOBgB/VuRd1o9erzHB8zSNrPQGKXJSxUSyj2J39603Pv0Cr2SOj6VophyiU0o2zTm9SoXXodwQh+/ZnbNhXZWR7VsELkw4VAhbVLHylKh4UTBMpfJKkjBJb7jzBdYg+IYGYXiTUVrDCP0wUCRe/w0wQTXW0MoLT0RFkrE9tcyN2DfOHqqIzpFQKMyzzLwIdbXJv8GnP+tN+FXOtetSqQJcwd7hGBL2p9ZGaB3o+kQQmMWSkJGmzPoSj4Thd222qnOhLXtMv4wd6NIvtTnncEEjOAgV652MPJZVkCoN2gu4+Zba+ztdj589AXjlNBo25e5zWuPQM91gmwTiQLloyoGrMnRhFZ4yHEeZY5cPvMaPgMuQgYK/j9e72l9o8xt0Z0FKNfLZOtWPPROYj0sNzkvl9i+Mdp8ZSxHvf3A+Tg6qi03YCTV5J9GwqjtH//2g11+Ba5Gv
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(136003)(396003)(346002)(39860400002)(376002)(46966006)(2906002)(82310400003)(81166007)(53546011)(6862004)(55016002)(6506007)(186003)(82740400003)(316002)(54906003)(7696005)(356005)(70586007)(966005)(4326008)(86362001)(52536014)(8936002)(47076005)(8676002)(33656002)(9686003)(83380400001)(478600001)(70206006)(336012)(26005)(5660300002)(21314003);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2021 02:07:21.5095
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c9b3666-8c4c-45a7-2556-08d8c4c3c75a
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR03FT010.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB2108
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Masami Hiramatsu <mhiramat@kernel.org>
> Sent: Friday, January 29, 2021 9:45 PM
> To: Jianlin Lv <Jianlin.Lv@arm.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>; Oleg Nesterov
> <oleg@redhat.com>; Ingo Molnar <mingo@redhat.com>; linux-
> kernel@vger.kernel.org
> Subject: Re: [PATCH] tracing/kprobe: Fix to support kretprobe events on
> unloaded modules
>
> Hi Jianlin,
>
> On Fri, 29 Jan 2021 07:45:32 +0000
> Jianlin Lv <Jianlin.Lv@arm.com> wrote:
> >
> >
> > I have verified this patch on server and it solves the kretprobe issue
> > on unloaded modules very well.
> >
> > One comments is this patch did not cover the issue I reported before,
> > https://lore.kernel.org/lkml/20210127151507.4185234-1-Jianlin.Lv@arm.c
> > om/ if echo wrong function symbol to tracefs, error_log show as :
> >
> > # echo 'r:myprobe ERROR_SYMBOL_XXX ret=3D%x0' >> kprobe_events # cat
> > error_log
> > [   87.746191] trace_kprobe: error: Invalid probed address or symbol
> >   Command: r:myprobe ERROR_SYMBOL_XXX ret=3D%x0
>
> This is the correct error message because the symbol is not exist, a bad
> symbol.
>
> Thank you,
>

Yes, it would be nice if errors could be detected before registering Kprobe=
.

Of course, this patch is looks good for me.

Jianlin

> >
> > Based on the current patch,  The following changes will make the error
> > log more accurate.
> >
> > @@ -828,9 +828,10 @@
> > static int trace_kprobe_create(int argc, const char *argv[]) if
> > (is_return) flags |=3D TPARG_FL_RETURN;
> > -    if (kprobe_on_func_entry(NULL, symbol, offset))
> > +    if (!kprobe_on_func_entry(NULL, symbol, offset))
> >         flags |=3D TPARG_FL_FENTRY;
> > -    if (offset && is_return && !(flags & TPARG_FL_FENTRY)) {
> > +    /* Check whether symbol is really bad or from a module */
> > +    if (!strchr(symbol, ':') && is_return && !(flags &
> > + TPARG_FL_FENTRY)) {
> >         trace_probe_log_err(0, BAD_RETPROBE);
> >         goto parse_error;
> >
> > If you don`t mind, I can send v5 of my patch after this patch be merged=
.
> >
> > Jianlin
> >
> >
> > IMPORTANT NOTICE: The contents of this email and any attachments are
> confidential and may also be privileged. If you are not the intended reci=
pient,
> please notify the sender immediately and do not disclose the contents to =
any
> other person, use it for any purpose, or store or copy the information in=
 any
> medium. Thank you.
>
>
> --
> Masami Hiramatsu <mhiramat@kernel.org>
IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.
