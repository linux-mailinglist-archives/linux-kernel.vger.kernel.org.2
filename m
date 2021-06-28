Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D8D53B5801
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 06:07:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231259AbhF1EJu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 00:09:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbhF1EJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 00:09:49 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF436C061766
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jun 2021 21:07:23 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id b5so638113plg.2
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jun 2021 21:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UPwJ4JFkf9xbmYHm20uOVNE4kSxCHxiSpBWFcMmJsf4=;
        b=Uok0jT2pxd+MJTrzQzNU+B1Vw/1BMSfeaNwyu3DXXL5ufR2/CLXdtn57aSt/Ij+NyS
         v1czpL+N/SxMFG/f9g9Y79C1BQL5ZX7wtuO8pqqdNgPgZbasIgwKw9DFwf9Vu/4wDPOq
         8J7Xk8e3fpcaL8HJYe9orfgkxD6X8HGcNyAV8iIkcx47v6GZZmxtLFMGZTV0baoi/WG7
         pmeuXXar7yh5VrUItS2vMKrkJPMwZ+Qe/VSUk2V99UlW2GgbuvEK8sGpBhil0klRZEu9
         8RagdFbFbrPm9DCbQ3lx1sySvMcq1+QCzjXQ1TeApB+Vq/xGZomy5aU2C/TI++3j7khi
         yaNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UPwJ4JFkf9xbmYHm20uOVNE4kSxCHxiSpBWFcMmJsf4=;
        b=KhH3UfXuzYxt2qTVuprIbWn2P/WVH9owpmXdlDA0TC4A2NIYX8SBqRZ+XprUkRGelL
         xgGnAqEAH1XMMCWIWvQzi5gC3C+Hqd0umqDjEI6uPPl/7929Mq0Bsuthj6Lf63QlvQHL
         HbsLv1V24I+GSYiiQcHm6mGvspLupSRTUPsqKaZxPgiDMKjnaM7xepVarR5OkUYaV0Jo
         uusYTslN1hTYNjwgCZEtzNoI5Ni9R7zAH0XbjVyiUIL41guJ8V8jvbAMkh4HOOK5HS5W
         d0CZRfAeb5dlggPRKEzNzt8j7vh829BCgddLzwCZwazawZu5j1H7fMoyxN7r8fZ/NE+R
         XRXQ==
X-Gm-Message-State: AOAM530Hf47GYLoLgvlnoRd8ct2RVyUTgTYCaVk4TWwqFBpvPe8+y1ay
        nOA5BdMM1nMC2K1LTR1fdG3BjA==
X-Google-Smtp-Source: ABdhPJzFWo89rXwqJzwPopMzsa0ZNowOikGCxgvea1IDTivUY8d9WCeemuR6SUA/phlV0AwqiLYnHQ==
X-Received: by 2002:a17:90a:69e2:: with SMTP id s89mr35387821pjj.154.1624853242453;
        Sun, 27 Jun 2021 21:07:22 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([103.207.71.35])
        by smtp.gmail.com with ESMTPSA id j3sm12654626pfe.98.2021.06.27.21.07.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Jun 2021 21:07:21 -0700 (PDT)
Date:   Mon, 28 Jun 2021 12:07:16 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Yang Jihong <yangjihong1@huawei.com>
Cc:     john.garry@huawei.com, will@kernel.org, mathieu.poirier@linaro.org,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, james.clark@arm.com,
        andre.przywara@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf arm-spe: Fix incorrect sample timestamp in perf
 script
Message-ID: <20210628040716.GC163942@leoy-ThinkPad-X240s>
References: <20210626032115.16742-1-yangjihong1@huawei.com>
 <20210628014953.GA163942@leoy-ThinkPad-X240s>
 <75dac5f8-9c82-0db1-d362-44289dcaa206@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <75dac5f8-9c82-0db1-d362-44289dcaa206@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 28, 2021 at 11:45:07AM +0800, Yang Jihong wrote:

[...]

> The timestamp does not match. Each timestamp has a difference of
> 213.98296702 seconds. Is the command I executed wrong?

I don't understand what's your meaning "a difference of 213.98296702
seconds".

But let me give an explaination with your below examples.  You could
the command "perf script" outputs the timestamp 314938.859071370 which
is the kernel's timestamp, if using the command "perf script -D", it
outputs the value 31515284203839 which is the Arch timer's raw counter
value.

In theory, the arch timer's counter is enabled at the very early
time before kernel's booting (e.g. bootloaders, UEFI, etc...).  So for
the kernel's timestamp, it should calibrate the timestamp and reduce
the offset prior to the kernel's booting.  I think this is the reason
why you observed 213.98296702 seconds difference (if compared with
your own patch?)

If still see any issue, please let me know.  Thanks a lot for the
testing!

Leo

> |symbol_address|perf script| perf script -D|
> |ffffb7ee2a20e100|314938.859071370|31515284203839|
> |ffffb7ee29f360e0|314938.859753820|31515284272084|
> |fffe85dd87e0|314938.859820430|31515284278745|
> |fffe85dd7a28|314938.859941110|31515284290813|
> |fffe85dd7a28|314938.859948890|31515284291591|
> |fffe85dc8f58|314938.859953610|31515284292063|
