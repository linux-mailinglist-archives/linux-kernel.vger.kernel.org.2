Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6895336FD5C
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 17:09:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbhD3PJP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 11:09:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbhD3PJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 11:09:14 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D64FC06174A
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 08:08:24 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id e7so82930689edu.10
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 08:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Mu0mYNOEV277bg0pTpOqMEzxYQPlgVYLrj4Fpbo0+Eo=;
        b=OSQgSLNVKb92/jcqxVrqvKp6nr43WRw7jGm8vkbdIiLo0d5yvhctFCfb45FW4M15S6
         RL9w4tSdEufazZuYoaGhWF6uOBuv2VUiWrLR/bvTfnoYSiMV6AG1Wq0cR0lluaepBicq
         BCEYSb4cTfONm2tY6m/11YxvtZln74IPQHeu+wre6YoL/5/Ds1AQwa7P0gGY68NO8kOx
         ayRkWRfHsnIYFJO9TJNi+qo27kQiqJxxxlbwKpEfxJnQd2y3YAHcVOZdMB5SCXwUsYLj
         P8LabYkDZ2CLcLH2mfOIlDTUnhjNez1AZNCptWsKnG8tbzRuIUjrVqFonc9lLz5EIXTX
         chew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Mu0mYNOEV277bg0pTpOqMEzxYQPlgVYLrj4Fpbo0+Eo=;
        b=VGUuAWLyK7mZhpAlHA/QetHwRAExhfzlcN7Qt09IO2Ay1L+tIt0fWhFKxh36yDpeuO
         9z0+BX47qKJNTy5A0L6+M7wG+dJBp74X7MgxjrD4XMkfqu1/gErZAURLFeYRbeexIanQ
         v170MS0KpsAf0hN3mzkl9aMeT0QoL63BUOERQ4caocdYm05qkmu/42AqCWYFnVqwBHt0
         48aW0muf5LOMjwqa7nP04RJpJkdrqivqNiraFDi+3mcbZ1hrCs3YY/OweZparw2uavnJ
         NRh/eVoobUCcx6jOD1NKxEP/ZBVMGgfELFNFHQP52+tv5JAmta8gTGweRg6fge7ZS9JZ
         bmFg==
X-Gm-Message-State: AOAM531+r3fIDKeX4asPqT+xUXigIjWtwf/redtSjkKtYOCULhvWGI1J
        EvZzDYnD+Cz6jGR11GAHQRk=
X-Google-Smtp-Source: ABdhPJyDUWhDuw0gu3nc7UjxMS5wiA2bqgX0qEl+zsc60tfJL3ITdmyzzJ5WAVomA0wiSPDQ6qYJcg==
X-Received: by 2002:a05:6402:1c0b:: with SMTP id ck11mr6562801edb.264.1619795303279;
        Fri, 30 Apr 2021 08:08:23 -0700 (PDT)
Received: from agape.jhs ([109.52.244.36])
        by smtp.gmail.com with ESMTPSA id r25sm1460727edv.78.2021.04.30.08.08.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 08:08:22 -0700 (PDT)
Date:   Fri, 30 Apr 2021 17:08:20 +0200
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     Bryan Brattlof <hello@bryanbrattlof.com>
Cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/43] staging: rlt8723bs: remove if-else blocks left
 empty by ODM_RT_TRACE deletion
Message-ID: <20210430150819.GB1387@agape.jhs>
References: <cover.1619768150.git.fabioaiuto83@gmail.com>
 <646608de41fb1ef915834a33453b0a99907d46b0.1619768150.git.fabioaiuto83@gmail.com>
 <20210430143100.jfdaitqlqaclmajp@bryanbrattlof.com>
 <20210430144959.GA1387@agape.jhs>
 <20210430150232.23extupxlsweecrg@bryanbrattlof.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210430150232.23extupxlsweecrg@bryanbrattlof.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 30, 2021 at 03:02:38PM +0000, Bryan Brattlof wrote:
> On Fri, Apr 30, 2021 at 04:50:00PM +0200, Fabio Aiuto wrote:
> >On Fri, Apr 30, 2021 at 02:31:08PM +0000, Bryan Brattlof wrote:
> >> On Fri, Apr 30, 2021 at 09:43:20AM +0200, Fabio Aiuto wrote:
> >> >remove if-else blocks left empty by ODM_RT_TRACE deletion.
> >> >remove unused variables to suppress compiler warnings.
> >> >
> >> >Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
> >> >
> >>
> >> Hi Fabio!
> >>
> >> I just wanted to point out a spelling mistake in the title 'rlt8723bs'
> >> in the off chance you submit a v2.
> >>
> >> Way to go switching this over to netdev btw.
> >
> >what do you mean exactly?
> >
> 
> I was just praising you for all the work you are putting into this
> driver. :)

thank you Bryan, I'm not to praise for my english :-D

> 
> >
> >> --
> >> ~Bryan
> >>
> >
> >Hi Brian,
> >
> >thank you! Ouch I've just sent a v2 for other issues...
> >no problem I will send a v3, sorry all for spamming.
> >
> 
> Don't worry about me. I would wait until Greg and others have feedback
> on your v2 before sending a v3 with this minor nitpick.
> 
> --
> ~Bryan
> 

too late, v3 submitted:(. But I understand what you say and agreed.
So let's wait a little more next time.

thank you,

fabio. 
