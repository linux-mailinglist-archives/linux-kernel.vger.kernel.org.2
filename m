Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F75A433E96
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 20:38:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234483AbhJSSlA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 14:41:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233102AbhJSSk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 14:40:59 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0A17C061746
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 11:38:46 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id m26so738057pff.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 11:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YS/ZZwdTMJ17Yr56yzlxDDUyUyTkXy20QdhmyCZ2gw8=;
        b=ZM0cA1hqFyEK8iHYryf2JkH5sTILR3bCqlm6ODs0zt59x4czD/CQmmqVLhY5XeMzP8
         ID0BhlJJnPR76+OCIH97WBinUZUgx7K3O6U9UPrcna91WawroDtzJJrZ1SIeFGkI32sC
         EEaBVn0z+CP3tgwujf8C6T6/FgLtIG39uwpZ2mL7yezsda1WY/A89cZ5eXP0dOhRDn0t
         tumFOfaVbMKRPXQuzWolVc3mQoB2VjpCVlHm/wqwdJJn0S47QrlBwzxjdTzmQPAnZpfi
         FDbdgar28v23wD1AQJ2ORsTa2Vwpd/gekyPlaVfJknl3YyKaW+IBGB2l0w1IV/xchoF8
         Bo+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=YS/ZZwdTMJ17Yr56yzlxDDUyUyTkXy20QdhmyCZ2gw8=;
        b=6Zx0eQsEkRy4iO460unR/QY/xKvV4sEKpAvTz+hnUh75bC/XrldNJPjh2ZfYdXHwWI
         uuxHDQopdsUeoQ6OdRIPRY4cnKALCAMWMQpKqNoNfswcf23AvJNAlOhiBhrKZ5Y6UNQ0
         3YtLJ6akz+hkftfd0kfBmW71cxSIP5q1UqqMFGq+D7O8fs2o+V6ZZRzyfH18e1Q+LhL6
         1CdPqN6+KYWpUAFZN4OR0IMrsx9qLMN8RO0qaxISkHCN0/ea0hNotW2haGT5VbNYKJ7e
         9VKY6B4nj+pwaZ/IavKCSSEXG+21/AdpT84E9kgcZei+uFofx4OU268aEgaEo+eKoDih
         tZmw==
X-Gm-Message-State: AOAM531VfUaNi1VcAlgD5qbBpwV+WGtOQax4UGPjTj7hHHc9befmK+TH
        tL4fASlrZZwvJUWgw16+oz0=
X-Google-Smtp-Source: ABdhPJzjt5IgYNfH7XYl0Ui57e0FmZTzyZ7bHRYKd4WoYrj18f0Xbr5KAKva+bDHTX9nnMiK4WEKcQ==
X-Received: by 2002:a63:470b:: with SMTP id u11mr29745002pga.441.1634668726062;
        Tue, 19 Oct 2021 11:38:46 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id qe17sm4094137pjb.39.2021.10.19.11.38.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 11:38:45 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 19 Oct 2021 08:38:44 -1000
From:   Tejun Heo <tj@kernel.org>
To:     menglong8.dong@gmail.com
Cc:     jiangshanlai@gmail.com, linux-kernel@vger.kernel.org,
        mengensun@tencent.com, Menglong Dong <imagedong@tencent.com>
Subject: Re: [PATCH v2] workqueue: make sysfs of unbound kworker cpumask more
 clever
Message-ID: <YW8QtIU5lqRB+NNU@slm.duckdns.org>
References: <20211017120402.2423524-1-imagedong@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211017120402.2423524-1-imagedong@tencent.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 17, 2021 at 08:04:02PM +0800, menglong8.dong@gmail.com wrote:
> From: Menglong Dong <imagedong@tencent.com>
> 
> Some unfriendly component, such as dpdk, write the same mask to
> unbound kworker cpumask again and again. Every time it write to
> this interface some work is queue to cpu, even though the mask
> is same with the original mask.
> 
> So, fix it by return success and do nothing if the cpumask is
> equal with the old one.
> 
> Signed-off-by: Mengen Sun <mengensun@tencent.com>
> Signed-off-by: Menglong Dong <imagedong@tencent.com>

Applied to wq/for-5.16.

Thanks.

-- 
tejun
