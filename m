Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20930444639
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 17:47:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232956AbhKCQuV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 12:50:21 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.109.102]:59618 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229894AbhKCQuT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 12:50:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1635958062;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vklV71tQz+gYe/2660xpWIGZqlkS7j/kAPZRX/cQH18=;
        b=PCHPa/NXrcIJSzRuX2FH7LkkdbwSZk5vPudYnnPiiU6iI3OgP9od6VmiBpLrneLHM/WDQP
        3XAJVQHzVATThtIl+JDVowDvsWjBZToBoJrtNpwgccCM807/tWPaDrbFvAdoQNOxdrsiaf
        2TgXUBZNY7/p6enPu4r93QCu7t6O388=
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2113.outbound.protection.outlook.com [104.47.17.113])
 (Using TLS) by relay.mimecast.com with ESMTP id
 de-mta-39-XQA62fuuObmEMqIDJrAlRw-1; Wed, 03 Nov 2021 17:47:41 +0100
X-MC-Unique: XQA62fuuObmEMqIDJrAlRw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FtSnhoszhOpPFursL+kFDY2K0SrUD8C3o/wS6hXP6KLRbKJCk69FFKF/KyOcBt//Acy2MkRkR6aq56t4nujgNzKTgdBrwCrx5on8nVgMd8C3yldLn8+AzwixIbwmdypn6zXURs4vQUhihbn+hLXhX44nfOEgGuhK5/1nshKbf7DvvgFTCwb8hfqUvAESt9ddnpD4FbGAWVctJfz5yc3zJwacwyT4BCryb9ve+TZyjNvbdHk4yPdJGMKF3HZesKZtBqcqnDAOkT0sHBhVqnJ/FzxShIY1eSJLrLY64Qf5t8qbZB32xq11/MX3A9jw1UocCRbTk43IfjhNx+ab6QT23A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vklV71tQz+gYe/2660xpWIGZqlkS7j/kAPZRX/cQH18=;
 b=GWgAkX1rZjB/TJB03g0y87pz2BRJzJtmGLDtBpHETdLeuoVGkEzRkSPadePChfKNp3OAnGL3p8hm0kM0VZKc0DTm4/e+INQ8UkX0J4LUsys5AHBVnqLJjfnOrHGqijo2Jj7Xw5otAKM6sXtx43vrU/xs5PFvDaA4uUkXNRZHar3xCJM/kNcD2N+bd4UgSVDSw5gBE5Ec8Rm5LlsisZabjM7nIZxeRrWG3xDqhA3i6C/dmui4sOmuYJ3k4Z6Pn1ltz904PJEuObsm+jGAms/PGIgUlM9Tq0E+D1yLE4K3tbVo0CzDbMYMmHCpNzLh7Vc8SFCh97/FEVNxcODRxFILVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AM6PR04MB5366.eurprd04.prod.outlook.com (2603:10a6:20b:9d::19)
 by AS8PR04MB8119.eurprd04.prod.outlook.com (2603:10a6:20b:3f9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15; Wed, 3 Nov
 2021 16:47:39 +0000
Received: from AM6PR04MB5366.eurprd04.prod.outlook.com
 ([fe80::b81e:116f:90fa:1b9c]) by AM6PR04MB5366.eurprd04.prod.outlook.com
 ([fe80::b81e:116f:90fa:1b9c%3]) with mapi id 15.20.4669.011; Wed, 3 Nov 2021
 16:47:39 +0000
Message-ID: <704e71ce-e6c6-6492-8f20-47e4fad8cc39@suse.com>
Date:   Wed, 3 Nov 2021 17:47:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Content-Language: en-US
To:     Charles Mirabile <cmirabil@redhat.com>,
        linux-kernel@vger.kernel.org
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Serge Schneider <serge@raspberrypi.org>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        linux-rpi-kernel@lists.infradead.org, fedora-rpi@googlegroups.com,
        Mwesigwa Guma <mguma@redhat.com>,
        Joel Savitz <jsavitz@redhat.com>
References: <20211029215516.801593-1-cmirabil@redhat.com>
 <20211029215516.801593-4-cmirabil@redhat.com>
From:   Matthias Brugger <mbrugger@suse.com>
Subject: Re: [PATCH 3/5] drivers/auxdisplay: senshat: Raspberry Pi Sense HAT
 display driver
In-Reply-To: <20211029215516.801593-4-cmirabil@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM7PR03CA0009.eurprd03.prod.outlook.com
 (2603:10a6:20b:130::19) To AM6PR04MB5366.eurprd04.prod.outlook.com
 (2603:10a6:20b:9d::19)
MIME-Version: 1.0
Received: from [192.168.0.18] (188.86.219.160) by AM7PR03CA0009.eurprd03.prod.outlook.com (2603:10a6:20b:130::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10 via Frontend Transport; Wed, 3 Nov 2021 16:47:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 74b98c14-aa96-463e-919c-08d99ee9a5ce
X-MS-TrafficTypeDiagnostic: AS8PR04MB8119:
X-Microsoft-Antispam-PRVS: <AS8PR04MB81196E3A54012A92DCD15FF4BA8C9@AS8PR04MB8119.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1824;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UKIgp1r/G6AaTMiXYtot8pgAG3+4qneVtkr9CwuCvvLSNzhV3YY076c9JWmCeOis5I0Si+6WQ3Z6LsOqgcUodS3UOsX8XpAqx4AUsq34l8gzt4umP8zVe0aQNq29Vurb5mRtwTm+Jssxn0SJJpZii50UVYuuOejqQfHQ7qFlXvvb6HrEErsQ91qtC8x4Kc+xXb513GHxe+9UBaSnzXuf2bWR6Bv2omWgk/+gQUdbxGdt40nW36SdbVWdJLpqdLHDE5f5VSR+ThY+NKXpHnZuJ2dOZ+O7V/ki3RR/i0D3n2m+BU93Ky/DvWHgdZNZkHZT7SzHYT2bnGvQeLuSjTNhgiLuTFitJ3ezfdpL9coLblnx0e0OIKYdDu/IWHNvip3ewpVntbToGkoXAgbaRq0WPGP9Hmciq9xdlgXCy5PSKYqJ2fLdlKZBS4QpYT7QGNu8enjMTVlAdRril+Dpx3P3k9H9E2qHBt+VdZGA4CDhyXkyzcS0kgYZimSfeiugGvAcxNJ+B4S8rvMrJCSLMUcCqFf6Dei9Chl1rCefI/ZOeqCGJGLU1XS8slzvE6cxFNFMcnq9dhEzuHg72rj8u58ypmfpy6PHsXnpvnltqAdDLuLi/vy5GMwY8w3xt9wm0Tg1j0CfD2csRpwGijZaT8+KikDNzsOQ3VMzLanTclnoyfUTugHkRTJb9E+Gj5VV4uR8P5zuwpggfSYOghAwXxsyhwCQNm2axkzIFAN7lkwsucs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(316002)(186003)(31696002)(66556008)(86362001)(83380400001)(54906003)(53546011)(16576012)(36756003)(55236004)(2906002)(7416002)(66476007)(26005)(38100700002)(8676002)(66946007)(5660300002)(31686004)(8936002)(6486002)(2616005)(4326008)(956004)(508600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M25tOW1nSnlHSk5HSVVIR1ltN3pwd25yUEpsajduMWR4TnVNdnJWRkx3L1ZC?=
 =?utf-8?B?UU81d0RYaTdoM1FLbTNaRzFkOExSbk8wZmYva1FKVFBVTUdnenpaeW5Obk0z?=
 =?utf-8?B?WDhzRVpFdVd1ZWR0akkwOU1TV01YalVYYzdaL0ZEZHpicHpWM1M3eVlaMUR6?=
 =?utf-8?B?b2VhalJHNWk0RW0zYjlJQU5qL1kyWW9INWRPKzNsWVNEam1vb0FIU3lpTGk0?=
 =?utf-8?B?UEV1TVpKMm9IcWYrbS9WYnpJaGtQa1I5ajlMbi9pVlA2TlZLUjd6RVF5Y3lE?=
 =?utf-8?B?RVJUblQ4V0lBajlLNFkyckRlR042VVNmUU1zamJ2TjVOc1YraHU0ajlULy9H?=
 =?utf-8?B?Qlo4V0lXMUtOT0QxbVljcDUzWGd6eDhFYkNXbFFFK3htQ1Rlb25YRnFrVndQ?=
 =?utf-8?B?NHgyUFBiZWhFTWFuVURMeWhWT1YzK1I4ZVpjb09UdllKUjl2WXpRTmYyaFp6?=
 =?utf-8?B?M0x2dXdqK2p4aGV5YVdsWXpYQ3BqQ2x0NjZ1elhKdkp3WmFuQmtiR0E3N0FV?=
 =?utf-8?B?SjRRbTEydkc2bFRmYWlhQmZ6ZnFHVnU3NlBUZlhLcUxqSGZNMFpwNDcvMUZV?=
 =?utf-8?B?WnVmK2o1Mis3UlNXc1hjRDNwQjBNUFBBV1FieFlMS3E1blFweHduVnVvQUkw?=
 =?utf-8?B?NWZiRytqVDE5aTZrVmxveUFGdHphSmJjL3lLemkvd0wxbURTSnlUM3oxQ2FH?=
 =?utf-8?B?UVlhaHp6eFhlRjV4Y0xxQnlFWE9sbkFpMkNpZ3ZxcHBHWVZzd2haUkZkaXhY?=
 =?utf-8?B?N2RIaTFIY0VkKzMrL1NLOTdaTUxQV09IM2pMckw5VGZrRllOMDkyOWVrZFJ2?=
 =?utf-8?B?SGhwczIwRURkRk1ESlpPWTJManZtcTl1OEcwKzNkNlJrTlhreGZMcmkxcHBx?=
 =?utf-8?B?UFJRWFJxL0hOMHdSRUxGTUJZNUJDTzhvUlFwSytzaVNnYmJRa1REVHZ4b0pH?=
 =?utf-8?B?RFBtdGJGM2JSSGxSV09UNklSV2hVWUk5NldBYU9xUUZRZFFmeXp3WmVJYTl2?=
 =?utf-8?B?eDF0bndYelBxTWJlVW9LemJpZUJKRXJJOFR1cjZUYVB4T2FlQ1lFbmphMS9E?=
 =?utf-8?B?SWFlUXlaamFQenFJQXlCSUtnY1pxOXY1SmhvSTR5RmMzN3BobDgrb2FWVHRD?=
 =?utf-8?B?WnR5VXgvQjV2Y1BnRWMvYU5FUnUwQ3lzWmhrNnJKQlN1eXlhckoxZXBIdGFH?=
 =?utf-8?B?M2hncWFqdW1pWk4xL1hTbi9GTGpXcjNtV1N1MDRoYmpraFBSdUpkYlduM1VM?=
 =?utf-8?B?NCt3ZVdEVDNZYkE3KzBqdFlzOHVBck5GaVdPcEFuVlEyTThXNldOUkJvZkZY?=
 =?utf-8?B?ZHlWWkIzMHFRWmRLeTFhdjBXdUlkVVJtYW9FMGtwZGlRRjZxSGJCT3FlVjdu?=
 =?utf-8?B?UFBYZzFVRzE4UUFEL1Z6bGFHQllXaDZ2ZE1DdG9Gbnhybm90ZGhBUkZUUXdH?=
 =?utf-8?B?UUY0TDZnRFhzQWFOYnNDMEdnTDVnbkJKZytBWFozT0JlQU1OQXBtUWFodVRP?=
 =?utf-8?B?REZ0Z0d6NVFKcThXZ2Frd2d5VzJESjQ5VUo1QUJwU0duMkN4SEQybFVqb1dB?=
 =?utf-8?B?L0F1Tk01dFkvQzNCZDJna0RxLzZDS3IxL2VDMXZNcEcvZDZHbDZhRUNiYjNO?=
 =?utf-8?B?dENXdHI5V25pRWdUTlBJVDU0R05QL3FLV3R3ZWdORXludnBnT1Q5M2MvaHZt?=
 =?utf-8?B?Q0dyTmFaZkJvOVlrY01zTFFnOEdRRklCTEVaTlRFMXlXdDFFdkdKeWFsekZ4?=
 =?utf-8?B?aFdUaitqUVI1UjFYUWRTR1oxVGtYb0E2YjBPTktGOG5UaDczYkVWbm8yRVl1?=
 =?utf-8?B?WCthR2FWMkFoN2IwbHllL0RJUG95bGM4MWRMcjdpNkx6OTZLWE5SeEU1N2pF?=
 =?utf-8?B?SkxtV1dOK3pOV3E4bUp3K2NZYWtqbDI3ZDZMdXhYQ051Y1puQkRCM1AyQTEr?=
 =?utf-8?B?WHhLWlBUOWRnR21SbTh4d0hpYWZmajZxcXFVSWpUMXhRWmZxSGtVZWcwS0Z0?=
 =?utf-8?B?NG1pWHNsUFJUNnMvTFI1UHFCdWlPZUFMa2NBOFJPcFRKS0FCOC80eFIwOUFE?=
 =?utf-8?B?ZFJmc3BBRDY4V1pQVnhwNEJPMzVOMUVZYjB5N2tkbUErR3EyeTcxUTRyY3Fq?=
 =?utf-8?B?a0o5WCtmSnZ5ZWJEMUtzOTE5Y3NNUFE4SnFRVzZpNWI4cGVldTFmcVNPUmpB?=
 =?utf-8?Q?oavjLQjmhVNbljyRgpp++NI=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74b98c14-aa96-463e-919c-08d99ee9a5ce
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2021 16:47:39.6642
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EEkYWOdAU17rADuOkKUvrYnUs4E2350FVh75o/aAzaGmhJBK47uZQq0kM4MMbEnHEZ9iBlaLjjRJrj34QeuSZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8119
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 29/10/2021 23:55, Charles Mirabile wrote:
> This patch implements control of the 8x8 RGB LED matrix display.
> 
> Signed-off-by: Charles Mirabile <cmirabil@redhat.com>
> Signed-off-by: Mwesigwa Guma <mguma@redhat.com>
> Signed-off-by: Joel Savitz <jsavitz@redhat.com>
> ---
>   drivers/auxdisplay/Kconfig            |   7 +
>   drivers/auxdisplay/Makefile           |   1 +
>   drivers/auxdisplay/sensehat-display.c | 258 ++++++++++++++++++++++++++
>   3 files changed, 266 insertions(+)
>   create mode 100644 drivers/auxdisplay/sensehat-display.c
> 
[....]
> diff --git a/drivers/auxdisplay/sensehat-display.c b/drivers/auxdisplay/sensehat-display.c
> new file mode 100644
> index 000000000000..5980ad23fd4f
> --- /dev/null
> +++ b/drivers/auxdisplay/sensehat-display.c
[...]
> +
> +static ssize_t
> +sensehat_display_write(struct file *filp, const char __user *buf, size_t count, loff_t *f_pos)
> +{
> +	struct sensehat *sensehat = container_of(filp->private_data, struct sensehat, display.mdev);
> +	struct sensehat_display *sensehat_display = &sensehat->display;
> +	u8 temp[VMEM_SIZE];
> +
> +	if (*f_pos >= VMEM_SIZE)
> +		return -EFBIG;
> +	if (*f_pos + count > VMEM_SIZE)
> +		count = VMEM_SIZE - *f_pos;
> +	if (copy_from_user(temp, buf, count))
> +		return -EFAULT;
> +	if (mutex_lock_interruptible(&sensehat_display->rw_mtx))
> +		return -ERESTARTSYS;
> +	memcpy(sensehat_display->vmem + *f_pos, temp, count);

So we copy from buf into temp, from temp into vmem and then we 'transform' vmem 
into the representation of pixel_data.

As you are implementing the user-space interface, couldn't we just change the 
pixel representation there and get rid of the transformation?

> +	sensehat_update_display(sensehat);
> +	*f_pos += count;
> +	mutex_unlock(&sensehat_display->rw_mtx);
> +	return count;
> +}
> +
> +static long sensehat_display_ioctl(struct file *filp, unsigned int cmd,
> +			     unsigned long arg)
> +{
> +	struct sensehat *sensehat = container_of(filp->private_data, struct sensehat, display.mdev);
> +	struct sensehat_display *sensehat_display = &sensehat->display;
> +	void __user *user_ptr = (void __user *)arg;
> +	u8 temp[GAMMA_SIZE];
> +	int ret;
> +
> +	if (mutex_lock_interruptible(&sensehat_display->rw_mtx))
> +		return -ERESTARTSYS;
> +	switch (cmd) {
> +	case SENSEDISP_IOGET_GAMMA:
> +		if (copy_to_user(user_ptr, sensehat_display->gamma, GAMMA_SIZE)) {
> +			ret = -EFAULT;
> +			goto out_unlock;
> +		}
> +		ret = 0;
> +		goto out_unlock;
> +	case SENSEDISP_IOSET_GAMMA:
> +		if (copy_from_user(temp, user_ptr, GAMMA_SIZE)) {
> +			ret = -EFAULT;
> +			goto out_unlock;
> +		}
> +		ret = 0;
> +		goto out_update;

That's just a 'break;' correct?

Regards,
Matthias

