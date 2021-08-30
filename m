Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1BBB3FBA82
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 18:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237978AbhH3Q7B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 12:59:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36768 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231234AbhH3Q67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 12:58:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630342685;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=raISjzzXTZAIieU8nOzMirvpJSgfC59Ba/8FkbPMcHk=;
        b=QnfkcBWlaK56XuTO6Aj5o9sRtOTJl7Er+R0ksQJs5YbbwTDJHW93GjIO3iZOKP5vkzJiBZ
        C9piycuMPNzLhyNol5Q1sbyH4LlfuJZfOpizw+cIisMpkHZ2e5XtP2A+ZV3xQS8+qKFI+t
        xiEq48IlWmEWDHWcfz/r9m5m20N/kaw=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-253--_D9OjgzMN6BgCvfl_wOBA-1; Mon, 30 Aug 2021 12:58:04 -0400
X-MC-Unique: -_D9OjgzMN6BgCvfl_wOBA-1
Received: by mail-qv1-f70.google.com with SMTP id t12-20020ad45bcc000000b003772069d04aso2546494qvt.19
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 09:58:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=raISjzzXTZAIieU8nOzMirvpJSgfC59Ba/8FkbPMcHk=;
        b=hRNC5uhFDVW6XRzs+bzIVEhWRGWdBY9rq5VLjX6zxsxwcKL7yi1R0WR1zckL2jz8on
         n+FvWpgXUKPQILoTfLxDSQGWXiVi643e8ucPi5MgL96RJrTxFOBGowu8Fv75+BcbGIvd
         w7sKr4uk6S0D8BBepGN836Ag5VkIvJMTdn44xFy/ajzoLGKW472+bGomKSWAosk26lE6
         eoLLs0xQkxKegpz5HI8ui6aVknWGtGOkiF1Uym0LuZpRgrAKZiD0p5z4yyMiBBFSUyTp
         mv841FZbk9glnXqUM9anTTxeJxe21/wokB/oD/AHbuvtjOLPpy0X1oMMDGwLv0YNdIlp
         EXdQ==
X-Gm-Message-State: AOAM532B1REU8ezmjt74vp1B2IuRUgU8fvK+3aaoYwUHaLG49vZNMAFN
        xCAs3J0Uzd2BKHr7mTI6iC8lOOrRG8maJUnnnPVbzCrXtMqzaiFkNSqBH+wIX+1K/PPFrD3Rnol
        +ZvXUqxs1kSclohFkUrfJ2Fgn
X-Received: by 2002:ac8:6601:: with SMTP id c1mr19178994qtp.179.1630342683866;
        Mon, 30 Aug 2021 09:58:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwsd1fcEPuUUh06f8iCPwA7mKsjRLGfmhZzGrmlfV/DO+fudHXPuiEhJVxn8MES4Ogj/P+umw==
X-Received: by 2002:ac8:6601:: with SMTP id c1mr19178971qtp.179.1630342683670;
        Mon, 30 Aug 2021 09:58:03 -0700 (PDT)
Received: from [192.168.8.104] (pool-108-49-102-102.bstnma.fios.verizon.net. [108.49.102.102])
        by smtp.gmail.com with ESMTPSA id j3sm9152085qti.4.2021.08.30.09.58.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 09:58:03 -0700 (PDT)
Message-ID: <db5ae1c8d070509580218a501cfa9caaf3f029e1.camel@redhat.com>
Subject: Re: [PATCH v3] drm/dp_mst: Fix return code on sideband message
 failure
From:   Lyude Paul <lyude@redhat.com>
To:     khsieh@codeaurora.org
Cc:     Jani Nikula <jani.nikula@linux.intel.com>, robdclark@gmail.com,
        sean@poorly.run, swboyd@chromium.org, abhinavk@codeaurora.org,
        aravindh@codeaurora.org, rsubbia@codeaurora.org,
        rnayak@codeaurora.org, freedreno@lists.freedesktop.org,
        airlied@linux.ie, daniel@ffwll.ch,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 30 Aug 2021 12:58:01 -0400
In-Reply-To: <f0fcfe7a73e87150a7a1f042269b76a3@codeaurora.org>
References: <1625585434-9562-1-git-send-email-khsieh@codeaurora.org>
         <87zguy7c5a.fsf@intel.com>
         <a514c19f712a6feeddf854dc17cb8eb5@codeaurora.org>
         <2da3949fa3504592da42c9d01dc060691c6a8b8b.camel@redhat.com>
         <d9ec812b4be57e32246735ca2f5e9560@codeaurora.org>
         <79c5a60fc189261b7a9ef611acd126a41f921593.camel@redhat.com>
         <696a009e2ab34747abd12bda03c103c7@codeaurora.org>
         <e725235a77935184cd20dab5af55da95b28d9e88.camel@redhat.com>
         <64049ef6c598910c1025e0e5802bb83e@codeaurora.org>
         <88b5fbe60c95bcdf42353bec9f8c48aefa864a31.camel@redhat.com>
         <f0fcfe7a73e87150a7a1f042269b76a3@codeaurora.org>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2021-08-30 at 08:56 -0700, khsieh@codeaurora.org wrote:
> On 2021-08-25 09:26, Lyude Paul wrote:
> > The patch was pushed yes (was part of drm-misc-next-2021-07-29), seems 
> > like it
> > just hasn't trickled down to linus's branch quite yet.
> 
> Hi Stephen B,
> 
> Would you mind back porting this patch to V5.10 branch?
> It will have lots of helps for us to support display port MST case.
> Thanks,

I'm assuming you're talking to someone else? A little confused because I don't
see a Stephen B in this thread

> 
> 
> 
> > 
> > On Wed, 2021-08-25 at 09:06 -0700, khsieh@codeaurora.org wrote:
> > > On 2021-07-27 15:44, Lyude Paul wrote:
> > > > Nice timing, you literally got me as I was 2 minutes away from leaving
> > > > work
> > > > for the day :P. I will go ahead and push it now.
> > > > 
> > > Hi Lyude,
> > > 
> > > Had you pushed this patch yet?
> > > We still did not see this patch at msm-nex and v5.10 branch.
> > > Thanks,
> > > 
> > > 
> > > > BTW - in the future I recommend using dim to add Fixes: tags as it'll
> > > > add Cc:
> > > > to stable as appropriate (this patch in particular should be Cc:
> > > > stable@vger.kernel.org # v5.3+). will add these tags when I push it
> > > > 
> > > > On Tue, 2021-07-27 at 15:41 -0700, khsieh@codeaurora.org wrote:
> > > > > On 2021-07-27 12:21, Lyude Paul wrote:
> > > > > > On Thu, 2021-07-22 at 15:28 -0700, khsieh@codeaurora.org wrote:
> > > > > > > 
> > > > > > > It looks like this patch is good to go (mainlined).
> > > > > > > Anything needed from me to do?
> > > > > > > Thanks,
> > > > > > 
> > > > > > Do you have access for pushing this patch? If not let me know and
> > > > > > I
> > > > > > can
> > > > > > go
> > > > > > ahead and push it to drm-misc-next for you.
> > > > > no, I do not have access to drm-misc-next.
> > > > > Please push it for me.
> > > > > Thanks a lots.
> > > > > 
> > > 
> 

-- 
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat

