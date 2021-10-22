Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9C68437F69
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 22:40:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234247AbhJVUnC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 16:43:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232750AbhJVUnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 16:43:01 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F985C061764
        for <linux-kernel@vger.kernel.org>; Fri, 22 Oct 2021 13:40:43 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id e5-20020a17090a804500b001a116ad95caso3855746pjw.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Oct 2021 13:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xOrNPvhTsHY1csw7khL4syGVcl+AAY84KWi+Xzur7yc=;
        b=ptmI5JIjZ0uYamFMRKBz0dn8nOfywB+cxK7Z+YteoGodtJ6iZ4qZDGKedlGU9yzriS
         c2YJrnSz+f3O+wx+zJGr7W8EcsXSrzcwHFcYUma7LAZblXUIqQmqvafKDTjgTm/l3Kl9
         1uUWS8Djy+VxHvOGfySibYJrn+fXxGItox7jmxNfJqd+P0atHT14kKBG5j5AmiGAbIrw
         lnqW2BUOgMzsuSqcpMSsOXxR3kihjTWzjXKQxx3/mSZjcP+CXnvefr+RAl1+CjLm8lhg
         w7lxwhf9UzS/CpSysOijK3tuWe0zqjIHfIHge3rYFhsa98gsOiJO9yTutvK4d5YiY8wC
         NrDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xOrNPvhTsHY1csw7khL4syGVcl+AAY84KWi+Xzur7yc=;
        b=I8uC9gR7QeO10ppUB3Q1m6UEO3ZAOEOETJyX0SjaUGG1RHEAG2oZjtC8UpjUL+znLB
         nicg1Xdn408kOHtqgkfpb2Y+KSvurOZ1tIlgCrCZ5uSUyJLClEjnon+RuTsZ3HO+R08r
         EoUGw3U7v/jowAB+GDKTdZimxY1VX9UL8icJmHHkSCoGgko54eoLcFjzdSeuvzdsrb+l
         06NhJ5b5qfoXJHfGbPO8B/lYjDIfGYPEUdABu/gZuSTxzL/Oj3cmDtZnI2N9+XAkrTS9
         yR/lLrZPFlt2LPpEzseE+Pxm46+pcrJD+MUVVnD43oCsKHvo01qAweJ+RkFEMyNVSsE8
         karg==
X-Gm-Message-State: AOAM5313V8NHSeKsTUWDfrP/TW2I2dtYfN/pGyUMMLMVm1HIM+jTH5G0
        wkY5PQfrI12KvHrI8FLwiOQ=
X-Google-Smtp-Source: ABdhPJy2z0WlZlfXqw1NRmOmMtfBB8EwZ/EoWg2vrkGdYT6Xf0z8RNdygeiDWsLmhCvNyU/KwIOrxg==
X-Received: by 2002:a17:90b:3e8d:: with SMTP id rj13mr2446459pjb.183.1634935243004;
        Fri, 22 Oct 2021 13:40:43 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
        by smtp.gmail.com with ESMTPSA id lb5sm10752179pjb.11.2021.10.22.13.40.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Oct 2021 13:40:42 -0700 (PDT)
Date:   Sat, 23 Oct 2021 05:40:39 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org, aou@eecs.berkeley.edu,
        catalin.marinas@arm.com, deanbo422@gmail.com, green.hu@gmail.com,
        guoren@kernel.org, jonas@southpole.se, kernelfans@gmail.com,
        linux-arm-kernel@lists.infradead.org, linux@armlinux.org.uk,
        maz@kernel.org, nickhu@andestech.com, palmer@dabbelt.com,
        paulmck@kernel.org, paul.walmsley@sifive.com, peterz@infradead.org,
        stefan.kristiansson@saunalahti.fi, tglx@linutronix.de,
        torvalds@linux-foundation.org, tsbogend@alpha.franken.de,
        vgupta@kernel.org, will@kernel.org
Subject: Re: [PATCH 12/15] irq: openrisc: perform irqentry in entry code
Message-ID: <YXMhx++FtUo7UKlq@antec>
References: <20211021180236.37428-1-mark.rutland@arm.com>
 <20211021180236.37428-13-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211021180236.37428-13-mark.rutland@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 21, 2021 at 07:02:33PM +0100, Mark Rutland wrote:
> In preparation for removing HANDLE_DOMAIN_IRQ_IRQENTRY, have
> arch/openrisc perform all the irqentry accounting in its entry code. As
> arch/openrisc uses GENERIC_IRQ_MULTI_HANDLER, we can use
> generic_handle_arch_irq() to do so.
> 
> There should be no functional change as a result of this patch.

Reviewed-by: Stafford Horne <shorne@gmail.com>

