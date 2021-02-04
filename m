Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0354B30F33C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 13:36:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235767AbhBDMdi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 07:33:38 -0500
Received: from mail-qk1-f169.google.com ([209.85.222.169]:43547 "EHLO
        mail-qk1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235804AbhBDMdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 07:33:36 -0500
Received: by mail-qk1-f169.google.com with SMTP id a12so3024801qkh.10
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 04:33:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wnZqjJEuExXvr2ahGiSYibU6oH4Y3j4NoTprC9RFWDg=;
        b=D6FBUD8h+B/Nj0wJKRwsDKLhE16lkwWCuQ2a5O3b60ofRXR1OxIl+ZQA+7xpkiAfpG
         1rVsOfy82pI4wLaxNySOKhZamrTADiHmuslZof6Pr8uFwy/XZeApYom8clwcsN5tHpk1
         lTR1vM8WYcWkufBcWi5Lfd50aSzBHsmYyjmt7rDkby9Kc3F0sNhOXT2LBwYskzc52prp
         CrXFAKQFk/A4U1zXwyOIveLSiQsASbRZxVKLUsnWFhK73L8y+83KvQWtw0e56z8UfLYF
         6rWlqOLSOG3+KsJF35CDMCsdV2K4UwYplXwiMFLdWON5Nvts1AAy4+NmVq2FRpkYwX4z
         cV1Q==
X-Gm-Message-State: AOAM533bX++GD4EWmaTrqFMLmP4qMOktO2zGI8WASCaNpa8oRuA8Iwmg
        qNUX8nRc3Tpqqy9a/2x/CkFsoTjg65ajObLAVv7eyWxm
X-Google-Smtp-Source: ABdhPJxnt7QDaUI17QwShWbNjSW8g3oWDEZBSFLLfjeKThtbOqR9ZceMt4zh2R1V1qNnKZHduTsgApE0fQlnzTkSt6E=
X-Received: by 2002:a37:648e:: with SMTP id y136mr7192699qkb.148.1612441975361;
 Thu, 04 Feb 2021 04:32:55 -0800 (PST)
MIME-Version: 1.0
References: <20210203135830.38568-1-alexander.antonov@linux.intel.com> <20210203135830.38568-4-alexander.antonov@linux.intel.com>
In-Reply-To: <20210203135830.38568-4-alexander.antonov@linux.intel.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 4 Feb 2021 21:32:43 +0900
Message-ID: <CAM9d7cjs5Su824v+02rEWd5jgvt8tGsMmoXftXBsj-mTTU_xkA@mail.gmail.com>
Subject: Re: [PATCH v4 3/5] perf stat: Helper functions for PCIe root ports
 list in iostat mode
To:     Alexander Antonov <alexander.antonov@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Rogers <irogers@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 3, 2021 at 10:58 PM Alexander Antonov
<alexander.antonov@linux.intel.com> wrote:
>
> Introduce helper functions to control PCIe root ports list.
> These helpers will be used in the follow-up patch.
>
> Signed-off-by: Alexander Antonov <alexander.antonov@linux.intel.com>
> ---
>  tools/perf/arch/x86/util/iostat.c | 124 ++++++++++++++++++++++++++++++
>  1 file changed, 124 insertions(+)
>  create mode 100644 tools/perf/arch/x86/util/iostat.c
>
> diff --git a/tools/perf/arch/x86/util/iostat.c b/tools/perf/arch/x86/util/iostat.c
> new file mode 100644
> index 000000000000..961e540106e6
> --- /dev/null
> +++ b/tools/perf/arch/x86/util/iostat.c
> @@ -0,0 +1,124 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * perf iostat
> + *
> + * Copyright (C) 2020, Intel Corporation
> + *
> + * Authors: Alexander Antonov <alexander.antonov@linux.intel.com>
> + */
> +
> +#include <api/fs/fs.h>
> +#include <linux/kernel.h>
> +#include <linux/err.h>
> +#include <limits.h>
> +#include <stdio.h>
> +#include <string.h>
> +#include <errno.h>
> +#include <sys/types.h>
> +#include <sys/stat.h>
> +#include <fcntl.h>
> +#include <dirent.h>
> +#include <unistd.h>
> +#include <stdlib.h>
> +#include <regex.h>
> +#include "util/cpumap.h"
> +#include "util/debug.h"
> +#include "util/iostat.h"
> +#include "util/counts.h"
> +#include "path.h"
> +
> +struct iio_root_port {
> +       u32 domain;
> +       u8 bus;
> +       u8 die;
> +       u8 pmu_idx;
> +       int idx;
> +};
> +
> +struct iio_root_ports_list {
> +       struct iio_root_port **rps;
> +       int nr_entries;
> +};
> +
> +static void iio_root_port_show(FILE *output,
> +                              const struct iio_root_port * const rp)
> +{
> +       if (output && rp)
> +               fprintf(output, "S%d-uncore_iio_%d<%04x:%02x>\n",
> +                       rp->die, rp->pmu_idx, rp->domain, rp->bus);
> +}
> +
> +static struct iio_root_port *iio_root_port_new(u32 domain, u8 bus,
> +                                              u8 die, u8 pmu_idx)
> +{
> +       struct iio_root_port *p = calloc(1, sizeof(*p));
> +
> +       if (p) {
> +               p->domain = domain;
> +               p->bus = bus;
> +               p->die = die;
> +               p->pmu_idx = pmu_idx;
> +       }
> +       return p;
> +}
> +
> +static struct iio_root_ports_list *iio_root_ports_list_new(void)
> +{
> +       struct iio_root_ports_list *list = calloc(1, sizeof(*list));
> +
> +       if (list) {
> +               list->rps = calloc(1, sizeof(struct iio_root_port *));

This seems unnecessary now.

Thanks,
Namhyung


> +               if (!list->rps) {
> +                       free(list);
> +                       list = NULL;
> +               }
> +       }
> +       return list;
> +}
> +
> +static void iio_root_ports_list_free(struct iio_root_ports_list *list)
> +{
> +       int idx;
> +
> +       if (list) {
> +               for (idx = 0; idx < list->nr_entries; idx++)
> +                       free(list->rps[idx]);
> +               free(list->rps);
> +               free(list);
> +       }
> +}
> +
> +static struct iio_root_port *iio_root_port_find_by_notation(
> +       const struct iio_root_ports_list * const list, u32 domain, u8 bus)
> +{
> +       int idx;
> +       struct iio_root_port *rp;
> +
> +       if (list) {
> +               for (idx = 0; idx < list->nr_entries; idx++) {
> +                       rp = list->rps[idx];
> +                       if (rp && rp->domain == domain && rp->bus == bus)
> +                               return rp;
> +               }
> +       }
> +       return NULL;
> +}
> +
> +static int iio_root_ports_list_insert(struct iio_root_ports_list *list,
> +                                     struct iio_root_port * const rp)
> +{
> +       struct iio_root_port **tmp_buf;
> +
> +       if (list && rp) {
> +               rp->idx = list->nr_entries++;
> +               tmp_buf = realloc(list->rps,
> +                                 list->nr_entries * sizeof(*list->rps));
> +               if (!tmp_buf) {
> +                       pr_err("Failed to realloc memory\n");
> +                       return -ENOMEM;
> +               }
> +               tmp_buf[rp->idx] = rp;
> +               list->rps = tmp_buf;
> +       }
> +       return 0;
> +}
> --
> 2.19.1
>
