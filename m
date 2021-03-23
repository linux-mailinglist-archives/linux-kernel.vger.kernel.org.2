Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 077713457FF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 07:51:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbhCWGui (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 02:50:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:40548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230008AbhCWGuF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 02:50:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 77B20619B6;
        Tue, 23 Mar 2021 06:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616482205;
        bh=dg3ddLYADr6YKw2HXZOwUsTND/PbCJkv3FHTduEjvhU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QCoSS159+jleeyQemzoaX7u/khOPpcdnOMgWemTHx9bFpJAhmGbFEVWjAUNaBncUK
         X87Wb1KE8aA0dsRTlEPnpcQcVy8O/KVNYojEe5FFwuiqOn2UDEUVVqD86wC6CoM73E
         iZg6/Pa7hgmRkGZMhAFcsRY13tt76S7zBuOoYsyAXOov21DivqrMeC1dzPwxZ+ToL/
         rDfUCifObsoaQipXSNNaRDvkx/gCn8UQd4Ei1jtMTqu4XepfuN/YeytiNvIRW75ZXY
         EdosRtG0HFlhBV/j9i+YAdrbNYO2LnRZvwdOJqXem/p9qKNpowiyKhZ1pVm91jyEuV
         rieHrE0P/ysGw==
Date:   Tue, 23 Mar 2021 12:20:01 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, srinivas.kandagatla@linaro.org,
        rander.wang@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        bard.liao@intel.com
Subject: Re: [PATCH 0/5] soundwire: add missing \n in dev_err()
Message-ID: <YFmPmSPQjvFiI4L2@vkoul-mobl.Dlink>
References: <20210323005855.20890-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210323005855.20890-1-yung-chuan.liao@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-03-21, 08:58, Bard Liao wrote:
> We fixed a lot of warnings in 2019 but the magic of copy-paste keeps
> adding new ones...

Applied, thanks

-- 
~Vinod
