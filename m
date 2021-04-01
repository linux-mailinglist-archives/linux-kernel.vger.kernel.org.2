Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7081E351004
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 09:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233687AbhDAHVi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 03:21:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:55154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233576AbhDAHVT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 03:21:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 613B56105A;
        Thu,  1 Apr 2021 07:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617261679;
        bh=3BgZHbWAlYyhCK/qSK2Ekjixiw6B8IA5V9jeRPHwXDk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P61NixqWNZan2HAwPeakmLV2OMI4zu11XzSkhc6p0z9AiVTLv+1ke4SgCcn3JIcUp
         5e84tdv6Cl6i7ywKrLMw3wTWegDKxPZGRpIRwkfGxjmFeWfQ6GA8c+5UVJkx7PBFeZ
         JUcsDp9I9o5iXKJLpZlOqQukZT+Dyqy/3Iqek2+tYPP8EYyyq1IBHwxVDIQphEtvHj
         A18BAT38H7ZTSt9QUzPyNnAUhk0/CHoHv99jX9THD+gxdDjm8CtKKfjaPWGr14ak7r
         9eN0HIFgfuaXMX46Zz+xxbuyNzvspIMYqfZFDpZhrWQ9d0vYApk/kK8KfMHeXo41Bq
         c1ODYK9j1IeaQ==
Date:   Thu, 1 Apr 2021 12:51:15 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, srinivas.kandagatla@linaro.org,
        rander.wang@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        bard.liao@intel.com
Subject: Re: [PATCH] soundwire: intel_init: test link->cdns
Message-ID: <YGV0a+ZnTh7A8DD0@vkoul-mobl.Dlink>
References: <20210331010250.14151-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210331010250.14151-1-yung-chuan.liao@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31-03-21, 09:02, Bard Liao wrote:
> intel_link_probe() could return error and dev_get_drvdata() will return
> null in such case. So we have to test link->cdns after
> link->cdns = dev_get_drvdata(&ldev->auxdev.dev);
> Otherwise, we will meet the "kernel NULL pointer dereference" error.

This fails to apply for me

-- 
~Vinod
