Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 273FC3FCFFD
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 01:38:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240888AbhHaXjj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 19:39:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232565AbhHaXji (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 19:39:38 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 212FBC061575
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 16:38:42 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id l10so2496170lfg.4
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 16:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/slivHcHScfReLSQZ8ergXWI4L/ZHdZnviGPtDhRnvI=;
        b=jjtfZtfzj5mp2vVzVN8ZQWHq2ksGaOE1oqqp03fU9/NQ6aiBWSqJbC95CUnR+qVv77
         gNHDcodRBYI2Wh5vEUcOt1wTa7Z3QGP7dD+YiR50XJVrQQMPIBotUSQorJVDRTOlzIXT
         KYIec3Aek6uLCyJrFPZ0GrfJlEBPlMqTpb5Ul7ueJtY6hlAhGmEpLjhmHphQ+E5JQXdl
         P4UMye0b6IYFAQNXgWgKvIASl3p9sk8gkxlffMxsbjCgkaL5vGNd0VjS2syYMBG3NnLh
         bnIfoZuBc8qAueUXAxWTAJPtFD+cQhSGeYPvDMK+X37bSjrwFSDv/N9qIW6tsjtpYji2
         wy4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/slivHcHScfReLSQZ8ergXWI4L/ZHdZnviGPtDhRnvI=;
        b=YL+jfNa3aIruebvCpujaA7N86pCTIxGnaMoGtPOYwUXnSeovMgXiRJ2gObmcg8uPLB
         nkSHmHq3lSg5CM0UySQIhlCJwFGLap2fjVNlCQl5ZAI1mDwFBvhUBRfR9AZ+Y/NuGOCv
         A38zzKyCNVDTCdBaGIc5GPaFnfqkoLFNR7wzPrTbEOVy+6eWgIMPysY4pfOcuT0nCO+Q
         ue5XJu5aJ9imirohb0rpibHZ1Tk8NI4GxeBSu5bOtT9FnqsPGWwWFFznO14Z5RkAxXOz
         4l97OqnPExedd4UmW90doOFCQ95MUlXeptfSXtXgsJ1Ho0uxGKbaeighWfTQrHtJy57n
         Cs8g==
X-Gm-Message-State: AOAM530zgRbq8dRoJWgFW4K4GN80VtsiSJgJ7qxm7AaNWQuwYPuJrVJY
        ezDbFJZ8CqWe3t63ytHmeaXmDw==
X-Google-Smtp-Source: ABdhPJxQcx66VMxDF+CGmAH4kJdfVwMQziNRgY+1PPRYa9L8F99UE+90LfcALD6L/oM06q/MazNPNA==
X-Received: by 2002:a05:6512:238e:: with SMTP id c14mr23788237lfv.324.1630453120483;
        Tue, 31 Aug 2021 16:38:40 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id u9sm2032331lff.290.2021.08.31.16.38.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 16:38:39 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 86B47102EFE; Wed,  1 Sep 2021 02:38:39 +0300 (+03)
Date:   Wed, 1 Sep 2021 02:38:39 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Yang Shi <shy828301@gmail.com>
Cc:     Hugh Dickins <hughd@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] mm: khugepaged: don't carry huge page to the next
 loop for !CONFIG_NUMA
Message-ID: <20210831233839.afaenhn32nx6m2fq@box.shutemov.name>
References: <20210817202146.3218-1-shy828301@gmail.com>
 <CAHbLzkpkDXyEZ2izMwpkwLg9fN7qsQ+soR+iu6sd8RfOSqhS-A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHbLzkpkDXyEZ2izMwpkwLg9fN7qsQ+soR+iu6sd8RfOSqhS-A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 30, 2021 at 11:49:43AM -0700, Yang Shi wrote:
> Gently ping...
> 
> Does this patch make sense? BTW, I have a couple of other khugepaged
> related patches in my queue. I plan to send them with this patch
> together. It would be great to hear some feedback before resending
> this one.

I don't really care for !NUMA optimization. I believe that most of setups
that benefit from THP has NUMA enabled compile time.

But if you wanna to go this path, make an effort to cleanup other
artifacts for the !NUMA optimization: the ifdef has to be gone and all
callers of these helpers has to be revisited. There's more opportunities to
cleanup. Like it is very odd that khugepaged_prealloc_page() frees the
page.


-- 
 Kirill A. Shutemov
