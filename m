Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF6383B2A45
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 10:22:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231888AbhFXIYT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 04:24:19 -0400
Received: from mail-dm6nam11on2084.outbound.protection.outlook.com ([40.107.223.84]:34249
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231821AbhFXIYS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 04:24:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hTEjPq6AhPEtiUPWhapGvbL6W0irvM1eYTAJyyCUwhnRI8wJMZYKRlGQEJjgx4RND2x38n6y4ml6haSsfNqCfNJx44YY1/VW1JPTxZQo4fZAV0plsAoSR+wxAT+IGt891Ego/esz97ua4uEPzBesRqxo3rawWHAY9U/TeDK/oU4nlE0KBR4jidufePgJUXxiMCH8ystgGGlwxTIDLLVw/e2ZeC13K3ROYHEpOcDLs4/k+QTnBVqj0dcwHrvF7IfKtfymxxLP2c/lOFMW+goPvSOAHACtlfScKphwqDYz5W80U/hk96Cmsu6Ri7evx0Fpg9aGL7k2ayDHDiybEjZKNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iyFG2p+987cnr+vkVap5K/fItk+5XSsLtu/HlG8i1Fw=;
 b=aAvT+n2Vr5MjTwkxFO/n15So12mm2yjA0rQtTwTSl37o5NeegU+nR/tkylO5saQJyjdAeK5MK3Ae+i2ciHM1qqxLvHCmRpaJ45Tk6fsH5zZOcxm/padzg+AATDVXHDz+h8m77WFKbIhAJTs8vAVcOi7A1R9MNIVhaDS72Rhv8p5n0H1N03X/0EPFfvqTwFj5WtFgwBKsf7Fa3qRHdhuU8oVMHcL52Hco8f3uItZHe139Yto6HGdp7+J/7V9GwvADLdEGtENrMIzpVYropW00v9SIYQ/0c7+HGRwwpF4v0BVsNoWtN9XCShgGHLjer/Ih0wX6wd4EdQIxFWlynFIIxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iyFG2p+987cnr+vkVap5K/fItk+5XSsLtu/HlG8i1Fw=;
 b=Ld8uzohNHQ3SkrE/KV0fzxgBCJCIH4khPnos61+EIeltnFxBGoJRr9Bf+cZAg9Mll2UKzyjgNPbAF/MOQOyzg5Gn9QfI/ieLjL0Bzzf/GFHPpxMaeOxyGU8M9vF+ygHwpteGK/pcmoQxOxaVBYnVjoTwxX5P9sPYhitN3K7DLCXQ5TGuL5VWi7sjv9SUnUOLZ3BqQ0YsentDgVx4X8MyX/yGdPVqbMKss09Ny9DKNM2NNrJY+wfPqRwjza33hrzi1wiaK9ZfOrOdX6KuYZBqvsvMBSFdSJIAciwyTiOXxR3lzybaheI/zW0H44Zfk7wvWyfR69SxmpOa6JU55s/k5A==
Received: from DM6PR13CA0025.namprd13.prod.outlook.com (2603:10b6:5:bc::38) by
 BN8PR12MB2948.namprd12.prod.outlook.com (2603:10b6:408:6d::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4242.21; Thu, 24 Jun 2021 08:21:57 +0000
Received: from DM6NAM11FT061.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:bc:cafe::6c) by DM6PR13CA0025.outlook.office365.com
 (2603:10b6:5:bc::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.8 via Frontend
 Transport; Thu, 24 Jun 2021 08:21:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 DM6NAM11FT061.mail.protection.outlook.com (10.13.173.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4264.18 via Frontend Transport; Thu, 24 Jun 2021 08:21:57 +0000
Received: from localhost (172.20.187.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 24 Jun
 2021 08:21:56 +0000
Date:   Thu, 24 Jun 2021 10:23:57 +0200
From:   Thierry Reding <treding@nvidia.com>
To:     Randy Dunlap <rdunlap@infradead.org>
CC:     <linux-kernel@vger.kernel.org>, Vidya Sagar <vidyas@nvidia.com>,
        "Lorenzo Pieralisi" <lorenzo.pieralisi@arm.com>,
        Timo Alho <talho@nvidia.com>
Subject: Re: [PATCH v2] soc: tegra/bpmp-abi.h: drop a duplicated word
Message-ID: <YNRBHVXE85JnatBG@orome.fritz.box>
References: <20210508064409.20387-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ffj5UvJDNhSxmbBs"
Content-Disposition: inline
In-Reply-To: <20210508064409.20387-1-rdunlap@infradead.org>
X-NVConfidentiality: public
User-Agent: Mutt/2.0.7 (481f3800) (2021-05-04)
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a473a00e-e8e3-4e19-405a-08d936e921f5
X-MS-TrafficTypeDiagnostic: BN8PR12MB2948:
X-Microsoft-Antispam-PRVS: <BN8PR12MB2948C817EC8223BD71041E8ECF079@BN8PR12MB2948.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j4WbW//Gdy9+lJJV9WPhK5CIHYl8m3t9hO2YW1MMztE0UqNv49E/RViGlnjBYin/JdVoDlGxlABZligid64R9iMbcbwkMmtUgm19T63Aow7KGNal09q5U68+90B84wcXRV7t9txYafQBx0Hb3w33mte8FO90Cr6KtGl7yJI3eriHBdVilemq05SZ/r7DtxOfgViZi6Sdp08Ezt3MZ6IrjsBk68INRfVu42ZHa+CC2xbEwp9aMRGOigvg8aMzC9cAWZ08P7t9rnMulv6EULbp/4LCYr43TEa3B8nASszkNHmmtTguZxhAT4ZBVldQKq1aBkdHEPzPPtZxjiFiCiXWQwRGQc2hmy+V0nZvMhSlTrld44bqs3o4VcgdTCSxAiYGMWIUsF8li/iLpX6rgWXmhPS1tpcs0QVcH1W5z7CkSSHHGVyi2cFbM+I/tWIcrlK2kp/bDd1X8//8uf1XCeK4oKVEJlPa2MATUXREKVscENUOuOyopv8QQWEOWUW+GXgs5ZTHwKhV7Yn5dSHeEkN2z9CrOOLDd9OoNL7CDUF/RIfZOb2RakCsF5qDuYE7mioAvjpEngG1rDyN0jyF+et+2+n0G9OHCp+xVHFdv6Yb9ig1lKy201YjP1Gr55qaE9k2joq6PaGctYe/iPdVJ0hqO3OYjwxeUjPSpq3Qi9X2C7SRaFca/6B1V1BsxllcRHJw
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(346002)(136003)(39860400002)(376002)(396003)(36840700001)(46966006)(82310400003)(9686003)(186003)(316002)(107886003)(83380400001)(8676002)(4326008)(336012)(26005)(2906002)(478600001)(44144004)(426003)(36906005)(54906003)(16526019)(86362001)(7636003)(8936002)(70586007)(82740400003)(356005)(21480400003)(70206006)(36860700001)(47076005)(5660300002)(6916009)(2700100001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2021 08:21:57.3577
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a473a00e-e8e3-4e19-405a-08d936e921f5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT061.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB2948
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--ffj5UvJDNhSxmbBs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 07, 2021 at 11:44:09PM -0700, Randy Dunlap wrote:
> Drop the repeated word "or" in a comment.
>=20
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Vidya Sagar <vidyas@nvidia.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Thierry Reding <treding@nvidia.com>
> Cc: Timo Alho <talho@nvidia.com>
> ---
> v2: rebase & resend
>=20
>  include/soc/tegra/bpmp-abi.h |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Sorry, this fell through the cracks. Applied now, thanks.

Thierry

--ffj5UvJDNhSxmbBs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmDUQRsACgkQ3SOs138+
s6FEQQ/+MI14fcDgGlPd43lbsEz5PY+/Vd2bl3Tsh6DL18dTNomQYabYD0rVszdS
chrdSEqDHbwpQERzcvRahCeh9IDC2utlyneEmt+SJBVfbGz0r+SZr3ZKyR/LJxkF
zZw/cJt8tRwKvO6rjxdbi3/zUc6TBq/l8mBikNzkypZ75bfDBJAEgwteiS/4FOO6
u5ZXDjnjzdj9Do9EgWY4YJGzuAbBokS0bP2QzC4VlZkqZegWZXuQyBibVTJQeQQg
Sw6tKdbx7HSf4/bWKqGqx/1QAiD/l5BmJxNdUOS8FXBiID3j1mtup50bjtStBiuF
Xfyor76fyZz9GbKYYyW3rboQnMuJDUwlmX1YQ9excswRfDQrBlhK+hvA4wYIos0F
HLkwDuVE2wX8vSWgtBaxxfLFsGCqWhp/HkNdwtXIuy4q2uT5RhtfqCkZHxgt5hN5
k/t9CrGtwy9ZRtTNRnWr8NH4fhWux6UmeCj9fO7+IRE7GX2MmKJoNzjO+iVBI3vd
Oz0OTvnDDj/18rKS9RQ2+5mD9R179u2UM9z+gN/ODoAV/NbL+R1sj373KzqFlrHZ
mz2gTex9mNtUx4qb+L0yJsJ0IQTJmRHRwhyynEBo0TGGY+H1IjKFaWHki5ZYV3pL
5Jl/qkBwSnKMQdFsWzx1L6sap1AN0f/ovTu9bcqRaqyS0ATWqJA=
=UHZ3
-----END PGP SIGNATURE-----

--ffj5UvJDNhSxmbBs--
