Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A8323F3697
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Aug 2021 00:41:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240157AbhHTWmZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 18:42:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:40676 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231274AbhHTWmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 18:42:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629499305;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PMddBmsWMWI5jF8CTPkKHEEdWMRR3jjcIFCbvP295Do=;
        b=dKwnLylpUw6qBu2tEEtx2HzlD/+cneULZulYHwexedSpnxaA4hmlAd4YjjEmwaZ+ODeXup
        2FXHMzpzlgZ8YgmggT7vqQezrTwmPy5lOahzQjqwH+3QmRvw6Dzwx9iuwLcFw4922h3yzc
        JaMTUJ1hreM20++pkfhP4odnXTYYoGM=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-430-kZ7CDvcROE6_PWJIGSoTiA-1; Fri, 20 Aug 2021 18:41:44 -0400
X-MC-Unique: kZ7CDvcROE6_PWJIGSoTiA-1
Received: by mail-ot1-f69.google.com with SMTP id h38-20020a9d14290000b02904ceed859e6eso5501784oth.21
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 15:41:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=PMddBmsWMWI5jF8CTPkKHEEdWMRR3jjcIFCbvP295Do=;
        b=M7S4bjBYJqyKsHV+/UAb44uupn662sf0tWhYkDipYLaPVrY5aO9jGqwaS0tIu6DtFb
         0zrIc8xbr3AVxx9ItAMNh4okvYaqj+JPSYJbh5nft2X93rNYYodZ/3admXQn7JwVtcQN
         Fjx62A78iRtQKAKBwkd9tkRPjI5g95gA7taJtnUJI9vGT/nl5fP0XqiSsw4UgJTVakBP
         rAJAEnSL7nS3bvg6BYjRhbdJBBBzjiGzReDbBSbEolh2OcmQPCw+w8lSd0UaSJuv8HKE
         8ir2Nd8wGnnDve5BvItZ3O2PbgxAOF7wnkW8lx5on55Gca+XmJOA9UpvIfBjsmCL8Wpd
         YSbA==
X-Gm-Message-State: AOAM532m42o1vZfptpYVUXt2fkE6BXrO7j9s5hQqc03znM5GHgYXDf79
        nnrwxzTosKsZ1pLyCz48/uIUwRKnBaBbZNCuE+R/CkSOd5bUrXfaczOq6dNns7LYOp/7xI3m/pz
        HuPdlczLx39sde4y/B8Iagqda
X-Received: by 2002:a9d:7a8a:: with SMTP id l10mr19044161otn.256.1629499303769;
        Fri, 20 Aug 2021 15:41:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwcFQXjKweunIGJyfApLENZn5qAh9f4tNkrZ9b1APukTQz366kMOunJGqWYj0xce16/nBRqGw==
X-Received: by 2002:a9d:7a8a:: with SMTP id l10mr19044147otn.256.1629499303534;
        Fri, 20 Aug 2021 15:41:43 -0700 (PDT)
Received: from redhat.com ([198.99.80.109])
        by smtp.gmail.com with ESMTPSA id o4sm1762132oik.49.2021.08.20.15.41.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Aug 2021 15:41:43 -0700 (PDT)
Date:   Fri, 20 Aug 2021 16:41:42 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Tony Krowiak <akrowiak@linux.ibm.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        cohuck@redhat.com, pasic@linux.vnet.ibm.com, jjherne@linux.ibm.com,
        kwankhede@nvidia.com, david@redhat.com
Subject: Re: [PATCH 1/2] s390/vfio-ap: r/w lock for PQAP interception
 handler function pointer
Message-ID: <20210820164142.1dcea352.alex.williamson@redhat.com>
In-Reply-To: <d905d1fa-2852-4fb7-5b56-4b3b12d8994f@linux.ibm.com>
References: <20210719193503.793910-1-akrowiak@linux.ibm.com>
        <20210719193503.793910-2-akrowiak@linux.ibm.com>
        <1a9f15d7-0f4d-00a0-0a8b-f1c08aa52eeb@de.ibm.com>
        <358b1052-c751-7417-1263-308b133325b6@linux.ibm.com>
        <20210819115433.76153ae4.alex.williamson@redhat.com>
        <20210819175807.GC1721383@nvidia.com>
        <d905d1fa-2852-4fb7-5b56-4b3b12d8994f@linux.ibm.com>
Organization: Red Hat
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Aug 2021 18:05:08 -0400
Tony Krowiak <akrowiak@linux.ibm.com> wrote:

> On 8/19/21 1:58 PM, Jason Gunthorpe wrote:
> > On Thu, Aug 19, 2021 at 11:54:33AM -0600, Alex Williamson wrote:
> >  
> >> Nope.  The only requests for merges through my tree that I'm aware of
> >> were [1] and what I understand was the evolution of that here now [2].
> >> Maybe you're thinking of [3], which I do see in mainline where this was
> >> 2/2 in that series but afaict only patch 1/2 was committed.  I guess
> >> that explains why there was no respin based on comments for this patch.
> >> Thanks,  
> > Tony,
> >
> > If you take Alex's tree from here:
> >
> > https://github.com/awilliam/linux-vfio/commits/next  
> 
> I navigated to this URL and clicked the green 'Code'
> button. I was given the option to download the zip file or
> use git to checkout the code at the URL displayed
> 'https://github.com/awilliam/linux-vfio.git'. I cloned the
> repo at that URL and the code was definitely not in any
> way similar to my code base. In particular, the
> arch/s390/include/asm/kvm_host.h file did not have any
> of the crypto structures.
> 
> I then downloaded the zip file and expanded it. The code
> looked legitimate, but this was not a git repository, so I
> had no way to cherry-pick my patches nor format patches
> to post to this mailing list.
> 
> Next, I tried cloning from 
> 'https://github.com/awilliam/linux-vfio-next.git',
> but I was prompted for uid/pw.
> 
> So, the question is, how to I get the linux-vfio-next repo upon which I
> can rebase my patches? I apologize for my ignorance.

You can use git fetch to download the objects, ex:

$ git fetch git://github.com/awilliam/linux-vfio.git next
$ git checkout FETCH_HEAD

Or you could add a remote, ex:

$ git remote add vfio git://github.com/awilliam/linux-vfio.git
$ git remote update vfio
$ git checkout vfio/next

The former might be easier and add a lot less crufty objects to your
local tree if this is a one-off activity.  Thanks,

Alex

