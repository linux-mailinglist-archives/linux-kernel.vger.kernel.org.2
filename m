Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E22BA41E591
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 02:39:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351010AbhJAAk6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 20:40:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350104AbhJAAk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 20:40:57 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC706C06176A
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 17:39:13 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id d13-20020a17090ad3cd00b0019e746f7bd4so8052172pjw.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 17:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fsgJJe7WOlN9DnqJOauj+mZ3ubzgkIojJ6QkyDZqouc=;
        b=l4bCcl1a47UkkzW3mbzukb0KurVpGgxKyI/V3Ofv3BRDeQst1xcWBeAG1fna/I6scx
         04PKT+MF6l6uj+4y5ZVugrNcoxECLKMBCq018wofS4HqoYth25pcdGT6P3+8SJzk+3Xx
         T1v3CIugj0yUuNFXjkdfGR4sTT/44lerOnQPqsTUScDS7C7MNHZUfD2wakAYMOSnZxwd
         Sp4k/tuUSz6Sz0E9h5j0/JGbe5H3W8Yi41TDXlMzelZjLeOhWGP24XcPvpAyuE7G67FA
         9yX/IsZtE+5YF/6oI5oimOWcT22u7Ax51JCPqC4xaxVVYlcgXEOM3nBQW+w4Qhis40Zp
         8kLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fsgJJe7WOlN9DnqJOauj+mZ3ubzgkIojJ6QkyDZqouc=;
        b=NhWT6D3YnGZypS51pYUO/V6h3xHqxgr8tgSMmMqx9Vfx0uWJ60OZx14NbUcWYphl12
         I/GA3oNl3eC+o++1+96u1L2x1Hx7bWF2kd1o3wbwWv4zedIhdJImEVz5VxO6pYB1wEbQ
         vX7sqMxQ9DEi4ElHz5h2tPm+Bth/q58a3hipXCymCXcMnn4hg9hmHy0xkxqp+1ipRf2Y
         zOT4K6WhP4kloFgEZgbV9gdLhw8bxcxtXmUY2XG0zP1Ejfh5rnzysneC5jdO1toddLpb
         lxkZfmLBY4Y6G/SJEe0oPuWvnFZ6qoGtZwFwHxL7IUlTxex/1RTbiBggiCx7d0oxrl+t
         z8sw==
X-Gm-Message-State: AOAM5331yfwB7aOCbus2WV4iCB61yhB0+qDMkqioZEBMVIk9QmXSLhkZ
        0MiWk4PhNsr57meJ8vatd1I=
X-Google-Smtp-Source: ABdhPJxnjbIxtoCXYeWXBoNfyR9DqjYl+OzpSV/+oYdqMHZqVprHVFXyIX42fASFR1Rs5QW237r/fw==
X-Received: by 2002:a17:90a:88c:: with SMTP id v12mr9905694pjc.232.1633048753379;
        Thu, 30 Sep 2021 17:39:13 -0700 (PDT)
Received: from linux.asia-northeast3-a.c.our-ratio-313919.internal (252.229.64.34.bc.googleusercontent.com. [34.64.229.252])
        by smtp.gmail.com with ESMTPSA id r13sm4013111pgl.90.2021.09.30.17.39.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Sep 2021 17:39:13 -0700 (PDT)
Date:   Fri, 1 Oct 2021 00:39:08 +0000
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     linux-mm@kvack.org, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Queueing is outside of SLUB nowdays
Message-ID: <20211001003908.GA2657@linux.asia-northeast3-a.c.our-ratio-313919.internal>
References: <20210927090347.GA2533@linux.asia-northeast3-a.c.our-ratio-313919.internal>
 <8aa15f4b-71de-5283-5ebc-d8d1a323473d@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8aa15f4b-71de-5283-5ebc-d8d1a323473d@suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 27, 2021 at 07:03:19PM +0200, Vlastimil Babka wrote:
> On 9/27/21 11:03, Hyeonggon Yoo wrote:
> > Hello there,
> > 
> > I've been working on adding 'lockless cache' on sl[au]b for a while.
> > But what it actually does is actually adding 'queuing' on slub.
> 
> Yeah, I pointed out those threads from 2011 that called it exactly that...
> was there any conclusion why that was not ultimately merged?

Looking at other layers, they implemented queuing layer outside of SLUB.
See commit 795bb1c00dd ("net: bulk free infrastructure for NAPI context,
use napi_consume_skb") for example. They made skb cache because SLUB is
not suitable for intensive alloc/free.

And because the queue is outside of slab, it can go lockless
depending on it's context. (But it's not easy to do so in slab because
slab is general purpose allocator.)

So current approach on place where slab's performance is critical
is implementing queuing layer on top of slab.

Then new question arising:
    - Is that proper way to solve fundamental problem?
      - why not use SLAB if they need queuing?
      - how does this approach work on SLAB?

    - If there are no problems with queuing outside of slab, why does
      SLAB exist? can we just drop SLAB?

I think we need to think about questions above.
