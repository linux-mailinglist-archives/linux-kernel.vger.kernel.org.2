Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D88BF37279D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 10:55:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbhEDI4E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 04:56:04 -0400
Received: from mail-eopbgr40126.outbound.protection.outlook.com ([40.107.4.126]:43688
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229703AbhEDI4D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 04:56:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E3TkgzRWKL/C1KHZhU7YAI11YWyUR6zi1kGv50bJPWVrCaYYudk5FN5kpzYAfNPn1OC+q12uZNXZnBXO2ChUqnCKqB+zfBBu1Gkl0luBYNJFVgi4jzf5o+UNdjcks74XOCjworXnqQi+9IeIf2ryaCKFbrAuX8N83oPdTImOnymA66YLK77KpU4nyyvrYt2HgBiqRFesvM5a0c2vtheUmsJcywY0bT188F17x0BHmKCpJxGDatyvPqiS8toqLdv9M+r7juuc3uOTfCe4pABa/ZUF+JaKOscXe6nFUmCJq9LjB64KYblfJm32LXOkJQOQJS9DEMoIO/IukmBbPfhgXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sFrp9Myq1DoCkpr6325MqArFBeAvRxf3abmtilrObts=;
 b=faQBtXWDBlvPEqKQFO6ej5G23YjP6IHlnyFISuHq2UFNJ+X3pyhmhrGOWwcOx581gr6wADzR1Pn+mhRJc3bUTprk+zjpWcxQ9Tbm/VrOVvMabVOzckClpBmHx1yGhSJd0DaTnlPZRoDSsf5/FgfIvJThcFB31eQA9gGK+3zZQzVjoBcrq8t/DqsSDh7TiWe19HUIyv3wD996tfo8l3aQsJJphW1Yo7IIYfk+6Rlr4UeQH5RoTBKw0lGH/dVrZUbwd8Zt9lSCQ/utOic9HDG6LZw9Fp7Dog+OkSD1k1GcIm0QCwBuubwWIMKDk54x2Ypja/vSEgV20l2g5z0FUzu62Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sFrp9Myq1DoCkpr6325MqArFBeAvRxf3abmtilrObts=;
 b=nME+Zq+uuVCC35KJktEaEkSZgUOZCVT4ns1opCyGOHFkb1cXotnFjY4oji4i2QDQ7wJRj7N/ARPyPExF/IcBYtm8k3gke3udNSOwwv/cdRU0Nxdnkuiu6PrfFlsU0wwyyMRKCQ8V44IZo6K9WpezBOygHCHco60KqOdwyhL/Uv8=
Authentication-Results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=kontron.de;
Received: from AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:157::14)
 by AM0PR10MB3297.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:182::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.38; Tue, 4 May
 2021 08:55:06 +0000
Received: from AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3d8a:f56b:3a0c:8a87]) by AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3d8a:f56b:3a0c:8a87%7]) with mapi id 15.20.4087.044; Tue, 4 May 2021
 08:55:06 +0000
Subject: Re: [PATCH V2 0/4] soc: imx: add i.MX BLK-CTL support
From:   Frieder Schrempf <frieder.schrempf@kontron.de>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, robh+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        p.zabel@pengutronix.de, l.stach@pengutronix.de, krzk@kernel.org,
        agx@sigxcpu.org, marex@denx.de, andrew.smirnov@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, ping.bai@nxp.com, aford173@gmail.com,
        abel.vesa@nxp.com, Peng Fan <peng.fan@nxp.com>
References: <20210430052746.10815-1-peng.fan@oss.nxp.com>
 <ae7630e5-af69-3504-2298-23e432308ce6@kontron.de>
Message-ID: <2f0300ba-2465-b379-6824-6b66cfad1c59@kontron.de>
Date:   Tue, 4 May 2021 10:55:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <ae7630e5-af69-3504-2298-23e432308ce6@kontron.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [89.244.177.213]
X-ClientProxiedBy: AM3PR07CA0058.eurprd07.prod.outlook.com
 (2603:10a6:207:4::16) To AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:157::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.10.27] (89.244.177.213) by AM3PR07CA0058.eurprd07.prod.outlook.com (2603:10a6:207:4::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.8 via Frontend Transport; Tue, 4 May 2021 08:55:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aa80b016-15ae-430d-6116-08d90eda4fd7
X-MS-TrafficTypeDiagnostic: AM0PR10MB3297:
X-Microsoft-Antispam-PRVS: <AM0PR10MB32974A0E70068D6CC938BFE4E95A9@AM0PR10MB3297.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TQ55yQ/8gPJdIkclFFcptkHQoxOhoO/dUUF6wgQriqYIBJN9Yiy/6PzyRzisuM/BVgynrbcycRDMtoHNFb0JrnyCK9y0gCMBQ5Aw0YKdihDD348yH65Lt05ZLfQnuGgCJCiQ9reUqsyytKF4EB81NWCKxLwh143B40xC9LE1tFncLNyEFSS9A/B0c74ksq+7CmoNzb/smOvfiOvuZeqnNG7bYjv8wWkZueeYm+O8XbV5d7oM9E60JDPe+ZhsV/oVkdf03s8AjHAMUnDph9dKZh30NGh8KplIs0vCInBMANJ8gw0Ix+Q5j1/mx72xB3y9jtJQP4zX+6GTFWDL88xE6KBTNPUIVQMjxeEF/OY5wXNtUmCEZu+N8TkDdBaNNDgRiYqPuVy4CRf6kxKsSZE5GFu7NIf+bTQmeMHEfEmktmEnjdT4RDz+WXRxrKp+0gup9g3rIxfozJaXeIvvxi1u75ic+RRdbAnJLXsCApPT4YYB10WpFOGR2TQcraG+MdgeBKXIXISkbl8bTUPNS8z8z4Mq09y1U5LNsiAmsD8H7wF6tXBp5z30DuGSrX8XqTuC2iFuRcoKGbDwS5a+NpvMDBXJCu+rT09sB4TSIskDD5EmRSOPgPkV7J8YhK5uJbfp16gV6V2DM1Ep9s1TwE/jQ16NtTE+I+v6mjoA3aqbOD4lCWM/sgFzkeks8yLiNEJ/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(396003)(39850400004)(346002)(366004)(8676002)(31696002)(44832011)(316002)(478600001)(6486002)(8936002)(7416002)(16576012)(4326008)(36756003)(5660300002)(2616005)(956004)(86362001)(2906002)(186003)(66556008)(66476007)(31686004)(38100700002)(66946007)(53546011)(26005)(83380400001)(16526019)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?eTZYVnZqVGtuTVNUMmg3VFZXamRqNUF2UzgxL2tETStxWWhITU94NG42NmFY?=
 =?utf-8?B?MHVVTU13bDVUZzZ0eUZpNldyQmw3Yy9UdnZlV1liNjZJRE5zcDJCNU1Mcll2?=
 =?utf-8?B?K2wwM2JmNmZTdERGSkhhbmdFdkZXZzFSbnRvNnpybTVveUd3Z0RZNXVEWFV4?=
 =?utf-8?B?a1BDdXVkenp1VDU4OEJDUjl3UzFWVElpWThtR0c4MXhOZmJ3eE83MktXM1c5?=
 =?utf-8?B?bFJ0L3I2Zy9VVW1uckJka2psb05ISFpyZ09UNHBpY0gzQjY2cjVXcTIrUzMz?=
 =?utf-8?B?SmowMlpkR2d2VXhFcWhmNUc1MW55SkZEMmVQRHRFck5wSTQ5SklsanpHVGJ4?=
 =?utf-8?B?NU9ERGtoTzVrSC8yN1k4RFhUWlBJcXkzQUZWNWFHQ1EyQ1IwN3h1aFlRWk0x?=
 =?utf-8?B?UXFaQ1NNSVg0aUpmbmgvMnArS0VZcXRmVDFMeXBnT2VmUkIxTWRjeTlaSW8r?=
 =?utf-8?B?ZTRiSDg1R1c3OTR6U1hTN2pnWmVxMGhQYkk0dUlDYW5hSHVnMWVMRTdha0Rv?=
 =?utf-8?B?SDFSUmpUeHpmNVpZV3U1SEtjK3NZazVxYW9iZ25vZDZOMjJWYkpJcmFObUMv?=
 =?utf-8?B?dkV0SzZTMWoxb2VNWUo2TzNaZGJzSW1VY0dGYUI0czJXb21mSUd1K29rcnR2?=
 =?utf-8?B?NEpCc3l0MnBBVUsxWENkY0pVa1hxaTRIcHBpSVAraW5LeEJGSXFsUHMvQXc3?=
 =?utf-8?B?VzkvdnAvU3FOZlJlUGx2VDBLNm1GZFNiLzdWNHlNQkJGajBuUnZ5K3RQRHNV?=
 =?utf-8?B?K1FqbDFwTTUvSU9CY0Z6U1VPMENUVGlNcXpNdFNhNkEwZ05vdnRBdDY3dzB3?=
 =?utf-8?B?Q3M4UnU2OFo2VTFDQy9UNm1SaFVBV2FhYlZza1RpR2svNzd0TWI1Q1pFRmkz?=
 =?utf-8?B?cE5mN3ljeFJmMDZGU2dzSWFwdVBXWGQvbjlkSlZZT2IrQ25KcGhKUHRQT2Z2?=
 =?utf-8?B?VGdNS2dNZFEvVFBQaHYwMjBSSDVpUDRIV3NFQ042WVJrMVViUmpSaFFQRWlj?=
 =?utf-8?B?Ty9WRmNjYjFNK2pjbnBkaHRGVTgyQ0JBeTZxU1J1TVp1SndBbmFRZWxhTWx3?=
 =?utf-8?B?UEl0L3p1eGIrMHFzQnh2UTlrMU5UemFrbUo3L2RhMjFJdVlqeUt0aFAwemsv?=
 =?utf-8?B?UmE0ZjV3Ry9BU0tmbS84WU1wU3lldjVPcjhiZ1Z5aDVsM3duOFJGRUxwa3hU?=
 =?utf-8?B?RW81UU80cHNSMEhWRnhkVXNURlVoVlpiVDlvd0h6VHF3NGcrQmQ3M1VLVUpD?=
 =?utf-8?B?NVhoZm5GRjVHLzd6Y3Q2VXBlcUpuRGs3VlhMUkExaWk2KytScnFWU0NPSXla?=
 =?utf-8?B?ZURYL29CSWhtSHZzQWF0a0I2UDgzZVZwM2ROYWlLUHRkSmRXMTFoVVFMTFAx?=
 =?utf-8?B?d2M2TVNXK3J0bExyMzhpRmhSRUJ3OVhJc0Z5QWpUWDY5R01GeWhmQWZjTEhv?=
 =?utf-8?B?U1lYd2JnTXhQcE5hK1Iyck8wTURpMG00Y2g1d0h5cm5sVDNXblN6dE1jUktx?=
 =?utf-8?B?RndkTzllUXU5eVFSWVY2WEhnSTRheEwvTy95cTdQMkx4RmNVODAySWZsTy8z?=
 =?utf-8?B?YmhFMVh0UHAzRmFqL0w5eU5aOU1aVzdBNGZ6SStmeXk3U3phN1pnbHNzNXdB?=
 =?utf-8?B?ZnlQQU83RGR2T2VkT2UyZFYwS29tZENIZ01hdTRQV3hNSXl1eFdwMWt1SkRn?=
 =?utf-8?B?aUJ6VVZtN1V4eENaajBFWEVhaHhkaTNUc3RiQ05EeW5md25Ld05TUU8vbFdM?=
 =?utf-8?Q?i5qM5o/xjNt9Tt1FlqkR5EMXqaJAQ34Xjml+s8u?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: aa80b016-15ae-430d-6116-08d90eda4fd7
X-MS-Exchange-CrossTenant-AuthSource: AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2021 08:55:05.9927
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yDB9TGYdIXEgWdykbNjX0MZn4pTjkVt+JNQxG+4OKzv1FBr4SgwKcDTTj4UIfK/9RIUYAplD+l5iVsxozOC4bFRI0dsZr1+E4QKQAopyGoQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3297
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03.05.21 16:57, Frieder Schrempf wrote:
> Hi Peng,
> 
> On 30.04.21 07:27, Peng Fan (OSS) wrote:
>> From: Peng Fan <peng.fan@nxp.com>
>>
>> V2:
>>   Fix yaml check failure
>>
>> Previously there is an effort from Abel that take BLK-CTL as clock
>> provider, but it turns out that there is A/B lock issue and we are
>> not able resolve that.
>>
>> Per discuss with Lucas and Jacky, we made an agreement that take BLK-CTL
>> as a power domain provider and use GPC's domain as parent, the consumer
>> node take BLK-CTL as power domain input.
>>
>> This patchset has been tested on i.MX8MM EVK board, but one hack
>> is not included in the patchset is that the DISPMIX BLK-CTL 
>> MIPI_M/S_RESET
>> not implemented. Per Lucas, we will finally have a MIPI DPHY driver,
>> so fine to leave it.
> 
> Thanks for your work. I would like to test this together with the DSIM 
> and PHY driver by Michael and Marek. So far the boot hangs when probing 
> the DSIM, but I'm not even sure if my DT is correct.
> 
> With the DSIM PHY driver (see [1]) in place, the GPR_MIPI_M_RESETN 
> should be set correctly, right?

So I found out, that with the hack below applied (taken from Marek's WIP 
patches for DSIM support) it seems to work properly.

Therefore I guess this is an issue with the DSIM driver, that somehow 
needs to make sure that the proper clocks are enabled at probe time.

diff --git a/drivers/soc/imx/gpcv2.c b/drivers/soc/imx/gpcv2.c
index 04564017bfe9..5a9bca805b0c 100644
--- a/drivers/soc/imx/gpcv2.c
+++ b/drivers/soc/imx/gpcv2.c
@@ -9,6 +9,7 @@
   */

  #include <linux/clk.h>
+#include <linux/clk-provider.h>
  #include <linux/of_device.h>
  #include <linux/platform_device.h>
  #include <linux/pm_domain.h>
@@ -193,6 +194,7 @@ to_imx_pgc_domain(struct generic_pm_domain *genpd)
  static int imx_pgc_power_up(struct generic_pm_domain *genpd)
  {
         struct imx_pgc_domain *domain = to_imx_pgc_domain(genpd);
+       unsigned int i;
         u32 reg_val;
         int ret;

@@ -254,7 +256,14 @@ static int imx_pgc_power_up(struct 
generic_pm_domain *genpd)
         }

         /* Disable reset clocks for all devices in the domain */
-       clk_bulk_disable_unprepare(domain->num_clks, domain->clks);
+       //clk_bulk_disable_unprepare(domain->num_clks, domain->clks);
+       for (i = 0; i < domain->num_clks; i++) {
+               /* Keep the DISPMIX active, it is needed by both LCDIF 
and MIPI */
+               if (strcmp(__clk_get_name(domain->clks[i].clk), 
"disp_root_clk") &&
+                   strcmp(__clk_get_name(domain->clks[i].clk), 
"disp_axi_root_clk") &&
+                   strcmp(__clk_get_name(domain->clks[i].clk), 
"disp_apb_root_clk"))
+                       clk_disable_unprepare(domain->clks[i].clk);
+       }

         return 0;

