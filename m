Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8917428D12
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 14:33:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236617AbhJKMf0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 08:35:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234689AbhJKMfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 08:35:25 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79FFBC061570
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 05:33:25 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id p13so67831931edw.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 05:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RJTUyJAg/0qOBSGu2m8VD16gMsA5V6NtIjIDHvnL/j4=;
        b=fYB/MfUpM2tfoS/PgqHaV0QQ496ObCtwA2wf1Pa5YrCg0XOosY1KpaO4aU4aPh4Oad
         NsODjk+rviw29QeQ+esAp6PovUcQmbt/Kp403piNECfUIgNLRmgc315odnPxvG3LV76L
         9aQ4UBsgFzhpZ3ALgaLteAWwFIMLUZag471IihbyI7I76ToqtC1rQa+PVQhPWQ2x33/1
         +00o1rmHd6+N3znUeRkBDGbWNu02g/7gnWPLWMnZY+qls6bwzjNpwkR46xm9pd9mpDwn
         ra1t3MidYMKZxt0MKfrnPUSC9msmhBJE7arxfEIm6kkeP0N8AT/5rbY4xphEq/q4YnPY
         6Oog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RJTUyJAg/0qOBSGu2m8VD16gMsA5V6NtIjIDHvnL/j4=;
        b=DKbD7X9zhtmZtorUDnVIBbTdskknoQ7G3l0n6HiAMRu5C16ceWlclh5KX/lKqbhWkW
         qpiB5gm9RqzHfrKJjvq8dsF9NjtAu6yLueeaplH88EE7OZxueHwI4Bduk/brFQzI8xjd
         woCt0n4maWl9LX2Ss2gnDbfL/66x21lqvK5uGEpOkaUSEIF0rZwen3z2L3+bt2qAul1b
         POc0D8C2tgrkPh4lpMkxhAas9SZfgp6jLIeR8sHIZl+tifm74lVouSxtEmCsKszRrw+e
         /+CfMkBnBiRYnU9IxffH+0IdKE11qlDBTvgYRA8lfMhRWuL4Sz1PGeZD2TY+95LFj47b
         qyKQ==
X-Gm-Message-State: AOAM5322Kx0nnwi2/7JQbDcA6b9Q438xtHjRlqWjjhyt8VGk97mBlRU1
        Fo2Z72n72VpfRL3FL+WYdRkcRQEaDUk=
X-Google-Smtp-Source: ABdhPJwyDliN6EEI1VKA/p8Y/OrfXeYL2sGqclnGX8StVSvJfbPFNVf1pfAvQMUmOe6pQsLTdpWAmQ==
X-Received: by 2002:a17:906:4c8c:: with SMTP id q12mr24795449eju.254.1633955603864;
        Mon, 11 Oct 2021 05:33:23 -0700 (PDT)
Received: from localhost.localdomain (host-79-43-109-12.retail.telecomitalia.it. [79.43.109.12])
        by smtp.gmail.com with ESMTPSA id y19sm3094934edd.39.2021.10.11.05.33.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Oct 2021 05:33:23 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     gregkh@linuxfoundation.org, fabioaiuto83@gmail.com,
        ross.schm.dev@gmail.com, marcocesati@gmail.com,
        saurav.girepunje@gmail.com, insafonov@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Saurav Girepunje <saurav.girepunje@gmail.com>
Cc:     saurav.girepunje@hotmail.com
Subject: Re: [PATCH v2] staging: rtl8723bs: os_dep: simplify the return statement.
Date:   Mon, 11 Oct 2021 14:33:21 +0200
Message-ID: <4541535.Yaozv5YaVW@localhost.localdomain>
In-Reply-To: <2482197.HNbSr4JpUv@localhost.localdomain>
References: <YWJ0vSrgsiKK7suE@user> <2482197.HNbSr4JpUv@localhost.localdomain>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, October 11, 2021 10:54:11 AM CEST Fabio M. De Francesco wrote:
> On Sunday, October 10, 2021 7:06:05 AM CEST Saurav Girepunje wrote:
> > Remove the unneeded and redundant check of variable on goto out.
> > Simplify the return using multiple goto label to avoid
> > unneeded check.
> > 
> > Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
> > ---
> > 
> > ChangeLog V2:
> > 	-Add goto out after the memcpy for no error case return with
> > 	 ret only. Free is not required on no error case.
> 
> Please write versions logs that reflect clearly and unequivocally what you 
> changed between revisions and why. Subjects, Commit messages (Changelogs), 
> and Versions logs are the "specifics" of your work. There must be no 
> inconsistencies between these and the code or the history of the changes of 
> the code.
> 
> You may think that I'm pedantic, but since I acked your patch, I don't want 
> to be misunderstood to be a promoter of approximate or clearly incorrect 
> messages.
> 
> "Free is not required on no error case" conveys the message that you have 
> changed something that is not required but that is still potentially 
allowed.
> 
> This is not the case because the problem that you fix with v2 is _not_ 
> something that is merely not required and unnecessary. You have fixed a bug 
> that is introduced in v1. Introducing bugs is not allowed. If you do 
> something that is not allowed you cannot simply say that it is not 
required. 
> 
> > 
> > ChangeLog V1:
> > 	-Remove the unneeded and redundant check of variable on
> > 	 goto out.
> > 	-Simplify the return using multiple goto label to avoid
> > 	 unneeded check.
> > 
> >  .../staging/rtl8723bs/os_dep/ioctl_cfg80211.c | 22 +++++++++----------
> >  1 file changed, 10 insertions(+), 12 deletions(-)
> > 
> > diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c b/drivers/
> staging/rtl8723bs/os_dep/ioctl_cfg80211.c
> > index 0868f56e2979..ae9579dc0848 100644
> > --- a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
> > +++ b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
> > @@ -2312,7 +2312,7 @@ static int rtw_cfg80211_add_monitor_if(struct 
adapter 
> *padapter, char *name, str
> >  	mon_wdev = rtw_zmalloc(sizeof(struct wireless_dev));
> >  	if (!mon_wdev) {
> >  		ret = -ENOMEM;
> > -		goto out;
> > +		goto err_zmalloc;
> >  	}
> > 
> >  	mon_wdev->wiphy = padapter->rtw_wdev->wiphy;
> > @@ -2322,23 +2322,21 @@ static int rtw_cfg80211_add_monitor_if(struct 
> adapter *padapter, char *name, str
> > 
> >  	ret = cfg80211_register_netdevice(mon_ndev);
> >  	if (ret) {
> > -		goto out;
> > +		goto err_register;
> >  	}
> > 
> >  	*ndev = pwdev_priv->pmon_ndev = mon_ndev;
> >  	memcpy(pwdev_priv->ifname_mon, name, IFNAMSIZ+1);
> > +	goto out;

As Pavel noticed, probably you'd better return 'ret' here. The logic does not 
change, but I guess that this is what Linux developers usually do.

From a review by Dan Carpenter of one of your other patches: "[] Do nothing
labels only hurt readability and introduce "forgot to set the error code
bugs.".

Thanks,

Fabio

> > 
> > -out:
> > -	if (ret && mon_wdev) {
> > -		kfree(mon_wdev);
> > -		mon_wdev = NULL;
> > -	}
> > -
> > -	if (ret && mon_ndev) {
> > -		free_netdev(mon_ndev);
> > -		*ndev = mon_ndev = NULL;
> > -	}
> > +err_register:
> > +	kfree(mon_wdev);
> > +	mon_wdev = NULL;
> 
> Probably you have already read a message by Greg Kroah-Hartman that 
confirms 
> what I wrote in another message: "There is no need to set a local variable 
> like this to NULL.".
> 
> So please submit a v3. With the two changes requested above, my "acked-by" 
> tag is confirmed again.
> 
> Thanks,
> 
> Fabio
> 
> > 
> > +err_zmalloc:
> > +	free_netdev(mon_ndev);
> > +	*ndev = mon_ndev = NULL;
> > +out:
> >  	return ret;
> >  }
> > 
> > --
> > 2.32.0
> > 
> > 
> > 
> 
> 
> 
> 
> 




