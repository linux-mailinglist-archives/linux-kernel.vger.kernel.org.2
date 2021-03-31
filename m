Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 359B7350842
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 22:35:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236573AbhCaUet (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 16:34:49 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:57829 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236460AbhCaUeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 16:34:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1617222875; x=1648758875;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=zEnzIZb6eGLG3Go484pM/SKOrs2zQ3PMZaAU/7QR21A=;
  b=k1JIYWY9iPJqO3CJfZZSWRnbeE4AIpFvMkN95eHwt9ShbzM8+6ACuQqS
   sd4LH8pFj5MYchUGkibUZLSadX8QqZvwnWII0VYeYi+YciCKMeppiqjB4
   mIIOpQ/r7pkIBAkwGdUsQVlmWHtWKi56dzVY8kPPAvliXid1T8iX3K1Dl
   5DsdhUdcKTiY09hUVUj3526AhV9eODKPJNEmYUh7AX9d5lyXgPerysOYE
   7gyJXSvRjpQHxOuDJUUc4WrWW3meCwieNjCLZzQdofDSQ2KCWgYSOf5wo
   vhCeL7vUg5GEt6Gc9TO1IbYnQwXhVJhkY5hFF6iV9kKJSoDDqNandtbth
   A==;
IronPort-SDR: Y8LpZ8I2sdQh9lNRVNPkkQRbkQgUxVT4EMM38WivqJZT1SGW7AE00AC42OHUKQrPq6te1btKk1
 sRrgCNqdzI//zintKJLLwtbEkTa3mATDZSB/jWLBRUV5EtroKax2CDMRDnbweRMVC+4w6Gq/or
 r8Un5CrKR/efdvDARzgY+mvRA9/8ZIssLuDqYIeehBiVH2XkslRNIq59i3UtvQSy+bp8UQ+WoF
 d76x6HlHwzudVMA+n5alcZ4ngSmA1TZeGgtStZ+ye2mZIjdgk8GydE3CXbJwJofz1uraGwEm3R
 KdU=
X-IronPort-AV: E=Sophos;i="5.81,293,1610380800"; 
   d="scan'208";a="163487209"
Received: from mail-bn7nam10lp2105.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.105])
  by ob1.hgst.iphmx.com with ESMTP; 01 Apr 2021 04:34:32 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RtN1HjBc6K2HgtqyC5gEqY450MPArKSefQ4b7NjYS6PrnWOPZE8vhxyzo5ga/fgonc33Q+G4EADmcPspCCszJm89cvSioLWvrSOk9cTjUTSvsZC2xoj2kzZfST9qwNds0mrYx7STJPtOb0gTWMB0OWnCUvm+Le/El/HFKmkFUAcR5dZtpQXvB+/MtcN0A7CpcKM8+f5HB+w8DnfnwuISKAW664kg8/KSOg32qRMFBPXqmQzn9fO0eaJSEnww6vnzIKm3++KnvU9JjLGljbrfg6wyUm9QxxymqFifZh7ushKxLy045BVQHBPpkaQhtYCuYG/13PSxqJqd/iM1e2vosQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=il3wUKTWuVxo+94hIrdRlLD9hTIWfB1/DhkNhQUIybI=;
 b=YexQ67GFh82LjiSpb+iGTPEXPgoVWesaY+AoPCd859DOO3LCN+U9EIAqJf/GlBtka2bW70zQrlkgMIxIdTCqpdtNdVvYd0g9k2OCG1oQyCcifzG1/+sYwK3FeA5/Fv41LJtm8YqVH9y3Z1GT/xGX/gUneEkhSorJY5zTl5PgSD093rNYe4f3kcVejZiIkncBvdwbkrW6Q+85fYEdi2j6mKwzaZHJqaxIhu6PZx/VzMMNakWOsGBJ0QfWibRKT3jUnD5WdP0RelViaotIB3K/0onp+fMCS2QZWNB+l/cnukN8CtCTrJJoXsd/KnTt4oqAMHupTUhMyL/wN4Xyfkc48g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=il3wUKTWuVxo+94hIrdRlLD9hTIWfB1/DhkNhQUIybI=;
 b=LLxNxOIEwt3S4/5txs7EjMzEmyP+9k8OWVlFbnmNppLzqMfZrW0YEFOb7xe0uQI8yG6zB8C1eMEkauq0xfUwIMENMPADuZt20SgwBQ8quxfRNHk/1ibXJwUuBZwdSnvi82MC1wE9y4ydQAisv7TmlDPPwofc6DBdxARxiJT15c8=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB5592.namprd04.prod.outlook.com (2603:10b6:a03:10a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.30; Wed, 31 Mar
 2021 20:34:32 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b%5]) with mapi id 15.20.3977.033; Wed, 31 Mar 2021
 20:34:31 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Daniel Wagner <dwagner@suse.de>
CC:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke <hare@suse.de>,
        Chao Leng <lengchao@huawei.com>,
        Victor Gladkov <Victor.Gladkov@kioxia.com>
Subject: Re: [PATCH] nvme: Export fast_io_fail_tmo to sysfs
Thread-Topic: [PATCH] nvme: Export fast_io_fail_tmo to sysfs
Thread-Index: AQHXJi+J720hbwseC0WZ8xLPt2l/cg==
Date:   Wed, 31 Mar 2021 20:34:31 +0000
Message-ID: <BYAPR04MB49658F0DDA22B253F98C6F3A867C9@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210331131228.131118-1-dwagner@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b2cfa361-350e-42bd-d201-08d8f48463c3
x-ms-traffictypediagnostic: BYAPR04MB5592:
x-microsoft-antispam-prvs: <BYAPR04MB5592B04995074271CA69061F867C9@BYAPR04MB5592.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RNDlETMWGRDaqTL3WuufCFZLeqGMDRNq7ldJ7p2E29tHikksHliwXgb0+XW1jDRuf+ofbFdsVBB6BlmnBXLmDiylgfJoi67/5+LCyq8P0+45y3KLNO14LfuZ6H3c0EZB6XeMGBApGkiLxmROW/ngO4fVoMYFH4ep3+i0UUS3k6LBx7B6vrAxlw2TCHVXiDsTcxDBjFsMzwqZMqNRm+5DZaaOfkdA1EpOUsSIdLkDP2ncX7sMGAnDYRzk9g5rbny2FROEoiULycYKp+jb3sHosFKVS3b7moYWEFibKkDA73Rg/8ztp8aVZymNfz/ni4TzQ7m5WZKtDHf532uGOukuKQ6YGXSJHYcgCIFHzQDi7+3nJ7eRf0kWc1hurLZItxRgO+r1jEsk+q0klCG5PvRIeFdhsE5sHlnHUeU4bQnuK5fruGMN7I/QBkXxuzuPwI0Q7D8CjKzF598/nZwkXoDVRnPitQkypXMvFwbkkQxQHUDHtNlha+Au2jMjpc6znaXYk2X/JPr0EH9pYhdSSnBYrp1laCvevPxny1TkjEr7jGRgyk+j3xtPgSfu2eiiEujpYufEc9QyWZPfpXCNN9ks5gFyBBteC/E2n/MDNTeFBuXqL+GB5EUGP4Y3zf20+i77kTYI2kMW5WAZK89zBMGivglndMaOSmFmd8XM359JWG4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(376002)(39860400002)(136003)(346002)(6506007)(8936002)(9686003)(71200400001)(7696005)(186003)(7416002)(76116006)(478600001)(86362001)(83380400001)(4326008)(55016002)(53546011)(2906002)(26005)(52536014)(66946007)(66446008)(64756008)(66476007)(66556008)(6916009)(33656002)(316002)(38100700001)(54906003)(8676002)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?h32wM/FXQ4E8Pku8Utx7jsD01NcYR3EZ0ErQVSxFOAnnhwW7Ztva18aoV3SI?=
 =?us-ascii?Q?RyhRx8lZZ9kAK8fZzCNRbZpZ0Ld4QHiTgHT2S9tVwuf5HELgFNSTsuH9N0Gb?=
 =?us-ascii?Q?0a3slXfuOcldMEv9ZXEOF61CLlMojVPpDV2gMn5Gdn1rw2U+rqO25B2ru0U2?=
 =?us-ascii?Q?pK9q8koBBHRzotQi3R0Gc3cvS9jT0LIaDHiAp6SQudqfrLDpHulexUYg1HLx?=
 =?us-ascii?Q?giYVWWiSbidpbfbbaDcUr5x1qxZ8cb4WcyrezpAGKLPxKIiZf6kooTv+0B7W?=
 =?us-ascii?Q?UiX9BwHnnz9HGBPK4g1LC1nIn1QaLQhUrneDuObIhMT71fxqThuscb1eZxkU?=
 =?us-ascii?Q?W0MO4N9g54ld16i3xma1xERmSuRauwnvSkC1BrCElqtTNxCrN1czWzrSijJa?=
 =?us-ascii?Q?cuAU4dJQXtjkGrleVJcHDSU64H8ZFbvH4UVcYXHzIfXFIoPCEjvRnYQqHzEN?=
 =?us-ascii?Q?jwf2+v0qbJhbFwHtAyN6A/MM1McNkLGPI0zkjwY7mmnD7Xh1ZR58jXCqAg1p?=
 =?us-ascii?Q?6hn5lSOXgWPJCgKXI3k++92uGrtliXoK+3FuO2Tts5hagil4LDWidkguMpEd?=
 =?us-ascii?Q?y+EC/r1Dn9jUzkp4AcjEebG6P92n0/li99skrbIoes6qkAzEVHwNh5XzL3KR?=
 =?us-ascii?Q?3wkuRF6mcdeXrC4LUQ8TjijKun2G64I2gYN6f0fydz1TABNxuPQq0hKVjBTH?=
 =?us-ascii?Q?/i9qak0cMDUYEK98qWQSXFe7uJHOSGGgWchMrOpZ6PvLxdHSiJSOUu/Kxdan?=
 =?us-ascii?Q?RplIb3mlpkCCF2GgmAu7gjhpiTS/RG5pSOEoc7hPAcRfTX7TPt4VrdFRilqJ?=
 =?us-ascii?Q?bN/q5SZnThI38xasxOLH6Hd4x5em6XF5aCjkw9PqU1hxyZbeRwmVPn+gjVrr?=
 =?us-ascii?Q?9nNCr3l0PANJzswUTRVXSl5hB0LeLyjXZMjReA6Bi2pn5J/vCSaAZfl6a96x?=
 =?us-ascii?Q?P/g8Qr10IaPeLzwVIboQeHPgOUbkgjIqkdIt+jSGhh0J0EW55UvPUBrE6J0O?=
 =?us-ascii?Q?Zad35sp/xvpNiY//d3toT532ZBl1jYk0LOKEyqg/8x9WAD8MqKA2TPkAOGaw?=
 =?us-ascii?Q?VSEOO1VBrLv6/6w/S15dNS9A6yX5BwQAhKEaafD2tQp+DaHFzY7O4jSY+HAS?=
 =?us-ascii?Q?8icr5vAAcr5EGB9kt8eGEc3RtuCSlATDwntfW8eweKvbDksNTVKNyP/8dyTF?=
 =?us-ascii?Q?jMGrZERWdgdk7kycgpI5Gi9LZaBM5NqTicRR8S+5+ssj9il87JIX3ix9tr7q?=
 =?us-ascii?Q?bNtJmDDbt4+t4visip4pimhB+1E7A2+OmQd+ff9+nu+iweuCqM4l0F5EErGT?=
 =?us-ascii?Q?HORoJxJPk3EyCSMGk7IEa40AMMtXqFM1xb0zWcm5D//KRg=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2cfa361-350e-42bd-d201-08d8f48463c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2021 20:34:31.8613
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rvDeFEbKzle6qGUJyH8kb/1eWlG7KoSUjATR4A0pgsbJytiVvLPCksLUxDj5mPDtRrjz7O8+lgQJFk9gowy8HAEhTnYL9PToQRbnsII1Ugc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5592
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel,=0A=
=0A=
On 3/31/21 06:12, Daniel Wagner wrote:=0A=
> Commit 8c4dfea97f15 ("nvme-fabrics: reject I/O to offline device")=0A=
> introduced fast_io_fail_tmo but didn't export the value to sysfs. That=0A=
> means the value is hard coded during compile time. Export the timeout=0A=
> value to user space via sysfs to allow runtime configuration.=0A=
>=0A=
> Cc: Victor Gladkov <Victor.Gladkov@kioxia.com>=0A=
> Signed-off-by: Daniel Wagner <dwagner@suse.de>=0A=
> ---=0A=
>=0A=
> This patch is against nvme-5.13=0A=
>=0A=
> BTW, checkpatch complains with=0A=
>=0A=
>   WARNING: Symbolic permissions 'S_IRUGO | S_IWUSR' are not preferred. Co=
nsider using octal permissions '0644'.=0A=
=0A=
For now keep the current style.=0A=
=0A=
>=0A=
> Is this something we want to adapt to?=0A=
>=0A=
>  drivers/nvme/host/core.c | 31 +++++++++++++++++++++++++++++++=0A=
>  1 file changed, 31 insertions(+)=0A=
>=0A=
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c=0A=
> index 40215a0246e4..c8de0e37c7d9 100644=0A=
> --- a/drivers/nvme/host/core.c=0A=
> +++ b/drivers/nvme/host/core.c=0A=
> @@ -3696,6 +3696,36 @@ static ssize_t nvme_ctrl_reconnect_delay_store(str=
uct device *dev,=0A=
>  static DEVICE_ATTR(reconnect_delay, S_IRUGO | S_IWUSR,=0A=
>  	nvme_ctrl_reconnect_delay_show, nvme_ctrl_reconnect_delay_store);=0A=
>  =0A=
> +static ssize_t nvme_ctrl_fast_io_fail_tmo_show(struct device *dev,=0A=
> +		struct device_attribute *attr, char *buf)=0A=
> +{=0A=
> +	struct nvme_ctrl *ctrl =3D dev_get_drvdata(dev);=0A=
> +=0A=
> +	if (ctrl->opts->fast_io_fail_tmo =3D=3D -1)=0A=
> +		return sprintf(buf, "off\n");=0A=
> +	return sprintf(buf, "%d\n", ctrl->opts->fast_io_fail_tmo);=0A=
=0A=
do we need snprintf() for 2nd ?=0A=
=0A=
> +}=0A=
> +=0A=
> +static ssize_t nvme_ctrl_fast_io_fail_tmo_store(struct device *dev,=0A=
> +		struct device_attribute *attr, const char *buf, size_t count)=0A=
> +{=0A=
> +	struct nvme_ctrl *ctrl =3D dev_get_drvdata(dev);=0A=
> +	struct nvmf_ctrl_options *opts =3D ctrl->opts;=0A=
> +	int fast_io_fail_tmo, err;=0A=
> +=0A=
> +	err =3D kstrtoint(buf, 10, &fast_io_fail_tmo);=0A=
> +	if (err)=0A=
> +		return -EINVAL;=0A=
> +=0A=
=0A=
since you are returning an error, you can remove next else if, this also=0A=
removes the extra line after above return. Something like this on the top=
=0A=
of yours totally untested :-=0A=
=0A=
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c=0A=
index c8de0e37c7d9..afa0a6790b52 100644=0A=
--- a/drivers/nvme/host/core.c=0A=
+++ b/drivers/nvme/host/core.c=0A=
@@ -3717,7 +3717,7 @@ static ssize_t=0A=
nvme_ctrl_fast_io_fail_tmo_store(struct device *dev,=0A=
        if (err)=0A=
                return -EINVAL;=0A=
 =0A=
-       else if (fast_io_fail_tmo < 0)=0A=
+       if (fast_io_fail_tmo < 0)=0A=
                opts->fast_io_fail_tmo =3D -1;=0A=
        else=0A=
                opts->fast_io_fail_tmo =3D fast_io_fail_tmo;=0A=
=0A=
> +	else if (fast_io_fail_tmo < 0)=0A=
> +		opts->fast_io_fail_tmo =3D -1;=0A=
> +	else=0A=
> +		opts->fast_io_fail_tmo =3D fast_io_fail_tmo;=0A=
> +	return count;=0A=
> +}=0A=
> +static DEVICE_ATTR(fast_io_fail_tmo, S_IRUGO | S_IWUSR,=0A=
> +	nvme_ctrl_fast_io_fail_tmo_show, nvme_ctrl_fast_io_fail_tmo_store);=0A=
> +=0A=
>  static struct attribute *nvme_dev_attrs[] =3D {=0A=
>  	&dev_attr_reset_controller.attr,=0A=
>  	&dev_attr_rescan_controller.attr,=0A=
> @@ -3715,6 +3745,7 @@ static struct attribute *nvme_dev_attrs[] =3D {=0A=
>  	&dev_attr_hostid.attr,=0A=
>  	&dev_attr_ctrl_loss_tmo.attr,=0A=
>  	&dev_attr_reconnect_delay.attr,=0A=
> +	&dev_attr_fast_io_fail_tmo.attr,=0A=
>  	NULL=0A=
>  };=0A=
>  =0A=
> -- 2.29.2=0A=
=0A=
=0A=
