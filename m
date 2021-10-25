Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 996B443997C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 16:59:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233721AbhJYPCM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 11:02:12 -0400
Received: from mail-eopbgr1410104.outbound.protection.outlook.com ([40.107.141.104]:30976
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233520AbhJYPCK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 11:02:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m6l85T+mfsvi9n5Ec9376ASHvIW3HzE4CvUjGzuTNaBCnDe8uKFohkyP6bRanDBxTIrGXbhtqGm+/dUOHkyRisD46ezzSftFr5ImLxMX/08dXObsHPhB04ZD1G1BuB6tD+mp18ZKWJ8TGYJ+Ejl/99iC5taANu1cUX+YPdZTndL9cPYUVhSVW7vao9tSyt3NforU+CdRb9pTwsPnbLUEuamohAsBEzdRyPipM9SqMjihuJGxU875U47iQWMgJyGWjdtj/DD0YrrtIqC4q2kcXQ1FjKUlxlnUiu7XqMa9fWXEWXW/Tgh3IKYpe4PIYwkc+VaFXnJ/wo7rqP/TVJmQ6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LcplUsXmmKr6AyHB+bKKuyHYQ9vM3Grrng3SpqpOzi8=;
 b=K6mvUqg8Af9sLCZNAlq5rS5nF6DmDoSxMgTPQf5KkSSB3ry0yPlwvoHP0G/aNq78xbXw2rbFOCAej6o+2jjx75GiihDrxpTP6LFG1bJZI8EjBbOOKrcXYw+Zl1ndS8KKkL263q5SoqFjTqQmaPWnshI3tJwNGHfxz0aMiRYcrt3idXgHTWli0djfroZSPodV0gBpHCkx9iRpdNELgqNcqB1P2IuUMUqxCeBiNumuL5hdggS1ey31vKcL19CayThzyEryCHe3vVAIoFizbMbduZtZaw0ULNucB54o7LotqXg8dXj6u66urQ/1AevsnJ1DbxL26QFEg5VqdLnIU6YBMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=connect.ust.hk; dmarc=pass action=none
 header.from=connect.ust.hk; dkim=pass header.d=connect.ust.hk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=connect.ust.hk;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LcplUsXmmKr6AyHB+bKKuyHYQ9vM3Grrng3SpqpOzi8=;
 b=C+ltqqOFIR510/FBiF7neyfwmhZ8nuF6hGdHoYP8iROAsD72uRIejbMI5zccob0zCruMqoh3qLUP4zS4+5lzxHly0xW0dxsmyleKeXJMQP7V1W849qyvVJGgpoqJC1QYNk2qcNIy8Uih9MUyBEzNOnh9ps/IksR8JJDEEeMBfkw=
Received: from TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:b7::8) by
 TYBP286MB0031.JPNP286.PROD.OUTLOOK.COM (2603:1096:404:8024::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.15; Mon, 25 Oct
 2021 14:59:45 +0000
Received: from TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM
 ([fe80::c0af:a534:cead:3a04]) by TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM
 ([fe80::c0af:a534:cead:3a04%7]) with mapi id 15.20.4628.020; Mon, 25 Oct 2021
 14:59:44 +0000
From:   YE Chengfeng <cyeaa@connect.ust.hk>
To:     "stuyoder@gmail.com" <stuyoder@gmail.com>,
        "laurentiu.tudor@nxp.com" <laurentiu.tudor@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: suspected null-pointer-reference problem for parent_mc_dev
Thread-Topic: suspected null-pointer-reference problem for parent_mc_dev
Thread-Index: AdfJsFoRJwVpy6fpTWOXKhK96VAHug==
Date:   Mon, 25 Oct 2021 14:59:44 +0000
Message-ID: <TYCP286MB1188FA8158C7DA86529E3F8F8A839@TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=connect.ust.hk;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 80d93b1d-b6ce-427a-5389-08d997c814e9
x-ms-traffictypediagnostic: TYBP286MB0031:
x-microsoft-antispam-prvs: <TYBP286MB0031647F2A80781BEAE3D8E98A839@TYBP286MB0031.JPNP286.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WWBwGt2yDl5xCA/VEiAIdpgLBWCW1uvieUXcWQXcQ596WvLefKUIq1KckhiMpIDBGOU29PgwAQwyDIQsK4wVU73cZqcxtb3dqWTf9SvV8amfDwJl/9UljHxzFSQzOujcf2Hl8r0EUvL35DjH+saWPPjw9Cumg4qPBJuYpIHlAsYVxrwe3l2sDlz1PqQt2IbIeAX6DI9vW6NMWe0VFNOc7tPVryirrkUdfLS42d9vRiA+ba4b8V48DNMAVgmgxiAdL/leGTVEpeYAUHHv//HtEVTMN2cZRhQEXwkX/HGDtzPjOEmJ76zaxdNfr4LTV5iui5ji1QC3BujjR/ziKjq1KNCfZNsMS+ayb7B5Cu/0p7i+4dKK8ip7FLF0AYLL+J/QrYCw2EOry8BZFbrQ+3ZlcUvIRCLuEVmmyb+5viQpn/0cA1pBsP7uV8M/JOcLOCTrwmSQ4xid6knlBrRKqyDAkKnJMnZYS26wVBsLc+xEr7is3vHok0LPl/zpIbBysAWhmY/xMMM1bzyZEIWIxhz0QiPtw7bBG8OrvQsaLC+2rrOVMIIimf8NLfmU+bIld0STpZdiuc5RZHocSnDurAcNhwdeI4uM7hvBOAqJYYcDsIRHpU66eKJoyxet5s0NF1StwoLgj50Wv0C7BhTi5hOwx878x7CO8RELZAaVMcIiXFmN3LiAwAIBaYCcQr2MUKRzJOFS4YSUTTFyQgUFuZRZ1adRpf1pm223CxBg77AcJ1vUUtBahN5kWIQzZQjYhkFLKbegUrtp+ScyAVoVF/1VbWPWUHK6hUaqm4lqZSBX4rc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(66446008)(55016002)(8676002)(9686003)(7696005)(64756008)(38100700002)(110136005)(966005)(76116006)(66946007)(52536014)(5660300002)(122000001)(508600001)(2906002)(4744005)(33656002)(6506007)(66556008)(71200400001)(186003)(8936002)(26005)(86362001)(786003)(83380400001)(66476007)(316002)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BE3X5asYJX61iBzmCtngqXFVgxq7DU3TSDwJSDVFI+DjGaeSWKziQwhhVSxU?=
 =?us-ascii?Q?Qqu9rM91UdV88pusUHuEfLmqOMzFm+Zl2fXMKuwqfiwq91dvN6DxUzBuXNj3?=
 =?us-ascii?Q?k9SQNdLBORHxHhi9zEr9yCEuu88mOrUFKPXz8MBMHapNKm3SDZbahHCzvJyO?=
 =?us-ascii?Q?+vn7J2jmDkTDpbqsSsfn6cU14VM4CwXu3l/wj9hMvM2n5fFTl9ZGsIg+Z7b3?=
 =?us-ascii?Q?Vq7ge+5eSndBh42ajGqZG1i5iKcVcRUewB/Sb4kLmagouRIgNpJ8kkENOS1k?=
 =?us-ascii?Q?p03p1yJTxr08kWgip9HZ4LjylSng200m1TX6WFUJwnKD/U9zI2nPQBg69czC?=
 =?us-ascii?Q?c04rlQ+VD+WGSJZNHDkWR5hFBpXCEXbA0Mgr7+AjTOUL8plgns5SsNia6KUf?=
 =?us-ascii?Q?hYR6y0GBhJ9huVY7RbV3dgE83JZAysiHL3Eqp67lbk7726kRmeaagKhxT6+q?=
 =?us-ascii?Q?XHVEz3gRp5x6Cs43QUlZpSJ2NQ0oF75GnErYWs6eVu/ncWAa/n4TUjk9JifS?=
 =?us-ascii?Q?aa4r5OS26pxnXUIIaBPv88QDqVBKzCb7mg/kHLc/67fa7mbS9WHPLTDPAv0q?=
 =?us-ascii?Q?lwOfeLhisiCK63FWODWtbJ2Lz4vdrnQWh5IAtlmtYwthMFRB21Aeb2p/BWxG?=
 =?us-ascii?Q?MJIhvgFws532PlO2Yw6kg1ZRbHcYajKBNAj9vCnRXgWFYrHdDA3xG+inGc3I?=
 =?us-ascii?Q?niMqw8INkzgsqUogu09bLBFbmXiSG4lu4zGMu9AOXI15J3bNIkBmNfdcUT1K?=
 =?us-ascii?Q?G7yBuV27dGqe7rXvdwDNGEcf8qSkRj+RxszByg9EkK2ax7a54g7KKlbpIZEK?=
 =?us-ascii?Q?le7RP+cZyZpGPOl2UbheAnypaNECKQzMbLm+m0Dhw/FHZrd9ozYueFy5XjOu?=
 =?us-ascii?Q?VeJGg7gYWDJMyqN2e7BSBBTc4+SEXuz9Nx3B7yjt0geKZAjIk27tf2FhGOJM?=
 =?us-ascii?Q?wtJd2qumS+w3hT3EaYkzo7JoKgE+ebd47ntfXPdz517oq4PL5+LhuQb3ihLN?=
 =?us-ascii?Q?jM4ZmswsWzppUcqEUVUL4NSuNxlItStkZNR6FpYVsb9JMNpkM/09JNF5RFtr?=
 =?us-ascii?Q?9lgH2+2uSe1TaAbktF3lBc1u/E419psdlFJXEWeeTHcLYk0TER9gTbnZb9Tz?=
 =?us-ascii?Q?TECesKYtRNGGrDef5comLUKN3JBawOxk04rXlVAXRKnHF+mnaoSka2RpE2wV?=
 =?us-ascii?Q?TGPIW+zFd1qkH52/Xuo5TpiNr2EEPgJOx7qNDbSagXQVi4AA1TIof6aZCFV/?=
 =?us-ascii?Q?QDIDvnx9jhbqAm7K4LidX/xg/O1NSDEUhqaBWLUKQuMaQ0pWcwiL4pgKiCQA?=
 =?us-ascii?Q?v+iHwRbkGr6VqqJj3PBf3/XFH0Y3EqNOKc9aykG9qOcL3z4huOYDbEVXxUq0?=
 =?us-ascii?Q?iBB7WxrOE/JmpOvjaZIncjtYncZ0dOi03fJyG+gGz3/eLbHW53FUEeUA/gkF?=
 =?us-ascii?Q?2uZq9hQWXkVA+js1qlDuKwEa9Bz75c/iL1OzN9rumYdOe7bHTGcBVHaJ6u/Q?=
 =?us-ascii?Q?mfBxsMfzQTRzZp/dxQ6FIMQNtU2Mi1zIa+WcZD7uzCHl+vuhleG8ZhkpQpXJ?=
 =?us-ascii?Q?bn7JIwtC+qUdvi1TeKCJkFxSv2N7l0lFUUKku+IYwTCaCr4kHTHQ6c1EixDV?=
 =?us-ascii?Q?aM9gZz2gV4UdXw+98ho9Y0A=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: connect.ust.hk
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 80d93b1d-b6ce-427a-5389-08d997c814e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2021 14:59:44.9207
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6c1d4152-39d0-44ca-88d9-b8d6ddca0708
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y2w8wz2bhYG1zwMg0aX6bEnPzRJ+KE61UfzK8jgk+giusgSDhDfyo4NV+8n3ZT34VqA4jnlJqtM6Ef/HpRxJWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYBP286MB0031
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

https://github.com/torvalds/linux/blob/master/drivers/bus/fsl-mc/fsl-mc-bus=
.c#L871

Our experimental static analysis tool detect a null-ptr-reference problem. =
It could be false positive, we report this to you just in case.

The pointer could be assigned null at line 796, and later could be derefere=
nced at line 871. We are not sure whether this is a feasible path, could yo=
u spare some time to have a look at it?

Thanks so much,
Chengfeng
