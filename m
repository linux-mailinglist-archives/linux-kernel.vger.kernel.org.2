Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5368441EF74
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 16:27:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354511AbhJAO2y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 10:28:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354297AbhJAO2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 10:28:50 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E45F3C06177C
        for <linux-kernel@vger.kernel.org>; Fri,  1 Oct 2021 07:27:05 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id i132so9307771qke.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Oct 2021 07:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DJs75BQaCW/g7pooRRj+6YO0ULlwMz3u2sNV5tiA/bM=;
        b=12f9ZN14mCgZ+mea7F6AapeGsomq5b/qDbcNfxZe76D96JIWEGlDkLQclucjiNxCER
         Pykd8tU79SFQM8L6xrigX5TEUjdEKChTRdTwmB6OPH6gCCIU9NVtzIzu0eZLv3xkLHCV
         uNuuIADIN040sWB1WYlgO5d4s+YLUIqo0SfGu/I4iP50M63j6rHIsaNJn4PFAwznaq1C
         oa60iWCS7UzYVFhUk0swK39HZ94r8v6wFNilzivbnZoyQhJ6or+govTF2UC3OIbYVsts
         AiZN/0uso7kEG44pjbDzm/rw6Kkd0agK1pN7/arZvdjziYQwcNlNvR0PqWpFKylS7sco
         0Ygw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DJs75BQaCW/g7pooRRj+6YO0ULlwMz3u2sNV5tiA/bM=;
        b=Km1ooKb6ZwqBvrQdiNu/J8CtFQvOH1AC6iKJxPPnvXK8/RDwAGSgUdd4b5df/gsKau
         1F5cmI5H8TFbhtTc3cannWmX/995Rl3zckW9I/Shs51MsrCiPP8HEx/EJBm3ArSu8g/Y
         pLnE6dD9zbtKgFB3j+W/duq35w4kvIFZcNptujMrrhzUO7+6+6zuWyVvt6/f2G0OJDE8
         Vbv/ubTutl7mN//ja4gfQSe2JrKceS4YIOq2WibCEtHfSzVWOHft8REJwYPEWd8h2U8o
         rWTGiM33NhNlk0XdC25wVu6Za+5GIgDIy6NYgKgcYh4FJznmS04hXQlNtvZATPdBSPsD
         8+Dg==
X-Gm-Message-State: AOAM532VHWUbW/q84gKE6iA/CnOwFaVFJi9h5G2BD8sm3hXvf4hfeQLB
        VGsdVovHxdV8ThkVhXDVOljBOg==
X-Google-Smtp-Source: ABdhPJziQP96l0Jg2qQu8oA5s6SKXjOsig27Z/sQ8/zMDsRX8qxd3kRy/BxnffoUk1+5psaMOzNUYA==
X-Received: by 2002:a37:8a47:: with SMTP id m68mr1684979qkd.452.1633098425018;
        Fri, 01 Oct 2021 07:27:05 -0700 (PDT)
Received: from localhost (cpe-98-15-154-102.hvc.res.rr.com. [98.15.154.102])
        by smtp.gmail.com with ESMTPSA id w17sm3085594qkf.97.2021.10.01.07.27.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Oct 2021 07:27:04 -0700 (PDT)
Date:   Fri, 1 Oct 2021 10:29:13 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] memcg: unify memcg stat flushing
Message-ID: <YVcbOZTQOTAKXzol@cmpxchg.org>
References: <20210930044711.2892660-1-shakeelb@google.com>
 <20210930044711.2892660-2-shakeelb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210930044711.2892660-2-shakeelb@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 29, 2021 at 09:47:11PM -0700, Shakeel Butt wrote:
> The memcg stats can be flushed in multiple context and potentially in
> parallel too. For example multiple parallel user space readers for memcg
> stats will contend on the rstat locks with each other. There is no need
> for that. We just need one flusher and everyone else can benefit. In
> addition after aa48e47e3906 ("memcg: infrastructure to flush memcg
> stats") the kernel periodically flush the memcg stats from the root, so,
> the other flushers will potentially have much less work to do.
> 
> Signed-off-by: Shakeel Butt <shakeelb@google.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
