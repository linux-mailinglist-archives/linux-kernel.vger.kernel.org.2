Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAFF7354BF8
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 07:09:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242507AbhDFE5H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 00:57:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:56602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229480AbhDFE5G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 00:57:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7634960FE6;
        Tue,  6 Apr 2021 04:56:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617685019;
        bh=eykr2zRjV23awTWOCrs34NVHeBS+R0SLLVT/NQ4p5mg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KMl7fCzf+avFIw8n5FkcmYURstc51T80anYnwq8M8t+W0/9e+g01HxTZ8EMIqVY1k
         Ejn/7OtPzeNJLzB5M16CGrxT+KVCfIbkz/MX1IjBp71wvL5IOqWOVnhkt1x36+C2M8
         W95NRiSnEgDOBegAPE1Rg9s1iA4nV4HONgfqVpUbg8H2+wR0bzX49foYchJOdXXgUs
         QUyDZ5eWBNKRcVmpQTKIVLQlYn8zm7TqA+yI5mHk0UcbQuBpd1YeIQ6hk1FzVccYLC
         qta1zYorfZzbAm0h7CyBFa7ao41d3omkxJVzVBEat0eFoihqavebMDyExJkktKv2XO
         2Xihgl7JUvxRQ==
Date:   Tue, 6 Apr 2021 10:26:55 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, srinivas.kandagatla@linaro.org,
        rander.wang@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        bard.liao@intel.com
Subject: Re: [PATCH v2] soundwire: intel_init: test link->cdns
Message-ID: <YGvqF43nP9OE7Y8d@vkoul-mobl.Dlink>
References: <20210406010101.11442-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210406010101.11442-1-yung-chuan.liao@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06-04-21, 09:01, Bard Liao wrote:
> intel_link_probe() could return error and dev_get_drvdata() will return
> null in such case. So we have to test link->cdns after
> link->cdns = dev_get_drvdata(&ldev->auxdev.dev);
> Otherwise, we will meet the "kernel NULL pointer dereference" error.

Applied, thanks

-- 
~Vinod
