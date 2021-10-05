Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0D1D4227A1
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 15:18:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234634AbhJENUf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 09:20:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233825AbhJENUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 09:20:33 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59A2CC061749
        for <linux-kernel@vger.kernel.org>; Tue,  5 Oct 2021 06:18:43 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id oa6-20020a17090b1bc600b0019ffc4b9c51so1959040pjb.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Oct 2021 06:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/n9PLhbLsN9GMz2w62Bl5DPNT8suG6RwT9DktILrPW8=;
        b=QPo2WWLTJLKUtOaB2PwOJ7t+f+KTcEEzQsRr6qtgej6BLzhFex4Y+rdGC/9nesJntn
         GqqIHxYnc7BfbCugj0P9j+sa1dWU0Oo2UlVcrmoW3QBASG6pretxz+TrB9icSOCoo+rT
         D47FfIPUIXjhJM1lJdqMEhM7jP+m2P5UqEG/+PIci9jFn8udsGy60BHsWo2R/FgFC0Em
         jilZuVr+Sr+I/329qAuPMbI2pBJofIOVUf4ERzvwm7wj+G02Htmq9MmuYfVSIc5GhpZv
         VED+vAZNStXnsT72TvY7sZqPz7Vop3LaKCBb+OXjroAGaEWy8ie+ub/2ZC6Ugrdzn5rB
         bxGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/n9PLhbLsN9GMz2w62Bl5DPNT8suG6RwT9DktILrPW8=;
        b=DBbMfE4pReveNi38hrVYErMAqZjckrt1HR7RBjvM2P9T7q53WX9BNVf01vTw9H+KbW
         TyDCCGxBKGSHJxNnfIE/RNcejngqbujtKQwq0HGc0vlJ2Hx5p0Q2886GWiNfULfzN7Rp
         X6Gf1YpYMz1dhr9Vdd8fLBNpA9Y8kfD0pbkvqrT1TntytNO2CKUkgIL1BlOIsq46E0e5
         8Oh9PbNsqP2RyHLCI/vwLxzYk82eqoRS6XECmX1LBpSSO6X20eUafH6xWo8TFsTgISPo
         ti0WEXVfGnEh+0MrJpJq3/7/EsyjuALC3DL0zz+EXVpALPnvI79WcEqE3qGl4Q5iZ0su
         t0cw==
X-Gm-Message-State: AOAM530c+4Kf59xB9agru96hjrhBP7z7lOHVh3bUpk8Vh+bJRzwrUhWY
        4CwAxILVApswJyyOoCma+zA=
X-Google-Smtp-Source: ABdhPJwQjViUqWak699WeKcPTk4zroZTMRPdopk9dLVR+VgDEGXyfWxlobxoJWVnl1M/frxrJ/pFSg==
X-Received: by 2002:a17:90b:1e47:: with SMTP id pi7mr1190797pjb.206.1633439922936;
        Tue, 05 Oct 2021 06:18:42 -0700 (PDT)
Received: from kvm.asia-northeast3-a.c.our-ratio-313919.internal (24.151.64.34.bc.googleusercontent.com. [34.64.151.24])
        by smtp.gmail.com with ESMTPSA id t2sm2271062pjf.1.2021.10.05.06.18.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 06:18:42 -0700 (PDT)
Date:   Tue, 5 Oct 2021 13:18:38 +0000
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Christoph Lameter <cl@gentwo.de>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [RFC PATCH] mm, slab: Reduce space complexity of alien_cache
 using rbtree
Message-ID: <20211005131838.GA2760@kvm.asia-northeast3-a.c.our-ratio-313919.internal>
References: <20211003051750.8296-1-42.hyeyoo@gmail.com>
 <alpine.DEB.2.22.394.2110041601170.294708@gentwo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2110041601170.294708@gentwo.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 04, 2021 at 04:05:23PM +0200, Christoph Lameter wrote:
> On Sun, 3 Oct 2021, Hyeonggon Yoo wrote:
> 
> > As remote node allocation isn't that frequent and better avoided,
> > this patch tries to compromise some execution time for memory usage.
> 
> Remote node allocation is typical for large memory loads and essential to
> balance the memory allocation over multiple nodes. Large NUMA systems
> exist because the memory requirements of the application cannot be
> satisfied by what a single node has to offer and usually code threads from
> multiple nodes may access remote memory.
>

> > Remove init_reap_node, next_reap_node and related variables
> > introduced by commit 8fce4d8e3b9e ("[PATCH] slab: Node rotor for freeing
> > alien caches and remote per cpu pages."), Because it has only one tree
> > for all remote nodes.
> 
> Rotors to spread the memory allocated are essential for the performance
> of large memory loads! Memory must be spread evenly otherwise memory
> accesses will overload a single node.

Sorry for making a noise. It was because I misunderstood NUMA.
Thought it should be not frequent because kernel's default memory allocation policy was
allocating from local node.

It would have been better If I asked why it uses much memory first, not writing code.
I'll be more careful next time. Thank you for reviewing!

Thanks,
Hyeonggon

