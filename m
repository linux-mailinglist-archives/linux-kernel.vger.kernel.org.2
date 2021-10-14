Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD5D142DF14
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 18:24:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232168AbhJNQ0L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 12:26:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbhJNQ0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 12:26:10 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EDD1C061570
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 09:24:05 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id r2so5994832pgl.10
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 09:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8caCDNPFMmNfuRznG9w7pDuUC8TdSEFuYL6ivhAOJqk=;
        b=hnnyxxTS7dMEJQ5ENJoSM5rPFfMcoLjf7VtGDO5RGa2TtpNDoH2qCvDfsxxTfErv6q
         8VSIC6MMKA79HdNVYjNYYJDHWT6sDk+R72RYwk2XkjPWGdCpvAqos5IambbNCMy8yQ2z
         cK7nwnEZ/Djiu1tIUPAXqCN6jT4Xk/Ofe8ZK+i/xUOTDZz+usiwQLBaHOSQnpwTtPYIX
         ALJlzHtYoocvk7GgRLIeF3HRmWpu9ONYzetSHknvW5uoiX3OfDN+aFAXi75gHYrRiYHc
         535QKI3iKue+SpfKMOJk9C60kiBWG/efbv8u+12GK8ez2jdLpq9d5XMocPJV/8uoRdnm
         khAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8caCDNPFMmNfuRznG9w7pDuUC8TdSEFuYL6ivhAOJqk=;
        b=Saao/EVhVeOC1eVONVbrqPJ9Xt60szDZg2pA1IE+FPik6Rxjj6BAIrNdpv2i1FA5xf
         cHn71xMTZ4i8Zmn3j1Q7bIvJnrk2s1lm66CsHfYFKdv/3YObDCWbThfuED0QSrnuCLFP
         gXSppFx4am4miCmkeHyTQ/kv1TpunXayKNqfOWze8X9A8y9ewDLmPFM/BUZp6F6rC1vF
         /QEs8HiXEeBVeBUkUik1X1I3UNzA4FzRqnaUHTz1SzFYfAcxuwC9hg0+K7klpVB3IAzG
         TbZ7UW7ewfiGh2btQ1pxCKJgqZwZ1Ocq1S2lbYQcMGroaFgzeZ2clZdhkLrv7iW3GcHB
         wLrA==
X-Gm-Message-State: AOAM533PBk4T5O1ClbVIM/BsiRqbIx+Q5gYa/vnzq+xwCbi+Ff7NOxzy
        xm2o0t/lEznd4KbPY5s4PIXSNRDAn0kNWXAo+zD/HA==
X-Google-Smtp-Source: ABdhPJwoH+pZbyXqKyQ+siMj10w2OTsMOxRIun1VuHKw6g/5DrarGMrwOQFFDj2ixrWnnuI3SkDYU5plD22RseXMzRg=
X-Received: by 2002:a63:3483:: with SMTP id b125mr5044019pga.79.1634228644402;
 Thu, 14 Oct 2021 09:24:04 -0700 (PDT)
MIME-Version: 1.0
References: <20211014013704.2854890-1-kaleshsingh@google.com> <202110141958.OJhbnOjj-lkp@intel.com>
In-Reply-To: <202110141958.OJhbnOjj-lkp@intel.com>
From:   Kalesh Singh <kaleshsingh@google.com>
Date:   Thu, 14 Oct 2021 09:23:53 -0700
Message-ID: <CAC_TJveDcGYMHrGB=tsnjrysBBpf-73uxtN8cGom1G3E5hsZiw@mail.gmail.com>
Subject: Re: [PATCH v2] tracing/cfi: Fix cmp_entries_* functions signature mismatch
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, Suren Baghdasaryan <surenb@google.com>,
        Hridya Valsaraju <hridya@google.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 14, 2021 at 4:13 AM kernel test robot <lkp@intel.com> wrote:
>
> Hi Kalesh,
>
> Thank you for the patch! Perhaps something to improve:
>
> [auto build test WARNING on 348949d9a4440abdab3b1dc99a9bb660e8c7da7c]
>
> url:    https://github.com/0day-ci/linux/commits/Kalesh-Singh/tracing-cfi-Fix-cmp_entries_-functions-signature-mismatch/20211014-093824
> base:   348949d9a4440abdab3b1dc99a9bb660e8c7da7c
> config: arm64-randconfig-r005-20211014 (attached as .config)
> compiler: aarch64-linux-gcc (GCC) 11.2.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/0day-ci/linux/commit/aca9efb61e0559ff7abff8c8bce5e1a65a73ccce
>         git remote add linux-review https://github.com/0day-ci/linux
>         git fetch --no-tags linux-review Kalesh-Singh/tracing-cfi-Fix-cmp_entries_-functions-signature-mismatch/20211014-093824
>         git checkout aca9efb61e0559ff7abff8c8bce5e1a65a73ccce
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross ARCH=arm64
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All warnings (new ones prefixed by >>):
>
>    kernel/trace/tracing_map.c: In function 'cmp_entries_dup':
> >> kernel/trace/tracing_map.c:839:52: warning: initialization discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
>      839 |         const struct tracing_map_sort_entry **pa = A;
>          |                                                    ^
>    kernel/trace/tracing_map.c:840:52: warning: initialization discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
>      840 |         const struct tracing_map_sort_entry **pb = B;
>          |                                                    ^
>    kernel/trace/tracing_map.c: In function 'cmp_entries_sum':
>    kernel/trace/tracing_map.c:853:52: warning: initialization discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
>      853 |         const struct tracing_map_sort_entry **pa = A;
>          |                                                    ^
>    kernel/trace/tracing_map.c:854:52: warning: initialization discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
>      854 |         const struct tracing_map_sort_entry **pb = B;
>          |                                                    ^
>    kernel/trace/tracing_map.c: In function 'cmp_entries_key':
>    kernel/trace/tracing_map.c:884:52: warning: initialization discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
>      884 |         const struct tracing_map_sort_entry **pa = A;
>          |                                                    ^
>    kernel/trace/tracing_map.c:885:52: warning: initialization discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
>      885 |         const struct tracing_map_sort_entry **pb = B;
>          |                                                    ^
>

I posted a v3 to address these:
https://lore.kernel.org/r/20211014045217.3265162-1-kaleshsingh@google.com/

Thanks,
Kalesh
>
> vim +/const +839 kernel/trace/tracing_map.c
>
>    836
>    837  static int cmp_entries_dup(const void *A, const void *B)
>    838  {
>  > 839          const struct tracing_map_sort_entry **pa = A;
>    840          const struct tracing_map_sort_entry **pb = B;
>    841          const struct tracing_map_sort_entry *a = *pa;
>    842          const struct tracing_map_sort_entry *b = *pb;
>    843          int ret = 0;
>    844
>    845          if (memcmp(a->key, b->key, a->elt->map->key_size))
>    846                  ret = 1;
>    847
>    848          return ret;
>    849  }
>    850
>
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
