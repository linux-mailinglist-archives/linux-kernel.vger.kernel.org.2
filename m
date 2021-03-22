Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B178344065
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 13:04:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbhCVMD7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 08:03:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:46980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230273AbhCVMD3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 08:03:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 32F1761998;
        Mon, 22 Mar 2021 12:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616414609;
        bh=mwKIvD3m2a8udoDntSattWkpAVmBGFOPr8WfGq95e5w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TsCHUKqbad1Wh33Bea4g9m/NbKCxtd0quqqHcu+kxT+7QvQ3dHmQ8Ut0hWZKV0V5U
         zwhVGlyg2LmKZzFmMwgYNeSy1gzQ+BGxQrIdeDMGMrrEogIujd39vg18ABIiduyh96
         /LyoBX/DHB+ihdsJOF+kmqERg1HFARqqoKBLj+otOdGwT3Rx8BjhCxL/BDMBDVVAwo
         qxV3aWJr8toqzRFfEvNH2cWL9N67BL+2hv467A4hHpe0RjI3yJxVGrbKgH0lVPq+ig
         h9BApB998sTSVGnQM+9hJYqca/hvcEFAwDoNSmGcl4Z8jtvmxc49NCj31XbjWoA0Si
         uhu4mYL/P88XA==
Date:   Mon, 22 Mar 2021 17:33:24 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, srinivas.kandagatla@linaro.org,
        rander.wang@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        bard.liao@intel.com
Subject: Re: [PATCH v2 0/3] soundwire: add DMI quirks for overridind addr
Message-ID: <YFiHjPawbh8dId7h@vkoul-mobl.Dlink>
References: <20210302075105.11515-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210302075105.11515-1-yung-chuan.liao@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02-03-21, 15:51, Bard Liao wrote:
> Platform firmware may have incorrect _ADR values causing the driver
> probes to fail. Adding the override_ops allows people to override the
> addr values.

Applied, thanks

-- 
~Vinod
