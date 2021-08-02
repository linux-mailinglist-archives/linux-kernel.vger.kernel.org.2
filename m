Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1ECA83DCFC5
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 06:36:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231639AbhHBEgX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 00:36:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:60622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229583AbhHBEgU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 00:36:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B0DAF601FE;
        Mon,  2 Aug 2021 04:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627878971;
        bh=9ZHWpGlOFBV/7Zg50ZOEVDw/8cegyh4g0MYH7kHplw0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=noSegpfoi/SbIqHY5pF4KkTzGxIeQ06N1YzU/vtaRCVOroRynH72ZicXeBbrWguSg
         cLaDsRQnZ+Fea8UA4bdcuPfKp8jUxaKDW+FM04ev9fNmAofaGgEmuPKU3rCjsrRTXk
         20yNizq7Yl70HRUUL3oU0h1+U1fO+h+kv4e6ljHFWgLkOmwcDrSQTS4VoO4fK5Gn/L
         /+FWWmnvfvECBEA/aEvmy0x6oBMtEML4pJaMgBW5+MWvJmCLWjYvL9OctAXAYZ0OCH
         q+jLiudCEscAIYJF9uJGYasyRRcN+cV5M48ub3F3fRNKueWZ4O6ie5/3TiONAhb5NN
         tym+perWAyYpA==
Date:   Mon, 2 Aug 2021 10:06:07 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org,
        srinivas.kandagatla@linaro.org,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        bard.liao@intel.com
Subject: Re: [PATCH v2 6/6] soundwire: intel: introduce shim and alh base
Message-ID: <YQd2N5Ihu/WCjJx9@matsya>
References: <20210723115451.7245-1-yung-chuan.liao@linux.intel.com>
 <20210723115451.7245-7-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210723115451.7245-7-yung-chuan.liao@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-07-21, 19:54, Bard Liao wrote:
> shim base and alh base are platform-dependent. Adding these two
> parameters allows us to use different shim/alh base for each
> platform.

Acked-By: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
