Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C70238087B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 13:31:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231140AbhENLcq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 07:32:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbhENLcp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 07:32:45 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A1EDC061574
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 04:31:34 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id t30so2565953pgl.8
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 04:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=Srp0VXunZH7UFMNTDlAEMdWti+cm4J3ENWCu+rjTgcY=;
        b=tqJK9JVQZojXe2r/to2RYOXkEnV5vg+o4P6HVhINeLDagrzFbQt6OPjMWqm80ybqcQ
         cy4znyry/zC7rzSx52SrXociGd1yVAFJlKlZVEAMDnrvsdLzHdbKNy6dagd83pgbwEUX
         +Q3ey44Mj/9R8HKfWFQT+J/kjxW+t6+gb4Zg0o5i5SnBiFm02NOAzYNzA6Ore9lTcjVV
         Czj42yUoq5oNuzkRtolLmSNCTk7e/mW24q9Idy5oWFOQzIe0OQMjPSaQZ1gCYqJgn33Y
         D8FharDhYiNhcsnFHDhHzIR2ziZJL5X4PGUidOTIquNDZxAuo5JaR8uHwfx2IwISpOSb
         rPgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=Srp0VXunZH7UFMNTDlAEMdWti+cm4J3ENWCu+rjTgcY=;
        b=HW9ye2CrBy1Em5YgflW3WSHSsom8il0Ux+4p5NSkHRTM/IwGcO1d4bFGv333Om2Itm
         lzU8hXfz4O1EjDlZwBIJ0ULa6FAYQEUFCDjhMeLw8u5AmHNo/IHC1HBOynfhkNyjMcHs
         re++JHC2cObCiyw52bRgfykz1rrIVnVOPdLZYGdWc8diUja/87A7HDuremoG7p1eWVNz
         goFaLQ0HfBF9SvnjIGnfx1CG6dkv82aAXDf/AnEFumBk8/Lcf2D7ZJ9E7ldgUdiAVbYv
         KBrB5KPZy7TclOcxsiKWWc8VsiYkfco9uBB1GjBhI4X4aC3XPlzK/2UcefutuuL0zOD2
         8LTQ==
X-Gm-Message-State: AOAM530qP9sHzjYOe/CYySIFX7ZB1oLgKmYsA+tAuRGClxq0LQfreRWW
        gv9ucoUZDF+Kqkj9B6cvnBPB1uqPV5Fvid8uzhUgIic0L0CnefHL
X-Google-Smtp-Source: ABdhPJzNz0dlkwxlDNUu8U5xwx901L/3yDr3DskcsO4InYroKpYCNfJes8j1jEAsI+KoasSspEEt1ifm9Gb8O4i0RbY=
X-Received: by 2002:a63:ee53:: with SMTP id n19mr46828553pgk.268.1620991893729;
 Fri, 14 May 2021 04:31:33 -0700 (PDT)
MIME-Version: 1.0
From:   Yiyuan guo <yguoaz@gmail.com>
Date:   Fri, 14 May 2021 19:31:24 +0800
Message-ID: <CAM7=BFpye1oOmF_ddVxDLGZebQRgpRORxN3J4sWcSgkq_nnYyg@mail.gmail.com>
Subject: A possible divide by zero bug in alloc_nodes_vectors
To:     tglx@linutronix.de
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In kernel/irq/affinity.c, the function alloc_nodes_vectors has the
following code:

static void alloc_nodes_vectors(unsigned int numvecs,
                cpumask_var_t *node_to_cpumask,
                const struct cpumask *cpu_mask,
                const nodemask_t nodemsk,
                struct cpumask *nmsk,
                struct node_vectors *node_vectors) {
    unsigned n, remaining_ncpus = 0;
    ...
    for_each_node_mask(n, nodemsk) {
        ...
        ncpus = cpumask_weight(nmsk);

        if (!ncpus)
            continue;
        remaining_ncpus += ncpus;
        ...
    }

    numvecs = min_t(unsigned, remaining_ncpus, numvecs);
    ...
    for (n = 0; n < nr_node_ids; n++) {
        ...
        WARN_ON_ONCE(numvecs == 0);
        ...
        nvectors = max_t(unsigned, 1,
                       numvecs * ncpus / remaining_ncpus);
    }
}

The variable remaining_ncpus may remain 0 if cpumask_weight(nmsk)
keeps returning 0 in the for loop. However, remaining_ncpus is used as
a divisor, leading to a potential divide by zero problem.

Notice that the code explicitly warns about numvecs being zero. And
since it is likely that numvecs equals to remaining_ncpus (because of
assignment: numvecs = min_t(unsigned, remaining_ncpus, numvecs)),
we should probably also check on remaining_ncpus before the division.
