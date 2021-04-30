Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFA6F36FCE1
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 16:50:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233233AbhD3Ouy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 10:50:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230369AbhD3Ouw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 10:50:52 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9492DC06174A
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 07:50:04 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id r12so105663886ejr.5
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 07:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=c+zhqiWolsRpS0pXdjMbRlziauRw3Z75fImkeJqnZy0=;
        b=f9bO5bVnY9RC3Z83q+bzToUas1OXT05VR8Q5dae3kMrSiL31eE6i3d+xiaAa4/lwsS
         mlhx1peh6gCER3Jt/6HYJq0KnBZ8YgPSDablXAIoTcyG+Nze74Ul5XVLWRxgKIZHAO4X
         4p2ixZDXBF9pm1EJoZJmbg00xUHcNQS/0fSO8FWTIE3gqnLhlQhCC0j+q4ZsCSeYMadV
         1bb2WruEa9FDLOv+tj1IWoTO3VkzyrsvZKG5umNdJGRlcPtj4yuMNOJzYZLb1wZsfEH8
         uSZnOervfo90+IRmFQQ4Zbi6YzFV341FAyADMEvauXol25t3Ce1yUcBl+UUfq4agsjFF
         24XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=c+zhqiWolsRpS0pXdjMbRlziauRw3Z75fImkeJqnZy0=;
        b=ulCkN8uZLnqXiVOr4/5Q3H13FYi/KKbIWW/2/jb30daC30Jv4+9P44uxJG++rBxo/7
         LaHK/SdPYYV2FaBD2s2bH7kgv5+P2iHpCOmasOjthRZ0dGYNWAKO16Awwc+ZA5NOsrD9
         EhoWu2zCqKQH0YGcWOtqSnycLS701fiT/ScsIxhl5NK31nJOO8p41LWeBgwbAkhlEvuG
         LENCLh05QJRuSdkZ1wqdJU6FsgzeJy4xX7X/rCl4dIy527NHSUGvP6tvHf4+e+mQ8zxj
         qXqjMlCrB/uJljlt6YlAyPKP0yuHE7/wjzaTaXKR3Pktx8qtSMoU+PuXjH8/nZQHlOZ/
         Xdgw==
X-Gm-Message-State: AOAM530wvjHqh2XgxhOg9qI5pQY8glWI2z1JIo+Ml7h+AQrisZlc1ITZ
        2ukQ7pTQNr3eIhdsOOCmYkI=
X-Google-Smtp-Source: ABdhPJzVA9Ff8z0j17pfnQSwN9Ng9Ie1Y57/NUB9OGLnxQk9fOq0TULDwctmP6cuNSX175YpY6PuHw==
X-Received: by 2002:a17:906:53d1:: with SMTP id p17mr4744914ejo.470.1619794203383;
        Fri, 30 Apr 2021 07:50:03 -0700 (PDT)
Received: from agape.jhs ([109.52.244.36])
        by smtp.gmail.com with ESMTPSA id g8sm2053127ejt.25.2021.04.30.07.50.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 07:50:02 -0700 (PDT)
Date:   Fri, 30 Apr 2021 16:50:00 +0200
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     Bryan Brattlof <hello@bryanbrattlof.com>
Cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/43] staging: rlt8723bs: remove if-else blocks left
 empty by ODM_RT_TRACE deletion
Message-ID: <20210430144959.GA1387@agape.jhs>
References: <cover.1619768150.git.fabioaiuto83@gmail.com>
 <646608de41fb1ef915834a33453b0a99907d46b0.1619768150.git.fabioaiuto83@gmail.com>
 <20210430143100.jfdaitqlqaclmajp@bryanbrattlof.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210430143100.jfdaitqlqaclmajp@bryanbrattlof.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 30, 2021 at 02:31:08PM +0000, Bryan Brattlof wrote:
> On Fri, Apr 30, 2021 at 09:43:20AM +0200, Fabio Aiuto wrote:
> >remove if-else blocks left empty by ODM_RT_TRACE deletion.
> >remove unused variables to suppress compiler warnings.
> >
> >Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
> >
> 
> Hi Fabio!
> 
> I just wanted to point out a spelling mistake in the title 'rlt8723bs'
> in the off chance you submit a v2.
> 
> Way to go switching this over to netdev btw.

what do you mean exactly?

> --
> ~Bryan
> 

Hi Brian,

thank you! Ouch I've just sent a v2 for other issues...
no problem I will send a v3, sorry all for spamming.

fabio
