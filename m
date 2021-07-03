Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E2BB3BA762
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jul 2021 07:25:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbhGCF1j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Jul 2021 01:27:39 -0400
Received: from mail-io1-f44.google.com ([209.85.166.44]:45834 "EHLO
        mail-io1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbhGCF1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Jul 2021 01:27:38 -0400
Received: by mail-io1-f44.google.com with SMTP id g3so12255456iok.12
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jul 2021 22:25:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=c8Bfor1R4wpqJRsIH5H7C4467Vk3S/8t2GJe8QN9CtA=;
        b=kVX5SWFvDrtfLrx4GtebQYFURyXaqhLIS4xjINPjkX0rbdoAfAxqkbOKKEyLsPVj9U
         tCUN4gJBnEFYpOcdkWKbFY8p1TEAPVXAkUjMwKV2Ev7PLXO0L9RscTVt9pPaswTaEzK3
         w1zuliZMOcLGHe4LGmJgS/gjZT/fnpekQy+jygx/2cnia3X3WR/JuMHBAAuRFDL+Rphs
         vfSoB8/HimghdZcwB7CHVAAbqd1aibpTvvjMDZhchFOZMHdU7NgtVbaA2kSy+BGm+hoi
         BJCQWSPhAGt+Bf/NzFqw5ubcxQ+RYEFD0Z+B0gywj/Y6SMQiG1xwJGD7Z18ODJHlEDu2
         5/TQ==
X-Gm-Message-State: AOAM532kiqoQYgfnbmVe8mOZy/1iY0MgyFzV/sj0W9MwFA1DlOLrjgLg
        mzeD8cGU1t9jl/M6+ej1g5Px3qtBrLg=
X-Google-Smtp-Source: ABdhPJzkE2mghXDvSfvuweq8J+Fj16WCb2OQWQoMswgNv+d+xZvwqnTjcwW6GHFZKlgnnBZOHMItLg==
X-Received: by 2002:a05:6638:9a:: with SMTP id v26mr2460687jao.124.1625289904256;
        Fri, 02 Jul 2021 22:25:04 -0700 (PDT)
Received: from google.com (243.199.238.35.bc.googleusercontent.com. [35.238.199.243])
        by smtp.gmail.com with ESMTPSA id r6sm2971487ioh.27.2021.07.02.22.25.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jul 2021 22:25:03 -0700 (PDT)
Date:   Sat, 3 Jul 2021 05:25:02 +0000
From:   Dennis Zhou <dennis@kernel.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] percpu: flush tlb after pcpu_depopulate_chunk()
Message-ID: <YN/0rmO0p6IJcImj@google.com>
References: <20210703051444.GA3786429@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210703051444.GA3786429@roeck-us.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 02, 2021 at 10:14:44PM -0700, Guenter Roeck wrote:
> On Sat, Jul 03, 2021 at 04:04:49AM +0000, Dennis Zhou wrote:
> > Prior to "percpu: implement partial chunk depopulation",
> > pcpu_depopulate_chunk() was called only on the destruction path. This
> > meant the virtual address range was on its way back to vmalloc which
> > will handle flushing the tlbs for us.
> > 
> > However, now that we call pcpu_depopulate_chunk() during the active
> > lifecycle of a chunk, we need to flush the tlb as well otherwise we can
> > end up accessing the wrong page through an invalid tlb mapping.
> > 
> > This was reported in [1].
> > 
> > [1] https://lore.kernel.org/lkml/20210702191140.GA3166599@roeck-us.net/
> > 
> > Fixes: f183324133ea ("percpu: implement partial chunk depopulation")
> > Reported-by: Guenter Roeck <linux@roeck-us.net>
> > Signed-off-by: Dennis Zhou <dennis@kernel.org>
> 
> Tested-by: Guenter Roeck <linux@roeck-us.net>
> 
> Thanks!
> Guenter
>

I updated the tag and have applied this to for-5.14-fixes so it can get
some for-next exposure before I send a fix to Linus.

Thanks for setting up the super easy repro! It made debugging this
significantly easier.

Thanks,
Dennis
