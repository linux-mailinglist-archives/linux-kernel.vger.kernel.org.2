Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 342B4387464
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 10:50:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347590AbhERIu0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 04:50:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:58714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347585AbhERIuX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 04:50:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5D9D56100A;
        Tue, 18 May 2021 08:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621327745;
        bh=9j086S06Khr9M+4Gb0l7IraBiUnmuGNVPHo84lmxyII=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kWsTjuP4DMrsfJl/E9IvAZlAVq1v4BR6l/VAFcDv4cZy1vSm0hw071yXD8NrBmDVg
         wqOW9sxrs5+myMw0Zi+0ORGjzkCvh3PTe9pTCjVVshS9vfrqHJhCbWuT0++f2KSaz2
         u7Vx9EIQaG5RUh+YJTBfEuOu87yyvShwbuSA1WKByLJBKSMPLvJYg9vLC9CQXTZ4dZ
         I24REZx9yU7hnJAecQ/nNXYcHaKR+GTvKS6IE7PnYGGE8ci1pPKPXoAtgfmz97tt9C
         oXELz2A1rtKTnN3C3rZM+YlWeVW+C3EmL1CqLPuu32eJoQM1pTA801m3s0hyYsANfu
         TCmavkJ3t4S8w==
Date:   Tue, 18 May 2021 09:49:01 +0100
From:   Will Deacon <will@kernel.org>
To:     John Stultz <john.stultz@linaro.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        YongQin Liu <yongqin.liu@linaro.org>,
        Amit Pundir <amit.pundir@linaro.org>
Subject: Re: REGRESSION: kernel BUG at arch/arm64/kernel/alternative.c:157!
Message-ID: <20210518084900.GA7412@willie-the-truck>
References: <CANcMJZDOMZVj6WVEe+7b--Rwkdg1-WVFfHkVm4KR-ykS4LxQFQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANcMJZDOMZVj6WVEe+7b--Rwkdg1-WVFfHkVm4KR-ykS4LxQFQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

On Mon, May 17, 2021 at 02:52:59PM -0700, John Stultz wrote:
> With v5.13-rc2, I've been seeing an odd boot regression with the
> DragonBoard 845c:
> 
> Unfortunately, trying to bisect it down (v5.13-rc1 works ok) is giving
> me inconsistent results so far. It feels a bit like maybe some config
> option gets enabled moving forward, and then sticks around when we go
> back.  I'll take another swing at bisecting it later today, but I have
> to move on to some other work right now, so I figured I'd share (with
> folks who better know the recent __apply_alternatives changes) in case
> folks have a better idea:

Please can you try reverting af44068c581c and 0c6c2d3615ef?

Thanks,

Will
