Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9517331C949
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 12:03:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbhBPLDW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 06:03:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbhBPLAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 06:00:50 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE889C061574
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 02:59:45 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id n8so12346640wrm.10
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 02:59:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4WaTVtSgctCLH5CW/OFKatQhtcNElL48/IKb5sH9hRM=;
        b=WgnTiNYLRWJ25zw5SRDQcnpLTRkkXPvgniBRwAwa1/vJu+Nl+fq2/NoOv/AC6jcwAi
         KBFECHy2/8WDz1xI5Fgv+51vaz98l3or8H/J1VEYEX/tbPKvDsqAL3q2tw4XXqM6bciD
         Xxo7DXsOZWFNiTWrLIx6vU1qefT4hoLrL+Co5wNstGzrXEBkKsPO9eGZfpmmqZKhjI74
         +1P4+96KUxb4vyf1K2OU/70otWdUZXIMnosB52r3LPaq5yRmsugyw+V3NTn3Db1dxAgL
         oGg2hBECe69zlMZl0LnGIsYhMxOBILHybSDcggs6WemT/HEN29ec2B9xhZpLyb7qmwLK
         IOXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4WaTVtSgctCLH5CW/OFKatQhtcNElL48/IKb5sH9hRM=;
        b=kX+ogO7B9ht8I4ZkSZ155Zs5qG8Szyb6Re8g3XIW6L8lJUTwbz8izlHbkZaNHXZCRX
         iq/lBbrNPvVPRr/etEC/TLikAEl9c1QKzCMhhE+SnzkmeqiBwPFUeRIoITquhLRp0j+P
         A2Xdxb+In9uYEgzl19faCWyQIqGBQvPWOGY7Z0NfZYb0wg2YcyhlOQvk3Jr9Xwg6Zfk5
         FnHUC6gjRapbAZqhSLW3Bv7i+Z9XAX2vqPd2mKmDShYWtPp1gwh25KC+oEYNl7OMXc84
         ZeBPKpzd6Ha9PjkR4xqBqeWyHFMQ+MXPAbVnNlKGS63blYGWYBH3vqrt+C0o5KwOYZbT
         tO8g==
X-Gm-Message-State: AOAM532s+tjN28oYOYufoaV0dl6UDUNRK2hssLyWqLLsyNNYgGgUhNmV
        77StEoS/Yjz+yTbE7LAdo/dNZoSLqafo196+m1wj+A==
X-Google-Smtp-Source: ABdhPJxbnl4xZFOK79lV94MG+SsADzMn6eveXlHElu1wy50LjpgpBfWPCDIiov6PxSFRNTdxdoUfdzxks9HnXI6QSZk=
X-Received: by 2002:adf:df88:: with SMTP id z8mr23214594wrl.39.1613473184619;
 Tue, 16 Feb 2021 02:59:44 -0800 (PST)
MIME-Version: 1.0
References: <1611737738-1493-1-git-send-email-anshuman.khandual@arm.com> <1611737738-1493-14-git-send-email-anshuman.khandual@arm.com>
In-Reply-To: <1611737738-1493-14-git-send-email-anshuman.khandual@arm.com>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Tue, 16 Feb 2021 10:59:33 +0000
Message-ID: <CAJ9a7Vies-1wy8kmtpf_gFQgXi=rouP5njYkqjSQaCSrfUwt8w@mail.gmail.com>
Subject: Re: [PATCH V3 13/14] perf: aux: Add flags for the buffer format
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Coresight ML <coresight@lists.linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        "Suzuki K. Poulose" <suzuki.poulose@arm.com>,
        Linu Cherian <lcherian@marvell.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Ziljstra <peterz@infradead.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Mathieu Poirier <mathieu.poirer@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Jan 2021 at 08:56, Anshuman Khandual
<anshuman.khandual@arm.com> wrote:
>
> From: Suzuki K Poulose <suzuki.poulose@arm.com>
>
> Allocate a byte for advertising the PMU specific format type
> of the given AUX record. A PMU could end up providing hardware
> trace data in multiple format in a single session.
>
> e.g, The format of hardware buffer produced by CoreSight ETM
> PMU depends on the type of the "sink" device used for collection
> for an event (Traditional TMC-ETR/Bs with formatting or
> TRBEs without any formatting).
>
>  # Boring story of why this is needed. Goto The_End_of_Story for skipping.
>
> CoreSight ETM trace allows instruction level tracing of Arm CPUs.
> The ETM generates the CPU excecution trace and pumps it into CoreSight
> AMBA Trace Bus and is collected by a different CoreSight component
> (traditionally CoreSight TMC-ETR /ETB/ETF), called "sink".
> Important to note that there is no guarantee that every CPU has
> a dedicated sink.  Thus multiple ETMs could pump the trace data
> into the same "sink" and thus they apply additional formatting
> of the trace data for the user to decode it properly and attribute
> the trace data to the corresponding ETM.
>
> However, with the introduction of Arm Trace buffer Extensions (TRBE),
> we now have a dedicated per-CPU architected sink for collecting the
> trace. Since the TRBE is always per-CPU, it doesn't apply any formatting
> of the trace. The support for this driver is under review [1].
>
> Now a system could have a per-cpu TRBE and one or more shared
> TMC-ETRs on the system. A user could choose a "specific" sink
> for a perf session (e.g, a TMC-ETR) or the driver could automatically
> select the nearest sink for a given ETM. It is possible that
> some ETMs could end up using TMC-ETR (e.g, if the TRBE is not
> usable on the CPU) while the others using TRBE in a single
> perf session. Thus we now have "formatted" trace collected
> from TMC-ETR and "unformatted" trace collected from TRBE.
> However, we don't get into a situation where a single event
> could end up using TMC-ETR & TRBE. i.e, any AUX buffer is
> guaranteed to be either RAW or FORMATTED, but not a mix
> of both.
>
> As for perf decoding, we need to know the type of the data
> in the individual AUX buffers, so that it can set up the
> "OpenCSD" (library for decoding CoreSight trace) decoder
> instance appropriately. Thus the perf.data file must conatin
> the hints for the tool to decode the data correctly.
>
> Since this is a runtime variable, and perf tool doesn't have
> a control on what sink gets used (in case of automatic sink
> selection), we need this information made available from
> the PMU driver for each AUX record.
>
>  # The_End_of_Story
>
> Cc: Peter Ziljstra <peterz@infradead.org>
> Cc: alexander.shishkin@linux.intel.com
> Cc: mingo@redhat.com
> Cc: will@kernel.org
> Cc: mark.rutland@arm.com
> Cc: mike.leach@linaro.org
> Cc: acme@kernel.org
> Cc: jolsa@redhat.com
> Cc: Mathieu Poirier <mathieu.poirer@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
>  include/uapi/linux/perf_event.h | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
> index b15e344..9a5ca45 100644
> --- a/include/uapi/linux/perf_event.h
> +++ b/include/uapi/linux/perf_event.h
> @@ -1105,10 +1105,11 @@ enum perf_callchain_context {
>  /**
>   * PERF_RECORD_AUX::flags bits
>   */
> -#define PERF_AUX_FLAG_TRUNCATED                0x01    /* record was truncated to fit */
> -#define PERF_AUX_FLAG_OVERWRITE                0x02    /* snapshot from overwrite mode */
> -#define PERF_AUX_FLAG_PARTIAL          0x04    /* record contains gaps */
> -#define PERF_AUX_FLAG_COLLISION                0x08    /* sample collided with another */
> +#define PERF_AUX_FLAG_TRUNCATED                        0x01    /* record was truncated to fit */
> +#define PERF_AUX_FLAG_OVERWRITE                        0x02    /* snapshot from overwrite mode */
> +#define PERF_AUX_FLAG_PARTIAL                  0x04    /* record contains gaps */
> +#define PERF_AUX_FLAG_COLLISION                        0x08    /* sample collided with another */
> +#define PERF_AUX_FLAG_PMU_FORMAT_TYPE_MASK     0xff00  /* PMU specific trace format type */
>
>  #define PERF_FLAG_FD_NO_GROUP          (1UL << 0)
>  #define PERF_FLAG_FD_OUTPUT            (1UL << 1)
> --
> 2.7.4
>

Reviewed by: Mike Leach <mike.leach@linaro.org>
-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
