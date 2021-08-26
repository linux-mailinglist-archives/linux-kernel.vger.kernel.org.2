Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61B6A3F85B4
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 12:40:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241790AbhHZKlc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 06:41:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:50160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241773AbhHZKlb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 06:41:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6F5A56108F;
        Thu, 26 Aug 2021 10:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1629974444;
        bh=2Ah456Plr9zifQ0qZ4JwbKGlX4FIbWfxT1v2f+zEnn4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=psJ+mQsYVpSZLZuD5I08ecJ3I8+ZY56QgL+FVqhA8eVphTYbkgigT6lNNzFAqnelD
         ihu81bFjm/sCKrDhkw46jbL3OR75aOetJx0iNALJn7y55/GxvdYg0KMZq2FNCM5nJg
         pN0hK/InoPsv+oERnH1GeWHN9Xpc/9584oNQTFH8=
Date:   Thu, 26 Aug 2021 12:40:39 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Pavel Skripkin <paskripkin@gmail.com>
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        straube.linux@gmail.com, fmdefrancesco@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/6] staging: r8188eu: remove {read,write}_macreg
Message-ID: <YSdvp5IUYY+QLs/D@kroah.com>
References: <cover.1629789580.git.paskripkin@gmail.com>
 <d591e29d77da73790c71f7a8e508a8b16fd48f65.1629789580.git.paskripkin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d591e29d77da73790c71f7a8e508a8b16fd48f65.1629789580.git.paskripkin@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 24, 2021 at 10:27:13AM +0300, Pavel Skripkin wrote:
> These 2 functions are unused, so they can be simply removed
> 
> Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
> ---
>  drivers/staging/r8188eu/core/rtw_mp.c    | 39 ------------------------
>  drivers/staging/r8188eu/include/rtw_mp.h |  2 --
>  2 files changed, 41 deletions(-)

I took this one patch of this series, please redo the rest of them and
resend.

thanks,

greg k-h
