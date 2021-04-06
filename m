Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 082C1354BEC
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 07:08:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243720AbhDFEyT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 00:54:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:56092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242579AbhDFEyT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 00:54:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0102060FE6;
        Tue,  6 Apr 2021 04:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617684851;
        bh=0rww47IafzbgbXEYx+IN9+Ntm6//M9vv4zbbSzEGEjI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ILA0ZYTMD0zZgHbfiZ+OqXegUsN/guH1H33DakqVpXd2ys4dC/i7kDBO+J4/LBxCu
         2uQtQDl3UkAmjGBJa3oylZDF7St1Dm4SnJDLPXxfDoPoJL1r8nV5t0ZF2pk2f6Wzl/
         IenjOnaGureCio8F627XUvIYoqYoBknDZx0Au5DtdcicG1ndL4N+peiUVVQ8bIW15f
         AcGia9o/mh1a4rHJvvTdycTsKp7nEbXVt2gc4QKb1GCPXp1uYZXF8iiHioyCL9kmGI
         kpYfi9jYQqxLEAGcMpXP0531npQRkPYfk4rOtMvHrg0mL/7bLz1b0meDnMSW+I+TAX
         RTsi7vZAzZxEg==
Date:   Tue, 6 Apr 2021 10:24:08 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     yung-chuan.liao@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        robh@kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH] soundwire: qcom: cleanup internal port config indexing
Message-ID: <YGvpcAcOGWiOFWim@vkoul-mobl.Dlink>
References: <20210401092454.21299-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210401092454.21299-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01-04-21, 10:24, Srinivas Kandagatla wrote:
> Internally used portconfig array for storing port bandwidth
> params starts from offset zero. However port zero is not really
> used and we also copy the bus parameters to offset zero.
> So basically we endup with a code which has to subtract 1 from port
> number to get to port parameters.
> 
> This is bit confusing to the reader so, make this bit more obvious by only
> copying the parameters to offset 1 instead of zero. This will avoid doing
> -1 every time when we try to get port params.
> 
> Similar thing has been recently done with din/dout_port_mask.

Applied, thanks

-- 
~Vinod
