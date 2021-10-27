Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 248DE43CDEF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 17:48:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242835AbhJ0PvK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 11:51:10 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41318 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242827AbhJ0PvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 11:51:09 -0400
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1635349723;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tkgVdeXd598pY6QU8+NQfjeQPsQIGyv6eN0Glc1LxB8=;
        b=E1mttTQNJGFfAAYzAmlbyJlajz+M1aCHTFA0exSqMApNuSblDEJ/VWVzbUiib9QPsnIDSG
        bqG1p6eHKr32gHH7LUa8Q6gm7GWXtBCoano7f85qDMZU6wimszeQAUxkgoVmuWymqt5g9+
        gkB/aJR5hqmxLjaG+ud4Pmh8pBFBoy8wObsI0NagaE90M1vtHKn/OSm+1id6atWiPHy3qE
        2jAwkoPAuPLantUo940hSj8BskMyWLcoR12DuYwbcAvPhGg/FAXm8Yu1iq9MGl6r/Wvxch
        SgG9+XVztZfP6u1CV2he2FKpjLX92dXO5RKZBwYEhoKMj/xOElRmQqeo5QtsVQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1635349723;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tkgVdeXd598pY6QU8+NQfjeQPsQIGyv6eN0Glc1LxB8=;
        b=vFfC/cCfKpiBQYOBxRqi7Tsb/O51LcCf3i/k0yyiJi6iXtBd7cWNLp5srPz34r7Ueikskh
        GZvvGnQTSpWHdTCw==
To:     Petr Mladek <pmladek@suse.com>
Cc:     "chunlei.wang" <Chunlei.wang@mediatek.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] printk: ringbuffer: Improve prb_next_seq() performance
In-Reply-To: <YXlddJxLh77DKfIO@alley>
References: <YXlddJxLh77DKfIO@alley>
Date:   Wed, 27 Oct 2021 17:54:42 +0206
Message-ID: <875ytih3j9.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-10-27, Petr Mladek <pmladek@suse.com> wrote:
> diff --git a/kernel/printk/printk_ringbuffer.c b/kernel/printk/printk_ringbuffer.c
> index 8a7b7362c0dd..24f47fbefbb5 100644
> --- a/kernel/printk/printk_ringbuffer.c
> +++ b/kernel/printk/printk_ringbuffer.c
> @@ -474,8 +474,10 @@ static enum desc_state desc_read(struct prb_desc_ring *desc_ring,
>  	 * state has been re-checked. A memcpy() for all of @desc
>  	 * cannot be used because of the atomic_t @state_var field.
>  	 */
> -	memcpy(&desc_out->text_blk_lpos, &desc->text_blk_lpos,
> -	       sizeof(desc_out->text_blk_lpos)); /* LMM(desc_read:C) */
> +	if (desc_out) {
> +		memcpy(&desc_out->text_blk_lpos, &desc->text_blk_lpos,
> +		       sizeof(desc_out->text_blk_lpos)); /* LMM(desc_read:C) */
> +	}
>  	if (seq_out)
>  		*seq_out = info->seq; /* also part of desc_read:C */
>  	if (caller_id_out)

You also need this hunk:

@@ -530,7 +530,8 @@ static enum desc_state desc_read(struct prb_desc_ring *desc_ring,
 	state_val = atomic_long_read(state_var); /* LMM(desc_read:E) */
 	d_state = get_desc_state(id, state_val);
 out:
-	atomic_long_set(&desc_out->state_var, state_val);
+	if (desc_out)
+		atomic_long_set(&desc_out->state_var, state_val);
 	return d_state;
 }

Sorry, I missed it in my last review. This time I build+boot tested the patch.

With this hunk added:

Reviewed-by: John Ogness <john.ogness@linutronix.de>

John
