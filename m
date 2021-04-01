Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62CAA3521E7
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 23:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235267AbhDAVvX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 17:51:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233974AbhDAVvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 17:51:21 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15BD0C0613E6
        for <linux-kernel@vger.kernel.org>; Thu,  1 Apr 2021 14:51:20 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id j3so3538087edp.11
        for <linux-kernel@vger.kernel.org>; Thu, 01 Apr 2021 14:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qr/zVXs4BBK3bX/o8KKs0/9ybzhhmiWFwZmB2BtSGVQ=;
        b=kQQwtFTWjnxgx2QvhXYC533iMgthpb5COZPCB0XfISupEww/VuHydSCCbVZms3TmLV
         4EKLMNsjVdSEezhDdCZgZipHY3FymwQwIdx3DqjDkbaonD4BqHbaYqbJaYZLJFdwypwm
         k6oHguxYl0cKXOYRvzjzHzQpLoVoDMzEVv9uQthprYrHmkannz5+1JRfBVx7uIxOj/BU
         BPlZ3kfI3Y9DwtKql+2bXyJHx6Uinn8gcDy3Yjq/1eY4kvQryiYeOfYIkgZNOK4ktJvL
         3VMKoKMFU2SwQGNTK7QMvSQtxop2mORZqL2zC+i8cdt7/3pup39Sx13LAqIvzgoXBrkU
         om3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qr/zVXs4BBK3bX/o8KKs0/9ybzhhmiWFwZmB2BtSGVQ=;
        b=QnRin45LTZIZYHOQnVjOTF8uTHzJY4tjIlJxdssNfvuf9aHk3z9bxFrnZglA0UBVrz
         BOsu2f/pk/gvoAiLw6pKu1Hrfmsv8KmEqnKvlZwzqNIqE7gcs+KHl2Z72UluRAxmqiQN
         9y1uA24Cvfj7/xBXrBWFY+y5AVOfpg/IhWrl0mRYoshXPB11JiEzkLuVKU0uOGjJjccS
         AyG7wx9ci+accLGk3z/fuF+uQRuy4K+zGCszt3ihuJur4RrBneRDNQ4CAlLNYbmmmogx
         NRhMunrZr2Fj9ntamCJXQd/Qm8IkOpsgUOahaY7F0ZlMWSubpUIcHfAT7YbctwCn+Z0B
         QoOw==
X-Gm-Message-State: AOAM533T3BDDVk200uZdO9ArT0aN+k90LG/+nYIPCtlzARAKIQspghw2
        dhE0Gpmy66vImNpKPQ2tMY4=
X-Google-Smtp-Source: ABdhPJy4IZaKdl/6YddAP+of+xBJDZHvqjdUtGoyUDBS4e+lSmMu9KtzO1uQ2W1TvLm3ARmZnZIvzg==
X-Received: by 2002:aa7:cb90:: with SMTP id r16mr12410133edt.139.1617313878783;
        Thu, 01 Apr 2021 14:51:18 -0700 (PDT)
Received: from agape.jhs ([5.171.72.8])
        by smtp.gmail.com with ESMTPSA id q20sm3336517ejs.41.2021.04.01.14.51.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 14:51:18 -0700 (PDT)
Date:   Thu, 1 Apr 2021 23:51:15 +0200
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     gregkh@linuxfoundation.org, joe@perches.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/49] staging: rtl8723bs: remove RT_TRACE logs in
 core/rtw_cmd.c
Message-ID: <20210401215114.GA15992@agape.jhs>
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

Hi Dan,

sorry again. In this case:

@@ -828,10 +829,11 @@ void rtw_surveydone_event_callback(struct adapter *adapter, u8 *pbuf)
 
                                        pmlmepriv->fw_state = WIFI_ADHOC_MASTER_STATE;
 
-                                       if (rtw_createbss_cmd(adapter) != _SUCCESS)
-                                               ;
-
                                        pmlmepriv->to_join = false;
+
+                                       ret = rtw_createbss_cmd(adapter);
+                                       if (ret != _SUCCESS)
+                                               goto unlock;
                                }
                        }

I decided to move the set to false of pmlepriv->to_join before 
the rtw_createbss_cmd(). In old code that statement was executed
unconditionally and seems not to be tied to the failure of 
rtw_createbss_cmd().

The eventual goto would skip this instruction so I moved it
before.

What do you think?

Thank you,

fabio
