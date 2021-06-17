Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F210E3ABAD6
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 19:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232645AbhFQRuW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 13:50:22 -0400
Received: from foss.arm.com ([217.140.110.172]:57196 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231249AbhFQRuV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 13:50:21 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 771F513D5;
        Thu, 17 Jun 2021 10:48:13 -0700 (PDT)
Received: from [10.57.9.136] (unknown [10.57.9.136])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A1CF13F694;
        Thu, 17 Jun 2021 10:48:12 -0700 (PDT)
Subject: Re: [PATCH] perf/arm-cmn: Fix invalid pointer when access dtc object
 sharing the same IRQ number
To:     Tuan Phan <tuanphan@os.amperecomputing.com>
Cc:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1623946129-3290-1-git-send-email-tuanphan@os.amperecomputing.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <b3f1126d-2906-cf36-4d3d-eb86552fa50b@arm.com>
Date:   Thu, 17 Jun 2021 18:48:06 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <1623946129-3290-1-git-send-email-tuanphan@os.amperecomputing.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-06-17 17:08, Tuan Phan wrote:
> When multiple dtcs share the same IRQ number, the irq_friend which
> used to refer to dtc object gets calculated incorrect which leads
> to invalid pointer.

Oops, indeed this is supposed to be a forward offset *from* the previous 
match *to* the current dtc. It's almost as if I never managed to test 
it... :)

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Fixes: 0ba64770a2f2 ("perf: Add Arm CMN-600 PMU driver")
> 
> Signed-off-by: Tuan Phan <tuanphan@os.amperecomputing.com>
> ---
>   drivers/perf/arm-cmn.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
> index 56a5c35..49016f2 100644
> --- a/drivers/perf/arm-cmn.c
> +++ b/drivers/perf/arm-cmn.c
> @@ -1212,7 +1212,7 @@ static int arm_cmn_init_irqs(struct arm_cmn *cmn)
>   		irq = cmn->dtc[i].irq;
>   		for (j = i; j--; ) {
>   			if (cmn->dtc[j].irq == irq) {
> -				cmn->dtc[j].irq_friend = j - i;
> +				cmn->dtc[j].irq_friend = i - j;
>   				goto next;
>   			}
>   		}
> 
