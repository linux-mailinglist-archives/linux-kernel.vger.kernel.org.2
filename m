Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1720039FE26
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 19:49:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233913AbhFHRvC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 13:51:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:39858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233572AbhFHRvB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 13:51:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C7515610E5;
        Tue,  8 Jun 2021 17:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1623174535;
        bh=q5Dx0JDXq9/j+AGGBSpGkx5DEZffs1kj/k6l+5w8O5E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ner4N5/ylhJNSB9p3aaOcZa1++rE8KRsAt41dQcxNgM4N5ekLkIMF4O4eB85z00/2
         Sn7jS2yn4hrSTlWATcxj2jRSWSQdLzVIpMftKIoGr1CYjavBpoTz1nouMvPMB0W+Ez
         mGVJtgyiO0OULKnmRXf8666IdjmbV9G9RQ9chiaY=
Date:   Tue, 8 Jun 2021 19:48:52 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     rojay@codeaurora.org, swboyd@chromium.org, wsa@kernel.org,
        stable-commits@vger.kernel.org
Subject: Re: Patch "i2c: qcom-geni: Suspend and resume the bus during
 SYSTEM_SLEEP_PM ops" has been added to the 4.19-stable tree
Message-ID: <YL+thORoMdRRf/A5@kroah.com>
References: <1623174038205253@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1623174038205253@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 08, 2021 at 07:40:38PM +0200, gregkh@linuxfoundation.org wrote:
> 
> This is a note to let you know that I've just added the patch titled
> 
>     i2c: qcom-geni: Suspend and resume the bus during SYSTEM_SLEEP_PM ops
> 
> to the 4.19-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      i2c-qcom-geni-suspend-and-resume-the-bus-during-system_sleep_pm-ops.patch
> and it can be found in the queue-4.19 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.

Breaks the build here, now dropped.
