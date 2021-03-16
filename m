Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7590733D465
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 13:55:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234394AbhCPMzH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 08:55:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:60332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233712AbhCPMvZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 08:51:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0F95365036;
        Tue, 16 Mar 2021 12:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1615899084;
        bh=gmxqoMt9J/BIXwHRDd8I4NBJ+PNnpfBABT0cNtOxOts=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NXl07EQioB4L+TaHyK4BhsKl3P2qBs5amJmsJyvwrw8RfOFJ38O9A7BCdMHVQVYTH
         5Vx0o8MZ6wjNmsxog7kMUzhbK73KdxkmvfVo3TwK9k2AlRb4NS8rdmLQlEDVVGKJhw
         IHmo4I9mA89ClYgfpCmwh78V/oHkv51iiiEs9qdc=
Date:   Tue, 16 Mar 2021 12:43:15 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Fabio Aiuto <fabioaiuto83@gmail.com>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/15] staging: rtl8723bs: remove unused code blocks
Message-ID: <YFCZ04cYWwDUuwsi@kroah.com>
References: <cover.1615801721.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1615801721.git.fabioaiuto83@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 15, 2021 at 11:13:49AM +0100, Fabio Aiuto wrote:
> Remove unused code blocks as required in TODO file
> 
> Fabio Aiuto (15):
>   staging: rtl8723bs: remove unused code blocks conditioned by never set
>     CONFIG_AUTO_AP_MODE
>   staging: rtl8723bs: remove unused code blocks conditioned by never set
>     CONFIG_HW_PWRP_DETECTION
>   staging: rtl8723bs: remove unused code blocks conditioned by never set
>     CONFIG_QOS_OPTIMIZATION
>   staging: rtl8723bs: remove unused code blocks conditioned by never set
>     CONFIG_AP_WOWLAN
>   staging: rtl8723bs: remove unused code blocks conditioned by never set
>     CONFIG_PM
>   staging: rtl8723bs: remove unused code blocks conditioned by never set
>     CONFIG_SIGNAL_DISPLAY_DBM
>   staging: rtl8723bs: remove unused code blocks conditioned by never set
>     CONFIG_BACKGROUND_NOISE_MONITOR
>   staging: rtl8723bs: remove unused code blocks conditioned by never set
>     CONFIG_SKIP_SIGNAL_SCALE_MAPPING
>   staging: rtl8723bs: remove unused code blocks conditioned by never set
>     CONFIG_GPIO_API
>   staging: rtl8723bs: remove unused code blocks conditioned by never set
>     CONFIG_EXT_CLK
>   staging: rtl8723bs: remove unused code blocks conditioned by never set
>     CONFIG_CHECK_BT_HANG
>   staging: rtl8723bs: remove unused code blocks conditioned by never set
>     CONFIG_SDIO_TX_TASKLET
>   staging: rtl8723bs: remove unused code blocks conditioned by never set
>     CONFIG_SW_CHANNEL_PLAN
>   staging: rtl8723bs: remove unused code blocks conditioned by never set
>     CONFIG_C2H_PACKET_EN
>   staging: rtl8723bs: remove unused code blocks conditioned by never set
>     CONFIG_ODM_ADAPTIVITY

Not all of these would apply, please rebase and resend the remaining
ones.

thanks,

greg k-h
