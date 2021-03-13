Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D4BA339D28
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Mar 2021 10:13:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231597AbhCMJMu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Mar 2021 04:12:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbhCMJM2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Mar 2021 04:12:28 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9080DC061574
        for <linux-kernel@vger.kernel.org>; Sat, 13 Mar 2021 01:12:27 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id d3so49122180lfg.10
        for <linux-kernel@vger.kernel.org>; Sat, 13 Mar 2021 01:12:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QV+PrYQw9pIkwPrpEKiXnL7M8rMYsIr7iv2PYbqI9P4=;
        b=lQvKkR5Jo7MYP5ECGFSPo4OIJDBNQRr4hzUNa6PAbl5P+8s8vpj1oz8MNyJ0GxqsJF
         EWWnpy2if4wAV0UJy8sXJIsuJVn3Q2pTJXnhpS0xRLr+9ivo7igaxn4HC3yXXU7lQ2Gt
         BvMUj1hq4DER7eBE6HVtvjHV8tLekqsQPFgjt5flIiL/W5mKUK1p08KaC55uwtlWTTZ6
         L8x6Nmkq1SpFWcqCA5RAl8XjT8jZzX8rKMrX1ZbRdPsB18eML0k4PGJaNVxsSsyiMhxn
         cwg7fE7102l9f/gqmNvtVeBzwc5cAkWrN1GBTJP9d0FAA/rHB1U7ifykiNaXZ3o3BKhJ
         +KvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QV+PrYQw9pIkwPrpEKiXnL7M8rMYsIr7iv2PYbqI9P4=;
        b=hYK1rveFY7L5JuQ09eYy1xeXyFZLKv8Wbik9oaE7/XQeuZiROR5mwL98s7u/sRy9vX
         rlVFOUdM1kUt/IGtRKcqUUP0VF9NovAdauxoME3uq0hKm9E9NybcIh0SLW3aFM8eePDT
         pFhImiL3XCjLnya48AI67MQ+D4VPySojIpNm1vRH8YYNux9KZMETziBWzfEJ3UqpywUc
         BWmCsuuXV2JHab2IqF9WP774jA0cA/lAOmUHX2mcro90R5JM/79PQ49BaQJW1rZIeykt
         7wm0tL7syPUICnac+DHyTTlbKr1TgMYzLAbmfM1IzixNwgV1qC2Lq/OAC960MZAlcAjQ
         5V9g==
X-Gm-Message-State: AOAM532hJ4Qx21Cjbh8fUKoUU67Ll5wps/ghjyypAff5QKg5eaYOLwyc
        Wf6ab0ldqZ1KynqHdfMn9/gw8055rZo=
X-Google-Smtp-Source: ABdhPJzxOihwfIDQCaJggwsPk7CXdbAdEBca82idtcUlm4I07ZtVDd9NhRBJFTE3BrM5BbF93/m7iA==
X-Received: by 2002:a19:45:: with SMTP id 66mr1965858lfa.163.1615626744087;
        Sat, 13 Mar 2021 01:12:24 -0800 (PST)
Received: from shahbazi (cable-hki-50dc98-67.dhcp.inet.fi. [80.220.152.67])
        by smtp.gmail.com with ESMTPSA id f10sm1934989lfm.194.2021.03.13.01.12.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Mar 2021 01:12:23 -0800 (PST)
Date:   Sat, 13 Mar 2021 11:12:21 +0200
From:   Hassan Shahbazi <h.shahbazi.git@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     yildirim.fatih@gmail.com, ducheng2@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers: tty: vt: vt.c: fix NULL dereference crash
Message-ID: <20210313090512.GA104236@shahbazi>
References: <20210307105642.112572-1-h.shahbazi.git@gmail.com>
 <YEsnYVwzRoEsbkie@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YEsnYVwzRoEsbkie@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 12, 2021 at 09:33:37AM +0100, Greg KH wrote:
> On Sun, Mar 07, 2021 at 12:56:43PM +0200, Hassan Shahbazi wrote:
> > Fix a NULL deference crash on hiding the cursor.
> > 
> > Reported by: syzbot
> > https://syzkaller.appspot.com/bug?id=defb47bf56e1c14d5687280c7bb91ce7b608b94b
> > 
> > Signed-off-by: Hassan Shahbazi <h.shahbazi.git@gmail.com>
> > ---
> >  drivers/tty/vt/vt.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
> > index 284b07224c55..8c3e83c81341 100644
> > --- a/drivers/tty/vt/vt.c
> > +++ b/drivers/tty/vt/vt.c
> > @@ -904,7 +904,9 @@ static void hide_cursor(struct vc_data *vc)
> >  	if (vc_is_sel(vc))
> >  		clear_selection();
> >  
> > -	vc->vc_sw->con_cursor(vc, CM_ERASE);
> > +	if (vc->vc_sw)
> > +		vc->vc_sw->con_cursor(vc, CM_ERASE);
> > +
> >  	hide_softcursor(vc);
> >  }
> >  
> > -- 
> > 2.26.2
> > 
> 
> Are you sure this actually fixes the problem?  How did you test it?  Did
> syzbot test this?
> 
> I had a few reports of this patch _not_ solving the problem, so getting
> confirmation of this would be good.
> 
> thanks,
> 
> greg k-h

Unfortunately, it seems the patch has not fixed the bug. I drop this
patch and will continue working on a newer one.

Thanks for the feedback,
Hassan Shahbazi
