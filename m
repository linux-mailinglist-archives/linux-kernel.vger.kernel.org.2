Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E023344DD4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 18:54:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231395AbhCVRyN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 13:54:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230231AbhCVRxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 13:53:41 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86D8EC061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 10:53:41 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id l23-20020a05683004b7b02901b529d1a2fdso16806250otd.8
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 10:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=c3qfNW7pReBN9uBBNYPS1RAciUjVnYBp+hSQCW1pI1Q=;
        b=Lxa+rLTcucBEpGfAPeWBuJDwXfZqE7TDWVw4jUPu2KFKWFft0FZpUG/G+pF+Yf+yyy
         +/TUa5IgcC3zCyGXXpuTYomkYtOYCM2eOr7OQCJ3Q6NP1JMrBajfHsa7s8XgdCpDENKK
         Rz60juy/XNiLqx4Zy1EBi+kh8lnokFWNGcv2w4JOmTrPPxhKpMW6/griviLoKAwlSYj4
         F/js7fGxYUrpfNt/QkGZ3912Uhcuoacj+YF3v//ueJSvfz71UVlmfm5hquUYp8AiQIDp
         onajRySfcOZl07bcs2GTLDnUBvEo4Icdd1QJzoAiE68CsO4vAskskcHiFdmFpBhaAyLo
         evZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=c3qfNW7pReBN9uBBNYPS1RAciUjVnYBp+hSQCW1pI1Q=;
        b=fUX2r9Iazb/2NgPE9c9KOVZ8h5KNryoOrIZ1L2PRLjqht90X0QqaMAmJV44pYjP+JA
         0obuKgJAaZ7J3D/MouCFqRX6wcvBDREn8JBNZxn9PQX3sneG8e4shHReYYigJPGWBWO/
         zNO41SJm2mW9wFqDh4Gh+E0KDxa0Ra2C2mkGyWlkNj8Zsd6uYbU4r84U4sudVk7TU9oA
         Zko/9ot/B6BevQkJpEHz1nTjvsimbL7LuKRRyyMCXd17vjrqvIGzPpDbTYU+jFsYdc/5
         vmXLiXEwydx0kYpA0aQuf2XHYmMWtPi/2LHwrHLmpMtz2Zr6KWdmgPHh3FwAnED7EEKd
         ak1Q==
X-Gm-Message-State: AOAM531M9vT4rAQbw7aNJeapow2iHZ2DMYLPjM0L7tnJSfP6GrKrJ2wi
        0IdP4sVuZTkQ8F58xId/I6c=
X-Google-Smtp-Source: ABdhPJzWGRJWgsj2bonwStCoRaX4vDQ62Bt7L4AIICdVvrsusLy0YrT6gK8SKLwubEmAVUhRnK0tQA==
X-Received: by 2002:a9d:628d:: with SMTP id x13mr844535otk.19.1616435620934;
        Mon, 22 Mar 2021 10:53:40 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u23sm3136949oof.17.2021.03.22.10.53.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Mar 2021 10:53:40 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 22 Mar 2021 10:53:38 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        iommu@lists.linux-foundation.org, Joerg Roedel <joro@8bytes.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Sanjay Kumar <sanjay.k.kumar@intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>
Subject: Re: [PATCH v2 1/4] iommu/vt-d: Enable write protect for supervisor
 SVM
Message-ID: <20210322175338.GA24424@roeck-us.net>
References: <1614680040-1989-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1614680040-1989-2-git-send-email-jacob.jun.pan@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1614680040-1989-2-git-send-email-jacob.jun.pan@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 02, 2021 at 02:13:57AM -0800, Jacob Pan wrote:
> Write protect bit, when set, inhibits supervisor writes to the read-only
> pages. In supervisor shared virtual addressing (SVA), where page tables
> are shared between CPU and DMA, IOMMU PASID entry WPE bit should match
> CR0.WP bit in the CPU.
> This patch sets WPE bit for supervisor PASIDs if CR0.WP is set.
> 
> Signed-off-by: Sanjay Kumar <sanjay.k.kumar@intel.com>
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> ---

ia64:defconfig:

drivers/iommu/intel/pasid.c: In function 'pasid_enable_wpe':
drivers/iommu/intel/pasid.c:536:22: error: implicit declaration of function 'read_cr0'
drivers/iommu/intel/pasid.c:539:23: error: 'X86_CR0_WP' undeclared

Maybe it _is_ time to retire ia64 ?

Guenter
