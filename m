Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B69F37A63D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 14:04:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231489AbhEKMF0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 08:05:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:48144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230225AbhEKMFZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 08:05:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5492D6186A;
        Tue, 11 May 2021 12:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620734659;
        bh=5VqG2NjZhzFLUHnKqRatAHTnKgyK5qeMuCtK5FhB5h4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z6YD/ET3KxC1cidjKKC7eHu9ZjHtSaEYOHhoQa79URJoWyK+6Ui/lzKkiwNXhnGvJ
         UmKtvGLLWYjLzxQTAA1dxJEXyEHF3bh9wvExenIqT+NPtuGY1yN7snbjfRnxnzA5dB
         Y0xITMkq038cio8J+QXcjTH/n9h4K/iWeo0hvxlmP801kIidYt0i1bqNfMyXOwUWDe
         iTeDNSicMGOXchk/28ZAO9JhTfrTWdYFIK+FMgG+Ig9s9ulfu7kQwpwikOc8/bY5Ic
         MmiCTvIFbX7xxy1fRYt1+2Vsn0G9UttqjmaB3j8PTzfW25ZMwLsHdwdXqYxH3M3X6z
         FP7tlMNWNwe2Q==
Date:   Tue, 11 May 2021 17:34:15 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, srinivas.kandagatla@linaro.org,
        rander.wang@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        bard.liao@intel.com
Subject: Re: [PATCH] soundwire: bandwidth allocation: improve error messages
Message-ID: <YJpyv2rSIcg4ZeCM@vkoul-mobl.Dlink>
References: <20210511054945.29558-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210511054945.29558-1-yung-chuan.liao@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11-05-21, 13:49, Bard Liao wrote:
> From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> 
> In rare corner cases, we see an error with the log:
> 
> [  838.297840] soundwire sdw-master-1: Compute bus params failed: -22
> 
> That's not very useful, there can be two different error conditions
> with the same -EINVAL code provided to the caller.
> 
> Let's add better dev_err() messages to figure out what went wrong.

Applied, thanks

-- 
~Vinod
