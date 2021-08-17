Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FF5B3EF113
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 19:48:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232473AbhHQRst (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 13:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230311AbhHQRss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 13:48:48 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 410A0C061764
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 10:48:15 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id oa17so323249pjb.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 10:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=b6UJk0VJ9F8wnxSML9OKAHavbOamej6c6PRWW6Zy/+Q=;
        b=P0BrqCGvAd7ru4eICEY0r6+mBiUsTfsPAl8N+vNx1YAcZXn47h71HAW6DE/S2ll+4N
         7/RXtn0gOvg9E0J8y8o5v7+O53DvXKfAeKu/5jR+LrtYuxgBcK8WmHO9faOAt2rXWNQR
         HrPMWAp4ZkDDky+OmW7Z1le1TZ3CgLC/kfQhV+3Feluqnj/8SJNyN7CfPccUpzhV5lnu
         GIwE4MfJ0Elu+zAZJR8UgBSSxe6uJ+xrvkiA3/ZRNNpiqLxsuIxUqhShN8ee7O79YX16
         pwd1nv7W92wMCDXxmTx4MSr+TM5bnM3aSf5jYSUKXm02hGjvTFTCsJ73sSvPnRcrhy+5
         ZXKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=b6UJk0VJ9F8wnxSML9OKAHavbOamej6c6PRWW6Zy/+Q=;
        b=qBJMJ0Vipkuq71Q6Y/B08TRFBJVckBvy/CO/btuBTSFyFEC64dM0r8KkcZzRbHNX9R
         sHvdZ67mTP8GZJz1a+4VZcytWlzzBPncxV2iLa7MekNsUDKKNsLcR/g4wHY0PcoNnYcI
         mzh7+erC54E+zEJ2B3qnEmBceu//sApOldxll4bFMG3VXOGrKnwJkiV/0KNBta1Cuz4I
         mnH4vrmAX2UY4JMSb7PWDM7ZGlZ2OIdKHgz7o0M7NU4xp7zn5Z7dDFeU+OKXXeLy9+/D
         SPIPYro1kL9E5sRhOFbfvmV1PIy6lZYlHt5ZTKd+ToBWrAW9rvYfZFH5NxzxNsbAAUOe
         D+jw==
X-Gm-Message-State: AOAM533SS62IFamOCoLPHlIVZLc99YFuBNhOECL2zmPHrsbqgtwJQd0n
        jQL6uXvk5bNxJjdwJNyao/E=
X-Google-Smtp-Source: ABdhPJyuoHiMtKtAGhrLueBc7OcTy8b51ZguMcikebRDsW9LOeD8q0AkgsUoa5qxoTf7adCfcFncZA==
X-Received: by 2002:a05:6a00:b95:b0:3e0:f3f4:6214 with SMTP id g21-20020a056a000b9500b003e0f3f46214mr4842715pfj.5.1629222494697;
        Tue, 17 Aug 2021 10:48:14 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id d2sm3875008pgv.87.2021.08.17.10.48.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 10:48:14 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 17 Aug 2021 07:48:12 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     linux-kernel@vger.kernel.org, lizefan.x@bytedance.com,
        lizhe.67@bytedance.com, Lai Jiangshan <laijs@linux.alibaba.com>
Subject: Re: [PATCH 0/6] workqueue: Make flush_workqueue() also watch
 flush_work()
Message-ID: <YRv2XP5F+lv41FE3@slm.duckdns.org>
References: <CAJhGHyBsn+rqVQzNqRw2RxtpHyrpQpa0kMtU1RcZP7TCbC6dqg@mail.gmail.com>
 <20210817013239.3921-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210817013239.3921-1-jiangshanlai@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 17, 2021 at 09:32:33AM +0800, Lai Jiangshan wrote:
> Due to historical convenience, we used WORK_NO_COLOR for barrier work items
> queued by flush_work().  The color has two purposes:
> 	Not participate in flushing
> 	Not participate in nr_active
> 
> Only the second purpose is obligatory.  So the plan is to mark barrier
> work items inactive without using WORK_NO_COLOR in patch4 so that we can
> assign a flushing color to them in patch5.

This is great work. Applied to wq/for-5.15.

Thanks.

-- 
tejun
