Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D3A0398A2F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 15:02:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbhFBNEh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 09:04:37 -0400
Received: from mail-pf1-f179.google.com ([209.85.210.179]:45811 "EHLO
        mail-pf1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbhFBNEf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 09:04:35 -0400
Received: by mail-pf1-f179.google.com with SMTP id d16so2092421pfn.12
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 06:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YI37M6WTB9tOz3HBK6mip6CCX60bhaIRlELFRiHmBo8=;
        b=WPntc7Kz0gCfuC7el9Vy999j5F05xUwLTaT76ZzqgCUhdhbALv1Fh8zus1SEofEzDn
         gVUwQN3efdDCF8Ekt2wDxM+L0oZAWBwZ96YaYFmFKwxVA+hpWkd3bxiypQgfSjAoVV/Z
         9SSKEuuvAublQXCeAyg0+QLtxoIQBBzQ+s5ZjJdpYdoP5ZOGg6i64ilxFsqQdP4fHjrE
         tmGx/oZjGny/ayR/SoYqLGLflzs6apQk2vO8kmaYYlrQpSJyQEh0s83LCgWNUjCDqIy/
         c7/yrojLy+4smIAEz+4j5FmCz9nIgqAZHREzOhVD+ySv9d2kMEjzFpReAfSUIpc9Ask2
         CR7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YI37M6WTB9tOz3HBK6mip6CCX60bhaIRlELFRiHmBo8=;
        b=E/ZtqXhH2IVYOUaiyYC/J1lvTRFArs/zgAaCtydt3LCwYgYNGY9NkubgFAXtSfyG85
         qRzYRHLIqhVmgpm/xqMGVAfgycnI1shVtuitaZY/s3+M/192/O01pKiilCOayh5/M9NV
         t+E4L/BrDIDsmnigTBhTZ3Q1ZdT7XxilL6iCfCvUyHyFyf5MfJ01tR89lytKnbXCR7m/
         prGsb+uEx5Hy7xj55z/O+qdgrg9IK10ErQUE4SjD0aCVyN9YHnd2ZOcfXc+8HyaU5zck
         EB7Wc3Aq5JUOnla+uPUDB4MXt8nBNoV3vN9R1iYEnr/GViXX4SzMn7+dCGi71HuZmaYZ
         bKkA==
X-Gm-Message-State: AOAM530MbucMZs9bjy74OjWLPToTE8dxmg4bIf9rcK2FjcMbD3xW3ziV
        FlpcKyUI0N5MLkadSJn6CuXOyA==
X-Google-Smtp-Source: ABdhPJxNI77ZxyMoAz4JSba4wJsZgj88a5H7K2T0ZSPsUpwuJZZDEBhk50O02tQ/AXokHZ1pjXXqYQ==
X-Received: by 2002:a63:ff22:: with SMTP id k34mr33546970pgi.336.1622638899656;
        Wed, 02 Jun 2021 06:01:39 -0700 (PDT)
Received: from leoy-ThinkPad-X240s (ec2-18-167-84-74.ap-east-1.compute.amazonaws.com. [18.167.84.74])
        by smtp.gmail.com with ESMTPSA id h13sm10991973pfv.213.2021.06.02.06.01.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 06:01:38 -0700 (PDT)
Date:   Wed, 2 Jun 2021 21:01:32 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 6/8] perf auxtrace: Drop legacy __sync functions
Message-ID: <20210602130132.GF10272@leoy-ThinkPad-X240s>
References: <20210602103007.184993-1-leo.yan@linaro.org>
 <20210602103007.184993-7-leo.yan@linaro.org>
 <fc7bfa25-d96e-ea6d-2756-f94653dc4771@intel.com>
 <20210602111620.GD10272@leoy-ThinkPad-X240s>
 <d179137e-4bbc-0026-3273-622f6dedb002@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d179137e-4bbc-0026-3273-622f6dedb002@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 02, 2021 at 02:21:05PM +0300, Adrian Hunter wrote:
> On 2/06/21 2:16 pm, Leo Yan wrote:
> > Hi Adrian,
> > 
> > On Wed, Jun 02, 2021 at 01:47:42PM +0300, Adrian Hunter wrote:
> > 
> > [...]
> > 
> >>> @@ -451,11 +445,7 @@ static inline u64 auxtrace_mmap__read_snapshot_head(struct auxtrace_mmap *mm)
> >>>  static inline u64 auxtrace_mmap__read_head(struct auxtrace_mmap *mm)
> >>>  {
> >>>  	struct perf_event_mmap_page *pc = mm->userpg;
> >>> -#if BITS_PER_LONG == 64 || !defined(HAVE_SYNC_COMPARE_AND_SWAP_SUPPORT)
> >>
> >> The test and setup for HAVE_SYNC_COMPARE_AND_SWAP_SUPPORT is not needed anymore either.
> > 
> > Yes, I think there have two files should be cleaned:
> > 
> >   Makefile.config
> >   util/auxtrace.c
> > 
> > If still miss anything, please let me know (I remembered there have a
> > test case for __sync_xxx_compare_and_swap, but I cannot find it now,
> > so this is why I am concern if I miss anything not).
> 
> tools/build/feature/test-sync-compare-and-swap.c

Thanks a lot!
