Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 237D9310917
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 11:31:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231303AbhBEKbA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 05:31:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:57342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231391AbhBEK1F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 05:27:05 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7CEE464E58;
        Fri,  5 Feb 2021 10:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1612520784;
        bh=CcDQz8EChwGz7WQdl4Z4qmJ5q8OPou+bsuoH1+tBZH8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G2JVCjd39ZPkqH3YGgX01yJ9irhMo7YBEGshEl5A6Htsp6eWq/rSqapWeweUJocCb
         A7e92+T2HOGvyHoLN52BgjiVW5sVAKw3iu0P//AGmNltksvirqyR9sfOIgYXKAVVjC
         3aIs1t9WMS+rEfzQ+rNWOWRu/B/X42sMK0g1JLUk=
Date:   Fri, 5 Feb 2021 11:26:18 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] nvmem: patches (set 2) for 5.12
Message-ID: <YB0dSsZwzeP3nZIC@kroah.com>
References: <20210205100853.32372-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210205100853.32372-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 05, 2021 at 10:08:51AM +0000, Srinivas Kandagatla wrote:
> Hi Greg,
> 
> Here are some last nvmem patches (set 2) for 5.12 which includes
> - fixing a typo in Kconfig
> - a fix of uninitialized pointer
> 
> If its not too late, Can you please queue them up for 5.12.

Now merged, thanks!

greg k-h
