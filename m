Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2138F413EA5
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 02:29:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbhIVAay (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 20:30:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41299 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229480AbhIVAax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 20:30:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632270563;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NmEXaXF/Zeuy5snsjO8cTG6bYqexhCWu35mF9eZUaWg=;
        b=AzFDPB0imFshaOw23EtGuiiOI8QdBcIKMSjqeeDEgxu3+VoXn9adsJPfTcoeTeL9PwnMQ1
        e76OaxROXPhb06YOl0nUrtw7s1DwtcGA4r3YEXwUvoErXYFfEiDLRMglsj2ZQlAPolaPWN
        T5IsW+kH2ZiMmyHfrgWMuOu0TVZPchw=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-551-fkDM0wCiMmOpdsJqkslTGg-1; Tue, 21 Sep 2021 20:29:22 -0400
X-MC-Unique: fkDM0wCiMmOpdsJqkslTGg-1
Received: by mail-qt1-f200.google.com with SMTP id e5-20020ac84905000000b002a69dc43859so5457944qtq.10
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 17:29:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NmEXaXF/Zeuy5snsjO8cTG6bYqexhCWu35mF9eZUaWg=;
        b=pIAEyrPoqMxxNiOBxD8Z6IgJfc45oMddKHaGvkopecno/d2GaUubGIRtt2RCVcg8xZ
         c6fUxTdIbNGq2ZEgtPrjorEohFx6l9n5NpYpKBkS8T5Ntlk0SiqVc5nflXYC+Jah9wdI
         D9bWQoe5y1UDmtwX7buwoHxXBEx4LCBZMZ2W4O7c5fCWfPQWxfaZbQ+4SIKXqfyFKgSq
         Ia4wUBRKnTFWmk/Ee0ueI+dcIBtIZG1q5e5VUOuRixvQ16assPCTGBsJG2cv5HzHogcH
         706tsVqQOhu40H+2WSncZaRHDt3CwmemVuVBy8Xa80RKH/jw0lF8LyGQpd/S5qnALV0X
         TrQA==
X-Gm-Message-State: AOAM530GtKEuX7BUL8qx212JtzbjLDN2sjzbenHIRkzSa63aFNizKFd+
        32XuWNbrR5QkLrhgF33ataqxVsN7oMUUpeGnHqgBSvLlBWWPte1uHO3au9abuBkW2pKoSwLTplt
        OwWPVWZh130Hh0N7xu/4gg/P+
X-Received: by 2002:a05:620a:524:: with SMTP id h4mr3517158qkh.320.1632270561731;
        Tue, 21 Sep 2021 17:29:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzp8OHGlxNnMNUsKkbTB5lbA+kEvBE9p0uF3GnGKhmEwdsDq6bdIOgUAQGlx7CMSNBruskFFA==
X-Received: by 2002:a05:620a:524:: with SMTP id h4mr3517145qkh.320.1632270561484;
        Tue, 21 Sep 2021 17:29:21 -0700 (PDT)
Received: from t490s ([2607:fea8:56a2:9100::d3ec])
        by smtp.gmail.com with ESMTPSA id i6sm416278qtx.40.2021.09.21.17.29.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 17:29:20 -0700 (PDT)
Date:   Tue, 21 Sep 2021 20:29:19 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, Linux MM <linux-mm@kvack.org>,
        Linuxkselftest <linux-kselftest@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] userfaultfd/selftests: fix feature support detection
Message-ID: <YUp438W5p5VHL1Ch@t490s>
References: <20210921163323.944352-1-axelrasmussen@google.com>
 <YUoaDr2wsW8wtk5Z@t490s>
 <CAJHvVcj68inRrpmw0pJq9qFc20JzG8+s7b31HkXQcsLcAJN_0Q@mail.gmail.com>
 <YUowr6phZU4v7dds@t490s>
 <CAJHvVcgz18qU9vjPimOhJ5YswfJnLN0tQGfsgjCh6M7ckvhfgA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJHvVcgz18qU9vjPimOhJ5YswfJnLN0tQGfsgjCh6M7ckvhfgA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 21, 2021 at 01:31:12PM -0700, Axel Rasmussen wrote:
> Ah, it has to do with us asserting the list of expected ioctls. The
> kernel changes the list of ioctls it reports in response to a
> UFFDIO_REGISTER, depending on the particular kind of vma being
> registered, **as well as what mode(s) it is being registered with**.
> 
> So for example, consider the hugetlb_shared test. When registering,
> the kernel might set the UFFDIO_CONTINUE bit or not, depending on
> whether we registered with the MINOR mode bit set in particular.

I can understand your point, but the "capability set" of the kernel is still
the same.  In this case we should have UFFDIO_CONTINUE capability for
hugetlb_shared test globally, as long as the kernel supports it, irrelevant of
what test case we're going to have.

Then in the test, if we don't register with MINOR mode, IMHO we should just
mask out the expected_ioctls with UFFDIO_CONTINUE because it does not make
sense to request UFFDIO_CONTINUE if we will never use it in the test.

In other words, having a "uffd_features" global variable and having it changing
all the time during tests is odd to me, but I agree it's not a big deal. :)

-- 
Peter Xu

