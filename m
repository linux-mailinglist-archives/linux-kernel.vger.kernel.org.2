Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 316E439AD49
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 23:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbhFCV6U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 17:58:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbhFCV6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 17:58:18 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88CA3C06174A
        for <linux-kernel@vger.kernel.org>; Thu,  3 Jun 2021 14:56:33 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id c13so3634166plz.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jun 2021 14:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hcR2WT3vvryIaxbYCFHgFPNRMu872lwm697WZRE1kh8=;
        b=OJ1ffKBL2zTMCQ8FGoFYNEK/qKuYsaHaSFwj3Gi0UxE+Hu2kehZOW8OHbO6bSbfsx3
         gY3bdb8N37tXlvSuJWR5rjzrdziyY5EMf8D5Q1IeQQvxH4n4xLAvy1/Us8AY20mDPv09
         7LAH6KrYzOhMGVDh+4KeGEVveCicvz6ZvjTLSFz5eumGHGfsmDZpq5WbgVoyFdMRMdJS
         Cwd3rF5kgbCzax+t70gJYwHOq8NtnD1BueaqiRgxjsNA5VFEugbrVG0iWv37sd/SaENB
         RdNy3EEN1r+BfOPygMbxtCjMY7R1yDwLGKkuq9KBtGvm28a44ADIcMMMVYno/vIgQtkA
         bayA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hcR2WT3vvryIaxbYCFHgFPNRMu872lwm697WZRE1kh8=;
        b=GsnBQtaOHjD915sIfL+HyEiw23NFvS3sgf1qia413ol3ITPupfT93Me1WOY/fX+/4i
         plvQi0S8lCNWP9dFK1enq3muzFIRtQOqzUsNafkr16mH+2ZDF8CLsBw0gncFFTzAI74l
         rPLEF/6L9pg2WC89bYRdc8vMnfcs04JAYI99qxpxcSA9Enf9EJit0kduuQlJzAfFcUcp
         vMks6gZd8L5q7uWjPIyLY7zzjVAU8wh9f0rtB2TU5R5zJLJMKXRWSE9DDemXhES6Kymx
         A0VYB0aynuW0muUbQnn7eg5iyg3B7dIMSnDYt45DHzafmd1YVjxUfMhBb4re5kb4kdfy
         AkOQ==
X-Gm-Message-State: AOAM5319b4XJDWx0qpmx98qAiCp4UN7tzOUYkvADttQuuxi+r9anT3Eg
        Keeiu67Y1Mu8p76EK2OEVRKc7w==
X-Google-Smtp-Source: ABdhPJyVUWstFctTJ2cBSzd8UOkLP8piwEWGOeyh98T/MvRNyuOqD1X92kpZG8zfPPjYlXoXiXFMqg==
X-Received: by 2002:a17:90a:7e92:: with SMTP id j18mr1384538pjl.231.1622757392443;
        Thu, 03 Jun 2021 14:56:32 -0700 (PDT)
Received: from google.com ([2401:fa00:9:211:6fff:8119:dab5:49cd])
        by smtp.gmail.com with ESMTPSA id x13sm3519123pja.3.2021.06.03.14.56.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jun 2021 14:56:31 -0700 (PDT)
Date:   Fri, 4 Jun 2021 07:56:18 +1000
From:   Matthew Bobrowski <repnop@google.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        kernel test robot <oliver.sang@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        kbuild test robot <lkp@intel.com>, ying.huang@intel.com,
        feng.tang@intel.com, zhengjun.xing@linux.intel.com,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [fanotify] a8b98c808e: stress-ng.fanotify.ops_per_sec 32.2%
 improvement
Message-ID: <YLlQAqlUxEt4eTiR@google.com>
References: <20210603015314.GA21290@xsang-OptiPlex-9020>
 <CAOQ4uxjdtfriARxh_CiTxFi8=T6j065HtbJGnuAas7oyPNADKg@mail.gmail.com>
 <20210603084324.GC23647@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210603084324.GC23647@quack2.suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 03, 2021 at 10:43:24AM +0200, Jan Kara wrote:
> On Thu 03-06-21 09:57:15, Amir Goldstein wrote:
> > On Thu, Jun 3, 2021 at 4:36 AM kernel test robot <oliver.sang@intel.com> wro
> > > Greeting,
> > >
> > > FYI, we noticed a 32.2% improvement of stress-ng.fanotify.ops_per_sec due to commit:
> > >
> > >
> > > commit: a8b98c808eab3ec8f1b5a64be967b0f4af4cae43 ("fanotify: fix permission model of unprivileged group")
> > > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> > >
> > >
> > 
> > I guess now we know what caused the reported regression:
> > https://lore.kernel.org/lkml/20210511124632.GL24154@quack2.suse.cz/
> > 
> > I didn't know that capable() is so significant.
> 
> Yeah, I wouldn't guess either. Interesting.

Indeed, interesting! :)

While on the topic of stress-ng, it reminds me to set this up on my server
so we can perform such regressions before merging fanotify changes into
master.

/M
