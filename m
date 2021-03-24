Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D30FB348340
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 21:57:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238241AbhCXU4m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 16:56:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238266AbhCXUzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 16:55:53 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32D34C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 13:55:53 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id r17so15576186pgi.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 13:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=bW7WoQMagjQIIn/8KR5VslHMG/0qRAE/ZaFZOdCtxDU=;
        b=CsGZg8KXX0+gDzDoUnbX6Y1biImPWLzCl2DUcsiu5txYHCEtbXGxarA02F0xZrd7Bl
         yX6HMNsYm2EIwXiBJ8qrS4IjBf3OngUaduS3sd6eZyfkUKcfPv+Bd7HyMDbw6LAMVLON
         8XkT0BgYZyKDT4YRJ2FIoK/koDunktRmgKUddd2S7BzSSExQP0ay375xoQ/VgRN+yMg6
         cb+RUNgyzswUsHxKPdPWMuPOPtMq2Jw7kbmZQrmOvPKoyPG3LPPIOGCnycaj37bNbc4h
         XeXZ+6SW0dj3y547kj/LCHPrd+nLguFMXCA8wdPi5qvdj1SAWP3bNavnpdfhze2WOcLZ
         Zn4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=bW7WoQMagjQIIn/8KR5VslHMG/0qRAE/ZaFZOdCtxDU=;
        b=tzETK0Ss50jla56QmyO2tTZcB4ppxY9J9z3G7eWMaNF3/xwKrwMFk+FaHoG5e6KHkg
         Jmk+RmywG91BSy4xkZOXSMEyuRC6tFMkFSGrq9FH1d/dqD81do3u17xYaJWCZ3tdkKPG
         HGchSCjWUisNaL9P1D0SCZOI0OObJYqjpkFlLxJKNwZdzlv7P0JZ6RcbX0rc+nbQWlOG
         QAxSHLm+ZgQ4zUIpCgysFGOpuUg4pz4AiuKdQKBPCOox3cQ4W4Bp9xSUuESelIg/aJem
         Az5zrsvs6HAk8LyS9SSwfP5K8vTCWYiiTMVlyaI3JtLRG/bdFwbu+arJnrTELOlNtj5F
         E0dQ==
X-Gm-Message-State: AOAM5314Icn7W2dPyRcpqW8K7rltB/Ir+2zlYN0y1E09lx/BowP4PONE
        NVbH1KLm70QwWtIBFsOz+4E=
X-Google-Smtp-Source: ABdhPJxWLuQACGwGD50bc0v5NiwE3SaRIWPHb0xTmcajBsHfu2DcB7sGbt2Y/fscZvWtPDnwMWWZYw==
X-Received: by 2002:a62:2a07:0:b029:214:fd95:7f7 with SMTP id q7-20020a622a070000b0290214fd9507f7mr4891951pfq.60.1616619352778;
        Wed, 24 Mar 2021 13:55:52 -0700 (PDT)
Received: from google.com ([2620:15c:211:201:7dfa:1e53:536:7976])
        by smtp.gmail.com with ESMTPSA id v126sm3472399pfv.163.2021.03.24.13.55.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 13:55:51 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Wed, 24 Mar 2021 13:55:49 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, gregkh@linuxfoundation.org,
        surenb@google.com, joaodias@google.com, jhubbard@nvidia.com,
        willy@infradead.org
Subject: Re: [PATCH] mm: cma: fix corruption cma_sysfs_alloc_pages_count
Message-ID: <YFunVZLZYSzUDd6n@google.com>
References: <20210324192044.1505747-1-minchan@kernel.org>
 <18ee5c3e-fba2-0d8d-bd93-5fb8d0dd7a01@gmail.com>
 <89ba4c7a-42d2-5412-2367-cc1cffc1117b@gmail.com>
 <YFuZua1TIEkXtqoL@google.com>
 <900f5707-3352-e3d1-69e8-c1f8580c0fc4@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <900f5707-3352-e3d1-69e8-c1f8580c0fc4@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 24, 2021 at 11:02:47PM +0300, Dmitry Osipenko wrote:
> 24.03.2021 22:57, Minchan Kim пишет:
> > On Wed, Mar 24, 2021 at 10:49:58PM +0300, Dmitry Osipenko wrote:
> >> 24.03.2021 22:43, Dmitry Osipenko пишет:
> >>> 24.03.2021 22:20, Minchan Kim пишет:
> >>>>  static int __init cma_sysfs_init(void)
> >>>>  {
> >>>> -	int i = 0;
> >>>> +	struct kobject *cma_kobj_root;
> >>>> +	struct cma_kobject *cma_kobj;
> >>>>  	struct cma *cma;
> >>>> +	unsigned int i;
> >>>
> >>>>  	while (--i >= 0) {
> >>>
> >>> Do you realize that this doesn't work anymore?
> >>>
> >>>>  		cma = &cma_areas[i];
> >>>> -		kobject_put(&cma->stat->kobj);
> >>>> -	}
> >>>>  
> >>>> -	kfree(cma_stats);
> >>>> -	kobject_put(cma_kobj);
> >>>> +		kobject_put(&cma->cma_kobj->kobj);
> >>>> +		kfree(cma->cma_kobj);
> >>>
> >>> Freeing a null pointer?
> >>>
> >>>> +		cma->cma_kobj = NULL;
> >>>> +	}
> >>>> +	kobject_put(cma_kobj_root);
> >>>
> >>
> >> Please try to simulate the errors and check that error path is working
> >> properly in the next version.
> >>
> >> Alternatively, we could remove the cma_kobj_release entirely, like Greg
> >> suggested previously, and then don't care about cleaning up at all.
> > 
> > Does he suggested it to remove cma_kobj_release?(Initially, I did but
> > was rejected from Greg)
> > 
> 
> Alright, I haven't followed the previous threads fully and only saw the
> reply where he suggested to removed it.

No problem. I just posted it new version. Hopefully, it tastes good
for you. ;-)

Thanks for the review!
