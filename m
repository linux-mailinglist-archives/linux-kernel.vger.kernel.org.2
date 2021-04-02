Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFA3F352879
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 11:19:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234959AbhDBJTA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 05:19:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234430AbhDBJS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 05:18:59 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE720C0613E6
        for <linux-kernel@vger.kernel.org>; Fri,  2 Apr 2021 02:18:57 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id kt15so6598038ejb.12
        for <linux-kernel@vger.kernel.org>; Fri, 02 Apr 2021 02:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Go+nOYmjItOdLHaRSwqz52JDspIO1NEPVs2X7x6Gm1w=;
        b=Kga+SD/wMiFC5TDw4Welm/bMQU8At4LdonfUlxfFEC0KwjQDOB+F2oxi5X459MUbyn
         b6nTmzrnee04y9rCcpWTG3lT1MOPCRs1onp3h/3ZPFNkTWE2iqTOn74tZu9Ri7tm4/Yo
         O1KjkfSWek4y7JUhva3RbPiWTz8y/+7wFUS2pvKPRjjxDwfJQk3/Zd3gjjKar//yaFFY
         yRxTNcPVNHcroN4qxAEtmGgFTbSTAompw3EoPQcbDpI/y26SUAIgUKJCUgMq7ZOOChaL
         dYdhZmtWy8UI7K9UiHfXqEQWv84EoLkz86DHudfNjJEgs+SxNSYMIfOpPTjUeMKWmcXW
         iamw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Go+nOYmjItOdLHaRSwqz52JDspIO1NEPVs2X7x6Gm1w=;
        b=rNE9w5as2t9/VNhHbn7sTl17NHThmGGjQkFxQYCzmQ4rlYOia3KPRAPjvElE5k0pLL
         M/rrc9ixd2ZtI5fsquT2/0AyO6dOEoVqv2IsqI0nvlDkTSgRwgMC+Zs5EXgCxXflCVPK
         s7li1v2Gzt4GezDPp0a3cT/PbyT8ECUUDWP5hnLpAI0TwUg9a0mtsNisU+g6dW+sEccq
         YkCxufvLhG3uSvA3D99jlSsv0hdxb+hze4TIHPIEvZZBJU9iUjQRVTug67B5lJlC1rsg
         6iDpKkSGDDJwyCBNF0DiWNLO8YBM1LBK9TVkdj8B+CpfRTYyB3zu0dX/uSItEjwJXMNL
         5E8w==
X-Gm-Message-State: AOAM530cHkcujbigUmusKgHsBo2zq28boh38veNeTjzMg07KCK6GXB2a
        ACmbw3PlKQXYuTCO1RDxpUiMzMWjC+w=
X-Google-Smtp-Source: ABdhPJzWQ4ISQZC/ax8+lpRbleVx+bMb7pUiDAsLmOTPYK1U+uDZ3BNA1QvbJ8Thllhjoq1Uy1MtCw==
X-Received: by 2002:a17:906:5203:: with SMTP id g3mr12733271ejm.95.1617355136459;
        Fri, 02 Apr 2021 02:18:56 -0700 (PDT)
Received: from agape.jhs ([5.171.72.128])
        by smtp.gmail.com with ESMTPSA id v25sm5084428edr.18.2021.04.02.02.18.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Apr 2021 02:18:56 -0700 (PDT)
Date:   Fri, 2 Apr 2021 11:18:53 +0200
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     gregkh@linuxfoundation.org, joe@perches.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/49] staging: rtl8723bs: remove RT_TRACE logs in
 core/rtw_cmd.c
Message-ID: <20210402091852.GA1406@agape.jhs>
References: <cover.1617268327.git.fabioaiuto83@gmail.com>
 <7f51432d99459d79742639341f107115f0c224c5.1617268327.git.fabioaiuto83@gmail.com>
 <20210401095017.GR2065@kadam>
 <20210401135536.GA1691@agape.jhs>
 <20210401143235.GV2065@kadam>
 <20210401215114.GA15992@agape.jhs>
 <20210402081420.GU2088@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210402081420.GU2088@kadam>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 02, 2021 at 08:14:20AM +0000, Dan Carpenter wrote:
> On Thu, Apr 01, 2021 at 11:51:15PM +0200, Fabio Aiuto wrote:
> > On Thu, Apr 01, 2021 at 05:32:36PM +0300, Dan Carpenter wrote:
> > > On Thu, Apr 01, 2021 at 03:55:37PM +0200, Fabio Aiuto wrote:
> > > > 
> > > > Hi Dan,
> > > > 
> > > > I have the following:
> > > > 
> > > >  	if (rtw_createbss_cmd(adapter) != _SUCCESS)
> > > > -		RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("Error =>rtw_createbss_cmd status FAIL\n"));
> > > > +	;
> > > > 
> > > > will I leave
> > > > 
> > > > 	if (rtw_createbss_cmd(adapter) != _SUCCESS)
> > > > 		;
> > > > 
> > > > or just
> > > > 
> > > > 	rtw_createbss_cmd(adapter);
> > > > 
> > > > ?
> > > > 
> > > > what's best from the static analysis point of view?
> > > > 
> > > > smatch and sparse says nothing about that.
> > > 
> > > rtw_createbss_cmd() can only fail if this allocation fails:
> > > 
> > > 	pcmd = rtw_zmalloc(sizeof(struct cmd_obj));
> > > 
> > > In current kernels, that size of small allocation will never fail.  But
> > > we alway write code as if every allocation can fail.
> > > 
> > > Normally when an allocation fails then we want to return -ENOMEM and
> > > clean up.  But this code is an event handler for firmware events and
> > > there isn't any real clean up to do.  Since there is nothing we can do
> > > then this is basically working and fine.
> > > 
> > > How I would write this is:
> > > 
> > > 			ret = rtw_createbss_cmd(adapter);
> > > 			if (ret != _SUCCESS)
> > > 				goto unlock;
> > > 		}
> > > 	}
> > > unlock:
> > > 	spin_unlock_bh(&pmlmepriv->lock);
> > > }
> > > 
> > > That doesn't change how the code works but it signals to the the reader
> > > what your intention is.  If we just remove the error handling then it's
> > > ambiguous.
> > > 
> > > 			rtw_createbss_cmd(adapter);
> > > 		}
> > > 	}
> > > 	<-- Futurue programmer decides to add code here then figuring
> > >             that rtw_createbss_cmd() can fail is a problem.
> > > 
> > > 	spin_unlock_bh(&pmlmepriv->lock);
> > > }
> > > 
> > > But for something like this which is maybe more subtle than just a
> > > straight delete of lines of code, then consider pulling it out into its
> > > own separate patch.  That makes it easier to review.  Put all the stuff
> > > that I said in the commit message:
> > > 
> > > ---
> > > [PATCH] tidy up some error handling
> > > 
> > > The RT_TRACE() output is not useful so we want to delete it.  In this
> > > case there is no cleanup for rtw_createbss_cmd() required or even
> > > possible.  I've deleted the RT_TRACE() output and added a goto unlock
> > > to show that we can't continue if rtw_createbss_cmd() fails.
> > > 
> > > ---
> > > 
> > > > 
> > > > Checkpatch too seems to ignore it, maybe the first one is good,
> > > > but I would like to be sure before sending another over 40 patches
> > > > long patchset.
> > > 
> > > Don't send 40 patches.  Just send 10 at a time until you get a better
> > > feel for which ones are going to get applied or not. :P  It's not
> > > arbitrary, and I'm definitely not trying to NAK your patches.  Once you
> > > learn the rules I hope that it's predictable and straight forward.
> > > 
> > > regards,
> > > dan carpenter
> > > 
> > 
> > Hi Dan,
> > 
> > sorry again. In this case:
> > 
> > @@ -828,10 +829,11 @@ void rtw_surveydone_event_callback(struct adapter *adapter, u8 *pbuf)
> >  
> >                                         pmlmepriv->fw_state = WIFI_ADHOC_MASTER_STATE;
> >  
> > -                                       if (rtw_createbss_cmd(adapter) != _SUCCESS)
> > -                                               ;
> > -
> >                                         pmlmepriv->to_join = false;
> > +
> > +                                       ret = rtw_createbss_cmd(adapter);
> > +                                       if (ret != _SUCCESS)
> > +                                               goto unlock;
> >                                 }
> >                         }
> > 
> > I decided to move the set to false of pmlepriv->to_join before 
> > the rtw_createbss_cmd(). In old code that statement was executed
> > unconditionally and seems not to be tied to the failure of 
> > rtw_createbss_cmd().
> > 
> > The eventual goto would skip this instruction so I moved it
> > before.
> > 
> > What do you think?
> 
> So when you're sending patches like this which have the potential to
> change the behavior then we want to see your thought process explained a
> bit in the message.

you are right, I skip a lot of steps in the message, next time I will
explain better.

> 
> For example, when I'm reviewing patches in my email client, then I don't
> know if rtw_createbss_cmd() uses pmlmepriv->to_join.  It turns out it
> doesn't.  I also don't know what ->to_join is for really.  Your patch
> preserves the original logic, but it's not totally clear that the
> original code was correct.  See how it's done in rtw_do_join():
> 
> drivers/staging/rtl8723bs/core/rtw_ioctl_set.c
>    107                                  rtw_generate_random_ibss(pibss);
>    108  
>    109                                  if (rtw_createbss_cmd(padapter) != _SUCCESS) {
>    110                                          RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_err_, ("***Error =>do_goin: rtw_createbss_cmd status FAIL***\n "));
>    111                                          ret =  false;
>    112                                          goto exit;
>    113                                  }
>    114  
>    115                                  pmlmepriv->to_join = false;
>    116  
> 
> So you could make an argument that the original code is wrong.
> 
> Also rtw_createbss_cmd() can't actually fail.
> 
> The other option is to replace that particular RT_TRACE() with a dev_err()
> message.  Another option is to just skip that one and come back to it
> later.  Maybe the code will be more clear after we have cleaned it up.
> 
> It doesn't matter so long as the commit message defends your choice then
> probably we would accept any of these patches.
> 
> regards,
> dan carpenter

ok I will leave the logic untouched moving the

pmlmepriv->to_join = false;

before the rtw_create_bss() call, for they not interfere.

thank you,

fabio
