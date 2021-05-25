Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19BAC39034E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 16:03:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233508AbhEYOFW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 10:05:22 -0400
Received: from mail-eopbgr30044.outbound.protection.outlook.com ([40.107.3.44]:4433
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233273AbhEYOFS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 10:05:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KLZtfgHAIdDN8GTcqgOwVEdUEVOGxg2lEJWohz7pzlrEEsk37E1axGI9dGC8utPnkaBwWc0vxZXqAAoNwD6UO8bQyDzfVnHfXzE4/RBq2PgrX7EhaT3dnXxx+GfNf7QsVLcaWl3BgpR4Oo4G4AWyVvMO6dJ2mTa9xOukcQ13KdT3jJAxdVmdOW9Y+ZCTph5qKoxrVVGxjYkjtJ6SraPm+JfjlLrK+skWciRbw05pPedA8vwSLIN1xYMAiwfe20vJsTICz0s/lwgag37xTnPExt3iejgbpIeQctWeOe4R2IHldN8ox/Yr5f+IAfpWvRJBF2SJhQ5SnM30iLAqVI75IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l1I0Fx4Rm8rHGyOMXgWpEHE4ZBhW1PA27gSkIu5hDjM=;
 b=mzSE4hV9CAj2UPzGThCs1F6mIgM4mQy0LQUIHpo7VFuXgmINpwZhS3WGltrDux7fSj124jS5GZEkmynUgEHiLqnODsK9dN6bYPzX/wp5FApAev19eEEmgkUqlAfo6m7njoPIwMB30jI9vBeS2mNzs17t0N8+dEoWtTNUUPJ+/U4ZhjiFhlt0vsNpe0BR83gBUXNw7JKZ2/rCcV4a0d6U0523xfX6oVOph3eF7Gi7rrZq79UuROIGwI0RDv3NYTFUZu2hGkJV5wF+32gQDE3zY8IKGjnazRXNUEfF8Pk6IdP7DZnXO3Hli02Xap9VFPZB7Q1KbsSNezTR8z9DwGULUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 139.15.153.201) smtp.rcpttodomain=sang-engineering.com
 smtp.mailfrom=de.bosch.com; dmarc=pass (p=reject sp=none pct=100) action=none
 header.from=de.bosch.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=de.bosch.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l1I0Fx4Rm8rHGyOMXgWpEHE4ZBhW1PA27gSkIu5hDjM=;
 b=ld1TjknxSUTz6UvbSx4JyIszIP6zlsM8f23E+1xBWRxvMrAxUe4b8SCXTFb3WT8zRmRQ3lo4YiAHJmCTkIQWHd89ZBE6EWp9bqcAnTo4UpYSRIZGJg/340Tel41TYaFH/A0uaCFHrDsxQ0dKevVg0UkOGkt1bwWvjtdQuwH2GSg=
Received: from DB9PR01CA0018.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:1d8::23) by HE1PR10MB1739.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:7:5a::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Tue, 25 May
 2021 14:03:46 +0000
Received: from DB5EUR03FT015.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:10:1d8:cafe::71) by DB9PR01CA0018.outlook.office365.com
 (2603:10a6:10:1d8::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.24 via Frontend
 Transport; Tue, 25 May 2021 14:03:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 139.15.153.201)
 smtp.mailfrom=de.bosch.com; sang-engineering.com; dkim=none (message not
 signed) header.d=none;sang-engineering.com; dmarc=pass action=none
 header.from=de.bosch.com;
Received-SPF: Pass (protection.outlook.com: domain of de.bosch.com designates
 139.15.153.201 as permitted sender) receiver=protection.outlook.com;
 client-ip=139.15.153.201; helo=eop.bosch-org.com;
Received: from eop.bosch-org.com (139.15.153.201) by
 DB5EUR03FT015.mail.protection.outlook.com (10.152.20.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4129.25 via Frontend Transport; Tue, 25 May 2021 14:03:46 +0000
Received: from FE-EXCAS2000.de.bosch.com (10.139.217.199) by eop.bosch-org.com
 (139.15.153.201) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2176.14; Tue, 25 May
 2021 16:03:33 +0200
Received: from FE-MBX2051.de.bosch.com (10.3.231.61) by
 FE-EXCAS2000.de.bosch.com (10.139.217.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2176.14; Tue, 25 May 2021 16:03:33 +0200
Received: from FE-MBX2051.de.bosch.com (10.3.231.61) by
 FE-MBX2051.de.bosch.com (10.3.231.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2176.14; Tue, 25 May 2021 16:03:32 +0200
Received: from FE-MBX2051.de.bosch.com ([fe80::ec4d:8bf1:e4f9:e31b]) by
 FE-MBX2051.de.bosch.com ([fe80::ec4d:8bf1:e4f9:e31b%6]) with mapi id
 15.01.2176.014; Tue, 25 May 2021 16:03:32 +0200
From:   "Jonas Mark (BT-FIR/ENG1-Grb)" <Mark.Jonas@de.bosch.com>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Support Opensource <support.opensource@diasemi.com>,
        Lee Jones <lee.jones@linaro.org>,
        "Streidl Hubert (BT-FIR/ENG1-Grb)" <Hubert.Streidl@de.bosch.com>,
        "stwiss.opensource@diasemi.com" <stwiss.opensource@diasemi.com>,
        "Jonas Mark (BT-FIR/ENG1-Grb)" <Mark.Jonas@de.bosch.com>
Subject: AW: [PATCH] mfd: da9063: propagate errno when I2C mode fails
Thread-Topic: [PATCH] mfd: da9063: propagate errno when I2C mode fails
Thread-Index: AQHXUWvh0ozLQISRlUGrPKGhh1oRSqr0Og6A
Date:   Tue, 25 May 2021 14:03:32 +0000
Message-ID: <31c67c873f564ccda7e0f1860ec13806@de.bosch.com>
References: <20210525134243.4003-1-wsa+renesas@sang-engineering.com>
In-Reply-To: <20210525134243.4003-1-wsa+renesas@sang-engineering.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.141.86.167]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a66d374e-246b-4f8c-3a18-08d91f85ea00
X-MS-TrafficTypeDiagnostic: HE1PR10MB1739:
X-Microsoft-Antispam-PRVS: <HE1PR10MB17398CF5C71324045DFBFA3FAD259@HE1PR10MB1739.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:1002;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: umhDUQw1kdrV/1xvcwcGke6JI9wsYB+33MaoH6NtOTRju1jDOfDD4aRtwpqe2zi9+G0vQUIDK+8AWS9AZSr9ofsRH+/CQO6csimtvkDU0clrVx+LDO3hKoQJWXp1atSlIKfLt7mVBohMzpe/mbrYkifBNDRi4I6aAy/OQhS4t3PcQoDJYCPQA4CZ3oSNPiwIT75AIaDN74pSA0pJmj4NNS0vAY1+h5eSN6uNbr1xpqSkA38Y7K9Or2G+fiDUq5ShiFbKqiDtbrsCkayXY8c5iXfyRNXWYwP6ZzG5pFCqRxu9S/SovKZctlViTxwTzE87KD7/NBtODJI7e4rVY7Z2lNoF+eE8ZGeeaOrmGKDPiWsgiX9fdG9VmVAToHxJ6wFuhdt5pfRtAezrrTRa0E7qTryQONVp4fA1LSGvATSorerGA3DbyYfxT+EjN1T+aJ2hKjAcTf/sv7kI1BvNKbgO61/ybvJQdqh3EFKVzQc/5vUXopS21mNfy7/3VENklnehqSL6WwXNjUfriE2WBRHbRz6F8aSQxMgdpqRw1NtqtWHGSPEQvFPO6DDVv/NN2yop0SUSb2YPN+WNxlDFYA6UCbQ7xw56W/k1Iq0USnLEr3ZaH2GucJxeaL5SaJpBKgMDX4z8tYVhIJNAa0DpgHswHmAEthCNGVA4e7Cm0yr+czehGaeJeom58Exa7PSu5Z2k
X-Forefront-Antispam-Report: CIP:139.15.153.201;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eop.bosch-org.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(346002)(136003)(376002)(396003)(39860400002)(36840700001)(46966006)(82740400003)(336012)(426003)(356005)(81166007)(107886003)(83380400001)(70586007)(70206006)(8676002)(8936002)(2616005)(2906002)(54906003)(4326008)(316002)(110136005)(5660300002)(478600001)(108616005)(47076005)(86362001)(24736004)(82310400003)(7696005)(36860700001)(186003)(26005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: de.bosch.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2021 14:03:46.5541
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a66d374e-246b-4f8c-3a18-08d91f85ea00
X-MS-Exchange-CrossTenant-Id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0ae51e19-07c8-4e4b-bb6d-648ee58410f4;Ip=[139.15.153.201];Helo=[eop.bosch-org.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR03FT015.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR10MB1739
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Von: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Gesendet: Dienstag, 25. Mai 2021 15:43
> An: linux-kernel@vger.kernel.org
> Cc: Support Opensource <support.opensource@diasemi.com>; Lee Jones
> <lee.jones@linaro.org>; Jonas Mark (BT-FIR/ENG1-Grb)
> <Mark.Jonas@de.bosch.com>; Streidl Hubert (BT-FIR/ENG1-Grb)
> <Hubert.Streidl@de.bosch.com>; stwiss.opensource@diasemi.com; Wolfram
> Sang <wsa+renesas@sang-engineering.com>
> Betreff: [PATCH] mfd: da9063: propagate errno when I2C mode fails
>=20
> Don't hardocde EIO but use the obtained value.
>=20
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  drivers/mfd/da9063-i2c.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/mfd/da9063-i2c.c b/drivers/mfd/da9063-i2c.c index
> 783a14af18e2..4b7f707b7952 100644
> --- a/drivers/mfd/da9063-i2c.c
> +++ b/drivers/mfd/da9063-i2c.c
> @@ -448,7 +448,7 @@ static int da9063_i2c_probe(struct i2c_client *i2c,
>  					DA9063_TWOWIRE_TO);
>  		if (ret < 0) {
>  			dev_err(da9063->dev, "Failed to set Two-Wire Bus
> Mode.\n");
> -			return -EIO;
> +			return ret;
>  		}
>  	}
>=20
> --
> 2.30.2

Reviewed-by: Mark Jonas <mark.jonas@de.bosch.com>
