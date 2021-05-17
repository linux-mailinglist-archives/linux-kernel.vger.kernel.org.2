Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FBB6382555
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 09:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233872AbhEQHar (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 03:30:47 -0400
Received: from mail-vi1eur05on2137.outbound.protection.outlook.com ([40.107.21.137]:63200
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233350AbhEQHap (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 03:30:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hQl/C1iGqVM3fzCTkWZsudr3hUpTFWEd94gixC42tgd7W5lCwNvisulllCXUAWYXJsZJ4XFhpuG292/6U/zBdvET/PO2Bplo12f3I8Y3s5IeP4xwtmKjvxtbwOfVmKk3C6toLwXddB1R50SPopCKR3lFdqQTlD8k8efFyUIQFt23lVntb0IA3rEyysGgZiSd6Tr7tH+pPwGKpfyjuATgCWerlKVa14MXqWpLjsqsIIdXetipDhXMBo/reRQTFhFST6ViRtnSVMHLl7itRokUXAnqDgSOQBT9P9cpCk/f38Z5IjovCfHfAMt49BGwpoHazTYlUyXCbrqt55ANiGq3Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v1WL6N+iNu+cWwb/eiQM0OMR5ALXulpqQRG6MO6hGe8=;
 b=hnfHSHA27Xfyt4Jj8+KaL75qlYNWuwVtq/Z1KAAheUyKQioqBi2QBjmZP+sXV9icUhZE2ZaOfVwHCQcttGaEmzXDIM1pv4Un2bd8xKuJP4ZyWSLH0BzwSQXtgThVfq7tsK2GduDGAyqv6mtUem1e7i+9llIBTx+kWZXOhqx8XcwuA1hxdGCofOfXaecyS9GAPXZdrryFexhXdO6p4Hyj3FIrwAyVB+ey16O+SBaZDJb2xWzLZ+SGF3ibV0d6iUBeEqqDqrbiB9a3xBOS0IXwLuZtmpy1778eQ0xHDoPuTGgqhX2M8nHxyuPiHTLOa8FWybOpxqZ9CZDtzc8u0P/aiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v1WL6N+iNu+cWwb/eiQM0OMR5ALXulpqQRG6MO6hGe8=;
 b=gRO6+t/F7NPqHVdd4KFWz+t3HqirKU4YiBu0bgwbKbWgVeHlX2VHWdPlsHmND32BRc8oo/eX50hv8DnQaA5j6AhHP3IAsyomDjNnjnXGiAZ9K7hICj6ccW3N79bDsBtkv3QW+CGZPLBldOCHkp0w5El4AJdjiTGL3r3w9lZiLrc=
Authentication-Results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=kontron.de;
Received: from AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:157::14)
 by AM0PR10MB3332.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:17d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Mon, 17 May
 2021 07:29:27 +0000
Received: from AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3d8a:f56b:3a0c:8a87]) by AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3d8a:f56b:3a0c:8a87%7]) with mapi id 15.20.4129.031; Mon, 17 May 2021
 07:29:27 +0000
Subject: Re: [PATCH V4 0/4] soc: imx: add i.MX BLK-CTL support
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, robh+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        p.zabel@pengutronix.de, l.stach@pengutronix.de, krzk@kernel.org,
        agx@sigxcpu.org, marex@denx.de, andrew.smirnov@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, ping.bai@nxp.com, aford173@gmail.com,
        abel.vesa@nxp.com, Peng Fan <peng.fan@nxp.com>
References: <20210510040704.14997-1-peng.fan@oss.nxp.com>
From:   Frieder Schrempf <frieder.schrempf@kontron.de>
Message-ID: <e1f1984c-9d79-beea-cc51-a154a50ec078@kontron.de>
Date:   Mon, 17 May 2021 09:28:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <20210510040704.14997-1-peng.fan@oss.nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [109.250.142.188]
X-ClientProxiedBy: AS8PR04CA0110.eurprd04.prod.outlook.com
 (2603:10a6:20b:31e::25) To AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:157::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.10.17] (109.250.142.188) by AS8PR04CA0110.eurprd04.prod.outlook.com (2603:10a6:20b:31e::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.32 via Frontend Transport; Mon, 17 May 2021 07:29:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0e1b54d9-ac49-45cd-0db4-08d91905809c
X-MS-TrafficTypeDiagnostic: AM0PR10MB3332:
X-Microsoft-Antispam-PRVS: <AM0PR10MB3332DDE89D884840B02F66CBE92D9@AM0PR10MB3332.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PxWBXha7NHKhWyCTaON7Fzg5muhuYzEW0sELKlK6Z6UjbWUiYn+oiskYInZn+dAG4vEas/YF0MsDtriLH0YBZjpAqJuCY40kclj2KYoRuCuZ0eH1HJphfPz8LL7aSXLlac/HiSRGHeUBwxZm/g90pXUjRM55NigwX3DCHlbq8xUuUQILTbdSsH/UzXxxlbdQyNwD+vdaiFya2QxbyyNksuZh7Yw7P9Prr6tKawzy1jHz/l93q9iITfIGFnr9SPLMyBoNjSQmX9ZNs4qPXA9Z9BWt1PlKb8d/SkIg7WXiI4EbC+Aak+4cOC2jYxx31ElXRzaDmhCNXaU39qV+nfJI5UqDbR8UbNzp5kCL1srWAJuMMEY1zIQhMNGDTbxjRmzyayMY0oWXHLFDOxK0Uj9fnIgxQJjxhoUP1XXaKIACl2yVaX5s4xUdQ1BgcqKLxybGOJBv7jeezyrbOK//yBAycbyDuX1z56cwCdLQeI/0YhphXZRWASQTrxG4UrhiUOzp4ENg5KwWO+863ltHenf9lzWszkAj/NICCExOX4HzmH1vMn+RSFybyVl/VIMUEe3YE+FCf0sm1uh0GndU52mZRzYC8qgFGdvZBNPMS33dc3SYxfNRqnsnC57xMXY+hP/L6SN7bj4Qhl9Osdxi2nLKCfxe2KRDcLfn8yNM4oVJPBXG0FkVdECgvMzOrn+SB1Us
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(136003)(376002)(39860400002)(366004)(83380400001)(86362001)(53546011)(2906002)(26005)(5660300002)(478600001)(16576012)(4326008)(31696002)(38100700002)(316002)(956004)(2616005)(186003)(66476007)(6486002)(66946007)(8936002)(66556008)(6666004)(31686004)(44832011)(8676002)(16526019)(7416002)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?OXg4bWNDdy81TGVFc3h6M0FGNGMwR0NkZnVTd09QOU1oZkdlQ1ZzMHQzVWF0?=
 =?utf-8?B?ald1SDJaTklBMUVXWFMxWjlBYWZhbWVXUFhCZ3dlOGJnczhSaXEwRnJRVnBU?=
 =?utf-8?B?SHBGeHpWYXVKdGladWtVdzBiSnozbE1FVHNtRkFrR1c0VzNXdnFWdzBHcnI3?=
 =?utf-8?B?K295aFVnRHVteWJLLzZrakRocElEa0hwMDZCemZLdjVyd09vZzhXZDhWWU81?=
 =?utf-8?B?aUtIUkw3dnBReFppcVpiS1h5M2tsZW5yMWlZNmdITzZiU0ZpTDN6MG9WeUZr?=
 =?utf-8?B?dWUwdFpnMkU2emx6Y21WMSszVnNBYS9kZWsrMHQ5VjRsZ2hLOUdmL1JZblhu?=
 =?utf-8?B?ekJsSE5RbnFuclhGN2VTeTdQdWJtWXRMQ2xoa1dVelJuTEZiN3JkWWRRNFNS?=
 =?utf-8?B?OVZwR25LdEh1dEVxS2dNZUhmY0hOQ3dYOVlPSUVDaE9MWG0wZGQ3bFVvd3hO?=
 =?utf-8?B?ZWNiQ0FablpnbVJQVDBXN3lCQVVjcUMzTWJxOUpzS2xKS3ppYi8yMlBMNnFl?=
 =?utf-8?B?VW5Nb3l2WlN3amhkWFdsV0YvUlpEWlk4bWNmaUo2d1crbW1QQzNlb0NRV0RU?=
 =?utf-8?B?REVUclg3QkxZS29VRGQ4c0VMYWJjVS9ZeG5mRjNkWEYrZi82aDJwdGRWQSs4?=
 =?utf-8?B?VzRVK3RiL1dHQXNnMGprYWR4MlNtVlArVHdVYjlPVjJTYTRwaithcGV4WlU0?=
 =?utf-8?B?RWVCVVRub1dBOFBNTkxsYzc5T1hHMzR6a3cxZXlYYmhKV2NMKzA2OW5ibXhZ?=
 =?utf-8?B?MDBLNjZFQUdsSjdBN1BWL09wM0dCODJOS2JTTTA0dWJmMjdtQU41M0RndGxn?=
 =?utf-8?B?SjJVaks2ZkNEV0k2NXRGWm1zeGljWkZtRnJML3gwWGo2Ykd2Y0wxVTU5K0Jv?=
 =?utf-8?B?RU5leWZPWGI1aklESjVISjg0aWx6UGQ3azJ2QjlkalpMT1M2bTY3bmxwWFJz?=
 =?utf-8?B?ODFmc0RyVi9aTVE4ay9RVUhDMXk5RStOeW4vc0tBUHNmeTRuMGZsWEpxSWly?=
 =?utf-8?B?dXR6TVFHZmNOT1g1ZkNhSnFFOFZONHdUSmFzU1ZCYVdyU1NzbkRLMDdTYW8z?=
 =?utf-8?B?ZHpPWk5uekgrK0tSSnR2TTRtZjVsaitHcGlCVUFVMWJVN0tlZVNqMEs4TjNC?=
 =?utf-8?B?UGJ1YmlWMlI3ZXdvdXBIemJlWVdLV21EQnZlZTJoNk1QS1VDTUFTcmtrRVRr?=
 =?utf-8?B?UWYwYVVJSkFoSUVRanhQV3JtNkYzRW1qREswdDRIYnNxMXZ6U0o1aGppaHhQ?=
 =?utf-8?B?Tkx0OXRXL1BrUEU4ZTV0UStUUkNtSzZUZkxVeWZiRjBscEw2ZXFNd1Zyazls?=
 =?utf-8?B?YkdIY1h6NlAwaHZraHdrRmdjNEd3cHRmWHlscC9CdGt3amd2YWY2b0VVTkFX?=
 =?utf-8?B?WiswT2tuaDBNaFFOektEVFpJb2IxLzFyTWw2cExtSVNsV29YeDl4Znd2WDd3?=
 =?utf-8?B?TUlzUWMzOGdUOUpvT3dNYlNnQ0RhcFpSTXVhU0JCeWt4dnBLeEpBQ2g0YUVW?=
 =?utf-8?B?VnhZUFNSSmtud21rRUFmNzFBaEhPaVlUaDBReFNFVGRMSHZ1Q21ENnMrNUFY?=
 =?utf-8?B?NkI5Q3lDNUNvUW9BYzZIUjRxUSs3SERQYStRUlRtMW1NWWdxZjVJTHpNalhD?=
 =?utf-8?B?c0NSdHE5T0JFMVdVdUVuUXowQXgvOWdvaVZGQ1pmMG82eDdSOHFGdUtyUURK?=
 =?utf-8?B?WS85cTB1dGsvTGdycS9qeEFzUUQ5bE95V3I3UXk2Z0xOekFtQXl0ZHF0TzQ4?=
 =?utf-8?Q?E+LjX3c8XR++Ro7YCBrnMZV70QbdZiBmlvL9XxD?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e1b54d9-ac49-45cd-0db4-08d91905809c
X-MS-Exchange-CrossTenant-AuthSource: AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2021 07:29:27.4596
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QcWQPu+5Bg0NTeukwB80MKjKwkVc3apEFClS1chQAlLMqt2+mF1/Bu7rssj71PT0Qibcfq3xGrW/wJP/L3t4nMngpMxQ+FCP4GSQil3c0FA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3332
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10.05.21 06:07, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> V4:
>  Add R-b tag
>  Typo fix
>  Update the power domain macro names Per Abel and Frieder
> 
> V3:
>  Add explaination for not listing items in patch 2 commit log Per Rob.
>  Addressed comments from Lucas and Frieder on patch [3,4].
>  A few comments from Jacky was ignored, because following gpcv2
>  coding style.
> 
> V2:
>  Fix yaml check failure.
> 
> Previously there is an effort from Abel that take BLK-CTL as clock
> provider, but it turns out that there is A/B lock issue and we are
> not able resolve that.
> 
> Per discuss with Lucas and Jacky, we made an agreement that take BLK-CTL
> as a power domain provider and use GPC's domain as parent, the consumer
> node take BLK-CTL as power domain input.
> 
> This patchset has been tested on i.MX8MM EVK board, but one hack
> is not included in the patchset is that the DISPMIX BLK-CTL
> MIPI_M/S_RESET not implemented. Per Lucas, we will finally have a MIPI
> DPHY driver, so fine to leave it.
> 
> Thanks for Lucas's suggestion, Frieder Schrempf for collecting
> all the patches, Abel's previous BLK-CTL work, Jacky Bai on help
> debug issues.

I tested v3 of this patchset with our i.MX8MM hardware and additional patches for DSIM support:

Tested-by: Frieder Schrempf <frieder.schrempf@kontron.de>

> 
> 
> Peng Fan (4):
>   dt-bindings: power: Add defines for i.MX8MM BLK-CTL power domains
>   Documentation: bindings: clk: Add bindings for i.MX BLK_CTL
>   soc: imx: Add generic blk-ctl driver
>   soc: imx: Add blk-ctl driver for i.MX8MM
> 
>  .../bindings/soc/imx/fsl,imx-blk-ctl.yaml     |  66 ++++
>  drivers/soc/imx/Makefile                      |   2 +-
>  drivers/soc/imx/blk-ctl-imx8mm.c              | 138 ++++++++
>  drivers/soc/imx/blk-ctl.c                     | 307 ++++++++++++++++++
>  drivers/soc/imx/blk-ctl.h                     |  77 +++++
>  include/dt-bindings/power/imx8mm-power.h      |  11 +
>  6 files changed, 600 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/soc/imx/fsl,imx-blk-ctl.yaml
>  create mode 100644 drivers/soc/imx/blk-ctl-imx8mm.c
>  create mode 100644 drivers/soc/imx/blk-ctl.c
>  create mode 100644 drivers/soc/imx/blk-ctl.h
> 
