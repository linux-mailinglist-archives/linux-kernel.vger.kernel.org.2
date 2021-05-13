Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61AF937F79A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 14:12:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233851AbhEMMNo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 08:13:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232304AbhEMMMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 08:12:38 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E841C061763
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 05:10:17 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id p17so14242379plf.12
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 05:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GIgBu0cXrDYQWIYcm6hEflFDTrhhfQxoWqqkLDTuF54=;
        b=TLQurYwVvXYBe2o3JZtkkCkLnNKAMQzVyefuAG+6gL2FsAYPukZR4VOUws5whXNTFn
         fyCHs5SWFj4cc/QekoElcQts7qqvLemYLDUK8EeVn0qSvRuo8vJjb5WsNISe0b3K8/VF
         z6bwwDN/qr2Jj3gkuHL0RCl2ZUKy/K2A5laCP3oKa5Y7EEWitjyFNFo1fmGP4YGoameR
         atklHBHkxxDE7Lk3tt3HMVqWjXBFexlKNbQzaRE3C31jmR0QqQTK1xpFPK20Fj52t3rh
         a/kkLVLJMTjclqshyETxUoCCu50gjaD7JC1ez5va8+Vah9B76DsBfP1suZNXF9xh+Z7/
         1Jrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GIgBu0cXrDYQWIYcm6hEflFDTrhhfQxoWqqkLDTuF54=;
        b=JVtRUQTHCIVh/UKzOSfTm802VyKg/fRZVVFQc/bKOzhdFKqLdx9cVJt/Kd0iBFtXH6
         s7kqf13q7tUV6FlZJpukqJsIyJvHs1VmFIjJFWlDivVFpzWWey28CKP3X38WBgiFR3Wq
         7vqCfE61tMgi0d8oVy4VlYmzbUmJISBBuhwn8MjyReKe08xQ81WcHbLT1LsbYAv/CYZG
         I/7EefIpras/ves6GRSPwyohENOncSyPieA8hXlNSBaTblCUvMNK63nSPUsStazNenE8
         7nmaJ4TfGLjOh/i34Cjm3cPhAswH8IQbsvpEDl8uuSApTiYnjaZMr0j3rC3wcD7n2WG7
         6UQw==
X-Gm-Message-State: AOAM533/vrDi9O5qclyfBw0fiBrtvFbUpl5HnN3ZkWZ/e826DOae/yyw
        xXJuWSJNBoZyv9XGyNhpXM0=
X-Google-Smtp-Source: ABdhPJwYQ8Aobb4fgVUj6E1ey4GT5R/j+ptNIujUvEG4uu22ypl4B8h5z4i+Uphfkqm/fhRaTGVwLw==
X-Received: by 2002:a17:902:d206:b029:ee:92d0:4405 with SMTP id t6-20020a170902d206b02900ee92d04405mr39040058ply.43.1620907816921;
        Thu, 13 May 2021 05:10:16 -0700 (PDT)
Received: from hyeyoo ([121.135.181.35])
        by smtp.gmail.com with ESMTPSA id t19sm2026073pfg.70.2021.05.13.05.10.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 May 2021 05:10:16 -0700 (PDT)
Date:   Thu, 13 May 2021 21:10:11 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Marco Elver <elver@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        iamjoonsoo.kim@lge.com, rientjes@google.com, penberg@kernel.org,
        cl@linux.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] mm, slub: change run-time assertion in
 kmalloc_index() to compile-time
Message-ID: <20210513121011.GA774527@hyeyoo>
References: <20210511173448.GA54466@hyeyoo>
 <20210512195227.245000695c9014242e9a00e5@linux-foundation.org>
 <20210513031220.GA133011@hyeyoo>
 <20210512204024.401ff3de38649d7d0f5a45e8@linux-foundation.org>
 <20210513062809.GA319973@hyeyoo>
 <a36ab9a1-f07a-42ca-bb11-5bd0c70660bb@suse.cz>
 <YJ0ACtMpasnoZdUp@elver.google.com>
 <90c1b2ae-a5c1-07d1-b056-5b3699b6cc77@suse.cz>
 <20210513120829.GB772931@hyeyoo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210513120829.GB772931@hyeyoo>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 13, 2021 at 09:08:29PM +0900, Hyeonggon Yoo wrote:
> I completely agree on what Vlastimil said. there should be comment
> saying that generally you should not use kmalloc_index with
> size_is_const == true.

sorry there was human error.
what I mean was: size_is_const == false
