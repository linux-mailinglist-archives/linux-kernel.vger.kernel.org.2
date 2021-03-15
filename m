Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 928F633AB88
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 07:16:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbhCOGQP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 02:16:15 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:48510 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229951AbhCOGPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 02:15:55 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12F68VVp023467;
        Sun, 14 Mar 2021 23:15:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=RMhtfnUgunY5y1aZ0iXeYMAXEaQzeXF1nJiY9XNmRDM=;
 b=oGYZZQN3IZVFR0+tjMtxifi0VY2yP1J/FRrv+p7FWJ9pTj7AlfTmQ1e9sNAsp9ES/DQI
 TIM4KLE0X3apKBYknKNHw7an0T3RJ6wMYPVLMxSA7PTJHZbj8jEHG0rJRnh3GNJlW42v
 ZA+tuC2214fIiMoKv6WIv8kKLvIk47XYBJxOR1YeCk/obeG/bxcDyH6ApmGh6URDAh6y
 8kkOdSaskvIu5TvugVCPAy5Ow5rlj8rkGPAN/Lu5nKZRK4hb3DHW327Q9Nc550R/PTcj
 K1QMSuAQlLQK8CFpEnsToqh3sFfIpIfEBTPnSFo7PZWjF2G65XBXD9LVEFjzBJOcIAzK /g== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
        by mx0a-0014ca01.pphosted.com with ESMTP id 378tu1vfvh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 14 Mar 2021 23:15:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QyFZAN9+4rHNXja8NvXwbk6aWTXVL2V4aALPruiAOZbOCUQoSiu7/XWus9+BDcSdasei5JGjtS3PV9WBhbvkP8DH8Qzflk5Wkz1JHnQ3XbgTgFPN/GgfpSlfJpgLjQTJzAbnUtUq2D2HatL0eCo9W6y2lCBC2Vrgz5GfcWl0Qp4HT1m80Yi61rT5LHnqVYX2F0hBRbR+JInD4kw7vpA+njMN9hdFdrqf8jA3vTvDlNjKweEsaR7CGWbPvpEk6qQBjr7NxWLH/CPD2r3bGYzmsPsqDU8shWiZlC5eKszli0RBPiaQAEIAY8iuoEtC5JEjfxqmAB8/qXBNAzKc3uYfGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RMhtfnUgunY5y1aZ0iXeYMAXEaQzeXF1nJiY9XNmRDM=;
 b=FOzSOU53wuzpRb71y5gWG/XpMCB8xxX40TfKky8pjRxnfrue9x38L2YD4SHIJMOX3wZeeUgU9KiN/vEDGMrIL098RUX2WaLjTJLTcWssLb0NgzXhf65wkd65yZ73Wkl/i6uKcjaGFl5njU50wibzkHOy2AT00BKwANCF+wUgyIHxm5vvzjNQ5Y2aJo1IARiO5uqerYLJg5buJERWKZLXrLcgtJpPQOTIhVjb+4IlG00KKTZvtTobPhx40LJwca5eeLONAtbvpaizmGa7BJ6kVqDvenC5JnZI6nSjUctE3Za3vG0zC7Z40i/YaxeZkoDy9t8j30bgMuYGdANZz587ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RMhtfnUgunY5y1aZ0iXeYMAXEaQzeXF1nJiY9XNmRDM=;
 b=woaUN3PorjbnAuuOkBeS4MVjAJmSFbxpkG/ll6c4XrqECUIrFhMcPYihfL3hUBd1NPskg6mDXhIKU8tPHRGrgbFIXU0wev4wBW7Zlj0/GOqn7GU7IE5ffv/JJ2U/G+iQUfNAxZzjX9fTc7LbRGs6xpYgTPhXlP47jrmopPYSIOE=
Received: from MN2PR07MB6160.namprd07.prod.outlook.com (2603:10b6:208:11d::30)
 by MN2PR07MB6416.namprd07.prod.outlook.com (2603:10b6:208:118::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Mon, 15 Mar
 2021 06:15:42 +0000
Received: from MN2PR07MB6160.namprd07.prod.outlook.com
 ([fe80::294b:4e83:24b:ce39]) by MN2PR07MB6160.namprd07.prod.outlook.com
 ([fe80::294b:4e83:24b:ce39%4]) with mapi id 15.20.3933.032; Mon, 15 Mar 2021
 06:15:42 +0000
From:   Swapnil Kashinath Jakhade <sjakhade@cadence.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Lokesh Vutla <lokeshvutla@ti.com>
Subject: RE: [PATCH v6 12/13] phy: cadence: phy-cadence-sierra: Model
 PLL_CMNLC and PLL_CMNLC1 as clocks (mux clocks)
Thread-Topic: [PATCH v6 12/13] phy: cadence: phy-cadence-sierra: Model
 PLL_CMNLC and PLL_CMNLC1 as clocks (mux clocks)
Thread-Index: AQHXFcSSbJODXRBadEi41gRIvEsxK6qAJZkQ
Date:   Mon, 15 Mar 2021 06:15:42 +0000
Message-ID: <MN2PR07MB616025FC090D7896E4E951D5C56C9@MN2PR07MB6160.namprd07.prod.outlook.com>
References: <20210310154558.32078-1-kishon@ti.com>
 <20210310154558.32078-13-kishon@ti.com>
In-Reply-To: <20210310154558.32078-13-kishon@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcc2pha2hhZGVcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRiYTI5ZTM1Ylxtc2dzXG1zZy1kZDE2MTRjNy04NTU1LTExZWItODU0Ny1jOGY3NTA0NDIyZDhcYW1lLXRlc3RcZGQxNjE0YzgtODU1NS0xMWViLTg1NDctYzhmNzUwNDQyMmQ4Ym9keS50eHQiIHN6PSIxNDI5MCIgdD0iMTMyNjAyNjI1NDAzMjI3MzUwIiBoPSJobjBwRmU2R1BqbUpHT09Vc2VxTHRNKzNXWTA9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: true
authentication-results: ti.com; dkim=none (message not signed)
 header.d=none;ti.com; dmarc=none action=none header.from=cadence.com;
x-originating-ip: [59.145.174.78]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 52a52dd6-c7a5-4c8f-62c6-08d8e779c358
x-ms-traffictypediagnostic: MN2PR07MB6416:
x-microsoft-antispam-prvs: <MN2PR07MB64162F43E7DF6131653D7FF0C56C9@MN2PR07MB6416.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:21;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Yt0Pi1vbyBKkJ9gnfhvlLgwYaEWq+q7GWIb0A0xpom+iRQiS2jaU5rTguh+K2AuHWRSFEWfaNg6ujZzICNzMr0BWXqacMTMmdHYRy6KpRZKxXYTGyr/GmGNsbLc5UAGvZm8h49WNYimfxq0pGlmpYmC1LPywQKjuddrmW7PYepZ+mSVEpXhXIxNm220Xz4oKNBF7lWhIaLnrQSQtWSIwUpmdpHU7D0VITaDGy1UieGM17lnUnq58oJIY/o2TK8MmRFyhbfzEtpFFT5HvDF5qos7oZMnNLBxwTejv7bHS6U78RrcwLfT4sheMC7QrupzX+Pwtdx4yw48dDlZA524Ihqa7p6WRk7P/BauRtNzesK+6WgM4+ZO+FSPVU+QqVznPGoPtdtvF+V9WZQaSZ51uZPN2xYghsly6g/WqrrwnUXpaNHSugDWoTG2q+lEpn6LQx5pECqrftVbNcwwCXvzBq6PoJMlMsA2Uh1JpWm16vtZs3ArR4QutAcp+QQV0GK00ahnsuFBYcXOaev2TIb3Mzi+X/UxjK8ruIVOcO+WLDJSFA3ovBDOJ4x1SWaby9PHzjKb3BqGz58PXirMI/aXxEuBBbUF5Re5p7nB12K/SbLEamvon/v24Syv+V7WDj8a+
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR07MB6160.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(346002)(366004)(136003)(396003)(36092001)(6506007)(53546011)(110136005)(7696005)(54906003)(478600001)(316002)(66946007)(4326008)(33656002)(66556008)(8936002)(86362001)(186003)(9686003)(26005)(66476007)(5660300002)(64756008)(71200400001)(83380400001)(55016002)(66446008)(2906002)(76116006)(30864003)(52536014)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?2P+A+cfzmkTIymmecZ6f44PDzT74bV5L2jXz/xWoIIF7eul0F5/M0qW9Fqh3?=
 =?us-ascii?Q?dSoDOecX7FOJDCRbACZjX0rwbTmOi1WX7f1BY8JoIGI65ExqfDOALUc2jQvI?=
 =?us-ascii?Q?IqwJisoNXfosaMgjT8NmuHeV3jJzjOehr14z6wT3kezmoWoFp+sRAMJKvuqT?=
 =?us-ascii?Q?rSnW35mgCRoIU1hBjaJm2oOsL7rfj07qLwfSobul57eaI9esT0oFRrMSBsm8?=
 =?us-ascii?Q?uzcjhQcvU35cSeWX6qmkUeu+zukk4XwburXaBw5NsgjosGaosg9DfvCcYlxv?=
 =?us-ascii?Q?wLFC1wBNFc1kmJH6sWSRavSeeU4948HEcJn5bZNoTAqocx6Nq80PY4KShBv7?=
 =?us-ascii?Q?8eTTpp4OWYdu6jYYa1R6w7+WZJlfSQMzgfrRvwZIEn72OylPVRO2nKjE0Wa6?=
 =?us-ascii?Q?K6XfbjPVl43iWR9+T9dF0Xa5OfKmWFK5i2FX57/s/QJPRXcEtmHwG3nR1pFT?=
 =?us-ascii?Q?IzWiE75Qg/5Kp9uDe4HX4RojjPIGPz8Olsx4KDjglVaOSmaNOr6sdaVtnSey?=
 =?us-ascii?Q?ORPlrKS0uJlJxSt4HftScU7nJqhZ5jS/D7+DfCb8VeCr6d0CEGz/IQx33siM?=
 =?us-ascii?Q?iuOi1vcssE6cZ3IaX98z253m6tcpsZN1nC1YjrJToxJOVLVyfCvaLa9hHj0o?=
 =?us-ascii?Q?aOKHZHTG2X51fNwDuu+mV6eD96VbKvpV839dOW1xAqx+zYNEG4gYvgq11a78?=
 =?us-ascii?Q?ZAgt5UiGQ7fpp25ezGgGHhnHeu9jabEnS+CpifxkGfB47MayVO/ba44qNGa5?=
 =?us-ascii?Q?z1hNmterwCuE58EfVBg93x7mjMZ/v8jymqeNNo94eewuvAEkbnqv6z/V82+X?=
 =?us-ascii?Q?PCe1hIFgIP1kUsh12zuNpidIV7Yn5BmR3G4iD7zQIi7+ovYKpH1PJY5r7XQS?=
 =?us-ascii?Q?/TOW8oMQu6k0y4q1DK6QNaiLG8BTtH8HDG3D5yp6TExTr7397Fwjk6PnnIEn?=
 =?us-ascii?Q?qIC+I5XbfAA8oA0txeaDcOUgB0KH6WM15JVPtKhO2CY8FmSuB63K3QKHtY2p?=
 =?us-ascii?Q?N62Z2JFK2T38WIbDtWROhNMHbFsSSBeqyjLtX5uhlvbEWnmdUXj4jXjOo2jO?=
 =?us-ascii?Q?7wKPWYaGSj+Fh5k61jnfeMWSPxwHfppi+P9P4c5RTlujhopSSOOttK3H3hhc?=
 =?us-ascii?Q?XoameD9WloUtjFSLDKr3WzDJ221+K/rvuNz+SofRUyydKTi2EXauQYfBPg+A?=
 =?us-ascii?Q?LnDsgKbqwlGuXLrHGNEa+8kVuEt/s52MTEPQgKzxQLZDp3+up2Wy3Kw9biHf?=
 =?us-ascii?Q?BSyZAwFBM98NFkNmQPMDfjCKcUBXj14Ibl4erT0msMBg7R49LDp6HeQ6bdFM?=
 =?us-ascii?Q?J+Ikd9OsiODeCZmhrzhMcSPo?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR07MB6160.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52a52dd6-c7a5-4c8f-62c6-08d8e779c358
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2021 06:15:42.5714
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DXrqdulq90aEpc9vTXJ1/RKJThkvRCLqMj0WMzeQtTH85FJMP76xLn67Zdl04VWytkbHzyEmUZyrWnnAXnNkQ4YXtlD1BKOVwCn8LAuoNwo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR07MB6416
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-15_01:2021-03-15,2021-03-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 adultscore=0
 priorityscore=1501 bulkscore=0 phishscore=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 spamscore=0 suspectscore=0
 impostorscore=0 mlxscore=0 mlxlogscore=999 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103150043
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Kishon Vijay Abraham I <kishon@ti.com>
> Sent: Wednesday, March 10, 2021 9:16 PM
> To: Kishon Vijay Abraham I <kishon@ti.com>; Vinod Koul
> <vkoul@kernel.org>; Rob Herring <robh+dt@kernel.org>; Philipp Zabel
> <p.zabel@pengutronix.de>; Swapnil Kashinath Jakhade
> <sjakhade@cadence.com>
> Cc: linux-kernel@vger.kernel.org; devicetree@vger.kernel.org; Lokesh Vutl=
a
> <lokeshvutla@ti.com>
> Subject: [PATCH v6 12/13] phy: cadence: phy-cadence-sierra: Model
> PLL_CMNLC and PLL_CMNLC1 as clocks (mux clocks)
>
> EXTERNAL MAIL
>
>
> Sierra has two PLLs, PLL_CMNLC and PLL_CMNLC1 and each of these PLLs has
> two inputs, plllc_refclk (input from pll0_refclk) and refrcv (input from
> pll1_refclk). Model PLL_CMNLC and PLL_CMNLC1 as clocks so that it's
> possible to select one of these two inputs from device tree.
>
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  drivers/phy/cadence/Kconfig              |   1 +
>  drivers/phy/cadence/phy-cadence-sierra.c | 267 ++++++++++++++++++++++-
>  2 files changed, 265 insertions(+), 3 deletions(-)
>

Reviewed-by: Swapnil Jakhade <sjakhade@cadence.com>

Thanks & regards,
Swapnil

> diff --git a/drivers/phy/cadence/Kconfig b/drivers/phy/cadence/Kconfig
> index 27e9d6c377e5..a62910ff5591 100644
> --- a/drivers/phy/cadence/Kconfig
> +++ b/drivers/phy/cadence/Kconfig
> @@ -25,6 +25,7 @@ config PHY_CADENCE_DPHY
>  config PHY_CADENCE_SIERRA
>       tristate "Cadence Sierra PHY Driver"
>       depends on OF && HAS_IOMEM && RESET_CONTROLLER
> +     depends on COMMON_CLK
>       select GENERIC_PHY
>       help
>         Enable this to support the Cadence Sierra PHY driver
> diff --git a/drivers/phy/cadence/phy-cadence-sierra.c
> b/drivers/phy/cadence/phy-cadence-sierra.c
> index ac32b7b0289f..039ca10db59d 100644
> --- a/drivers/phy/cadence/phy-cadence-sierra.c
> +++ b/drivers/phy/cadence/phy-cadence-sierra.c
> @@ -7,6 +7,7 @@
>   *
>   */
>  #include <linux/clk.h>
> +#include <linux/clk-provider.h>
>  #include <linux/delay.h>
>  #include <linux/err.h>
>  #include <linux/io.h>
> @@ -20,10 +21,12 @@
>  #include <linux/of.h>
>  #include <linux/of_platform.h>
>  #include <dt-bindings/phy/phy.h>
> +#include <dt-bindings/phy/phy-cadence.h>
>
>  /* PHY register offsets */
>  #define SIERRA_COMMON_CDB_OFFSET                     0x0
>  #define SIERRA_MACRO_ID_REG                          0x0
> +#define SIERRA_CMN_PLLLC_GEN_PREG                    0x42
>  #define SIERRA_CMN_PLLLC_MODE_PREG                   0x48
>  #define SIERRA_CMN_PLLLC_LF_COEFF_MODE1_PREG         0x49
>  #define SIERRA_CMN_PLLLC_LF_COEFF_MODE0_PREG         0x4A
> @@ -31,6 +34,9 @@
>  #define SIERRA_CMN_PLLLC_BWCAL_MODE1_PREG            0x4F
>  #define SIERRA_CMN_PLLLC_BWCAL_MODE0_PREG            0x50
>  #define SIERRA_CMN_PLLLC_SS_TIME_STEPSIZE_MODE_PREG  0x62
> +#define SIERRA_CMN_REFRCV_PREG                               0x98
> +#define SIERRA_CMN_REFRCV1_PREG                              0xB8
> +#define SIERRA_CMN_PLLLC1_GEN_PREG                   0xC2
>
>  #define SIERRA_LANE_CDB_OFFSET(ln, block_offset, reg_offset) \
>                               ((0x4000 << (block_offset)) + \
> @@ -144,13 +150,19 @@
>  #define SIERRA_MAX_LANES                             16
>  #define PLL_LOCK_TIME                                        100000
>
> -#define CDNS_SIERRA_INPUT_CLOCKS                     3
> +#define CDNS_SIERRA_OUTPUT_CLOCKS                    2
> +#define CDNS_SIERRA_INPUT_CLOCKS                     5
>  enum cdns_sierra_clock_input {
>       PHY_CLK,
>       CMN_REFCLK_DIG_DIV,
>       CMN_REFCLK1_DIG_DIV,
> +     PLL0_REFCLK,
> +     PLL1_REFCLK,
>  };
>
> +#define SIERRA_NUM_CMN_PLLC                          2
> +#define SIERRA_NUM_CMN_PLLC_PARENTS                  2
> +
>  static const struct reg_field macro_id_type =3D
>                               REG_FIELD(SIERRA_MACRO_ID_REG, 0, 15);
>  static const struct reg_field phy_pll_cfg_1 =3D
> @@ -158,6 +170,53 @@ static const struct reg_field phy_pll_cfg_1 =3D
>  static const struct reg_field pllctrl_lock =3D
>                               REG_FIELD(SIERRA_PLLCTRL_STATUS_PREG, 0,
> 0);
>
> +static const char * const clk_names[] =3D {
> +     [CDNS_SIERRA_PLL_CMNLC] =3D "pll_cmnlc",
> +     [CDNS_SIERRA_PLL_CMNLC1] =3D "pll_cmnlc1",
> +};
> +
> +enum cdns_sierra_cmn_plllc {
> +     CMN_PLLLC,
> +     CMN_PLLLC1,
> +};
> +
> +struct cdns_sierra_pll_mux_reg_fields {
> +     struct reg_field        pfdclk_sel_preg;
> +     struct reg_field        plllc1en_field;
> +     struct reg_field        termen_field;
> +};
> +
> +static const struct cdns_sierra_pll_mux_reg_fields
> cmn_plllc_pfdclk1_sel_preg[] =3D {
> +     [CMN_PLLLC] =3D {
> +             .pfdclk_sel_preg =3D
> REG_FIELD(SIERRA_CMN_PLLLC_GEN_PREG, 1, 1),
> +             .plllc1en_field =3D REG_FIELD(SIERRA_CMN_REFRCV1_PREG, 8,
> 8),
> +             .termen_field =3D REG_FIELD(SIERRA_CMN_REFRCV1_PREG, 0,
> 0),
> +     },
> +     [CMN_PLLLC1] =3D {
> +             .pfdclk_sel_preg =3D
> REG_FIELD(SIERRA_CMN_PLLLC1_GEN_PREG, 1, 1),
> +             .plllc1en_field =3D REG_FIELD(SIERRA_CMN_REFRCV_PREG, 8,
> 8),
> +             .termen_field =3D REG_FIELD(SIERRA_CMN_REFRCV_PREG, 0, 0),
> +     },
> +};
> +
> +struct cdns_sierra_pll_mux {
> +     struct clk_hw           hw;
> +     struct regmap_field     *pfdclk_sel_preg;
> +     struct regmap_field     *plllc1en_field;
> +     struct regmap_field     *termen_field;
> +     struct clk_init_data    clk_data;
> +};
> +
> +#define to_cdns_sierra_pll_mux(_hw)  \
> +                     container_of(_hw, struct cdns_sierra_pll_mux, hw)
> +
> +static const int pll_mux_parent_index[][SIERRA_NUM_CMN_PLLC_PARENTS]
> =3D {
> +     [CMN_PLLLC] =3D { PLL0_REFCLK, PLL1_REFCLK },
> +     [CMN_PLLLC1] =3D { PLL1_REFCLK, PLL0_REFCLK },
> +};
> +
> +static u32 cdns_sierra_pll_mux_table[] =3D { 0, 1 };
> +
>  struct cdns_sierra_inst {
>       struct phy *phy;
>       u32 phy_type;
> @@ -204,10 +263,15 @@ struct cdns_sierra_phy {
>       struct regmap_field *macro_id_type;
>       struct regmap_field *phy_pll_cfg_1;
>       struct regmap_field *pllctrl_lock[SIERRA_MAX_LANES];
> +     struct regmap_field
> *cmn_refrcv_refclk_plllc1en_preg[SIERRA_NUM_CMN_PLLC];
> +     struct regmap_field
> *cmn_refrcv_refclk_termen_preg[SIERRA_NUM_CMN_PLLC];
> +     struct regmap_field
> *cmn_plllc_pfdclk1_sel_preg[SIERRA_NUM_CMN_PLLC];
>       struct clk *input_clks[CDNS_SIERRA_INPUT_CLOCKS];
>       int nsubnodes;
>       u32 num_lanes;
>       bool autoconf;
> +     struct clk_onecell_data clk_data;
> +     struct clk *output_clks[CDNS_SIERRA_OUTPUT_CLOCKS];
>  };
>
>  static int cdns_regmap_write(void *context, unsigned int reg, unsigned i=
nt
> val)
> @@ -369,6 +433,153 @@ static const struct phy_ops ops =3D {
>       .owner          =3D THIS_MODULE,
>  };
>
> +static u8 cdns_sierra_pll_mux_get_parent(struct clk_hw *hw)
> +{
> +     struct cdns_sierra_pll_mux *mux =3D to_cdns_sierra_pll_mux(hw);
> +     struct regmap_field *field =3D mux->pfdclk_sel_preg;
> +     unsigned int val;
> +
> +     regmap_field_read(field, &val);
> +     return clk_mux_val_to_index(hw, cdns_sierra_pll_mux_table, 0, val);
> +}
> +
> +static int cdns_sierra_pll_mux_set_parent(struct clk_hw *hw, u8 index)
> +{
> +     struct cdns_sierra_pll_mux *mux =3D to_cdns_sierra_pll_mux(hw);
> +     struct regmap_field *plllc1en_field =3D mux->plllc1en_field;
> +     struct regmap_field *termen_field =3D mux->termen_field;
> +     struct regmap_field *field =3D mux->pfdclk_sel_preg;
> +     int val, ret;
> +
> +     ret =3D regmap_field_write(plllc1en_field, 0);
> +     ret |=3D regmap_field_write(termen_field, 0);
> +     if (index =3D=3D 1) {
> +             ret |=3D regmap_field_write(plllc1en_field, 1);
> +             ret |=3D regmap_field_write(termen_field, 1);
> +     }
> +
> +     val =3D cdns_sierra_pll_mux_table[index];
> +     ret |=3D regmap_field_write(field, val);
> +
> +     return ret;
> +}
> +
> +static const struct clk_ops cdns_sierra_pll_mux_ops =3D {
> +     .set_parent =3D cdns_sierra_pll_mux_set_parent,
> +     .get_parent =3D cdns_sierra_pll_mux_get_parent,
> +};
> +
> +static int cdns_sierra_pll_mux_register(struct cdns_sierra_phy *sp,
> +                                     struct regmap_field
> *pfdclk1_sel_field,
> +                                     struct regmap_field *plllc1en_field=
,
> +                                     struct regmap_field *termen_field,
> +                                     int clk_index)
> +{
> +     struct cdns_sierra_pll_mux *mux;
> +     struct device *dev =3D sp->dev;
> +     struct clk_init_data *init;
> +     const char **parent_names;
> +     unsigned int num_parents;
> +     char clk_name[100];
> +     struct clk *clk;
> +     int i;
> +
> +     mux =3D devm_kzalloc(dev, sizeof(*mux), GFP_KERNEL);
> +     if (!mux)
> +             return -ENOMEM;
> +
> +     num_parents =3D SIERRA_NUM_CMN_PLLC_PARENTS;
> +     parent_names =3D devm_kzalloc(dev, (sizeof(char *) * num_parents),
> GFP_KERNEL);
> +     if (!parent_names)
> +             return -ENOMEM;
> +
> +     for (i =3D 0; i < num_parents; i++) {
> +             clk =3D sp->input_clks[pll_mux_parent_index[clk_index][i]];
> +             if (IS_ERR_OR_NULL(clk)) {
> +                     dev_err(dev, "No parent clock for derived_refclk\n"=
);
> +                     return PTR_ERR(clk);
> +             }
> +             parent_names[i] =3D __clk_get_name(clk);
> +     }
> +
> +     snprintf(clk_name, sizeof(clk_name), "%s_%s", dev_name(dev),
> clk_names[clk_index]);
> +
> +     init =3D &mux->clk_data;
> +
> +     init->ops =3D &cdns_sierra_pll_mux_ops;
> +     init->flags =3D CLK_SET_RATE_NO_REPARENT;
> +     init->parent_names =3D parent_names;
> +     init->num_parents =3D num_parents;
> +     init->name =3D clk_name;
> +
> +     mux->pfdclk_sel_preg =3D pfdclk1_sel_field;
> +     mux->plllc1en_field =3D plllc1en_field;
> +     mux->termen_field =3D termen_field;
> +     mux->hw.init =3D init;
> +
> +     clk =3D devm_clk_register(dev, &mux->hw);
> +     if (IS_ERR(clk))
> +             return PTR_ERR(clk);
> +
> +     sp->output_clks[clk_index] =3D clk;
> +
> +     return 0;
> +}
> +
> +static int cdns_sierra_phy_register_pll_mux(struct cdns_sierra_phy *sp)
> +{
> +     struct regmap_field *pfdclk1_sel_field;
> +     struct regmap_field *plllc1en_field;
> +     struct regmap_field *termen_field;
> +     struct device *dev =3D sp->dev;
> +     int ret =3D 0, i, clk_index;
> +
> +     clk_index =3D CDNS_SIERRA_PLL_CMNLC;
> +     for (i =3D 0; i < SIERRA_NUM_CMN_PLLC; i++, clk_index++) {
> +             pfdclk1_sel_field =3D sp->cmn_plllc_pfdclk1_sel_preg[i];
> +             plllc1en_field =3D sp->cmn_refrcv_refclk_plllc1en_preg[i];
> +             termen_field =3D sp->cmn_refrcv_refclk_termen_preg[i];
> +
> +             ret =3D cdns_sierra_pll_mux_register(sp, pfdclk1_sel_field,
> plllc1en_field,
> +                                                termen_field, clk_index)=
;
> +             if (ret) {
> +                     dev_err(dev, "Fail to register cmn plllc mux\n");
> +                     return ret;
> +             }
> +     }
> +
> +     return 0;
> +}
> +
> +static void cdns_sierra_clk_unregister(struct cdns_sierra_phy *sp)
> +{
> +     struct device *dev =3D sp->dev;
> +     struct device_node *node =3D dev->of_node;
> +
> +     of_clk_del_provider(node);
> +}
> +
> +static int cdns_sierra_clk_register(struct cdns_sierra_phy *sp)
> +{
> +     struct device *dev =3D sp->dev;
> +     struct device_node *node =3D dev->of_node;
> +     int ret;
> +
> +     ret =3D cdns_sierra_phy_register_pll_mux(sp);
> +     if (ret) {
> +             dev_err(dev, "Failed to pll mux clocks\n");
> +             return ret;
> +     }
> +
> +     sp->clk_data.clks =3D sp->output_clks;
> +     sp->clk_data.clk_num =3D CDNS_SIERRA_OUTPUT_CLOCKS;
> +     ret =3D of_clk_add_provider(node, of_clk_src_onecell_get, &sp-
> >clk_data);
> +     if (ret)
> +             dev_err(dev, "Failed to add clock provider: %s\n", node-
> >name);
> +
> +     return ret;
> +}
> +
>  static int cdns_sierra_get_optional(struct cdns_sierra_inst *inst,
>                                   struct device_node *child)
>  {
> @@ -407,6 +618,7 @@ static int cdns_regfield_init(struct cdns_sierra_phy
> *sp)
>  {
>       struct device *dev =3D sp->dev;
>       struct regmap_field *field;
> +     struct reg_field reg_field;
>       struct regmap *regmap;
>       int i;
>
> @@ -418,6 +630,32 @@ static int cdns_regfield_init(struct cdns_sierra_phy
> *sp)
>       }
>       sp->macro_id_type =3D field;
>
> +     for (i =3D 0; i < SIERRA_NUM_CMN_PLLC; i++) {
> +             reg_field =3D cmn_plllc_pfdclk1_sel_preg[i].pfdclk_sel_preg=
;
> +             field =3D devm_regmap_field_alloc(dev, regmap, reg_field);
> +             if (IS_ERR(field)) {
> +                     dev_err(dev, "PLLLC%d_PFDCLK1_SEL failed\n", i);
> +                     return PTR_ERR(field);
> +             }
> +             sp->cmn_plllc_pfdclk1_sel_preg[i] =3D field;
> +
> +             reg_field =3D cmn_plllc_pfdclk1_sel_preg[i].plllc1en_field;
> +             field =3D devm_regmap_field_alloc(dev, regmap, reg_field);
> +             if (IS_ERR(field)) {
> +                     dev_err(dev, "REFRCV%d_REFCLK_PLLLC1EN failed\n",
> i);
> +                     return PTR_ERR(field);
> +             }
> +             sp->cmn_refrcv_refclk_plllc1en_preg[i] =3D field;
> +
> +             reg_field =3D cmn_plllc_pfdclk1_sel_preg[i].termen_field;
> +             field =3D devm_regmap_field_alloc(dev, regmap, reg_field);
> +             if (IS_ERR(field)) {
> +                     dev_err(dev, "REFRCV%d_REFCLK_TERMEN failed\n",
> i);
> +                     return PTR_ERR(field);
> +             }
> +             sp->cmn_refrcv_refclk_termen_preg[i] =3D field;
> +     }
> +
>       regmap =3D sp->regmap_phy_config_ctrl;
>       field =3D devm_regmap_field_alloc(dev, regmap, phy_pll_cfg_1);
>       if (IS_ERR(field)) {
> @@ -511,6 +749,22 @@ static int cdns_sierra_phy_get_clocks(struct
> cdns_sierra_phy *sp,
>       }
>       sp->input_clks[CMN_REFCLK1_DIG_DIV] =3D clk;
>
> +     clk =3D devm_clk_get_optional(dev, "pll0_refclk");
> +     if (IS_ERR(clk)) {
> +             dev_err(dev, "pll0_refclk clock not found\n");
> +             ret =3D PTR_ERR(clk);
> +             return ret;
> +     }
> +     sp->input_clks[PLL0_REFCLK] =3D clk;
> +
> +     clk =3D devm_clk_get_optional(dev, "pll1_refclk");
> +     if (IS_ERR(clk)) {
> +             dev_err(dev, "pll1_refclk clock not found\n");
> +             ret =3D PTR_ERR(clk);
> +             return ret;
> +     }
> +     sp->input_clks[PLL1_REFCLK] =3D clk;
> +
>       return 0;
>  }
>
> @@ -586,13 +840,17 @@ static int cdns_sierra_phy_probe(struct
> platform_device *pdev)
>       if (ret)
>               return ret;
>
> -     ret =3D cdns_sierra_phy_get_resets(sp, dev);
> +     ret =3D cdns_sierra_clk_register(sp);
>       if (ret)
>               return ret;
>
> +     ret =3D cdns_sierra_phy_get_resets(sp, dev);
> +     if (ret)
> +             goto unregister_clk;
> +
>       ret =3D clk_prepare_enable(sp->input_clks[PHY_CLK]);
>       if (ret)
> -             return ret;
> +             goto unregister_clk;
>
>       /* Enable APB */
>       reset_control_deassert(sp->apb_rst);
> @@ -669,6 +927,8 @@ static int cdns_sierra_phy_probe(struct
> platform_device *pdev)
>  clk_disable:
>       clk_disable_unprepare(sp->input_clks[PHY_CLK]);
>       reset_control_assert(sp->apb_rst);
> +unregister_clk:
> +     cdns_sierra_clk_unregister(sp);
>       return ret;
>  }
>
> @@ -691,6 +951,7 @@ static int cdns_sierra_phy_remove(struct
> platform_device *pdev)
>       }
>
>       clk_disable_unprepare(phy->input_clks[PHY_CLK]);
> +     cdns_sierra_clk_unregister(phy);
>
>       return 0;
>  }
> --
> 2.17.1

