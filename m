Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 895DF33A5DB
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Mar 2021 16:59:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233841AbhCNP6b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Mar 2021 11:58:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:46898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229539AbhCNP6C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Mar 2021 11:58:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 07AEF64E89;
        Sun, 14 Mar 2021 15:58:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1615737482;
        bh=7VN49rm6JEqj7Q+up9pcIg4ZPrqsnDegtaG+SsByO7Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NfBeu7vEjYc/qdMuq5dXLURsFTPsdBaAgQy6xLUc4IGD+yQetr8VwljGmg22pxkFi
         7CIp3LslDg358+xMa3+b1cqgCb0x9pS9lrr/G3d8C2ESHVPx72G/o0DaQz5fEMFMLG
         jJVqPdLX+VILzif28rSwbfr9lknj1p6kDNuC4KKU=
Date:   Sun, 14 Mar 2021 16:57:59 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Shreya <shreya.ajithchb@gmail.com>
Cc:     devel@driverdev.osuosl.org, bkkarthik@pesu.pes.edu,
        d.straghkov@ispras.ru, linux-kernel@vger.kernel.org,
        dan.carpenter@oracle.com
Subject: Re: [PATCH] staging:rtl8723bs:core:rtw_wlan_util:fixed indentation
 coding style issue
Message-ID: <YE4yhxukkFPuTIYb@kroah.com>
References: <20210313171453.GA2640@shreya-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210313171453.GA2640@shreya-VirtualBox>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 13, 2021 at 10:44:53PM +0530, Shreya wrote:
> Fixed the indentation of the else part of the conditional statement.
> 
> Signed-off-by: Shreya Ajith <shreya.ajithchb@gmail.com>

This name does not match your "From:" email name :(

Please fix up and resend.

thanks,

greg k-h
