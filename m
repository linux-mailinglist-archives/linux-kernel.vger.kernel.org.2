Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 149C532CDAE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 08:37:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232076AbhCDHf0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 02:35:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:45676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231709AbhCDHfT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 02:35:19 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id BB12E64EF9;
        Thu,  4 Mar 2021 07:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1614843279;
        bh=j0dbx+0okJq+o2vUZD0eF1jb60cNwMTE6NIC90Fk4kE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VN6kfBkWJoxqUZB+7aH2qaLW6ln73YSAXAdae7tOCcIOM9UQhKivI3xSFdkPhN+E6
         GwrvsOepZa/XEdWpPLrol5zxe360PbtHfqmE23ftIuyRyfwoVi6POh7sv1nejX17F3
         yXMfaBNKHMjHzn+t9ARVTaTS9sP8j5grA8lI6T8U=
Date:   Thu, 4 Mar 2021 08:34:36 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     maqiang <maqianga@uniontech.com>
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] char: lp: remove redundant space
Message-ID: <YECNjIa0Wipx+1RH@kroah.com>
References: <20210304072147.10354-1-maqianga@uniontech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210304072147.10354-1-maqianga@uniontech.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 04, 2021 at 03:21:47PM +0800, maqiang wrote:
> These two lines of code don't meet the kernel coding style,
> so remove the redundant space.
> 
> Signed-off-by: Qiang Ma <maqianga@uniontech.com>
> Signed-off-by: maqiang <maqianga@uniontech.com>

Why do you have 2 signed-off-by lines with the same email address, but
different names?

If you want to start out in kernel development for coding style fixes, I
recommend doing so in drivers/staging/ as patches there for things like
this are more welcome than other parts of the kernel.

thanks,

greg k-h
