Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0086035F7F3
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 17:48:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350268AbhDNPhV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 11:37:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343889AbhDNPhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 11:37:20 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68F64C061574
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 08:36:57 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id sd23so23437375ejb.12
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 08:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=f1Y5+4VG6CJZgdx4UWOh8zx7QoiyJatpZDoj3QFWUTQ=;
        b=piifReYeJ7FkLTHElIuXKecxeioDin2ZIZeegb8sFHRXjwXt1JAz67On69HayK6LXp
         WXnsqQdz0qMTdsYaz13CI4Ps5BUZMZoSo+ctENjK/Msqg3CfNLwgy1l0yGqQX0h3RXr/
         bar7RE5EEh7Om2DAWmBxCbhpHXRQQvpp0WGF7W+UiN3onvUnaYrGza5MqgJL4vQ2xwrm
         UF23oOWmUZWXUvuCSV8Vv+PwJJ6l2bHk8N/LurpMl9GqeGYxZJl+M89fltT0zEin7GUW
         7yjZkoUHPaefPgIiBu8hKc54YgcQExl6vbEdxrwHPGepZyWC7NlIXAyvR07dtK8dQaoG
         G0rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f1Y5+4VG6CJZgdx4UWOh8zx7QoiyJatpZDoj3QFWUTQ=;
        b=fhbZkYUpYAmK2PYTRKjkhGiL45yeoCsDTHjcfQWZzoshHAKg1w/+2WTQZ0seF5EQU0
         ZL7T3s8lZEQgiHPTRVooQLQfGSXcjeF6mg3bPVr9p/HYNHSHcS/oiMI/GF1i6hq6/+Za
         2dhIfkx11wCxksxUEPYJSXHY9FsazHzV3OsYyS7bgXQOy/zIiyVlThQ8jf4fXxotWlCM
         gCtxxW+wfNT4b2FOlam/xJhU2Q4n4tYyc4yB76Oir7xINP61HU7Er+JG0nBxZfw385nf
         WQ7ojPL+DVaIo4rM0AcKrHEb6PY3NS/hwqdQiworUwuWP5lKyiY/QG0qL4eTstRsBtgD
         mxXA==
X-Gm-Message-State: AOAM532NRCtUFZtDtdNS1s4XC2zZytvXTb6+rwn3XoKpO7/3aebUQiGz
        EN8DYbt1iY7Ya0NR1SQPItY=
X-Google-Smtp-Source: ABdhPJz/ztdQYwfO6w1xd3uWCzCPiq1t76zGTPKMWBjS1uCJxfpa/klwJrm+tbjyMWJ5of0/aiFt+Q==
X-Received: by 2002:a17:907:629e:: with SMTP id nd30mr38150830ejc.407.1618414616155;
        Wed, 14 Apr 2021 08:36:56 -0700 (PDT)
Received: from linux.local (host-95-237-55-30.retail.telecomitalia.it. [95.237.55.30])
        by smtp.gmail.com with ESMTPSA id t1sm12190317eds.53.2021.04.14.08.36.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 08:36:55 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     outreachy-kernel@googlegroups.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        Julia Lawall <julia.lawall@inria.fr>
Subject: Re: [Outreachy kernel] [PATCH] staging: rtl8723bs: Remove useless led_blink_hdl()
Date:   Wed, 14 Apr 2021 17:36:54 +0200
Message-ID: <4318909.BRL0aILv4p@linux.local>
In-Reply-To: <20210414132414.GE6048@kadam>
References: <20210414115243.32716-1-fmdefrancesco@gmail.com> <20210414132414.GE6048@kadam>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, April 14, 2021 3:24:14 PM CEST Dan Carpenter wrote:
> On Wed, Apr 14, 2021 at 01:52:43PM +0200, Fabio M. De Francesco wrote:
> > Removed the led_blink_hdl() function (declaration and definition).
> > Declared dummy_function() in include/rtw_mlme_ext.h and defined it in
> > core/rtw_cmd.c. Changed the second parameter of GEN_MLME_EXT_HANDLER
> > macro to make use of dummy_function().
> > 
> > Reported-by: Julia Lawall <julia.lawall@inria.fr>
> > Suggested-by: Dan Carpenter <dan.carpenter@oracle.com>
> > Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> > ---
> > 
> >  drivers/staging/rtl8723bs/core/rtw_cmd.c         | 4 +++-
> >  drivers/staging/rtl8723bs/core/rtw_mlme_ext.c    | 9 ---------
> >  drivers/staging/rtl8723bs/include/rtw_mlme_ext.h | 3 ++-
> >  3 files changed, 5 insertions(+), 11 deletions(-)
> > 
> > diff --git a/drivers/staging/rtl8723bs/core/rtw_cmd.c
> > b/drivers/staging/rtl8723bs/core/rtw_cmd.c index
> > 0297fbad7bce..7b6102a2bb2c 100644
> > --- a/drivers/staging/rtl8723bs/core/rtw_cmd.c
> > +++ b/drivers/staging/rtl8723bs/core/rtw_cmd.c
> > @@ -87,6 +87,8 @@ static struct _cmd_callback rtw_cmd_callback[] = {
> > 
> >  	{GEN_CMD_CODE(_RunInThreadCMD), NULL},/*64*/
> >  
> >  };
> > 
> > +u8 dummy_functioni(struct adapter *var0, u8 *var1) { return 0; }
> > +
> > 
> >  static struct cmd_hdl wlancmds[] = {
> >  
> >  	GEN_DRV_CMD_HANDLER(0, NULL) /*0*/
> >  	GEN_DRV_CMD_HANDLER(0, NULL)
> > 
> > @@ -150,7 +152,7 @@ static struct cmd_hdl wlancmds[] = {
> > 
> >  	GEN_MLME_EXT_HANDLER(0, h2c_msg_hdl) /*58*/
> >  	GEN_MLME_EXT_HANDLER(sizeof(struct SetChannelPlan_param),
> >  	set_chplan_hdl) /*59*/> 
> > -	GEN_MLME_EXT_HANDLER(sizeof(struct LedBlink_param), 
led_blink_hdl)
> > /*60*/ +	GEN_MLME_EXT_HANDLER(sizeof(struct LedBlink_param),
> > dummy_function) /*60*/
> No, no.  Don't create a dummy function. Do it like so:
> 
> 	GEN_DRV_CMD_HANDLER(0, NULL) /* 60 */
> 
> regards,
> dan carpenter
>
I'm replying late because I didn't want to blindly use that solution; I 
mean that I wanted to understand why I can simply put 0 and NULL into that 
macro. I had seen it made in other lines that initialize wlancmds[] 
elements, but I wasn't sure if it could work for the specific slot where 
the pointer to led_blinck_hdl was supposed to be placed.

Now I think that it is why, in this case, cmd_hdl would be set to NULL by 
the call to wlancmds[pcmd->cmdcode].h2cfuns and the cmd_hdl() function 
wouldn't be called because cmd_hdl is tested within an "if" statement.

Therefore a simple GEN_DRV_CMD_HANDLER(0, NULL) at slot number would be the 
simplest and most obvious solution.

Is the above argument sound?

Thanks for your kind help,

Fabio



