Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 831F6380E31
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 18:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232144AbhENQap (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 12:30:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbhENQan (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 12:30:43 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADE86C061574
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 09:29:29 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id r11so11299141edt.13
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 09:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EjCa/Y8fPjm4VNptwpoJ6doa9lNqw0SSL7+evAimqKA=;
        b=uq1b0TRBSGV5y3N9/LBzSnoEsVO9A4VNXUPGgt2SF2QyjAzBGMVXPf+EZgdA3r4r84
         30BwxNO+4v8pi6gCotag91xtXPTy+Rng3OTGiuadS8F1nZkKXDEGMZ1aPsoBrFUmuv6x
         kcIUjyF6k2z8zaNiQmtKhnwFcA8tsXYs1gDLZlnXDysMxSHFkJe+1jw8MVkzug7c7Vf+
         qSC1cgDMqP/PpkaVnfh3qG/aK3wYMkYtSBWS+RBf/bRQOSWyKfbtDjmF9c7xa64gkkUu
         cKCJlcveSvHvwX+VNzJYcuFC0T3i8nao1kxsa1I0hCZvKAARxnwNvrV5ueylWnp6AaV1
         kuGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EjCa/Y8fPjm4VNptwpoJ6doa9lNqw0SSL7+evAimqKA=;
        b=fZ/Rskb4WRdyz8T+V+ufOmAOiMpx2I2vNXiajwFvtPIThxOAtivLtvIU4y3Pn4qT5Q
         GU+tjdP8y8mueJzfg689vV2q1GeVd5etwz7iPQIpaXzpvXniadBEqVDgKcbknBHRys1y
         25g+2yqyMOxodpsyzEnsXTAqztSPhz2HKn8RcbQtZ7hOFvEVAqJ4ivwhwLvmwXrOU7aC
         ThfBOrf4ikp9RDtwlXLzLtGWpei0fYuwM6Q525Oq57MvLINAHfFcLDUV+x01RkaxdqmJ
         bRLlnc490IEX63JzT/r/CF85ahgmMig4013llIs63fALjT4rwdWk/qaOw7p8k+wmHRc6
         uYmw==
X-Gm-Message-State: AOAM532O4XAnmx34V1mpqwXO3nhx4nDvWgHCz5YP2kr/xRnyAiKxxb0K
        Uh11Xi5Cp4A4H8D4eXHSH84opxm0iefsTg==
X-Google-Smtp-Source: ABdhPJzJQzM7qSR6YpKntCTFQHiOYUxGKL8R0Pl2TzZ99ffjN6gbUsMr1X0dNhgI7+WBTCHsk4wKMQ==
X-Received: by 2002:a05:6402:176f:: with SMTP id da15mr12000926edb.380.1621009768472;
        Fri, 14 May 2021 09:29:28 -0700 (PDT)
Received: from agape.jhs ([5.171.72.183])
        by smtp.gmail.com with ESMTPSA id p25sm3859345eja.35.2021.05.14.09.29.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 May 2021 09:29:28 -0700 (PDT)
Date:   Fri, 14 May 2021 18:29:25 +0200
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     hdegoede@redhat.com, Larry.Finger@lwfinger.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: staging: rtl8723bs: questions on TODO list
Message-ID: <20210514162925.GA1568@agape.jhs>
References: <20210514083856.GA13800@agape.jhs>
 <YJ44mtOUVZwhxW4m@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YJ44mtOUVZwhxW4m@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 14, 2021 at 10:45:14AM +0200, Greg KH wrote:
> On Fri, May 14, 2021 at 10:38:57AM +0200, Fabio Aiuto wrote:
> > Hello all,
> > 
> > I'd like to have some clarifications about rtl8723bs driver.
> > In order to make this driver ready for moving out of staging
> > I would like to know:
> > 
> > - find and remove remaining code valid only for 5 GHz. Most of the obvious
> >   ones have been removed, but things like channel > 14 still exist.
> > 
> > is it possible to remove all 5g code, even the one related to power
> > regulation when on band 5g? As far as I know about this card is that
> > it doesn't support 5g, so may I just delete all 5g code or there are some
> > constraints I'd take care of?
> > 
> > - find and remove any code for other chips that is left over
> > 
> > Ok this seems clear, are there some suggestion to do it safely?
> > 
> > - convert any remaining unusual variable types
> > 
> > Ok (but feel free to suggest anything)
> > 
> > - find codes that can use %pM and %Nph formatting
> > 
> > Ok (but feel free to suggest anything)
> > 
> > - checkpatch.pl fixes - most of the remaining ones are lines too long. Many
> >   of them will require refactoring
> > 
> > Ok
> > 
> > - merge Realtek's bugfixes and new features into the driver
> > 
> > Please, can you explain what one could do that?
> > 
> > - switch to use LIB80211
> > - switch to use MAC80211
> > 
> > I think I need a few details for these last points as well.
> > 
> > Do you think that one will need real hardware to complete
> > these tasks? I don't have rtl8723bs card at the moment, so
> > I think I will focus on those TODO activities which
> > don't need it.
> 
> I recommend getting one of these devices to do the more complex tasks as
> described above.  Otherwise it's going to be hard to verify that your
> changes are valid.
> 
> thanks,
> 
> greg k-h

got it,

thank you,

fabio
