Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F36430D814
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 12:04:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234017AbhBCLCY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 06:02:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56404 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233974AbhBCLCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 06:02:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612350034;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hQg0sdLNM2xYsUdmnJn7mPJoZ7uFdvAkPAibxzjlOr4=;
        b=d9JV+Z0F4T6SNmMpBrkCpZvthTf4IodjcLIcBVnL0CDwrytg9qGlXgu6PV+JUJjESCZBiK
        daT3QWjR/C/LMz1aQpAKLY7/gN5CoavUIoSgUeRycibJhhcGg51XaEOYpQ2cynLICcHRHJ
        oTEWL5CIRp+PGWtKRG7tMj6IID/Gm94=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-325-cENQM9jZNvezoNRWjBsL_Q-1; Wed, 03 Feb 2021 06:00:32 -0500
X-MC-Unique: cENQM9jZNvezoNRWjBsL_Q-1
Received: by mail-ed1-f69.google.com with SMTP id t9so11228488edd.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 03:00:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hQg0sdLNM2xYsUdmnJn7mPJoZ7uFdvAkPAibxzjlOr4=;
        b=gkb2zb9drZHDvLvSmNCj/Cj8gN4O8m7eSljnDxuQPYIJoZle3urmdHMv1Z2ByPtTZV
         A9yJ+8mFcDWmaS37mQypYz9CZ8ajhYvXEgbz3Y98cwJIb9y5hEgL+XqieglHGk35j4k+
         J4UL6Y9vYsP9omr/WF+f4R0AlkKzL3R/wXhraH2Z53WEQv7SGlJQPrP5HFdolt6CYOSt
         DQoWyJg6VxeEwo0LnI81U4drDITQbjgSjpETvKElEnZ58aKC8KINGwUkN6Xt/psd1793
         lroGEbdKr201cmbszohI2tdAv2rrJfizP5iEIBScUzl2UewSGN/ZgMHVlDlvjBKavMAb
         rCoA==
X-Gm-Message-State: AOAM531ckx+usx0jdZV1tT3dh4xmUVaGAZ/Jopw0yLLnf/fd02vVKUBk
        pfRoZFlYiwV0Qhum2/iWTeZ9DWXNkO/3r2XMQhU1QMcyo4jRoBCZzwFIg8sjNDa8KAuT6VLIvNz
        u73EZ5F38MvfWyGRl3Dzqu2b37yKi/paOHEfD1gMGoMQg5oXBWEHREgwPwxDDP7nuCUvDg+vx3X
        XY
X-Received: by 2002:aa7:dd16:: with SMTP id i22mr2276993edv.215.1612350030602;
        Wed, 03 Feb 2021 03:00:30 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxD0l2Sp1vPosJtV46JVBfBeZ0Qn3cmoMemJtsZ1Tpnpbn4n/FzLpKq80zvyNgceIdXHL4zCQ==
X-Received: by 2002:aa7:dd16:: with SMTP id i22mr2276963edv.215.1612350030287;
        Wed, 03 Feb 2021 03:00:30 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-37a3-353b-be90-1238.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:37a3:353b:be90:1238])
        by smtp.gmail.com with ESMTPSA id lo26sm825014ejb.106.2021.02.03.03.00.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Feb 2021 03:00:29 -0800 (PST)
Subject: Re: [PATCH] platform/surface: aggregator: Fix braces in if condition
 with unlikely() macro
To:     Maximilian Luz <luzmaximilian@gmail.com>,
        platform-driver-x86@vger.kernel.org
Cc:     Mark Gross <mgross@linux.intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-kernel@vger.kernel.org
References: <20210126172202.1428367-1-luzmaximilian@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <81c1f69c-30ba-d01f-002f-41da5cb670aa@redhat.com>
Date:   Wed, 3 Feb 2021 12:00:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210126172202.1428367-1-luzmaximilian@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 1/26/21 6:22 PM, Maximilian Luz wrote:
> The braces of the unlikely() macro inside the if condition only cover
> the subtraction part, not the whole statement. This causes the result of
> the subtraction to be converted to zero or one. While that still works
> in this context, it causes static analysis tools to complain (and is
> just plain wrong).
> 
> Fix the bracket placement and, while at it, simplify the if-condition.
> Also add a comment to the if-condition explaining what we expect the
> result to be and what happens on the failure path, as it seems to have
> caused a bit of confusion.
> 
> This commit should not cause any difference in behavior or generated
> code.
> 
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Fixes: c167b9c7e3d6 ("platform/surface: Add Surface Aggregator subsystem")
> Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>

Thank you for your patch, I've applied this patch to my review-hans 
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note it will show up in my review-hans branch once I've pushed my
local branch there, which might take a while.

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans


> ---
>  .../surface/aggregator/ssh_packet_layer.c     | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/surface/aggregator/ssh_packet_layer.c b/drivers/platform/surface/aggregator/ssh_packet_layer.c
> index 74f0faaa2b27..583315db8b02 100644
> --- a/drivers/platform/surface/aggregator/ssh_packet_layer.c
> +++ b/drivers/platform/surface/aggregator/ssh_packet_layer.c
> @@ -1694,7 +1694,24 @@ static size_t ssh_ptl_rx_eval(struct ssh_ptl *ptl, struct ssam_span *source)
>  	/* Find SYN. */
>  	syn_found = sshp_find_syn(source, &aligned);
>  
> -	if (unlikely(aligned.ptr - source->ptr) > 0) {
> +	if (unlikely(aligned.ptr != source->ptr)) {
> +		/*
> +		 * We expect aligned.ptr == source->ptr. If this is not the
> +		 * case, then aligned.ptr > source->ptr and we've encountered
> +		 * some unexpected data where we'd expect the start of a new
> +		 * message (i.e. the SYN sequence).
> +		 *
> +		 * This can happen when a CRC check for the previous message
> +		 * failed and we start actively searching for the next one
> +		 * (via the call to sshp_find_syn() above), or the first bytes
> +		 * of a message got dropped or corrupted.
> +		 *
> +		 * In any case, we issue a warning, send a NAK to the EC to
> +		 * request re-transmission of any data we haven't acknowledged
> +		 * yet, and finally, skip everything up to the next SYN
> +		 * sequence.
> +		 */
> +
>  		ptl_warn(ptl, "rx: parser: invalid start of frame, skipping\n");
>  
>  		/*
> 

