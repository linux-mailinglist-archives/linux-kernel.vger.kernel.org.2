Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 144DE3109CA
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 12:07:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231968AbhBELFv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 06:05:51 -0500
Received: from mail-lj1-f180.google.com ([209.85.208.180]:36543 "EHLO
        mail-lj1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231439AbhBELDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 06:03:00 -0500
Received: by mail-lj1-f180.google.com with SMTP id l12so7256557ljc.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 03:02:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9FZ7JiIRGalR06B1jY8cCbXb/IG0NVBGBAKRBdfVP0k=;
        b=cgXJB0uSCBk55V/+pkc3riIa1yfqHxtozakwUYaYWhL/U3SlH3NNrNiGkPIreYHSq/
         qdjEoWI2dsRvnxYxlkQ/L0+zsh6++3plMgwk83F1gJHE0GyWwec9De8y0QDhiz9pOT0O
         QvglJnrjjIz513/uxlxYPp83ytjtD72lc2Hk6EKoYBkj9nPfwA1iLLWwxXs0hlreuHcz
         Ta36hHsdaXTNDLsumnR+IYSaLB6cry4ehD7xv0IdybJhef26L0xjdMXYbG5mzPivqMo+
         lA72aLDjsGJ1zxPfFy2JJO89SEsZxRAD1Nyyj6n7xKCmonAgG/wkHK2RmPRbh9XdHzZY
         4XOw==
X-Gm-Message-State: AOAM5318wygL4PYXSrflsdrwSktGMn57oFw27VtyhNhyf3sZLXcaAaWM
        p5IVIMWJ0wAGNJemFoQ9Y1OfgyusEHHrF7+bOgw=
X-Google-Smtp-Source: ABdhPJwqrKD0kuGPMAgsgWB/zCaPIwiAlfnMsG5FSWsCsAnIQZ4qZjW9w0t2S2PcVchHtoWSUwc7+0DGzOTSiQpsv8E=
X-Received: by 2002:a2e:90c9:: with SMTP id o9mr2323331ljg.26.1612522938534;
 Fri, 05 Feb 2021 03:02:18 -0800 (PST)
MIME-Version: 1.0
References: <1612296553-21962-1-git-send-email-kan.liang@linux.intel.com> <1612296553-21962-4-git-send-email-kan.liang@linux.intel.com>
In-Reply-To: <1612296553-21962-4-git-send-email-kan.liang@linux.intel.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 5 Feb 2021 20:02:06 +0900
Message-ID: <CAM9d7cj-q_-+98o-VH02WhC+wcJ44bAG8ZyV1UFN7ATT7Lxn6w@mail.gmail.com>
Subject: Re: [PATCH 3/9] perf tools: Support data block and addr block
To:     Kan Liang <kan.liang@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Stephane Eranian <eranian@google.com>,
        Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        Yao Jin <yao.jin@linux.intel.com>, maddy@linux.vnet.ibm.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 3, 2021 at 5:14 AM <kan.liang@linux.intel.com> wrote:
>
> From: Kan Liang <kan.liang@linux.intel.com>
>
> Two new data source fields, to indicate the block reasons of a load
> instruction, are introduced on the Intel Sapphire Rapids server. The
> fields can be used by the memory profiling.
>
> Add a new sort function, SORT_MEM_BLOCKED, for the two fields.
>
> For the previous platforms or the block reason is unknown, print "N/A"
> for the block reason.
>
> Add blocked as a default mem sort key for perf report and
> perf mem report.
>
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> ---
[SNIP]
> +int perf_mem__blk_scnprintf(char *out, size_t sz, struct mem_info *mem_info)
> +{
> +       size_t l = 0;
> +       u64 mask = PERF_MEM_BLK_NA;
> +
> +       sz -= 1; /* -1 for null termination */
> +       out[0] = '\0';
> +
> +       if (mem_info)
> +               mask = mem_info->data_src.mem_blk;
> +
> +       if (!mask || (mask & PERF_MEM_BLK_NA)) {
> +               l += scnprintf(out + l, sz - l, " N/A");
> +               return l;
> +       }
> +       if (mask & PERF_MEM_BLK_DATA)
> +               l += scnprintf(out + l, sz - l, " Data");
> +       if (mask & PERF_MEM_BLK_ADDR)
> +               l += scnprintf(out + l, sz - l, " Addr");

So this means it's possible to have BLK_DATA and BLK_ADDR
together and in that case it'll print "DataAddr", right?

Thanks,
Namhyung


> +
> +       return l;
> +}
> +
>  int perf_script__meminfo_scnprintf(char *out, size_t sz, struct mem_info *mem_info)
>  {
>         int i = 0;
> @@ -348,6 +371,8 @@ int perf_script__meminfo_scnprintf(char *out, size_t sz, struct mem_info *mem_in
>         i += perf_mem__tlb_scnprintf(out + i, sz - i, mem_info);
>         i += scnprintf(out + i, sz - i, "|LCK ");
>         i += perf_mem__lck_scnprintf(out + i, sz - i, mem_info);
> +       i += scnprintf(out + i, sz - i, "|BLK ");
> +       i += perf_mem__blk_scnprintf(out + i, sz - i, mem_info);
>
>         return i;
>  }
