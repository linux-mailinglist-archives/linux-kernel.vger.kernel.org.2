Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CEF6409B40
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 19:53:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239549AbhIMRyj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 13:54:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240741AbhIMRya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 13:54:30 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10CCBC061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 10:53:14 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id mi6-20020a17090b4b4600b00199280a31cbso436030pjb.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 10:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kXZtHcVNaM7mdaUxUJBAXKCjuJ3E0tetF3TAL3wdUUo=;
        b=Xs18WTwxXQS7iQJjubYakIrgstlm0398vyhA3uqhygdFTqMPF5w2fcl9SDAL3x6y5T
         p3ROiewN0tQ+eWfvoIyrVU7G6EMbt5w2c9zQcnDP8j/5/CGhguJ0gJdkBoZnSulcITiv
         Q/vWi/Mp6zaDDks4UlEQXN/GSbiaPoOlgM4pdsFD7W02CYH8Go33Rh2lMEvOz++fCLX1
         6ALj/DzVYcenjZs0xKNyuRvneh98F2NxB09XI8uvpvmfRF4ESXEtjg0h5ibRkIT+A/iZ
         JnymNDOHu95hpDsmHAEilGbJQLGDT3Dwi670u31lCp9fs8ytFfpRLjiRKYOcAVSueTfO
         HQTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=kXZtHcVNaM7mdaUxUJBAXKCjuJ3E0tetF3TAL3wdUUo=;
        b=w5UEgpl569WSWScwEdoRHBJ/c0zCACNFvu9FtM2niq9pj9SsrmSYstH1AWT1+8SZ9m
         y8/NdzjthktJgad3G5kClws1df9RUv2P+AW40fpKCKwPDRnU85+G5d4cp+QiVDLuObMu
         ZSg0vEjSbkdm1zjUPl4pf2RZPNwrPHAhttmDUWxNffGsAvgnz7sDiWdjHnzEcVdIowW5
         roZm4J1V109Q2ZC/ogPKFQdYBpLcZzjtcxoxl/3PL3/ZtU3BuKGi3VHrs0U36BT93GPL
         jPoeG8rXdsZBamFXKL0vamSdKkeMMlE7bFBLW+H38pd4KPwn4Wk1xwxJIW6M0WnBlJ6f
         IyYg==
X-Gm-Message-State: AOAM530j0eFp2dZZSir0OQN8g9BsCI3CvOTyxJ4H7P0H375ord7cioKq
        GoSNPNyQzWAQG/sb7HktmRSix7sf1sk=
X-Google-Smtp-Source: ABdhPJwmR6Bf6ozUOtFrgMtzXtElYodZ2ttS/KQzBkD8k3oOCEdCh9pkimdpe+J8+33UVOnxE7FJyw==
X-Received: by 2002:a17:90a:2dc6:: with SMTP id q6mr739892pjm.200.1631555593362;
        Mon, 13 Sep 2021 10:53:13 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id h16sm1736143pjt.30.2021.09.13.10.53.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 10:53:12 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 13 Sep 2021 07:53:11 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Rolf Eike Beer <eb@emlix.com>
Cc:     Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] workqueue: annotate alloc_workqueue() as printf
Message-ID: <YT+QBwXiQGxkRqXZ@slm.duckdns.org>
References: <2947630.YJcLE3A3dI@mobilepool36.emlix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2947630.YJcLE3A3dI@mobilepool36.emlix.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 13, 2021 at 12:02:56PM +0200, Rolf Eike Beer wrote:
> This also enables checking of allows alloc_ordered_workqueue().
> 
> Signed-off-by: Rolf Eike Beer <eb@emlix.com>

Applied to wq/for-5.16.

> +__printf(1, 4) struct workqueue_struct *alloc_workqueue(const char *fmt,
> +							unsigned int flags,
> +							int max_active, ...);

I broke the line after the return type while applying.

Thanks.

-- 
tejun
