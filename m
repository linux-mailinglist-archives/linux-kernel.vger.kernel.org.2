Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C359F41AF31
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 14:42:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240755AbhI1MoQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 08:44:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240746AbhI1MoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 08:44:14 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76719C061604
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 05:42:35 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id e7so21094400pgk.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 05:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=heitbaum.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KrkBhOCAHDLrXlCJGYdW7dNSKw0SJG9MSoAFEH4IRhM=;
        b=V3HnIKh9EBOuvvF6mNGhT0Ru4vFPSZOsbxmvLe24EqZnjfggFqYa95coyrVbCFyWai
         PhFyRqaL6GLJMN1ez7Xdl/zu1/9PzfWXBereA7KvMCWcnvhQbZKiDu3AIdo+Bp+pEDwG
         oYusH6ow2v/Qzt58vQOlhRpbXrWWkKsahCFxo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KrkBhOCAHDLrXlCJGYdW7dNSKw0SJG9MSoAFEH4IRhM=;
        b=53HJl3JnAGCq52z1XhYZwqMFvoH5sB85pije8HCybIlXeJ4ThuH65AV0L6S0LAIMMb
         xH3G9xN6+RUjBcyFhfiWeA48++IM3yxgXCLuU/RFxQt8OO3/QzFwqT59K6YmNPORX4pX
         0wrVbokEyDXd8Ys1FeLi3AZN0hW87Zees+XtlYvuRDdxSwGL6cyXa2bOP3i9qLR1YqTC
         H3d4rhriKAtTI+eJKKnd5SnGwPJ6GLHYWDpSUQ23UihXRxFfjoSjArJtBt4z8lxOn6+k
         zUdV/ElYf0H6EXf8Pdb3jlMML4Fn/7NCIFGFt+2PZKdV1RtWGQM8MFOIzZj6gJYGkZ25
         o5dw==
X-Gm-Message-State: AOAM5312ATFzctlmV0akKK6Sph13wocixrW/coUeWukN5Ndw+QnuslPJ
        16cGcAvhd5DRttSMkEBA9ONuEQ==
X-Google-Smtp-Source: ABdhPJztuO9y0JJxQl3fjPtbES/ZsYEsZ3QZBTftThZwr9boSo2ZHAwM94JQ3QFpg9M9db83/rbZYg==
X-Received: by 2002:a63:534f:: with SMTP id t15mr4468932pgl.392.1632832954904;
        Tue, 28 Sep 2021 05:42:34 -0700 (PDT)
Received: from 235a98196aae (194-193-55-226.tpgi.com.au. [194.193.55.226])
        by smtp.gmail.com with ESMTPSA id t9sm2597559pjq.20.2021.09.28.05.42.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 Sep 2021 05:42:34 -0700 (PDT)
Date:   Tue, 28 Sep 2021 22:42:27 +1000
From:   Rudi Heitbaum <rudi@heitbaum.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com, stable@vger.kernel.org
Subject: Re: [PATCH 5.14 000/161] 5.14.9-rc2 review
Message-ID: <20210928124222.GA7@235a98196aae>
References: <20210928071739.782455217@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210928071739.782455217@linuxfoundation.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 28, 2021 at 09:19:04AM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.14.9 release.
> There are 161 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 30 Sep 2021 07:17:13 +0000.
> Anything received after that time might be too late.

Hi Greg,

the following patch causes IGC not to build as PTP_1588_CLOCK_OPTIONAL
is not included in the 5.14.9-rc2 patch.

igc: fix build errors for PTP
[ Upstream commit 87758511075ec961486fe78d7548dd709b524433 ]

the config is only found in 5.15rc on this commit:
https://github.com/torvalds/linux/commit/e5f31552674e88bff3a4e3ca3e5357668b5f2973

diff --git a/drivers/net/ethernet/intel/Kconfig b/drivers/net/ethernet/intel/Kconfig
index 82744a7501c7..c11d974a62d8 100644
--- a/drivers/net/ethernet/intel/Kconfig
+++ b/drivers/net/ethernet/intel/Kconfig
@@ -335,6 +335,7 @@ config IGC
 	tristate "Intel(R) Ethernet Controller I225-LM/I225-V support"
 	default n
 	depends on PCI
+	depends on PTP_1588_CLOCK_OPTIONAL
 	help
 	  This driver supports Intel(R) Ethernet Controller I225-LM/I225-V
 	  family of adapters.
