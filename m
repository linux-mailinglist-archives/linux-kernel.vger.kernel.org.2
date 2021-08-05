Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25B783E1181
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 11:40:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239386AbhHEJkt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 05:40:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238685AbhHEJkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 05:40:47 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD3DDC0613C1
        for <linux-kernel@vger.kernel.org>; Thu,  5 Aug 2021 02:40:32 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id t7-20020a17090a5d87b029017807007f23so10155075pji.5
        for <linux-kernel@vger.kernel.org>; Thu, 05 Aug 2021 02:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nDgSiKT3PmC/uVgbSGJ5t/4JCmbXe35pN3HpY7zZV9E=;
        b=C6wyBK36441JkySRlvZ/2pfKdBz31BE8gQlFQzt5bcvETqDRArNU8tGTG9jk5HrXm8
         c+VvdloQWAyGTz2BO0E9PWSmHPiFYRdhwGc+BINqy6yNpcrZ3VMorgtPknMB8368Q6WM
         snrSDbzmuiLJgbUt/DcpuxCppoZAnA7Yl4VVW3v7NYIeSpR7DT1ZGAmdvklUADOVK4p0
         D/VDnfrUAidl0RQOXIlojaUCwmIOfTTF22wN8u9J3/NYWcwXvsEMX8ghCKZu/Cyi9i41
         J6R2QjAG00zXHIlPnv962j2wh2i9Sr2rJfS9GrXYaJEfblDCtvBJ5AA5uh51aRsaLVzY
         Ffjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nDgSiKT3PmC/uVgbSGJ5t/4JCmbXe35pN3HpY7zZV9E=;
        b=aY3l7rrZi/wTQ7RzVtwnK+RAra4ARPNzOSuVj3uz97zAakYneaYHb8nzj57cx4TXUx
         LYUW80m6tR7kAYYGtlv5aflSoMl0YDU07WVxJwMcEdqWSW+PcPf0xj88brF6wzY4ew8L
         QvMD+lwDyfjmqg3ePHFEebMncdW0fBDtmZKyQO4pgC7f/2Rm3c1/vaGHQcA80pVZa0+f
         PWo+J0SvINnG0YN43d+WqCVgIrY+fvvHjeuMnrmcWcxE9tJoJMFYCb1jQLWDK1Zcaj8C
         EKHmz9UacAzMp708dx4hDrCgOGndfO4uMZwb5WiNUBaQGVfYkT/IidDP/vP0nlwtshRn
         y+8A==
X-Gm-Message-State: AOAM531/JdZnfyZVLpNu/CpByX3Y9D4wKV04bBRQUvvAobQhi0pmRCoC
        aG/2VSxubgeWJjnft4j1kL8YiQ==
X-Google-Smtp-Source: ABdhPJyPyEcVsCvddqnfpJm3MeotME9LAyQ5SA1NJxPIjyQ+VBI4nEmORfuHRBrQHWkSGcv02u0ZuA==
X-Received: by 2002:a05:6a00:16d6:b029:32a:ffe9:76a with SMTP id l22-20020a056a0016d6b029032affe9076amr4429638pfc.60.1628156432150;
        Thu, 05 Aug 2021 02:40:32 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([202.155.204.36])
        by smtp.gmail.com with ESMTPSA id x189sm6908188pfx.99.2021.08.05.02.40.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Aug 2021 02:40:31 -0700 (PDT)
Date:   Thu, 5 Aug 2021 17:40:24 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     James Clark <james.clark@arm.com>
Cc:     Mike Leach <mike.leach@linaro.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Coresight ML <coresight@lists.linaro.org>,
        Al Grant <al.grant@arm.com>,
        "Suzuki K. Poulose" <suzuki.poulose@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 3/6] perf cs-etm: Save TRCDEVARCH register
Message-ID: <20210805094024.GA19058@leoy-ThinkPad-X240s>
References: <20210721090706.21523-1-james.clark@arm.com>
 <20210721090706.21523-4-james.clark@arm.com>
 <CAJ9a7Vjz_CMugYrLcAqr_aFsK6jYcqR3xLwJUi9KTXB3aPjnEQ@mail.gmail.com>
 <20210731063731.GC7437@leoy-ThinkPad-X240s>
 <9156d7a1-3676-ab98-2c38-26f9765b845c@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9156d7a1-3676-ab98-2c38-26f9765b845c@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 03, 2021 at 01:34:36PM +0100, James Clark wrote:
> 
> On 31/07/2021 07:37, Leo Yan wrote:
> >>> diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
> >>> index 85168d87b2d7..65a863bdf5cc 100644
> >>> --- a/tools/perf/arch/arm/util/cs-etm.c
> >>> +++ b/tools/perf/arch/arm/util/cs-etm.c
> >>> @@ -53,6 +53,7 @@ static const char *metadata_etmv4_ro[CS_ETMV4_PRIV_MAX] = {
> >>>         [CS_ETMV4_TRCIDR2]              = "trcidr/trcidr2",
> >>>         [CS_ETMV4_TRCIDR8]              = "trcidr/trcidr8",
> >>>         [CS_ETMV4_TRCAUTHSTATUS]        = "mgmt/trcauthstatus",
> >>> +       [CS_ETE_TRCDEVARCH]             = "mgmt/trcdevarch"
> > ETMv4 supports TRCDEVARCH, so I think it's good to use the naming
> > "CS_ETMV4_TRCDEVARCH"?
> > 
> 
> Based on the other discussions do you still think I should do this?

No, don't need to add TRCDEVARCH for ETMv4 anymore.

> As part of the new magic number I moved it into a new enum so it
> might be clearer now?

Regard ETMv4 and ETE use the different decoder types from OpenCSD, you
could add a new magic number and new enum for ETE.  It would be easier
for later extension for ETMv4 and ETE separately if decoder requires
to pass more config info.

Thanks,
Leo
