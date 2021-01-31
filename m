Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15FF6309994
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jan 2021 02:13:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232258AbhAaBLV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jan 2021 20:11:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230360AbhAaBLU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jan 2021 20:11:20 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 314A5C061573
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jan 2021 17:10:40 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id i63so9106861pfg.7
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jan 2021 17:10:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=WnnqcWCxinzE2IIXfwW8B1NU0qXZbP2tW/76Rc4KOfQ=;
        b=PEIyRHsPXymEddhifnCMfnXCpz7yq5ShKa7hWqXJejwLaaoiK7h2FEEnt4o7SGbdJJ
         zZ8cGCyQKrJLSbros9s+PFp7n00Xj7rqSMfrfzx4tgg0dXCn7puM+OL2jpqimmSmzJy4
         +qpUqOd4llseW9R8Af2w4TrCoDJ4X9qVZgs5Krr4PGenY326GMu8wX1EHADNPAQmbeC7
         kGrK/7PgQF9q84e+HAw6h3aKtwm3+TwxG5nA7EJN/40xxb4zzvsku9dEeZ9gJ57M1q/K
         +Jf8sTPdR1bKtyoUHg5ahUh8GocPQiELvkf6nXI12+oHIu909sMXFpsoJXshtuXfV6MQ
         Y4yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=WnnqcWCxinzE2IIXfwW8B1NU0qXZbP2tW/76Rc4KOfQ=;
        b=mWBxpPKjBxYqiIPAH+Qg5M1khJN3Yj93xOA/bGDDJfIaTA2deX6uWO/Xm1HwkbrB5u
         ooXQCSxnnN7VK3fDjG9NV6YxaIalGv1LfDIr6Q2pyOmi02rcbpuiNmH7pN09gOkuOy7i
         c3TkMkO0ndpvPQFrGUpWwCOrgIeLFRnApBnn2gVyL63Nl0pdz2QpIeLfJCyFM9GBMyVl
         dxQZHI3GUmpsnbx4PqwHjlc+iS6Kc+Zd5KV42FGXsFCTbXPc6yNJAoNq0jIFaPSzccK8
         WO//BuKiFOh6JdoDk0wD81wsvL4wx5eplR8Rah7Sfb5aD+pYF8iGKS6K8E7x+h+H+ZGN
         msZg==
X-Gm-Message-State: AOAM532K4QY9OkMSEFwsqGJzA/wCEXlOVjjp3BrcRe7k8vheGfGDBhM/
        bTQTxdQHvBuEkFcRw49GvTJ+IQ==
X-Google-Smtp-Source: ABdhPJz+krmbNOjAh3xBgN4aIa4YeB3SrGwyAxX3AqsZT6+jYbJrjCFSAAitddf2O9BKhKl6gDq0GQ==
X-Received: by 2002:a63:4e08:: with SMTP id c8mr10404489pgb.87.1612055439683;
        Sat, 30 Jan 2021 17:10:39 -0800 (PST)
Received: from [2620:15c:17:3:4a0f:cfff:fe51:6667] ([2620:15c:17:3:4a0f:cfff:fe51:6667])
        by smtp.gmail.com with ESMTPSA id q79sm14369850pfc.63.2021.01.30.17.10.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Jan 2021 17:10:38 -0800 (PST)
Date:   Sat, 30 Jan 2021 17:10:37 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
To:     Dave Hansen <dave.hansen@linux.intel.com>
cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        ben.widawsky@intel.com, cl@linux.com, alex.shi@linux.alibaba.com,
        tobin@kernel.org, akpm@linux-foundation.org, ying.huang@intel.com,
        dan.j.williams@intel.com, cai@lca.pw, dwagner@suse.de,
        osalvador@suse.de
Subject: Re: [RFC][PATCH 03/13] mm/vmscan: replace implicit RECLAIM_ZONE
 checks with explicit checks
In-Reply-To: <20210126003417.72B4BCFB@viggo.jf.intel.com>
Message-ID: <4ea95a1a-33b0-eb15-98d8-79c81dc8a37@google.com>
References: <20210126003411.2AC51464@viggo.jf.intel.com> <20210126003417.72B4BCFB@viggo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Jan 2021, Dave Hansen wrote:

> 
> From: Dave Hansen <dave.hansen@linux.intel.com>
> 
> RECLAIM_ZONE was assumed to be unused because it was never explicitly
> used in the kernel.  However, there were a number of places where it
> was checked implicitly by checking 'node_reclaim_mode' for a zero
> value.
> 
> These zero checks are not great because it is not obvious what a zero
> mode *means* in the code.  Replace them with a helper which makes it
> more obvious: node_reclaim_enabled().
> 
> This helper also provides a handy place to explicitly check the
> RECLAIM_ZONE bit itself.  Check it explicitly there to make it more
> obvious where the bit can affect behavior.
> 
> This should have no functional impact.
> 
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Reviewed-by: Ben Widawsky <ben.widawsky@intel.com>
> Acked-by: Christoph Lameter <cl@linux.com>
> Cc: Alex Shi <alex.shi@linux.alibaba.com>
> Cc: "Tobin C. Harding" <tobin@kernel.org>
> Cc: Christoph Lameter <cl@linux.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Huang Ying <ying.huang@intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Qian Cai <cai@lca.pw>
> Cc: Daniel Wagner <dwagner@suse.de>
> Cc: osalvador <osalvador@suse.de>

Acked-by: David Rientjes <rientjes@google.com>
