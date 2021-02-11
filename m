Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F49B3187B5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 11:05:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbhBKKE3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 05:04:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:48282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230014AbhBKKBB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 05:01:01 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id CBA3064E95;
        Thu, 11 Feb 2021 10:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1613037621;
        bh=jLVPIT2Tb0aqIZLErCoySxXU9jKdMCQPZI74l/yB11M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kTEj0WSbvgoVRPTVqdgPpMhypgO6vXabbGifC4nz3VgbAanXm9oV5LZLIyUjWzT97
         WsOTf5vbxhSRNrgu23K/VFO4ZjobRCPezUxDqVPvUwRYSr6m1NdvS1Bp1CU5pjaoLa
         923LSWqv+k5JxRLEriDzZfjNzboBiRDS4xcvUnAY=
Date:   Thu, 11 Feb 2021 11:00:18 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Hemansh Agnihotri <hemanshagnihotri27@gmail.com>
Cc:     johan@kernel.org, elder@kernel.org, devel@driverdev.osuosl.org,
        greybus-dev@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] staging: greybus: Added do - while in multi
 statement macro
Message-ID: <YCUAMgFa6i9vl9An@kroah.com>
References: <20210211095444.54447-1-hemanshagnihotri27@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210211095444.54447-1-hemanshagnihotri27@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 11, 2021 at 03:24:44PM +0530, Hemansh Agnihotri wrote:
> This patch add fixes an checkpatch error for "Macros with multiple statements
> should be enclosed in a do - while loop"
> 
> Signed-off-by: Hemansh Agnihotri <hemanshagnihotri27@gmail.com>

Any reason you didn't test-build your patch before sending it out?

That's a bit rude to reviewers :(

Please always do that.

thanks,

greg k-h
