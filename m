Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11C463EEC7A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 14:31:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235911AbhHQMbn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 08:31:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:54715 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230323AbhHQMbj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 08:31:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629203465;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=l9WuU7cYAYKJNJSQJYvnJwi7OnY5SKMEuReQStHmD5c=;
        b=g2cSRWpJNVeIT+hmrieNoOq9CZMqq63vhDA23/Z1mhYJlfCi0jnbnkJ1+5Bz35mVTRfk+x
        hxvyqlirIs56tqsAk1HIDedpt2/GPJdrzxSTZh+if2wUclCqiVNuTW3NIuHyWnoT1QMHcx
        9f326Wd2ztfjkhbYRor84s0lzp5KzPA=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-288-aZN9o1HUMx66eClTPOhnOA-1; Tue, 17 Aug 2021 08:31:04 -0400
X-MC-Unique: aZN9o1HUMx66eClTPOhnOA-1
Received: by mail-lj1-f198.google.com with SMTP id f11-20020a05651c160bb0290192ede80275so7313226ljq.12
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 05:31:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l9WuU7cYAYKJNJSQJYvnJwi7OnY5SKMEuReQStHmD5c=;
        b=XJLmavnVh7EosXqctLNTcu6/5ne/8CTCwAvFQP2TEKXQKp7jmya5Qxh577s8BW9/SJ
         5/hpC/vvNaDqqU8ULjCFWz1FtiKAugA6OHb22bFfVBIqIQuS8NEgqDQQxQwxhXYfFzxY
         5Gt2WKqxRAcPl3+1pm0zzT252UKYRKec8yzZJ4MCy50BsiY7oxsfeJZiJH5mY5DdwDvK
         teRKubLhtohx1aK7NlnbFh+UEdXaYHF02th6PdK8NgWDxzh++bO0+0nSRvDx7PawqZI7
         xVbZjUykUm+0gK5Tmqgj+VKWrWb8i+0hf0vmW5vA4CNWja0uz8KdKQbsA0qjiHwlr4NQ
         lnbw==
X-Gm-Message-State: AOAM530Vm2p6kHX4PM/V4jyisvXfxyKGw2O5MyKS1BXqeVpTGzazbTt/
        FEUkYaRGc1jmFegQoKK1qxwEPHRsVVxirHjGLzDpCZHCUJjwQGQ4TJadXGHsNjkKX4Gr9iRcAe+
        21Xk53hxqDX4mSPMl7T9wi8txy4ObVjNERn3RGy9K
X-Received: by 2002:a05:6512:3f08:: with SMTP id y8mr2061042lfa.221.1629203462738;
        Tue, 17 Aug 2021 05:31:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJybPSuwd/cHGg1jI+YCben7Tu95Hhn1Pf3wlgLk+sravd7yNqCyi9y75i+PPeb4osilTXEvMDNRNSkEayvjHTM=
X-Received: by 2002:a05:6512:3f08:: with SMTP id y8mr2061030lfa.221.1629203462497;
 Tue, 17 Aug 2021 05:31:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210816105119.704302-1-hpa@redhat.com> <20210816105119.704302-7-hpa@redhat.com>
 <YRt+Tnt4tvULM4MP@lahna>
In-Reply-To: <YRt+Tnt4tvULM4MP@lahna>
From:   Kate Hsuan <hpa@redhat.com>
Date:   Tue, 17 Aug 2021 20:30:51 +0800
Message-ID: <CAEth8oH=kEb76CP578A7YnS3CN28aSDgUSjgNeGQgUnCTMXPWQ@mail.gmail.com>
Subject: Re: [PATCH v2 06/20] platform/x86: intel_scu: Move to intel sub-directory
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Alex Hung <alex.hung@canonical.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        AceLan Kao <acelan.kao@canonical.com>,
        Jithu Joseph <jithu.joseph@intel.com>,
        Maurice Ma <maurice.ma@intel.com>,
        Sujith Thomas <sujith.thomas@intel.com>,
        Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
        Zha Qipeng <qipeng.zha@intel.com>,
        "David E . Box" <david.e.box@linux.intel.com>,
        linux-kernel@vger.kernel.org, Dell.Client.Kernel@dell.com,
        platform-driver-x86@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 17, 2021 at 5:16 PM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> On Mon, Aug 16, 2021 at 06:51:05PM +0800, Kate Hsuan wrote:
> > Move intel_scu to intel sub-directory to improve readability.
> >
> > Signed-off-by: Kate Hsuan <hpa@redhat.com>
>
> Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
>

I'll add this to the commit message.
Thanks

-- 
BR,
Kate

