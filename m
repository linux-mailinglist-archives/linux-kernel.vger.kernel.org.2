Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A67A430F723
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 17:04:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237734AbhBDQCs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 11:02:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:39146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237359AbhBDQCO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 11:02:14 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3A19A64F51;
        Thu,  4 Feb 2021 16:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1612454493;
        bh=Dg50UZlwmBpnd9bKARX2LhHURLZvFWZMz3YQOL3h6VU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QIfm1bGCWpAOEVZ3HXfj/q4RkX00S2IG5cQFuioLOpaVJB/C252UEbuGDqORhy5Nk
         kzjgZYFqIJadzO1yJ2LzVvemE2P9p6+07ZmYGUV2hQxqVMDN1iYnAIuw0Zkof5vbLV
         jU/RqLUblgj+r2zD9Vr+XNsDZ8RgkUg8lTUgqJXw=
Date:   Thu, 4 Feb 2021 17:01:11 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/31] coresight: Patches for v5.12
Message-ID: <YBwaRwDNMDt7kNJb@kroah.com>
References: <20210201181351.1475223-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210201181351.1475223-1-mathieu.poirier@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 01, 2021 at 11:13:20AM -0700, Mathieu Poirier wrote:
> Good day Greg,
> 
> Please consider the following patches for inclusion in the coming v5.12 cycle.
> 
> Note that patches 11, 13 and 14 make checkpatch angry over the lack of 
> parentheses when defining complex macros but looking at the code I really don't
> see how else it could be done. 

Now queued up, thanks.

greg k-h
