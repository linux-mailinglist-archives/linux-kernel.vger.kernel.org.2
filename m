Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF0DC45602F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 17:09:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232882AbhKRQMp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 11:12:45 -0500
Received: from mail-eopbgr670078.outbound.protection.outlook.com ([40.107.67.78]:22208
        "EHLO CAN01-TO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231167AbhKRQMm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 11:12:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WqtpFVufr1Am9yO2nwEpoXKefJkgzxghUyWYwTW95G9sSLGmH8xlz1fmsN506sRJtHSYc0x4NcG2A2R+vaG8i/3ePMXtkIPk72qb93OJfPgmFhU9SxqZlL98pUhmZVf9e3xUpylfF72Hg1/FIOwYeuCjaZSU7VH/Aqn4zW6Q1vth9rPxQGzeIWW6l/jJoyfpLsnqUpOLgfSeFYawbvhSEVTb5i2ukVVAB9Aphl3hfdVQ08JkhzVIlfAhZnFjYRLidj2pVuBINKzPBMho13JRiNUdeRXN5Mn6X6plyp8FoQN08UTMzVSJ7WELIrEDTd1fut8dh9DFTNmN6WbqNU3z6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cAgF33b2l8cBAHlnYCrSXB0tLe0aOSc0KGkW/AaDIII=;
 b=CS1n9KXDiqftn46C/w5epF8Ew81eQwgnOwiTSgXESXBMEmCAsEB9dHoZ1vWzHomSZtYR/RIB8mhnCffR52hhOZGFYJtGQ+THeLTfZ+jDP5zr4sBP525PGHz5v0hIcYBvxJIDwAybPAFDODi5y9faYsInTs+/ecnlfU0FhzEH5zkFNB0FDQTWzatTJJSZqG3rBjcf+glLpV2wJjAjgG+xI4SXZPqcLQmRMVvHJNk7KXwl+p6B/G96ugHehGnZp4VOQA1v8OaEzLlOHY2dQpI4/kM/kw1wzNjZihDWRsm7sWf+irRioRfrRqw7mGktz6A7oYCZiMSR7Ufivtl0Qho5BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dimonoff.com; dmarc=pass action=none header.from=amotus.ca;
 dkim=pass header.d=amotus.ca; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dimonoff.onmicrosoft.com; s=selector2-dimonoff-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cAgF33b2l8cBAHlnYCrSXB0tLe0aOSc0KGkW/AaDIII=;
 b=INFoNHdS6VUVR2qwhp6M4HnJfdETzEZIdwqrCx9P7Xn45trEY2UF8NioKC8qYABdm8VT8gMPUdK9Mw9JF6R6mut+KVeAFdKFpdycO3Yy2Ub9qRzza5PyubaG1Sv9kCviKcCWLSQtq4DG4hTb7gBgMf/+T+7dHaVQiQ0begpyAQM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amotus.ca;
Received: from YT1PR01MB4485.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:40::10)
 by YT3PR01MB4963.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:4a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.26; Thu, 18 Nov
 2021 16:09:40 +0000
Received: from YT1PR01MB4485.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::2cf6:a5c6:1232:6810]) by YT1PR01MB4485.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::2cf6:a5c6:1232:6810%4]) with mapi id 15.20.4713.022; Thu, 18 Nov 2021
 16:09:40 +0000
X-Gm-Message-State: AOAM531QdqXA0yNhSFaaggF0MdM+lwRIHduwgs5ZLsz9ICu0CX5wCBQD
        zi7DnfvFf89HhUd5HPLZwjf6wu/qe69ATg2erEM=
X-Google-Smtp-Source: ABdhPJyLKWbrLYFtVK/PoXQ2tDQQjpVACuIU7YUEBdsun34EvzbVtdbQ18+6ms5Kyy9AdgVdLzDC2wypkjt+H+iemlY=
X-Received: by 2002:a17:907:1b25:: with SMTP id mp37mr343498ejc.140.1637251777185;
 Thu, 18 Nov 2021 08:09:37 -0800 (PST)
References: <20211027200223.72701-1-ferlandm@amotus.ca> <YZUFYsaskqDan6kF@kroah.com>
In-Reply-To: <YZUFYsaskqDan6kF@kroah.com>
From:   Marc Ferland <ferlandm@amotus.ca>
Date:   Thu, 18 Nov 2021 11:09:25 -0500
X-Gmail-Original-Message-ID: <CAMRMzCAUw01N_WmriwGV7rJu9D-rwF8xHuwySZpsw7eQfb0OMg@mail.gmail.com>
Message-ID: <CAMRMzCAUw01N_WmriwGV7rJu9D-rwF8xHuwySZpsw7eQfb0OMg@mail.gmail.com>
Subject: Re: [PATCH] USB: serial: simple: add sierra wireless xm1210 gnss receiver
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     johan@kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-ClientProxiedBy: AM3PR05CA0133.eurprd05.prod.outlook.com
 (2603:10a6:207:3::11) To YT1PR01MB4485.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:40::10)
MIME-Version: 1.0
Received: from mail-ed1-f44.google.com (209.85.208.44) by AM3PR05CA0133.eurprd05.prod.outlook.com (2603:10a6:207:3::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.20 via Frontend Transport; Thu, 18 Nov 2021 16:09:40 +0000
Received: by mail-ed1-f44.google.com with SMTP id b15so29303053edd.7;        Thu, 18 Nov 2021 08:09:40 -0800 (PST)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 791f8665-0ded-41d1-3ea9-08d9aaadd376
X-MS-TrafficTypeDiagnostic: YT3PR01MB4963:
X-Microsoft-Antispam-PRVS: <YT3PR01MB49633D4E43465BB78C08E428A09B9@YT3PR01MB4963.CANPRD01.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9Ny/B+KpEhZEK4ScWQwr7rbCjknZEaVJ5XhCtI8YamcBdiBjpAYJzCcLKYtDV1RIRg2SCrxX+jGeB2upwxdzYtTEIFzkTxvJoaL00UVF492Gxyo3AuyMtOodCITzXuAmIHha6qBi01lk9/+G+stYVfXAixW4Yvg6Hwy4zXsdBj3EUYl29B5A3xHmVFLnYyTx72Ywqb8raqh+AzJHgkYy+Sh8/sKvnq4llWXd5pkYcspCyEFmHjStaBOv2AkVAFgORbihha5fMp8iug/Ros4XxUf9ncBcnsXK6eaUHM1TVvQWWfgZrPUZewJaJvhtuBnynXpuJiATMJk/OlHjL/qj69IksO6OPaZl9J4R21WjjB+S1px3Nb8p6r7pK0JMFwMUUckJw60NSdv0Q3iRYm3L6cG6rIO0TctJIZQoAFoyxVJ1OxJWO6IW9SfnV1jm3fxU5Io1Ut7bSOYHytT6IohwEZ9rZpc4BNX36TSHwSUtMUqaNkwLmdcmYaXUqUTVkXSCSCjXN6P806He+Ew6jGjArtsi5ZfZAZjoa0XvR1AArvUVg28UIbRu/GZFND9NSfqhd62ZciIeZPRsEI7l82SS0HK3DKrKoa7Qgt0/IrD7PQABu4tR1BDyNJvT7j2RvqMnqaLrjNm8qLmY91BU6UVBTOLmbLOEEG0st/rucwUOoj7qRiXi6uN5mrpIuXBuNYjv/JL0U0EWFcPQfnxB9hor38u0w2nBAV4xVLm0pj9C+OF1+A9CqFjYk3RTzmlALlNDgxnTBFIdO1QlXw4i1TKfo+65I7ob6LCdAnJuWYt3E0Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT1PR01MB4485.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(396003)(39830400003)(136003)(376002)(346002)(366004)(8676002)(26005)(38100700002)(55446002)(9686003)(6666004)(38350700002)(186003)(8936002)(42882007)(6862004)(55236004)(66476007)(66946007)(66556008)(316002)(2906002)(5660300002)(52116002)(4326008)(83170400001)(966005)(508600001)(450100002)(4744005)(53546011)(42186006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?czdYbi8zcVFJaWlWS1Z6MXNSNlhsRFlWdk0zdXZZQ2dkdHlZRmpOUzZWcFRO?=
 =?utf-8?B?cm5RbEUyVUtxUmJ5dldYNlptcGFjQmRURDJFREdwbjRPZHNXL1ltQjBGbGhw?=
 =?utf-8?B?UWZJeS9wR2o1cElPMzh0empZTm42eTJRVVhLcFY5SU81TkNORS93NWV2Q3ov?=
 =?utf-8?B?MmsvRGdhYVpEVm5NQUw0SUVUY25rcFMvYlNlbG8zaEplTFVpeGVZRFFMODlS?=
 =?utf-8?B?eXg2VDBaR3h3UkQ2YmVWNFZuQVpNQkRJWVFZMWVUQTJDVm5SNit6K2NMd3gy?=
 =?utf-8?B?SVU3elZJdHBNSGdCaDdhMnZmUEdMNEJRMXY4NVlPem5LY2JaNnVJSEkwYU1D?=
 =?utf-8?B?aURUOUhaNHh1OUNidjdJN0JNVFJOK0FRc1pqTTU4Y05VcTZxSXFKTlo2T0hF?=
 =?utf-8?B?VEw3Y2NMUHFCYVA0dEtwU0F1emJTK2UvdWtLNUhPZzFQMlM4Q2wweFd4ZUZy?=
 =?utf-8?B?aGF0ekdWME5LMC9oaFBMUUVsREdyRXNmWEdremgwL2lIcUVEa2JZRVh6Vzhz?=
 =?utf-8?B?bXhZeHgrUytnQlJxWjZVTmtneE03VFFwZnN4Z1BKQ290eWliUzl6VzJUVmpx?=
 =?utf-8?B?YU1DelhhN2NCcHcyaVdOWWxiYVk4YUIvRDRpOTVMUXZya0J6NU02R1BlQW9U?=
 =?utf-8?B?cENjakt5TXdvM1NTN0U1ZW9DMmJ4UnZONUdDTzMyRk5OQ0p4TEpJK1hhazVu?=
 =?utf-8?B?dGhOYXhBaDlPRmRaQXhqQ3NJSWhUbkJ0T3FaV0g4cnFoMkJ5Y2h0aURhMUZh?=
 =?utf-8?B?b3dwY3M4clJnSVdHUmJ4TThuSk9reTRqNDgvcnZYMS9SVVZxeDNsTy8wNmU4?=
 =?utf-8?B?SWpKb01IUGlmbnFUZ0lISEZtenI2TFRqNzQwSG9ucXNWUFNSRk0wN0RUTnBy?=
 =?utf-8?B?eXJINlZLOVZiTDcwZFh0b3dpT1hpY2h2a3VMVm56ZHNYSjdzWHZFdWU2ODkx?=
 =?utf-8?B?a2c3ekkwN2U1dDVWSWJBcFFLUUlGL001V1NyNXI4RTltZWZVR3hoMmUrcmMy?=
 =?utf-8?B?QXFCNC8xbnR6TzdjRklZaEtpbTNuZDdYR1dNb1lZaG1DaXhEejJsd2VwT1dj?=
 =?utf-8?B?SUdEbXhOdkwrazAwTG1hQkJsOTZVM0k2UjVXVVhNZThpUEltSmdndkN4OUsy?=
 =?utf-8?B?Z1dzcVoyZEdPS3ZyVkFlQmY2czZsWU9sRE1leEVVNGV3ZWQ0OTFKMjJyMEV4?=
 =?utf-8?B?YThSU3JUVU1pN1k3WGY3Wk9aL1pody9VdFB4ZWUraGpNZFVsakJSQkdWWUU2?=
 =?utf-8?B?dDlGUFpHR0YrWXpiQlMyZ25GbnBLUkNWT1Z6RFVOTzRIT3BDWGhHVnduaGJn?=
 =?utf-8?B?UWZhRW5zVSt0YWc4SGNRWXM4YWd3OWhtOXhnVUhXcUNUdkVSNlhYeEdFb1Ba?=
 =?utf-8?B?T0hibUsyWFF3WDVqZHEwMllTc2lWRXFob2hNSWV3c2ZPTDBVRllJSW9kd05Y?=
 =?utf-8?B?VHFXa0VJN0pzMzA2NWhJbXg3WTBzNHQzQkhsRlZNdEtlMmsxZVN3MTBYYWdn?=
 =?utf-8?B?aElPeStBblo0M0N4cG9zV2VOa3FZTGpjeDlHN0QyY0NuS0Qra3VZM0dhakxP?=
 =?utf-8?B?bndRMGdxUm1qc2FLRHNmSStSZEVUWm1jZ29UaTRzWUV6T285S1pUZi9TNGQr?=
 =?utf-8?B?aHhmelhTTXdCaU5JdGlwVmRFd0VsS2JraWdsd1gxOW9lNytOYnNwM2Q1SHVE?=
 =?utf-8?B?b2tBWjBGeUNTYzZvUTlVU2dxT2VVa2VydU80SzJLV0hhVjIxRmwzV2Z1bWJ5?=
 =?utf-8?B?RkFvNTFUVFgyQ0F0Yjd3QlNDRFZYby9sSHpwakhyWnRQeGxZWm96cGNxcFBV?=
 =?utf-8?B?dVM3aUtyYnV6bnJBdXdYdlJHaHN4cUlYNEJaYkV4V3htUUdxZFk4QkdXbmRG?=
 =?utf-8?B?bk5EaTFKcldITlBFQncyL29ESndWdlNtcnRVbHJoQnFyUnUwd3pxWHU4azI1?=
 =?utf-8?B?SmVJcW1VcGZTME5zcDdZUDhBbnY1ZjB4Z094dFhUcnpDZDBrSEdiL0ZBQTRD?=
 =?utf-8?B?MlJhOUozSVJ0M3dOdTc0d1JaN3A5cEtVdXlBSmtOYkd4bUdOYXhrbFRnVk9i?=
 =?utf-8?B?ZVpGVnJMWVpqOG9GN2Jod2ttWjhEMDBCbmpaQUtPc2VLZTNuUkNpSWI4SFhE?=
 =?utf-8?B?Y0RWdlROSG9hR1pHTVhjS0tMMVhXMnNDcG9RT1BMeHNobXpzbDFJRGI0VlNF?=
 =?utf-8?Q?xQh8mCbfzuqMFy7n6phGyqg=3D?=
X-OriginatorOrg: amotus.ca
X-MS-Exchange-CrossTenant-Network-Message-Id: 791f8665-0ded-41d1-3ea9-08d9aaadd376
X-MS-Exchange-CrossTenant-AuthSource: YT1PR01MB4485.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2021 16:09:40.6080
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: c4063547-e5e6-4866-a386-58c3965da102
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /oWDdl8ItpjD+Mx5RAaUlufjvWZ9FEqD85PegNj0faXjg0eb/13dcDL5P4EY//kfq0lv9ePQ/rZlw/fmxnV8/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB4963
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 17, 2021 at 8:36 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Wed, Oct 27, 2021 at 04:02:23PM -0400, ferlandm@amotus.ca wrote:
> > From: Marc Ferland <ferlandm@amotus.ca>
> >
> > Add device id for the Sierra Wireless XM1210 Multi-GNSS module.
> >
> > https://www.sierrawireless.com/iot-solutions/products/xm1210/
> >
> > $ lsusb -vd 1199:b000
> >
> > Bus 002 Device 003: ID 1199:b000 Sierra Wireless, Inc. Sierra Wireless_GNSS
>
> Why doesn't this device work with the qcserial.c driver instead?  Have
> you tried that?
>

I just tried adding the USB_ID to the qcserial driver and it fails
with -ENODEV. Looking at the code it seems qcserial only supports the
USB_CLASS_VENDOR_SPEC interface class and this device returns an
interface class value of 0 (reserved?):

$ lsusb -vd 1199:b000 | grep bInterfaceClass
      bInterfaceClass         0

Thanks,

Marc
