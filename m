Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B461391AD0
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 16:54:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235168AbhEZOzk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 10:55:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235160AbhEZOzi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 10:55:38 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4630BC061756
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 07:54:06 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id e17so1111693pfl.5
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 07:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=+GScnmVdacRASdZ6acXofN+D5Tlo5vzk3Jj+0xXhnBs=;
        b=ZYIDSNqauuNmVnIUAuIoNdVNNM2lQjPM+LT4mr3k7iqCbm2CS2JAJW2PvDpPIsNYWv
         L1q8BX81tSCVLgMVqm6EhgDppexrZdN2KU8FY9FObpX9YpLxzxSWZfQRPtoG3KR4pmJ5
         woKMn0hPLltjsd9+WNBmmuUlEM8S9I0Y5Vug4Le47r6H1sKH362Uekz3kEFkdMfJf/TA
         c389q1zYA3waMXh98Ah/9taeEEF6WDpS2noTjs6QXTWtVXolJfL4LwR5jBBvvUn0tgjI
         RNNzXLpj4Rr/zgktfpU/kuGbv+WInnNlelnRXD06e2o/CzO3J3bNMkqX5+j3PK3icKqQ
         7JVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=+GScnmVdacRASdZ6acXofN+D5Tlo5vzk3Jj+0xXhnBs=;
        b=maFGD7KZ0zkZ2shUPGpEuKhHGfN9T7NNuZDKHSEdeV7bKxHYHXYNVZN2dEwAePbFGv
         3hVf5XCBeYl2tCsaxyLlxYqfWr/IQMihbYRSf8iJ4h1HSplJOXrN1iNf21WUy+aaFB7C
         o1DN+G6AUtIkNYxGMpyQA7drbhiHCej8DY2SnGAALPcBjrqA6Gz5lSgRvBoevSeMo6Cj
         Ugqz3BIzgpDOScfB8OmwkvQqTHjILqE+DqjKYnTanN76LXgD1UCYSHrZ956pp31fYMi9
         7gzLzLMxY1vVSdDLvzHhkjAcmwwmp3KEAfvrhsu3v3rXIPZL82BzO/vZbwRaU9xUIT+E
         1rlQ==
X-Gm-Message-State: AOAM531h+DdXLpOq5jPW7bk8LTEcbGXnoE7FcjegZx14a4/G9laTDLR8
        Tf+2YujIZAkwv+EDFKCkpl68VQ==
X-Google-Smtp-Source: ABdhPJy/4bHs4xkk+2NL5sdmo643CgS2zx60hGlhSq8WGMvUzh6ma3fHy5ASZe6EKhoY1bkqfa42aA==
X-Received: by 2002:a62:60c4:0:b029:2ca:ebf7:cd0d with SMTP id u187-20020a6260c40000b02902caebf7cd0dmr35557829pfb.71.1622040845628;
        Wed, 26 May 2021 07:54:05 -0700 (PDT)
Received: from google.com (240.111.247.35.bc.googleusercontent.com. [35.247.111.240])
        by smtp.gmail.com with ESMTPSA id e17sm12841738pfi.131.2021.05.26.07.54.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 07:54:05 -0700 (PDT)
Date:   Wed, 26 May 2021 14:54:01 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     "Liu, Jing2" <jing2.liu@linux.intel.com>
Cc:     pbonzini@redhat.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, jing2.liu@intel.com
Subject: Re: [PATCH RFC 7/7] kvm: x86: AMX XCR0 support for guest
Message-ID: <YK5hCUoPo4OJzeU0@google.com>
References: <20210207154256.52850-1-jing2.liu@linux.intel.com>
 <20210207154256.52850-8-jing2.liu@linux.intel.com>
 <YKwgdBTqiyuItL6b@google.com>
 <43eb3317-4101-0786-57f4-f35e7ec094eb@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <43eb3317-4101-0786-57f4-f35e7ec094eb@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 26, 2021, Liu, Jing2 wrote:
> 
> On 5/25/2021 5:53 AM, Sean Christopherson wrote:
> > On Sun, Feb 07, 2021, Jing Liu wrote:
> > > Two XCR0 bits are defined for AMX to support XSAVE mechanism.
> > > Bit 17 is for tilecfg and bit 18 is for tiledata.
> > This fails to explain why they must be set in tandem.
> The spec says, "executing the XSETBV instruction causes a general-protection
> fault (#GP) if ECX=0 and EAX[17] ≠ EAX[18] (XTILECFG and XTILEDATA must be
> enabled together).  This implies that the value of XCR0[17:18] is always
> either 00b or 11b."
> 
> I can add more to changelog if this is reasonable.

Ya, please do.  It doesn't have to be the full thing verbatim (but that's ok, too),
but the requirement does need to be called out.

> >  Out of curisoity, assuming they do indeed need to be set/cleared as a
> >  pair, what's the point of having two separate bits?
>
> What I can see is to separate different states and mirror by XFD which can
> set bits separately.

Ah, that would make sense.  Thanks!
