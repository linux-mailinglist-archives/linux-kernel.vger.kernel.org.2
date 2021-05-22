Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C887738D4C2
	for <lists+linux-kernel@lfdr.de>; Sat, 22 May 2021 11:26:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbhEVJ2U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 May 2021 05:28:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:48356 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230137AbhEVJ2R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 May 2021 05:28:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 81EE561090;
        Sat, 22 May 2021 09:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1621675613;
        bh=aQAR0Z09kZdoFhigfeEe2x7py2pznctlRs5s0ni7rNc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K7GbLNORGpuqK4qWlDz6laompMVTHbiTjvCAe385F5iPeytRPS/trYpp6Qz2UYd8s
         sqlYRZNXg400R+flvyLeii6CcvdUDTf1faRvrAWZzG1Va+o7Qn2hCen7k+uJ0UevP3
         K9XUrtA/fiTAecXLpTDlmWTwLw9NO1qvq2ynUGCU=
Date:   Sat, 22 May 2021 11:26:50 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Shreyansh Chouhan <chouhan.shreyansh630@gmail.com>
Cc:     fabioaiuto83@gmail.com, ross.schm.dev@gmail.com,
        straube.linux@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [Resend] [PATCH 1/2] [RFC] staging: rtl8723bs: refactor to
 reduce indents
Message-ID: <YKjOWtwarhM99dXc@kroah.com>
References: <20210522092024.65018-1-chouhan.shreyansh630@gmail.com>
 <20210522092024.65018-2-chouhan.shreyansh630@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210522092024.65018-2-chouhan.shreyansh630@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 22, 2021 at 02:50:23PM +0530, Shreyansh Chouhan wrote:
> Reduce the number of indents in rtw_wlan_util.c file by refactoring the
> code.
> 
> Moved the part of code that rearranged ac paramaters in the function
> WMMOnAssocResp to a separate function named sort_wmm_ac_params. It takes
> both the array of ac params and their indexes as arguments and sorts them.
> Has return type void.
> 
> Moved the part of code that checked for the realtek vendor in the
> function check_assoc_AP to a separate function named
> get_realtek_assoc_AP_vender. It takes a pointer to struct
> ndis_80211_var_ie as an argument and returns a u32 realtek vendor.
> 
> Signed-off-by: Shreyansh Chouhan <chouhan.shreyansh630@gmail.com>
> ---
>  .../staging/rtl8723bs/core/rtw_wlan_util.c    | 108 +++++++++---------
>  1 file changed, 56 insertions(+), 52 deletions(-)

Why is [RFC] in the subject line?  Do you not want these merged?

confused,

greg k-h
