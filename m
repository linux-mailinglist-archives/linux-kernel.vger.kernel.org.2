Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24E2540D50A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 10:50:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235510AbhIPIvJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 04:51:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235495AbhIPIvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 04:51:01 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7783CC0613C1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 01:49:39 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id c19-20020a9d6153000000b0051829acbfc7so7406000otk.9
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 01:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vIP749jeRM51PP+EheT1+GJQiFSryXau4Nw9wt2MR9o=;
        b=ib0a2fLDYWnjqZoTZ2hv2mqWpo0hxUiuak1z8zTBm5r0xV/7KaW/JbUV25PKvnGvTy
         bFs639CZnjaV49OWYkXGOaipp0xWiE3EQFig/rlZBYZVLal2Dz23Y7n+hcBfSbvJyGq6
         0x/9XTrelZbk/G7wpUU/6D37k2Qg9f2IxTOirWCacrGFIj29wrJz6nvF2J52/AZVpVOl
         VcA8YnGAzh0qDhwLtiL93l5UlzwE6Fh1955ClLCsOouv38pRaQebmWv/fzIu4CZhbSn4
         jyf5Jex3LTofcZwSiNA3D0omXfwDoSopXsQ2EyH2Sw0HDn4INDyfoivTV8hGI15Hb06h
         hCeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vIP749jeRM51PP+EheT1+GJQiFSryXau4Nw9wt2MR9o=;
        b=4GgZhX9RbETXPmQ8ftvrfJKE7uRAJbZm0ONGCVQIJyr1MlsrzBCFia5+RFH70HqIvt
         LU6Gd4IWC18DNt2JNdsHoTJjLSVlv0UESzpMC6Br8F/gO8JNdTuuoMIHk1rDP0TJNZeu
         pDIVqTAGXW2UCBOnkerZbdjDkGTTmRvU3NwspEnU48AIc1ED59k9m21fQXSn8bgx5NFA
         Y5L7llpnmkPDmDI9lE8iTx8EHlP4uvGC2HgF8I7X094AGE1ryFTZuxXrdkC++bdxq3hN
         7CbEv4ys1wEvSDPP1yyMbMCDxTC2ShqY2JpX+YOycTxHQTcgJ+s5SeQveTzH5PaqEjj2
         5ukg==
X-Gm-Message-State: AOAM5324SDAIzUmss2Qiwm4aHzm4WisytjE+ZbpgLRPNE1sjOgjoXM8P
        3Oj7+RpRYIKxBr5AwYTcHwY+YYVeTJwhDtYh9DB50Q==
X-Google-Smtp-Source: ABdhPJz3110GOQH0TXL0WZg5/2ZsApOW/cZ8gCqx6RYVU3IQy90hLLmlWEzVPbFdklWHNIUmQvOmVKas6KBPlKGgdGQ=
X-Received: by 2002:a9d:71db:: with SMTP id z27mr3758946otj.292.1631782178670;
 Thu, 16 Sep 2021 01:49:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210421105132.3965998-1-elver@google.com> <20210421105132.3965998-3-elver@google.com>
 <6c0d5f40-5067-3a59-65fa-6977b6f70219@huawei.com> <abd74d5a-1236-4f0e-c123-a41e56e22391@huawei.com>
In-Reply-To: <abd74d5a-1236-4f0e-c123-a41e56e22391@huawei.com>
From:   Marco Elver <elver@google.com>
Date:   Thu, 16 Sep 2021 10:49:27 +0200
Message-ID: <CANpmjNNXiuQbjMBP=5+uZRNAiduV7v067pPmAgsYzSPpR8Y2yg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] kfence: maximize allocation wait timeout duration
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     akpm@linux-foundation.org, glider@google.com, dvyukov@google.com,
        jannh@google.com, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kasan-dev@googlegroups.com, hdanton@sina.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Sept 2021 at 03:20, Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
> Hi Marco,
>
> We found kfence_test will fails  on ARM64 with this patch with/without
> CONFIG_DETECT_HUNG_TASK,
>
> Any thought ?

Please share log and instructions to reproduce if possible. Also, if
possible, please share bisection log that led you to this patch.

I currently do not see how this patch would cause that, it only
increases the timeout duration.

I know that under QEMU TCG mode, there are occasionally timeouts in
the test simply due to QEMU being extremely slow or other weirdness.
