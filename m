Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5EAE34E3DA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 11:02:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231728AbhC3JCW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 05:02:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:49122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231731AbhC3JCE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 05:02:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7338D6195D;
        Tue, 30 Mar 2021 09:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617094924;
        bh=hAv6DilAIxtCgBbhv9FLZwO8QDhSFQHMKU2AEqrqDRg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ij2Ecc32OujdOVJlnOlW3Cr1yRgdFLx7hGTtQqIF677yJvrk4vxx9AC1aCvSm2Aa6
         UJXoFPgy+fWr5MY/s/PFvyB57770/kvZYRtxr1V2z5rJxbOrshEQb7Z1vYX2l2kjAd
         DMpECWGyE2xAPcRR/KtSvnBKPvyzMgGqd+SSI7mg5odbNKi3Eooc0qeSyZFlpslqJO
         pub1Dgq9VyEtqL/Rg89jJjv9bHLDL++ZimXhx00aIq1UjvdQl3VfyVprxOqiiCg8PI
         3PGk0waLway+WDS8oadOa6fKKy2HIP0cCcUUJvytxZFxrcgFtLtgoQIWr9vKL0jAK0
         zYiZFRuVtRLGQ==
Date:   Tue, 30 Mar 2021 14:31:59 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     broonie@kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     robh@kernel.org, devicetree@vger.kernel.org,
        yung-chuan.liao@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Re: [PATCH v4 4/5] ASoC: dt-bindings: wsa881x: add bindings for port
 mapping
Message-ID: <YGLpBxw0DV3km1wM@vkoul-mobl.Dlink>
References: <20210315165650.13392-1-srinivas.kandagatla@linaro.org>
 <20210315165650.13392-5-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210315165650.13392-5-srinivas.kandagatla@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15-03-21, 16:56, Srinivas Kandagatla wrote:
> WSA881x SoundWire device ports are statically assigned to master ports
> at design time. So add bindings required to specify these mappings!

Mark, are you okay for 4, 5 to go thru sdw tree with your ack? The
patches lgtm

-- 
~Vinod
