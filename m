Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B63A3B59BD
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 09:29:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232364AbhF1Hbn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 03:31:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232246AbhF1Hbj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 03:31:39 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A64EC061574
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 00:29:13 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id a2so14694740pgi.6
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 00:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wB3pl4eCR9A++KTJRTkdffyKKOfE2xIxwn/POU4enCY=;
        b=iI8bdKhvZIzGk2VtpTl/bDn+tP/WcmhCHenP0+2ElP2BImp8g6U8UFn8SML86vFH+Z
         +E5/uvEzv0okOM7pkjsPJ1lKGkHWFvqgWTho2RBTbFaapHf1GfkmXnLT0WB0OR41IiK2
         xhGdFGx1oeb42WavV6e0ZBrmaYmXtvTPNZy2sPB+A8GxjTyoJrHk4m35vVsStJ8D3ViQ
         epqQLEJcOZogwk15UEqBvAKcsr2oJbBt4MCh3JAGedDLsBk0SA9RxWJNpdEQbsXRDeOp
         fjq9sijZgMJZCriUqFYX7O66JHyJM+KUYAeq/0+bKmMEZsbr0PP2qVNF94fQatcio9hW
         41Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wB3pl4eCR9A++KTJRTkdffyKKOfE2xIxwn/POU4enCY=;
        b=qqBIg8GcLc/Nre7kUblzxrh0/+2xZn45L5PMSIV0kHk0wZ6RBa/gueyQMUpQH5cuOJ
         7Zco+K6XbMU7PYGwd7GbpKtyIFwxfi8k+V3o6KzJ+v8N2dRc6usCRIUuUXOu9d1gSFIm
         nt0eERMI/MfXRfbeOQ/BTw5NqQbVS5V5BZrsj0mBfWhLfQCG5UvGY2EXx79jnL6ZYOUk
         DWxDKbyvKPqC5DkQ2ilHsiSFPS8sK7kC7fMkRgYHinCwldIerLOJ7dh103YqHfE8//ve
         zfL3+PKuBsl/QQ61BFB388vZmvqtvENESf0eH1vAiH6brVzMUTuRp2LJWfY62q2HLcbX
         On2A==
X-Gm-Message-State: AOAM530xKuMBosVfNt1Y2KgMleuUYF1FfmNb1LXxH/I8j0jTy0axVOxd
        97ZxUKx+4JklPFKRMLtFkO8osw==
X-Google-Smtp-Source: ABdhPJxStIGl45SpHmvs+WzNvuv9XnE+Eojse23ogntaEl5G9CRgIlE0sBkQrQlUV9ZDG1tQmCYnYA==
X-Received: by 2002:a62:1c05:0:b029:305:5230:79f7 with SMTP id c5-20020a621c050000b0290305523079f7mr23412103pfc.80.1624865352892;
        Mon, 28 Jun 2021 00:29:12 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([202.155.204.36])
        by smtp.gmail.com with ESMTPSA id q18sm13444994pfj.178.2021.06.28.00.29.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 00:29:12 -0700 (PDT)
Date:   Mon, 28 Jun 2021 15:29:05 +0800
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
Message-ID: <20210628072905.GB200044@leoy-ThinkPad-X240s>
References: <20210626032115.16742-1-yangjihong1@huawei.com>
 <20210628014953.GA163942@leoy-ThinkPad-X240s>
 <75dac5f8-9c82-0db1-d362-44289dcaa206@huawei.com>
 <20210628040716.GC163942@leoy-ThinkPad-X240s>
 <2af84c69-8528-9c4a-f666-2dd660bcd966@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2af84c69-8528-9c4a-f666-2dd660bcd966@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 28, 2021 at 02:30:56PM +0800, Yang Jihong wrote:
> Hello Leo,
> 
> On 2021/6/28 12:07, Leo Yan wrote:
> > On Mon, Jun 28, 2021 at 11:45:07AM +0800, Yang Jihong wrote:
> > 
> > [...]
> > 
> > > The timestamp does not match. Each timestamp has a difference of
> > > 213.98296702 seconds. Is the command I executed wrong?
> > 
> > I don't understand what's your meaning "a difference of 213.98296702
> > seconds".
> > 
> > But let me give an explaination with your below examples.  You could
> > the command "perf script" outputs the timestamp 314938.859071370 which
> > is the kernel's timestamp, if using the command "perf script -D", it
> > outputs the value 31515284203839 which is the Arch timer's raw counter
> > value.
> > 
> > In theory, the arch timer's counter is enabled at the very early
> > time before kernel's booting (e.g. bootloaders, UEFI, etc...).  So for
> > the kernel's timestamp, it should calibrate the timestamp and reduce
> > the offset prior to the kernel's booting.  I think this is the reason
> > why you observed 213.98296702 seconds difference (if compared with
> > your own patch?)
> > 
> > If still see any issue, please let me know.  Thanks a lot for the
> > testing!
> > 
> Thanks for the very detailed explanation.
> To keep the correct relative time sequence between events in SPE and other
> events, we should use kernel timestamp instead of arch time. Therefore, we
> need to calibrate the time. Is this correct?

Yes, correct!
