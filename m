Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4092940FA20
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 16:27:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241700AbhIQO3K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 10:29:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233943AbhIQO3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 10:29:08 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E611C061574
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 07:27:46 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id d21so15472640wra.12
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 07:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=m1Q502mrSpZ9oXk6X21arToT8O1gwujgIuzL6kqxNVs=;
        b=cx/1LJSexyu6+UJ9zfWPvObA8SB8EP7KndxOHpwTDFrMbiHoURv5Zw+F2RxTLmxwnW
         mygksbW2LI01naG7QgkZH1lIsmx3vl5tb4qNbE4ZzDXuC2bdde59xwKp7RWwTzLUcs2/
         UTpeljWZMxtobpeji9tzTgI/HG+2rkpx/6KsGT3Ns8A7gS7kORa0ORAfsZKCOgpKOEgN
         NZ7cZety6hG7zdkJ65zhxbQ1eWmLxW2KVqvJZFgUlqDNQlGcdHYXXHTMWg+YHrC3U9Fk
         w9hbAftd0tGT/2/6ghe5SxbJHiVLleOqwkIld7W3a4p36y+zkvZu/LXb6C0vpoVC+10n
         gQww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=m1Q502mrSpZ9oXk6X21arToT8O1gwujgIuzL6kqxNVs=;
        b=WhINDZQuG6LoOCFeK8bHyKjQX0y61YQOl5MjNvt4aIJWHxTRsRvRwIRjGrQ7DWbNha
         6LM0H0Qy9XSCPYizeNF2B+mZsN6yUPpswWecTczeuonFVv7HLI/HvcF7W7IAtswu1FEy
         7j9LFew7b+DhNvXqz+E5TJmyMvtBFU+JVky2iU6aEdRzOAUny4+yEiHLlyAAs5/D0sMM
         MkwiheWBdfcM1fay8xpmZk7l7+2Huvc7DqPmIvVj3VpZTTzvJYsO8zVB7dxMtO2vcOGM
         pQDbFLUrSxEeSjOVOKcvPvu7xVnHQyFKwLSIARThpSaR6x6jN4CCt2KK6BEfUTmWcU6Z
         agyQ==
X-Gm-Message-State: AOAM5336lwUT3h7UAhVxT47WnbGzSfwGsDHYav5qsiRT80BON5c9Xy1d
        vhINUmruan13tqmFvS3FAXI=
X-Google-Smtp-Source: ABdhPJxG+075/7XDx7/pYVyd5hLlKIJ0i6qC5vh9Ja/fcsVEJel+6rPHZBmp6CIJ1jVpMWtF1NxFaQ==
X-Received: by 2002:adf:c148:: with SMTP id w8mr12689653wre.317.1631888864824;
        Fri, 17 Sep 2021 07:27:44 -0700 (PDT)
Received: from agape.jhs ([5.171.73.89])
        by smtp.gmail.com with ESMTPSA id v20sm7002218wra.73.2021.09.17.07.27.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Sep 2021 07:27:44 -0700 (PDT)
Date:   Fri, 17 Sep 2021 16:27:42 +0200
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, Larry.Finger@lwfinger.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8723bs: protect sleepq_len access by
 sleep_q.lock
Message-ID: <20210917142740.GA1407@agape.jhs>
References: <20210913130346.2390-1-fabioaiuto83@gmail.com>
 <d6d6c6bf-b787-aac9-4767-4bf54c5437ac@redhat.com>
 <20210913133915.GA1414@agape.jhs>
 <30e138d5-fc51-bbcd-4dfc-3264c258c0bc@redhat.com>
 <YUSlSDz3k9CZdGbP@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YUSlSDz3k9CZdGbP@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Fri, Sep 17, 2021 at 04:25:12PM +0200, Greg KH wrote:
> On Mon, Sep 13, 2021 at 05:12:19PM +0200, Hans de Goede wrote:
> > Hi Fabio,
> > 
> > On 9/13/21 3:39 PM, Fabio Aiuto wrote:
> > > Hello Hans,
> > > 
> > > On Mon, Sep 13, 2021 at 03:24:44PM +0200, Hans de Goede wrote:
> > >> Hi Fabio,
> > >>
> > >  
> > >>> Note that sleep_q.lock is already taken inside
> > >>> rtw_free_xmitframe_queue so we just wrap sleepq_len
> > >>> access.
> > >>>
> > >>> Moved pxmitpriv->lock after sleep_q.lock release to
> > >>> avoid locks nesting.
> > > 
> > >>>  	rtw_free_xmitframe_queue(pxmitpriv, &psta->sleep_q);
> > >>> +	spin_lock_bh(&psta->sleep_q.lock);
> > >>
> > >> AFAICT this needs to be above the rtw_free_xmitframe_queue() ?
> > > 
> > > as I wrote on the changelog, the sleep_q.lock is already
> > > taken inside rtw_free_xmitframe_queue. If I put the
> > > sleep_q.lock above that function a soft lock occurs when
> > > I disconnect.
> > > 
> > > So I put it just below rtw_free_xmitframe_queue.
> > > 
> > > Things works fine this way.
> > > 
> > > Please tell me if there's a best way to do it.
> > 
> > Hmm I see, this may work, but the sleepq_len access
> > really should be protected by the same lock as the freeing
> > of the queue is without dropping it in between.
> > 
> > That rtw_free_xmitframe_queue() takes the sleep_q.lock
> > then to me that signals that other (higher-level) functions should
> > not take sleep_q.lock at all, since this is then private to the
> > functions operating on the sleep_q.
> > 
> > I've an idea how we we can possibly tackle this, but I'm not sure
> > yet I will try to make some time to look into this tomorrow or
> > the day after.
> 
> I'm just going to go and revert the original change here until you all
> can sort it out :)

that's the best thing for now ;)

> 
> thanks,
> 
> greg k-h

thank you,

fabio
