Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06BC33E0819
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 20:46:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240518AbhHDSqf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 14:46:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240404AbhHDSpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 14:45:51 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18F13C06179E
        for <linux-kernel@vger.kernel.org>; Wed,  4 Aug 2021 11:45:32 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id j1so4336165pjv.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Aug 2021 11:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/EQmTGydF1pIXOESNrwErzBdNg9CrOE9Mxb8eJMGl6U=;
        b=lYgtUH8iYVPqtvlrViEDj4VisTlI5BAnqJr+1CvEvld5nN6Rr/R75P9DnspBYe8FOA
         GvhNwqEoUnzWPmWB8A28qBG6O+IKvGIoCEYJ6HWqGjl3m6xhmUIME+FBpli2J/sYtzb1
         0ZM6tR/MN7vxyJQIPM8zHlHp4FJpGRdzghkChnowHjsbAY5DD7MPKN9e8dHGqkCH26t5
         WoEAW9u+JDUK+G5crAlmyWI+HlNoFIGDM03OwBFC3JWb/rfC5H7glsPCimWq1uuR/C9O
         85bW3wAHCCflHFpo+vNcqoFkuW/Vp97Wprb+sMzRVocNrGf+R482OPaB/PGxZE/4Zaoa
         GVoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/EQmTGydF1pIXOESNrwErzBdNg9CrOE9Mxb8eJMGl6U=;
        b=Sxi3QrnpI+99gZUVed2y+choWgxeoIS5WTNb4JaqujGn7cJwGCY7QrPHULVD6tzkJ2
         YMs2rY0ItQ6f7W53n6FjHtNRmCmQIxWitYHgnlVmLrWO5uoX7HxfcJlj7Ib58XEgcYN1
         JVO4Xvs2Li3SfdxgFArSckUUhbUbLQk569Yn++fUoXFJ3lnUBWtjjEs5nreX0kPjEdf/
         33EZbwcWruYUI1PdqE2vZzJIZ1yptqnGoITdLjHe01YmG0WvzBIDM311EG8Q0M//mdbM
         kbzH49WYYkOG5K2uLf1qhqqVg2g7v9kbaND8zbCA+pSIy8SclF7/qZYKmKCmNCQ/to26
         aBUg==
X-Gm-Message-State: AOAM532AdBg8EbZHRQYAbpKYvTfN7t5d4D/TvZQOzoUxBWUhIFHFe8Cn
        nLZPYn7fJC6lBj4aHBu2rfJ+FKY2lXpaAvO3sRXmnA==
X-Google-Smtp-Source: ABdhPJwRABacfDbCANpEBh/SV7ISPXsw4UJ7/x0n6pmLObYtDw0FF3GTHMwnbKk4Jkn/qvdLfv0uzAtpGu6zUY49kjA=
X-Received: by 2002:a63:3c7:: with SMTP id 190mr530402pgd.240.1628102731653;
 Wed, 04 Aug 2021 11:45:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210804174322.2898409-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <YQrXhnHJCsTxiRcP@casper.infradead.org>
In-Reply-To: <YQrXhnHJCsTxiRcP@casper.infradead.org>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 4 Aug 2021 11:45:20 -0700
Message-ID: <CAPcyv4hW7nxffn0s8OKOh=GfK3AO_CvgRvuYs8vOQ8B4PCW24A@mail.gmail.com>
Subject: Re: [PATCH v1] driver: base: Add driver filter support
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Andi Kleen <ak@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 4, 2021 at 11:09 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Wed, Aug 04, 2021 at 10:43:22AM -0700, Kuppuswamy Sathyanarayanan wrote:
> > +/* Driver allow list */
> > +static LIST_HEAD(driver_allow_list);
> > +/* Driver deny list */
> > +static LIST_HEAD(driver_deny_list);
>
> Why use a doubly-linked-list here?  An allocating xarray should perform
> much better and use less memory.

Sounds reasonable to me.
