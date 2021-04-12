Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CAB335B9B8
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 07:05:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230062AbhDLFFn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 01:05:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:36590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229482AbhDLFFm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 01:05:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7A9A76109E;
        Mon, 12 Apr 2021 05:05:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618203925;
        bh=JEZDcPyp6ZxHZbYo8YgMJjcLTmNNKgrcuE5xLYPWZgk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NMb1SsLVPPrxaRoFXrp6ot5A08DjwJrmaFq9WOuF66ZlAVzOKJ592EgQSTdr6e/Ce
         hUXafYaVvmO7uFPdhTPWBp6MYXc+4qog5T3Wgx01LMZK5BLLVDyao2R/2AxdTTpfJ0
         jdTGVb9LgzRtHJy5PTHEES/ikWSDjfSx3j04fD+3z8nfmtS5C71C1FyIt7/8129OTg
         UwC2hJXFHdsSSVYXCifyB0O8KN6urg9NoBWInG4JdqVgehA6eeeNYYP7Gz978uC+WB
         TBSw0v2YTEzLjpou6C7PR7+3LTIyDppjEnEyzd4WKPJkTU49yzxfakgaEUaVtvOhwX
         4VVlRPC5p3VLQ==
Date:   Mon, 12 Apr 2021 10:35:20 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        kishon@ti.com
Subject: Re: [PATCH -next] phy: phy-twl4030-usb: Fix possible use-after-free
 in twl4030_usb_remove()
Message-ID: <YHPVEFTCMrWCARRw@vkoul-mobl.Dlink>
References: <20210407092716.3270248-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210407092716.3270248-1-yangyingliang@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07-04-21, 17:27, Yang Yingliang wrote:
> This driver's remove path calls cancel_delayed_work(). However, that
> function does not wait until the work function finishes. This means
> that the callback function may still be running after the driver's
> remove function has finished, which would result in a use-after-free.
> 
> Fix by calling cancel_delayed_work_sync(), which ensures that
> the work is properly cancelled, no longer running, and unable
> to re-schedule itself.

Applied, thanks

-- 
~Vinod
