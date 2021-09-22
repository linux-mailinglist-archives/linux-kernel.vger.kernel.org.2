Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CCCB414F2D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 19:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236797AbhIVRek (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 13:34:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45767 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236753AbhIVReb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 13:34:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632331981;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MZ4chEPGfSUbQ0+WB80DpWY3pUb3ySacIIiH07OzzAA=;
        b=M7IB6PCnAqwaU1XXmmi2xx9F9fk2w9V8021o14jQPv+UbIF8Sjloj+kgQRBCj4zFGU5LlV
        Nd4rthDeJ77f8jwdbGX+HUQ/K+CoSHqsfTOLb9ENu8ns9V0xN21Cz/03VsByTtjHQj2YJu
        AFblJ/g80Re3JxvpGHkvymTpdf9IxV0=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-381-KS6YxbhpM9KDtZ3N8WwqiA-1; Wed, 22 Sep 2021 13:32:59 -0400
X-MC-Unique: KS6YxbhpM9KDtZ3N8WwqiA-1
Received: by mail-qv1-f72.google.com with SMTP id u6-20020ad449a6000000b003798010ad14so13406723qvx.10
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 10:32:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MZ4chEPGfSUbQ0+WB80DpWY3pUb3ySacIIiH07OzzAA=;
        b=0O+YpI8Z7dEvEg4N+hClhd/LogoXnlDZJEUaprHiLNBb+5dW8utDTk1KsVegOBri0G
         fzM6vEX+QkdNRkbobV1Oxbp3pVzclekae7URnVk6FqLW49H5n+C1kfrMGKsPVCaggu9o
         8P0YpaxpesSXRXgEBr1a0Dqirhne5O3wO9JCCTKwNLSK+EKYhzrfooYQHixzAfSjTfa8
         gohkQnErF/kpYjArro5ZnmkApm+ctnagd/b3Zsg5sJStxjdiOhZunO+qKgS59THoO/w6
         yhGeYtqFtwu4c0SxOBDNF8ErFKGaFSgV4t4y+D01ra1l1GGRSYRJ1j3OXPsfIgWACopk
         9rHw==
X-Gm-Message-State: AOAM530/A3KMk0Ccxp228NSFlfL6vJPznnUbj639ml5LTNE/WZBjjJX6
        UYdACVl+6/vZheIk8jg7IyH+gSCwJnaIF4FUGX9+8S1tVtUwOZLrJ0QvAv/6hLd9pVPNKvJr9g4
        hu8nie3mI4SWKFHqEanhV91Qy
X-Received: by 2002:a37:a394:: with SMTP id m142mr441170qke.62.1632331979231;
        Wed, 22 Sep 2021 10:32:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxW3s8uMYgBcSDjxDYcpMGPxHXsr8QBkq7aoss9LqopmKZ+usF6kGL5uVjE8LbpBJf8Uk26UQ==
X-Received: by 2002:a37:a394:: with SMTP id m142mr441144qke.62.1632331978972;
        Wed, 22 Sep 2021 10:32:58 -0700 (PDT)
Received: from t490s ([2607:fea8:56a2:9100::d3ec])
        by smtp.gmail.com with ESMTPSA id j26sm1821108qtr.53.2021.09.22.10.32.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 10:32:57 -0700 (PDT)
Date:   Wed, 22 Sep 2021 13:32:56 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, Linux MM <linux-mm@kvack.org>,
        Linuxkselftest <linux-kselftest@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] userfaultfd/selftests: fix feature support detection
Message-ID: <YUtoyNic4Jxfv9f7@t490s>
References: <20210921163323.944352-1-axelrasmussen@google.com>
 <YUoaDr2wsW8wtk5Z@t490s>
 <CAJHvVcj68inRrpmw0pJq9qFc20JzG8+s7b31HkXQcsLcAJN_0Q@mail.gmail.com>
 <YUowr6phZU4v7dds@t490s>
 <CAJHvVcgz18qU9vjPimOhJ5YswfJnLN0tQGfsgjCh6M7ckvhfgA@mail.gmail.com>
 <YUp438W5p5VHL1Ch@t490s>
 <CAJHvVciZc0mpcw8OSPk71YsVzCTajY+ikymcD3+zBJKsZynYkg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJHvVciZc0mpcw8OSPk71YsVzCTajY+ikymcD3+zBJKsZynYkg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Axel,

On Wed, Sep 22, 2021 at 10:04:03AM -0700, Axel Rasmussen wrote:
> Thanks for discussing the design Peter. I have some ideas which might
> make for a nicer v2; I'll massage the code a bit and see what I can
> come up with.

Sure thing.  Note again that as I don't have a strong opinion on that, feel
free to keep it.  However if you provide v2, I'll read.

[off-topic below]

Another thing I probably have forgot but need your confirmation is, when you
worked on uffd minor mode, did you explicitly disable thp, or is it allowed?

When I'm reworking the uffd-wp series, I noticed that commit e1e267c7928f
("khugepaged: skip collapse if uffd-wp detected", 2020-04-07) was actually
awkward and not efficient, as we can simply lookup the vma flags for detecting
uffd-wp enablement.  I'm preparing a patch for it to do it by checking vmas
(and that patch will also pave the way for file-backed).

Then I noticed we need similar thing for minor mode?

I think the answer is yes, but I didn't see any code that explicitly handled
thp for minor mode, do you remember?

To be explicit, what if in mcontinue_atomic_pte() we get a shmem_getpage() call
with a thp returned?  Will minor mode break?

I plan to post the khugepaged patch soon and I plan to cover minor mode too
there, but I'm not sure whether that's enough, as the thp can be there from the
1st day I think, but I could have missed something.

-- 
Peter Xu

