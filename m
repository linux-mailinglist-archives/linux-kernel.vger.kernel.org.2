Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44A26311C97
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 11:28:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbhBFK1e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Feb 2021 05:27:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:40926 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229508AbhBFK1a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Feb 2021 05:27:30 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9CF7B64E30;
        Sat,  6 Feb 2021 10:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612607209;
        bh=T+7tJ8N28DhBC0FiHzy9b548DcuDktyP9XhUL1tWkYo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J/XcP4g/U9mFvg324pexE9yyBaNcn+AX0V2hEa3UcbfSPCsvgmyH5xCpDu3nut+hL
         d4Zp9fhtqx1ieRP2AH7g7A/v1/cxfNckyq9cjYV1mP8Prq1wqAlC3TcRsuWXGmVMNe
         c9bStB+KS3ukTrm7U0BB9RqTkBWpd8LOgSNU/7cFvaAAv25Hbt6LbdhWtNpLf4nBhS
         pJNcISwFvMIso4J5IFFc2P8z6t8qiOF3gmDlGgIMUtyhHc/QEt76DXj6B0VCjRYS4E
         0s3m+s++d9o/TJ9219EpOE2KoTfEqVtCTnZ2OWhjoZkqsvodF/hQ0WSB4nKaKf+PZt
         h6Pdkz7nsSuag==
Date:   Sat, 6 Feb 2021 15:56:44 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org,
        jank@cadence.com, srinivas.kandagatla@linaro.org,
        rander.wang@linux.intel.com, ranjani.sridharan@linux.intel.com,
        hui.wang@canonical.com, pierre-louis.bossart@linux.intel.com,
        sanyog.r.kale@intel.com, bard.liao@intel.com
Subject: Re: [RESEND PATCH v2 0/9] soundwire/regmap: use _no_pm routines
Message-ID: <20210206102644.GN2656@vkoul-mobl.Dlink>
References: <20210122070634.12825-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210122070634.12825-1-yung-chuan.liao@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-01-21, 15:06, Bard Liao wrote:
> When a Slave device is resumed, it may resume the bus and restart the
> enumeration. And Slave drivers will wait for initialization_complete
> complete in their resume function, however initialization_complete will
> complete after sdw_update_slave_status function is finished and codec
> driver usually call some IO functions in the update_status callback
> function.
> It will become a deadlock if we use regular read/write routines during
> the resuming process.

Applied all sdw patches, thanks
-- 
~Vinod
