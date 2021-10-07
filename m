Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 762D7425FB0
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 00:13:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234956AbhJGWPC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 18:15:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232604AbhJGWPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 18:15:00 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09512C061570
        for <linux-kernel@vger.kernel.org>; Thu,  7 Oct 2021 15:13:06 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id g2so6515451pfc.6
        for <linux-kernel@vger.kernel.org>; Thu, 07 Oct 2021 15:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PSoxPKgtUx8Cz3W1XGlx1AREdDnlsBnd21q2tDG35gc=;
        b=qW3jrj29Zo6JDTgt0l4U+zOb++xBTePrWQsuT5+h4ShAebzXCcnJGSdk0hcFaBYiFb
         bpVV/zNe8FMHo4epeIKXnM4DiND8ecR6TPQweheO9CYyDiYTsTqVtLhkYxGObZ3kkH3Z
         moB/ntomYDR/Pa3Jeo81t6/oUD89bv6B1zN3coYQ+XY8xFoxVOEZdOs2j26DJS6vShAj
         ZiykpYkvjnHTm4CP0IttCmbqQVmK0mfIAPbVMwTM4wrSMAnYW2P/0DVe493B8XCTEzGf
         3TXIqMPsmSy2tBb9gKQIz9bCp2X6uPEkbYUuk9clHfNom0j72zMO3nn7R5jGoqH4ZREA
         Tpgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PSoxPKgtUx8Cz3W1XGlx1AREdDnlsBnd21q2tDG35gc=;
        b=gubacmxhO9SRzZMFMAh9ZgcwSpLyg5On4vuFc04i2Ck+vCrRw4MVgrMegSnHjFxZRz
         r7khdfSWfeYd14NEnN6m2Jdn22BqXuN1ml+VjUPogYPJTPlDPcj+jxueN50BFizt3Rec
         wHDkEh/lvI1JkSkXo3DOZvE5LgLdKQBHsbDtbGFL878Ou7hAOokPI6H9Qcds80GZdgNG
         4B+EAcNKiPtDbGbgj8Nc5QDU/MQM2sAUJmbmz9fy8tsSOLWeGR0Ze7VtVLqJ2dQGanAb
         /RlW1zlkT6GwS1j0kXUQ7uCsmaqFha4n4+FonW/Ho6Nf+6U9uANA5izEu/a8RwXQ3PuQ
         MvKw==
X-Gm-Message-State: AOAM532DqKQLNO9wgk7MHjZqPu5uwVr6ghgV/Lqj7SVCpMJtxSxFD2qV
        Okeko7+8jFOeeCZLG2ThHBAvQg==
X-Google-Smtp-Source: ABdhPJxntsFG9xEbbx22n+JcOZX6gb+uARZJFWJEf9sOIHpZmdxEEZUGGtRODs2tFLPGbJwklzHuLA==
X-Received: by 2002:a65:6919:: with SMTP id s25mr1712827pgq.14.1633644785160;
        Thu, 07 Oct 2021 15:13:05 -0700 (PDT)
Received: from google.com (64.157.240.35.bc.googleusercontent.com. [35.240.157.64])
        by smtp.gmail.com with ESMTPSA id y22sm9360044pjj.33.2021.10.07.15.13.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 15:13:04 -0700 (PDT)
Date:   Thu, 7 Oct 2021 22:12:57 +0000
From:   Matthew Bobrowski <repnop@google.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Vlastimil Babka <vbabka@suse.cz>,
        Suren Baghdasaryan <surenb@google.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Jan Kara <jack@suse.cz>
Subject: Re: [PATCH 0/2] Introduce simple pidfd to task helper
Message-ID: <YV9w6QQcGlgYWjfd@google.com>
References: <20211004125050.1153693-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211004125050.1153693-1-christian.brauner@ubuntu.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 04, 2021 at 02:50:48PM +0200, Christian Brauner wrote:
> Hey everyone,
> 
> This adds a simple helper to get rid of some code duplication introduced
> with the addition of two new pidfd-based syscalls in mm. We should've
> probably added the helper right away and I think I mentioned this during
> in the review on one of the revisions but we probably just lost track of
> it. If this looks ok to you, I'll queue this up for next.

I went through the series. Seems like a very sensible thing to do, so thanks for
adding the helper and updating the call sites accordingly.

Reviewed-by: Matthew Bobrowski <repnop@google.com>

> Christian Brauner (2):
>   pid: add pidfd_get_task() helper
>   mm: use pidfd_get_task()
> 
>  include/linux/pid.h |  1 +
>  kernel/pid.c        | 34 ++++++++++++++++++++++++++++++++++
>  mm/madvise.c        | 15 +++------------
>  mm/oom_kill.c       | 15 +++------------
>  4 files changed, 41 insertions(+), 24 deletions(-)
> 
> 
> base-commit: 9e1ff307c779ce1f0f810c7ecce3d95bbae40896
> -- 
> 2.30.2
> 
/M
