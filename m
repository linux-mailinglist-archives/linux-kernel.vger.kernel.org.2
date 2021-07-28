Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA2A13D92B4
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 18:03:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237262AbhG1QDR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 12:03:17 -0400
Received: from mx0a-00010702.pphosted.com ([148.163.156.75]:60572 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S236868AbhG1QDO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 12:03:14 -0400
X-Greylist: delayed 2745 seconds by postgrey-1.27 at vger.kernel.org; Wed, 28 Jul 2021 12:03:13 EDT
Received: from pps.filterd (m0098780.ppops.net [127.0.0.1])
        by mx0a-00010702.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16SFEQHe030141;
        Wed, 28 Jul 2021 10:17:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ni.com; h=date : from : to : cc :
 message-id : references : content-type : in-reply-to : mime-version :
 subject; s=PPS11062020; bh=+UE9FlCp8vMoaJya8ZId88dLqKyymcxoHyawI8JSjKI=;
 b=b4hfYV0LZlmjl1S5idqEBBXNaAq2t9itZ5jWeKBrwFd3HjhkvCBav9g7GXaOquopaGYd
 YWChBf38rAdD6huewd0lGoOj5jS7VpcCipbnshTejLlCTv4mQpXKBPk85NdoLPZLbvfU
 3vU7N0dtsAyu82z84uy1BV85TznwdLltpW9FasjDyhysNg7034bBVT6DaKkbTaffCCRs
 vwpCt/fZegyLryaeCvzgkSpBU9XX6eZQ5qVMH3DR29acCVN0GkG0i5vmB/hBT2xbPYiX
 xjf/DyhGUM9ewXPvh3VVr3eReWMxYq7vhxURYLLL5eoj/oDvA0DkW0N40eFgA2VXGR3a bg== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2174.outbound.protection.outlook.com [104.47.58.174])
        by mx0a-00010702.pphosted.com with ESMTP id 3a2m8xjbks-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Jul 2021 10:17:19 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E4gHApOOECmH+EgXycxewQ8UiTTKir6T0+ZzsVNQMeuOVsbwNQs6dzFhWOIt9En3xxFK4s4jg69EmAt6amiTzBLplme3GYeb8SGVtsqNjPrkK7FcxAoKmglKTRNynyCjBnoUhcecBjYFCksNvNO0jblxz0rITJwXBu/aQKNxcoWiI3z1CAH0qupEHxuhZ5LsKxyJ4I48mEOLeVm0265Ossztla0AX5sK2Qf9F5FPv90ePlkwJW31j8/EgxBrNydc41z2bUrTYus8UgQGTVU6amS2k7GWRrJDs52nlb9aSriNptxLFjhFqvQYsbRrIanqR6RxWokueUbRvUOfLrFbdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+UE9FlCp8vMoaJya8ZId88dLqKyymcxoHyawI8JSjKI=;
 b=KT4myi0goT2wANrpsTJFeKMx75z5SdU9qJKib+ehFwDQupHLV2N/hXp+z+kCaHwUB3fTfG8CiOPBF1lWzKPiqeb8k0S5i3wDItaSYd4wdmZEL1v/5whos84MvTJVNfF9lwx6OHUmPEwXI8Q0/1GwH5MYghtUdvBwNpJX28nAlusTBurgqbL3GhYFjEuu6RNKv7XlkfIglU7GptPWBNAxRt7jPb/nog81VLdVerxqbeAUTXejRvWTb28xfcveUZRCtcUvzylslZqfprWcEdkxCg6CutejRMTEWhqNYrMDDunnIgsac0Tf/ipTLzQx/eT1ZCEQtzHZFELMlTjiV63IpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ni.com; dmarc=pass action=none header.from=ni.com; dkim=pass
 header.d=ni.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nio365.onmicrosoft.com; s=selector2-nio365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+UE9FlCp8vMoaJya8ZId88dLqKyymcxoHyawI8JSjKI=;
 b=Ra5HZefMndUDuHokKSAWbFqSDQFXkQrgGvqdyzvNkCihJABtvsX00XO6EUzbbBPqRz7+HGYw4akdTlrUP2lrAENeje6Iwe7ZLLzOL+xZDwNPuTJ2T0eUXil9y3nx5bzn1OUKNQWatMoafSNXAF3YrC/11EpXuEnSPuUOOXWBI84=
Authentication-Results: protonmail.com; dkim=none (message not signed)
 header.d=none;protonmail.com; dmarc=none action=none header.from=ni.com;
Received: from SN2PR04MB2317.namprd04.prod.outlook.com (2603:10b6:804:6::20)
 by SN6PR04MB5166.namprd04.prod.outlook.com (2603:10b6:805:94::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.17; Wed, 28 Jul
 2021 15:17:17 +0000
Received: from SN2PR04MB2317.namprd04.prod.outlook.com
 ([fe80::4081:a5d7:c725:baea]) by SN2PR04MB2317.namprd04.prod.outlook.com
 ([fe80::4081:a5d7:c725:baea%9]) with mapi id 15.20.4352.031; Wed, 28 Jul 2021
 15:17:17 +0000
Date:   Wed, 28 Jul 2021 10:17:16 -0500
From:   Michael Auchter <michael.auchter@ni.com>
To:     Yassine Oudjana <y.oudjana@protonmail.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Message-ID: <YQF0/P6ngk7pjSCH@xaphan>
References: <Fz2Ehjftp2eVDCxfgd4j3TYcrmSf5ForizOdT7rngo@cp7-web-042.plabs.ch>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Fz2Ehjftp2eVDCxfgd4j3TYcrmSf5ForizOdT7rngo@cp7-web-042.plabs.ch>
X-ClientProxiedBy: SN6PR05CA0022.namprd05.prod.outlook.com
 (2603:10b6:805:de::35) To SN2PR04MB2317.namprd04.prod.outlook.com
 (2603:10b6:804:6::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (2605:a601:aae2:5000:9ead:5cd9:abd2:2ef9) by SN6PR05CA0022.namprd05.prod.outlook.com (2603:10b6:805:de::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.6 via Frontend Transport; Wed, 28 Jul 2021 15:17:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e6116951-cf5b-40f2-d1d8-08d951dac915
X-MS-TrafficTypeDiagnostic: SN6PR04MB5166:
X-Microsoft-Antispam-PRVS: <SN6PR04MB5166AB433DEF28D2C36463E687EA9@SN6PR04MB5166.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5j4n08lslouhdd57F5lBzHmPIIxsjSo3mu+VBJOSu8DNCIrRiSWR5aagxYqM+2pibU8QYnwVlUEoSOzfQZxpeXY/uxiHeuch/jG6DA24RCzCsWHhogAsO0C3wBBX+xY6NWdWr+oRjOr8PZYZZKhmWwrLaYIe5x2V+K0y+IrQiDEsu9psdLpMjPjfmNtmjpaD4qmI/bHaOgn2iyJkTg+PWakd4gjIe7+ZxTTY/d5xOrcdsvMcHpUsOHP9aSlSRlknx8Jcb9ImkQTeZFKxlocd5vt5z2grdvzHrg82BEz35wDpyWt3u+qvD+nBcaKg6mpUZjYae+KGFZ7haE/lC2hB4oIZA5CI/PGRuH9FIZd48SY3oZV9OlD4AqBR7/3QUJEoV4NZjmFxzdSgZOM4Mjg7Z9qXzZBMwAFVR94ttzaHRgrfJr530o/DBMvfeO0UbMkAKS216r44dP3DkLYmVykoMh/KbkJooxUYpDhlSb/O+iavUsRg8jMzLEo4jS2qpTxbo5tXR6CAJ3O4+FlcRGb0NgRxVLOs+oQVWljB6jiI9ep1+Gl05w/Sg29E+CXlRuWH1GyQl4XDaqoEW2AcjXVSYpC5X1mIHfeRFRQ6ORPVAtlLkVLZ1vmq69txgsjZo5Ep/5GaCxkZbdUmncqrpQSLYQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN2PR04MB2317.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(396003)(39830400003)(366004)(346002)(136003)(376002)(5660300002)(54906003)(6916009)(316002)(66946007)(66556008)(33716001)(8676002)(4326008)(83380400001)(86362001)(186003)(6496006)(38100700002)(478600001)(2906002)(6486002)(66476007)(9686003)(52116002)(44832011)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8UVMAG27GCfVbrUBpJKYOgvYfXC+93gTPjt3a2k64Bf7TiRiEicdiqE2tWA8?=
 =?us-ascii?Q?wwUqDEKS7VXrZftTIkM840TgxzfEuWBLebUoifmNwESOBwa4UU3s9as0pbOP?=
 =?us-ascii?Q?AufFjd6gVj63SkINi0oDp4SXqE92rm40y+yEa5c+IAW/uWd8bP66dO1Ii1hj?=
 =?us-ascii?Q?j8UUxvnemYN0js9ZCxqtFGTh/QEc0ElUuG9ZlwwQZ707VEWWAHPURG6zDfvD?=
 =?us-ascii?Q?veym6ferMTeiJWw/An6lnuIadg73W0fQHVtiY8GXyEzvuqEpW3K+DYurr2Ld?=
 =?us-ascii?Q?GbFVLz71w+2Xk5N/IB5I3LAH5b1XdSeU4vZGnF9eUklhs5079bgK41jMh9f0?=
 =?us-ascii?Q?JfZhokW/14Autf8t2LGhFPbK3kX3JjPN0d0V3TxQUcO5KJCOEnkZ3l99hepl?=
 =?us-ascii?Q?ntUHsbSt8X+VM2cbeMKzAckHQ7PWYtKsuXuFgSFb/KP752dg/aIKI7PAxxJ5?=
 =?us-ascii?Q?vBej7Vcidm/ksbA8suciUcuE0Jqj4EqI5c4K4FESoWQseLYFfBiAFoXhoonN?=
 =?us-ascii?Q?GRJ8cT4T4K0meE9/PJbBezzF7dqRXLHs5bq58Wiv6FJgmowZQnS3xYD5UjkY?=
 =?us-ascii?Q?1ax8QczsOkn5CDI+YB1HRAZ9JkPw5mPRnvepOMY/4y5QmZ8j8D6h90gPS9jc?=
 =?us-ascii?Q?irL05Q44EibJFlaWEgMe64m5axj4gcbA8pRWKEBNBKaHuO0f8pyn+jHDtW1n?=
 =?us-ascii?Q?xNKCqbcT/dn2nYFVaLZYyXXsASaKdvXQwhjXb2hIc04atXE4x8KzGPHJ4QpN?=
 =?us-ascii?Q?XY/kAAZkzoZaHuFT3NuOrGrhmtnB158cZCoHXd0yP27QXfhJcuHAXS34DJxt?=
 =?us-ascii?Q?hTMOKB72qsf3T0Z9sbStyxolRdC1ny//ZG54eVOjt6p8RtpnyjAT1o7CiXOX?=
 =?us-ascii?Q?BsSCrinf5mZz4R7JKLXHr0AWqPpJZDxTvMPPq/y1uiFcwilAwf6P8EI873wC?=
 =?us-ascii?Q?4WnwkWWu/uUmUIPdZioU8sJqApXq3PM6AVjVc6EACnD2sfU8JVp7Hl0u6294?=
 =?us-ascii?Q?GB65lDchz99dDQRUtTjzG8KPcejb5dGK7obl9965DZf5JviPMy0RlPTlsFwH?=
 =?us-ascii?Q?BaH9JipnzonUT3oTVFtcVhWgPvup0HJ8zfkTUMjfnpihWcz7DukoxQ/TUevv?=
 =?us-ascii?Q?4ACpnRLw3hkcZ+frPMw552itV/BHIeuQteX+bWFN4PmiEpi6a/JGs+34InKF?=
 =?us-ascii?Q?lKXALQvKqDtkeBN0EoJ78LSZJK1UOvPM3pOPZgnt/u4kMRQ34k4TeazJi3VQ?=
 =?us-ascii?Q?mcAsYRujgRH/Dos6s7YaoBOrReycGLKmtw2hiATA5ktzn90r1vVEwiLFvbqt?=
 =?us-ascii?Q?k4G+l33G5hz9+sGSYwrmo4HVGr7vvvJL+J09gYwb4Z6yxYJodCg2+u2ys1vW?=
 =?us-ascii?Q?BVWPCiWiK4S3h8NyHRYNgzCSLQ7k?=
X-OriginatorOrg: ni.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6116951-cf5b-40f2-d1d8-08d951dac915
X-MS-Exchange-CrossTenant-AuthSource: SN2PR04MB2317.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2021 15:17:17.0215
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 87ba1f9a-44cd-43a6-b008-6fdb45a5204e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hwb2S61Ms99YQt9T8Puyv3e+uqXu2hNK+8emqADWhoDrr/UXqxraYxCiYtxFG1HkD7ljocvzLrBdAUoagYYtiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB5166
X-Proofpoint-GUID: 6HR2dO9nz_JgWQfbNaBwjiRROB3VVB5C
X-Proofpoint-ORIG-GUID: 6HR2dO9nz_JgWQfbNaBwjiRROB3VVB5C
Subject: Re: [PATCH v2 1/3] extcon: usbc-tusb320: Add support for mode setting and
 reset
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-28_08:2021-07-27,2021-07-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_policy_notspam policy=outbound_policy score=30 mlxscore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 clxscore=1011
 malwarescore=0 mlxlogscore=999 impostorscore=0 adultscore=0 phishscore=0
 suspectscore=0 spamscore=0 classifier=spam adjust=30 reason=mlx
 scancount=1 engine=8.12.0-2107140000 definitions=main-2107280085
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Yassine,

On Tue, Jul 27, 2021 at 09:56:41AM +0000, Yassine Oudjana wrote:
> Reset the chip and set its mode to default (maintain mode set by PORT pin)
> during probe to make sure it comes up in the default state.
> 
> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
> ---
>  drivers/extcon/extcon-usbc-tusb320.c | 111 +++++++++++++++++++++++----
>  1 file changed, 97 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/extcon/extcon-usbc-tusb320.c b/drivers/extcon/extcon-usbc-tusb320.c
> index 805af73b4152..c8d931abbf9f 100644
> --- a/drivers/extcon/extcon-usbc-tusb320.c
> +++ b/drivers/extcon/extcon-usbc-tusb320.c
> @@ -19,15 +19,32 @@
>  #define TUSB320_REG9_ATTACHED_STATE_MASK	0x3
>  #define TUSB320_REG9_CABLE_DIRECTION		BIT(5)
>  #define TUSB320_REG9_INTERRUPT_STATUS		BIT(4)
> -#define TUSB320_ATTACHED_STATE_NONE		0x0
> -#define TUSB320_ATTACHED_STATE_DFP		0x1
> -#define TUSB320_ATTACHED_STATE_UFP		0x2
> -#define TUSB320_ATTACHED_STATE_ACC		0x3
> +
> +#define TUSB320_REGA				0xa
> +#define TUSB320_REGA_I2C_SOFT_RESET		BIT(3)
> +#define TUSB320_REGA_MODE_SELECT_SHIFT		4
> +#define TUSB320_REGA_MODE_SELECT_MASK		0x3
> +
> +enum tusb320_attached_state {
> +	TUSB320_ATTACHED_STATE_NONE,
> +	TUSB320_ATTACHED_STATE_DFP,
> +	TUSB320_ATTACHED_STATE_UFP,
> +	TUSB320_ATTACHED_STATE_ACC,
> +};
> +
> +enum tusb320_mode {
> +	TUSB320_MODE_PORT,
> +	TUSB320_MODE_UFP,
> +	TUSB320_MODE_DFP,
> +	TUSB320_MODE_DRP,
> +};
>  
>  struct tusb320_priv {
>  	struct device *dev;
>  	struct regmap *regmap;
>  	struct extcon_dev *edev;
> +
> +	enum tusb320_attached_state state;
>  };
>  
>  static const char * const tusb_attached_states[] = {
> @@ -37,6 +54,13 @@ static const char * const tusb_attached_states[] = {
>  	[TUSB320_ATTACHED_STATE_ACC]  = "accessory",
>  };
>  
> +static const char * const tusb_modes[] = {
> +	[TUSB320_MODE_PORT] = "maintain mode set by PORT pin",
> +	[TUSB320_MODE_UFP]  = "upstream facing port",
> +	[TUSB320_MODE_DFP]  = "downstream facing port",
> +	[TUSB320_MODE_DRP]  = "dual role port",
> +};
> +
>  static const unsigned int tusb320_extcon_cable[] = {
>  	EXTCON_USB,
>  	EXTCON_USB_HOST,
> @@ -62,26 +86,77 @@ static int tusb320_check_signature(struct tusb320_priv *priv)
>  	return 0;
>  }
>  
> +static int tusb320_set_mode(struct tusb320_priv *priv, enum tusb320_mode mode)
> +{
> +	int ret;
> +
> +	/* Mode cannot be changed while cable is attached */
> +	if(priv->state != TUSB320_ATTACHED_STATE_NONE)
> +		return -EBUSY;

When tusb320_set_mode() is called from probe() via tusb320_reset(),
priv->state will be always be 0 as it hasn't been read from the chip
yet.

Also, per CodingStyle, please ensure there's a space between the "if"
and the opening paren (here and elsewhere in this patchset)

> +
> +	/* Write mode */
> +	ret = regmap_write_bits(priv->regmap, TUSB320_REGA,
> +		TUSB320_REGA_MODE_SELECT_MASK << TUSB320_REGA_MODE_SELECT_SHIFT,
> +		mode << TUSB320_REGA_MODE_SELECT_SHIFT);
> +	if(ret) {
> +		dev_err(priv->dev, "failed to write mode: %d\n", ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int tusb320_reset(struct tusb320_priv *priv)
> +{
> +	int ret;
> +
> +	/* Set mode to default (follow PORT pin) */
> +	ret = tusb320_set_mode(priv, TUSB320_MODE_PORT);
> +	if(ret && ret != -EBUSY) {
> +		dev_err(priv->dev,
> +			"failed to set mode to PORT: %d\n", ret);
> +		return ret;
> +	}
> +
> +	/* Perform soft reset */
> +	ret = regmap_write_bits(priv->regmap, TUSB320_REGA,
> +			TUSB320_REGA_I2C_SOFT_RESET, 1);
> +	if(ret) {
> +		dev_err(priv->dev,
> +			"failed to write soft reset bit: %d\n", ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
>  static irqreturn_t tusb320_irq_handler(int irq, void *dev_id)
>  {
>  	struct tusb320_priv *priv = dev_id;
> -	int state, polarity;
> -	unsigned reg;
> +	int state, polarity, mode;
> +	unsigned reg9, rega;
> +
> +	if (regmap_read(priv->regmap, TUSB320_REG9, &reg9)) {
> +		dev_err(priv->dev, "error during register 0x9 i2c read!\n");
> +		return IRQ_NONE;
> +	}
>  
> -	if (regmap_read(priv->regmap, TUSB320_REG9, &reg)) {
> -		dev_err(priv->dev, "error during i2c read!\n");
> +	if (regmap_read(priv->regmap, TUSB320_REGA, &rega)) {
> +		dev_err(priv->dev, "error during register 0xa i2c read!\n");

Why is this register being read in the interrupt handler? The
datasheet's documentation for the INTERRUPT_STATUS register says that an
interrupt will be generated "whenever a CSR with RU in [the] Access field
changes" (i.e., whenever hardware has autonomously updated a value). As
far as I can see, there are no RU registers here.

>  		return IRQ_NONE;
>  	}
>  
> -	if (!(reg & TUSB320_REG9_INTERRUPT_STATUS))
> +	if (!(reg9 & TUSB320_REG9_INTERRUPT_STATUS))
>  		return IRQ_NONE;
>  
> -	state = (reg >> TUSB320_REG9_ATTACHED_STATE_SHIFT) &
> +	state = (reg9 >> TUSB320_REG9_ATTACHED_STATE_SHIFT) &
>  		TUSB320_REG9_ATTACHED_STATE_MASK;
> -	polarity = !!(reg & TUSB320_REG9_CABLE_DIRECTION);
> +	polarity = !!(reg9 & TUSB320_REG9_CABLE_DIRECTION);
> +	mode = (rega >> TUSB320_REGA_MODE_SELECT_SHIFT) &
> +		TUSB320_REGA_MODE_SELECT_MASK;
>  
> -	dev_dbg(priv->dev, "attached state: %s, polarity: %d\n",
> -		tusb_attached_states[state], polarity);
> +	dev_dbg(priv->dev, "mode: %s, attached state: %s, polarity: %d\n",
> +		tusb_modes[mode], tusb_attached_states[state], polarity);

What's the purpose of tracing the mode here? Since the chip does not
change the mode on its own, it should always be whatever it was last set
to, correct?

>  	extcon_set_state(priv->edev, EXTCON_USB,
>  			 state == TUSB320_ATTACHED_STATE_UFP);
> @@ -96,7 +171,10 @@ static irqreturn_t tusb320_irq_handler(int irq, void *dev_id)
>  	extcon_sync(priv->edev, EXTCON_USB);
>  	extcon_sync(priv->edev, EXTCON_USB_HOST);
>  
> -	regmap_write(priv->regmap, TUSB320_REG9, reg);
> +	priv->state = state;
> +
> +	regmap_write(priv->regmap, TUSB320_REG9, reg9);
> +	regmap_write(priv->regmap, TUSB320_REGA, rega);

The write to REG9 is required in order to clear the INTERRUPT_STATUS
bit, but I do not see a need to write back to REGA...

>  
>  	return IRQ_HANDLED;
>  }
> @@ -137,6 +215,11 @@ static int tusb320_extcon_probe(struct i2c_client *client,
>  		return ret;
>  	}
>  
> +	/* Reset chip to its default state */
> +	ret = tusb320_reset(priv);
> +	if(ret)
> +		dev_warn(priv->dev, "failed to reset chip: %d\n", ret);
> +

As mentioned above, the tusb320_reset() should be probably be done after
the call to tusb320_irq_handler(), which will read and update the
attached state.

>  	extcon_set_property_capability(priv->edev, EXTCON_USB,
>  				       EXTCON_PROP_USB_TYPEC_POLARITY);
>  	extcon_set_property_capability(priv->edev, EXTCON_USB_HOST,
> -- 
> 2.32.0
> 
> 

Thanks,
 Michael
