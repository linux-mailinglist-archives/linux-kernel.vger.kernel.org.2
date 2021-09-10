Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B27B9405FFA
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 01:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349041AbhIIXWI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 19:22:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348975AbhIIXWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 19:22:04 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96219C061756
        for <linux-kernel@vger.kernel.org>; Thu,  9 Sep 2021 16:20:54 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id m25-20020a7bcb99000000b002e751bcb5dbso91100wmi.5
        for <linux-kernel@vger.kernel.org>; Thu, 09 Sep 2021 16:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0RhJIdD4xaWkX/YGpADDYGfI03GmKt9W5rxecYw0/Cg=;
        b=HAOjaTrXDUjh/cv/D9OeCqhRVaKLSCHTXZOVyHBL7Dk51+p+YOZwElC4pEolZqvo2s
         2hSd7g0QqrTqDS6LWRXoGlUAZlX/+nL074ugrHTonBakYklXDEGBbTL8mrGWDTN8OcMm
         khhu68PqR8IkV+BtRDQFqNfF8luFh+oBwJi06M9WFLdlPY7cL9bYtr8i3rRF8Yv+T29+
         lD4xZiYyRmsZOWkl5Mw20P0SUe7QyX8WS4SwGYsbmX8iM1OcfQzAiKDug/l96hVbon+T
         XOHS7Zay/1+wEnm0SVYbY8+zA1AqpcXewhBpSZZv11vhugodfMavNueSHSDMZQeOiNNZ
         WkFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0RhJIdD4xaWkX/YGpADDYGfI03GmKt9W5rxecYw0/Cg=;
        b=lGr6rrwQAHhDXyL7YcP7T2bLeNtqmyHvZRaXTX5xVWu1DOVpGv8yk09K0eJmN8w+dO
         Stiz2CYkAx0j6KwVkNVek8YzJ88qHRMIwULDSmEom5NbaWC6GQitQA045pTfK5HgSQP0
         Sc5FXGRnLF1VhxQCDmHhKZ4hQ564Qq/jsspzYkD2dJIBasE4f/Gu61TkIYtQkXq8o9NJ
         p6D3Mv/UILYSJG1CeCGQsKYxG0kXF/hSAKFqj+DEwkx1JD3qR2ocZ5R5ywLaKOWdJ6km
         Zcq3slzRNeldQggNPIC5VhIZS7xS4fF0DqpQB8SBmVz7d3zyqBgVq9LqGT6HHa34bWtP
         xPiA==
X-Gm-Message-State: AOAM533N11uJUI15Tv4im2K03IRFSFMd77Fp9s1CKdaqdpuXeDy4DGUl
        TaCf2iUi9wSoBZmNu9dT4atuKw==
X-Google-Smtp-Source: ABdhPJwIUWtrK6eidOuuglBJjbyNiJcVrL7gxPBH6ujcDRAnhp0VTGH/CzqnlUfh0QXfHhmX5OUn6A==
X-Received: by 2002:a05:600c:4e93:: with SMTP id f19mr5402658wmq.185.1631229653222;
        Thu, 09 Sep 2021 16:20:53 -0700 (PDT)
Received: from equinox (2.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0::2])
        by smtp.gmail.com with ESMTPSA id a10sm3077136wrd.51.2021.09.09.16.20.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 16:20:52 -0700 (PDT)
Date:   Fri, 10 Sep 2021 00:20:50 +0100
From:   Phillip Potter <phil@philpotter.co.uk>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     rdunlap@infradead.org, axboe@kernel.dk, hch@infradead.org,
        linux-kernel@vger.kernel.org, lumip@lumip.de,
        linux-block@vger.kernel.org
Subject: Re: [PATCH v2] drivers/cdrom: improved ioctl for media change
 detection
Message-ID: <YTqW0ppQUAh9u4dj@equinox>
References: <409876e1-1293-932d-8d37-0211bef07749@infradead.org>
 <20210909180553.8299-1-lumip@lumip.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210909180553.8299-1-lumip@lumip.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 09, 2021 at 09:05:54PM +0300, Lukas Prediger wrote:
> Dear Christoph, Phillip and Randy,
> 
> thanks to you all for your comments!
> 

Dear Lukas,

You're welcome, thank you for the code.

> >>> Overly long line here, but more importantly this is much cleaner with
> >>> a good old if:
> >>>
> >>>
> >>> 	if (tmp_info.last_media_change - cdi->last_media_change_ms) < 0)
> >>> 		tmp_info.has_changed = 1;
> >>>
> >> 
> >> Whilst I don't disagree this is technically cleaner, the existing style
> >> certainly read well to me. 
> 
> The if would additionally require to explicitly initialise .has_changed to
> zero for the else case, so I favored the single assignment that covers
> all cases. I don't have a strong opinion on this, though, so if the if variant
> is generally favored, I can change this. (And I will definitely fix the overlength).
>

Yes true, but I guess your existing style is harder to split across
lines in a clean way. As mentioned, I didn't mind the original code, but
the line length is a fair point. Your call on this one - those with far
more experience than me would probably argue the if/else form though.

> >> In terms of line length, checkpatch doesn't
> >> complain about it, so I guess you mean purely from a visual perspective?
> >
> > Documentation/process/coding-style.rst says:
> >
> >    The preferred limit on the length of a single line is 80 columns.
> >
> > checkpatch only checks lines > 100 columns since that is OK in a few
> > cases, like a long quoted string.
> >
> > So try to limit line lengths to 80 columns unless there is some
> > other reason not to do that.
> 
> I wasn't aware that checkpatch.pl does not complain if I exceed the 80 cols,
> have fixed those now for an upcoming resubmission.
> 

Same, guilty as charged on this one - live and learn I guess :-)

> >>> +{
> >>> +	__s64	last_media_change;	/* Timestamp of the last detected media
> >>> +					 * change in ms. May be set by caller, updated
> >>> +					 * upon successful return of ioctl.
> >>> +					 */
> >>> +	__u64	has_changed;		/* Set to 1 by ioctl if last detected media
> >>>
> >>> More overly long lines.  Also why is has_changed a u64 if it is used as
> >>> a boolean flag?
> >>
> >> As this is not a packed struct, would not a smaller value still take up
> >> the same space?
> >
> > Might as well be explicit about it and also make it obvious that there
> > is some space available for other fields.
> 
> I had this as a __u8 in the first submission but Jens asked me to change it.
> From his feedback on this:
> 
> "The struct layout should be modified such that there are no holes or
> padding in it. Probably just make the has_changed a flags thing, and
> make it u64 as well. Then you can define bit 0 to be HAS_CHANGED, and
> that leaves you room to add more flags in the future."
> https://lore.kernel.org/lkml/6d6c533d-465e-33ee-5801-cb7ea84924a8@kernel.dk/
> 

Yeah, maybe just a bit more in the comment to emphasize the room for
extra bits in has_changed? I agree it looks fine like this to me though
given the lack of struck packing anyway.

> I changed it to __u64 to address this. We could think about turning it
> back to a __u8 (or bool) and add some explicit padding members
> (a __u8 reserved[3]?), but honestly I don't see much real benefit in that
> compared to how it is now.
> 

I agree with you on this personally, I think it's fine.

Regards,
Phil
