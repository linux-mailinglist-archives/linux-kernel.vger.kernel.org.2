Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EC1D3F8B45
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 17:43:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242962AbhHZPoX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 11:44:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243008AbhHZPoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 11:44:22 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78715C061757
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 08:43:34 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id q17so5363290edv.2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 08:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RTmjjgKNf1oCjSw/UGsuRv5cqlu6x5zYZlIgXT+yaLw=;
        b=lJrbCB4ysWZEZarm93Wi761yWOa7QX6uuPO+ZLMF/GnkYGg5Uwp0Yomk0Vg6y9ZJk/
         CRv9GBrp1fe2U8X2Rbq7nSiGL8GFkJolMCEvPTCwFAazvpdoFU6mMyK8w126BPWiDmWD
         g9RlrtPyMYB/J8vrYRvtMz6KEebkG0SJl6C+g4MaU/w7FZezv4EHltZDtTrw1l1+57v+
         fjjRqAwBwezlB1Copa/4O+ril4Hnv6xsaMxx2am8WnREGpmDWnzl+o3kXWakNPKo5Kzf
         IVmBZjSnVl4BckAjMG/4R66jaPA5lCTBKdLmpFu07MnEfnJSrs+95sc2uhl2Fy8WDoG7
         jbjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RTmjjgKNf1oCjSw/UGsuRv5cqlu6x5zYZlIgXT+yaLw=;
        b=UkQ2W9JlivMsLP2HhiOAoJxiaXJScWis9Y4a7O6KjjG/b9CmbyPPk2ga9msZF/jWXr
         5rl1iQxAujVwAQIUfZ+TBbonkpyyVDJjQo/VQFWk3k5/0/X1wRHu9vi72PdnSmLeHYYo
         zZ9iDTJnp94SubSnudJ/mhl8g5WQie7qiImchTkniHZ3yhhonevkqhQMq0yasY2vrN2I
         6kbyEo5oEFtm5g8jNIn4u6mgOWz0BUp/3zqc/efngE/pp2tuN5ipaztUtcI20BhA/RWn
         UPhySX76JZqG4CLxcWZ4orlm74yrLzf4j5nt/9ZV7VNXeCzkBu7hml6UwedfvRcU5VUL
         ODHw==
X-Gm-Message-State: AOAM530RXbeHAik/VkUN4MOKXAo4qv+Q+73/pV023tl6u/9A9HuQOeKI
        qxCDTiNuF/jrBVlbbeIAERk=
X-Google-Smtp-Source: ABdhPJwkXf1Qnwx1ulvB0BzEOAhffXq4rQNByw4ajefIueu5Z9lvMH5E2+n0wNBe02BpglytvaB3Rg==
X-Received: by 2002:aa7:d54f:: with SMTP id u15mr4926461edr.178.1629992613045;
        Thu, 26 Aug 2021 08:43:33 -0700 (PDT)
Received: from localhost.localdomain (host-79-22-100-164.retail.telecomitalia.it. [79.22.100.164])
        by smtp.gmail.com with ESMTPSA id q6sm2025099edd.26.2021.08.26.08.43.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Aug 2021 08:43:32 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Pavel Skripkin <paskripkin@gmail.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH v3 1/2] staging: r8188eu: Use usb_control_msg_recv/send() in usbctrl_vendorreq()
Date:   Thu, 26 Aug 2021 17:43:31 +0200
Message-ID: <1897490.lth8vsWHjN@localhost.localdomain>
In-Reply-To: <YSepDdf+nHekuIxA@kroah.com>
References: <20210825035311.8910-1-fmdefrancesco@gmail.com> <47945171.69uSEkksVi@localhost.localdomain> <YSepDdf+nHekuIxA@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, August 26, 2021 4:45:33 PM CEST Greg Kroah-Hartman wrote:
> On Thu, Aug 26, 2021 at 04:24:35PM +0200, Fabio M. De Francesco wrote:
> > On Thursday, August 26, 2021 12:48:37 PM CEST Greg Kroah-Hartman wrote:
> > > On Wed, Aug 25, 2021 at 05:53:10AM +0200, Fabio M. De Francesco wrote:
> > > > Replace usb_control_msg() with the new usb_control_msg_recv() and
> > > > usb_control_msg_send() API of USB Core in usbctrl_vendorreq().
> > > > Remove no more needed variables. Move out of an if-else block
> > > > some code that it is no more dependent on status < 0. Remove
> > > > redundant code depending on status > 0 or status == len.
> > > > 
> > > > Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> > > > ---
> > > > 
> > > > v2->v3: Restore the test for success of usb_control_message_recv/send
> > > > that was inadvertently removed. Issue reported by Pavel Skripkin.
> > > > 
> > > > v1->v2: According to suggestions by Christophe JAILLET 
> > > > <christophe.jaillet@wanadoo.fr>, remove 'pipe' and pass an explicit 0
> > > > to the new API. According to suggestions by Pavel Skripkin 
> > > > <paskripkin@gmail.com>, remove an extra if-else that is no more needed, 
> > > > since status can be 0 and < 0 and there is no 3rd state, like it was before.
> > > > Many thanks to them and also to Phillip Potter <phil@philpotter.co.uk>
> > > > who kindly offered his time for the purpose of testing v1.
> > > > 
> > > >  drivers/staging/r8188eu/hal/usb_ops_linux.c | 45 ++++++++-------------
> > > >  1 file changed, 17 insertions(+), 28 deletions(-)
> > > 
> > > This doesn't apply to my tree at all.  Please rebase and resend.
> > 
> > This series cannot apply to your tree until another one of mine is applied 
> > ("staging: r8188eu: Remove _enter/_exit_critical_mutex()"). This series builds
> > on the previous patch.
> 
> When you do that, please let me know somehow that this is the case,
> otherwise how am I supposed to guess that?

Correct, my fault :( 

To my defense I can only say that I really had forgot that there were the 
above-mentioned previous patch still in your queue. So I didn't immediately 
realized that I had to inform you somehow of this kind of dependence.
I knew that only yesterday, when Pavel wanted to apply this patch to 
his local copy of your then current tree and he couldn't. After some thoughts
I understood that the latter depended on the former, but I guess it was too late 
to inform you. Furthermore, yesterday I thought that you would have applied 
in a FIFO order and that you wouldn't notice any conflict.

Actually I was wrong, because you didn't apply the former and instead asked
me to test it (we talked about that patch some minutes ago in another message).
 
> > > But first, are you sure you want to use these new functions here?  This
> > > is a "common" function that is called from different places for
> > > different things.  How about unwinding the callers of this function
> > > first, to see if they really need all of the complexity in this function
> > > at all, and if not, then call the real USB function in those locations
> > > instead.
> > 
> > I think it could be fine to simply refactor usbctrl_vendorreq() to use the newer
> > API with no necessity to directly use them at least in six different places in
> > hal/usb_ops_linux.c. The only users of this helper are usb_read8/16/32() and
> > usb_write8/16/32(). Why do you prefer using usb_control_msg_recv/send() 
> > directly in the callers? I guess it would lead to redundant code, more or less
> > the same code repeated again and again within the above-mentioned six callers.
> > What do we improve by doing as you suggest? What am I missing?
> 
> If you unwind the mess, you will find that the code will be much easier
> to understand.
> 
> As an example, look at usb_write8().  Where is it ever called?  Why do
> we have it at all?  It's only used in 1 place, and then that function
> unwinds into rtw_write8(), which is used in a lot of places, and never
> checked at all, making the majority of the logic in this function
> totally unneeded and useless.
> 
> Same for rtw_write16() and rtw_write32().  After unwinding the mess you
> see that the logic you are working to try to clean up in this patch
> series is pretty much not used / needed at all, right?  So why do it?
> 
> Unwind the mess into a useful set of functions the driver can actually
> call that is not 2-4 function pointers deep and then we can talk about
> unifying things, if they are really needed.  But right now, it's
> impossible to tell.

Yeah, I know how is the call chain from top (rtw_read/write8/16/32()) to bottom
(usbctrl_vendorreq()) and then to the new USB core API. 

Pavel and I have been talking about this topic while he was working on his 
series ("r8188eu: avoid uninit value bugs").

Aside from this, I re-thought about what you write above and I too find that
having 2-4 function pointers deep is a bad design. Anyway I'm stuck in 
waiting to see what Pavel will submit with his reworking, because I don't 
desire to make patches that conflict with his.

As you often say to all us: there is no hurry! So, I'll wait to see Pavel's final
work before changing whatever could conflict with him.

> good luck!

Thanks, I'll need it :-)

And thanks for the time you spent to clarify your thoughts about these topics.

Fabio
 
> greg k-h



