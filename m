Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B835314799
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 05:38:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbhBIEhk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 23:37:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbhBIEUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 23:20:32 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A329C061788
        for <linux-kernel@vger.kernel.org>; Mon,  8 Feb 2021 20:19:06 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id d26so9857095pfn.5
        for <linux-kernel@vger.kernel.org>; Mon, 08 Feb 2021 20:19:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Tt7NU6eH2qZk36MrtuahT3BoC+mN14Xz4gumOEz2YIs=;
        b=G5+KVbjzQwzsleisEV9RBpjh3hqEzUm//nHaHTu++l66A5rL3btyxgjOijaDYzF7QF
         c2m9bBWYVKmK7RDGYE4dcV0uibjy4UAHlhSlrsHj+Dx10D1FhMU5uLGbR4qttwj4/eDv
         yBav+123FiF00nflbjQWq1MqzrCtSTZubwqiSUZToYxDoXPXuMfvQxUwSkOmhuKWyZJD
         kZUg1/wRqZI8/ScaubcXUAv0+jnmFjJVdezDDKzEtjn8LSzXmP/5ddV0q3trALCcfhsX
         yzxkhJ7MAivWYunqr0hj8quBNxOVIek1d5XuLwgvRP8sFz2cKAhFvWfeZ/FbvbOlzBHq
         JY3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=Tt7NU6eH2qZk36MrtuahT3BoC+mN14Xz4gumOEz2YIs=;
        b=YE5T818P5jdJEv3yIHnVOItMnd0Hann3Ijb2zgaV4z49qn4QcGCwpa+l7DenleESam
         MHLmeHQRxhCiiQF5GxwmghuaUOWl37l9oLQ0hVGhjGE/7Y9d15j/1yYaqPV64xnTqtqR
         sS9/YMUl0wX9zjDfvvy3rsIsipeRwfdDSW2Gd9OTW63dvGZzqgPTsatr7NGovQRY09x1
         VFtkWmO2wJ3i3ErYAkukS1EjlU1JWG+R0L3ePrswMZvVNZD9lgMvaaPDRqKeRXt6D/TQ
         mwV1iabRHkJAr52SzIBQhMiLrFXh+II+f+Z0B1j/lsiQLERNRongIl2enT5KXKMuXvnV
         gMFQ==
X-Gm-Message-State: AOAM533XfBSdxQRYks0xqO5S4jQrlZe2xPTqsbIlhINFsiQFtaD2LGh2
        63Tr/MT57dt1cCvM9eDqZMcs3a5J5Jo=
X-Google-Smtp-Source: ABdhPJzPlwFx24JZ/xZ38SgPzEeN3MnHxsMDSO+fCLePdJhljroGige80WVs0fVgJ8f/LbLjiQ8YyA==
X-Received: by 2002:a63:ca45:: with SMTP id o5mr20267760pgi.48.1612844345897;
        Mon, 08 Feb 2021 20:19:05 -0800 (PST)
Received: from google.com ([2620:15c:211:201:1557:50ce:fb7a:a325])
        by smtp.gmail.com with ESMTPSA id v4sm720647pff.156.2021.02.08.20.19.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 20:19:04 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Mon, 8 Feb 2021 20:19:02 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, gregkh@linuxfoundation.org,
        surenb@google.com, joaodias@google.com, willy@infradead.org
Subject: Re: [PATCH v2] mm: cma: support sysfs
Message-ID: <YCINNpA09FTwr63U@google.com>
References: <20210208180142.2765456-1-minchan@kernel.org>
 <e01c111b-fb20-0586-c7a9-dd6d922c0e57@nvidia.com>
 <YCHLAdabGmm7kqSH@google.com>
 <43cd6fc4-5bc5-50ec-0252-ffe09afd68ea@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43cd6fc4-5bc5-50ec-0252-ffe09afd68ea@nvidia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 08, 2021 at 05:57:17PM -0800, John Hubbard wrote:
> On 2/8/21 3:36 PM, Minchan Kim wrote:
> ...
> > > >    	char name[CMA_MAX_NAME];
> > > > +#ifdef CONFIG_CMA_SYSFS
> > > > +	struct cma_stat	*stat;
> > > 
> > > This should not be a pointer. By making it a pointer, you've added a bunch of pointless
> > > extra code to the implementation.
> > 
> > Originally, I went with the object lifetime with struct cma as you
> > suggested to make code simple. However, Greg KH wanted to have
> > release for kobj_type since it is consistent with other kboject
> > handling.
> 
> Are you talking about the kobj in your new struct cma_stat? That seems
> like circular logic if so. I'm guessing Greg just wanted kobj methods
> to be used *if* you are dealing with kobjects. That's a narrower point.
> 
> I can't imagine that he would have insisted on having additional
> allocations just so that kobj freeing methods could be used. :)

I have no objection if Greg agree static kobject is okay in this
case. Greg?
