Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B77A456A57
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 07:38:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231751AbhKSGlh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 01:41:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:60662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229457AbhKSGlg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 01:41:36 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A8B4A61101;
        Fri, 19 Nov 2021 06:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1637303915;
        bh=+ETw7Xi0OwIuaRxNGm3Y/jlhPTldMlIj9OAAr37LegU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h4/kVnNmukiRnneGq6Ci2GQ9TDmBrlAo+O5C3Bc75rHwKZZ5lXB8gaHNP9HurxEwe
         RExlCEeg5t5ZibFWYZ3mRQYYakelrL6A3ABI2g/MgGKvs5NjtvOHQ+dSTfqoM37CGL
         FWVkDMUHtS9dSS/kNu2BIJ3NC0b9aQIPitKA/Vlo=
Date:   Fri, 19 Nov 2021 07:38:32 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Alberto Merciai <alb3rt0.m3rciai@gmail.com>
Cc:     devel@driverdev.osuosl.org, forest@alittletooquiet.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] staging: vt6655: refactor camelcase uCurrRSSI to
 current_rssi
Message-ID: <YZdGaAVSVM8/4ZB2@kroah.com>
References: <20211118202718.GA152832@t470p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211118202718.GA152832@t470p>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 18, 2021 at 09:27:18PM +0100, Alberto Merciai wrote:
> Replace camelcase variable "uCurrRSSI" (current Received Signal Strength
> Indicator) into linux kernel coding style equivalent
> variable "current_rssi".
> 
> Signed-off-by: Alberto Merciai <alb3rt0.m3rciai@gmail.com>
> ---
> 
> v2
> - correct mailing list

No, you did not use the correct mailing list.

What is the output of scripts/get_maintainer.pl on your patch?

thanks,

greg k-h
