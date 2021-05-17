Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09EBC382B7F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 13:52:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236849AbhEQLxV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 07:53:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbhEQLxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 07:53:20 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4558CC061573
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 04:52:03 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id z12so7330313ejw.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 04:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eOBbNnzXd5jDSyNZK3+7RsaXbe+7IZ4EESXVsBeqm6Q=;
        b=YLXweJIH9XeTkd0h43dqIzoxxKTEZ2tFaW+VSOlnndWvyDeJ/676eYfmb6WaAurqbe
         HHPaympL0jFvNJBqG+YyK1trYDSOB9cRLIdLp1PH6bWO/brWpRMIczF90CZ8HN68ZMlw
         4Yido0/9ENIzoWlWzh4SxS6KsuUYaIPv0Kh0xAp6DA6eOzwkNJdl9Pe4wyB0BGCIDMlJ
         OC+wPdftMwCu62wcZDD9D4FddDMO2iB9hfiYyWA8OAdFAWUL/CRoKxe57e1yBn2ttoX5
         EwdvUL1HS+UVSp5i738E7mff7pZOUql04TKrIpEDgbxRG3o96BlhS4xRjAOByOC9m03k
         Wvxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eOBbNnzXd5jDSyNZK3+7RsaXbe+7IZ4EESXVsBeqm6Q=;
        b=Udq0eirO52nAUb4/k1ti9pmuVNt1E6/eFlpaGWaZlL7cUJjtQcOp40iJ6xOB34Hzi7
         e5TuD0G0e1ugOvXEKgDY8L11yHQtJAqczUcVdBSnRda2p5orbzeCh8WcSTPwEgVt62Fb
         0R1IC4OAcz3iL0XdhYL80gEunRR++fI6S3xjhd2hE9l27fATpJQ3QpgDUzJFpZebXuR2
         NCdSm7jKUBxii5d/sJV/0O3W/51cQEZR+s6mqMPvuSBk55Ypa+u4ShTsDDnhEIsrs+2/
         kJnvivzu3JotVx3sfLqhVNUqkGnp7u5KJ0j84rK4KCHSZTT/gwFKlLfUsRBtw62UEsvs
         zQsQ==
X-Gm-Message-State: AOAM532nHM2vT7k3b5NG0/96rqRaM+zowCy+2WN3DkJhHzHodtN1AtXs
        hMFN3Gni0zHFXZmKbYFv34DqeVxTeYvVuQKVSZs=
X-Google-Smtp-Source: ABdhPJw0DKItARIlJ5c5jQitKk0OjDf/tD3PqrbDvvDlhuMj1/tBvobGvQih53TbY52GyyV5fZjml8A2Qql1IbdS5kw=
X-Received: by 2002:a17:906:924a:: with SMTP id c10mr22660696ejx.415.1621252321911;
 Mon, 17 May 2021 04:52:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210516202056.2120-1-urezki@gmail.com> <20210516202056.2120-3-urezki@gmail.com>
 <20210517082449.GT3672@suse.de>
In-Reply-To: <20210517082449.GT3672@suse.de>
From:   Uladzislau Rezki <urezki@gmail.com>
Date:   Mon, 17 May 2021 13:51:50 +0200
Message-ID: <CA+KHdyXMqMPhffiQ84h_+c7ckBe3U0Nfv+612EsfgJQPq_o3dA@mail.gmail.com>
Subject: Re: [PATCH 2/3] mm/vmalloc: Switch to bulk allocator in __vmalloc_area_node()
To:     Mel Gorman <mgorman@suse.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Hillf Danton <hdanton@sina.com>,
        Michal Hocko <mhocko@suse.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
> FWIW, it passed build and boot tests.
>
> Acked-by: Mel Gorman <mgorman@suse.de>
>
Thanks!

-- 
Vlad Rezki
