Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB1D4368FFC
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 12:02:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241962AbhDWKCz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 06:02:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:43114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241950AbhDWKCy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 06:02:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 46FEC613D5;
        Fri, 23 Apr 2021 10:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619172138;
        bh=Atm2RSl1zOSBf0w7r+F7tka/tiajyaeJj79Yy8aLB/k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=v08p5z18mC1EQgkwvifjSGk6rfEegumTbZ44n7NkRVeIeif+Nc/4hv6ayxsGctcyu
         7U+oQNRwisV1ocW+YtUMAmBbeeafWQ8aC45cgJBHAIFZURSRAceqXyvH2bMkQinXLj
         WC84wMrxpsicXq49c0KFpQPE8Xm/BqvQ/vWZBF1k=
Date:   Fri, 23 Apr 2021 12:02:15 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Tao Zhang <taozha@codeaurora.org>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Tingwei Zhang <tingwei@codeaurora.org>,
        Mao Jinlong <jinlmao@codeaurora.org>,
        Yuanfang Zhang <zhangyuanfang@codeaurora.org>
Subject: Re: [PATCH v1] coresight: add node to reset all coresight devices
Message-ID: <YIKbJ/WafuFnqGvr@kroah.com>
References: <1619166578-28690-1-git-send-email-taozha@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1619166578-28690-1-git-send-email-taozha@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 23, 2021 at 04:29:38PM +0800, Tao Zhang wrote:
> Add new reset_source_sink node to be able to disable all active
> coresight devices.
> In this way, we no longer need to manually disable all active
> coresight devices one by one. After enabling multiple coresight
> paths, users can reset their status more conveniently by this
> node.
> 
> This patch base on coresight-next repo
> http://git.linaro.org/kernel/coresight.git/log/?h=next
> 
> And this patch depends on the following patch
> https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg2551216.html
> 
> Signed-off-by: Tingwei Zhang <tingwei@codeaurora.org>
> Signed-off-by: Mao Jinlong <jinlmao@codeaurora.org>
> Signed-off-by: Tao Zhang <taozha@codeaurora.org>
> ---
>  drivers/hwtracing/coresight/coresight-core.c | 72 ++++++++++++++++++++++++----
>  1 file changed, 64 insertions(+), 8 deletions(-)

You added new sysfs files with no new Documentation/ABI entries, so we
have no idea how to review this code to determine if it does what you
want it to do :(

thanks,

greg k-h
