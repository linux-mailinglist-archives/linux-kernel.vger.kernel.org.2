Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7846444D731
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 14:27:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233448AbhKKNaQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 08:30:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233396AbhKKN3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 08:29:46 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2922BC0613F5
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 05:26:57 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id j6-20020a17090a588600b001a78a5ce46aso4583816pji.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 05:26:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+5ZZCvB7cw3hxgR2a0Zb0YuaBAaUVc++Fgiq7CcVKlI=;
        b=Gc2X4tKrbUgmH8pZ6b2ngv7PYyDIUUmGkDXHWRyLKAP9hlLqOtfzQttT0prEy79j8x
         7QLu6UMoc79OxVTgbKvFzW6+z/2I+k7M+TsObUUc3/H7jAXhPnZRUKFF98vPc28LhKB4
         fcDsze/LsOPhYY3oDztOzwtk9R6IU1rEUELwYcrC3sGzjp8nAYWHQ9FMD73x/heFh2/u
         YbiXH9G++3/y/mjzD/bPRo7CZek6T48pUMzEr06NuNzy21IODIa/+VXSjRDS8MzYyUzi
         0noUg50ItLHTLmDv8pdVCA7W4I6WN/+pFq/RKv95TT/x70ux+jCa8RYtbRC03JpPCfHj
         BuEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+5ZZCvB7cw3hxgR2a0Zb0YuaBAaUVc++Fgiq7CcVKlI=;
        b=qocFAIfvI6juwQ084bOkR4mNXWt/2T2INubHBFAn1MdoFt6/gXgOdwJEGAvBfh2Pur
         rdQOSv5vdQvdcctw5zJ2xtmdR/t56qent18GiYz2Gwawi1d5nVU4L5szTZX68F/b5KTD
         K/cYBVzScGTuknvkrrQ3iRU/pP/8pfw2aoZSdXQ/pThueL1TKuSsh6gKg+dI1ZkGlbio
         JFEHSK/l5XN399SNbVeS+c37VqRRNnuzzkQrvbaM762g8bOv1HnJ2erLWxTRQ7/e6uhC
         oFX82U0c+CNH8d4lYXRD+V/a/BIPVU7dvwEzliC+BfqSSfJsFsdDz0RGEQ2SBBfPiHQi
         c3FA==
X-Gm-Message-State: AOAM530klYislevX2QXY+7qOyfiTTSzvExB4RYSxxPg/k9o5BpT81Mkk
        HBiZlMPS4ioHvZG31KeEUCiRJA==
X-Google-Smtp-Source: ABdhPJx+iquOm/A/o8dJzkfx0jH3xgN1cdgV9HpuS1Ct1QFtC/wkEFVlMk5Xnct2Gpt4cu/NvdozTQ==
X-Received: by 2002:a17:902:c245:b0:141:f279:1c72 with SMTP id 5-20020a170902c24500b00141f2791c72mr7636312plg.18.1636637216665;
        Thu, 11 Nov 2021 05:26:56 -0800 (PST)
Received: from leoy-ThinkPad-X240s ([148.163.172.147])
        by smtp.gmail.com with ESMTPSA id q6sm3309107pfk.144.2021.11.11.05.26.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Nov 2021 05:26:55 -0800 (PST)
Date:   Thu, 11 Nov 2021 21:26:47 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     German Gomez <german.gomez@arm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 0/4] perf arm-spe: Track pid/tid for Arm SPE samples
Message-ID: <20211111132647.GC106654@leoy-ThinkPad-X240s>
References: <20211109115020.31623-1-german.gomez@arm.com>
 <20211111072714.GB102075@leoy-ThinkPad-X240s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211111072714.GB102075@leoy-ThinkPad-X240s>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 11, 2021 at 03:27:14PM +0800, Leo Yan wrote:
> Hi Arnaldo,
> 
> On Tue, Nov 09, 2021 at 11:50:16AM +0000, German Gomez wrote:
> > The following patchset is an iteration on RFC [1] where pid/tid info is
> > assigned to the Arm SPE synthesized samples. Two methods of tracking
> > pids are considered: hardware-based (using Arm SPE CONTEXT packets), and
> > context-switch events (from perf) as fallback.
> > 
> >   - Patch #1 enables pid tracking using RECORD_SWITCH* events from perf.
> >   - Patch #2 updates perf-record documentation and arm-spe recording so
> >     that they are consistent.
> >   - Patch #3 saves the value of SPE CONTEXT packet to the arm_spe_record
> >     struct.
> >   - Patch #4 enables hardware-based pid tracking using SPE CONTEXT
> >     packets.
> 
> I have tested this patch set, it works well on Hisilicon D06 board,
> please consider to pick up.  Thanks!

Hi Arnaldo,

Please hold on this version and German will respin a new patch set for
a found issue.

Thanks,
Leo
