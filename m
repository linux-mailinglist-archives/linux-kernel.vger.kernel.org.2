Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 768ED390016
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 13:35:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231686AbhEYLgk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 07:36:40 -0400
Received: from mail-mw2nam12on2072.outbound.protection.outlook.com ([40.107.244.72]:46945
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231127AbhEYLgg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 07:36:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y95F0yQ5Y9TyAOrBcWXeSgmMnFbZX7zDr85jrEoHjtfKLFGwd0/BnkR8kerg/PuRK3sq+065OgzBoRMcKgtqAlsbqq9UZO2BAZixRP3mVhQStsK9ZvimORC7pPyEMDA8p4tvH3EYpzqXJq2lM5p3YXLqZfHiIcnGZjFOt0QWdAZ49BR2D1CxlyClRePP2RTHAFMYYa2CeAzzH0iRm9Mul9R1COibfZMPbEVvpviWCtRmGAe0mJRA28soOlCmzNiUpvwjnVGlLlwy9l4ad/t++a4I7FFXV3O+AeAGIY9EEf/X65gXFgxcFV1mDmfUk8WZKJSm5rU19qcPcQddzMvfYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=53HOcoM9yELm70S0YqVL63A/msRDL34nENAb/kHNg/Q=;
 b=Z3wfvPUXkEWP0r7p54Swo1Aq7Eavyj4nYdOic5vf9wWNBuQeOX0hYv8ZIa4XI8heSPj3gGDaX2M9KwZRzuZd+OgEc+8zpS02uW3l9+PsRtHyuHXHhtFjGbyYEDeIoFzpajCWfF/jpskHCBisKrZsDJ3sWRSmOeWPB8Ld5Z808EMW8uuHxEZc/bzrsO4u4IdOI1fCacXYkugsPBvcxvbP29krMKKFwkZlGqgSn86CtwytbFFkhdGs2tUh12ZE41CfSCquxRbHZNrtJ5k3VUZShZhL0Phz5cwV+mnHg0MZl2M+2Ai4HcSjok3Kn2CmMmFcAI5A26mykV4FW51KMBZr4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=53HOcoM9yELm70S0YqVL63A/msRDL34nENAb/kHNg/Q=;
 b=oIR9aRu+9yoWmxoinqd9j9in3gLoL4X1ZCfVLXLkJmTFjhJWhdlgsT63JZYwMR5BYGZFFO6WALmV+KdWT+qttCLBYvkb9lXqMhDsZGbbOSc6D7G0JECC3mT1e9lJrhXa9vskie5OHGVQSFOZs9XfDXqxh87Vh2AlmEXYXSLcdUs0jsy0Bxj9jfiXUbl2eq+mD3jEmCBt1ArcYSnJi3slbNLihM2tovG+XXolJo5SddhPRuM66Le9g8xyelD8c/gYiSNk8RhMnmDHxPhPgFbsSkGwgIQxlkiFKIi7z1k5lvGrKt4aKgYhh8Xkd8nKb/4Uk6CBJkgroa40iU7Lz0QwAQ==
Received: from BN6PR2001CA0008.namprd20.prod.outlook.com
 (2603:10b6:404:b4::18) by MN2PR12MB4437.namprd12.prod.outlook.com
 (2603:10b6:208:26f::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.27; Tue, 25 May
 2021 11:35:05 +0000
Received: from BN8NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:b4:cafe::d6) by BN6PR2001CA0008.outlook.office365.com
 (2603:10b6:404:b4::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend
 Transport; Tue, 25 May 2021 11:35:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT036.mail.protection.outlook.com (10.13.177.168) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4129.25 via Frontend Transport; Tue, 25 May 2021 11:35:05 +0000
Received: from localhost (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 25 May
 2021 11:35:03 +0000
Date:   Tue, 25 May 2021 13:36:30 +0200
From:   Thierry Reding <treding@nvidia.com>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Lee Jones <lee.jones@linaro.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH v2 3/3] Revert "usb: common: usb-conn-gpio: Make VBUS
 supply optional"
Message-ID: <YKzhPnMU3PXx+tXK@orome.fritz.box>
References: <1621406386-18838-1-git-send-email-chunfeng.yun@mediatek.com>
 <1621406386-18838-3-git-send-email-chunfeng.yun@mediatek.com>
 <YKezl0nlWFQhLyf/@orome.fritz.box>
 <1621835511.26501.14.camel@mhfsdcap03>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6moWkyVZP6DJIGB7"
Content-Disposition: inline
In-Reply-To: <1621835511.26501.14.camel@mhfsdcap03>
X-NVConfidentiality: public
User-Agent: Mutt/2.0.6 (98f8cb83) (2021-03-06)
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eda579cf-97a0-47e7-7aeb-08d91f7124a4
X-MS-TrafficTypeDiagnostic: MN2PR12MB4437:
X-Microsoft-Antispam-PRVS: <MN2PR12MB4437681DB128DF1350C41334CF259@MN2PR12MB4437.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LYKDasZ1JmfOzmdqeGTgeiR9NwbgDnSpZOBmB//uuDGFkOcE1Uha/5JqYj7uAtuviy2znvpX3aTN9FhCRDM8XJMxtOdHXko8jHYy3jK9vCIGVg0bR3HSSeVfl8UbBcatazp5jevby6hcFJtVr2GsPHz/pGkBYg8/PNuNUZEnFDUDUKmwXP/nn6fVSS4O0uXOTc9WlCuqpCCEeEfQjZYcacfSS9q1fnh/6edpr7Rzy5gtX7KgxPiN2yzIGeWKkQrIwmrPUWM1J9Zl11/T/vRb4wDF5GLeL/+Z8pfWr5oU+4+gJJyZafBCVig5OLl+GXOLwDO+Y2hH1alhOjwalkz/SywlBtoXT8ta0T9pYZDKO77fpFDHOHvbhTM4hH2+sWfBnsdqFUXZ+IPtaqWb6F+Qqd7AqNfuSxv0mNikWywRb29YRzz464QL3QZ8LCQXNz4k6NdfMsU3uIGH7ZeGvT8KS/KraDTOyoJpODTdw8UneVqqP1Szc4uXB7BqohDUvGVbP01rdHBNtdWI9mPnUR2NllVLxQvV9kRYGXT9xyQf4ONEEzq8zoqCU1lVqjghL0KBXHycoJp95Xnkam9LfpB697NSuIDCWvNSqcrUovXyNIAm+2B3E9PG9nP5Hp7f/eB02+LYNA+928GvLvc82Zv9pehKpEziUPHH7YhIIAVnZyM3U97WE2Ww8CiF/39FXXSkMvZhfFcit9JRrql+E819dw==
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(136003)(376002)(39860400002)(396003)(346002)(46966006)(36840700001)(86362001)(2906002)(478600001)(6666004)(5660300002)(4326008)(70586007)(70206006)(186003)(36860700001)(16526019)(8676002)(9686003)(54906003)(8936002)(7636003)(6916009)(83380400001)(82310400003)(7416002)(36906005)(44144004)(21480400003)(316002)(82740400003)(47076005)(26005)(426003)(336012)(356005)(2700100001)(67856001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2021 11:35:05.4481
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eda579cf-97a0-47e7-7aeb-08d91f7124a4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4437
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--6moWkyVZP6DJIGB7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 24, 2021 at 01:51:51PM +0800, Chunfeng Yun wrote:
> On Fri, 2021-05-21 at 15:20 +0200, Thierry Reding wrote:
> > On Wed, May 19, 2021 at 02:39:46PM +0800, Chunfeng Yun wrote:
> > > Vbus is already an optional supply, if the vbus-supply is not
> > > provided in DTS, will use a dummy regulator,
> >=20
> > That statement is not entirely correct. The dummy regulator is
> > substituted only if the supply is in fact not optional. The idea behind
> > that is to allow DTS files that don't specify all required regulators to
> > get away with it, based on the assumption that the supply is one of
> > those always-on supplies that are often not described in DTS.
> Yes, you are right.
> But from the point of result, it indeed can help to handle the absent
> regulator.
> >=20
> > > the warning log is as below:
> > > "supply vbus not found, using dummy regulator"
> >=20
> > And the reason why we get that warning is to point out that the DTS has
> > a bug and that it should be fixed (by adding a proper regulator to take
> > the place of the dummy).
> >=20
> > > This reverts commit 4ddf1ac79e5f082451cd549283d2eb7559ab6ca9.
> >=20
> > But if you read the description of that commit, the purpose of that
> > patch was in fact to make the supply completely optional in the case
> > where we already have the VBUS supply specified for the USB port that
> > the connector is parented to.
> Could you please give an example you mentioned?

You can find examples of this in these:

	arch/arm64/boot/dts/nvidia/tegra210-p2597.dtsi
	arch/arm64/boot/dts/nvidia/tegra210-p3450-0000.dts
	arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dts

> It seems prefer to provide vbus supply in connector instead of port
> according to dt-binding

My recollection is that the above (or at least some of them) predate USB
connectors.

It's possible that we could convert the above to have the VBUS supply
listed in the connector instead of the port. However, since we have to
preserve backwards compatibility with older device trees, we can't
revert the commit anyway.

Thierry

--6moWkyVZP6DJIGB7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmCs4TsACgkQ3SOs138+
s6EOrA/9E77ghrgkWT2zfVOb/ncuXBSAQeTwDMEllA25DFvOL7IDy+1m9ayU1WNW
2UIY9b2lAmvXnwuCq6e17RpNT6Kstpc7KLtIUzkO7Bhx0XhS0rM2J8Lmb3ibpwT9
JV5nb96d8B67fecVCLoxIMSPaYmLw3aZzYKcrg3F7aJBSbzmkP04zusdpBV80nSK
yfQ8stt3DFI1Q+Hv8W6/v3gtM/lgLve7OUlxpX+IltUqP78k7PPdLi4Tz5vjsbm+
71KmpzyAnDMtSM4GEWG3U6zKaD4YxpdCeYwP9N8oXEfDZBPrEiLohxGuaeqJK023
d56NO62yJuKyD0YDOOyKyxFcZOfK0HBIO2M7YGNU0jR//JSw8RzHF8NwewPGpFTo
Ss3pP4fqLFu0FbFZAzqp1sZPgxBJ8kaJ8XobwO1d+eRSFaS8jlLcRkL4uTI58wEN
d5HtBzVh0s/qfTHRHbQDGYbs2whnHfAJHGwqDso1hNklYD3CnDbIsIMJD9l1emCU
uFcJYBPEgjNRwyBC8rTCNWDl4d2TO2GxIsKhd2j37ONyPIc/DmzgxS+ehFelMgig
l2mvqQk3c7dwUl7Aaxf55sxWGQZ/00KDDnNd4+ov735wFEVoGJFltqcNlfee7vge
bPENAJtpaX8Am+gdpCxhdbFviVGnevJKiEg0n/mKHm7BDkQ/knU=
=VjGV
-----END PGP SIGNATURE-----

--6moWkyVZP6DJIGB7--
