Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFAF33ABE84
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 00:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231651AbhFQWDp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 18:03:45 -0400
Received: from mail-io1-f48.google.com ([209.85.166.48]:42610 "EHLO
        mail-io1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231249AbhFQWDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 18:03:44 -0400
Received: by mail-io1-f48.google.com with SMTP id s26so1530277ioe.9
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 15:01:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0jCUxN5VHbSW7yt0ADd96KTkL0vWh52LCH6fuo5IQ6o=;
        b=qorarSrslEoCvfSHtdRVpU/fcmCou3+v8F+alTL7SW0xSPjq2J4CRkdF82VR0BIRzf
         CPWxNajJEYSwtDXDtcs852L8S1dSt7gmPpd2B/EBg7R5kzkGhv+2t3IXekWtcFDH4QC1
         68HXf6t59O5akakxsagmIdW4JwbdpDWjDTvdCKQITeOfAv9q3+ANkD8kwDca+aAuw4sJ
         1qiW+NGvZ3cAKc5dZhSUIKiE8S/RKxXb9PuO5foLkZFr+DYe2ltjaq0ojJ65x+UPQnK7
         T7hQEhoCFFkc5KCLLL/YbsVL0D5CMVL1IJ4Iq6u2LCyPue1Q6qCI6QPtDhfNGVuNDPTa
         YmZw==
X-Gm-Message-State: AOAM5318lARRUOCJxarVDPliPfEiB02r0E5acgTjb4HJ9Ai4Ytpt/dbp
        zute9C2QzCiZeHZYFtpFKLQ=
X-Google-Smtp-Source: ABdhPJzZezAeX+10l0RtyH2LwFjrlZTciRKNZU8/wa4NlvJjN3TjD369mvVHqO9ZrhRcKYBIojYZjw==
X-Received: by 2002:a05:6602:2c4e:: with SMTP id x14mr5472295iov.194.1623967295221;
        Thu, 17 Jun 2021 15:01:35 -0700 (PDT)
Received: from google.com (243.199.238.35.bc.googleusercontent.com. [35.238.199.243])
        by smtp.gmail.com with ESMTPSA id f7sm996452ioc.18.2021.06.17.15.01.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 15:01:34 -0700 (PDT)
Date:   Thu, 17 Jun 2021 22:01:33 +0000
From:   Dennis Zhou <dennis@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Roman Gushchin <guro@fb.com>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] percpu: optimize locking in pcpu_balance_workfn()
Message-ID: <YMvGPWHY993l3OYj@google.com>
References: <20210617190322.3636731-1-guro@fb.com>
 <YMuo55c9QM91pc9p@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YMuo55c9QM91pc9p@casper.infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Thu, Jun 17, 2021 at 08:56:23PM +0100, Matthew Wilcox wrote:
> On Thu, Jun 17, 2021 at 12:03:22PM -0700, Roman Gushchin wrote:
> > +++ b/mm/percpu.c
> > @@ -1980,6 +1980,9 @@ void __percpu *__alloc_reserved_percpu(size_t size, size_t align)
> >   * If empty_only is %false, reclaim all fully free chunks regardless of the
> >   * number of populated pages.  Otherwise, only reclaim chunks that have no
> >   * populated pages.
> > + *
> > + * CONTEXT:
> > + * pcpu_lock (can be dropped temporarily)
> >   */
> 
> What's the shouting all about?  I would write it like this:

At this point it's just to keep the code consistent.

> 
>  * Context: Process context.  Caller must hold pcpu_lock with interrupts
>  * disabled.  This function may drop the lock and re-enable interrupts if
>  * it needs to sleep, but will return with the lock held and interrupts
>  * disabled.
> 

This is related to background work done via a workqueue not in process
context. I'll take a look at cleaning up the documentation in the
future.

Thanks,
Dennis
