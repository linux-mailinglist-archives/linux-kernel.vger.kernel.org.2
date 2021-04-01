Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A046351918
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 19:52:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237168AbhDARus (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 13:50:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234799AbhDARkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 13:40:15 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E830C0F26EE
        for <linux-kernel@vger.kernel.org>; Thu,  1 Apr 2021 08:04:49 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id z1so2311852edb.8
        for <linux-kernel@vger.kernel.org>; Thu, 01 Apr 2021 08:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kUgcLehiCS2Liu+9B7yEqjgIRfZbGgW3tjIFAhk2RdY=;
        b=RWD1OhRpCTvG7+q/A99FBIQBZKMizyVtPJTRMSR3U4ydit7U8ka0CD+eP6BEMv/Clo
         RNkjcJTmX6VbrAsqYLN/0ooq0hCyWMXUr6MDjj9VwRafte34nAYnlCVrgn6HhQK9CZQe
         n8Zaoh+1X24FTOV1nWrU1d+kLbD+eyb9JCIfUg6HnURJpmSgEYpzMe5bTw2bfpo5YIHP
         sbWZpZDuH8SS5sXyQU9f67r0pSZ9JWMYi/FDsnU3H3JI353GtQhmHdeCryhS+qCOeSUe
         tqVBspGk5LH48jPFrZUvkpbhh5jPTuN43Ol4qpzZr/X6Dsy06ZyctOA1A01651fEwo77
         V9Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kUgcLehiCS2Liu+9B7yEqjgIRfZbGgW3tjIFAhk2RdY=;
        b=cR/kp6qGacMs3ZWoRL1pmKv+2t1zsfzk7kaVsTxNxy1KJ1ZHvfNZS8akaw7CppSDzh
         5dTxsZYDlZMiU0AYLVhKIPKZFYdR9qjYr+aTgRNd2YDO0CZoNbJd+pina5qPRcCKtbQ+
         lsqYdyC8cl+TG69/Xcde8+wY+UWIf+uvPbdkenEN7LWtAA+G4NkKzUI6nzecX1V2MVLW
         dL3SdC+aucj7zTXhHapv0aVT7TbbxrsjlMwzTTRNXvphDBGykg7Si6l8ClYe/mZcorxH
         h9CykRy/km1SNMtdajCBQsb/Z1/Ym7KFtL3IAL1mJYtZovMprGv4jsib3J0uN/C6BdcH
         pHOg==
X-Gm-Message-State: AOAM5327qUZ5K4ypZVs1XSEw4eaIou6YqgUQP3Eev+x/1ra3uxqLRUAd
        1wpJBSvVFp2J43IItKdGOjM=
X-Google-Smtp-Source: ABdhPJzpC3+n2F8xqohnsJM07ONTeJHJoJszze98yi24ldPwRjkvMC75+XQGmfzYgAAWtXbz6oUv5Q==
X-Received: by 2002:aa7:d5c9:: with SMTP id d9mr10801758eds.102.1617289487930;
        Thu, 01 Apr 2021 08:04:47 -0700 (PDT)
Received: from agape.jhs ([5.171.72.40])
        by smtp.gmail.com with ESMTPSA id q16sm3797944edv.61.2021.04.01.08.04.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 08:04:47 -0700 (PDT)
Date:   Thu, 1 Apr 2021 17:04:44 +0200
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     gregkh@linuxfoundation.org, joe@perches.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/49] staging: rtl8723bs: remove RT_TRACE logs in
 core/rtw_cmd.c
Message-ID: <20210401150443.GB1691@agape.jhs>
References: <cover.1617268327.git.fabioaiuto83@gmail.com>
 <7f51432d99459d79742639341f107115f0c224c5.1617268327.git.fabioaiuto83@gmail.com>
 <20210401095017.GR2065@kadam>
 <20210401135536.GA1691@agape.jhs>
 <20210401143235.GV2065@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210401143235.GV2065@kadam>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 01, 2021 at 05:32:36PM +0300, Dan Carpenter wrote:
> On Thu, Apr 01, 2021 at 03:55:37PM +0200, Fabio Aiuto wrote:
> > 
> > Hi Dan,
> > 
> > I have the following:
> > 
> >  	if (rtw_createbss_cmd(adapter) != _SUCCESS)
> > -		RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("Error =>rtw_createbss_cmd status FAIL\n"));
> > +	;
> > 
> > will I leave
> > 
> > 	if (rtw_createbss_cmd(adapter) != _SUCCESS)
> > 		;
> > 
> > or just
> > 
> > 	rtw_createbss_cmd(adapter);
> > 
> > ?
> > 
> > what's best from the static analysis point of view?
> > 
> > smatch and sparse says nothing about that.
> 
> rtw_createbss_cmd() can only fail if this allocation fails:
> 
> 	pcmd = rtw_zmalloc(sizeof(struct cmd_obj));
> 
> In current kernels, that size of small allocation will never fail.  But
> we alway write code as if every allocation can fail.
> 
> Normally when an allocation fails then we want to return -ENOMEM and
> clean up.  But this code is an event handler for firmware events and
> there isn't any real clean up to do.  Since there is nothing we can do
> then this is basically working and fine.
> 
> How I would write this is:
> 
> 			ret = rtw_createbss_cmd(adapter);
> 			if (ret != _SUCCESS)
> 				goto unlock;
> 		}
> 	}
> unlock:
> 	spin_unlock_bh(&pmlmepriv->lock);
> }
> 
> That doesn't change how the code works but it signals to the the reader
> what your intention is.  If we just remove the error handling then it's
> ambiguous.
> 
> 			rtw_createbss_cmd(adapter);
> 		}
> 	}
> 	<-- Futurue programmer decides to add code here then figuring
>             that rtw_createbss_cmd() can fail is a problem.
> 
> 	spin_unlock_bh(&pmlmepriv->lock);
> }
> 
> But for something like this which is maybe more subtle than just a
> straight delete of lines of code, then consider pulling it out into its
> own separate patch.  That makes it easier to review.  Put all the stuff
> that I said in the commit message:
> 
> ---
> [PATCH] tidy up some error handling
> 
> The RT_TRACE() output is not useful so we want to delete it.  In this
> case there is no cleanup for rtw_createbss_cmd() required or even
> possible.  I've deleted the RT_TRACE() output and added a goto unlock
> to show that we can't continue if rtw_createbss_cmd() fails.
> 
> ---
> 
> > 
> > Checkpatch too seems to ignore it, maybe the first one is good,
> > but I would like to be sure before sending another over 40 patches
> > long patchset.
> 
> Don't send 40 patches.  Just send 10 at a time until you get a better
> feel for which ones are going to get applied or not. :P  It's not
> arbitrary, and I'm definitely not trying to NAK your patches.  Once you
> learn the rules I hope that it's predictable and straight forward.
> 
> regards,
> dan carpenter
> 

thank you Dan for you explanation, I will do like you said. I appreciate a
lot and it's good for my patches to be acked when they are fully ok, there's no
hurry :-D.

I will send them in smaller patchsets then.

regrards,

fabio
