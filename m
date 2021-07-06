Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35F2F3BDD27
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 20:27:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231355AbhGFS3F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 14:29:05 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:58867 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231276AbhGFS3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 14:29:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1625595985; x=1657131985;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=U7Rcd/MP3s8gvcjpjJD6UAS6NcP8vBtrbPVW9dx8gOY=;
  b=PbpB1cN4v8hwLNJtrfUq1U9yEb21rY8+M1U5cKbSA1GcoNdBjM7Wajg9
   h7ndkfZY6bRIrIplfC+b0RxwpjAZPx/+pWydBdgOaC+FVgzKOXWohyXeC
   oT+e7uLpjpnb3aC8pv5PzoHcCRUazciZXhuha+kQ9DpIJcvNP9BZpiIpH
   3qt2xoKG5bPGw17T4S8+rW7bLrfZJdF43wE9i7fR9dyOy2nQ19wJ7hvcS
   mfctX1uUgh0x3g3C7/9Em22TFkPgmqis+2eanYJq115GLZ0uceakmz3Z4
   pIEDiIRxwMDbm2cNz1yxTMvp5KcgNX9djvXp8MrYXL8oPa9DkQIQiS7Ig
   w==;
IronPort-SDR: UlVVTEIViv34vI9BTvhv70JrNudAJmwikWialDzUdHgvzaz+u8227B8lCjyxWF5xEOozsMVi1X
 Dxs0jV+0LLf2QO1ASYT5LqDYmTUsfrT/dKVn8Xn1Csl1E7AYBBNIboHOUZBxz8zhVwEDKmGXA9
 kMco3jf3eGs8xe8326vurNHhOQpPnIoX0Yflzc+GFVbhIQmk4m7dLPFIG2aWnEqhEJH1oyLYID
 Csd9rR7pL1GWturs5IGBJkxHhfVxS2/3kmxDnfTlq16zRxP1JZ0E0xKxemM9ivN1gH6RzFHuvX
 inA=
X-IronPort-AV: E=Sophos;i="5.83,329,1616428800"; 
   d="scan'208";a="277649165"
Received: from mail-mw2nam08lp2175.outbound.protection.outlook.com (HELO NAM04-MW2-obe.outbound.protection.outlook.com) ([104.47.73.175])
  by ob1.hgst.iphmx.com with ESMTP; 07 Jul 2021 02:26:25 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TZFMvUMKViovqqCVUaDU6UpSccjNr+mSAryCeaXqLmDcTCcl4iBiLVOqqSTiCMJliZt2IxJh5dbDGIr5px+yc0oNTzrEg0ehEwJ0GBvWV4Ycn9bZ+S8T+AB1TZqq+kSKSeXNtZ89qm77zPZI2j9V6ZMsUOdAE33PdeXxJUTM46j6qEZSgln3/4NjhdbJt28mAaIuvk+bCePUbAV/7mm7ujUqy6F+90B6HYFTyEk4wtpE20wyJmkg/rCRpWfoWXI+aWAEltf1Lr0ovqsuvmjOf4xiMzNPGmTgUAcmPV4X9Ff69b6fLuX9iRoyJZx0Sabl/fnWtsej1/E4XO+T6LFEjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U7Rcd/MP3s8gvcjpjJD6UAS6NcP8vBtrbPVW9dx8gOY=;
 b=dgOFjtFU9epODu1mj9b/X1dEYy26wG19J/1u5Mv10A+HmfwrYKqxZA4Gg78BHl8r5u5vbd+X+TMiPfjYc7zuuRypasuteJG9wRKOsEb1d1mHy4UV2THW+BKFAgnphnW0sxNLNjAnHsu82aY0VkWVP3DbSG8DviIqG3nasm58V+9EVdYQUoyInIPo9wq3VOQcVltQ8A2gLgBXcqymJfzepTeFoajekYcLqaF62z79zazBMwAYSB8gmvXL3uRJ6bm8RXSOtdCET+e+s8XqTUOsK823ePOmeynuAE27VSsfCR/00EniIVq/4l1RGmRM1eMsOg8qWR+ttvMrYmBPWueIvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U7Rcd/MP3s8gvcjpjJD6UAS6NcP8vBtrbPVW9dx8gOY=;
 b=Q7Wtv5loL2wOk9uhRyBpXgYN4MsgfqpIpzld4Ux2bMGKMm68GK4KRckyocyQA7Io2dUftBYjy4+C5yFe5hTgn1ZdvKcOJp32gPu1A9LsasKMytGDwbfPhvVgseMV7A7pOUpNNqvf68nAgro9oE72yRpkrO13VBGAk6tPPtvrQHs=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by SJ0PR04MB7423.namprd04.prod.outlook.com (2603:10b6:a03:29c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.24; Tue, 6 Jul
 2021 18:26:22 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c026:2bf9:70fc:4999]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c026:2bf9:70fc:4999%6]) with mapi id 15.20.4287.033; Tue, 6 Jul 2021
 18:26:22 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Colin King <colin.king@canonical.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC:     "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][next] nvmet: remove redundant assignments of variable
 status
Thread-Topic: [PATCH][next] nvmet: remove redundant assignments of variable
 status
Thread-Index: AQHXcncrWvc0ckRe8UGBmMjb9aYIlA==
Date:   Tue, 6 Jul 2021 18:26:21 +0000
Message-ID: <BYAPR04MB49658C0C1319D1A8B30C7DAB861B9@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210706145650.32555-1-colin.king@canonical.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: canonical.com; dkim=none (message not signed)
 header.d=none;canonical.com; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e41bf8a3-0c08-4960-90a8-08d940ab8e4a
x-ms-traffictypediagnostic: SJ0PR04MB7423:
x-microsoft-antispam-prvs: <SJ0PR04MB742384E7DC95BEE5FC859B25861B9@SJ0PR04MB7423.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:556;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zLvI2Wk9UAnHYzPXnoDN0XzueR3yl8/LBhMm/PwEPIeelUrHoDSENnwuMMTPOHlQ0ar2rrbekCbd0C0bx52SE2hddcCNlBG6D0RAAbhEwLkkXGrBDTOXf8d0s5UZFLBepHmzHp5PA+S4nNaj9wAwsq60Bj4as51OnKKTtl4iYs1zm8Jl79POGW6x5agFrOSA+acutFJptxhUhuQMP0wpCdQRIwBgXaEjtlGddVWtuJhc9rVC9AFdEP7/djQDMM7hpQA92wHC/KHrZFntH+Ap+7h78gZnJbQ+y1U6/RyNsAX2vRMGleDkwpa20lKeL8oEnwl7KSWv8uqqo5llz3vj+lNw8PT0bl2nkPk2eao0dppYLpZHA24CS9/WxEqMp1zvVV6Kf2DhAuhTXkdE1qbnbuLiW668hYTT7Ew+2Ij6SjEVYP9aHg2MZOFzUwbhFTz2T0QFrOsCErhqo0T4c/WAnebZ33ZM7OCPS4RYV+6rXqIX4QKvuzQXS9mdDlVtjg2pFNXgYNPRV9CXJeXcA6urQgtVuWG077WgEV6G98uP9yoIs4g719Yceb+oO5VssdyDV8b+FNzD46RmRr+KOg/fxdDtjDXnzp15riitVbXo1X1K6LrWL4NGt/muYo3eLRygB8XShgJG1u2rBZexSFNXGQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(366004)(346002)(39860400002)(396003)(9686003)(55016002)(53546011)(6506007)(86362001)(64756008)(8676002)(478600001)(38100700002)(2906002)(26005)(186003)(33656002)(83380400001)(4744005)(5660300002)(4326008)(122000001)(8936002)(66476007)(52536014)(76116006)(110136005)(7696005)(66446008)(66556008)(66946007)(316002)(71200400001)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cC/HwhrQCIy7b4SRhTFNHo2bnMqjfchIaoA33cz9CxT4fz0cSIffLmiGOnhs?=
 =?us-ascii?Q?Uq6lzU+vKTuU65XBdlNunMPo5f/zgo22sEKqrNXViUJ4qYvv75wypXHjpO7K?=
 =?us-ascii?Q?j5Ey+cUNSVDMaiRds0b0BLaXDldWvl9Ypc5eMXWU9VN/4JFHaNfaOKh5Dr34?=
 =?us-ascii?Q?eQFje9zmOOO6JQlD5M6DZKV8/Ng6vUePXaOs+PqJ0hi3s1EtFiJWTcVGayFC?=
 =?us-ascii?Q?7VIceqvjHeaJ/clbQjL0FPxYqM1yq8CX4B7VR3htAURWhbVIpurjR1dvKquo?=
 =?us-ascii?Q?kq34aRsRuZVTUkmnI1Uac8HF7svBY8bToouExFawvXVI5a7GFsKizXYHW5gT?=
 =?us-ascii?Q?cz9kRGvnQUMHfBLL5Y+r3lUdU+acrwS5dSMwfrJNGFgUg6UnSIOoNiykgitP?=
 =?us-ascii?Q?ahQDualuReSc8cZyFQ/rBLXEgVRSSWoLYtIWM/SAm8cEXj6rGY9sN8c1pF+d?=
 =?us-ascii?Q?J80BGMQ29aMTvYv02dde312Uj0PIGKO8JCuV3PUV8DjdqRX9ExQWRFhUKL5q?=
 =?us-ascii?Q?bZrXtOAi7gwxW9V/npiNqiGAByWLnAH7966+FOOXbO5b79qBWM+IdsWWjf6N?=
 =?us-ascii?Q?0+eunSEHY/uU3kKijG4ANKdZirayS9qW+VPQ1a2FlVpxkz6oh46andSpOey0?=
 =?us-ascii?Q?NbzeZbTZ5/TTtfFwoKcZpBWzE7yMrD0BpvV5jHIXPe1H4NYZx2wZ71kv/AUA?=
 =?us-ascii?Q?OIiKO8r7KhPUwnyNfrJsdU2I23mWezNrHBOMNhIyhQDyHKS286GU9dnCw5JU?=
 =?us-ascii?Q?3ar1vDzKhjx25BRKh3r8a3JyDEv3Fl4t5taP7HKhpOuPBK5ntflG74S/AcIX?=
 =?us-ascii?Q?x3M7MYfwxnf58D0kCabv/hFKktHJdvZ4mjSTPWwZy8k5HVW2QTjQRfdBngz6?=
 =?us-ascii?Q?gyk336T8oNeeVIVocXyMZxfDuy6E3w527QRHk3M3/niUPK+SEkicu4rysD/W?=
 =?us-ascii?Q?oPngDYcMwxFCWxnxkse61jaMAZl6SsVNtNWRqvEEQ2EJHbNi+Hxji3Lze5oy?=
 =?us-ascii?Q?O8Uua8uSNkNMU99DaXxxaqrkg6igtptMJKPj780fIDGPKuOC/9T5NijGLJNw?=
 =?us-ascii?Q?mttjXQynnvanjAg0SlfhdbU8AD1ZVmvhYflWInJKnCRF4XF9aohXI3OFeT/6?=
 =?us-ascii?Q?uUZ770TwuO0hPCJqdfQjPRlUXwTxEuECaEcVs1RYM/ehm686Wrt+AWMExarJ?=
 =?us-ascii?Q?T8pI61V/HnqFIU7WtVEqIfwsI0FPvo5vR7tqVdzZgG3RSurgDiKGiu1c467T?=
 =?us-ascii?Q?0rMFUC2XCfMAKWUuevd/2Zltk5eSiNZdZUZfwaC2paFqxuQu6faZTF2P+oGp?=
 =?us-ascii?Q?1ads1bRveWoAXSsqBxRTi8bi?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e41bf8a3-0c08-4960-90a8-08d940ab8e4a
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2021 18:26:21.9523
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eC2LY8sX1vEuLzeEweMBYI4Zjf0NZhKJ2ZQ/rOXE2zZRF+H1HxJsk5l/Pfgytgw6VBjFYhkK+xaMRImbkNqZss7cQPxCW4FhFd2/1H8Ljr4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7423
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/6/21 07:56, Colin King wrote:=0A=
> From: Colin Ian King <colin.king@canonical.com>=0A=
>=0A=
> There are two occurrances where variable status is being assigned a=0A=
> value that is never read and it is being re-assigned a new value=0A=
> almost immediately afterwards on an error exit path. The assignments=0A=
> are redundant and can be removed.=0A=
>=0A=
> Addresses-Coverity: ("Unused value")=0A=
> Signed-off-by: Colin Ian King <colin.king@canonical.com>=0A=
=0A=
For now looks good.=0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
=0A=
