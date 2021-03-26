Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54D8734AE11
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 18:58:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbhCZR5e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 13:57:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbhCZR5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 13:57:12 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1255C0613AA
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 10:57:11 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id j7so6494116wrd.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 10:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1t/0Bpv5qVziM336nk0rPn6pQA+Kb+gV2sVnrRpUuDc=;
        b=QIvHEKJQHrUxt4VR/iUcqTWKK0unXoDuCvLpmIiJgvNaNzhkXOziIKcKCL4maSPhqM
         xE4FeLvGwCRrE2EW7BIK09MyE/jBKSApe9G8vyw3uvkLMDnLZUbzr56ad8sfM6kwW+yH
         c/o4U10tYCLxLqasPQh5zQV2ulBtOHaBuCDcTmgsW5vK6Vo/FO0Is5KOY0splO3aE1bw
         A05W0fmEt4zyERo+CgFiexcXtMWOr65wD9SJpICAHJQ98KhyafaL9Ppwt5h/WGXjkl8F
         aciFDIBzZcODQaMO87Ya8H745aLb6LtpWUiWTuS/cEaBACe8gAY14ZZU2oZ2kmEJUTTI
         9WIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1t/0Bpv5qVziM336nk0rPn6pQA+Kb+gV2sVnrRpUuDc=;
        b=ICWylNiPHl0FqNPxANqjagTxsXdkDRZWlRe9j5aulLnX9btuslK9r/j+ZtU1ewcExo
         F0HpA1/gc2F2g+urxtstH9iAPAVuTNVO8NKENVXVeLibJiLEu/iUDUeACliVMpKM5q9s
         otyBycwYhLNfm7YVoKVu/ip0yvlH4Pasv7IQ94oSF0i/mHDW5x3HlWgX5JLbUW+SurCp
         /U9YG48VYtkNYRmzdv+euT3KO43ezfyxIvE6vAuIFDE9kRC97ZElA22eyw6TAJITAkYD
         12xUuBLvdzyXQvwdk3VkvhSEHDB2QFYavxuWWtyQtjois6tz7dBtQzHrMwtnK6Oxq6RK
         OApA==
X-Gm-Message-State: AOAM530C1q2eY8idJveObOTd5uSzsR3amy0WE+QTkzKqMWw06V6MMBk1
        y87JMk9GQuO4ajLI61JDnQ8yursa2jec7g==
X-Google-Smtp-Source: ABdhPJzpq6eqymGBmVDq77F42urjhWGXEulUKb6s4ehEjkArnIhuodpQFR50lbW45Q9/H8y4hTMRUQ==
X-Received: by 2002:adf:e582:: with SMTP id l2mr15882957wrm.207.1616781430406;
        Fri, 26 Mar 2021 10:57:10 -0700 (PDT)
Received: from agape.jhs ([151.37.215.119])
        by smtp.gmail.com with ESMTPSA id t8sm14586922wrr.10.2021.03.26.10.57.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 10:57:10 -0700 (PDT)
Date:   Fri, 26 Mar 2021 18:57:07 +0100
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     dan.carpenter@oracle.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fixes: 65f183001f6e (staging: rtl8723bs: remove unused
 code blocks conditioned by never set CONFIG_INTERRUPT_BASED_TXBCN*)
Message-ID: <20210326175706.GB1464@agape.jhs>
References: <YF3qSsH/3vRy7BRy@kroah.com>
 <20210326155252.6746-1-fabioaiuto83@gmail.com>
 <YF4J2JVz1tHiFsGJ@kroah.com>
 <20210326174327.GA1464@agape.jhs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210326174327.GA1464@agape.jhs>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 26, 2021 at 06:43:28PM +0100, Fabio Aiuto wrote:
> On Fri, Mar 26, 2021 at 05:20:40PM +0100, Greg KH wrote:
> > On Fri, Mar 26, 2021 at 04:52:52PM +0100, Fabio Aiuto wrote:
> > > fix indentation broken by patch removing conditional
> > > code blocks checked by unused
> > > CONFIG_INTERRUPT_BASED_TXBCN family defines
> > > 
> > > https://lore.kernel.org/r/9157000821fd6febf25566b8c712fad1995c7c78.1615907632.git.fabioaiuto83@gmail.com
> > 
> > No, please use a "Fixes:" tag that points to the git commit id that this
> > commit fixes.  Look in the kernel tree for loads of examples of how to
> > do this, and it's even documented in the Documentation/ process guide as
> > well.
> > 
> > thanks,
> > 
> > greg k-h
> 
> is what I did, as you can see in the subject. Or I did wrong?
> 
> thank you,
> 
> fabio

forget this message :( I will send you the patch correctly formatted,
just seen some examples. I thought the 'Fixes: ...' was the one line
desc.

thank you

fabio
