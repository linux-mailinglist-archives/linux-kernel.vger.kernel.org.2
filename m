Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78D3B30C9C8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 19:30:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238691AbhBBS3D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 13:29:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59796 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238416AbhBBS0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 13:26:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612290306;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AnGr4EooSXaQZ5ZRROa4NLkKWgLW6n+u1Od1EbAD4Lg=;
        b=biARlsBi1lrpONqG0jvHMLhzaRtq+GxkFyqj+3QnsXljf34B/qdIfO044QuSGHt0St74yK
        VUFQs8Jf6Dh8hAiUGJlwVvIPqYYUplIXHlpqgXs3AilpG4tNSUTqWoh2UWa+olLjRWps4w
        qnrekvX39SCzXTcsa2XKPS+H7CDKP/4=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-379-IYUK043KPFKmbigvanqxNg-1; Tue, 02 Feb 2021 13:24:57 -0500
X-MC-Unique: IYUK043KPFKmbigvanqxNg-1
Received: by mail-qv1-f71.google.com with SMTP id h13so15607708qvs.13
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 10:24:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:reply-to:to:cc:date
         :in-reply-to:references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=AnGr4EooSXaQZ5ZRROa4NLkKWgLW6n+u1Od1EbAD4Lg=;
        b=oTqjUKyP2nhuGV+Cykbul+e7DC60dEZADMPt/BlYgKS84ELCqu3o3FY34eLH83jlGX
         2t05m1N6Cc9Y7F7iqg3NKLcjNKce+JLgnJXNiaZlGDYjiDvJTX+j70CfVfp0h+PvmNSC
         YTA2pLdFuNsxFE0+7igfcaiNTC2ksFGny1goOEFzAlWxINZElnjiZqNP1A73gh4a1PG6
         hzl73SXH0aWoWD5qQM238kMECrj+U0rzNcjuiY4ItzmReGJcmmKotX4zNaWTc0vpsRwJ
         pd3Ak/kNZDA8RAlaMrZmn6YkYVL/pdbiHwVa+tLOlknNyEwHMW73qHhzrdj3KDkeRhfg
         p+mw==
X-Gm-Message-State: AOAM531GnmEsqqQIswX0c4f5Kh0CX8R4hKbm1tqDOEZp48o7ldgnHMhh
        RP9Q6lawbkKeyNofwxQt1McOYuK0sfgb13qvUskZ5z1n5fFv4MhYSHT0eu0eOmSmYMCKSehthWh
        mhKtHfALM+qcTpUUr5wTTZQ1X
X-Received: by 2002:a05:6214:324:: with SMTP id j4mr21390769qvu.53.1612290297359;
        Tue, 02 Feb 2021 10:24:57 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw5CH5N3KAln06tkbRsEidyvbDgmef52F3iN9tUMNV+94ggr3F3Qn9K6XQ4RRxyy8rmKeIvmA==
X-Received: by 2002:a05:6214:324:: with SMTP id j4mr21390743qvu.53.1612290297144;
        Tue, 02 Feb 2021 10:24:57 -0800 (PST)
Received: from Whitewolf.lyude.net (pool-108-49-102-102.bstnma.fios.verizon.net. [108.49.102.102])
        by smtp.gmail.com with ESMTPSA id j125sm17584722qke.56.2021.02.02.10.24.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 10:24:56 -0800 (PST)
Message-ID: <a06e4ebe71f6809a772efc43592739e46b022b0e.camel@redhat.com>
Subject: Re: [Linaro-mm-sig] [PATCH 08/29] dma-buf: Avoid comma separated
 statements
From:   Lyude Paul <lyude@redhat.com>
Reply-To: lyude@redhat.com
To:     christian.koenig@amd.com, Joe Perches <joe@perches.com>,
        Jiri Kosina <trivial@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>
Cc:     linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org
Date:   Tue, 02 Feb 2021 13:24:55 -0500
In-Reply-To: <ad79432b-9c83-ce5a-f8ca-ec45bb55fb2c@gmail.com>
References: <cover.1598331148.git.joe@perches.com>
         <990bf6f33ccaf73ad56eb4bea8bd2c0db5e90a31.1598331148.git.joe@perches.com>
         <a87b95d11c22d997ebc423bba71cabef15ca0bac.camel@perches.com>
         <4d5891b7-ea87-974e-d260-f78c3af326bc@amd.com>
         <4266568da0437ea605bfb2810ead2b05475bfbb8.camel@redhat.com>
         <ad79432b-9c83-ce5a-f8ca-ec45bb55fb2c@gmail.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3 (3.38.3-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2021-02-02 at 09:33 +0100, Christian König wrote:
> Yeah, known issue.
> 
> An NTP server which I don't have access to has gone bananas and 
> sometimes spits out invalid time stamps.
> 
> Only thing I can do is wait for an admin to take care of this.

haha it's ok! I just thought it was mildly entertaining to see, as my email
client formatted the message timestamp "Next Wednesday" :)

> 
> Christian.
> 
> Am 01.02.21 um 22:54 schrieb Lyude Paul:
> > This is entirely unrelated to this thread, but I noticed when going through
> > dri-
> > devel that this email is somehow dated two days in the future from now.
> > 
> > On Wed, 2021-02-03 at 14:26 +0100, Christian König wrote:
> > > Am 30.01.21 um 19:47 schrieb Joe Perches:
> > > > On Mon, 2020-08-24 at 21:56 -0700, Joe Perches wrote:
> > > > > Use semicolons and braces.
> > > > Ping?
> > > >    
> > > > > Signed-off-by: Joe Perches <joe@perches.com>
> > > Reviewed-by: Christian König <christian.koenig@amd.com>
> > > 
> > > Do you have commit rights to drm-misc-next?
> > > 
> > > > > ---
> > > > >    drivers/dma-buf/st-dma-fence.c | 7 +++++--
> > > > >    1 file changed, 5 insertions(+), 2 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/dma-buf/st-dma-fence.c b/drivers/dma-buf/st-dma-
> > > > > fence.c
> > > > > index e593064341c8..c8a12d7ad71a 100644
> > > > > --- a/drivers/dma-buf/st-dma-fence.c
> > > > > +++ b/drivers/dma-buf/st-dma-fence.c
> > > > > @@ -471,8 +471,11 @@ static int thread_signal_callback(void *arg)
> > > > >                          dma_fence_signal(f1);
> > > > >    
> > > > > 
> > > > >                  smp_store_mb(cb.seen, false);
> > > > > -               if (!f2 || dma_fence_add_callback(f2, &cb.cb,
> > > > > simple_callback))
> > > > > -                       miss++, cb.seen = true;
> > > > > +               if (!f2 ||
> > > > > +                   dma_fence_add_callback(f2, &cb.cb,
> > > > > simple_callback)) {
> > > > > +                       miss++;
> > > > > +                       cb.seen = true;
> > > > > +               }
> > > > >    
> > > > > 
> > > > >                  if (!t->before)
> > > > >                          dma_fence_signal(f1);
> > > _______________________________________________
> > > dri-devel mailing list
> > > dri-devel@lists.freedesktop.org
> > > https://lists.freedesktop.org/mailman/listinfo/dri-devel
> 

-- 
Sincerely,
   Lyude Paul (she/her)
   Software Engineer at Red Hat
   
Note: I deal with a lot of emails and have a lot of bugs on my plate. If you've
asked me a question, are waiting for a review/merge on a patch, etc. and I
haven't responded in a while, please feel free to send me another email to check
on my status. I don't bite!

