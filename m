Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A332A35FA39
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 20:07:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351955AbhDNSG0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 14:06:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237770AbhDNSGZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 14:06:25 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D2BCC061574
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 11:06:02 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id l4so32751104ejc.10
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 11:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=T7wAnr/gJYaABznT6fzPw36DcxU7yZSqfUQF8WwNLo8=;
        b=EwzB6QAacn/mbirKbhS1czQH4EG6r34NUMNKPmtniN48MdVyipYWQfnfs/3K4GkqtK
         wgzAdqi7/47/LHooFNvulal0JLYFNFcUyzi3cE9uxslaLg4GRneHlWejzcSFA/8uOgKf
         7BJv3WTxITqE2KjvG+CI+L+2ICa48LiHJ6WQRazeL+FIzMvScWMUw/ROioTt0uV+lJhN
         e+TYdFpGl6MAc4OUO6hr0rMkMgwj9w0mY5qY3U4mKkNMMDL+AuTxvDBgp+QCoV1uAw6M
         4oT/kq7j76zZA0MMdFMVtP/DHYzNmW8Rpdgs8sqKQ287hEO+Z9tGTlk2NVFPVYM76xAF
         bojg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T7wAnr/gJYaABznT6fzPw36DcxU7yZSqfUQF8WwNLo8=;
        b=D2ZTPB3gCghedIrVsc40PZSJNFzAUKBloZhO8IPYNbK5Q6+tAphrvu6iyMGVM6u512
         WRdgNwvG/TLD0JLhRn4K7Ne77y9onKieDJHDTdC/8QgXWGxryZTBL+l09BqZK+VN+hoS
         qaAOA4xVOlOnquapXZyBW7VCDeuT7/SJb8o+gwUGLuYG/cy40qbGTNT9UGu5mMbX9u3c
         vf/IPtK+C8MC0wldwTl65HPoxUY0jf7/1iMhjkDkGPSoe7J8MYrb5l06BWtUD2iZpQLh
         VAR9jRE4xYqlhGTExw4v8WbpZI9MS/6WVG3WKJSEjjV6XIGtH0X1TVQ8iZG9SUNftsh4
         zR9g==
X-Gm-Message-State: AOAM532ye4DHC3gY96akbIfQnOD06LmPP8LjvHJ66qfExHhdXNd12How
        vOQLAlhW/dwQ9J0wShz6sK4=
X-Google-Smtp-Source: ABdhPJz7jRQXrsM9+YGvwXMSpxqKfK538x0frrzj4SwPexIDJ2Bnn6nczDa6RNYuyvPUlz/G8u394w==
X-Received: by 2002:a17:906:f759:: with SMTP id jp25mr140120ejb.228.1618423561145;
        Wed, 14 Apr 2021 11:06:01 -0700 (PDT)
Received: from linux.local (host-95-237-55-30.retail.telecomitalia.it. [95.237.55.30])
        by smtp.gmail.com with ESMTPSA id t1sm254377eds.53.2021.04.14.11.06.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 11:06:00 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     outreachy-kernel@googlegroups.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Julia Lawall <julia.lawall@inria.fr>
Subject: Re: [Outreachy kernel] [PATCH v2] staging: rtl8723bs: Remove useless led_blink_hdl()
Date:   Wed, 14 Apr 2021 20:05:59 +0200
Message-ID: <7427098.3VjF5iJQtU@linux.local>
In-Reply-To: <YHcs70RdhaBBZv0i@kroah.com>
References: <20210414162614.14867-1-fmdefrancesco@gmail.com> <20210414174809.GX6021@kadam> <YHcs70RdhaBBZv0i@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, April 14, 2021 7:57:03 PM CEST Greg Kroah-Hartman wrote:
> On Wed, Apr 14, 2021 at 08:48:09PM +0300, Dan Carpenter wrote:
> > On Wed, Apr 14, 2021 at 07:00:41PM +0200, Greg Kroah-Hartman wrote:
> > > On Wed, Apr 14, 2021 at 06:26:14PM +0200, Fabio M. De Francesco 
wrote:
> > > > Removed useless led_blink_hdl() prototype and definition. In
> > > > wlancmds[]
> > > > the slot #60 is now set to NULL using the macro
> > > > GEN_MLME_EXT_HANDLER. This change has not unwanted side effects
> > > > because the code in rtw_cmd.c checks if the function pointer is
> > > > valid before using it.
> > > > 
> > > > Reported-by: Julia Lawall <julia.lawall@inria.fr>
> > > > Suggested-by: Dan Carpenter <dan.carpenter@oracle.com>
> > > > Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> > > > ---
> > > > 
> > > > Changes since v1: Corrected a bad solution to this issue that made
> > > > use of an unnecessary dummy function.
> > > > 
> > > >  drivers/staging/rtl8723bs/core/rtw_cmd.c         | 2 +-
> > > >  drivers/staging/rtl8723bs/core/rtw_mlme_ext.c    | 9 ---------
> > > >  drivers/staging/rtl8723bs/include/rtw_mlme_ext.h | 1 -
> > > >  3 files changed, 1 insertion(+), 11 deletions(-)
> > > > 
> > > > diff --git a/drivers/staging/rtl8723bs/core/rtw_cmd.c
> > > > b/drivers/staging/rtl8723bs/core/rtw_cmd.c index
> > > > 0297fbad7bce..f82dbd4f4c3d 100644
> > > > --- a/drivers/staging/rtl8723bs/core/rtw_cmd.c
> > > > +++ b/drivers/staging/rtl8723bs/core/rtw_cmd.c
> > > > @@ -150,7 +150,7 @@ static struct cmd_hdl wlancmds[] = {
> > > > 
> > > >  	GEN_MLME_EXT_HANDLER(0, h2c_msg_hdl) /*58*/
> > > >  	GEN_MLME_EXT_HANDLER(sizeof(struct SetChannelPlan_param),
> > > >  	set_chplan_hdl) /*59*/> > > 
> > > > -	GEN_MLME_EXT_HANDLER(sizeof(struct LedBlink_param),
> > > > led_blink_hdl) /*60*/ +	GEN_MLME_EXT_HANDLER(0, NULL) /*60*/
> > > 
> > > Better, but you really do not need to keep this here, right?  Remove
> > > the
> > > "led blink command" entirely, you didn't do that here.
> > 
> > No, this is right.  We have to put a NULL function pointer in the array
> > or the indexing will be off.  But Fabio is correct that the struct
> > type should be removed.
> 
> The indexing can be off, just remove the other place where the "command"
> is in the index and all is good as rebuilding will fix it.  These are
> not external "values" we have to keep stable.
> 
> This has been done for other drivers exactly like this, there are loads
> of "odd" commands in there that should not be.
> 
> thanks,
> 
> greg k-h
I'm not sure if this task is so close related to deserve a v3 or if I 
should make a new v1 patch with a different "Subject".

Thanks,

Fabio




