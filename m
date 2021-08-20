Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C0A13F2D51
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 15:43:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235334AbhHTNnt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 09:43:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42079 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229829AbhHTNns (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 09:43:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629466990;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4KjTjMbm6Ax2NoBz/SV8LRb7ROzLCYCzwIW7Ojvzm8c=;
        b=YD78ABzr1tiHYUcQ9Uf1Mp+hjDhEdBPds4spo57vKYHDE1dP7+0sxWSDjDU2Mi5FyvNc/t
        eXMPlVLP0WIIRKNAJHUpvkyOZbG+EiXEH6tmdyL1RgBJX/n+Ui2Mmqh7G4vIsIBkfbosGv
        D0PscFhC69sIV3VSvj6aOvtYho3guuA=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-603-gzy_ZX8bPEmHEBwKjp6i1w-1; Fri, 20 Aug 2021 09:41:46 -0400
X-MC-Unique: gzy_ZX8bPEmHEBwKjp6i1w-1
Received: by mail-ej1-f70.google.com with SMTP id s11-20020a170906060b00b005be824f15daso3732282ejb.2
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 06:41:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=4KjTjMbm6Ax2NoBz/SV8LRb7ROzLCYCzwIW7Ojvzm8c=;
        b=JGTAeQX/Yro+fqudcdaUE0y1t0kylszj4e22JL1NlblfAFTVMR7asm0bRTuAzk71K9
         TScUedK2wH2orOb9Jp5chO6aPhtkHva6+1dkQCwQYw7eYbkRltC/9Kc4vWoPFYP559Bt
         vpIJI0HDhysI1zpT1xX4NihTzh/GmKGvZgjNKrdZXa7cZnXr76pQ6yYSOdGHlfCJ72bN
         POGoF6YPJz2lZAmVPo5O9TbZFa/1C3GKxNin/8BwOgT9Rx7j9+nfl9X4TZFDtZyfipLN
         xhF0F+wEdmj1T9i3f4gqPofUpDjx2Tp2BINad0xT1CMaT2r5sERRt8F57pf+hm+VNLAj
         5aHg==
X-Gm-Message-State: AOAM533AxQq8FtlEUgLRs8Kz2b835G0G+2PM5xMoa/SsMUKjrUsa/EF6
        caSibScu9qDqraKBiYD191c0zBKBo00+UO8AUnTFiB4WS8++Vuow7/vyrgQ/LNoAyYxbUZdpgxG
        ypU6xVl0fED/fiK8pVRHjzt9f
X-Received: by 2002:aa7:db8b:: with SMTP id u11mr22178966edt.362.1629466893416;
        Fri, 20 Aug 2021 06:41:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx0hLwN+s7rk8F847DLOmn4dy1Ao93kGJxxgV8+oY8fbxG+6Lejz40d6vR1Ye9lqW0fsphjXg==
X-Received: by 2002:aa7:db8b:: with SMTP id u11mr22178939edt.362.1629466893221;
        Fri, 20 Aug 2021 06:41:33 -0700 (PDT)
Received: from 0.7.3.c.2.b.0.0.0.3.7.8.9.5.0.2.0.0.0.0.a.d.f.f.0.b.8.0.1.0.0.2.ip6.arpa (0.7.3.c.2.b.0.0.0.3.7.8.9.5.0.2.0.0.0.0.a.d.f.f.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:ffda:0:2059:8730:b2:c370])
        by smtp.gmail.com with ESMTPSA id g14sm3636121edr.47.2021.08.20.06.41.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Aug 2021 06:41:32 -0700 (PDT)
Message-ID: <2508f12f0d2a5eedaad0c6b77657f53222b33e3c.camel@redhat.com>
Subject: Re: [Cluster-devel] [PATCH v6 10/19] gfs2: Introduce flag for glock
 holder auto-demotion
From:   Steven Whitehouse <swhiteho@redhat.com>
To:     Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>, cluster-devel@redhat.com,
        linux-fsdevel@vger.kernel.org, ocfs2-devel@oss.oracle.com
Date:   Fri, 20 Aug 2021 14:41:32 +0100
In-Reply-To: <cf284633-a9db-9f88-6b60-4377bc33e473@redhat.com>
References: <20210819194102.1491495-1-agruenba@redhat.com>
         <20210819194102.1491495-11-agruenba@redhat.com>
         <5e8a20a8d45043e88013c6004636eae5dadc9be3.camel@redhat.com>
         <cf284633-a9db-9f88-6b60-4377bc33e473@redhat.com>
Organization: Red Hat UK Ltd
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 2021-08-20 at 08:11 -0500, Bob Peterson wrote:
> On 8/20/21 4:35 AM, Steven Whitehouse wrote:
> > Hi,
> > 
> > On Thu, 2021-08-19 at 21:40 +0200, Andreas Gruenbacher wrote:
> > > From: Bob Peterson <rpeterso@redhat.com>
> > > 
> > > This patch introduces a new HIF_MAY_DEMOTE flag and
> > > infrastructure
> > > that
> > > will allow glocks to be demoted automatically on locking
> > > conflicts.
> > > When a locking request comes in that isn't compatible with the
> > > locking
> > > state of a holder and that holder has the HIF_MAY_DEMOTE flag
> > > set,
> > > the
> > > holder will be demoted automatically before the incoming locking
> > > request
> > > is granted.
> > > 
> > I'm not sure I understand what is going on here. When there are
> > locking
> > conflicts we generate call backs and those result in glock
> > demotion.
> > There is no need for a flag to indicate that I think, since it is
> > the
> > default behaviour anyway. Or perhaps the explanation is just a bit
> > confusing...
> 
> I agree that the whole concept and explanation are confusing.
> Andreas 
> and I went through several heated arguments about the symantics, 
> comments, patch descriptions, etc. We played around with many
> different 
> flag name ideas, etc. We did not agree on the best way to describe
> the 
> whole concept. He didn't like my explanation and I didn't like his.
> So 
> yes, it is confusing.
> 
That seems to be a good reason to take a step back and look at this a
bit closer. If we are finding this confusing, then someone else looking
at it at a future date, who may not be steeped in GFS2 knowledge is
likely to find it almost impossible.

So at least the description needs some work here I think, to make it
much clearer what the overall aim is. It would be good to start with a
statement of the problem that it is trying to solve which Andreas has
hinted at in his reply just now,

Steve.


