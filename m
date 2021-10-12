Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9857429BBE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 05:09:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232071AbhJLDLP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 23:11:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231755AbhJLDLO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 23:11:14 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44FB2C06161C
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 20:09:13 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id w10so43475098ybt.4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 20:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FTVshl9Jefo2BzQxtGM9kFLryo0edF9MOJ5E+vVxA44=;
        b=efFH465LIdLBSe6pxeyXd6rpuBwhMRC7O641rjKon+zYzEi5zbCl6aXlyPw/kzRD2e
         hxvl04IAP8Lu0xmEIuQ1Y28asASEfpDySl+jvc7b+sXSYgSIxyN3/50TvP50fjOYDyby
         VQpu6oRd5fS7xFjzsN9pB0qHjFoZixL6UN3Dro8F0prUKfJUku4cuuPpEMV4Y5tsvhTJ
         Yb0Uw6u4NXyR9qD8lSLLvqFk5Dz4TqSZQPR//vgcu3rf69JusHZmsVHWLln1Cj7+r9x0
         wHDrZfrg5nQWhQ6Q6OTKuA66jB8rYEhjj7KXv0FW+8d3CyhCxSTmxFV5VWpUlYcTABEc
         sBPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FTVshl9Jefo2BzQxtGM9kFLryo0edF9MOJ5E+vVxA44=;
        b=pR4WvEuxTwoVIrQM7H8HC9AJ8hRGEZxQPjy4zbwD7/ZmlW2/ZzjBF/GD+Sq6VzSbD9
         5mpq+J6nb27VY6T7ybQkALFVuU5HH4cpJADLei8xMiroxDqXo3cGm0iYjGh9GAaH+W/H
         CzU91V2/wzmFzbgZNNUW3Tl86Kg4cbtNBA9hzpxLVVzbPa2C2YXnbExkOD7kNsz9UKfF
         y+hvjSqYRY/nPjJdpFGUd5PfIXUZ7dgivKQiaDu0Tg2FHvAJ+jQ6Y2s0alvb+woAPB7X
         T4/GgWzmbTHrD+zFpVsSfpWQwtGLtlEL0amP2VfFV1XpdsldZD2QmGCKktq+/d5jbRb8
         iFUA==
X-Gm-Message-State: AOAM532AyygGI+QNqYgLx/WdBLEnEXdBjndjHByg17XfgrRkzRl0eNkq
        2PM4vqoBdHKd0VgVrB+gqONVyw2WDoyvf2zdKxgusA==
X-Google-Smtp-Source: ABdhPJzJS9y19I8QsN2CIc+h2Q+qEVwU2WZQBTowP4Q1pR7aazPCRPw2H9xNl2hUVLv6e/ATtWp904GkhyIGzEVaBg4=
X-Received: by 2002:a25:ba08:: with SMTP id t8mr27043351ybg.111.1634008152410;
 Mon, 11 Oct 2021 20:09:12 -0700 (PDT)
MIME-Version: 1.0
References: <20211012021321.291635-1-irogers@google.com>
In-Reply-To: <20211012021321.291635-1-irogers@google.com>
From:   =?UTF-8?B?RsSBbmctcnXDrCBTw7JuZw==?= <maskray@google.com>
Date:   Mon, 11 Oct 2021 20:09:01 -0700
Message-ID: <CAFP8O3L_Oi916yOAuPB7MFpa3QoDQtreRbV7oNt2Yh6h1Coq9A@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] tools: Bump minimum LLVM C++ std to GNU++14
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <Mark.Rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Leo Yan <leo.yan@linaro.org>,
        Michael Petlan <mpetlan@redhat.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 11, 2021 at 7:13 PM Ian Rogers <irogers@google.com> wrote:
>
> LLVM 9 (current release is LLVM 13) moved the minimum C++ version to
> GNU++14. Bump the version numbers in the feature test and perf build.
>
> Signed-off-by: Ian Rogers <irogers@google.com>


Reviewed-by: Fangrui Song <maskray@google.com>
