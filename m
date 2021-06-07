Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1521439DB7D
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 13:37:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231443AbhFGLjb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 07:39:31 -0400
Received: from mail-wr1-f50.google.com ([209.85.221.50]:33720 "EHLO
        mail-wr1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231244AbhFGLja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 07:39:30 -0400
Received: by mail-wr1-f50.google.com with SMTP id a20so17262837wrc.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jun 2021 04:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IRP6U/zRIj4Wve486AFNVnGZR885iuJf9+Fq7ikTrUU=;
        b=jp514miurjB9pYXQ+tyBzCZye9+n3pjiE0nAkpC++XsMLnSQzT+DKRHl5v8t1kr3qU
         SGSy1eHHqenjMr+OJbDb9IqOWQEHK+v9FzSH3yUdwU+9WeYqmRBXAmHcC3YjDZa7l0fs
         /S81q5c041+cZGAKMffGoBGLT3sznSBKgTBgR6ELCDAC/L52yT+nj7bxw42YIHfyJBeR
         hkbSs8O4QmRsJ4XZjpOgqcxxWtMdytkozw6K3P5DkjabyMQjVMOjq2WEKMNOB/oLr7lU
         IYq2jyo+dRg+HKcXiv5kepXlXwxyqqDvry1aGDEMOOcw2Pig3YWkBV06x1HAn++L3JKw
         hfXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IRP6U/zRIj4Wve486AFNVnGZR885iuJf9+Fq7ikTrUU=;
        b=NUOfDia6yppCCwNKRMGsuEmHXnukF9/EYkEwIjUUXuHtZRPF+v+c+8QWQY/kYoUtMf
         JKi84nijezJSHL0wnZsiIpPYtGwv3NFH9DhpbrS13QIbV3UNj1Qf2HU7cRWF15yPf5Sv
         UrpU23FyfOYENypJgjpKKOcepf6dlgVKLigYIwojfofub5W1lnABEnBOnHJenw8H8zbm
         o0tbLNLgIdrqUwXQRMlyUZ1xC9nb9Z9eOtH79TRLrwvQNdctvnBWG3sROSP1/h4n6Q01
         rzoG5iRXWgz8VgnidpMEJtIQrOvi0kZqtW7tsTz10AKDLPn9udBLCl5vfw6JB/Kbq+cj
         poDg==
X-Gm-Message-State: AOAM533M1nNcZEFpJJNjkk9VeGki52KsdRtbIU/UUi58WwlInZ/47/iG
        ah5MI6gUcNo+IvJlWOjilVM=
X-Google-Smtp-Source: ABdhPJwQPoom+sdaqZ8kDKUf2auJZmp6dqcKDwsKQTYSiW9hdtfV0lB+uAxUle/GkuTEEIF3S/GO5w==
X-Received: by 2002:adf:9031:: with SMTP id h46mr17068670wrh.125.1623065787346;
        Mon, 07 Jun 2021 04:36:27 -0700 (PDT)
Received: from agape.jhs ([5.171.72.204])
        by smtp.gmail.com with ESMTPSA id x7sm17369157wre.8.2021.06.07.04.36.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 04:36:27 -0700 (PDT)
Date:   Mon, 7 Jun 2021 13:36:24 +0200
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        gregkh@linuxfoundation.org, hdegoede@redhat.com,
        Larry.Finger@lwfinger.net, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8723bs: Use list iterators and helpers
Message-ID: <20210607113624.GA1410@agape.jhs>
References: <20210428173301.149619-1-linux@roeck-us.net>
 <20210604172632.GA1526@agape.jhs>
 <20210605005422.GB255680@roeck-us.net>
 <20210607111704.GT1955@kadam>
 <20210607112648.GA314533@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210607112648.GA314533@roeck-us.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 07, 2021 at 04:26:48AM -0700, Guenter Roeck wrote:
> On Mon, Jun 07, 2021 at 02:17:04PM +0300, Dan Carpenter wrote:
> > On Fri, Jun 04, 2021 at 05:54:22PM -0700, Guenter Roeck wrote:
> > > On Fri, Jun 04, 2021 at 07:26:33PM +0200, Fabio Aiuto wrote:
> > > > Hello Guenter,
> > > > 
> > > > On Wed, Apr 28, 2021 at 10:33:01AM -0700, Guenter Roeck wrote:
> > > > > The rtl8723bs driver manually re-implements list helper functions
> > > > > and macros in various ways. Replace with existing list helpers.
> > > > 
> > > > I'm testing rtl8723bs on a baytrail tablet (Lenovo Ideapad MIIX 300-10IBY)
> > > > and applying the tag staging-5.13-rc4, loading r8723bs makes the whole
> > > > system freezing while trying to connect to local AP.
> > > > 
> > > > Only a power off is allowed.
> > > > 
> > > > I found that commit b3cd518c5abd42fbc747ef55a5fdc40bf7bf01c0
> > > > (staging: rtl8723bs: Use list iterators and helpers)
> > > > introduced the bug.
> > > > 
> > > > I'm trying to find out what's wrong with this patch, have you any suggestions?
> > > 
> > > Some of the iterators needed the _safe variant which I didn't take into account.
> > > I thought that was fixed, but maybe some locations were missed.
> > 
> > Ah...  Crud.  As near as I can tell Martin fixed a lot of these in the driver
> > he is working on, rtl8188eu.  But they still aren't fixed in rtl8723bs.  I looked
> > at the functions and the following loops need to changed to list_for_each_safe().
> > (Doing a search for list_del_init() helped during review).
> > 
> 
> Hans wants the patch introducing the problem reverted, so I won't bother
> sending a fix. Sorry for the trouble. Learned a lesson (I hope).
> 
> Guenter
> 
> > expire_timeout_chk() (both loops)
> > rtw_acl_remove_sta()
> > rtw_sta_flush()
> > stop_ap_mode()
> > 
> > rtw_free_network_queue()
> > chk_bmc_sleepq_hdl()
> > rtw_free_all_stainfo()
> > rtw_free_xmitframe_queue()
> > dequeue_xmitframes_to_sleeping_queue()
> > wakeup_sta_to_xmit()  (both loops)
> > xmit_delivery_enabled_frames()
> > 
> > xmit_xmitframes()
> > cfg80211_rtw_del_station()
> > 
> > regards,
> > dan carpenter
> > 
> > 

thanks to Guenter suggestion I made the fix needed, if there's no particular
hurry to revert the change I'm submitting it today or tomorrow at most.
Will cross check with Dan's hint either.

thank you,

fabio
