Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96160352019
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 21:48:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235352AbhDATsA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 15:48:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234089AbhDATr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 15:47:59 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC50CC0613E6
        for <linux-kernel@vger.kernel.org>; Thu,  1 Apr 2021 12:47:59 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id i9so3438108qka.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Apr 2021 12:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Qpz5/i5ZiJKb5n7InY8CiPZlk0x+Dq7b/uIx2Bj5OpE=;
        b=gHA/myvRTrd31/FpZ3kQwDv2jGlHY8liwkebl0Xrla8zjpNPXLQr261xsvUieysw+3
         aiOG5eTaNxH2yEBUPqo5T8eKwc5eUs1IvRbCLoM8V0dKE8oFP9PCAhGSGvzl1ZOaHB5f
         0fNY61RvGYD5clArYU0vrt82aYuH1xLDRO+yb0CxMDdtHX6QAOg8itU5lcLPFUHbBSDy
         AYfedNarmeh6T5cC3bIX5NYzGkaQZgPFNwV83zgrhs98VkrPW+mKGo4ykVLI1dCGnU1b
         fERVV5dKAkQOs2oIUoLvQPNcKXyr61FkWOcI4CXq6PdEkFTMfI/UGIXihJZCGOHgLo3h
         1bvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Qpz5/i5ZiJKb5n7InY8CiPZlk0x+Dq7b/uIx2Bj5OpE=;
        b=EGWtzxx8htByjjQt1eLkCv1PUxb5NLmyqFhMoeIzh2vax8u3QkEn9kR07Fus4aIkUJ
         iRYssFcXwT5w07BKVgp/HnONP/JtllBRqA+pXPOkG9nkI2RRKeWESPITSC+LYi1WmmLU
         1grAdTP2em4Z13xdRrxSR24b8Sp7C22QO0V9ZP54uIqSV0aj2KT3zp9IUzTZB8m9K84J
         3qA8RuMtMZBOpA6SaH3buCsuxUQVrQ8mgZH/ujCWcRZu2RxyJoAcxugAQl3CiVVphFqL
         duAtU7rzqalW1qKTZfXYXt5EeP+RWh2/d26E0baSsF+rTst8chb0+QdslltRJRncdjMs
         5l3A==
X-Gm-Message-State: AOAM533rMAzVgOHTiN1DLnNlQRF+fqOoYW/sFEBPr/31IWFWPjfnAi4v
        IvU18l4jowp5s5ZP6gFqq3624A==
X-Google-Smtp-Source: ABdhPJyX+i7fJoUY5Xl4vvZeyhOgOYS40nQagciH0+td2piB+6uyxeb8b41v94ByGinn6A/r9Ujq7A==
X-Received: by 2002:a37:9c4a:: with SMTP id f71mr10025840qke.74.1617306479013;
        Thu, 01 Apr 2021 12:47:59 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:9738])
        by smtp.gmail.com with ESMTPSA id p186sm4887311qka.66.2021.04.01.12.47.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 12:47:58 -0700 (PDT)
Date:   Thu, 1 Apr 2021 15:47:57 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Josh Hunt <johunt@akamai.com>, Ingo Molnar <mingo@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] psi: allow unprivileged users with CAP_SYS_RESOURCE to
 write psi files
Message-ID: <YGYjbcqThAVOi8kP@cmpxchg.org>
References: <20210401033156.7262-1-johunt@akamai.com>
 <YGVshWmKgZgIgBKd@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YGVshWmKgZgIgBKd@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 01, 2021 at 08:47:33AM +0200, Peter Zijlstra wrote:
> On Wed, Mar 31, 2021 at 11:31:56PM -0400, Josh Hunt wrote:
> > Currently only root can write files under /proc/pressure. Relax this to
> > allow tasks running as unprivileged users with CAP_SYS_RESOURCE to be
> > able to write to these files.
> > 
> > Signed-off-by: Josh Hunt <johunt@akamai.com>
> 
> I suppose that's ok, but lets also ask Johannes.

The write creates a kthread that runs as SCHED_FIFO. For userspace
threads this is reserved for CAP_SYS_NICE tasks, but it's a kernel
thread and not arbitrary code, so I suppose CAP_SYS_RESOURCE is fine.

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
