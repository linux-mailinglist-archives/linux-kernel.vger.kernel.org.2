Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28322340087
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 08:59:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbhCRH7S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 03:59:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:53912 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229554AbhCRH7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 03:59:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616054341;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Nn/5yebJvV+hf+x2xhoc0zHDxmraj53kP1qAate3bo0=;
        b=Nsq+Jb+DJlO6rgZElIStF1kys/jAYo9jQVCLxbX997nV1jTIZzj0TSTAFrEPY8r04B9Yr1
        NJl0WOIrJSHcc3dAJcQUM5pqsfVxXGsKKlcSYC90kTqrZ6v0eN+B9RGomrqWmKFrJfMpRV
        X6jpWSDP8/+nEbHMOgUEFiUuXAEvsuk=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-440-aru-LSBBMO2894VfwE-fCw-1; Thu, 18 Mar 2021 03:58:57 -0400
X-MC-Unique: aru-LSBBMO2894VfwE-fCw-1
Received: by mail-ej1-f70.google.com with SMTP id h14so16356340ejg.7
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 00:58:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=Nn/5yebJvV+hf+x2xhoc0zHDxmraj53kP1qAate3bo0=;
        b=hrAt2UrYfBf5VXSynzk+T1RFAE23E0IFOnJdwszJku38KnCBTHq6dT0Whxu9/VbpSj
         7Lc9c2E7feMfbLbsu3Ajfqzk1du5W4sZhtxef/0XBSP16woxfcfdbfZZKW0OHmi5Fm9E
         W0cN8XDKaY5NgFQB4ygNAVZdHEEuXWgVTgEjnptZsZre3YM77Z6Pd3xIOdmSfNW86Yhw
         67OZQUcBYyFYVG4QvDtHVm8IUjYqc7zF3QqOqSeL8GtD6Pd5BKN+0CY/UI/wl0rmggoo
         hduqUVJG80lPRT/CSDlCHTxH2ggSMnhwmGbkh2pIkIN7nQpPGsXdf1wtOt2NpS8Q1keo
         3Umg==
X-Gm-Message-State: AOAM530mT0fetEslwmBF49RxPv4cpfTbcLKglnewX3nsc53cTvMLPjN6
        pvzK4xodAZTNntkEaWl4fEyB872SN58l8aO6+G6Hvwj67YMcI1FLVQyGIH9uojNx77p6iRBkyrd
        cJWzx5xZYdoCYDK4fqlnJzFPXW+1ahZFzvKGf3mzpjxNfJN2cGoRmzo3AR9tEGY9S1EUBdLN53I
        SL
X-Received: by 2002:a05:6402:4309:: with SMTP id m9mr2129828edc.25.1616054336775;
        Thu, 18 Mar 2021 00:58:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwtTLWscZ5MkOswUL8Zw2SFSzMaZ4yu0V5jQXI+Yz6Xq29LK2u5lCyD7PnFFyifhvaTRoW0qQ==
X-Received: by 2002:a05:6402:4309:: with SMTP id m9mr2129809edc.25.1616054336551;
        Thu, 18 Mar 2021 00:58:56 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id e16sm1155895ejc.63.2021.03.18.00.58.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 00:58:56 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org
Cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 2/2] genirq/matrix: WARN_ON_ONCE() when
 cm->allocated/m->total_allocated go negative
In-Reply-To: <87eegdy0qh.fsf@nanos.tec.linutronix.de>
References: <20210219113101.967508-1-vkuznets@redhat.com>
 <20210219113101.967508-3-vkuznets@redhat.com>
 <87eegdy0qh.fsf@nanos.tec.linutronix.de>
Date:   Thu, 18 Mar 2021 08:58:55 +0100
Message-ID: <87eegc7v0g.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Gleixner <tglx@linutronix.de> writes:

> On Fri, Feb 19 2021 at 12:31, Vitaly Kuznetsov wrote:
>
>> When irq_matrix_assign()/irq_matrix_free() calls get unsynced, weird
>> effects are possible, e.g. when cm->allocated goes negative CPU hotplug
>> may get blocked. Add WARN_ON_ONCE() to simplify detecting such situations.
>>
>> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>> ---
>>  kernel/irq/matrix.c | 11 +++++++++--
>>  1 file changed, 9 insertions(+), 2 deletions(-)
>>
>> diff --git a/kernel/irq/matrix.c b/kernel/irq/matrix.c
>> index 651a4ad6d711..2438a4f9d726 100644
>> --- a/kernel/irq/matrix.c
>> +++ b/kernel/irq/matrix.c
>> @@ -189,7 +189,9 @@ void irq_matrix_assign_system(struct irq_matrix *m, unsigned int bit,
>>  	set_bit(bit, m->system_map);
>>  	if (replace) {
>>  		BUG_ON(!test_and_clear_bit(bit, cm->alloc_map));
>> +		WARN_ON_ONCE(!cm->allocated);
>>  		cm->allocated--;
>> +		WARN_ON_ONCE(!m->total_allocated);
>
> This hunk is not really useful. It already dies when the bit is not set
> in the alloc map.

This was to check for the hypothetical issue when then number of bits
set get out of sync with 'total_allocated' counter -- which is likely
impossible today but could maybe be useful as a future proof. In case
this seems to be too much I'm not against dropping it.

>
>>  		m->total_allocated--;
>>  	}
>>  	if (bit >= m->alloc_start && bit < m->alloc_end)
>> @@ -424,12 +426,17 @@ void irq_matrix_free(struct irq_matrix *m, unsigned int cpu,
>>  		return;
>>  
>>  	clear_bit(bit, cm->alloc_map);
>> +	WARN_ON_ONCE(!cm->allocated);
>>  	cm->allocated--;
>
> WARN and then decrement is not necessarily any better than just
> decrementing unconditionally. It's just more noisy.
>
> Why would you let the counter wrap into negative space if you already
> know it's 0?
>
> There is a way more useful way to handle this. In such a case the bit is
> NOT set in the alloc map. So:
>
>     if (!WARN_ON_ONCE(test_and_clear_bit(bit, cm->alloc_map)))
>     	   return;
>
> would have caught the problem at hand nicely and let the machine survive
> while just throwing warns and continuing is broken to begin with.

Thanks, I like the idea. I didn't do that probably because the problem
which triggered me to write these patches wasn't fatal, it was just
causing CPU0 offlining to fail.

>
> Thanks,
>
>         tglx
>

-- 
Vitaly

