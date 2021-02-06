Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B112311CAC
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 11:50:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbhBFKtq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Feb 2021 05:49:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbhBFKtm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Feb 2021 05:49:42 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AD30C061756
        for <linux-kernel@vger.kernel.org>; Sat,  6 Feb 2021 02:49:02 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id u11so4859740plg.13
        for <linux-kernel@vger.kernel.org>; Sat, 06 Feb 2021 02:49:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Wnt31go3qxgTOGvZP7DEXg16m0fpmuqivDt/iA9WlXo=;
        b=X5HqkrqQuQZWnnV3phuwbdLjM4fwAzOSaxUHw/etu7wLv1QYGARa2rNZFZoZbKSTDO
         a3uFqOptwDHzZtSVGFG9tLzsDhOm1FjgypGVBjHlBIfJvNYzpYDl0McPhlmwdwqMB+2P
         CmkRk3fMVp+ojccORatFQlrHEKqrpr3xcUr/nXiQPgJ2zAtSXNV1B3U1JZUv2YoJ082R
         mWSARARH1RdRszQcmUwdYwCMqs9Wiahw+JdwV//p12gCGhT3zGAAmvdpE8Ax8qu9oJiv
         v7RltzY3f0CnFkzuzaOXfd7649nYCMqmj8aHsgzdnsoa+HpsnfUuiTth39Vg/SG44NUC
         7rJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Wnt31go3qxgTOGvZP7DEXg16m0fpmuqivDt/iA9WlXo=;
        b=Lnvaj70GgxKRuZrcAV+HnVOirSzwbiX282TRUkvI0uWuNDrIzVJVaHQkUKa6uRUbr5
         aY9lgUHrWeoR/pgv4KKPEkxk4Su2BVO05c17LUqCSeSP3rETa1rzTxjiaL+lCLMtNUu+
         v0Ndeiqv+7kjzMbJsSeiulN8w/48zaVmFddW4etfjZTh8hd+koWL3P2q2nNiRBfyWwuT
         f0utUdVC3Ky0ywkhH1vbNvQoviHVdg2H5QAP88IYC2VkX264z6UXOnePsn+4JddXcLpz
         XwJ3s2P7ZNWBBYEZu82qSpT0VbKglH+TPqRx3oLqcjIkdsatHp2ZQXNZYxJRCIxSmAf9
         s/Bg==
X-Gm-Message-State: AOAM532OVpYy7ZoULUNL00o7l9OvT/GTBLbqauNxa0porVLDtzHQ9pGm
        R1cYz+8KGzLuXTtjm7iOB5pFDQ==
X-Google-Smtp-Source: ABdhPJzRpTiDsbSCcJBW5kdLUgEacWK8AWdgcA9tGT89CZK6du++rz58bXp0VU+OaB8ILLcj0PYzXA==
X-Received: by 2002:a17:90a:318d:: with SMTP id j13mr8103093pjb.77.1612608541526;
        Sat, 06 Feb 2021 02:49:01 -0800 (PST)
Received: from dragon (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id j9sm10635936pjn.32.2021.02.06.02.48.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 06 Feb 2021 02:49:01 -0800 (PST)
Date:   Sat, 6 Feb 2021 18:48:55 +0800
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, devel@acpica.org,
        Robert Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] Revert "ACPICA: Interpreter: fix memory leak by using
 existing buffer"
Message-ID: <20210206104854.GC27503@dragon>
References: <20210206084937.20853-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210206084937.20853-1-ardb@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 06, 2021 at 09:49:37AM +0100, Ard Biesheuvel wrote:
> This reverts commit 32cf1a12cad43358e47dac8014379c2f33dfbed4.
> 
> The 'exisitng buffer' in this case is the firmware provided table, and
> we should not modify that in place. This fixes a crash on arm64 with
> initrd table overrides, in which case the DSDT is not mapped with
> read/write permissions.
> 
> Cc: Robert Moore <robert.moore@intel.com>
> Cc: Erik Kaneda <erik.kaneda@intel.com>
> Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> Cc: Len Brown <lenb@kernel.org>
> Reported-by: Shawn Guo <shawn.guo@linaro.org>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>

Tested-by: Shawn Guo <shawn.guo@linaro.org>

Thanks for fixing the regression, Ard!

Shawn
