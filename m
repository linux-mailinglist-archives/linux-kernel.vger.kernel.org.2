Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E76734A2CC
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 08:57:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbhCZH4z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 03:56:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbhCZH4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 03:56:24 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21C5FC0613B0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 00:56:21 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id c17so4336715pfn.6
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 00:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mUQq3PrJMaz6NYH8VwmJQgPfisiTwShGx9McnxTXhnk=;
        b=wU82PSmZV07gFEZKyLCCeXzVDsQs8Hqfi+cXYpmpwOyqBWVPErNZp3a2QbDRpj27QS
         sDs/HvLo+7bTcF7cnAwCMiUcLIh7dbL4gDaU65+pnOURKh0FDjJR92Cq/wOmWFlQrk8i
         vp6OPrsPXZ+W8gh8UMQZgR1mHmaUG/BGOrkQZ/MrePIKHIuOx+QN+QncNvKB4QZkrRrW
         55ZzxwjmQg9EJTFS8CdO034PUNA9AYdKKKUnKC9mhD8qS3SShpQQkt2vLVZQXZOiAkdc
         SvvRLAhFEBVWjBGgs6vNBNyKgf8hYZe3tdAe/wNbEBsNG6Cy+p+YhiPhFfMGmJr4D/Hu
         CXsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mUQq3PrJMaz6NYH8VwmJQgPfisiTwShGx9McnxTXhnk=;
        b=tlInXB7f84fmbZq2S9b93O7GzOx+qGak8FNT2If9U69T0JWhDu7MqNSxgW3Da1ofuA
         EUTXcSBAB8b2oE8LEgdt66zzHhIjbtIs8DMpm3H2W+F2KqHS/uwgSHL3BE0W4qjR31mq
         aGdf+Uxf0tBIWEXg5s0JfCzBvpMAmchWCNWVVWsBN/F4fOEsM07JdcRK8+QhDaEdlItV
         1rA4JdwfRRoB/V29L37XGpa+1XxBYfZGdnde5WV87T2mKp5Alr29NWzufquSah2NNOLi
         4ob2Wh7S4CMXURVvpzG0u3qVYkB3oi4trPwAHs1vzEhlobSHxoY/YxCGE8i9W3coFzMt
         l6Jg==
X-Gm-Message-State: AOAM533IY6Lk9p9MQyppSVIqwQWt9aWpD0aP5NMaKn1ECBmHfngOL7Xj
        8a1z6IwcHcQNyT1WBhX59yKQ0PXLtMnzMg==
X-Google-Smtp-Source: ABdhPJwkWJNou8M1+ZA0i2uVUDhWftzEHtGUA6UHxvMpCCKXo5K1Txwvv9aZTWEvZKra+PXCw/NVWw==
X-Received: by 2002:a62:ddd2:0:b029:1f1:533b:b1cf with SMTP id w201-20020a62ddd20000b02901f1533bb1cfmr11411355pff.56.1616745380129;
        Fri, 26 Mar 2021 00:56:20 -0700 (PDT)
Received: from google.com (139.60.82.34.bc.googleusercontent.com. [34.82.60.139])
        by smtp.gmail.com with ESMTPSA id z22sm7985530pfa.41.2021.03.26.00.56.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 00:56:19 -0700 (PDT)
Date:   Fri, 26 Mar 2021 07:56:16 +0000
From:   Satya Tangirala <satyat@google.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Eric Biggers <ebiggers@google.com>
Subject: Re: [PATCH v2 0/8] ensure bios aren't split in middle of crypto data
 unit
Message-ID: <YF2ToMDxIpVpKftI@google.com>
References: <20210325212609.492188-1-satyat@google.com>
 <e0248d93-e880-6a6d-92d6-dfcfb6f9d661@acm.org>
 <YF07bqQ1NvPxPNrh@google.com>
 <4694766c-8d95-1ad3-cb0c-d1ba8b7fe7ad@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4694766c-8d95-1ad3-cb0c-d1ba8b7fe7ad@acm.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 25, 2021 at 08:46:20PM -0700, Bart Van Assche wrote:
> On 3/25/21 6:39 PM, Satya Tangirala wrote:
> > On Thu, Mar 25, 2021 at 02:51:31PM -0700, Bart Van Assche wrote:
> >> Are you sure that the block layer core splits bios at logical block
> >> boundaries? Commit 9cc5169cd478 ("block: Improve physical block
> >> alignment of split bios") should have changed the behavior from
> >> splitting at logical block boundaries into splitting at physical block
> >> boundaries.
> >
> > Ah, what I really meant with that sentence was "Currently, if a bio is
> > split, the size of the resulting bio is guaranteed to be aligned to a
> > the lbs. The endpoint of the bio might also be aligned to a physical
> > block boundary (which 9cc5169cd478 tries to achieve if possible), but
> > the bio's size (and hence also its endpoint since the start of the bio
> > is always lbs aligned) is *at least* lbs aligned". Does that sound
> > accurate?
> That sounds better to me :-)
> 
> >> Without having looked at this patch series, can the same
> >> effect be achieved by reporting the crypto data unit size as the
> >> physical block size?
> >
> > That would've been awesome, but I don't think we can do that :(
> > 1) There isn't only one crypto data unit size. A device can support,
> >    and upper layers are free to use, many different data unit sizes.
> > 2) IIUC 9cc5169cd478 (or more accurately get_max_io_size() since the
> >    function has been changed slightly since your original patch)
> >    doesn't align the size of the bio to the pbs - it only aligns the
> >    endpoint of the bio to the pbs (and it may actually not even do
> >    that if it turns out to not be possible). Is that right? If so,
> >    that means that if the startpoint of the bio isn't pbs aligned, the
> >    size of the bio won't be pbs aligned either.
> 
> Hmm ... if the start of a bio is not aligned to the physical block size
> I don't think that the block layer can do anything about the start of
> the bio. Anyway, I have taken a quick look at this patch series and the
> patch series looks pretty clean to me. I will let Christoph review this
> patch series since he already reviewed the previous version of this series.
Sounds good. Thanks for looking through the series!
> 
> Bart.
