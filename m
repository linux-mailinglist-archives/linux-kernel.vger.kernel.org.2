Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E63A3E869B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 01:38:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235473AbhHJXim (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 19:38:42 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:6482 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235495AbhHJXik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 19:38:40 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17ANbFNS010712;
        Tue, 10 Aug 2021 23:38:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-id :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=KRmlu0nEMbTspuRdP3KyCrZR7KkKMaGh3nbxHYATXVU=;
 b=AMXj4QcBrUpTg8pD3NVz/gpXc3znHYZHlpEWwSc7supJHLEmJdsB65U1oBlGdGDgGzYZ
 Ip5i5axTglX6BY0MncWawj6YGkxX2AWOPNsnGivQDLNP9oFPguV1ghWR4mt4FjyhzDmq
 VLpgEOgiGY09JBPrAKzzgFZT6con2Z5KVuJ+5/b0SL5vHOXGDbtkSZ13I8WHT2gFbyzo
 XNZTL+eq4BBb62YhNiIACpCTi3u5Q6TaoTQklUyFxk0hqzMxgK5JP5Ele18z4ZePW3WL
 Z4tWPUERql5gjceJ0giP7gxOSSLe2oQEJ3jFFf0pMqWN/KMVM04FAAGDAxP7g3KNSgzy cw== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-id :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=KRmlu0nEMbTspuRdP3KyCrZR7KkKMaGh3nbxHYATXVU=;
 b=vW87UFvguDzRt/cOEkACZ7V6b2wAXmj2x2or4YExtW/NpK2T8ol9pNbqrqT23HPAww8I
 ZckqCSS3lqqY2R+OWOVLOTNWEnoMoeCt14L65vnlIUKkdf0Tv+W7Pk87l++w3KgJCl5U
 ugocQbXu+UxRSIGsyQb9NlXslSMfs8I9pObsVkXbnkyMZ1nwe4M2OeZK/zc4TVcdjCEg
 aJI/1AiCPACJh47QskzIqXYjk9y7MHSTpxs7tujCsNPy0YpFMqaM9hT5ZxsGqYi9f9pZ
 pUq0EtMJ9Co4ZL8V+TlPgIT+hsykqiIjoQh+uquB2IEZKTpSW/90PvG9UPVlaYGPixhV ag== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3abwkg8q3g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Aug 2021 23:38:10 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17ANEsuo158130;
        Tue, 10 Aug 2021 23:38:09 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2040.outbound.protection.outlook.com [104.47.73.40])
        by userp3030.oracle.com with ESMTP id 3abjw59chm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Aug 2021 23:38:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bu89Ow5a1E/L+caqqlxogGLKVzMY4ODlpS/YLGhuzcc4dtN9ZxB5xx/ANlKrlxthsZrETY9b1peyJDvZzj9WF9J4uXylTVj7ne0QmAZFmMEiiwfOTHV/JW1D/pKQGNVtVV0VGQSa2RXX2QnWZ1ZyQOsQOmZvX/90nDt+QMjpEvHgdRAoDkfQmTB2BVAsCkxcEUxE5+fdjH7gqQnKH23/bDA2ufQBkFgleKU4gfWynU4G7R3lxfr9BxRnSkJ5uO35Ufb6D+Q3YNoDA5KUCQuaUBkffDtPyiAXxffdcRghDojOdSy3Bpi04mSg7PWLjToM5NzIK6eaW5lbABOBw5agTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KRmlu0nEMbTspuRdP3KyCrZR7KkKMaGh3nbxHYATXVU=;
 b=j5r5e9Pl3pm9XSw4DBioOcH+0HgZFSh1CsVoFf8FlSylTBMiUze/VSTcjXpOSp229RFKoPH2E+TLjuBezQfb4VLqVtGswRKcHl4oLqJDruvNOzDo4FcmbxrcydP5smvDdGH/3OmjtFTfJ5zjF8+0kmYzxqt1B2vo3rtLmagfuBRxj8B0TTWwf/K/GqP1dwxDUuLXeBdCFpOrnSQZ9CsSdyamN+ga9V+g3YaVMKfNjnh3My8CP04FhdmalB73xTIo2jN+iJB7xtNZPhkRpm2Bf0R7NXNL2K6NFgHYgD5erH/ZjswQDRyV632xAYf9VrbFVF9YhneihqBkUOlKdDmUag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KRmlu0nEMbTspuRdP3KyCrZR7KkKMaGh3nbxHYATXVU=;
 b=fZIQnZsU+tUOeaE7MjdMR8ZmISvNCuO0w8+4ymGlKUnC5OFxzbyH0Bwt84Qs4T6zUBR4zDef6bV29mXMJPTyh2W/VBjTpkLlNITdUGSG6+r+4RG4jHYaI95p0wrcDwYpJsWdBdN9DD4tYNE7KVX9dCiZpqwZI6rGQipKrnyT4Ro=
Received: from BYAPR10MB3270.namprd10.prod.outlook.com (2603:10b6:a03:159::25)
 by SJ0PR10MB5536.namprd10.prod.outlook.com (2603:10b6:a03:3fa::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.19; Tue, 10 Aug
 2021 23:38:07 +0000
Received: from BYAPR10MB3270.namprd10.prod.outlook.com
 ([fe80::5d51:1350:5264:c4aa]) by BYAPR10MB3270.namprd10.prod.outlook.com
 ([fe80::5d51:1350:5264:c4aa%5]) with mapi id 15.20.4394.023; Tue, 10 Aug 2021
 23:38:07 +0000
From:   Santosh Shilimkar <santosh.shilimkar@oracle.com>
To:     "arnd@arndb.de" <arnd@arndb.de>, "olof@lixom.net" <olof@lixom.net>,
        "soc@kernel.org" <soc@kernel.org>
CC:     "arm@kernel.org" <arm@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Santosh Shilimkar <santosh.shilimkar@oracle.com>
Subject: [GIT PULL] soc: Keystone driver update for v5.15
Thread-Topic: [GIT PULL] soc: Keystone driver update for v5.15
Thread-Index: AQHXjkDFYUUTofriu0ORzgX/sjMVqA==
Date:   Tue, 10 Aug 2021 23:38:07 +0000
Message-ID: <0A637A41-2353-4900-962C-DBE50BBDE75A@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.4)
authentication-results: arndb.de; dkim=none (message not signed)
 header.d=none;arndb.de; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e66dde51-76ec-48f8-333d-08d95c57e813
x-ms-traffictypediagnostic: SJ0PR10MB5536:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SJ0PR10MB553626282B2DD845D902C05393F79@SJ0PR10MB5536.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:363;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7hhjnprmHbCP9C/HYI/AViM6nK9zVF6LPahlXQ6y6rmb6nPk5gPzPaZrWgA0kG67QNCmKtyTF36c/Z8c73cC1I1dx53WILT5fq2pZWLqqwtgWJcjp1FRY7wIIVlaEbsMw+o9nXGTqQaUiPWuv98XeiEk9a9RdrrDiVl6dI+9q+E59WaUlewk+6zUT7YMvz0l9R1qG4PEZyZLE5ehQXbW0IaROA76pq0R36MmFAN3zn2PuaXJvHmnp0avWHAV8K/lEWistshnUd2G/V85k6NuUA5ZA+7/BejCUhK73Sz6+cI0ouiAG5K0xgbM40s9mCP6/NynTRJJ+5rcD94XARuvNwOHPgXEIlxLoRY5gmcPCL7Fbs0C5/ZLvVOs49e93NAc8t4vdu2zhzD6b6ntUS0g/+qy3TRu8i7Qrefm8U3GFNbaNB834v48gDKccT42POocIRGAK169hcJPA1OH7WQcZtwTc6K9lkMZTnmtO8cINITLvWio+IiSpDkBgrZcfcU/rOEvsXo2PqWg2Eu46Apy4mUgGeMT0FyaxmUHsMjVVg89WGDu4jMt31ZmNZbiTIfXzlcV4Wyf3H0aEfIY22k3ioaYKYxvm4riaOKNjOlMhvyAnAzDMTrg/LnrYGX7iiAgFmqIMjQpr7Qr94TlWGGBCB0YJCazPDgEp81M2NkS9Y1aoZcEsqe+mUmTarpauzR1yQFuvXF6LxnWAVHd0XW0iP4XKX6LIWvyo20LCYw0NUfis4mddEwoW7xLmM1aIYl/
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3270.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(122000001)(4326008)(54906003)(186003)(38070700005)(5660300002)(33656002)(76116006)(66556008)(508600001)(38100700002)(110136005)(66446008)(8936002)(26005)(6506007)(6486002)(64756008)(107886003)(66946007)(316002)(8676002)(66476007)(15650500001)(36756003)(44832011)(2616005)(71200400001)(6512007)(83380400001)(86362001)(2906002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?n0FEANPmeW2RW60hWmBW+U4fbYImFRyETuu5UP7hxQPojDlFtlreczG9IVS9?=
 =?us-ascii?Q?KqiGEUVQ55xOYow895TgZLb3PtsJH3lMKZ/c+SdQRsVROzBtLSY3PDK0rp/v?=
 =?us-ascii?Q?wCrC9WKYJZVfUo00JwGCL7nxiVxLmJTHBrMwwmMf0a1n/irI181MNECrBXEB?=
 =?us-ascii?Q?n2SW9tjQ42f14nPcm1Lf3A4EQiueqBVJPOPuIQRPLNoQkf+060c3Ul4NXu1r?=
 =?us-ascii?Q?fCErgcl87tV34zUD9LWdUKe8lh9so/eEc8ilDBtDO+QVehfGvXm0ca9Gd0zM?=
 =?us-ascii?Q?aDjHyURye7CYbhMqSctG6XPdg8DyTq2ln0maPWTHjWYu74zv4nVpJiwbayZ4?=
 =?us-ascii?Q?ZQoNRyxnxISBhnNDz3LdkVr5t4xyadu9Y1gG7MPaHcrjhuZ+ka7viIsMphcM?=
 =?us-ascii?Q?AehogmrYgg+PYrfI0e/edM5gY2GSgBA7StT7PLrsKAT63ON+qKWOTdKmQnmf?=
 =?us-ascii?Q?eWv5OX1FwHM6FyJhojo808M2nkZ7Bt4bM/sC20qgGdRC97wa+heHmuJ7awrW?=
 =?us-ascii?Q?T6ly5yqSRqg/lLFIkDg/H99Y9/ScVuXT8BJe9LiDOo/XAuAwKhri0mOYjtMk?=
 =?us-ascii?Q?CSmx7UXKlwZ42bjr1Ahn1U3pBE0mSAF2GbUw13N9x5aXi6prTdujpDsHpNHm?=
 =?us-ascii?Q?1FbRrp3tpg+no1gQ/nqNP5QcoqTsYrRGer3h1XcDY34kSVGptxMIwM1C4/SF?=
 =?us-ascii?Q?GtDSGb8IiZxz3rV+WxmnaVmb8tkYS99Ki0usatWbnU5AS32vAtFTmb2FiK0F?=
 =?us-ascii?Q?caDDbazF79NuAMbzSssu4NVwUA6ZHRGDZBBJYoTRcklY8vV/p9LEA3ioHtmW?=
 =?us-ascii?Q?Zbzk1kdvLjjEE1Z4VBfU7mUV3POln9xlF7Yu+JRNMZm2BO0ABdSyOYMsES+w?=
 =?us-ascii?Q?5f6e+Qo4/JBd6kdOhouN6RFGysf8/EH/Q42iRJ9sQHN6BbfXAV7OX7dDZz4l?=
 =?us-ascii?Q?b8sbt04RCOzeql/ZSlxt1d3Uo4HD8rlru/LayVImho6p+IiKV0Ks5VuVx6+h?=
 =?us-ascii?Q?mrwJoYqu2Ydi+sXLJyyT3Z3G7m/pIjRAQ0GSo0rvyJitVUCniIXtcd5LVPP5?=
 =?us-ascii?Q?T2VI/joB60RIEBgHSflZkpH+VTOa9ib8juY27vGAdv98rTliFW/T70RDXrA+?=
 =?us-ascii?Q?g5liNrjZM9tMBo4zxa2V5IagPjwivWhsZ/VT5dY5cWsnDJXtk40cI1wqRrew?=
 =?us-ascii?Q?K6/voVOdWp6lq/Xe1kfRzLM+cDCUAxHYzauIo0CrqkIBwWpVVXF9YKWJM0lE?=
 =?us-ascii?Q?A8xyEg5yB7TgofUXd2ioyKaUT7KkMqEnzbrqNwB3IHFYKAn3Wtd398e3qUUn?=
 =?us-ascii?Q?lhi1x3pEqa2MKOSfjcVW3gJjyGrKytJVJMo1G9VZ8YDMNg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9BAD93D6C23EB845B6B205A3D236B1E9@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3270.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e66dde51-76ec-48f8-333d-08d95c57e813
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2021 23:38:07.4198
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Jvv2KO/5sQkoHpAF5TGYP6BuRxU4CgFyJwdtgXKI9p+kr/tykOj4X74KxslapBy/wlyI7D9XOBZnB7kyvOykFYq9Vf7TTfZ4PB5XBqw3AVI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5536
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10072 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=969
 malwarescore=0 phishscore=0 bulkscore=0 suspectscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108100153
X-Proofpoint-GUID: dn4tfVZhRolZSgBOdgDhKjSmw7_1shGq
X-Proofpoint-ORIG-GUID: dn4tfVZhRolZSgBOdgDhKjSmw7_1shGq
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit e73f0f0ee7541171d89f2e2491130c7771ba58d3=
:

  Linux 5.14-rc1 (2021-07-11 15:07:40 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux-keystone.git=
 tags/drivers_soc_for_5.15

for you to fetch changes up to 62e8ce8506f5a998796dbdd93363fbed3342d379:

  dt-bindings: soc: ti: pruss: Add dma-coherent property (2021-08-10 15:51:=
22 -0700)

----------------------------------------------------------------
soc: Keystone SOC drivers for v5.15

The pull request contains:
 - ICSSG subsystem support for Keystone3 AM64x SOCs
 - Removes smartrefelx PM dependency for deeper low power states

----------------------------------------------------------------
Suman Anna (3):
      dt-bindings: soc: ti: pruss: Update bindings for K3 AM64x SoCs
      soc: ti: pruss: Enable support for ICSSG subsystems on K3 AM64x SoCs
      dt-bindings: soc: ti: pruss: Add dma-coherent property

Tony Lindgren (1):
      soc: ti: Remove pm_runtime_irq_safe() usage for smartreflex

 .../devicetree/bindings/soc/ti/ti,pruss.yaml       | 41 +++++++++++------
 drivers/bus/ti-sysc.c                              |  6 +--
 drivers/soc/ti/pruss.c                             |  1 +
 drivers/soc/ti/smartreflex.c                       | 52 +++++++++---------=
----
 include/linux/power/smartreflex.h                  |  2 +
 5 files changed, 55 insertions(+), 47 deletions(-)
