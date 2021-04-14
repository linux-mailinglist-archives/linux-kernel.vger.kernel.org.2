Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3CC535ED40
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 08:34:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349229AbhDNGeT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 02:34:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231831AbhDNGeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 02:34:18 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03E4DC061574
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 23:33:57 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id mh2so8096875ejb.8
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 23:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lM9tE4YP45dEebvaB1mn9Fj0H0g1RisXEtTq0o0OVEg=;
        b=CnRNwfJWtnIxInVYy3BheuUuKlU/mLd0foWWQrwKR3EJVfzoxafwDXdLhuh2FT6ekj
         eRHZkZVCs+EaW9aO45cwqvr/LvEgoDS+nuGRokvGpLMWz2k4eqPNFM4QjZ0XUrblF6uj
         EVxPtJUFyp1xy1OqpazRyNeSWqQBRSyStD0FifqOsEt/dk6SuUlOAQf7ZwAtxFQsiASn
         4UYqdjcnEmg/DEePZwdLxh0CFQCayzUKQ2sVM2Cc27iHsgQNTffhZ0NaI9L5zCvaanZF
         imQt3KHAGDNpmGS9wjIeTgnTf0A86mG/GD9w2tmWB5TPFYcKiSeed67ueSVniba188/o
         xOXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lM9tE4YP45dEebvaB1mn9Fj0H0g1RisXEtTq0o0OVEg=;
        b=D1yUekn9k/AEFU75tpXQRNcAAT8003oKtokqIbFKpGSEqkLG+BqFksfgFZrgBLUsCs
         5QxYYI1kYPcpKVC9vO34XNZeUcqCl6c95Ih95+x/yEnqw2yeeGVuIp1qil+72egsadJZ
         d8WVn0qAayJOGeoXXxOAlBv4zqgp+tXnWD2wEXlJDZcXQQOeXk4dTHVWx7L7AO+Nocpi
         mbXiSK0sYcDtyYA7mDzBnlCdXRj4dMjlljdpmf9fxC2Jvmp4ZtYw59yyvObgWC3FPF1U
         lRPYGfbP9XceV5S5nNGIQDwytDf9xdoFC0mugMC9EvZDKNB2ZPgtNPAg/EWMsNx1nqtY
         8Dfw==
X-Gm-Message-State: AOAM532c2fyX4911znAWEwkOnQZZ+iien3OzVeMtxYjjd1aI+kOrgQo4
        ubnSZaGlDYoZScrNJOmhiLA=
X-Google-Smtp-Source: ABdhPJys+cocbe6bRomQGIukA/bEx/YGlcSGCKLpsH1p4sKjSUD3v93yKLd0W0nCDUyFxnIVMzbbVw==
X-Received: by 2002:a17:906:f8d7:: with SMTP id lh23mr10907676ejb.77.1618382030493;
        Tue, 13 Apr 2021 23:33:50 -0700 (PDT)
Received: from linux.local (host-95-237-55-30.retail.telecomitalia.it. [95.237.55.30])
        by smtp.gmail.com with ESMTPSA id u13sm9263724ejj.16.2021.04.13.23.33.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 23:33:49 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Julia Lawall <julia.lawall@inria.fr>,
        outreachy-kernel@googlegroups.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [Outreachy kernel] [PATCH] :staging: rtl8723bs: Remove useless led_blink_hdl()
Date:   Wed, 14 Apr 2021 08:33:48 +0200
Message-ID: <2418632.vfNx7fMs9o@linux.local>
In-Reply-To: <20210414052150.GO6021@kadam>
References: <20210413155908.8691-1-fmdefrancesco@gmail.com> <3505455.GpAHCVcAZI@linux.local> <20210414052150.GO6021@kadam>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, April 14, 2021 7:21:50 AM CEST Dan Carpenter wrote:
> On Tue, Apr 13, 2021 at 10:08:32PM +0200, Fabio M. De Francesco wrote:
> > On Tuesday, April 13, 2021 9:48:44 PM CEST Matthew Wilcox wrote:
> > > On Tue, Apr 13, 2021 at 09:45:03PM +0200, Fabio M. De Francesco 
wrote:
> > > > 1) The driver doesn't call that function from anywhere else than
> > > > the
> > > > macro. 2) You have explained that the macro add its symbol to a
> > > > slot
> > > > in an array that would shift all the subsequent elements down if
> > > > that
> > > > macro is not used exactly in the line where it is.
> > > > 3) Dan Carpenter said that that array is full of null functions (or
> > > > empty slots?).
> > > > 
> > > > Unless that function is called anonymously dereferencing its
> > > > address
> > > > from the position it occupies in the array, I'm not able to see
> > > > what
> > > > else means can any caller use.
> > > > 
> > > > I know I have much less experience than you with C: what can go
> > > > wrong?
> > > 
> > > Here's where the driver calls that function:
> > > 
> > > $ git grep wlancmds drivers/staging/rtl8723bs/
> > > drivers/staging/rtl8723bs/core/rtw_cmd.c:static struct cmd_hdl
> > > wlancmds[] = { drivers/staging/rtl8723bs/core/rtw_cmd.c:            
> > >   if
> > > (pcmd->cmdcode < ARRAY_SIZE(wlancmds)) {
> > > drivers/staging/rtl8723bs/core/rtw_cmd.c:                      
> > > cmd_hdl
> > > = wlancmds[pcmd->cmdcode].h2cfuns;
> > 
> > OK, I had imagined an anonymous call from its location in the array (as
> > I wrote in the last phrase of my message). However, I thought that it
> > could have been an improbable possibility, not a real one.
> > 
> > Linux uses a lot of interesting ideas that newcomers like me should
> > learn. Things here are trickier than they appear at first sight.
> 
> One trick would be to build the Smatch cross function database.
> 
> https://www.spinics.net/lists/smatch/msg00568.html
> 
> Then you could do:
> 
> $ ~/path/to/smatch_data/db/smdb.py led_blink_hdl
> file | caller | function | type | parameter | key | value |
> drivers/staging/rtl8723bs/core/rtw_cmd.c |       rtw_cmd_thread |
> rtw_cmd_thread ptr cmd_hdl |           INTERNAL | -1 |                 |
> uchar(*)(struct adapter*, uchar*)
> drivers/staging/rtl8188eu/core/rtw_cmd.c |       rtw_cmd_thread |
> rtw_cmd_thread ptr cmd_hdl |           INTERNAL | -1 |                 |
> uchar(*)(struct adapter*, uchar*)
> drivers/staging/rtl8188eu/core/rtw_cmd.c |       rtw_cmd_thread |
> rtw_cmd_thread ptr cmd_hdl |           BUF_SIZE |  1 |            pbuf |
> 1,4,6,8,12,14,16,19-20,23-24,48,740,884,892,900,960
> 
> 
> Which says that led_blink_hdl() is called as a function pointer called
> "cmd_hdl" from rtw_cmd_thread().
> 
> Hm...  It says it can be called from either rtw_cmd_thread() function
> (the rtl8723bs or rtl8188eu version) which is not ideal.  But also
> basically harmless so whatever...
> 
> regards,
> dan carpenter
>
Nice tool, thanks. I'll surely use it when it is needed to find out which  
callers use a function pointer.

However I cannot see how it can help in this context. That function *does* 
something, even if I cannot understand why someone needs a function to test 
the initialization of a pointer. Furthermore it is actually called by 
rtw_cmd_thread() (as you found out by using smatch) that expect one of the 
two possible values that led_blink_hdl() returns.

That said, what trick could I use for the purpose of getting rid of that 
function? At this point I'm not sure it could be made.

Regards,

Fabio
 






