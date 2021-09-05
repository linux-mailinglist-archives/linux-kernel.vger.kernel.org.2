Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC93F4011C9
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Sep 2021 23:25:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238390AbhIEV0F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Sep 2021 17:26:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238290AbhIEVZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Sep 2021 17:25:52 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BC42C06175F
        for <linux-kernel@vger.kernel.org>; Sun,  5 Sep 2021 14:24:48 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id l7-20020a1c2507000000b002e6be5d86b3so3411337wml.3
        for <linux-kernel@vger.kernel.org>; Sun, 05 Sep 2021 14:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IzMnieHj8CQ0BE7oCVu9Qby1qRbJ4iUQix525l8uDPE=;
        b=xLIPObrB2QPf9oWi8YMS3tfoo2dLtzgZXok0V8QGIh9uExEgirOpec0D/NqchG1Uv4
         tLklJ2EPANmnkEEGFi/nAN7wxc+BM3qx0/G0T310hPMV7uPs0x+nZVbgQR1Kz2vJ3B54
         e9cRn3M8qeo8kr5t1vT9Vgx2ZoQmAfd4MC9LcEJ10lS6RdoY+hU+K28c2hCsgdscCzO8
         /R81n9BPnGvVo8jaLRhO3kcU1pbipkGL5/7T403dwismDoC+KaesWNhUsqcTCN9Jc1n6
         5ck06m+H3IrWLcVdGZWYgwJxyZ4Th1Estg7sa1gzmktARmtt4Ch/K8E4ySgWxFx/hoWL
         B7bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IzMnieHj8CQ0BE7oCVu9Qby1qRbJ4iUQix525l8uDPE=;
        b=fqgdBveUS7E2KST5rmcubaehiLKGV1FaREUZPywaX7fZzZDwo2S/fAUO0S+Q6fwTQ8
         L2X3lfCgWmVUvHdR8IQg9dnj0AiYKwqB81V5EPV3bEKfJXvgkaGYeMizgpVyuupurHRT
         BAGpcNVmFZB6ab7KGiNLwLYMpqUOOYDZllfw7t7505dV3bCG+4t71og9b8SVDHlBGOY6
         0Ri69Ea6+NzoFyiwwkCjlP8ghk4in9Qzz3PXxdVftHyAzfcRX5Sq8RS+mx4S5Wrl/LZM
         aBbcqNxtXNMgucxf1BsfRDgCGfkBn/fOPYAsQGiuhR17ai0N5Smvc1iCykN9c1B0i6FJ
         Khaw==
X-Gm-Message-State: AOAM531GTkw49vZsJpN8SsaBoLg06pD131U53MP8ESRMPcQokCid73Lt
        vGmxVBUgsaA+T4aqioEgVuSetM4kA8PpprJ5fhBJAQ==
X-Google-Smtp-Source: ABdhPJxYsade69aYn0KH+yIJSt7Vq7VLiTvS8bBvcW8iIn+jft9ImdyuA1gNMMfKpPvk5quvMLwcULgoawAy45mcfNM=
X-Received: by 2002:a7b:cb09:: with SMTP id u9mr8450444wmj.63.1630877087046;
 Sun, 05 Sep 2021 14:24:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210806134109.1182235-1-james.clark@arm.com> <20210806134109.1182235-7-james.clark@arm.com>
 <63c17023-7451-6445-2110-f1f92b06dd41@arm.com> <YTIEDp9hFNNi0cB1@kernel.org>
In-Reply-To: <YTIEDp9hFNNi0cB1@kernel.org>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Sun, 5 Sep 2021 22:24:36 +0100
Message-ID: <CAJ9a7VgjvD0_TN7F70px45Gzh0_txQNUG7s4DDV79E2eQMvcRQ@mail.gmail.com>
Subject: Re: [PATCH v2 6/9] perf cs-etm: Update OpenCSD decoder for ETE
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        James Clark <james.clark@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Coresight ML <coresight@lists.linaro.org>,
        linux-perf-users@vger.kernel.org,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Mike Leach <mike.leach@linaro.org>


On Fri, 3 Sept 2021 at 12:16, Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
>
> Em Fri, Sep 03, 2021 at 10:10:01AM +0100, Suzuki K Poulose escreveu:
> > On 06/08/2021 14:41, James Clark wrote:
> > > OpenCSD v1.1.1 has a bug fix for the installation of the ETE decoder
> > > headers. This also means that including headers separately for each
> > > decoder is unnecessary so remove these.
> > >
> > > Reviewed-by: Leo Yan <leo.yan@linaro.org>
> > > Signed-off-by: James Clark <james.clark@arm.com>
> >
> > Acked-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>
> Thanks, collected the Acked-by.
>
> - Arnaldo



--
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
