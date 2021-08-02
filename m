Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4F963DCFC4
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 06:36:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231436AbhHBEgH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 00:36:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:60444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230423AbhHBEgG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 00:36:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C4602601FE;
        Mon,  2 Aug 2021 04:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627878957;
        bh=SgNNxqoN0R+IJq58I42KXc1cu7KooyADDnnuUWV4/SI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MoAKPx7+08nU3QMhm8eZon6nCGbySXrA12filjWyl4TEV44A3XamfG0ZgfuA4NHSl
         WnhMmUm5IQCiPVsB7+8xjMPzoyIpNnQQd8aPfV21mNrvl1uFPCsRom8pUSuTKfhSiY
         G8uNmsNoI7uLg7TPwNhK76Y2BdjfoIGhglLJ18hW0Z2IgZlJe8QPUEos+muQqGtVZ+
         w80tYRKvsFLEx/v7qCu1WBNDtPlpol0iKJzMcBzKyGy6Oa0Czr1SAFF3awrrtAGxCb
         15D0oKXEwJ1CzPBImIA4BApcQc8TRa5FymLjBRBMdJlIf6o2yZlxKCN3/F9usitlYW
         fGygHd0EEClCA==
Date:   Mon, 2 Aug 2021 10:05:53 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org,
        srinivas.kandagatla@linaro.org,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        bard.liao@intel.com
Subject: Re: [PATCH v2 1/6] soundwire: move intel sdw register definitions to
 sdw_intel.h
Message-ID: <YQd2KSaFkIQqx+F7@matsya>
References: <20210723115451.7245-1-yung-chuan.liao@linux.intel.com>
 <20210723115451.7245-2-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210723115451.7245-2-yung-chuan.liao@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-07-21, 19:54, Bard Liao wrote:
> Those Intel sdw registers will be used by ASoC SOF drivers in the
> following commits. So move those definitions to sdw_intel.h and it can
> be visible to SOF drivers.

Acked-By: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
