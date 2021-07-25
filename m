Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A9153D4D3B
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jul 2021 13:44:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbhGYLD2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jul 2021 07:03:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbhGYLD2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jul 2021 07:03:28 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BD87C061757
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jul 2021 04:43:57 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id h24-20020a1ccc180000b029022e0571d1a0so4408852wmb.5
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jul 2021 04:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4bsJHCDmDh2MLKgv8Kwe4Fjj1ivOjmIJSIAwlKwlLkI=;
        b=WoW4LcGxpUFcaRqv+uBN+5ANNeK5KZ4D5aqz+SglUxUqCZiL8L7HLll5B95YufnrXO
         7/Zi8/ULjqzAmgYIgjJb3JCqaLnVpz6H0imjzyw7Gkt4VEb8w8cr+/yxvh21z4+Toedw
         YE9vfnhKCiTyJXP9bBgeD2bUSTk2XFeqJ8XNw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4bsJHCDmDh2MLKgv8Kwe4Fjj1ivOjmIJSIAwlKwlLkI=;
        b=dJxYZPYyVFb2Et8PKtdyFshNPLmRN5vFA+V5LnwhX6Pv/oAeCdvRWUkNMq1nDQzOYq
         wnEpbcByf46eery6moCnFSnsVf4Za4eLDRoLOc1JDHei+/jHAjOzl3npl68n5h6132SS
         iJ9I9TJWC11uP8Xi2t+Hu3C3D5cELtan4dNAHz34Dqf67VSVtel9pGqausyyDZ7OcZ7W
         pP9xE6g2iTFer8O/+ghobNFwlFXPRR9Gl8FQ6NgbYTcAMHMOFtkZxljZ1Hdy66jPdoh7
         cX8CwYmCV/NA/ktL5Oiwy3VKT6R6dYwEsd1lj9KgqvqZHsqtjgk0vVic1/xFR5EvEB+E
         4naA==
X-Gm-Message-State: AOAM531zKdspkmQeBb9A6XRYIvEWeIRWkapqa9cUtiQNDvauXx5lBWmi
        GNbR+16VFek5GSRfn0NRs9gpgQ==
X-Google-Smtp-Source: ABdhPJyc7tGO/pye71VWeck3OLvIapyZcl+Dx7EJuv13rjnPZ3+eAkaBVS5ZMBFtg0Ao83d2Z7Lrwg==
X-Received: by 2002:a1c:1bd0:: with SMTP id b199mr12562635wmb.108.1627213435630;
        Sun, 25 Jul 2021 04:43:55 -0700 (PDT)
Received: from localhost ([2620:10d:c093:400::5:d571])
        by smtp.gmail.com with ESMTPSA id x15sm175461wrs.57.2021.07.25.04.43.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jul 2021 04:43:54 -0700 (PDT)
Date:   Sun, 25 Jul 2021 12:43:54 +0100
From:   Chris Down <chris@chrisdown.name>
To:     Ma Feng <mafeng.ma@huawei.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Petr Mladek <pmladek@suse.com>
Subject: Re: [printk:for-5.15-printk-index 4/8]
 drivers/media/usb/pvrusb2/pvrusb2-encoder.c:288 pvr2_encoder_cmd() warn:
 inconsistent indenting
Message-ID: <YP1OeodZim+HUL+I@chrisdown.name>
References: <202107250913.OiKJhpRZ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <202107250913.OiKJhpRZ-lkp@intel.com>
User-Agent: Mutt/2.1 (4b100969) (2021-06-12)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey there,

kernel test robot writes:
>smatch warnings:
>drivers/media/usb/pvrusb2/pvrusb2-encoder.c:288 pvr2_encoder_cmd() warn: inconsistent indenting
>drivers/media/usb/pvrusb2/pvrusb2-hdw.c:1730 pvr2_hdw_set_streaming() warn: inconsistent indenting
>drivers/media/usb/pvrusb2/pvrusb2-hdw.c:3461 pvr2_hdw_cpufw_set_enabled() warn: inconsistent indenting
>drivers/media/usb/pvrusb2/pvrusb2-hdw.c:3501 pvr2_hdw_cpufw_get() warn: inconsistent indenting
>
>vim +288 drivers/media/usb/pvrusb2/pvrusb2-encoder.c
>
>[...]
>1ad371deb9b0be drivers/media/usb/pvrusb2/pvrusb2-encoder.c   Mauro Carvalho Chehab 2017-06-26  191  	LOCK_TAKE(hdw->ctl_lock); while (1) {
>[...]
>11c48e41d5fcc5 drivers/media/usb/pvrusb2/pvrusb2-encoder.c   Ma Feng               2019-12-19  287  	}
>11c48e41d5fcc5 drivers/media/usb/pvrusb2/pvrusb2-encoder.c   Ma Feng               2019-12-19 @288  	LOCK_GIVE(hdw->ctl_lock);

Ok, so it looks like it's complaining that LOCK_TAKE and LOCK_GIVE are somewhat 
unbalanced in indenting. Which... they are. I don't really see what this has to 
do with the printk indexing patchset.

I tried to reproduce myself, but spatch just segfaults when trying to read 
drivers/media/usb/pvrusb2/pvrusb2-encoder.c under CHECK=, before _and_ after...

There is a pr_info user in here, pvr2_trace, which may be related, but honestly 
I'm not seeing how the printk indexing patchset could materially change this, 
and not having a repro is frustrating.

All of the reported places are just LOCK_GIVE, which is just a mutex unlock, 
nothing to do with printk:

     % sed -n 288p drivers/media/usb/pvrusb2/pvrusb2-encoder.c
             LOCK_GIVE(hdw->ctl_lock);
     % sed -n '1730p;3461p;3501p' drivers/media/usb/pvrusb2/pvrusb2-hdw.c
             } while (0); LOCK_GIVE(hdw->big_lock);
             } while (0); LOCK_GIVE(hdw->big_lock);
             } while (0); LOCK_GIVE(hdw->big_lock);

...where...

     #define LOCK_TAKE(x) do { mutex_lock(&x##_mutex); x##_held = !0; } while (0)
     #define LOCK_GIVE(x) do { x##_held = 0; mutex_unlock(&x##_mutex); } while (0)

Ma Feng, looks like you were already cleaning this up, judging by 11c48e41d5 
("media: pvrusb2: Remove unneeded semicolon and add newline"), maybe you have 
some suggestions? I really don't see what it has to do with the printk indexing 
patchset, although if I had a local repro it would help.

Thanks,

Chris

>:::::: The code at line 288 was first introduced by commit
>:::::: 11c48e41d5fcc5b4cf17aa74388be128ca5444f8 media: pvrusb2: Remove unneeded semicolon and add newline
>
>:::::: TO: Ma Feng <mafeng.ma@huawei.com>
>:::::: CC: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
>
>---
>0-DAY CI Kernel Test Service, Intel Corporation
>https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
