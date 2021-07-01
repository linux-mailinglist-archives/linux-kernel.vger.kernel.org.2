Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B487B3B8F06
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 10:43:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235661AbhGAIpn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 04:45:43 -0400
Received: from mail-am6eur05on2124.outbound.protection.outlook.com ([40.107.22.124]:61025
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235689AbhGAIpl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 04:45:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=md+QHqJ62yFkYAh6y0Ba9lQUCnBEUd4WWYSfpV5aS+MVOiqScaDuSritd2bVSSUsqGm0WYlL8S/L+rCoOMfb5xaujaWXep8mn92EFC7b9u/RRZLdAVZ+TZfDmJng7fSr/ocSGOFip1rzsQCVq1XMzeD5/FFk0G2oCHRb+YcjM90Jg5E+8N9pkdCUYi/pF/Dj/pJv/wGA2heiG/ynBhqu9zUkN7Nz3rtaxSpiy0LHOwXDCrljH/qMcVcxXeW/hmLIi2mN1BSHBXNmWnWlSIB3mfq9Wcovqg/9gZ2FpcsqdXWZXIjb151VoXAceS/TURj0aYbTjswz0cCBOruidIVyLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0o5rhDBYoYAiRZrYIYUT3e/0SUzE49ugzPDrZK/35C8=;
 b=WF+pS+w3CfKqF6k6uxgKsPAwo9h/CSu6R6niyHrW77qwNXcIz1VJ44cusptWo4prFu3ve/FsZ4ZBapTNkXEja5VU+DKFtdGuC8prG6OCI16ukuoRYdLGFRLTxGA7oirJl+4YJ/bSkeOHyfSKNedrRNJ2indwj9a6Y0syUjJwNc376hl6w1zT0Z9Fr2F23nMZMVWsCfLIPQVi0aFV3KcLK4YqUS2CMkVcG7+gwP+O4tQEjT342tAjrpAY+5RDoDCgW2hgoFAEEb99nqr4stYLX3A0JuyB6A2uK+V6zWtXh3f+bY/TLCEjVt1EO8wL/LcTfLQn97B1OhSxWnQaE5b5ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=opensynergy.com; dmarc=pass action=none
 header.from=opensynergy.com; dkim=pass header.d=opensynergy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=opensynergy.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0o5rhDBYoYAiRZrYIYUT3e/0SUzE49ugzPDrZK/35C8=;
 b=ReeCp2CHd5FUUDamVOXlA9H4zr1FM9Sewroe3STJB8Zsf2/SYtTMKuPN3dCefeZ1ArEucijfwTG5LwXzkGZUgQ9D7vwhabOXTiobLF0FGtdZCC/IMY76v2KtEjOy46ZldAoGH8VCeFA287D/yX53nZ3LdNAIzzPqo871tsptOoo=
Authentication-Results: opensynergy.com; dkim=none (message not signed)
 header.d=none;opensynergy.com; dmarc=none action=none
 header.from=opensynergy.com;
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
        Andriy.Tryshnivskyy@opensynergy.com
References: <20210611165937.701-1-cristian.marussi@arm.com>
 <20210611165937.701-15-cristian.marussi@arm.com>
From:   Peter Hilber <peter.hilber@opensynergy.com>
Subject: Re: [PATCH v4 14/16] firmware: arm_scmi: Add virtio transport
Message-ID: <ccc64935-08fa-d1a3-fc21-227c9d05fe24@opensynergy.com>
Date:   Thu, 1 Jul 2021 10:43:07 +0200
In-Reply-To: <20210611165937.701-15-cristian.marussi@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM6PR01CA0043.eurprd01.prod.exchangelabs.com
 (2603:10a6:20b:e0::20) To AM9PR04MB8084.eurprd04.prod.outlook.com
 (2603:10a6:20b:3ec::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5d86f8da-e253-47b6-581b-08d93c6c4140
X-MS-TrafficTypeDiagnostic: AM0PR04MB6609:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR04MB660999C49F16A9CC7FA943F78C009@AM0PR04MB6609.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Iu7RBLvzSElpbdWaJJkEvgeA7+G+EyGEsVTXbFVIpdyMZgpTLD5AOouIg8UvjNW/WRZSkyeciqiyvCCj2p1qJjB36MpNu91ptehno6yfBi1FDXyOHRvdBUrtZ5Q/SIW1oKAnEe4QedeuM8FdnQkb1dGB0JFRbqLzh73Z2IMFAmXw3VkKTjfizrlRRL9oXb0aV9dKAKUtZH9/4VBURT5bGOBd7yXvKtIZRBHbNjpv4X6iqtyowugaoDU5iYM5AonidzPHePcXf63wJuTs7KEYvfPSZO01GOoy6io93+s9V09wrvEHY4km8j2X1JaNP4/MIezQ74bW0FsShF7ha3jeEyAYa49HxIc56tT5QtZvzTNMPvtNyXsVj9J24e6GNjqes3/AgNyZ0mMEaDtUIBSCBi3MeU2pniFlHkoYrwBS6/dQQu036ErN6UpqXx8F5duaA9a29axuS3MtRxWtEo/6y5rJCZlmeHdLZ5Hn0juuPqun46IUXmC/iBgHbYCqNIgqbTVheYSD/quVOWM9n4YHBcrMyyZEB0qNR05s3OnZdZaXz9pfH0PSZe3co34xBVhTEA0wmkflm+jNEmkkIGHUIgSGY6/6mD19qjCxZMnEwyw7QSZM7Ms8yJ7R0y3Kr0NIjvvs9pFxl0w30BrF1FN53A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8084.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(346002)(366004)(39830400003)(376002)(396003)(107886003)(5660300002)(53546011)(4326008)(31696002)(36756003)(86362001)(316002)(42186006)(8676002)(478600001)(8936002)(7416002)(66476007)(2616005)(44832011)(31686004)(83380400001)(38100700002)(186003)(2906002)(66556008)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QlNDSWU5QmhrQTNGYld1cUV2VFlpWWloUFBUR1NoQTNnc2I2enNqNFJsSzN1?=
 =?utf-8?B?dm40WGlST3NCaVNHNVN0SkxJTW43WS93Vk9MYTBHaXZ0OFN3NmtTRFMzSmZH?=
 =?utf-8?B?R3lCc1VXdkpoZHlDNXQwWklSUHpLdVNaWW5jbDRtcVBrd2ZRM21lR2JHVFND?=
 =?utf-8?B?V25sR0gwT3VrZWxuMWY0bXNiWFVreDZlT1JmYTNJdlZZcVlpSlBTWm9IUHlL?=
 =?utf-8?B?K2htdEJuRFV4M3NYWU52aWpNMDVrN2RNSzJ2bmtZckNKcWxvQXgvbXY0bW5I?=
 =?utf-8?B?NURrK0FJeVBRK1JWbFd0Y2FFZGc4eUtPdUZZWTBuQW1RYStKa3JMb0l3anpq?=
 =?utf-8?B?bUxVTVdiYXpOeUhQK2E3YkVtdFJLNGI2cndqQzVQbTZxSlIvdUJYaDJ2UkNG?=
 =?utf-8?B?QUtQSy9iaGc5aVlRUDYwd2ZsaWYyWEdrdVp3SHVtU1hML2tqditnVEZiVFJF?=
 =?utf-8?B?aFAwT1VORjdWRUpDR2tneHJNSWc4SW14T1M4OVNOV1FOV3RXYjhnZHdMU2h5?=
 =?utf-8?B?bWU4NEhrSmNOcXQ4ZWpBckFaTXhPRHNtbjlubFgvNytyMDBWc2pvZkdLcnNH?=
 =?utf-8?B?bDVsZUZwdS82MStrTkp3ZXZwL1lQTFZlc0ZrSW0xNCtGWFViSS9teFdzc3Vu?=
 =?utf-8?B?T3dUSU02NGVnWmlnaUdYaUJJOWNUeW9WUEUzeWl4d0xFaGJtTFlqOFBwVGlt?=
 =?utf-8?B?UEQ5MW16eGs2b0F6aFdHREM1bXhYMitSSlM4RTBMeUxwVmxoRC9QL1M4dEVU?=
 =?utf-8?B?YjdhZ2dvb1hwRUpHanVIT0gwZ1FVRkJ2WEhRamZPZWdhMnhLTGJYSlFsYno2?=
 =?utf-8?B?UG9GR296Q1hDdXcyRTRLNHJnSHlJY2phamRGSlNDemFVWlRBcnRueUw0d0FR?=
 =?utf-8?B?OWU4dUNjakdWUU5UNE16bHZ3ZEdkeTVIdndvMU1KUUplQ0R0eFpxQnpGcWFw?=
 =?utf-8?B?dFo2djJCalh3WEp1L1Awc1RCOFhJVUZUeTRYUVBkS1ZjbE5VU1BROTg2ZHFn?=
 =?utf-8?B?U3RHZ09EaXZxMDkwcVRwampLc0U2Q3Faa3FUQlQrRlRtSEMvWDhsQk5KRk9S?=
 =?utf-8?B?amJuQzN4akd4TDFFbGYvT1doR0pEamRKNmxLMGNVRElXWXBhdVZUaFpoTzRo?=
 =?utf-8?B?Qm9LVHRVZC9SRm5TZFdFMzZ2WnN5N0xPcFNtMmVmdjZMeFQ5d29GbEdyLzRV?=
 =?utf-8?B?Y2pNSXVqWVREdXcrK2ZEVU9SRG1ZV1Buem0rdFFMNXNaUDNOT0FZYUpjYzNm?=
 =?utf-8?B?anNZZmpGR3pDaEVlY0EreHh5ODVzMmJwL0pMU01yOFRNNTJnbkVmYW5xWkFx?=
 =?utf-8?B?K1pna1AzUWJOQ2ZkUUs0U0pTT3FWeHFUYmxZRHBaR1dwZEs4R0crUkNONXdE?=
 =?utf-8?B?eStxQStIVjBxQXF4RWhyMzZvU1pkSzRxNXVnWDliNjVrMGkxbXFtWG44dnE5?=
 =?utf-8?B?TkdYcTJrb3UrRkRrS0NZV2o4TG9OTFRUMmtxZXBYbUhzWTU0dnQxVjhDdVAy?=
 =?utf-8?B?QlM5SGhkK3N1dkE4cWdBZldnelJvMGRDdEcrYVJqREdKTWVBWnFrVGxxYjRl?=
 =?utf-8?B?QkE3cUZuVHBqWldpSUgrell4V3hVKzU0bHYvNGprRGg4UXBwcEdJYUFhOHUy?=
 =?utf-8?B?TXNHYmE1Y3F6T1EyNUFSMWZPb0w5UXpwUkZGaUZia1l1b1ppZDBmUHY3YVpD?=
 =?utf-8?B?WTE0SGsyRW9RL0xsMlVNbk5NYW45QmFuTVBuR2xjY3NXVVhRaUZXSEthQVBw?=
 =?utf-8?B?elJBVlM3Z0JQaWswTjVqTHpRdUpLSldyclZWN1dlaVJvWDZtdHNOSFNoNzZn?=
 =?utf-8?B?WkxnRGhETGNEaXlWd3dXSkdYNjc4UlV1Y1B3VjFKaXoxbWdKajUzVTBvZjRS?=
 =?utf-8?Q?8/rMVzw7zl1gV?=
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d86f8da-e253-47b6-581b-08d93c6c4140
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8084.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2021 08:43:10.1523
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fp7lT83HDRFNiN3WCP9rOWVOfz38tFt3CcbFWdylgJenDeMjNe9N3+grRVopA0j4lSuQglplDx7cHwXzbdDN1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6609
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.06.21 18:59, Cristian Marussi wrote:

<snip>

> +static struct virtio_driver virtio_scmi_driver = {
> +	.driver.name = "scmi-virtio",
> +	.driver.owner = THIS_MODULE,
> +	.feature_table = features,
> +	.feature_table_size = ARRAY_SIZE(features),
> +	.id_table = id_table,
> +	.probe = scmi_vio_probe,
> +	.remove = scmi_vio_remove,
> +};
> +

It might be good to also check for the VIRTIO_F_VERSION_1 feature bit in 
the optional .validate op (not yet implemented above), as some other 
devices do (quoting virtio-snd in the following):

> /**
>  * virtsnd_validate() - Validate if the device can be started.
>  * @vdev: VirtIO parent device.
>  *
>  * Context: Any context.
>  * Return: 0 on success, -EINVAL on failure.
>  */
> static int virtsnd_validate(struct virtio_device *vdev)
> {

<snip>

> 
> 	if (!virtio_has_feature(vdev, VIRTIO_F_VERSION_1)) {
> 		dev_err(&vdev->dev,
> 			"device does not comply with spec version 1.x\n");
> 		return -EINVAL;
> 	}
> 

<snip>

> 
> static struct virtio_driver virtsnd_driver = {
> 	.driver.name = KBUILD_MODNAME,
> 	.driver.owner = THIS_MODULE,
> 	.id_table = id_table,
> 	.validate = virtsnd_validate,

(end of virtio-snd quote)
