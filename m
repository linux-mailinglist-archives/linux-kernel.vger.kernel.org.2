Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D700C349ECF
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 02:40:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbhCZBkP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 21:40:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbhCZBkD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 21:40:03 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED84FC061761
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 18:40:02 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id gb6so1833541pjb.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 18:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4lq6ugqQ7DoHWUJ2oZTfqM5jsYnHqhKM18N0gM46fh0=;
        b=IFyQJO6aR8uJhs/32M8nyX5+1pjYPfj7Rq2KRApdQ5lJ8Gxp8486ggaEmfalDfoBOy
         CHK2jbvo+lOR3GGglVR48MDixdMqrRyuCkEVYxv8eZTFTiQ8+FCA1Ij9mmBCGCW1Kara
         fuaqy0YSnSUgpUX3hS16ft/EABv8xRVwTzaGZnMTpjm0nCJAIuf9m1JWlG1ieEK3SrrY
         6JnafbIALHRInJ5upIXdegZbbY9Qb3La48Mhz8KlmPz1WkzeIyYmuHfRIVbW16yiJLhe
         SapPvePdh/B8GOreHDOFptWzktwwpPQqh34BqZFX8kfaf1NO673h7nu2ELnfF3/Y9KZB
         rvmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4lq6ugqQ7DoHWUJ2oZTfqM5jsYnHqhKM18N0gM46fh0=;
        b=m5l+GPkcuwJKSmz6PLs3kgvqcX0+RhavcpoLCoLFFDfirhv8yKu1k3l0f4Grzacbgq
         4gzLk8JjuvIBnmi6Ufw88tciepqkhy3vCMNfiS4+LKLyv8+wiH9V9juKm4Qg3rgcijed
         AZD/oqOA7S3SMWoBJok26/jUJsmK4yBy0KTAEnokPVN67lMgYc9zq2jhykVuqZ8Uvzdy
         Wf1Vz3lIFkNu6DE5nT6Vyzj/KpoQ6xV1t9zcqCV5B1UBIVjzrSjJdelqMRadPYkieJUm
         jGXFNaWjgHcQwjMKPMw7CmPnFtHv+viQCuSzSBEk5U5d8upnllrJ5zVKbI+UD4vGZ98o
         UCaQ==
X-Gm-Message-State: AOAM533wEbyjTbKcn1dL67vWJ66suFQ0WkVsD0g7BD6GfVsVf8wkw+no
        oianXLE831u8PfVKx8i07V5gPux3Dc+K/Q==
X-Google-Smtp-Source: ABdhPJz0tCoNh8/WA1QUHrND2iPUnP3GrL360Kol5FzbDDH6X7BiOdci/RWl1yA8sTXWk6XBRXfBtQ==
X-Received: by 2002:a17:902:edc7:b029:e6:f01d:75a9 with SMTP id q7-20020a170902edc7b02900e6f01d75a9mr13255243plk.63.1616722802265;
        Thu, 25 Mar 2021 18:40:02 -0700 (PDT)
Received: from google.com (139.60.82.34.bc.googleusercontent.com. [34.82.60.139])
        by smtp.gmail.com with ESMTPSA id k17sm6748830pfa.68.2021.03.25.18.40.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 18:40:01 -0700 (PDT)
Date:   Fri, 26 Mar 2021 01:39:58 +0000
From:   Satya Tangirala <satyat@google.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Eric Biggers <ebiggers@google.com>
Subject: Re: [PATCH v2 0/8] ensure bios aren't split in middle of crypto data
 unit
Message-ID: <YF07bqQ1NvPxPNrh@google.com>
References: <20210325212609.492188-1-satyat@google.com>
 <e0248d93-e880-6a6d-92d6-dfcfb6f9d661@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e0248d93-e880-6a6d-92d6-dfcfb6f9d661@acm.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 25, 2021 at 02:51:31PM -0700, Bart Van Assche wrote:
> On 3/25/21 2:26 PM, Satya Tangirala wrote:
> > When a bio has an encryption context, its size must be aligned to its
> > crypto data unit size. A bio must not be split in the middle of a data
> > unit. Currently, bios are split at logical block boundaries [...]
> 
> Hi Satya,
> 
> Are you sure that the block layer core splits bios at logical block
> boundaries? Commit 9cc5169cd478 ("block: Improve physical block
> alignment of split bios") should have changed the behavior from
> splitting at logical block boundaries into splitting at physical block
> boundaries.
Ah, what I really meant with that sentence was "Currently, if a bio is
split, the size of the resulting bio is guaranteed to be aligned to a
the lbs. The endpoint of the bio might also be aligned to a physical
block boundary (which 9cc5169cd478 tries to achieve if possible), but
the bio's size (and hence also its endpoint since the start of the bio
is always lbs aligned) is *at least* lbs aligned". Does that sound
accurate?

With inline encryption, that lbs alignment guarantee is no longer
enough - the bio now needs to have a size that's aligned to the bio's
data unit size (which may be larger than the logical block size, but
is also still a power of 2).
> Without having looked at this patch series, can the same
> effect be achieved by reporting the crypto data unit size as the
> physical block size?
That would've been awesome, but I don't think we can do that :(
1) There isn't only one crypto data unit size. A device can support,
   and upper layers are free to use, many different data unit sizes.
2) IIUC 9cc5169cd478 (or more accurately get_max_io_size() since the
   function has been changed slightly since your original patch)
   doesn't align the size of the bio to the pbs - it only aligns the
   endpoint of the bio to the pbs (and it may actually not even do
   that if it turns out to not be possible). Is that right? If so,
   that means that if the startpoint of the bio isn't pbs aligned, the
   size of the bio won't be pbs aligned either.

> 
> Thanks,
> 
> Bart.
