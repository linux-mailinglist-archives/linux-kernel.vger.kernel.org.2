Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00330351003
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 09:22:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233647AbhDAHVf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 03:21:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:55010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233151AbhDAHVC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 03:21:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F2A7F6023C;
        Thu,  1 Apr 2021 07:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617261661;
        bh=ZWEem6wvNgJS46gZy7rOARo0M8j/1n/7RpnfGUxvSAQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z43pJ/6J/QBbelI2RTCRvZu30Fv1erhhUhjEBzUeviZp0gVedrhHqCvU3V4JIlKmq
         Kd5et0N3hsYmuzD/Kj1cnJeJ+6/HCfDmo43fc1kuuaZcX6dngqwMohwR3ZvDie4nAZ
         KegY93RXfl4dSsUUfMZ+M1wxBDFpDoCJ4rJQ+r51SIJrcJyNJ+0oB9ZJuEvIeq8JL6
         0xKT9sn9u49sPx1r3raYir3aUy2Y2AG8AOzNtukmss4tPdjxOBY7ymITpS9oPb7N2g
         cBHMemX9lWNV5UiguUGo2hcjKZdHiQQyupC+5tTEuLNViqXI1PKrAOV0KFcdlvOi3+
         sa8A9gGcc9IIQ==
Date:   Thu, 1 Apr 2021 12:50:57 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, srinivas.kandagatla@linaro.org,
        rander.wang@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        bard.liao@intel.com
Subject: Re: [PATCH] soundwire: stream: fix memory leak in stream config
 error path
Message-ID: <YGV0WRmhscWmn8y+@vkoul-mobl.Dlink>
References: <20210331004610.12242-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210331004610.12242-1-yung-chuan.liao@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31-03-21, 08:46, Bard Liao wrote:
> From: Rander Wang <rander.wang@intel.com>
> 
> When stream config is failed, master runtime will release all
> slave runtime in the slave_rt_list, but slave runtime is not
> added to the list at this time. This patch frees slave runtime
> in the config error path to fix the memory leak.

Applied, thanks

-- 
~Vinod
