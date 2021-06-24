Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B0DE3B2791
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 08:42:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231379AbhFXGpD convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 24 Jun 2021 02:45:03 -0400
Received: from de-smtp-delivery-105.mimecast.com ([194.104.111.105]:25226 "EHLO
        de-smtp-delivery-105.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231145AbhFXGpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 02:45:03 -0400
Received: from GBR01-LO2-obe.outbound.protection.outlook.com
 (mail-lo2gbr01lp2051.outbound.protection.outlook.com [104.47.21.51]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-24-oAgHv0DaNfa77PcUzd0RGw-1; Thu, 24 Jun 2021 08:42:42 +0200
X-MC-Unique: oAgHv0DaNfa77PcUzd0RGw-1
Received: from CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:89::10)
 by CWXP265MB2007.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:83::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18; Thu, 24 Jun
 2021 06:42:41 +0000
Received: from CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM
 ([fe80::259d:65ac:ae6d:409d]) by CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM
 ([fe80::259d:65ac:ae6d:409d%9]) with mapi id 15.20.4264.020; Thu, 24 Jun 2021
 06:42:41 +0000
From:   =?iso-8859-1?Q?Christian_L=F6hle?= <CLoehle@hyperstone.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kobject: Safe return of kobject_get_path with NULL
Thread-Topic: [PATCH] kobject: Safe return of kobject_get_path with NULL
Thread-Index: AQHXaD5guylz4e+fzky/qfcToJhYzKshs5UAgAEBc6c=
Date:   Thu, 24 Jun 2021 06:42:41 +0000
Message-ID: <CWXP265MB26809893E168B75CF57ECC86C4079@CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM>
References: <CWXP265MB2680094534A5559B0A904B76C4089@CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM>,<YNNPHvFWoeI4UwEZ@kroah.com>
In-Reply-To: <YNNPHvFWoeI4UwEZ@kroah.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [185.80.168.10]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e38ba1a5-c374-4af3-acd2-08d936db43ce
x-ms-traffictypediagnostic: CWXP265MB2007:
x-microsoft-antispam-prvs: <CWXP265MB2007F595EF9669197A348E02C4079@CWXP265MB2007.GBRP265.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:9508
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: RNS6rIjY0NcY3gi1Lc/VqqlCPKYnz/7gR+g4fzh6PoRHr8msB+03Opizbh8gS/NIUbksp5nV00Zq5nXX0ouRujvmmWPqtHqYsijLli0mVbsbqpiYLyl9RwvEGAAWpwC9c3dEKLk2NJP5kHOJDT1H68ZVN2KtKaZBKbBIgbLuimkhBsyqi1WPgV0qOtD4biKocEbQaTWSdmi+jplV/8JBpeS+enq1jCgf35ZvgKX5OiAKrEJIkF6weMyFT9ciQncn9BwWOwecjnhUPN+xV6PK0K5ITb19NjQCiQnRk7M+QDlg7rUe3NW2o7IQSmDA+LozdTFDvQAjw7Se6QjYNzlxkuNWlpvfRSXfH6LJ/VYIUiW48jzaKwVtRZ7OActA3NK9TdePRFNxviFNmGqfuFzq3MtVlmydIfHyRzKRnma6E9IhGe+0LzDNxNBLbt6HDMMnppKumtnRa4jbPDF6rojFWxY5RKLCD8Bdh3ALHSFK2un7KI2o3V2sibYkXqro6PkSBLRKklfJRPdvA2d/NoiZfdQYa47uXYAmEc0A3TUdv564Y7DM9CJcYmTehbSepb1WZ/79n4SzSclYTRuf7Lw70OmRCnbQTJ18FJARaQxpAzc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(366004)(136003)(346002)(396003)(376002)(39830400003)(8936002)(8676002)(66446008)(66946007)(64756008)(66556008)(66476007)(86362001)(7696005)(71200400001)(52536014)(2906002)(55016002)(9686003)(91956017)(38100700002)(76116006)(122000001)(33656002)(5660300002)(26005)(186003)(110136005)(6506007)(478600001)(316002);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?hqsjGnPXV7pT00ZooQjY5UEo+87hx7xD+jGtMm4BM7GTXvr0FR8s6GSN4o?=
 =?iso-8859-1?Q?D9/6d67hEc9zpPM2xbROCfTGh9ivgDX39Isu5DpCBnujhHqcT8KbdY+oiw?=
 =?iso-8859-1?Q?DQDqM424WGD9gd3dk5tpUY/TwMsjnlDGH5EcYdXKERLeQu5Ul0b+mLDrsa?=
 =?iso-8859-1?Q?YWR2eOrtQ+Lsn3iY3GdCjSZoHAmnRLMWfZvyni4YxsuIJAAVRbAMJYGEqA?=
 =?iso-8859-1?Q?ruKn9hqOs/dIXNMHGmWKnA+0yzROMGpgiVDYyPOcaJxqu8LCBiUMqLAU+B?=
 =?iso-8859-1?Q?dELKD01DKZWWQKrmbVnCDpTd2SogmfhOYzggEQySzRo47QJDeSCeo1MJ7A?=
 =?iso-8859-1?Q?0oegO0VJ3B0FQAXlgJ7G0CGuIDha9u8sZr/XwxThvsvpegxS4ybUg5jA9P?=
 =?iso-8859-1?Q?vDm8NBSTPFVCVdswYf3umpVyjOBo/yZX2Vf4/e1oNxXmc2FdqleVY9gIiY?=
 =?iso-8859-1?Q?S0/GxQtNXyUvfOmQnoRdSssQdErxGHbMtglCQK5bUbySAg94GhBo8A6KmP?=
 =?iso-8859-1?Q?zan8wT5zDAV92Bmi2o7MdpdLNfop1XRz4D4k6oeSI4ZjvtKKRB8rhtGuay?=
 =?iso-8859-1?Q?MMHawQzCWH3xdBg2u8p5KKdOhvliebHsCuuPrcN09Mf8N07JLlFOyES++1?=
 =?iso-8859-1?Q?VcNN3gJqKVS2XtKjqJW56zOLdtyVSfpcJ/gg4PHnnS5QmsKMqhONJVom6N?=
 =?iso-8859-1?Q?HV/vdnn6m+MZ2YzOaGkHU7Gwqr2LA85EIUWisfQRVs4d8MJssaA/1S2xEY?=
 =?iso-8859-1?Q?avQAI+4U86n25oG29nFFg4SFh4JeEO88Eg+y2ya0LZONdaEtEBkia8uEzk?=
 =?iso-8859-1?Q?3l037T1je1LVVtoxs0Utdz5WOwrILWu+xfJM7DMy1F1963A6F5LIazVC7p?=
 =?iso-8859-1?Q?uRc3lkit95QW7Yv2LZloTzLVroeI52mBYsI939jn080YJLOa50AQd1Ft3G?=
 =?iso-8859-1?Q?+KRk8Nivw/MjDq7TqENexsNz7WWnHnboW9aFQi9D1yqX4umpUqGkVCJero?=
 =?iso-8859-1?Q?CKqfJj6Z7zrZHNCOoXBS1shHuP9HWoElTM2K77R7kXqLrqZumUb5OKwZIw?=
 =?iso-8859-1?Q?+lqG31itwmCdzFW/7EnAb0uKt/vSKGyBaaS9+JUA7m8xob6S6kLlrVaY+0?=
 =?iso-8859-1?Q?Nc6zmuA1BMdq3CDfQ9eJCDajX0PC57sW0lbnLuT9YEOdEBUl3m/m5Fh7Vc?=
 =?iso-8859-1?Q?MyOrbGZeyt0q04mnowLz6NlCWHC9lRLRs214DL30Zc+CJqhrUvnnRI2s5L?=
 =?iso-8859-1?Q?HIhc5epfm64sN8idQIuhQ4HT3rRqNUqpz0BiQesOYFh8v1FZhZAmrMsW84?=
 =?iso-8859-1?Q?2/CxlUvzDd8GWodz3UnpWIzjKbGiiUV34SHwrUY62GAk3po=3D?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: hyperstone.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: e38ba1a5-c374-4af3-acd2-08d936db43ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2021 06:42:41.2284
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 86f203eb-e878-4188-b297-34c118c18b11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5GudH2fPqBZfqv8t27BzhfwHEV/GzupRDhmRekkAhKOiIex/XpXhCBXLx1UVOInlle3yFw2rR0cd5whvDtzmUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP265MB2007
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: hyperstone.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Greg,

>> Prevent NULL dereference within get_kobj_path_length
>> 
>> Calling kobject_get_path could provoke a NULL dereference
>> if NULL was passed. while fill_kobj_path will return
>> with a sane 0 for NULL, kobjet_get_path_length did not.
>
>Who passes NULL into that function?  Shouldn't that be fixed first?

It seems to me like here specifically it was a sd_open on some no longer
existing device. I agree, but could not find a fix for that, and even if, it might
not have been in the current tree.
But when looking at the kobject code it felt like it was meant to be safe for
NULL, (like any parent in the tree can be NULL), but the do while does hide that
a bit.
So is it not meant to be safe?
I will try to find the sd_open issue some more, but cannot reproduce the issue
consistently enough right now.


>Pleaase always run your patches through checkpatch.pl so you do not get
>maintainers asking you to use checkpatch.pl...

I did, so please tell me what part bothers you, so I can get that fixed, either in v2
or maybe even in checkpatch.pl?
(Only thing I spotted now is the kobjet typo)

Regards,
Christian
Hyperstone GmbH | Line-Eid-Strasse 3 | 78467 Konstanz
Managing Directors: Dr. Jan Peter Berns.
Commercial register of local courts: Freiburg HRB381782

