Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB301357473
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 20:40:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236189AbhDGSkj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 14:40:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbhDGSkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 14:40:35 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49D4EC06175F
        for <linux-kernel@vger.kernel.org>; Wed,  7 Apr 2021 11:40:25 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id 6so7443117ilt.9
        for <linux-kernel@vger.kernel.org>; Wed, 07 Apr 2021 11:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m1C32+Ws/D/BXd+DIGZBmNk7jd19N3wmSzcAq3Dfs+w=;
        b=mHnRP/cYm6AvebvssXcW8Y5WB637Pdq6YQItx1eIHoLvW2sqh1sTzxZY5lNRS3DScd
         70RAIaDFbuDUyDab9m4sdx8nuPkME0ykMMGMTy7p/u7kFVNybCIVO2g1OuQ2v6rcsR5t
         8m+xhS2GBMprE5PkJ6RrGyjSSj2gDc/My9l7sVVKtNOOpWjNp4T9vBraj3XyzO10Wx16
         InUqxzzs6+ywZGX/aVn66gYoHXSZvY7oEWmSRT+LMHE8nSt/om6zdZtGs/LxbpwRCEi8
         Soc8dpGPGTIkGvygZj3Hw6+oT9lOEn5vUGD++kx3yK2tZ6VyyvMdnlMmG0/YwqRvL6T4
         PVug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m1C32+Ws/D/BXd+DIGZBmNk7jd19N3wmSzcAq3Dfs+w=;
        b=BL4dYR8/qnJ5NjKgUfz/vyY74TnINT33h5jdB7HhNr2kjrkyOXKkdA+m/lcsPYjF4U
         OCgRUbefbIOVTpNqMZrvqYqSmNwXnIfcPvYAQJ9yx0Qn0TCe+ZtfSzyc5za0fQvi3R9x
         USYUMDR8gjUsSeBngyIintmniR9qo9l2s5HPebuMv5s7qC620Y/4dV89sQCF1YpiOdwc
         ZF4k8XeCZ90eKq3eJ0ZrZILov8ZAaA5mfDMEP0i+i4rX/cQO7BOQxQY+CRaHJc6uyaPG
         KGhnr3zrNwRgvxSgbuJSnRdaNPGavT9jIJsbJp5Snb5V1+RY3ttWztWH1WuJ04zReSrz
         lyKg==
X-Gm-Message-State: AOAM533iB++kbEaAlesSnoEabqkVmyQaQSWxdCWkRsVxGaLg4NnOAaNP
        lkEanodOKK5ZEHIFZ0GW1E9fvsCqayBtJUPvmKe1qQ==
X-Google-Smtp-Source: ABdhPJxrOr8UlQInHmCI5WOtRKkP7DU5pbsad3aM8CI9NjQc322ZHlK1Y0YkZVSp1YHXwfJCn17oBbL7EtzZlF6KFYc=
X-Received: by 2002:a05:6e02:1ca2:: with SMTP id x2mr1011087ill.128.1617820824429;
 Wed, 07 Apr 2021 11:40:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210401183216.443C4443@viggo.jf.intel.com> <20210401183229.B2360AEA@viggo.jf.intel.com>
In-Reply-To: <20210401183229.B2360AEA@viggo.jf.intel.com>
From:   Wei Xu <weixugc@google.com>
Date:   Wed, 7 Apr 2021 11:40:13 -0700
Message-ID: <CAAPL-u-OgmT+R=txfO_rFaYLKC0UZ5xEmFOY3spVHEmk_r4iSQ@mail.gmail.com>
Subject: Re: [PATCH 07/10] mm/vmscan: add helper for querying ability to age
 anonymous pages
To:     Dave Hansen <dave.hansen@linux.intel.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        shy828301@gmail.com, Greg Thelen <gthelen@google.com>,
        David Rientjes <rientjes@google.com>, ying.huang@intel.com,
        Dan Williams <dan.j.williams@intel.com>, david@redhat.com,
        osalvador@suse.de
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +/*
> + * Anonymous LRU management is a waste if there is
> + * ultimately no way to reclaim the memory.
> + */
> +bool anon_should_be_aged(struct lruvec *lruvec)
> +{
> +       struct pglist_data *pgdat = lruvec_pgdat(lruvec);
> +
> +       /* Aging the anon LRU is valuable if swap is present: */
> +       if (total_swap_pages > 0)
> +               return true;
> +
> +       /* Also valuable if anon pages can be demoted: */
> +       if (next_demotion_node(pgdat->node_id) >= 0)
> +               return true;
> +
> +       /* No way to reclaim anon pages.  Should not age anon LRUs: */
> +       return false;
> +}

anon_should_be_aged() doesn't really need "lruvec".  It essentially
answers whether the pages of the given node can be swapped or demoted.
So it would be clearer and less confusing if anon_should_be_aged()
takes "pgdat" instead of "lruvec" as the argument.  The call to
mem_cgroup_lruvec(NULL, pgdat) in age_active_anon() can then be removed
as well.
