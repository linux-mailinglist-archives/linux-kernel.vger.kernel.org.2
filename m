Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63A58396682
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 19:08:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232490AbhEaRJC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 13:09:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234004AbhEaQxJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 12:53:09 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B81B2C08C5F5
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 08:10:54 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id x18so9207509pfi.9
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 08:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ET6uFordsiWwX4MCNMKhRus+C3EuLNdh9eoANIik8+8=;
        b=uxQrV6jJGwTClKvYEfNPzMNvPtOF0xpt3MjLEvYdAfXOqfEmfb8IImhakUa3zkMp9w
         GoNx9HoqHI6R2jqa89T+r8zAz1WMhF1cjeYu/SzQvv52NEsCZXsdlEgdsdVhEDKSvfzd
         lzzdZhsik9wljdNu6FTmVNKsAiqEBi9rxNwaa/j24ifcxmMrqGJoA4eiL2ayWkfqaMl2
         4vLJffCJ1AvynhPt9UEgyPY07zqAZJ3je3GM62hZsgSY4FHwoMoab9p0un6t6U9WzoiC
         g8gXwT6xuXjQbdhZK+EPpPHSkxgl4ZexOL6IycLGCPK44Hc5+vdY2ZEBbOskzRjMy7Kt
         K1ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ET6uFordsiWwX4MCNMKhRus+C3EuLNdh9eoANIik8+8=;
        b=kdB8ewwV6Fj6u7YrShtEpeKtGR1V6kZ0OtFMfKzJZH+b+QyMsZv8GOsaobujrOlcLL
         AVPh6wAFPBb0E1LntaYZHR8sxFa4y/3y2q2FNsoelfNVksKcXe//rT6by07JLoptzIU+
         HeXEBQNSf+1d6x9Gm6L7uu6pZ4F8Je+aXbcptq8MvIrszBJxzjK4+Uf4O9yaie7T9UJL
         h93S0fQkqB1uP90D3/r7wTosm6R8VQeIwLhy0hbwlDjYXuPzS3BMHhUqxpvc8KGXMxHR
         npDPYc33AZPk8uNxKfljdVlsfDwwyUSJpyPQWm5dsbA2S2QXk9AN3jGXMft6rkVQKuZY
         /tIQ==
X-Gm-Message-State: AOAM533EVmjHhxjl6uwuDuE4xMqpKfVZXU05/Qm9McLXYk309rtYzu2U
        Bmxf/r1k/KRxZPG/Y/fd5+uSr/rkk1HO3Dvq
X-Google-Smtp-Source: ABdhPJzMMkejZt3VKTL6ctQVH8j2oDFU1XAa2OsxjE1kMvD4VotB6aVDwnJd8mL3JHN/jChYu0s0fw==
X-Received: by 2002:aa7:8703:0:b029:2da:b87f:7d38 with SMTP id b3-20020aa787030000b02902dab87f7d38mr17753307pfo.20.1622473854083;
        Mon, 31 May 2021 08:10:54 -0700 (PDT)
Received: from leoy-ThinkPad-X240s (ec2-18-167-84-74.ap-east-1.compute.amazonaws.com. [18.167.84.74])
        by smtp.gmail.com with ESMTPSA id md24sm1519907pjb.43.2021.05.31.08.10.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 May 2021 08:10:53 -0700 (PDT)
Date:   Mon, 31 May 2021 23:10:49 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] perf auxtrace: Optimize barriers with
 load-acquire and store-release
Message-ID: <20210531151049.GE9324@leoy-ThinkPad-X240s>
References: <20210519140319.1673043-1-leo.yan@linaro.org>
 <20210519140319.1673043-2-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210519140319.1673043-2-leo.yan@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter, Adrian,

On Wed, May 19, 2021 at 10:03:19PM +0800, Leo Yan wrote:
> Load-acquire and store-release are one-way permeable barriers, which can
> be used to guarantee the memory ordering between accessing the buffer
> data and the buffer's head / tail.
> 
> This patch optimizes the memory ordering with the load-acquire and
> store-release barriers.

Is this patch okay for you?

Besides this patch, I have an extra question.  You could see for
accessing the AUX buffer's head and tail, it also support to use
compiler build-in functions for atomicity accessing:

  __sync_val_compare_and_swap()
  __sync_bool_compare_and_swap()

Since now we have READ_ONCE()/WRITE_ONCE(), do you think we still need
to support __sync_xxx_compare_and_swap() atomicity?

I checked the code for updating head and tail for the perf ring buffer
(see ring_buffer_read_head() and ring_buffer_write_tail() in the file
tools/include/linux/ring_buffer.h), which doesn't support
__sync_xxx_compare_and_swap() anymore.  This is why I wander if should
drop __sync_xxx_compare_and_swap() atomicity for AUX ring buffer as
well.

Thanks,
Leo
