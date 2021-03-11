Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EACB8336BB0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 06:34:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbhCKFd0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 00:33:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:37622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229777AbhCKFc7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 00:32:59 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C4F1064FC3;
        Thu, 11 Mar 2021 05:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1615440779;
        bh=tEeIsWKy6ADAqHuH3i2x/NhpCefo/U/k0RnES4MACkw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=LWeyskbck0cO7bdjAQmjbytawcsikWAFYLPs26YbMEEXFeq8jHhIoV+YGatR3UqZk
         kAzTuRVw7MxRu71E+aptqxpjINK2H3wn/fXQ2dk6yS2h9VR72VpAJ1/fRRCEFLJ6mg
         bEbpAXrH0fXkqf+xc10dKCjfsJboWrBT9uoZIlVA=
Date:   Wed, 10 Mar 2021 21:32:58 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Eric Biederman <ebiederm@xmission.com>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, Guohan Lu <lguohan@gmail.com>,
        Joe LeVeque <jolevequ@microsoft.com>
Subject: Re: [PATCH] kexec: Add kexec reboot string
Message-Id: <20210310213258.da50fe5f81086ab0147f6167@linux-foundation.org>
In-Reply-To: <20210304124626.13927-1-pmenzel@molgen.mpg.de>
References: <20210304124626.13927-1-pmenzel@molgen.mpg.de>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  4 Mar 2021 13:46:26 +0100 Paul Menzel <pmenzel@molgen.mpg.de> wrote:

> From: Joe LeVeque <jolevequ@microsoft.com>
> 
> The purpose is to notify the kernel module for fast reboot.
> 
> Upstream a patch from the SONiC network operating system [1].
> 
> [1]: https://github.com/Azure/sonic-linux-kernel/pull/46
> 
> Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>

We should have Joe's signed-off-by: for this.  Joe, can you please send
it?

