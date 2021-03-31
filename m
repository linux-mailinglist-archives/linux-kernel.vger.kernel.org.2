Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E4DE350009
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 14:18:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235388AbhCaMSC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 08:18:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235119AbhCaMRd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 08:17:33 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AFA3C061574
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 05:17:33 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id w3so29773476ejc.4
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 05:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oYv7KV+vPKymp5Vqak7qegS1FdYgShW8DujJwU/0Nzc=;
        b=qCY8iHBJ0GMAog1brwfg3xQhaH1ZeCf0EpHmwcHi47RWQmugLf8srCHHEbS8WXLk5L
         4B8Ao6bC5/g1hnroKaOWWdwYA1SD+szEfYFdWkFbto5OWbxSyAXNg+vEenW2M+BVr8n6
         XW5NnD7OjND04XpXOaio+CnGGpbiBdzY+dECsiO6xAQtLjlwFkcdAyU0N6d8cOAYGm9a
         FOcmip0jdrgBXNO031t/ea+sWmqmG+CpUiNCW3jc4bcN0Ed6JCxUlVKpBQCHYhhwPGQ2
         NnjhfQHy8f0mRm6trEwyNs7hj8LPsPs60VGQNtqd1LcWrgLalCu11li43cM8XwwrrIj8
         /NkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oYv7KV+vPKymp5Vqak7qegS1FdYgShW8DujJwU/0Nzc=;
        b=uE6kgih5AmlWkwIIAql7MJt+VOaAZjzmzmHCYZFwREudWsz16qFWpKKgdG0CaMaqHB
         mIX4OGJ56gtJ2huXxTNp3qyhClGVTXculf9PSK0/KSbnUG7zR7rPgZiFwBVqSIkLu2yt
         BQANx18aydMQ3Gta1mH54WMH+u9cameiWPY1ABubr0Q1UQXypayboIbV/2L2yNaGS3jZ
         TBTppU0EjBXvJUISEB29FTdoTjtndt01VUEpwAhC3VfOnitaTWU51Kr6xIwTw0bdJ2Xk
         OSRzi/ug9xpDIh5OuDnFnm5dKW8zHLSpN3vGuVqoNFvg5WG+TcaMfva531nBbIBPUJ5e
         rQnA==
X-Gm-Message-State: AOAM531cE+3RBKUJNhiU3xwIz1Z7WW71eX3tjQiV1IR0nx57xvKxRl/C
        2bY9WPQR6hUjihqlshR4DXw=
X-Google-Smtp-Source: ABdhPJytrQ1QlerWOFvV2F4sUMUH5OPvcbzXbVV9e5LhkctWLg+7giZd+daod7213IPskQBAnVV8vA==
X-Received: by 2002:a17:907:94cc:: with SMTP id dn12mr3214727ejc.177.1617193052031;
        Wed, 31 Mar 2021 05:17:32 -0700 (PDT)
Received: from agape.jhs ([5.171.81.9])
        by smtp.gmail.com with ESMTPSA id s20sm1103527ejj.38.2021.03.31.05.17.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 05:17:31 -0700 (PDT)
Date:   Wed, 31 Mar 2021 14:17:28 +0200
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     dan.carpenter@oracle.com, joe@perches.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/40] staging: rtl8723bs: replace RT_TRACE with public
 printk wrappers in core/rtw_eeprom.c
Message-ID: <20210331121727.GA1599@agape.jhs>
References: <cover.1617183374.git.fabioaiuto83@gmail.com>
 <39c2cd878bc914a00e71ea988c3cacb651670822.1617183374.git.fabioaiuto83@gmail.com>
 <YGROiD19tgF8XnK6@kroah.com>
 <20210331105551.GB1450@agape.jhs>
 <YGRZilreNqCdsLCE@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YGRZilreNqCdsLCE@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 31, 2021 at 01:14:18PM +0200, Greg KH wrote:
> On Wed, Mar 31, 2021 at 12:55:51PM +0200, Fabio Aiuto wrote:
> > On Wed, Mar 31, 2021 at 12:27:20PM +0200, Greg KH wrote:
> > > On Wed, Mar 31, 2021 at 11:39:31AM +0200, Fabio Aiuto wrote:
> > > > replace private macro RT_TRACE for tracing with in-kernel
> > > > pr_* printk wrappers
> > > > 
> > > > Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
> > > > ---
> > > >  drivers/staging/rtl8723bs/core/rtw_eeprom.c | 26 ++++++++++-----------
> > > >  1 file changed, 13 insertions(+), 13 deletions(-)
> > > > 
> > > > diff --git a/drivers/staging/rtl8723bs/core/rtw_eeprom.c b/drivers/staging/rtl8723bs/core/rtw_eeprom.c
> > > > index 3cbd65dee741..6176d741d60e 100644
> > > > --- a/drivers/staging/rtl8723bs/core/rtw_eeprom.c
> > > > +++ b/drivers/staging/rtl8723bs/core/rtw_eeprom.c
> > > > @@ -36,7 +36,7 @@ void shift_out_bits(_adapter *padapter, u16 data, u16 count)
> > > >  _func_enter_;
> > > >  
> > > >  	if (padapter->bSurpriseRemoved == true) {
> > > > -		RT_TRACE(_module_rtl871x_eeprom_c_, _drv_err_, ("padapter->bSurpriseRemoved==true"));
> > > > +		pr_err("%s padapter->bSurpriseRemoved==true", DRIVER_PREFIX);
> > > 
> > > As Dan said, this is not the same thing.  You are now always printing
> > > out this mess, when before you were not unless you explicitly enabled
> > > "tracing".
> > 
> > RT_TRACE is enabled if is defined the symbol DEBUG_RTL871X. It doesn't seem to be related 
> > to tracing. DEBUG_RTL871X is never declared, is commented out in rtl8723bs/include/autoconf.h
> 
> That's a good sign this is never used and should just all be removed.
> 
> > that's why RT_TRACE is never printed. If we try to uncomment the symbol definition we have some
> > comiling errors..
> 
> What errors do you get?

If I declare DEBUG and DEBUG_RTL871X to activate private tracing..

diff --git a/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c b/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c
index 9b16265b543d..f84e0e54cc9c 100644
--- a/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c
+++ b/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c
@@ -1717,7 +1717,7 @@ s8 phy_get_tx_pwr_lmt(struct adapter *adapter, u32 reg_pwr_tbl_sel,
 	idx_rate_sctn = get_rate_sctn_idx(data_rate);
 
 	if (band_type == BAND_ON_5G && idx_rate_sctn == 0)
-		DBG_871X("Wrong rate 0x%x: No CCK in 5G Band\n", DataRate);
+		DBG_871X("Wrong rate 0x%x: No CCK in 5G Band\n", data_rate);

here I have to fix a variable name -----------------------------------^
to let the code compile.

but it won't compile yet, there are more of those errors, in both DBG_871X and
RT_TRACE macro.

 
 	/*  workaround for wrong index combination to obtain tx power limit, */
 	/*  OFDM only exists in BW 20M */
diff --git a/drivers/staging/rtl8723bs/include/autoconf.h b/drivers/staging/rtl8723bs/include/autoconf.h
index 996198750814..bece2ed1ef88 100644
--- a/drivers/staging/rtl8723bs/include/autoconf.h
+++ b/drivers/staging/rtl8723bs/include/autoconf.h
@@ -45,10 +45,10 @@
  * Debug Related Config
  */
 #undef DEBUG
-
+#define DEBUG
 #ifdef DEBUG
 #define DBG	1	/*  for ODM & BTCOEX debug */
-/*#define DEBUG_RTL871X */
+#define DEBUG_RTL871X 
 #else /*  !DEBUG */
 #define DBG	0	/*  for ODM & BTCOEX debug */
 #endif /*  !DEBUG */

^^^^^^^^^^^^^^^^^------------here hand declaration to reproduce
				compiling errors


> 
> > > And you are sending it to the error log?
> > > 
> > > And finally, drivers should never be using pr_*() for messages, they
> > > should be using dev_*() instead as they are a driver and have access to
> > > a device pointer.
> > > 
> > > thanks,
> > > 
> > > greg k-h
> > 
> > I still wonder what's best...
> 
> Just delete them all please, they are obviously not used as no one
> rebuilds the source just for this type of thing.
> 
> thanks,
> 
> greg k-h

ok I will delete all RT_TRACE call, and even DBG_871X if you agree...

thank you,

fabio
