Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C8B23C7B7F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 04:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237422AbhGNCNh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 22:13:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237401AbhGNCNg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 22:13:36 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 180ACC0613DD
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 19:10:45 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id b5-20020a17090a9905b029016fc06f6c5bso590890pjp.5
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 19:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gXlJL7ra5SyqPc0iG65gvOPT5c5xzf36xPc1PPpU1xY=;
        b=F44tQNhiaOYkkT64bIFSQ15xn18NX3ZfkXEA567D5eUlr5qmw25qfBkbNJKOZ1RtAM
         yUBzdpKghrVkyIHV1OYVWpAfwo8fBhg2jURAXuaituq8YdIvRmlv/0t2Oliqn/igY16U
         JiERsoTKqcV1cZ1sDBwgOCsYJV8PM697hA6GVnMrRnUQX6w6h5qZCNfTbbkWiRDbd+FF
         Uln4V228uHEGOGc0mlBt1/QA3zpKeqQvgCDFdo2V+gd5K5Tcv0PkkruoFMZOMfSdBUgM
         nTFIgMZ6opatBceDhhzvrXYkaRa6rEZuPpQhY9/f2Faj2Q2zo4qnL1/EHZwxaXcUVHQC
         R2iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gXlJL7ra5SyqPc0iG65gvOPT5c5xzf36xPc1PPpU1xY=;
        b=fg5RHOKfGgv+hZaq7gUPOFVshh/OyOLuINWIaum6AoZ4fxwZOL5K1FWo97U0WjE6dq
         S4Qf/0SINuLZs+lAaPvj63xoMh4nU3EIWEtsVdI/soFNLlaOIP5iHj2kNw4604RZE4KI
         j99MnTin9jMPjhhxotWPElkXHb3CuAzD7b2CqqK7szyLw+vXm8MDbgY6LWUH91ZtS+iz
         oHtXTsTRXKfVbXITy/BIYVIHO/NG3PM2S2asOhcZoujQ410+mrOcJuyhz5WtKmfM/RdF
         RC7g7NdYGprs5OBNbpKTUPDO8Eh3voik2DW4eUzSDQb4AsZRoe6n2LjnmJFaZ5Mrsw8s
         87yQ==
X-Gm-Message-State: AOAM531iXUyaZ1W7uBoIk4z2KXGijMw3tBpbJSfYHqoNDA3gqU1Q9g5N
        sBBVdLQ7hYqyaGZJlKvt+FNdeQ==
X-Google-Smtp-Source: ABdhPJzJRksFxhnqpVSkwr6RMFocOpadjnvHZAefwMJ4xF9fIEpb5BbiiuDCxaKGDcyYOFGTwhuy9Q==
X-Received: by 2002:a17:90a:600d:: with SMTP id y13mr1304985pji.14.1626228644619;
        Tue, 13 Jul 2021 19:10:44 -0700 (PDT)
Received: from localhost ([106.201.108.2])
        by smtp.gmail.com with ESMTPSA id mz6sm414071pjb.38.2021.07.13.19.10.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 19:10:44 -0700 (PDT)
Date:   Wed, 14 Jul 2021 07:40:42 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Jie Deng <jie.deng@intel.com>, linux-i2c@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, wsa@kernel.org,
        wsa+renesas@sang-engineering.com, arnd@arndb.de,
        jasowang@redhat.com, andriy.shevchenko@linux.intel.com,
        yu1.wang@intel.com, shuo.a.liu@intel.com, conghui.chen@intel.com,
        stefanha@redhat.com, gregkh@linuxfoundation.org
Subject: Re: [PATCH v14] i2c: virtio: add a virtio i2c frontend driver
Message-ID: <20210714021042.56hnr73wzrie3jzj@vireshk-i7>
References: <984ebecaf697058eb73389ed14ead9dd6d38fb53.1625796246.git.jie.deng@intel.com>
 <20210713113607-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210713113607-mutt-send-email-mst@kernel.org>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13-07-21, 11:38, Michael S. Tsirkin wrote:
> I think we should tweak this such that we add multiple buffers but
> only make them visible to host after all add commands were successful.
> With split this is possible by deffering avail idx update,
> with packed by deferring update of the avail bit in the descriptor.
> I'll write a patch to add an API like that to virtio, then we
> can switch to that.

That will be great, exactly what we wanted but didn't ask for :)

-- 
viresh
