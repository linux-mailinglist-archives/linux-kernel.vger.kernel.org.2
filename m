Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76E70345234
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 23:07:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbhCVWGv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 18:06:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21919 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229639AbhCVWGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 18:06:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616450801;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=F0xmtxsbrSY/EqwRbgt4RPB4j15Yx4zHQ1t04X/H0aY=;
        b=Uz0bddkabAQ7wuvGX6aio3ZCqbe4od7WI6yp7+YAixHP2c5lUILFgh+I48DGgt1jixl4P8
        XZCxJLEcwWgc+UpcWL6ZyiImVRR3r3d7Kp3863rCHjWhORE35pqfY47N7U7sfeLlk0JRkX
        F0z1xc5i9h+CaY6nlg4ypvosZ5M9wTI=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-333-hwUMhgAROgqk-_tU0IdSHw-1; Mon, 22 Mar 2021 18:06:39 -0400
X-MC-Unique: hwUMhgAROgqk-_tU0IdSHw-1
Received: by mail-qv1-f72.google.com with SMTP id s16so384189qvw.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 15:06:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=F0xmtxsbrSY/EqwRbgt4RPB4j15Yx4zHQ1t04X/H0aY=;
        b=oigGGAf52GTq++GWj5HYMOw8iRv6A8eopPByN31N1iLW0cZ+GW4juDla0goKxCxnOQ
         p7JJVFRkeqYEJH5ylcwdzPhT8K/y7aAe7+iQaaFuI1MB04IGNt0BfO5xsmpPtUoYxud5
         NyaaUL7RyebIafGrwHJACpQr0uM4I0zwJogp7GqFpKls4se060gcbcl7cM/v3zm4AvKH
         jYpe1k0Qz8wxwDJ/Ac/0F3t9dAnTxhZsbPRbsb+TNl435Wip7eTumLjcy9s7txyeloye
         tLz/lt/vPTmphhJBPFnCiq+1+neO4LL6h1L4bEP5sS+bExctZpAoPEOe+jSTT6xhe1FW
         yfkQ==
X-Gm-Message-State: AOAM532MDi7+cCNxSpXz/ZPWsYbfUDFtiljLJA5N0b74GD4BLOdEnsHB
        oWFbMXBa57OWtcJNar3xS9SvK2nhFjQaHMjKJo3IAxW+tPTnSaPJJKn+S+OmFEf2rbx6vu3CoMM
        Kd+AUxQwIfGDEsp8XgDtDAJmQ
X-Received: by 2002:a05:620a:13a6:: with SMTP id m6mr2400185qki.64.1616450798822;
        Mon, 22 Mar 2021 15:06:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyBNVJY3fOU+3jm44Dl1dmP6P13HIl+FnxCKWahujf02BY3Hnwz4gLC5NeCUL7ioqbJgIVFxw==
X-Received: by 2002:a05:620a:13a6:: with SMTP id m6mr2400163qki.64.1616450798573;
        Mon, 22 Mar 2021 15:06:38 -0700 (PDT)
Received: from xz-x1 (bras-base-toroon474qw-grc-82-174-91-135-175.dsl.bell.ca. [174.91.135.175])
        by smtp.gmail.com with ESMTPSA id 85sm12351357qkf.58.2021.03.22.15.06.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 15:06:37 -0700 (PDT)
Date:   Mon, 22 Mar 2021 18:06:36 -0400
From:   Peter Xu <peterx@redhat.com>
To:     "Alejandro Colomar (man-pages)" <alx.manpages@gmail.com>
Cc:     linux-man@vger.kernel.org, Andrea Arcangeli <aarcange@redhat.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        linux-kernel@vger.kernel.org,
        Linux MM Mailing List <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nadav Amit <nadav.amit@gmail.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 4/4] ioctl_userfaultfd.2: Add write-protect mode docs
Message-ID: <20210322220636.GI16645@xz-x1>
References: <20210310222300.200054-1-peterx@redhat.com>
 <20210310222300.200054-5-peterx@redhat.com>
 <5c533ba3-f335-0681-223f-bf2202a9b72a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5c533ba3-f335-0681-223f-bf2202a9b72a@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 19, 2021 at 11:37:20PM +0100, Alejandro Colomar (man-pages) wrote:
> Hi Peter,

Hi, Alex,

> > +generate another write-protect userfault message.
> > +This is only used in conjunction with write-protect mode when both missing and
> 
> "when both missing"
> 
> both what?

I modified it to:

        This is only used when both
        .B UFFDIO_REGISTER_MODE_MISSING
        and
        .B UFFDIO_REGISTER_MODE_WP
        modes are enabled for the registered range.

And I fixed all the rest, including all the comments in patch 3.

Thanks for looking, I'll repost shortly.

-- 
Peter Xu

