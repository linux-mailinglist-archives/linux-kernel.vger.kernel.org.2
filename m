Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FBA8441972
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 11:06:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232274AbhKAKJL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 06:09:11 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:39852 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231958AbhKAKI6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 06:08:58 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 4C6491FD29;
        Mon,  1 Nov 2021 10:06:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1635761184; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WH7VChrDI+e9Uk1fqS2sz7sqWyDarVDdnxdnYZmqXAk=;
        b=vHTq/U3Id6FrBhLsYrLNIAncwMSC+Auwky48/YfxU80iYDZ/NpKm4Q5X+AK+Mku2Vplu4z
        62bOyc4rgBXHnlCEvBRRueCkPtt8DAJJX1x5BBP0bCkaH52L6AjLNpzblJdaKjUfUfLWYW
        JB1ABBbVTMLdFBEMsLncLOHaQxmQKw0=
Received: from suse.cz (unknown [10.100.224.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id C5293A3B83;
        Mon,  1 Nov 2021 10:06:23 +0000 (UTC)
Date:   Mon, 1 Nov 2021 11:06:23 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     "chunlei.wang" <Chunlei.wang@mediatek.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] printk: ringbuffer: Improve prb_next_seq() performance
Message-ID: <YX+8H8ApU/jm2lo9@alley>
References: <YXlddJxLh77DKfIO@alley>
 <875ytih3j9.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875ytih3j9.fsf@jogness.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2021-10-27 17:54:42, John Ogness wrote:
> On 2021-10-27, Petr Mladek <pmladek@suse.com> wrote:
> > diff --git a/kernel/printk/printk_ringbuffer.c b/kernel/printk/printk_ringbuffer.c
> > index 8a7b7362c0dd..24f47fbefbb5 100644
> > --- a/kernel/printk/printk_ringbuffer.c
> > +++ b/kernel/printk/printk_ringbuffer.c
> > @@ -474,8 +474,10 @@ static enum desc_state desc_read(struct prb_desc_ring *desc_ring,
> >  	 * state has been re-checked. A memcpy() for all of @desc
> >  	 * cannot be used because of the atomic_t @state_var field.
> >  	 */
> > -	memcpy(&desc_out->text_blk_lpos, &desc->text_blk_lpos,
> > -	       sizeof(desc_out->text_blk_lpos)); /* LMM(desc_read:C) */
> > +	if (desc_out) {
> > +		memcpy(&desc_out->text_blk_lpos, &desc->text_blk_lpos,
> > +		       sizeof(desc_out->text_blk_lpos)); /* LMM(desc_read:C) */
> > +	}
> >  	if (seq_out)
> >  		*seq_out = info->seq; /* also part of desc_read:C */
> >  	if (caller_id_out)
> 
> You also need this hunk:
> 
> @@ -530,7 +530,8 @@ static enum desc_state desc_read(struct prb_desc_ring *desc_ring,
>  	state_val = atomic_long_read(state_var); /* LMM(desc_read:E) */
>  	d_state = get_desc_state(id, state_val);
>  out:
> -	atomic_long_set(&desc_out->state_var, state_val);
> +	if (desc_out)
> +		atomic_long_set(&desc_out->state_var, state_val);
>  	return d_state;
>  }
> 
> Sorry, I missed it in my last review. This time I build+boot tested the patch.

Urgh. Great catch! It seems that my testing was not good enough. Or
that I was just lucky.

> With this hunk added:
> 
> Reviewed-by: John Ogness <john.ogness@linutronix.de>

I am going to queue it for 5.17 after the pull request for 5.16 is
accepted. I do not feel comfortable to rush this into 5.16, especially
after finding the bug. The merge window has just started...

Anyway, thanks a lot for review and catching the mistake.

Best Regards,
Petr
