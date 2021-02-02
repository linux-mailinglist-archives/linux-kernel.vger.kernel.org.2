Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7AF330B6AD
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 05:49:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231842AbhBBErZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 23:47:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:34800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231725AbhBBErX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 23:47:23 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 196AC64D79;
        Tue,  2 Feb 2021 04:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612241203;
        bh=YuyulshcBgDXIxc6tUZMPdtoz3RGyqGTVQuKlffUHh8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dAcEaxQu+yWFFJ69ocA1gEg0RbwUT/u2dHEO2rAAZudfYVw9kki/9tBuC4bca9Z2G
         /Ok8wL4eOU8A6/X1VH63vcLHTGPyB5mNjtAAtiHvdKhuBBwE4w08+Pdc+rLae1MXpg
         ZiowW7EHmIFCds0aQvnRlolFW+NfxZvnLuYg4W36ZYJ5nNS/tTzUkKjAZ2FtJAQMWw
         h/APXD7lh5SnaaE3TsytzC/GeRxkZ4D9lbvb56sd7jvw92juD/XPytXdkByV/OcsT8
         YfFige1gK0S0F7U4lzRR2xpLIBmjaJPveexj/lOJ7mslGM+ab/a6Shka1FmM1r0ekA
         J+pEXn0uJMbvw==
Date:   Tue, 2 Feb 2021 10:16:38 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     yung-chuan.liao@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Re: [PATCH 4/6] soundwire: qcom: start the clock during
 initialization
Message-ID: <20210202044638.GK2771@vkoul-mobl>
References: <20210129173248.5941-1-srinivas.kandagatla@linaro.org>
 <20210129173248.5941-5-srinivas.kandagatla@linaro.org>
 <20210201142134.GC2771@vkoul-mobl>
 <bdedf84c-68fd-767d-8b3b-5a6ba03e03d8@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bdedf84c-68fd-767d-8b3b-5a6ba03e03d8@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01-02-21, 15:50, Srinivas Kandagatla wrote:
> 
> 
> On 01/02/2021 14:21, Vinod Koul wrote:
> > On 29-01-21, 17:32, Srinivas Kandagatla wrote:
> > > Start the clock during initialization.
> > 
> > A detailed log please, which clock..? Also how do older controllers work
> > w/o this clk
> 
> By default this is ON, however depending on that is not really reliable!
> 
> Explicitly enabling this will make things clear when we add clk pause
> feature for this driver!

lets add this in the log please

-- 
~Vinod
