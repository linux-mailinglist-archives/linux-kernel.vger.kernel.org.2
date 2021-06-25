Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E737F3B49AB
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 22:08:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbhFYUKZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 16:10:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:39114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229712AbhFYUKY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 16:10:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7A69761960;
        Fri, 25 Jun 2021 20:08:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624651683;
        bh=NlrfNtc194UlEd/q110C08hY9M4sajBezN97jjTWyY0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i1Qf5Nyvau5r1xhbMEMCySZ+xdDEQAEVe/I9EQYmz1aGUxT9Zs4a9bj3PAa+5h3T7
         XGmgELeyxdj+RJK5ERNBChniycSKC7UIyE7y0VYk+eVuAUE7OMU6M9Ji4Wqnyk0brk
         670xDGSHV+dnjBclobYlkImMCCfGta1JGVKHTCZQrgqhvqJ+hT4vPN6KMCOLUb9mvK
         GKedY5RA90OA41ZNb7KcCGr2+aKFrQNJWIKdqxoF7RS6NAl5Z9orNcDRSweB+xSjrz
         +2K9OkKfM2cfyjEj/ZFeAh9uMmdDnm+SAMgGfQAx5Ve/TF1KawhLzygZ3mLfO4USat
         uLJ2sb6CwkjSg==
Date:   Fri, 25 Jun 2021 13:08:00 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     "Geoffrey D. Bennett" <g@b4.vu>
Cc:     alsa-devel@alsa-project.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH v2] ALSA: usb-audio: scarlett2: Fix for loop increment in
 scarlett2_usb_get_config
Message-ID: <YNY3oF3RkbZRk2Ri@Ryzen-9-3900X.localdomain>
References: <s5heecql74j.wl-tiwai@suse.de>
 <20210625175418.2019892-1-nathan@kernel.org>
 <20210625184342.GA23780@m.b4.vu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210625184342.GA23780@m.b4.vu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 26, 2021 at 04:13:42AM +0930, Geoffrey D. Bennett wrote:
> On Fri, Jun 25, 2021 at 10:54:19AM -0700, Nathan Chancellor wrote:
> > Clang warns:
> > 
> > sound/usb/mixer_scarlett_gen2.c:1189:32: warning: expression result
> > unused [-Wunused-value]
> >                         for (i = 0; i < count; i++, (u16 *)buf++)
> >                                                     ^      ~~~~~
> > 1 warning generated.
> > 
> > It appears the intention was to cast the void pointer to a u16 pointer
> > so that the data could be iterated through like an array of u16 values.
> > However, the cast happens after the increment because a cast is an
> > rvalue, whereas the post-increment operator only works on lvalues, so
> > the loop does not iterate as expected. This is not a bug in practice
> > because count is not greater than one at the moment but this could
> > change in the future so this should be fixed.
> > 
> > Replace the cast with a temporary variable of the proper type, which is
> > less error prone and fixes the iteration. Do the same thing for the
> > 'u8 *' below this if block.
> > 
> > Fixes: ac34df733d2d ("ALSA: usb-audio: scarlett2: Update get_config to do endian conversion")
> > Link: https://github.com/ClangBuiltLinux/linux/issues/1408
> > Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> > ---
> > 
> > v1 -> v2:
> > 
> > * Use temporary variables of proper type rather than casting, as
> >   requested by Takashi. I did not include Geoffrey's ack for this
> >   reason.
> > 
> > * Mention that there is not a bug at the moment per Geoffrey's comment.
> > 
> >  sound/usb/mixer_scarlett_gen2.c | 14 ++++++++++----
> >  1 file changed, 10 insertions(+), 4 deletions(-)
> > 
> > diff --git a/sound/usb/mixer_scarlett_gen2.c b/sound/usb/mixer_scarlett_gen2.c
> > index fcba682cd422..b13903bed330 100644
> > --- a/sound/usb/mixer_scarlett_gen2.c
> > +++ b/sound/usb/mixer_scarlett_gen2.c
> > @@ -1177,17 +1177,22 @@ static int scarlett2_usb_get_config(
> >  	const struct scarlett2_config *config_item =
> >  		&scarlett2_config_items[info->has_mixer][config_item_num];
> >  	int size, err, i;
> > +	u8 *buf_8;
> >  	u8 value;
> >  
> >  	/* For byte-sized parameters, retrieve directly into buf */
> >  	if (config_item->size >= 8) {
> > +		u16 *buf_16;
> > +
> 
> I would prefer that the u16 *buf_16 declaration above be removed from
> there...
> 
> >  		size = config_item->size / 8 * count;
> >  		err = scarlett2_usb_get(mixer, config_item->offset, buf, size);
> >  		if (err < 0)
> >  			return err;
> > -		if (size == 2)
> > -			for (i = 0; i < count; i++, (u16 *)buf++)
> > -				*(u16 *)buf = le16_to_cpu(*(__le16 *)buf);
> > +		if (size == 2) {
> > +			buf_16 = buf;
> 
> ...and combined with the assignment here, like: u16 *buf_16 = buf;

Thanks for pointing it out, I was not paying enough attention to realize
that the scope could be reduced. v3 sent with your Ack added, thank you
for taking a look in a quick manner!

Cheers,
Nathan

> Regardless:
> 
> Acked-by: Geoffrey D. Bennett <g@b4.vu>
> 
> And, thanks again!
> 
> > +			for (i = 0; i < count; i++, buf_16++)
> > +				*buf_16 = le16_to_cpu(*(__le16 *)buf_16);
> > +		}
> >  		return 0;
> >  	}
> >  
> > @@ -1197,8 +1202,9 @@ static int scarlett2_usb_get_config(
> >  		return err;
> >  
> >  	/* then unpack from value into buf[] */
> > +	buf_8 = buf;
> >  	for (i = 0; i < 8 && i < count; i++, value >>= 1)
> > -		*(u8 *)buf++ = value & 1;
> > +		*buf_8++ = value & 1;
> >  
> >  	return 0;
> >  }
> > 
> > base-commit: 0cbbeaf370221fc469c95945dd3c1198865c5fe4
> > -- 
> > 2.32.0.93.g670b81a890
> > 
