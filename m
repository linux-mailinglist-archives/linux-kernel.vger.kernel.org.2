Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E71C36B719
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 18:42:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234472AbhDZQnT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 12:43:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21138 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234403AbhDZQnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 12:43:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619455354;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BJxzv5jKNQktybLPgY590umZq9XnypXNfHP7076nH64=;
        b=aTmlduUdgTCpfiM+b1W4zGk5cLXWf2u1JbZeXuwMkDGDUqsve2bLWVcmpQtBB4jqipPp+U
        jld455ZequpVXj7RVRcjjh3doeRcSm5URI4lMCgYWxok09mv6ozWm/f1ahikN1LMNkXCxO
        eJUhALmLlNXErhCI5JwCZ90z9bCUAB8=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-491-MCWOGxNoOoGJ3NQI6elQYA-1; Mon, 26 Apr 2021 12:42:32 -0400
X-MC-Unique: MCWOGxNoOoGJ3NQI6elQYA-1
Received: by mail-io1-f70.google.com with SMTP id v3-20020a5d90430000b02903da4a3efc9dso28749958ioq.9
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 09:42:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BJxzv5jKNQktybLPgY590umZq9XnypXNfHP7076nH64=;
        b=lRN5KQbG+WtaB8WSHdrWeIlg/zqUOcBWUMiulRDYfSIBK1eY8KA8dpGawhs5EpS6qi
         fj2srJnzj7agJVRSKa/VAJJ/4zeCCkfuZB2eJluxTBjzMzMqHwCOYAgOEST3E1FhOxrM
         kFPCYnl6M35hAG8eE4ymrC9TMnKo7khQXODSrMWOJHSlLuEvJ+vYbhNB7enYm0Tbs0cs
         y/yfjGOcUiNUoSDWzmx4Q5+NSo0r7cv0iCImvvs3+RhA7gC7e/UsfuQHpSISiK11aygc
         7Zmk9dhNomaezFERrEii89k5/+c1GmZnmYFnzBL+v4n36Aal33BXalWEkYge830/sY2f
         Zp0A==
X-Gm-Message-State: AOAM533P28thSPp8EpQmfrYforf+Zgo55B2OEBPfDLlVknM+Uqxp444v
        fwOw6K63yMPaYZASKyIgSCtVmLjJ4KelW8MBbjsut9IeSiD+vlyp5tWA8DQasStzJHjvg/YPSoX
        RII3yT/XFUVARdASCCZu0abP8
X-Received: by 2002:a92:bf11:: with SMTP id z17mr15070653ilh.146.1619455351946;
        Mon, 26 Apr 2021 09:42:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyD8S2SaijrAd62taudrpY7FzMTTsRwm3xCUxNYbDsm3mc+yVBtLie0n3zLxCerfxoxSBh27Q==
X-Received: by 2002:a92:bf11:: with SMTP id z17mr15070638ilh.146.1619455351776;
        Mon, 26 Apr 2021 09:42:31 -0700 (PDT)
Received: from halaneylaptop (068-184-200-203.res.spectrum.com. [68.184.200.203])
        by smtp.gmail.com with ESMTPSA id v8sm181953ilq.0.2021.04.26.09.42.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Apr 2021 09:42:31 -0700 (PDT)
Date:   Mon, 26 Apr 2021 11:42:29 -0500
From:   Andrew Halaney <ahalaney@redhat.com>
To:     bigeasy@linutronix.de
Cc:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Chunyu Hu <chuhu@redhat.com>
Subject: Re: [RT PATCH] locking/rwsem-rt: Remove might_sleep() in __up_read()
Message-ID: <20210426164229.mbrsrjpmmhp7ehna@halaneylaptop>
References: <20210406221952.50399-1-ahalaney@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210406221952.50399-1-ahalaney@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 06, 2021 at 05:19:52PM -0500, Andrew Halaney wrote:
> There's no chance of sleeping here, the reader is giving up the
> lock and possibly waking up the writer who is waiting on it.
> 
> Reported-by: Chunyu Hu <chuhu@redhat.com>
> Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
> ---
> Hello,
> 
> I ran into a warning caused by this, and I think the warning is
> incorrect. Please let me know if I'm wrong!
> I'm working off of linux-5.12.y-rt, but this applies cleanly to older
> stable branches as well.
> 
> Thanks,
> Andrew
> 
>  kernel/locking/rwsem-rt.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/kernel/locking/rwsem-rt.c b/kernel/locking/rwsem-rt.c
> index 274172d5bb3a..b61edc4dcb73 100644
> --- a/kernel/locking/rwsem-rt.c
> +++ b/kernel/locking/rwsem-rt.c
> @@ -198,7 +198,6 @@ void __up_read(struct rw_semaphore *sem)
>  	if (!atomic_dec_and_test(&sem->readers))
>  		return;
>  
> -	might_sleep();
>  	raw_spin_lock_irq(&m->wait_lock);
>  	/*
>  	 * Wake the writer, i.e. the rtmutex owner. It might release the
> -- 
> 2.30.2
> 

Just a gentle follow up, any feedback?

Thanks,
Andrew

