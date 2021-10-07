Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71B3D4255F3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 17:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242257AbhJGPDp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 11:03:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233392AbhJGPDn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 11:03:43 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C543C061570
        for <linux-kernel@vger.kernel.org>; Thu,  7 Oct 2021 08:01:50 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id u7so5548370pfg.13
        for <linux-kernel@vger.kernel.org>; Thu, 07 Oct 2021 08:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mgxV9vofFa2JKR3OMuIjOLiE52M694+VDJIIWjcXhQw=;
        b=m9dNvUSiolriakGCOk/N0DwqY/YGaaVeEAc6xc9IMKoL5dH9MYaH6gA5VP/XZFd1Bq
         pmDl43BYu7lzLPzdFuYfbm+BQjC5GSshwjxS0Ui60WrFmL5fmCeSCSfH7VLYA0DiaN/E
         hGubIh8y6P3UUYZbH8ndY0tBxizgOUeaBDpfY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mgxV9vofFa2JKR3OMuIjOLiE52M694+VDJIIWjcXhQw=;
        b=3JrVbaAoacn00lFrmwQu65gxyr/t814VbF6bfxI3DjUSHTOdWXqi17ZvqrTyf29AHY
         ny31dhx7M9Ln8iVym6fkUaETxQrMjwH0SPBza6W9cSBTMb/OqVAAtoqBT3KmAzBlW4Ec
         b9ZFIU8ZzX6/WGrY/NIyaQ0qBzBtolVC0kF8OgVdfgBxAfYj0gDpcVQhC/fw1q+O4fTl
         A0+thBjBvzQoggd6SZKXM0LBzMwTmBTtfPxdGzsnJxMC2iZ5ufhVImBjT4YujeW3xho5
         lHqPcvu/zwLzkThvSq9VzqGlSBQvpwl00CgZQy+RzWviYmEHz/YiZq3djdPZQv1LAohZ
         ssAg==
X-Gm-Message-State: AOAM530Q5697smXEVc/grJ9jUxj+XfbFsGHEVtd4x4ujnonENEj5xCPO
        22sWXucwCZaOKJgfR+IP1tniig==
X-Google-Smtp-Source: ABdhPJxLnVlOseU08rqspnpqFtYL3QSFvbUaoRITM2OBRrImlAWs2nc6K0pqVOr+n7tYjKEAnNg6CA==
X-Received: by 2002:a63:ff0a:: with SMTP id k10mr82399pgi.363.1633618909475;
        Thu, 07 Oct 2021 08:01:49 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id m1sm25225382pfc.183.2021.10.07.08.01.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 08:01:49 -0700 (PDT)
Date:   Thu, 7 Oct 2021 08:01:48 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     pmladek@suse.com, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org, peterz@infradead.org,
        valentin.schneider@arm.com, mathieu.desnoyers@efficios.com,
        qiang.zhang@windriver.com, robdclark@chromium.org,
        christian@brauner.io, dietmar.eggemann@arm.com, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] kernel/kthread: show a warning if kthread's comm
 is truncated
Message-ID: <202110070801.C425A092@keescook>
References: <20211007120752.5195-1-laoar.shao@gmail.com>
 <20211007120752.5195-5-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211007120752.5195-5-laoar.shao@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 07, 2021 at 12:07:52PM +0000, Yafang Shao wrote:
> Show a warning if task comm is truncated. Below is the result
> of my test case:
> 
> truncated kthread comm:I-am-a-kthread-with-lon, pid:14 by 6 characters
> 
> Suggtested-by: Petr Mladek <pmladek@suse.com>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>

I like that we get a warning now. :)

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
