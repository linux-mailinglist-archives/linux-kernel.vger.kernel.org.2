Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D1643CFBB4
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 16:13:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238776AbhGTNbt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 09:31:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239389AbhGTNOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 09:14:16 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F317C061574
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 06:54:53 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id c23so2276444ljr.8
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 06:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=d+X4Q07MgeHYW8eCJj5YoBj1nYkhGjnbiHZEqthoXuw=;
        b=hWgOOiHC1DPm4CD0bWFnEDG/qcM3MfkuXkskeBSyryxl8VruwN/+6X0WPj5NhE3DuV
         XbCJwizjc0O3gDMkTGthoz/YtPk9SWFZMHsY97J+4gaPHVgpDbJAJ8rzyMJldJqFaQRf
         VAxa+xkIUUPv+R90Qm1VgRZ13yJ7kNUKIeJk+9LLrsr8+lVpNQhtM0Zl1gse7/Nn6cNV
         BfonwVRwHUkQuBOJm3V4lVk70H8GxWd1yMlMJrMiLbIzWOCvoMS8VcLzcMGFLCCzCXob
         iInrfGf8dcvT8FoqXDOELMm6vCvwimUlJDJnOotePedFPFFkcUcG+7gbW0u6ZWcEcG4H
         nORw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=d+X4Q07MgeHYW8eCJj5YoBj1nYkhGjnbiHZEqthoXuw=;
        b=C2/4OQhZ+qD2Y6AVqxgy75DMsptoLWMQrmPfu29MDL3i5TKiBdOMkKO9ZZDKfG5FzD
         1f8TfIeFB4bfn0RCSlty8CnvdDzGVKJkWVnmlYRCKJ1dpf5CjF97efWUI8dWRWeAxZQD
         fido9Zio+BRMm83Tj3BHq/idiv9sYls55FHsTHZ655IubHHYBCbHSNIlp1pPGUyzIDaL
         IwKGr6QR9igzuACeHMwqYXRjjVOhCmvkO4SBq4abwpHuBkFWqQeJObL5RXURd4P0zaSK
         I30IlitlpWF6akZSgkC5xhh1b6HE+9S8PKhoWqPxZzmywQOu/8EkcePGzieoytJJA41D
         CEow==
X-Gm-Message-State: AOAM533b7LaataNe5aq3DSN7D7qm2xTS9tjCL3++ojLDM9MYKyEj1HI1
        nArENaqDmwPhafrlYuR6/O8=
X-Google-Smtp-Source: ABdhPJy4TnTO/KADjfeq45oGIZeLjmaF0iuw3S0A95gL94Hln0f36b7vpfQZwJDHneZb27GGGFn55A==
X-Received: by 2002:a2e:9c54:: with SMTP id t20mr12193411ljj.87.1626789291527;
        Tue, 20 Jul 2021 06:54:51 -0700 (PDT)
Received: from grain.localdomain ([5.18.255.97])
        by smtp.gmail.com with ESMTPSA id x10sm1427384ljn.27.2021.07.20.06.54.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 06:54:50 -0700 (PDT)
Received: by grain.localdomain (Postfix, from userid 1000)
        id 14FC65A001E; Tue, 20 Jul 2021 16:54:49 +0300 (MSK)
Date:   Tue, 20 Jul 2021 16:54:49 +0300
From:   Cyrill Gorcunov <gorcunov@gmail.com>
To:     Andrei Vagin <avagin@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Keno Fischer <keno@juliacomputing.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH] prctl: allow to setup brk for et_dyn executables
Message-ID: <YPbVqfRqXtj5olFO@grain>
References: <20210121221207.GB2174@grain>
 <CANaxB-zuh-TvODuQ9pdycqGUyXfO4rXXtyFmXFh905+es6AOXQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANaxB-zuh-TvODuQ9pdycqGUyXfO4rXXtyFmXFh905+es6AOXQ@mail.gmail.com>
User-Agent: Mutt/2.0.7 (2021-05-04)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 20, 2021 at 12:33:11AM -0700, Andrei Vagin wrote:
> >
> > Reported-by: Keno Fischer <keno@juliacomputing.com>
> > Signed-off-by: Cyrill Gorcunov <gorcunov@gmail.com>
> > CC: Andrew Morton <akpm@linux-foundation.org>
> > CC: Dmitry Safonov <0x7f454c46@gmail.com>
> > CC: Andrey Vagin <avagin@gmail.com>
> 
> Acked-by: Andrey Vagin <avagin@gmail.com>
> Fixes: bbdc6076d2e5 ("binfmt_elf: move brk out of mmap when doing
> direct loader exec")

Thanks for review, Andrew! I reviseted this patch recently again and
indeed we still need it.
