Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BAC63440A2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 13:17:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbhCVMQf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 08:16:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:49226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230317AbhCVMQU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 08:16:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 176236196F;
        Mon, 22 Mar 2021 12:16:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616415380;
        bh=MR2f7IFBl4DUtgnudwNrV4yKMxynGWswKdUshB9QITo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=arf85JXDRHi2ZY97VnXS3DFQQFASj63KYpaP7eLwJlvlJUgywKlzWF5iTbo4rVUTK
         cXyfqrsO2ex53T++rcwzgt6uNcsF4fvZ89fXnlFcgMStjPSuEWsXasZFL15JpdS7DL
         mQlFGiDm3EDoUhUwlxSP3wj9eSdS+pofJe/vSFxI+uK6F5UK64EgpHizvrCB8uNrtC
         9Oz7OVPMlrdR5XExJF78j3nTrdLn/bx/HtiBewznsl/QYlcb52lsN5SKN4nyN/JuDy
         wO2ogPxoa2DqzzQHCfKJDseFaInEwJ5Hj7UrM681/zhM2q5QxpCRIxXoEhDEQxucxq
         4KRtx8Jj8IWCw==
Date:   Mon, 22 Mar 2021 17:46:15 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     yung-chuan.liao@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Re: [RESEND PATCH v2] soundwire: bus: Fix device found flag correctly
Message-ID: <YFiKjzAjqrU44TlM@vkoul-mobl.Dlink>
References: <20210309104816.20350-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210309104816.20350-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09-03-21, 10:48, Srinivas Kandagatla wrote:
> found flag is used to indicate SoundWire devices that are
> both enumerated on the bus and available in the device list.
> However this flag is not reset correctly after one iteration,
> This could miss some of the devices that are enumerated on the
> bus but not in device list. So reset this correctly to fix this issue!

Applied, thanks

-- 
~Vinod
