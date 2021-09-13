Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1C174098D2
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 18:21:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231560AbhIMQW3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 12:22:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:55142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229614AbhIMQW2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 12:22:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9AE3860EE5;
        Mon, 13 Sep 2021 16:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1631550073;
        bh=1v+BzYscB7RrEgma7R6BwLGpCDKi1yPqJg+TV5c6ONA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mXXXJdHpkVSYOPfC5ndT4Pt55MxT1aDQGGD+2dG3PEUBS6HNAt+w9evrUHqYEUm90
         Ztlw08uCc9bPfMnvZ21tBMftd3LhFlWz04Lq/sasWXH4eZYx02ppdr65GHquNXyTbG
         uSqSFgb8n8AukNgBZSf9v/vrabWg3rmnluNgNqlQ=
Date:   Mon, 13 Sep 2021 18:21:05 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Martin Kaiser <martin@kaiser.cx>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/12] staging: r8188eu: power management cleanup
Message-ID: <YT96cYdbN/n5OY+S@kroah.com>
References: <20210911141521.24901-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210911141521.24901-1-martin@kaiser.cx>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 11, 2021 at 04:15:09PM +0200, Martin Kaiser wrote:
> Remove some unused parts of the power management code.
> 
> Tested with Edimax EW-7811Un V2 on an ARM32 embedded system.
> 
> Martin Kaiser (12):
>   staging: r8188eu: btcoex_rfon is always false
>   staging: r8188eu: setting HW_VAR_SET_RPWM does nothing
>   staging: r8188eu: remove write-only variable cpwm
>   staging: r8188eu: remove write-only variable tog
>   staging: r8188eu: remove rtw_set_rpwm
>   staging: r8188eu: remove unused power state defines
>   staging: r8188eu: _free_pwrlock is empty
>   staging: r8188eu: remove unused pwrctrl definitions
>   staging: r8188eu: remove unused enum and array
>   staging: r8188eu: rtw_set_ips_deny is not used
>   staging: r8188eu: remove unused variable cpwm_tog
>   staging: r8188eu: remove unused variable b_hw_radio_off

I applied a subset of these.  Please rebase and resend the reset.

thanks,

greg k-h
