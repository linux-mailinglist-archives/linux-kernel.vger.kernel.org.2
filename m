Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F36233A08A9
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 02:51:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231730AbhFIAxf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 20:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231537AbhFIAxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 20:53:33 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DF5BC061574
        for <linux-kernel@vger.kernel.org>; Tue,  8 Jun 2021 17:51:40 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id 5so1651862qvf.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 17:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=ZRT8zrQ2N9SjTzmLEJcU4+KmU9ocAxkuy2bveBueYwo=;
        b=NYAGWBb4/K4c7eykm4A+8Rr2kdej77JpxU9svLenVqJEjU/93VhMDPF+MIcPnYv31E
         4/l17VYX914tDAGbq52G/8GflBEBfS0uhf2aH4fjZQA1E3eNJWd1Yfe+Ldhqb0pZPZhW
         RNQvzdHdsIae8EWMxmEBl1BPJsi/4FlCts+FDcANdq5H7FszJo6SgZcs8+/Yqmkux6AZ
         /6xWX8lAcmQUerWPZ1diRnzTYqS4EYkKl8Y4/CUxMwxWo3ye8dch5AJ7b7O+0xO3vBWn
         K1SZNidDcISOj/ZBBhWte68Q6/PxQFmdytGMfGyN0lZ6ub03d82Ykx7GL9sfVxq/ixqK
         f9Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=ZRT8zrQ2N9SjTzmLEJcU4+KmU9ocAxkuy2bveBueYwo=;
        b=KgQnLu5omkzXJGgERb/6VBwI8ux0hqv67xgqsPLh+edHEdu03LVLvdOIZtDJ/YftAA
         b4o4VkqTGmVF1iOi3//u8Eqxnt6et7xs0ScSuoSHMpXmLtjP5j7hxk66FCDZFBJ2wb5c
         ZUGBycmMOhJx8wgjfQPFYcsW8I+370FZWbISHV2JkrUqnNve3g3F4gJPTg98NkbMsDvp
         4c548nMqopmJwJXuwm6GVtJ4ZfJqWS0QxuIzm2tueAz6hPFv3j/TcXZk/G8HK5XPpgif
         JzyKKFQCy1E5X+0ex7HVbBU/aZfrMDriseVq/YPpbkhouJgRORwSAHF6jCN1+DX65b8t
         FjYg==
X-Gm-Message-State: AOAM533O07XmqoVdiwEAonkWSBPvLno1qAvZCnV5o4W4QGfQ2hbzOWYS
        BnuEduUEj3Ftn562bHXjRnE=
X-Google-Smtp-Source: ABdhPJz9r33GyMkS6NiGQnyNqezGP+ixa/GbLHKfeN6icVFxqKcSM6aeKs8NdbGSE17Qj6fuBvxLjg==
X-Received: by 2002:a0c:eda5:: with SMTP id h5mr3227067qvr.26.1623199899716;
        Tue, 08 Jun 2021 17:51:39 -0700 (PDT)
Received: from ?IPv6:2804:14c:482:87bb::1002? ([2804:14c:482:87bb::1002])
        by smtp.gmail.com with ESMTPSA id m199sm12011191qke.71.2021.06.08.17.51.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 17:51:39 -0700 (PDT)
Message-ID: <648b382159009c5f4277d9b9c3f896142ea75d6c.camel@gmail.com>
Subject: Re: [PATCH v2 1/3] powerpc/mm/hash: Avoid resizing-down HPT on
 first memory hotplug
From:   Leonardo =?ISO-8859-1?Q?Br=E1s?= <leobras.c@gmail.com>
To:     David Gibson <david@gibson.dropbear.id.au>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Sandipan Das <sandipan@linux.ibm.com>,
        Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Nathan Lynch <nathanl@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Scott Cheloha <cheloha@linux.ibm.com>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date:   Tue, 08 Jun 2021 21:52:10 -0300
In-Reply-To: <YL2obsnp4rWbW6CV@yekko>
References: <20210430143607.135005-1-leobras.c@gmail.com>
         <20210430143607.135005-2-leobras.c@gmail.com> <YL2obsnp4rWbW6CV@yekko>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2021-06-07 at 15:02 +1000, David Gibson wrote:
> On Fri, Apr 30, 2021 at 11:36:06AM -0300, Leonardo Bras wrote:
> > Because hypervisors may need to create HPTs without knowing the
> > guest
> > page size, the smallest used page-size (4k) may be chosen,
> > resulting in
> > a HPT that is possibly bigger than needed.
> > 
> > On a guest with bigger page-sizes, the amount of entries for HTP
> > may be
> > too high, causing the guest to ask for a HPT resize-down on the
> > first
> > hotplug.
> > 
> > This becomes a problem when HPT resize-down fails, and causes the
> > HPT resize to be performed on every LMB added, until HPT size is
> > compatible to guest memory size, causing a major slowdown.
> > 
> > So, avoiding HPT resizing-down on hot-add significantly improves
> > memory
> > hotplug times.
> > 
> > As an example, hotplugging 256GB on a 129GB guest took 710s without
> > this
> > patch, and 21s after applied.
> > 
> > Signed-off-by: Leonardo Bras <leobras.c@gmail.com>
> 
> Sorry it's taken me so long to look at these
> 
> I don't love the extra statefulness that the 'shrinking' parameter
> adds, but I can't see an elegant way to avoid it, so:
> 
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

np, thanks for reviewing!

Best regards,
Leonardo Bras

