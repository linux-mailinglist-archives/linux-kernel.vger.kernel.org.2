Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E04F23F1659
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 11:36:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237594AbhHSJhN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 05:37:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237366AbhHSJhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 05:37:12 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 472DCC061757
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 02:36:36 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id q10so8093171wro.2
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 02:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=m+LHyne0kv5mF9vWjh7fD8eOk46K8HFKzEPGFhrnFPM=;
        b=GvRLgi6eJnrZ1RKBLJvKMsbPyP9D8ACO613KOSlfXAwS/eni21eNpmEOmnJU7BdUq6
         sozDszho81xo0ejjZywT1pCdbumjvRt+StSteFgApCyAgeZVSE+nrlbcmmQffXD8eZrJ
         nw327OkI8DDT82RUaWB+sAPpNumoMNfpinT+fgQujT/u1ADNKg+l9S0KVmJfWSGerfb0
         4fm6fgaHnslyjoqitvvXw89wnWmxq0fn/VQy4xsfnTR4P5m9CteELGeG+VqEh6sNCm20
         MLKqFg+I4GfWWRo53RBPm8qVqNXX3P/QjbSB0rd02cfFzlXLqEU+nTSKdavbLifSGmGV
         Dz8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=m+LHyne0kv5mF9vWjh7fD8eOk46K8HFKzEPGFhrnFPM=;
        b=PnNws18rtACAZRcxzb5aQDQgWiC0nyyucQtiH7KQGQvho4W8ylTlyHQeDk/sw2rjyl
         gyZ+LlHcRh8xgk7yyvrEB/B5v6dYbdtfEzK3qFKC7WlDCC+4k9cmdRePSCSkiPjxhpdE
         hFVPdcB15kDHcicJ5ipDOwrIBJoZXL9AnOPMf4SrleUE9cMw9EcRDLHmkeTPPxWnmvt5
         gBBAmNXDMHF33zSEW07jSZwSzDOtERgorsZ2ur6feu8YkHtULHszjdk1W2ILMojaQGDL
         iu4kuUWW3TFTBS30h59JhTT+OJajpZ8hl7eNBSMBmWtIw3yR+MBgkCexlIk0cTdgpMK8
         vdmw==
X-Gm-Message-State: AOAM531TBpN97wgHpls/wb7T3DhHKVNlrc6vKyZXXASIbRWHsOmgFlh0
        qM1JDkCuUTBjhywxpYLX6Oi05Q==
X-Google-Smtp-Source: ABdhPJxkp5oW5Dn0ctdn3JjnnGk8HMnsKNq7mdpuH7P0JWvijzf9A93EMtNVZJgUM9dNSCfCtHfAkQ==
X-Received: by 2002:a5d:6da4:: with SMTP id u4mr2634271wrs.50.1629365794902;
        Thu, 19 Aug 2021 02:36:34 -0700 (PDT)
Received: from google.com ([2.31.167.59])
        by smtp.gmail.com with ESMTPSA id w18sm2520320wrg.68.2021.08.19.02.36.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 02:36:34 -0700 (PDT)
Date:   Thu, 19 Aug 2021 10:36:32 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "David E. Box" <david.e.box@linux.intel.com>,
        mgross@linux.intel.com, bhelgaas@google.com,
        srinivas.pandruvada@intel.com, andy.shevchenko@gmail.com,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 0/5] MFD: intel_pmt: Add general DVSEC/VSEC support
Message-ID: <YR4mIGeZAqJJCZ9i@google.com>
References: <20210817224018.1013192-1-david.e.box@linux.intel.com>
 <21f59d91-c9b9-2a7e-e5d9-a7697979b4bf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <21f59d91-c9b9-2a7e-e5d9-a7697979b4bf@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Aug 2021, Hans de Goede wrote:

> Hi,
> 
> On 8/18/21 12:40 AM, David E. Box wrote:
> > This patch enables general support for Intel defined PCIe VSEC and DVSEC
> > capabilities in the Intel Platform Monitoring Technology (PMT) driver.
> > Though the driver was written exclusively for PMT capabilities, newer DVSEC
> > and VSEC IDs for other capabilities can exist on the same device requiring
> > that the driver handle them.
> > 
> > This 2nd revision drops the creation of a separate OOBMSM driver. Instead,
> > all cell drivers will have a dependency on CONFIG_MFD_INTEL_PMT, whether or
> > not they are PMT. Changes in this patchset to the current cell drivers
> > located in platform/x86 are based on Hans for-next branch where they have
> > been moved to the intel/pmt subfolder.
> > 
> > David E. Box (5):
> >   PCI: Add #defines for accessing PCIE DVSEC fields
> >   MFD: intel_pmt: Support non-PMT capabilities
> >   MFD: intel_pmt: Add support for PCIe VSEC structures
> >   platform/x86: intel_pmt_telemetry: Ignore zero sized entries
> 
> Since this patch is pretty much a stand alone patch I've picked
> this one (4/5) up now.
> 
> The rest of the patches touch both MFD and pdx86 files, so these
> should be picked up by Lee. But they rely on the patch moving
> the pdx86 pmt code into the drivers/platform/x86/intel/pmt dir
> which is currently only available in my for-next branch.
> 
> I think it is probably best to wait for 5.15-rc1 and then Lee
> can merge the rest. Here is my ack for Lee picking up
> the pdx86 bits:
> 
> Acked-by: Hans de Goede <hdegoede@redhat.com>
> 
> Lee, alternatively you could also merge commit e184b1e589a7fbb80bfdd0364c11422999a17a26
> from the pdx86 tree, that is only 1 commit ahead of my latest fixes
> pull-req to Linus for 5.14, so in essence that is 5.14-rc? (?=5 I think)
> + just the commit which you need as base, then you could still merge
> these this cycle. If you wish I can put a signed tag on that
> for you (I will treat it as immutable either way).

I'm happy to wait.

The MFD patches aren't even reviewed yet and it's late in the cycle.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
