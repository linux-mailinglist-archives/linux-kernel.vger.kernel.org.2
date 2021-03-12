Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D72F338842
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 10:07:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232518AbhCLJHP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 04:07:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232432AbhCLJHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 04:07:05 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFEDBC061574
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 01:07:04 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id p8so51897363ejb.10
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 01:07:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=WibsGuYCmR5ROef6TpFFTAegptjciVV1wiVGexu3I74=;
        b=ki51h7NpduIxACvNA+ICT9fNV8vDZhLnaO3OuGC4Nowva0kyumANtnOGr9bDTvn+PO
         fYiX+6lwo+UHHDF32GWhjxU9gi8iDa/CCbYgY3tZD3mmVZWb9Jrzq+TI6wf9B6X+10lk
         OinLaQlsQR1ue29EiZNy4Cl3ArHEPJJDZqzcyzgjty8DQWvaKl4tS3MMCUJJySLGM/ci
         xhCih+Tnb5wjOqndToaN954fj1vyOG2q5K1tRAkuMRmPNYtiUa9TtEFDejZKmZCy77rK
         eN3XRz2N8amai18J9XavmHGS+zhbjr07W3j4Yea8TzZ/ljYAIG5gNY02H7uUL/iAArTI
         HMjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=WibsGuYCmR5ROef6TpFFTAegptjciVV1wiVGexu3I74=;
        b=Bzu29Ql7FirSDVhGXznIhQbeQ3y21ok674YzZ/gjGdf1s/idH9bVrb+j/gQ9moSO6s
         7Xxl1uQO8EENkAFqkQRLVGwT05m9AK/fVKJvyrk4KNuL239tpc0chUJYyA8n2YKyks9p
         JlEFVZ+3YEfWraZiSZF/caq8PcM2SsV4EaA4cCj2bFOuR5jGHedyYFB6oKwSWYbt0ReA
         EjnGbyr0exkCexoAKMKFHslVTfnQY7HKVPMaV3yoGqU+kLiOwMH7ZnFQMIg7JzEXR7uz
         Xu4qNjsYOCGTSxqWdYVPoZLbzJo67IIkHvvVhpdRHJ96pHsPXYA1kGteYCI3bWYRwT7L
         ivqA==
X-Gm-Message-State: AOAM532ay83iDEMAbCotsAB0DeWp8mvsT/XGYq6IcIwfTnA5Xf8H7xA3
        uzEVMHYv+CxWqjoLe/vXyhMS2BNYQwOWZult
X-Google-Smtp-Source: ABdhPJz8psTrnSROjRDRj7LHbJmAL5rDTeycCFTfqXEsECDj4WxQKj5Fx7GhgAS6PKAmj//D5tB+gA==
X-Received: by 2002:a17:906:bccc:: with SMTP id lw12mr7367704ejb.268.1615540023299;
        Fri, 12 Mar 2021 01:07:03 -0800 (PST)
Received: from TRWS9215 ([88.245.22.54])
        by smtp.gmail.com with ESMTPSA id b12sm2465598eds.94.2021.03.12.01.07.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 01:07:02 -0800 (PST)
Message-ID: <14878df31817f11528c9326f2855819bcf782721.camel@gmail.com>
Subject: Re: [PATCH] drivers: tty: vt: vt.c: fix NULL dereference crash
From:   Fatih Yildirim <yildirim.fatih@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>,
        Hassan Shahbazi <h.shahbazi.git@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Date:   Fri, 12 Mar 2021 12:07:01 +0300
In-Reply-To: <YEsnYVwzRoEsbkie@kroah.com>
References: <20210307105642.112572-1-h.shahbazi.git@gmail.com>
         <YEsnYVwzRoEsbkie@kroah.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2021-03-12 at 09:33 +0100, Greg KH wrote:
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
> Are you sure this actually fixes the problem?  How did you test
> it?  Did
> syzbot test this?
> 
> I had a few reports of this patch _not_ solving the problem, so
> getting
> confirmation of this would be good.
> 
> thanks,
> 
> greg k-h

Hi,

I've tested the patch on upstream using the .config and the C
reproducer reported by syzbot. It seems that the patch doesn't fix the
issue.

Maybe you can send a patch test request to syzbot to validate the
patch.

Thanks,
Fatih


