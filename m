Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9E7A3CA1AB
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 17:50:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239199AbhGOPxS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 11:53:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238841AbhGOPxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 11:53:17 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7269FC06175F
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 08:50:24 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id d1so4852898qto.4
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 08:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zdJ5ZjcavwcHHbMqn+hbi9ZtU6+DEG5Y1d3HPh4pGFc=;
        b=d2L/sE9pxIM+mizWsal43cYbqpELvR3/1xAUM1YqHB2Ah++CRoBLk7d3Tfl7QTJGCs
         ZtuvUQMiZGzWEsVRHb5CHEkz3r1gmTOtBkKoL48BGULgS30KkA4H50wEhE3oXX2bwMT2
         tJwZpzSfe0Av6bP6wUSZtYi+NV3wMjoso/T4a91IpCmArB0gR0Lw1e5adE7eOFG7taGu
         2rDH/K/h8URg73xUHe/rn8m2AIWAzZGLo6MAbwQ3R14e8Dr97hGTYiiA/38g4NtauX8X
         5wKraclDzqmdp3vzXHqJhfyZ/N9LBBs8jA9Oz3/bRBH3ErMSV9sQs2nglWfhsYpsyoS0
         XqZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zdJ5ZjcavwcHHbMqn+hbi9ZtU6+DEG5Y1d3HPh4pGFc=;
        b=rUMqb3Iz0pc3okvHafMUX+fAqlc9qoKEuky+PCmga4xXCCW2viGpaUleL7+ffP2ptF
         vwHL84IjJ0cZPd+EEO4qGHg/OKnNsMxpD2FojuwI/L2r29FwksYokfkIK15m1RItk7fl
         qXWbGX35LSVUi0YIu472HbFekSGs7UXuyRk+b9nItP9LkAv+KAAjviqEIqaZuGO+ZzIM
         uKA6ehJS1Sx5tct8H6flizUzGXhuszGGVJLJn6t0y9haWCE+1r0y5L3VBsezifcaZilv
         DXbjYPTGM2Gt434UMtZAT1L4MK9nD3wNXAaja4xAcAWeHSSIo2Aeyqul/NRto/YU5uAa
         Ytgw==
X-Gm-Message-State: AOAM5302i6nTxKDylOhwi4BXmbYj/3PsrivMV3uepXSAFqEuztexeoVL
        uGL3qUpzurmAVxsh8HvMjx4=
X-Google-Smtp-Source: ABdhPJxqTexUkfy/+clU20gVzdJQ2zM0BLKh1Lmpydjsv2w3mO6pcXgZudwaDWgCC3bQsleiViXDCg==
X-Received: by 2002:ac8:1005:: with SMTP id z5mr4641488qti.255.1626364222971;
        Thu, 15 Jul 2021 08:50:22 -0700 (PDT)
Received: from localhost ([207.98.216.60])
        by smtp.gmail.com with ESMTPSA id j20sm2115806qtq.14.2021.07.15.08.50.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jul 2021 08:50:22 -0700 (PDT)
Date:   Thu, 15 Jul 2021 08:50:21 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 2/2] bitmap: introduce for_each_set_bitrange
Message-ID: <YPBZPbCgJPjV2qPW@yury-ThinkPad>
References: <20210709034519.2859777-1-yury.norov@gmail.com>
 <20210709034519.2859777-3-yury.norov@gmail.com>
 <20210709095950.6a451ccb@oasis.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210709095950.6a451ccb@oasis.local.home>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 09, 2021 at 09:59:50AM -0400, Steven Rostedt wrote:
> On Thu,  8 Jul 2021 20:45:19 -0700
> Yury Norov <yury.norov@gmail.com> wrote:
> 
> > bitmap_list_string() is very ineffective when printing bitmaps with long
> > ranges of set bits because it calls find_next_bit for each bit. We can do
> > better by detecting ranges of set bits.
> > 
> > This patch introduces a macro for_each_set_bitrange and uses it in
> > bitmap_list_string(). In my environment, before/after is 943008/31008 ns.
> > 
> > Signed-off-by: Yury Norov <yury.norov@gmail.com>
> > ---
> >  include/linux/find.h |  7 +++++++
> >  lib/vsprintf.c       | 40 ++++++++++++++++------------------------
> >  2 files changed, 23 insertions(+), 24 deletions(-)
> > 
> > diff --git a/include/linux/find.h b/include/linux/find.h
> > index ae9ed52b52b8..1a5ed45dc81b 100644
> > --- a/include/linux/find.h
> > +++ b/include/linux/find.h
> > @@ -301,6 +301,13 @@ unsigned long find_next_bit_le(const void *addr, unsigned
> >  	     (bit) < (size);					\
> >  	     (bit) = find_next_zero_bit((addr), (size), (bit) + 1))
> >  
> > +#define for_each_set_bitrange(b, e, addr, size)			\
> 
> The above needs a kerneldoc header.

OK. 

> 
> > +	for ((b) = find_next_bit((addr), (size), 0),		\
> > +	     (e) = find_next_zero_bit((addr), (size), (b) + 1);	\
> > +	     (b) < (size);					\
> > +	     (b) = find_next_bit((addr), (size), (e) + 1),	\
> > +	     (e) = find_next_zero_bit((addr), (size), (b) + 1))
> > +
> >  /**
> >   * for_each_set_clump8 - iterate over bitmap for each 8-bit clump with set bits
> >   * @start: bit offset to start search and to store the current iteration offset
> > diff --git a/lib/vsprintf.c b/lib/vsprintf.c
> > index 87acf66f0e4c..1ee54dace71e 100644
> > --- a/lib/vsprintf.c
> > +++ b/lib/vsprintf.c
> > @@ -1240,38 +1240,30 @@ char *bitmap_list_string(char *buf, char *end, unsigned long *bitmap,
> >  			 struct printf_spec spec, const char *fmt)
> >  {
> >  	int nr_bits = max_t(int, spec.field_width, 0);
> > -	/* current bit is 'cur', most recently seen range is [rbot, rtop] */
> > -	int cur, rbot, rtop;
> > -	bool first = true;
> > +	char *start = buf;
> > +	int b, e;
> >  
> >  	if (check_pointer(&buf, end, bitmap, spec))
> >  		return buf;
> >  
> > -	rbot = cur = find_first_bit(bitmap, nr_bits);
> > -	while (cur < nr_bits) {
> > -		rtop = cur;
> > -		cur = find_next_bit(bitmap, nr_bits, cur + 1);
> > -		if (cur < nr_bits && cur <= rtop + 1)
> > -			continue;
> > +	for_each_set_bitrange(b, e, bitmap, nr_bits) {
> > +		buf = number(buf, end, b, default_dec_spec);
> > +		if (e == b + 1)
> > +			goto put_comma;
> 
> Using a goto to skip a few lines instead of just having the reverse
> conditional is rather sloppy IMO.
> 
> 		if (e != b + 1) {
> 			if (buf < end)
> 				*buf = '-';
> 			buf++;
> 			buf = number(buf, end, e - 1, default_dec_spec);
> 		}
> 
> Is much clearer.
 	
I don't think it's clearer, but as you wish.

> >  
> > -		if (!first) {
> > -			if (buf < end)
> > -				*buf = ',';
> > -			buf++;
> > -		}
> > -		first = false;
> > +		if (buf < end)
> > +			*buf = '-';
> >  
> > -		buf = number(buf, end, rbot, default_dec_spec);
> > -		if (rbot < rtop) {
> > -			if (buf < end)
> > -				*buf = '-';
> > -			buf++;
> > +		buf = number(++buf, end, e - 1, default_dec_spec);
> > +put_comma:
> > +		if (buf < end)
> > +			*buf = ',';
> > +		buf++;
> > +	}
> >  
> > -			buf = number(buf, end, rtop, default_dec_spec);
> > -		}
> > +	if (buf > start)
> > +		buf--;
> 
> If the above is to undo the last comma, please put back the first logic.
> 
> -- Steve

You're asking me to move part of the logic inside the loop which generally
should be avoided. Is there any particular reason to do this?

> 
> >  
> > -		rbot = cur;
> > -	}
> >  	return buf;
> >  }
> >  
