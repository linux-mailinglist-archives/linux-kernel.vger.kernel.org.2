Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 576EC39235C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 01:45:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233632AbhEZXqs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 19:46:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232342AbhEZXqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 19:46:45 -0400
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DF9DC061574
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 16:45:13 -0700 (PDT)
Received: by mail-oo1-xc29.google.com with SMTP id v13-20020a4ac00d0000b029020b43b918eeso700218oop.9
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 16:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=0y4oXa9mqrbY6uCl4kzhmA7j5A4msSW0Zi3gpLtyg3E=;
        b=V2cmkIfbPjV+x8lih4zZfuj0XcC8fM5ePmgBB/9wiNZa8DUDH+82qaheZ74GKH9ugA
         w13+ybtyIoZQpjI07AxeJ7rIuTL8ftddb8eK+27iY+ezbwy0hVjYBE9MNdQkZOdNZRwi
         mNHfwToudLTxPk7AdurQK8j1f3FIuwc/Ga70M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=0y4oXa9mqrbY6uCl4kzhmA7j5A4msSW0Zi3gpLtyg3E=;
        b=LDSaFs340aOuJtOMAiaKbfQeH01KM6k9htnGVyFs4Z/e5Bgdl2jMcWL8HS1D1IxObL
         z/Hah2eRXaejZ4z/CBFvS7g0oeJ18WDKrVA8YMhQhK/F+yj/2VUNpbn/V1fxMudtMkej
         Cq16KuvMXDnjrwamt5vWwdIXpb6QY1PPmUDaMVdCT3RFtZy96bmvcHSNn8krRhgxYqiE
         z8V4x/P7JkC/+dLg8QlKNYtFQQZnMLTq7p9npEVca7ZTHRfJXQ+rQSiVnpvUJanCJteL
         P5gFs0jwJNUauWXhwNy5VbNOf/KQ1Kuz8TohuzWXlCR8GfQAs05g9Niw3TBxsa3SM5T4
         iapA==
X-Gm-Message-State: AOAM530PrrSzfWAbN7kIQ85Gf3n/vJ77mzbzKxboDs2u0DAhj7dtxk1S
        ZLq+bxKSxB7ShC0MefT6NF+afOpPBinbAx4JJhv4vQ==
X-Google-Smtp-Source: ABdhPJz4ibpQNujOSgI4oVId3Gt1dBFg5wy4X6I0uy9OwxHmhZAOrrbOnDOyYbUo/F1CsWWaDf5CSRksRx98vBJOlPo=
X-Received: by 2002:a05:6820:1048:: with SMTP id x8mr615679oot.16.1622072712535;
 Wed, 26 May 2021 16:45:12 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 26 May 2021 19:45:12 -0400
MIME-Version: 1.0
In-Reply-To: <1621596371-26482-3-git-send-email-mkshah@codeaurora.org>
References: <1621596371-26482-1-git-send-email-mkshah@codeaurora.org> <1621596371-26482-3-git-send-email-mkshah@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Wed, 26 May 2021 19:45:12 -0400
Message-ID: <CAE-0n50pLe-1CbjH9nRgcAuT=EfLEKctoJUrm+FnZVkrCr5+LQ@mail.gmail.com>
Subject: Re: [PATCH v8 2/5] soc: qcom: Add SoC sleep stats driver
To:     Maulik Shah <mkshah@codeaurora.org>, bjorn.andersson@linaro.org,
        evgreen@chromium.org, mka@chromium.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        agross@kernel.org, dianders@chromium.org, linux@roeck-us.net,
        rnayak@codeaurora.org, lsrao@codeaurora.org,
        Mahesh Sivasubramanian <msivasub@codeaurora.org>,
        Lina Iyer <ilina@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Maulik Shah (2021-05-21 04:26:08)
> diff --git a/drivers/soc/qcom/soc_sleep_stats.c b/drivers/soc/qcom/soc_sleep_stats.c
> new file mode 100644
> index 0000000..a8396f9
> --- /dev/null
> +++ b/drivers/soc/qcom/soc_sleep_stats.c
> @@ -0,0 +1,255 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2011-2021, The Linux Foundation. All rights reserved.
> + */
> +
> +#include <linux/debugfs.h>
> +#include <linux/device.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/seq_file.h>
> +
> +#include <linux/soc/qcom/smem.h>
> +#include <clocksource/arm_arch_timer.h>
> +
> +#define STAT_TYPE_OFFSET       0x0
> +#define COUNT_OFFSET           0x4
> +#define LAST_ENTERED_AT_OFFSET 0x8
> +#define LAST_EXITED_AT_OFFSET  0x10
> +#define ACCUMULATED_OFFSET     0x18
> +#define CLIENT_VOTES_OFFSET    0x1c
> +
> +struct subsystem_data {
> +       const char *name;
> +       u32 smem_item;
> +       u32 pid;
> +};
> +
> +static const struct subsystem_data subsystems[] = {
> +       { "modem", 605, 1 },
> +       { "wpss", 605, 13 },
> +       { "adsp", 606, 2 },
> +       { "cdsp", 607, 5 },
> +       { "slpi", 608, 3 },
> +       { "gpu", 609, 0 },
> +       { "display", 610, 0 },
> +       { "adsp_island", 613, 2 },
> +       { "slpi_island", 613, 3 },
> +};
> +
> +struct stats_config {
> +       size_t offset_addr;
> +       size_t num_records;
> +       bool appended_stats_avail;
> +};
> +
> +struct stats_data {
> +       bool appended_stats_avail;
> +       void __iomem *base;
> +};
> +
> +struct sleep_stats {
> +       u32 stat_type;
> +       u32 count;
> +       u64 last_entered_at;
> +       u64 last_exited_at;
> +       u64 accumulated;

Is this coming from memory directly? So we need a bunch of __le32 and
__le64 markings and then the endian swaps?

> +};
> +
> +struct appended_stats {
> +       u32 client_votes;
> +       u32 reserved[3];

This one too? It's stored in smem?

> +};
> +
> +static void qcom_print_stats(struct seq_file *s, const struct sleep_stats *stat)
> +{
> +       u64 accumulated = stat->accumulated;
> +       /*
> +        * If a subsystem is in sleep when reading the sleep stats adjust
> +        * the accumulated sleep duration to show actual sleep time.
> +        */
> +       if (stat->last_entered_at > stat->last_exited_at)
> +               accumulated += arch_timer_read_counter() - stat->last_entered_at;

Doesn't this read the virtual count? Which could be very different than
the physical count that the subsystems see and then write into smem? I
suppose we need some sort of "physical count" reading API to match up
the timestamps that are there but that is sort of hard given that the
physical count isn't always intended to be read by the kernel. Maybe we
should split off an MMIO architected timer to be used by this code that
uses the same clocksource that the other subsystems are using?

> +
> +       seq_printf(s, "Count: %u\n", stat->count);
> +       seq_printf(s, "Last Entered At: %llu\n", stat->last_entered_at);
> +       seq_printf(s, "Last Exited At: %llu\n", stat->last_exited_at);
> +       seq_printf(s, "Accumulated Duration: %llu\n", accumulated);
> +}
> +
> +static int qcom_subsystem_sleep_stats_show(struct seq_file *s, void *unused)
> +{
> +       struct subsystem_data *subsystem = s->private;
> +       struct sleep_stats *stat;
> +
> +       /* Items are allocated lazily, so lookup pointer each time */
> +       stat = qcom_smem_get(subsystem->pid, subsystem->smem_item, NULL);
> +       if (IS_ERR(stat))
> +               return PTR_ERR(stat);

Can this return EPROBE_DEFER to userspace? That would be pretty weird.
Maybe we should convert the return value to -EIO regardless of the error.

> +
> +       qcom_print_stats(s, stat);
> +
> +       return 0;
> +}
> +
> +static int qcom_soc_sleep_stats_show(struct seq_file *s, void *unused)
> +{
> +       struct stats_data *d = s->private;
> +       void __iomem *reg = d->base;
> +       struct sleep_stats stat;
> +
> +       memcpy_fromio(&stat, reg, sizeof(stat));
> +       qcom_print_stats(s, &stat);
> +
> +       if (d->appended_stats_avail) {
> +               struct appended_stats votes;
> +
> +               memcpy_fromio(&votes, reg + CLIENT_VOTES_OFFSET, sizeof(votes));
> +               seq_printf(s, "Client Votes: %#x\n", votes.client_votes);
> +       }
> +
> +       return 0;
> +}
> +
> +DEFINE_SHOW_ATTRIBUTE(qcom_soc_sleep_stats);
> +DEFINE_SHOW_ATTRIBUTE(qcom_subsystem_sleep_stats);
> +
> +static void qcom_create_soc_sleep_stat_files(struct dentry *root, void __iomem *reg,
> +                                            struct stats_data *d, u32 num_records)
> +{
> +       char stat_type[sizeof(u32) + 1] = {0};
> +       u32 offset = 0, type;
> +       int i, j;
> +
> +       for (i = 0; i < num_records; i++) {
> +               d[i].base = reg + offset;
> +
> +               /*
> +                * Read the low power mode name and create debugfs file for it.

What do we do if there are two same named low power modes? Maybe they
should be directories instead with pretty name and values inside of
them.

> +                * The names read could be of below,
> +                * (may change depending on low power mode supported).
> +                * For rpmh-sleep-stats: "aosd", "cxsd" and "ddr".
> +                * For rpm-sleep-stats: "vmin" and "vlow".
> +                */
> +               type = readl(d[i].base);
> +               for (j = 0; j < sizeof(u32); j++) {
> +                       stat_type[j] = type & 0xff;
> +                       type = type >> 8;
> +               }
> +               strim(stat_type);
> +               debugfs_create_file(stat_type, 0400, root, &d[i],
> +                                   &qcom_soc_sleep_stats_fops);
> +
> +               offset += sizeof(struct sleep_stats);
> +               if (d[i].appended_stats_avail)
> +                       offset += sizeof(struct appended_stats);
> +       }
> +}
> +
> +static void qcom_create_subsystem_stat_files(struct dentry *root)
> +{
> +       struct sleep_stats *stat;

const? The pointer isn't used though so is this even relevant?

> +       int i;
> +
> +       for (i = 0; i < ARRAY_SIZE(subsystems); i++) {
> +               stat = qcom_smem_get(subsystems[i].pid, subsystems[i].smem_item, NULL);
> +               if (IS_ERR(stat))
> +                       continue;
> +
> +               debugfs_create_file(subsystems[i].name, 0400, root, (void *)&subsystems[i],

Do we need to cast to void pointer? Is it unused? If it's unused then
pass NULL?

> +                                   &qcom_subsystem_sleep_stats_fops);
> +       }
> +}
> +
> +static int qcom_soc_sleep_stats_probe(struct platform_device *pdev)
> +{
> +       struct resource *res;
> +       void __iomem *reg;
> +       void __iomem *offset_addr;
> +       phys_addr_t stats_base;
> +       resource_size_t stats_size;
> +       struct dentry *root;
> +       const struct stats_config *config;
> +       struct stats_data *d;
> +       int i;
> +
> +       config = device_get_match_data(&pdev->dev);
> +       if (!config)
> +               return -ENODEV;
> +
> +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       if (!res)
> +               return PTR_ERR(res);
> +
> +       offset_addr = ioremap(res->start + config->offset_addr, sizeof(u32));

Why can't we devm_platform_get_and_ioremap_resource()?

> +       if (IS_ERR(offset_addr))
> +               return PTR_ERR(offset_addr);
> +
> +       stats_base = res->start | readl_relaxed(offset_addr);
> +       stats_size = resource_size(res);
> +       iounmap(offset_addr);

Oh because of unmap? Can we add a resource for stats_base/size to the
system? I'd really like to see what address that is at. I think it is
actually within the same region of this "pointer" that is assigned in
DT, but I honestly don't know why we wouldn't just hardcode the address
in DT to begin with instead of doing this map, find the real address,
and then map that. Is this really changing that often? Probably it
changes a few times during development but then it settles down and we
can just hardcode it in DT? At least please make a resource and reserve
it so we know that the region isn't being used by other kernel drivers.

> +
> +       reg = devm_ioremap(&pdev->dev, stats_base, stats_size);
> +       if (!reg)
> +               return -ENOMEM;
> +
> +       d = devm_kcalloc(&pdev->dev, config->num_records,
> +                        sizeof(*d), GFP_KERNEL);
> +       if (!d)
> +               return -ENOMEM;
> +
> +       for (i = 0; i < config->num_records; i++)
> +               d[i].appended_stats_avail = config->appended_stats_avail;
> +
> +       root = debugfs_create_dir("qcom_sleep_stats", NULL);
> +
> +       qcom_create_subsystem_stat_files(root);
> +       qcom_create_soc_sleep_stat_files(root, reg, d, config->num_records);
> +
> +       platform_set_drvdata(pdev, root);
> +
> +       return 0;
> +}
> +
> +static int qcom_soc_sleep_stats_remove(struct platform_device *pdev)
> +{
> +       struct dentry *root = platform_get_drvdata(pdev);
> +
> +       debugfs_remove_recursive(root);
> +
> +       return 0;
> +}
> +
> +static const struct stats_config rpm_data = {
> +       .offset_addr = 0x14,
> +       .num_records = 2,
> +       .appended_stats_avail = true,
> +};
> +
> +static const struct stats_config rpmh_data = {
> +       .offset_addr = 0x4,
> +       .num_records = 3,
> +       .appended_stats_avail = false,
> +};
> +
> +static const struct of_device_id qcom_soc_sleep_stats_table[] = {
> +       { .compatible = "qcom,rpm-sleep-stats", .data = &rpm_data },
> +       { .compatible = "qcom,rpmh-sleep-stats", .data = &rpmh_data },
> +       { }
> +};
> +
> +static struct platform_driver soc_sleep_stats_driver = {

A driver seems pretty heavyweight for a thing that sticks stuff into
debugfs. It's not "driving" anything.

> +       .probe = qcom_soc_sleep_stats_probe,
> +       .remove = qcom_soc_sleep_stats_remove,
> +       .driver = {
> +               .name = "soc_sleep_stats",
> +               .of_match_table = qcom_soc_sleep_stats_table,
> +       },
> +};
> +module_platform_driver(soc_sleep_stats_driver);
> +
> +MODULE_DESCRIPTION("Qualcomm Technologies, Inc. (QTI) SoC Sleep Stats driver");
> +MODULE_LICENSE("GPL v2");
> +MODULE_SOFTDEP("pre: smem");
