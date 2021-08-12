Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 998DC3E9DAF
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 06:44:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234038AbhHLEpK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 00:45:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233944AbhHLEpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 00:45:09 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A312FC061765
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 21:44:44 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id a20so5703712plm.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 21:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0vicLVzCCl9YmTsU4Ijx176av4bofRoa23f7HFotu84=;
        b=ds3Ixf4GeKZ7ZyS3IbS8j8E3plLFal26OWPsMZMVC7EnzwayHTymd/ENxyf06Ft4Zw
         FQptdw7FfpSGOt3a8vb1gpPsQME5oCteIHGHSN0KHNAa7928B4ZuLmm4rfigW82Q231M
         7/9PjZebE/JxOT/lrYWePjTjoCDfTdvhxUgkunftZoJJGVoWN0+3Z/N0y/b7g/K6C2sg
         Asjb3mgU7rWnx1jBk0STbtTudU4ie3XVTixjmN8xaf2ETLobmwbPNHpCz34fEOPvplOs
         x+rY12Fcufh2NqrUtxwdSBNSERtvAzgb3LLwoNlzXR8I5PNMxELtV6BOsvJFz230+uSO
         AMDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0vicLVzCCl9YmTsU4Ijx176av4bofRoa23f7HFotu84=;
        b=NzsQXqGW1jlmkFdc9RnfMix39D8KL9qGInmIN6R2NKKpGPlD0s1ZclIZXjchv1OlMo
         YoMtE6AE/bR/PsDDGCTHDkfx5gs3Utx5m4V8DnjrmkV7CHj+O5Y0Mx5m1YbJzrC0AfRI
         L97i2qFifE6icsCZQKfY7gciGNchxu2z0kEHIRexhoiA6hd0cqMVtBdla523imw2n2Vr
         FTz/R6Dwu2fivxZBs+/tID7HEmeighwM4X9x95AiEXu5pECuiNGLkcr5G4XVtkjain+Y
         qfFNPBVDahQFN8uU2vN3hHKsGwtV0P/BgvF/C8etdJnofPZBmt7QHl9WnM2DgGABFXqy
         qI7A==
X-Gm-Message-State: AOAM530UQQe5mbGfZnvGr5/tTCvZwJVcgmFvf/+oZok0cB2vxsnkzxEB
        VBeRAbXVLUHrQZy/vI4XbRI=
X-Google-Smtp-Source: ABdhPJyh4lUN4Pe6L8cT4X5gRmCXkYOoauoclelCZKN5DvRdWU1Aah1v7MTgXlE/Xm3wOYPV4nXP3g==
X-Received: by 2002:a05:6a00:26f7:b029:3be:5428:3994 with SMTP id p55-20020a056a0026f7b02903be54283994mr2340060pfw.42.1628743484030;
        Wed, 11 Aug 2021 21:44:44 -0700 (PDT)
Received: from localhost.localdomain ([2407:7000:8916:5000:73b9:7bc0:297c:e850])
        by smtp.gmail.com with ESMTPSA id y23sm1417536pgf.38.2021.08.11.21.44.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 21:44:43 -0700 (PDT)
From:   Barry Song <21cnbao@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     song.bao.hua@hisilicon.com, agordeev@linux.ibm.com,
        akpm@linux-foundation.org, andriy.shevchenko@linux.intel.com,
        bristot@redhat.com, dave.hansen@intel.com, guodong.xu@linaro.org,
        jianpeng.ma@intel.com, linux-kernel@vger.kernel.org,
        linux@rasmusvillemoes.dk, linuxarm@huawei.com,
        peterz@infradead.org, prime.zeng@hisilicon.com, rafael@kernel.org,
        rdunlap@infradead.org, sbrivio@redhat.com,
        tangchengchang@huawei.com, tim.c.chen@linux.intel.com,
        valentin.schneider@arm.com, yangyicong@huawei.com,
        yury.norov@gmail.com
Subject: Re: [PATCH v9 0/5] use bin_attribute to break the size limitation of cpumap ABI
Date:   Thu, 12 Aug 2021 16:44:26 +1200
Message-Id: <20210812044426.29876-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210806110251.560-1-song.bao.hua@hisilicon.com>
References: <20210806110251.560-1-song.bao.hua@hisilicon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> V9:
>   - Split bitmask and list APIs and removed bool parameter with respect to
>     Greg's comment
>   - Removed duplication in code doc
>
...
>
> Background:
>
> the whole story began from this thread when Jonatah and me tried to add a
> new topology level-cluster which exists on kunpeng920 and X86 Jacobsville:
> https://lore.kernel.org/lkml/YFRGIedW1fUlnmi+@kroah.com/
> https://lore.kernel.org/lkml/YFR2kwakbcGiI37w@kroah.com/
>

Hi Greg,
Will you take this series so that I can rebase the cluster-scheduler series[1] on top of
this? that cluster series is where this ABI series really get started. I am looking forward
to sending a normal patchset for cluster series after this ABI series settles down.

[1] scheduler: expose the topology of clusters and add cluster scheduler
https://lore.kernel.org/lkml/20210420001844.9116-1-song.bao.hua@hisilicon.com/

>
> Barry Song (1):
>   lib: test_bitmap: add bitmap_print_bitmask/list_to_buf test cases
>
> Tian Tao (3):
>   cpumask: introduce cpumap_print_list/bitmask_to_buf to support large
>     bitmask and list
>   topology: use bin_attribute to break the size limitation of cpumap ABI
>   drivers/base/node.c: use bin_attribute to break the size limitation of
>     cpumap ABI
>
> Yury Norov (1):
>   bitmap: extend comment to bitmap_print_bitmask/list_to_buf
>
>  drivers/base/node.c     |  63 +++++++++++------
>  drivers/base/topology.c | 115 ++++++++++++++++--------------
>  include/linux/bitmap.h  |   6 ++
>  include/linux/cpumask.h |  38 ++++++++++
>  lib/bitmap.c            | 121 ++++++++++++++++++++++++++++++++
>  lib/test_bitmap.c       | 150 ++++++++++++++++++++++++++++++++++++++++
>  6 files changed, 418 insertions(+), 75 deletions(-)
>
> --
> 2.25.1

Thanks
Barry

