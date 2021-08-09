Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D1A23E435B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 11:55:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233569AbhHIJzx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 05:55:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233309AbhHIJzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 05:55:51 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE430C0613D3
        for <linux-kernel@vger.kernel.org>; Mon,  9 Aug 2021 02:55:31 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id t7-20020a17090a5d87b029017807007f23so30382081pji.5
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 02:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=njx7c6+9wwA5X4lpJAmyr5NBuDZKm/2/00nAyGm9k3c=;
        b=A6HsFJTtWkUFXXd4aLs1v0S4FAaWZ6FzJBH/6lqJy06Wopt1mFdbBSMXJtzJqTR8PB
         BHAsY13ADf4bd6erQ6Gp0bYhRVC0eaDV+2RRW83GRuNl1qEGEZnWHMI22SoXewA23WXG
         +ipT1jQ8aD7+dAJe2SS6kAW8FTxLH1AovNzz2G0Jcf0viG7WS2uOj4DIqiIjWdudmL/l
         7CNQ0q1aFU12N6lL7qQ6yndyJOw7lwwc45suUG7A7ZAWzTjJu9u8mTtQBjeW2usP8Ot5
         KGVod/uc7JxyyPTv+qP2SREFlBpCZh7a7MoZALGqUrnHd/sGqqhVQiWRmySqbWRV94XW
         y8mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=njx7c6+9wwA5X4lpJAmyr5NBuDZKm/2/00nAyGm9k3c=;
        b=gViv1QyhNod++adOh1QMmZfyG00RmxeKkqNN5JkdrWHsW2ImcJKwgi1ixIyPysC8lZ
         3wFSFIYVNfxOYGCtmg56L0RHAlYYc3X3nNNfsiLFTriRpksf+g+/B+0RuXk9rI/lGFek
         tL3XJkTTwwmz0dri2BCdYz8vIiLs3UgKcq1rrXoYsZNWxrfvtIk7jLTpF3U7nUJN0OSw
         4Xt+E3qaaZC8EGHySMRx1IMVMV+b5RAmoEfucfwBnt4MbCs0DqbZ+64k9dJqkftdk76d
         ofrCSEPrlaKWGeDLnr6xaBAWyCSaecX1e3eQkxHRK3BmuSqwAtNrDrHYeQhHICrmvWDm
         oeOw==
X-Gm-Message-State: AOAM5329pV75NV1D11NzXAbTQqGveDZs4praHKynXwbo+y8qBD1/Vasy
        NJKG+YXwqRvUump4aO2G9WKo
X-Google-Smtp-Source: ABdhPJzkchZ9TKCH/nJ58d9SDnhGhAbgyFy3EDYXD4WWzkELI2NvyiPzAdxMJGpUETw3oBycIuLFGQ==
X-Received: by 2002:a17:90a:9747:: with SMTP id i7mr24897101pjw.141.1628502931254;
        Mon, 09 Aug 2021 02:55:31 -0700 (PDT)
Received: from workstation ([120.138.12.137])
        by smtp.gmail.com with ESMTPSA id p190sm20015973pfb.4.2021.08.09.02.55.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Aug 2021 02:55:30 -0700 (PDT)
Date:   Mon, 9 Aug 2021 15:25:27 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Greg KH <greg@kroah.com>, Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the mhi tree
Message-ID: <20210809095527.GA13990@workstation>
References: <20210809193837.373a9f68@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210809193837.373a9f68@canb.auug.org.au>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On Mon, Aug 09, 2021 at 07:38:37PM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the mhi tree, today's linux-next build (x86_64 allmodconfig)
> failed like this:
> 
> drivers/bus/mhi/pci_generic.c:406:40: error: redefinition of 'mhi_mv31_channels'
>   406 | static const struct mhi_channel_config mhi_mv31_channels[] = {
>       |                                        ^~~~~~~~~~~~~~~~~
> drivers/bus/mhi/pci_generic.c:372:40: note: previous definition of 'mhi_mv31_channels' was here
>   372 | static const struct mhi_channel_config mhi_mv31_channels[] = {
>       |                                        ^~~~~~~~~~~~~~~~~
> drivers/bus/mhi/pci_generic.c:417:32: error: redefinition of 'mhi_mv31_events'
>   417 | static struct mhi_event_config mhi_mv31_events[] = {
>       |                                ^~~~~~~~~~~~~~~
> drivers/bus/mhi/pci_generic.c:383:32: note: previous definition of 'mhi_mv31_events' was here
>   383 | static struct mhi_event_config mhi_mv31_events[] = {
>       |                                ^~~~~~~~~~~~~~~
> drivers/bus/mhi/pci_generic.c:424:43: error: redefinition of 'modem_mv31_config'
>   424 | static const struct mhi_controller_config modem_mv31_config = {
>       |                                           ^~~~~~~~~~~~~~~~~
> drivers/bus/mhi/pci_generic.c:390:43: note: previous definition of 'modem_mv31_config' was here
>   390 | static const struct mhi_controller_config modem_mv31_config = {
>       |                                           ^~~~~~~~~~~~~~~~~
> drivers/bus/mhi/pci_generic.c:433:38: error: redefinition of 'mhi_mv31_info'
>   433 | static const struct mhi_pci_dev_info mhi_mv31_info = {
>       |                                      ^~~~~~~~~~~~~
> drivers/bus/mhi/pci_generic.c:399:38: note: previous definition of 'mhi_mv31_info' was here
>   399 | static const struct mhi_pci_dev_info mhi_mv31_info = {
>       |                                      ^~~~~~~~~~~~~
> 
> Caused by an newer version (but almost identical) of all the mhi tree
> commits are also now in the char-misc tree (almos identical patches,
> but different commits.
> 

That's due to sending the patches as a series to Greg instead of pull
request.

> I have dropped the mhi tree for today (please clean it up).
> 

Done!

Thanks,
Mani

> -- 
> Cheers,
> Stephen Rothwell


