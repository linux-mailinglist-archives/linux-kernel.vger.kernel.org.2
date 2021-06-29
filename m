Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29F493B7176
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 13:40:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233500AbhF2LnC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 07:43:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233446AbhF2Lm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 07:42:59 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C896C061760
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jun 2021 04:40:31 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id mn20-20020a17090b1894b02901707fc074e8so1789533pjb.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jun 2021 04:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=cY85RduMbCPMd8R5fgtQlYocUrJ+UgRnlC7mI3SHP7k=;
        b=UfQAcSeV9VmVoD2wLUQpy83IajMRjrBF+0jRiKuFqhdT2lnuUMiznEhmGKGWQ0k9ga
         SNhhaPFaCFJ/AI3sNrcwTA2MCYzqjVfX/chalufZD3dr0nNYflB6AoOe1+PT8aFMQe8o
         hxybDIlc2kAEQ+wdbkFDZp+1kfBqVMyYgeYOY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=cY85RduMbCPMd8R5fgtQlYocUrJ+UgRnlC7mI3SHP7k=;
        b=bCMsfjgJ0Lmkg3ip1ZmGEL4Wy16ZaaOOtKyvfpoB4hC/LPRsTRh84QQHtc9MUKBXH0
         Wtl/h1IECA3/f6rpBvL6eRbTVWh2661IugNbZtQeYoWXJp0IVHMq3GxchBshWdnNcgeC
         kobp0i6UDV9zNqIih3oYOQzQH6051xCLVlFQ8SwhsMVqm8nh4a/Z+2hKhi2rBb9io5/Q
         L5j1CBqD5X5dwJN2md8LCEKXnOx2bgy9e7yjJrNzdfBFF1rXp00DDp4fHJI1qicCGYwZ
         HCibzT8a0+Mo8dfNJ3xoudnTv0dxEANM9ViBrZAGHJNfOxp9agCVwaVrnfwQlU9P2T7j
         7VHA==
X-Gm-Message-State: AOAM530FBY5KIwTeq9oMFXAgrFMCf4a0ubHU1k4uN8SFAhUv/00v32QA
        1JTUI3BD0Wd+25ezTc6ALscQRA==
X-Google-Smtp-Source: ABdhPJwtTM+UDjQ0+TpcEEhv287WYE0+QrC3Hq2ARQa9SGw1XpIqxhBrehW1JKYGa1B8ew8z5OE4Og==
X-Received: by 2002:a17:90a:4592:: with SMTP id v18mr33261516pjg.132.1624966830939;
        Tue, 29 Jun 2021 04:40:30 -0700 (PDT)
Received: from cork (dyndsl-085-016-196-171.ewe-ip-backbone.de. [85.16.196.171])
        by smtp.gmail.com with ESMTPSA id m4sm2973019pjv.41.2021.06.29.04.40.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jun 2021 04:40:30 -0700 (PDT)
Date:   Tue, 29 Jun 2021 04:40:15 -0700
From:   =?iso-8859-1?Q?J=F6rn?= Engel <joern@purestorage.com>
To:     Alexander Potapenko <glider@google.com>
Cc:     Marco Elver <elver@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitriy Vyukov <dvyukov@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH] kfence: show cpu and timestamp in alloc/free info
Message-ID: <YNsGnyHJL6i1OZFl@cork>
References: <20210629113323.2354571-1-elver@google.com>
 <CAG_fn=V2H7UX8YQYqsQ08D_xF3VKUMCUkafTMVr-ywtki6S0wA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG_fn=V2H7UX8YQYqsQ08D_xF3VKUMCUkafTMVr-ywtki6S0wA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 29, 2021 at 01:34:27PM +0200, Alexander Potapenko wrote:
> On Tue, Jun 29, 2021 at 1:33 PM Marco Elver <elver@google.com> wrote:
> >
> > Record cpu and timestamp on allocations and frees, and show them in
> > reports. Upon an error, this can help correlate earlier messages in the
> > kernel log via allocation and free timestamps.
> >
> > Suggested-by: Joern Engel <joern@purestorage.com>
> > Signed-off-by: Marco Elver <elver@google.com>
> 
> Acked-by: Alexander Potapenko <glider@google.com>
Acked-by: Joern Engel <joern@purestorage.com>

Jörn

--
Without a major sea change, nothing that is under copyright today will
ever come out from under it and fall into the public domain.
-- Jake Edge
