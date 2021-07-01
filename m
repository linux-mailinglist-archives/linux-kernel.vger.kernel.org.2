Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 699563B8F05
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 10:43:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235672AbhGAIpj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 04:45:39 -0400
Received: from mail-eopbgr30132.outbound.protection.outlook.com ([40.107.3.132]:60485
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235619AbhGAIpg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 04:45:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ExghVx6pY647fpVSAhSEHOYAwBuKch76Jx9w5XDnpTZEYOvDGPsd7tZPVtblpayq31bvBu4DY8wWxjhj67Jo3uebZ2BG1W0Zrb4jzC2xNXejbrltup/t7Nf6rTN+YLWhQdkkSyq1nzLqRZg2hXa7f3guRuuv/xXnt/EShVK//WL0y7JtmzrYlfFb/KZJihW6oo8QnssICkE1Lm02jhm1RWg25D4wEpvnor0O6NYxrjXPHq1F6rhgr/Mqx5R4sIIUq6TwxK4IXLJUwNxIzvVkXGv6hFTbGHzRN4Tgo11Omw2zxUATl3h5MWBpLzvKst3X4JND8/HdiZ6BEUcx6jco6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NIdrUk/cJ+3Kbb3BzZ4S5VJs8oF3SQDQUdeTbcsnTT0=;
 b=jJAQFLUwWdMm4OC8CYRH1kxl6w7ticu87b9Se6CKA2oiwbOZd+r8WbJhbbd8Qs8mru7uJfcbmLrbiY95/apFbfuLm31Lum8zzNON0OjJ5aBN2bHtew1d3TylgQaCwXUnx4LpI8qPUutqHKyG0jklT1ygLxNr9z0zS9FV28HlatZDi55G/X4YsJOt0F/iQJ7SAWYbcByL1Aoh+u3ItCbbS6RwOZrOPIF76wfRiKJP02fTBPMsDbYk7ddLLXODh4bCGHpedM2MjZStCLv8qyXXBK5FWBDNvU4xmgxjzCK2fAHKhnbtI1LnwMTvateYwhTKmEVqg2MuHT1DZ14/ZECwfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=opensynergy.com; dmarc=pass action=none
 header.from=opensynergy.com; dkim=pass header.d=opensynergy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=opensynergy.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NIdrUk/cJ+3Kbb3BzZ4S5VJs8oF3SQDQUdeTbcsnTT0=;
 b=Fe8iQh7VVv5/3y2rzWIJSWKTxcKqi8X8kghn1ZqdPevT6QrcMFLR0aMzPX9KlbiHuSj98EqsS9KNPXntveUqJnhasVO3L/lqwSoCmITmDTWuy92P7IAjwjMOzpH4yzdmClRx1dURQiJIFX6WD9bxalmRpiWhY4FnJ4LE+qy+zS8=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=opensynergy.com;
From:   Peter Hilber <peter.hilber@opensynergy.com>
To:     Cristian Marussi <cristian.marussi@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        virtualization@lists.linux-foundation.org,
        virtio-dev@lists.oasis-open.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, igor.skalkin@opensynergy.com,
        alex.bennee@linaro.org, jean-philippe@linaro.org,
        mikhail.golubev@opensynergy.com, anton.yakovlev@opensynergy.com,
        Vasyl.Vavrychuk@opensynergy.com,
        Andriy.Tryshnivskyy@opensynergy.com,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
References: <20210611165937.701-1-cristian.marussi@arm.com>
 <20210611165937.701-14-cristian.marussi@arm.com>
Subject: Re: [PATCH v4 13/16] dt-bindings: arm: Add virtio transport for SCMI
Message-ID: <e7fbfdfb-5368-f861-98c4-058d835779fc@opensynergy.com>
Date:   Thu, 1 Jul 2021 10:43:02 +0200
In-Reply-To: <20210611165937.701-14-cristian.marussi@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM6PR01CA0051.eurprd01.prod.exchangelabs.com
 (2603:10a6:20b:e0::28) To AM9PR04MB8084.eurprd04.prod.outlook.com
 (2603:10a6:20b:3ec::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f8323d59-6a25-4a5e-20f3-08d93c6c3dc9
X-MS-TrafficTypeDiagnostic: AM0PR04MB6609:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR04MB6609E3457C233FE66D1B083F8C009@AM0PR04MB6609.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2HxKYyPLiuB4entwykmBYg/iylq6gpCrSvex135uhPdNnHRA4zf9q1mFU9b/65bp3N1adYc1bXrfig2x5KH+y4VJ/np7XkCecAqBkH1y5lLPRX4FN49HTK+aiJ7mAMUnE++VGQau6EvALu+qVb0OfQcgPnc1DDQj2PjKQHdkvvhGmWwfGptiVfYbjNBqb6OR8QqcMmJu00iX2Xu37vH8oDqGuAK+lVkeqEiQFDiudenX8E9gAG5r5OLzaYVkpURQk/DzJzytpAbp4pAOUenuUITYsIW8s3Pmpuwp7VDESETtHONpaJS0uAmU4yO+XMIjJVxeHozudJQE9dor7K5zShvW3LP5c1JG+ttgrvNZZYNV/Rbyo0KMuqA/tIQOlZVOJZw9uZv/UbVa74W3aCcPNOnyaUkDqDaMdfLVN6tlty0MUjYQuLwCYevNTySY4JkMtxNeCs4ucFuv7YdC4mreR/QO/XW+INP/8K7burgGohtSnDu/hxq62f1PbwiaAAOQnUoHwkupq2pqOst1tRv9B4F/LeuFDZT2fqwlyECoHZ68qOaIP59VG+CHhH47dd7DPNJ9UxhXc6S62AmnJHXMcLPRjfgac9aFkRoqzzgT95/MxhtSX0WPFilDWG0aXrDCM/jKS/wrR43Sm8tYE5WaZ2YuDuykwktT5Jm7gDRdFphLqBTujQ14uofS+imFHpshNJJZ+VmZNYI/2j2G3j7+pV6pxRHTiydMNfvzz1/BE03G1q41Rw0PUv++7h5ueHiLEZ8pVdzLXCmVybDrRiEVVA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8084.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(346002)(366004)(39830400003)(376002)(396003)(5660300002)(53546011)(4326008)(31696002)(36756003)(86362001)(316002)(42186006)(966005)(8676002)(478600001)(8936002)(7416002)(66476007)(2616005)(44832011)(31686004)(83380400001)(38100700002)(186003)(2906002)(66556008)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z3RNSFVtUlRuN0FKcTlMQVQrNnJ4UW9IZ3N0bHBEUlhwZkp4c2MwdFdwTTFi?=
 =?utf-8?B?Nm9ieGNNd25FN2pRM2EvcmFCeWNKUTNVZjB6L1pBUVZjZ1RTNCtDdEQ2b01m?=
 =?utf-8?B?UnZZYkZEdHliWDFsbkFLakVuN0g0Yi82UWlZS3hZVVE1ZjJ3RHZGOXd6Q2lV?=
 =?utf-8?B?Ulp6QU5DWEYzREMwcTNzeHAvenNuT2d5MzZkZHdvdnFkRzNYaXRDYjFuclFD?=
 =?utf-8?B?a1JUMkFpdGVBRENaeVlOazlwdUpKWGMwaWpWaUw0SjBIeEoyby9iU2lMdWpI?=
 =?utf-8?B?NWxNWVgwc2ZlT1RtRURIcjlUZFdWaEhuSEZ1ZEFmZTVHSlVNU2VZZEZKVkpk?=
 =?utf-8?B?R0pHWHpvVjZibHRsZDJBc0htN2Q0TEptTE1UMWE4REdGWE5HcWJJd1VmeFpG?=
 =?utf-8?B?dGpXbVVkZ0VZSmYxandYbWkySmw4VlFsT2hnenJOQ25QaXJxZFBvVXNoWDZW?=
 =?utf-8?B?SkVKMDdNYmhTd1F4eE1vaVNEc1FqLzJMUi9SdktwTTg2dHI2M3RYN0I0Q2VB?=
 =?utf-8?B?K3ZydE95VnRtbVRVT1l5VFZjSVJqS3RGRXYrZWlFV2hlSlZ6eEQ3dCtVNTJJ?=
 =?utf-8?B?VlFSOXlBdE5wbVAwMTQzYmJNMkROSHoyV1pDd2RyZWV5YW1MK0hhL29EeGN2?=
 =?utf-8?B?Uk1PeU9vWFZ5bmxXMFdOSUpJS1FtSlhKdFdRREdrRWt0eDUrOTdQNCs1ZFVH?=
 =?utf-8?B?TlRIdWNzN1o3NW4zVkVWaHR6Rnh5ajRxTjdUa1V1U2IvL1EzdnhxQ2NVVVZR?=
 =?utf-8?B?Y2h5NUpPVXNRYTl5ZFRSVXE0VFVPMEVOeGk4ckVvNjh3OGlWeUhmaDdnZ1hI?=
 =?utf-8?B?WmFyQk1SY0ZSMTRzSUhSVnI1UzJaZHpKbXUwZFVYaVp2N0xYNXZmTTVrblkv?=
 =?utf-8?B?aDVwSjFLR01qZHg1ME5taVlsZ2NaZWhyekRKc3ljQ1BmL3VUZkZJTHFlZk9S?=
 =?utf-8?B?b2NoZERNS0U0OXRnTXZpdFZ2cC9YQWtoQWxEOVpncWNJNmtjeVRhUWFzTW5w?=
 =?utf-8?B?bnpkL0dmZHY2Vk16SHQvWHNuTnlTNURrdy83OVJ6YnZOVkc0aEJVR1Roa2hQ?=
 =?utf-8?B?TUdzSkxvSk8yU0lodW1BTEEwdWdmVURqeGRFamJrZTZTTlZ6UDZXMmFNNUlz?=
 =?utf-8?B?ZGd4amwwL2dzUVZQbk5jaHY0Nm8xT2xYRkFhOGZqT095NytxeVFUTHhqaTFN?=
 =?utf-8?B?My9ZS2lqMFU2ZS9LUEdkMENsNTc3VEdnVnJuQXBVQU9Qc0UvSENUcG5rUFJE?=
 =?utf-8?B?bCtJcE9qNWVhcTNTVjdJVW1NT1FPMWE2aEFIbVhlSnNIUnRCRytzVTRSb3BO?=
 =?utf-8?B?R29qR0FzMHdiVFBvdFpyUXVTdThBa3Z5SkJtemxvTnBkN1B1aFJWSnNFTVlV?=
 =?utf-8?B?eVlkdkk3ZjhjYkhxcjR3S25BY1YyZkE5bkNBTGkrK200VUNxbUVDSFEwT3dX?=
 =?utf-8?B?LzhrREI3UXdyUWZpcTJIMHhsUW1RcUVMRHhiK3RHa2YrVFhIS0s4T2pzZCtX?=
 =?utf-8?B?cjNiUlNWbU5IMnV0QmpPUk5Kck9OTm9sdzZIN1dyYUlzamZzQ0xMamZEY1Vj?=
 =?utf-8?B?aEhKenl6Y1hPWm1xdS94cDIxamdGdzdobkpKN1J6ekMvRUk1UnI2WXBabnNZ?=
 =?utf-8?B?UExibk10djdVRjZPd1dOY01zYkRmVktlaHlnWkxjNWpzUzBvWW53ZDUyT3Nh?=
 =?utf-8?B?UitYb1QwelpmYXVLOExzNERYdzF4TXFrRERDQjBSbHNxeml3RDREaFJadjMy?=
 =?utf-8?B?cTdqY0QrK1lDUENuZS83akd2S2V0dDJBWDlmZk1DbTBrL3QwamFjdGE3ZUYv?=
 =?utf-8?B?YlkySDZEN2tURVZ5c2hPbGdXaDluMkloWG1JNmR5cnAwOGRicXY3Q0RGYnI1?=
 =?utf-8?Q?1pc0HnGbYtnia?=
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8323d59-6a25-4a5e-20f3-08d93c6c3dc9
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8084.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2021 08:43:04.5180
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5ivVC49mPAh7RDI1bk674jr8Qsx4xUQL/9zKGIpPzMF9wp2/bddLZrzwkNqKiboJo1icLJzUO7kFLOmBwkQIdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6609
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.06.21 18:59, Cristian Marussi wrote:
> From: Igor Skalkin <igor.skalkin@opensynergy.com>
> 
> Document the properties for arm,scmi-virtio compatible nodes.
> The backing virtio SCMI device is described in patch [1].
> 
> While doing that, make shmem property required only for pre-existing
> mailbox and smc transports, since virtio-scmi does not need it.
> 
> [1] https://lists.oasis-open.org/archives/virtio-comment/202102/msg00018.html
> 
> CC: Rob Herring <robh+dt@kernel.org>
> CC: devicetree@vger.kernel.org
> Signed-off-by: Igor Skalkin <igor.skalkin@opensynergy.com>
> [ Peter: Adapted patch for submission to upstream. ]
> Co-developed-by: Peter Hilber <peter.hilber@opensynergy.com>
> Signed-off-by: Peter Hilber <peter.hilber@opensynergy.com>
> [ Cristian: converted to yaml format, moved shmen required property. ]
> Co-developed-by: Cristian Marussi <cristian.marussi@arm.com>
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> ---
> v3 --> V4
> - convertd to YAML
> - make shmem required only for pre-existing mailbox and smc transport
> - updated VirtIO specification patch message reference
> - dropped virtio-mmio SCMI device example since really not pertinent to
>    virtio-scmi dt bindings transport: it is not even referenced in SCMI
>    virtio DT node since they are enumerated by VirtIO subsystem and there
>    could be PCI based SCMI devices anyway.
> ---
>   Documentation/devicetree/bindings/firmware/arm,scmi.yaml | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> index cebf6ffe70d5..5c4c6782e052 100644
> --- a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> +++ b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> @@ -34,6 +34,10 @@ properties:
>         - description: SCMI compliant firmware with ARM SMC/HVC transport
>           items:
>             - const: arm,scmi-smc
> +      - description: SCMI compliant firmware with SCMI Virtio transport.
> +                     The virtio transport only supports a single device.
> +        items:
> +          - const: arm,scmi-virtio
>   
>     interrupts:
>       description:
> @@ -172,6 +176,7 @@ patternProperties:
>         Each sub-node represents a protocol supported. If the platform
>         supports a dedicated communication channel for a particular protocol,
>         then the corresponding transport properties must be present.
> +      The virtio transport does not support a dedicated communication channel.
>   
>       properties:
>         reg:
> @@ -195,7 +200,6 @@ patternProperties:
>   
>   required:
>     - compatible
> -  - shmem
>   
>   if:
>     properties:
> @@ -209,6 +213,7 @@ then:
>   
>     required:
>       - mboxes
> +    - shmem
>   
>   else:
>     if:
> @@ -219,6 +224,7 @@ else:
>     then:
>       required:
>         - arm,smc-id
> +      - shmem
>   
>   examples:
>     - |
> 

Maybe a minimal example for arm,scmi-virtio could be added, such as below:

diff --git a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml 
b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
index 5c4c6782e052..576faf970c1b 100644
--- a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
+++ b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
@@ -344,4 +344,19 @@ examples:
          };
      };

+  - |
+    firmware {
+        scmi {
+            compatible = "arm,scmi-virtio";
+
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            scmi_devpd2: protocol@11 {
+                reg = <0x11>;
+                #power-domain-cells = <1>;
+            };
+        };
+    };
+
  ...
