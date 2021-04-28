Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 458B536D99E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 16:32:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234553AbhD1OcW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 10:32:22 -0400
Received: from mail-db8eur05on2082.outbound.protection.outlook.com ([40.107.20.82]:9772
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234397AbhD1OcS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 10:32:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gKs0bI6S3ZkUXW5TAjmyaZ6AyW4nA4DOtiTEiduSY7x9aot5gt5SlWvmhG9NdAT2ppGIamcVugnOp0CTEpNcU1wLqWZK1nI99eLBWmFUjZQ3VRgkQXsb3V/RFcXKlrgjyIiysBAX2+9Ih3UXuMSR8CjosegTt7beKfqUQdwmtRIyrR5HRhgEWWDN48sHM3q4g1qfemIIE7N7hK61JQ2bRACkiZc4tkmK8AuU3C02bw+Qf15Y9UQnL4WMk9oOLoxdZn9f4M5w23K+0dfMc5yooSVFa8BuYPZAvq4oELewjW0mVxIj+Bi70NKn2hlbFnz07XmuBilZkWIpgVfWUZRpyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ET8SSGCAA3N3/owTc7yQjlnnSHs3SZnQCbSCO/Wp6wM=;
 b=FbOUEZHyYVfynW6YaEn3azun+UaLf76uoarziNplDoqXJU8RKRbS84Dxi0KepIIYL5KR9cyrSSSQ09TCgMJbdEc2YhzGxGAvE5EDEZTHGNUEgcsfWznxzK9yWib+EWgdnHSZSPJRoldMvo4Nfhsocmki8XDj5zUG02pc7Lq6e2fFwFejpqt4M/CcpRzaVAj8kJzqT9EVJlMRa5k9CFtbtVCqKfYtb9IKHCjwA2r/lPygs3cQWY+aWZ41r5KyO/a7pHEkH01200FMk3r3Hzh1i/gMXiqTmY57HbO7SonbZQ1fHpcY3PCRypTZtTUJxtEChXP/4K2JzfExjfEdalhjAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ET8SSGCAA3N3/owTc7yQjlnnSHs3SZnQCbSCO/Wp6wM=;
 b=chDCZTlULX1gpAu4FnpUacFIsWRNyLxRIwPNWktGVUrXHNzm9UcpCROj9sRZoxWqdFXRSepRDQonNRpCFPqhvRyxSnSmb0yYX+nC7JIVe6GasnafjEe6KbP9MnYjXnC3iTBJUl8EgbhS118WeIxGfjVUZ1/4PjAAr+BeSKe55hg=
Received: from VI1PR04MB5136.eurprd04.prod.outlook.com (2603:10a6:803:55::19)
 by VI1PR0401MB2302.eurprd04.prod.outlook.com (2603:10a6:800:2b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21; Wed, 28 Apr
 2021 14:31:29 +0000
Received: from VI1PR04MB5136.eurprd04.prod.outlook.com
 ([fe80::f0c0:cb99:d153:e39b]) by VI1PR04MB5136.eurprd04.prod.outlook.com
 ([fe80::f0c0:cb99:d153:e39b%7]) with mapi id 15.20.4065.027; Wed, 28 Apr 2021
 14:31:28 +0000
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     Zhen Lei <thunder.leizhen@huawei.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] lib: devres: Add error information printing for
 __devm_ioremap_resource()
Thread-Topic: [PATCH 1/1] lib: devres: Add error information printing for
 __devm_ioremap_resource()
Thread-Index: AQHXO/hNg2FtgmUgPUKA4YcddIRVEarJ/mgA
Date:   Wed, 28 Apr 2021 14:31:28 +0000
Message-ID: <20210428143128.cafwzjzgwhb3akbe@skbuf>
References: <20210428063203.691-1-thunder.leizhen@huawei.com>
In-Reply-To: <20210428063203.691-1-thunder.leizhen@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [86.127.41.210]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e9bfe40b-dfaa-4543-9275-08d90a524fa2
x-ms-traffictypediagnostic: VI1PR0401MB2302:
x-microsoft-antispam-prvs: <VI1PR0401MB23027C5F8FE2B9FF63A349DCE0409@VI1PR0401MB2302.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LwjucJvEccn5RCNLAUzg1F5o70UjzQTGqY9xoJCCsPIZdQDEIDVvUipGF/HMPCjnqksDjyt5ZljKGxk1uR4Pr6EE73z+uKcnrHAhCbzPKLTyOXEtTKWU0c+Ei7HK5AHab+Bbmri35IxGUmRWSMCzcV47cYhklXTmo6OiXt00WvvnyHjMK7Ytsy9Nfkh6F40jWz1ju1l0LzmrPr1j6WX2l7csMBk5J4ENpipkkXGruyU0qvhEplByUiNRmeBWuhAJ1qrJ/veQgmFQ+mr7fcpZxQqFE2XSbglxVqJroKwkIkwKP/0MDPhRYF2g9zLxOCP13T5n4Ke09neyv0MmiW0CESOQZUIxFicNuPgTh5fy334x6cQUd30hB+ySlC/HC62CQ03731Sx6pwUFT7uLYlMOtB6eqZUel0gomx55BHwGeHg/F07B1r5otj+IDFFE3FDReZa1og8ByTIQWwkt0Rd8ejmc5lYlu+HBXCrecYfvIdQLh8eABKdgQIa9WuslMaPIaBiDq+0r2DUiv7vH1QSGCH2Jd0L5m2HyopffbwW4/EuCjjGIgqLr6nVu9Loecv0ZFbmalEtguym+9KrVYWeRxny39JMHb/0d2D1UccHNbE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5136.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(4636009)(136003)(346002)(366004)(396003)(39850400004)(376002)(54906003)(6512007)(76116006)(71200400001)(66946007)(66476007)(66556008)(66446008)(91956017)(5660300002)(64756008)(6506007)(186003)(1076003)(4326008)(2906002)(8676002)(4744005)(9686003)(44832011)(33716001)(8936002)(478600001)(6916009)(38100700002)(83380400001)(26005)(316002)(122000001)(6486002)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?MghgkF3ayW8W7Fp81Cx2U6CEAvb8dcF7/dvc+tMTo7I20TPuiE9P5auF8fWU?=
 =?us-ascii?Q?XJg3m5rXTlw51XmCf3LNyxOBkq6UlvNednaZ4mG2uF4kk6ooNdpzGcdY21dh?=
 =?us-ascii?Q?bQiGtpvBecv6EKeSp/HsoWp7wWbtgqt+taRYyjWXhgnMJpItHH0kE/ELkyCQ?=
 =?us-ascii?Q?ZC/tM/PRLjFqGkj30u6S5tLcLqMgWxEjK35+XMaPLHE8PWE9cbLOlxr8+jot?=
 =?us-ascii?Q?ZR2yjuFC/bwpMpDDsC4ES6T52XVGL20gcLjb6uQ8dPPkAED7O0VFu1CmgXse?=
 =?us-ascii?Q?mGId8qFUtBPu4f62v71W6Mn2JV5Un0wXwzpJ4sXbs291da0sXnPLZGIOZJm9?=
 =?us-ascii?Q?OVO5J87TFyU5H0AgWpGi0Mr0TLuu5FpeAFi9ajPDTh8+ayrd840/DozgZhqT?=
 =?us-ascii?Q?013kzF2VKfqIgm/tT/sHNVu6ZEFVcHSHIxEP4b7NN27FcYo5OdfgtgHToGZ6?=
 =?us-ascii?Q?fGUjC+3TY+Um4yFPdpsv0TDR3OyAtV3S9GahCfZcKCNyFnJ6Ajv8lMt31lUW?=
 =?us-ascii?Q?JwA4ypv7DmOfMzHZgzSSlw7aKsR0EEtDk0/Ekil/6XCbfdLYarchVfIhB/Hq?=
 =?us-ascii?Q?cxwx8hp+eQJbzsiJk2RlWwcGalu3on57MrMd9mBc9U/Ab8306Y5HNrzIfDDt?=
 =?us-ascii?Q?n92/x9h7Dj7/76w2ApgvDxgfL1xI5yGVZXHqnffEIPAKmCU0FBgouLbdnVdc?=
 =?us-ascii?Q?c2G3KlV6JVorLss1F8Y4pLA2Ed+5yPyufKLah9TPqKlVW91WhmgtNw+asfol?=
 =?us-ascii?Q?XcoB+8Pxfzx8dZR+k+1K8ovEobWfKOHPvRrLBhsmOfWjuY/Y2KZlEInzzY9D?=
 =?us-ascii?Q?EzwoRyuYK0W8DJeYJ2bH8QO7uKvPjoE4YYZlVjwvZ2bhU7j6CLyPGsBva7FK?=
 =?us-ascii?Q?6HUyYIYXo2VMntSDAKcWutzVbMOf5H7kY/p4mr1ABU80Pc1fPbiO30PWitLG?=
 =?us-ascii?Q?SQa7MQt6D5aZkytQRq4fFYpwAMpwdqO5VZCVbBiS2OGXoHEhG/4IoBcJKzIP?=
 =?us-ascii?Q?CrgdkaTmst1SAACIcPcWIEctyNqYsPx598rSlrBmLxekT/V6vRmDJySqKyr+?=
 =?us-ascii?Q?/KNB1jYEWck2zOERvuCm6bZOTEn/1aiJTNl4SKWGqVYvi9ZHr/uOLy2RImCd?=
 =?us-ascii?Q?MMdvtII7JGv4V3JxHEHyW2MudG/2eWzi7HlGfkbKOACJAyp2pz45ZnVG9pDf?=
 =?us-ascii?Q?fqoouKfKLlfNb4QOGPLrXVeKMk44zDvfJmFWnLTJ3wHvdhafILwWPKnez5Gc?=
 =?us-ascii?Q?i1CsJShfBvRrYDgclSWtHSGIInDCl1rYXoFGSPysh43ufwAKdpeRf1GI2bEp?=
 =?us-ascii?Q?/+C2z11YqaiwSfFxJT14+DZy?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <329EDA4CC76034409CC067393348B791@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5136.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9bfe40b-dfaa-4543-9275-08d90a524fa2
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2021 14:31:28.7907
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FVz+HYHm+hQhlFwIADyLmbqxXu9Wq1k3wW6kRTZXErhgelurzu5jrkOO0blhuqq6AUxxMjZDEbt+iEzEXVu3rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2302
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 28, 2021 at 02:32:03PM +0800, Zhen Lei wrote:
> Ensure that all error handling branches print error information. In this
> way, when this function fails, the upper-layer functions can directly
> return an error code without missing debugging information. Otherwise,
> the error message will be printed redundantly or missing.
>=20
> Fixes: 35bd8c07db2c ("devres: keep both device name and resource name in =
pretty name")
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---

A Fixes: tag is probably a bit too drastic, but anyway:

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>=
