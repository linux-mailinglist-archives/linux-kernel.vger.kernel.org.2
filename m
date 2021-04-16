Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F21D3361B78
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 10:34:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239363AbhDPILy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 04:11:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:57602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238743AbhDPILw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 04:11:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5C7046113D;
        Fri, 16 Apr 2021 08:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1618560688;
        bh=cgPieXTTqwGlyiVE41tmEiN77r8JA/Z1/31L1HgD1sM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DygyKHDPSyTM1z2NveXS86FTeQUldHTKITxx8IGyHmn5SlLHdx7LsesTHlLUFuW4U
         elrtxTnIdtdokb0CJhnZuE9Ao+PwtcWFXiQzjPN83ayq+Wt45tS9QTtu6WXFPujqCN
         lWHSL2O6h9veGe7zNn33w+kSpQRMiDzXYuxo7nkA=
Date:   Fri, 16 Apr 2021 10:11:25 +0200
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
Subject: Re: [PATCH 0/2] *** SUBJECT HERE ***
Message-ID: <YHlGrcghXrwe2RKm@kroah.com>
References: <1618560476-28908-1-git-send-email-taozha@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1618560476-28908-1-git-send-email-taozha@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 16, 2021 at 04:07:54PM +0800, Tao Zhang wrote:
> *** BLURB HERE ***

Where is the blurb?

And your subject is not ok :(

