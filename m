Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8254835FAC6
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 20:43:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234421AbhDNSZZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 14:25:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233369AbhDNSZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 14:25:22 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BE73C061574
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 11:25:01 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id m3so24876905edv.5
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 11:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FJgpVpnm59KDS8nnKfjN27Nq3KwrEWqv8OFg6Lc4YJw=;
        b=ZgcjIvGgXnZrjotUEbeEHSlhNMutTh2BNSvbuTopkKY8r7G3Yc2o5Aka5ZSzThp/Ic
         x+KYKBnWmRQgpkx6N3PTTF+5fqK7UEpyUuFFQkRgHUx22cZZ8DdcnpeR5npwtJm0f8zo
         9lBMt7QXIIjBL0PeTVxF2t9Xmz3ezKEToR4goabJzF7WoLQjC+t3CDTu6z6J7/LIxrVe
         d/S386LaiOGR2lTV9mSe9AKkqXoonXf6V5KtdLEQmAd4NdNP6umneNMyhqdaNWYY+i7h
         GGBSMpL7fVh54Eby4hfzf0qbfZD98fzLLzsu6IgfpDIPhMK5TaDlexwJdD69mq68yxkW
         rSHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FJgpVpnm59KDS8nnKfjN27Nq3KwrEWqv8OFg6Lc4YJw=;
        b=IXAi2LAwk5LxQ7tzV1xqUDI7/ue79st93AcViok9ASFk2epolY9D1OtgP/43XSG7fo
         ElV4BJvjsFHCpMPNSMiR217limZul/d50eZkvZ8UKVFpKlwgugpg3Kefq4jMg/GqkbqN
         +mTKr3w34oiAJG9KNX3/dNETCrSUCk9Qslxqzf0zIB8U8BMZNIcf+mmUkQvu9Zr1Yndp
         UfBH9Z8Hmn3N+8wIWzxPnQD1pJ28EBaejhxsOrh4t6yLZefQANUzL1mMGIKurOeHk4wu
         LkDiJYPHCQ+HdBO3WvGSnGNR19EACapjNr2y3DHuEkc71IEDfm/hEXlS0y3+88pgVf3J
         2/xw==
X-Gm-Message-State: AOAM531kL3oahsIym+rltlpoaCrkL4lAkqyc5eXWPRGhWbEKa7z4X7ms
        zSwePPLv+BXOGtSMWvNwTOQ=
X-Google-Smtp-Source: ABdhPJwcfsVDj6JXMsjkgrz5PpPpYcJgWaqp6S9WoNZZ8u39YQ8ObqA+XYrUrTunr3VGUCINwL/zeA==
X-Received: by 2002:a50:c004:: with SMTP id r4mr253319edb.192.1618424699994;
        Wed, 14 Apr 2021 11:24:59 -0700 (PDT)
Received: from linux.local (host-95-237-55-30.retail.telecomitalia.it. [95.237.55.30])
        by smtp.gmail.com with ESMTPSA id ws15sm186274ejb.38.2021.04.14.11.24.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 11:24:59 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     outreachy-kernel@googlegroups.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Julia Lawall <julia.lawall@inria.fr>
Subject: Re: [Outreachy kernel] [PATCH v2] staging: rtl8723bs: Remove useless led_blink_hdl()
Date:   Wed, 14 Apr 2021 20:24:58 +0200
Message-ID: <3820176.uhjs84E3K9@linux.local>
In-Reply-To: <7427098.3VjF5iJQtU@linux.local>
References: <20210414162614.14867-1-fmdefrancesco@gmail.com> <YHcs70RdhaBBZv0i@kroah.com> <7427098.3VjF5iJQtU@linux.local>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, April 14, 2021 8:05:59 PM CEST Fabio M. De Francesco wrote:
> On Wednesday, April 14, 2021 7:57:03 PM CEST Greg Kroah-Hartman wrote:
> > On Wed, Apr 14, 2021 at 08:48:09PM +0300, Dan Carpenter wrote:
> > > On Wed, Apr 14, 2021 at 07:00:41PM +0200, Greg Kroah-Hartman wrote:
> > > > On Wed, Apr 14, 2021 at 06:26:14PM +0200, Fabio M. De Francesco
> 
> wrote:
> > > > > Removed useless led_blink_hdl() prototype and definition. In
> > > > > wlancmds[]
> > > > > the slot #60 is now set to NULL using the macro
> > > > > GEN_MLME_EXT_HANDLER. This change has not unwanted side effects
> > > > > because the code in rtw_cmd.c checks if the function pointer is
> > > > > valid before using it.
> > > > > 
> > > > > Reported-by: Julia Lawall <julia.lawall@inria.fr>
> > > > > Suggested-by: Dan Carpenter <dan.carpenter@oracle.com>
> > > > > Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> > > > > ---
> > > > > 
> > > > > Changes since v1: Corrected a bad solution to this issue that
> > > > > made
> > > > > use of an unnecessary dummy function.
> > > > > 
> > > > >  drivers/staging/rtl8723bs/core/rtw_cmd.c         | 2 +-
> > > > >  drivers/staging/rtl8723bs/core/rtw_mlme_ext.c    | 9 ---------
> > > > >  drivers/staging/rtl8723bs/include/rtw_mlme_ext.h | 1 -
> > > > >  3 files changed, 1 insertion(+), 11 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/staging/rtl8723bs/core/rtw_cmd.c
> > > > > b/drivers/staging/rtl8723bs/core/rtw_cmd.c index
> > > > > 0297fbad7bce..f82dbd4f4c3d 100644
> > > > > --- a/drivers/staging/rtl8723bs/core/rtw_cmd.c
> > > > > +++ b/drivers/staging/rtl8723bs/core/rtw_cmd.c
> > > > > @@ -150,7 +150,7 @@ static struct cmd_hdl wlancmds[] = {
> > > > > 
> > > > >  	GEN_MLME_EXT_HANDLER(0, h2c_msg_hdl) /*58*/
> > > > >  	GEN_MLME_EXT_HANDLER(sizeof(struct SetChannelPlan_param),
> > > > >  	set_chplan_hdl) /*59*/> > >
> > > > > 
> > > > > -	GEN_MLME_EXT_HANDLER(sizeof(struct LedBlink_param),
> > > > > led_blink_hdl) /*60*/ +	GEN_MLME_EXT_HANDLER(0, NULL) /
*60*/
> > > > 
> > > > Better, but you really do not need to keep this here, right? 
> > > > Remove
> > > > the
> > > > "led blink command" entirely, you didn't do that here.
> > > 
> > > No, this is right.  We have to put a NULL function pointer in the
> > > array
> > > or the indexing will be off.  But Fabio is correct that the struct
> > > type should be removed.
> > 
> > The indexing can be off, just remove the other place where the
> > "command"
> > is in the index and all is good as rebuilding will fix it.  These are
> > not external "values" we have to keep stable.
> > 
> > This has been done for other drivers exactly like this, there are loads
> > of "odd" commands in there that should not be.
> > 
> > thanks,
> > 
> > greg k-h
> 
> I'm not sure if this task is so close related to deserve a v3 or if I
> should make a new v1 patch with a different "Subject".
> 
> Thanks,
> 
> Fabio
I'll make a v3 series, submitting this patch again (as 1/2) and adding the 
above-mentioned changes in another one (as 2/2).

Fabio


