Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20FB438F7F7
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 04:13:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbhEYCPJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 22:15:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbhEYCPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 22:15:08 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9755C061574
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 19:13:39 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 29so10407325pgu.11
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 19:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=eTe+TnZWka47XzdYxR4Tb+kvwPnKlvl1m7carpA23+0=;
        b=vQ93Zkm21b8ODlREXEuF2D82fumsqTWTEkCq1ZrHm2kLdMrNJxLbCwGVg67Tmt1DKD
         hcWEb78lcoBscnRM+3+HbVa2pUOWjannqZWfboa7izS5ul12BxbD/LA4CF4iz46k+clT
         PDidvl236m4pNVxmGWpPFw9MoR/ViQVfSy7snua6iX/QPKhYGKWdTbzgYSlO/h94zqd7
         /tY2ZaxLJQYyFWy6NHqIJemUA+cHUTk8f5MsoZEbXQuuMptiXg7ID13UtFiCpHIgBnIA
         Am2ffYqotcJNje3pKP860jOTbbzmaO91egzwlbydHapOoRAqG8IOaVe6DLLpwstAK1IF
         ER4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eTe+TnZWka47XzdYxR4Tb+kvwPnKlvl1m7carpA23+0=;
        b=pD/Owx4E+IB8ZyYCFqiurMQMs2t6TPMR8aSvN4uRslfjI5PjEMMzTJuTI/8nebMezZ
         8OJzi7hfUz1zHZALiQXqkZ2b5puRSHYP4T91McgEC1LIODLSacE4x8LEfTZwNVfuPWsA
         F2Oi8Un2TB8fs/g2o3oaivqbfCozSULb4XTKuoseXmzNuRsQcRoyn9kPD/9o3LHzddx0
         JPCe0eMfDVV2GCWwmGkmgJGbewfZlnkPt+pDy3k1YXIWKYN62UHzUTxXAauh6ChLLYJI
         pz8gyj4OL4FCx1bgfM2ieTTInTe4H8+smwqK1MkDv3y8Ai0QlnwB7ZtTSLYFoIzBKFjO
         Ymyg==
X-Gm-Message-State: AOAM530RXbbbhCc8FvNuN93Vb79rUpBrTvAts++DQqSXXp1JoYYoTdfr
        FSLdSZfr1M/4ZXL5Nt+MXIA=
X-Google-Smtp-Source: ABdhPJybAMHkQ4/DFc8FbBn/wDHTRPUFlKBtA8RA12mPH+X4Vt0d1iJUVa1m/hjFV2nCADyJdQDTmA==
X-Received: by 2002:a63:521a:: with SMTP id g26mr16763354pgb.279.1621908819022;
        Mon, 24 May 2021 19:13:39 -0700 (PDT)
Received: from [192.168.1.67] (99-44-17-11.lightspeed.irvnca.sbcglobal.net. [99.44.17.11])
        by smtp.gmail.com with ESMTPSA id r4sm4794825pff.197.2021.05.24.19.13.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 May 2021 19:13:38 -0700 (PDT)
Subject: Re: [PATCH 3/4] firmware: arm_scmi: Introduce monotonically
 increasing tokens
To:     Cristian Marussi <cristian.marussi@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, etienne.carriere@linaro.org,
        vincent.guittot@linaro.org, souvik.chakravarty@arm.com
References: <20210524231503.34924-1-cristian.marussi@arm.com>
 <20210524231503.34924-4-cristian.marussi@arm.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <38fb1a44-3ed4-3a8f-0716-e91159b72a9b@gmail.com>
Date:   Mon, 24 May 2021 19:13:35 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210524231503.34924-4-cristian.marussi@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/24/2021 4:15 PM, Cristian Marussi wrote:
> Tokens are sequence numbers embedded in the each SCMI message header: they
> are used to correlate commands with responses (and delayed responses), but
> their usage and policy of selection is entirely up to the caller (usually
> the OSPM agent), while they are completely opaque to the callee (SCMI
> server platform) which merely copies them back from the command into the
> response message header.
> This also means that the platform does not, can not and should not enforce
> any kind of policy on received messages depending on the contained sequence
> number: platform can perfectly handle concurrent requests carrying the same
> identifiying token if that should happen.
> 
> Moreover the platform is not required to produce in-order responses to
> agent requests, the only constraint in these regards is that in case of
> an asynchronous message the delayed response must be sent after the
> immediate response for the synchronous part of the command transaction.
> 
> Currenly the SCMI stack of the OSPM agent selects as token for the

s/as token/a token/?

> egressing commands the lowest possible number which is not already in use
> by an existing in-flight transaction, which means, in other words, that
> we immediately reuse any token after its transaction has completed or it
> has timed out: this indeed simplifies token and associated xfer management
> and lookup.
> 
> Under the above assumptions and constraints, since there is really no state
> shared between the agent and the platform to let the platform know when a
> token and its associated message has timed out, the current policy of early
> reuse of tokens can easily lead to the situation in which a spurios or late

s/spurios/spurious/

> received response (or delayed_response), related to an old stale and timed
> out transaction, can be wrongly associated to a newer valid in-flight xfer
> that just happens to have reused the same token.
> 
> This misbehavior on such ghost responses is more easily exposed on those
> transports that naturally have an higher level of parallelism in processing
> multiple concurrent in-flight messages.
> 
> This commit introduces a new policy of selection of tokens for the OSPM
> agent: each new transfer now gets the next available and monotonically
> increasing token, until tokens are exhausted and the counter rolls over.
> 
> Such new policy mitigates the above issues with ghost responses since the
> tokens are now reused as later as possible (when they roll back ideally)
> and so it is much easier to identify ghost responses to stale timed out
> transactions: this also helps in simplifying the specific transports
> implementation since stale transport messages can be easily identified
> and discarded early on in the rx path without the need to cross check
> their actual sate with the core transport layer.
> This mitigation is even more effective when, as is usual the case, the

s/usual/usually/

> maximum number of pending messages is capped by the platform to a much
> lower value than whole possible range of tokens.(2^10)
> 
> This internal policy change in the core SCMI transport layer is fully
> transparent to the specific transports so it has not and should not have
> any impact on the transports implementation.
> 
> The empirically observed cost of such new procedure of token selection
> amounts in the best case to ~10us out of an observed full transaction cost
> of 3ms for the completion of a synchronous sensor reading command on a
> platform supporting commmands completion interrupts.

s/commmands/commands/

> 
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>

Overall this looks good to me and is more straightforward than I thought.
[snip]

> +/**
> + * scmi_xfer_token_set  - Reserve and set new token for the xfer at hand
> + *
> + * @minfo: Pointer to Tx/Rx Message management info based on channel type
> + * @xfer: The xfer to act upon
> + *
> + * Pick the next unused monotonically increasing token and set it into
> + * xfer->hdr.seq: picking a monotonically increasing value avoids reusing
> + * immediately tokens of just completed or timed-out xfers, mitigating the risk
> + * of wrongly associating a late received answer for an expired xfer to a live
> + * in-flight transaction which happened to have reused the same token.

This was a bit harder to read than I thought, how about:

picking a monotonically increasing value avoids immediate reuse of
freshly completed or timed-out xfers, thus mitigating the risk of
incorrect association of a late and expired xfer with a live in-flight
transaction, both happening to re-use the same token identifier.
-- 
Florian
