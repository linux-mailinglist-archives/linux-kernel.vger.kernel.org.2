Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D15833D2FB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 12:27:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231169AbhCPL0s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 07:26:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:39346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237242AbhCPL0J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 07:26:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E0E1665027;
        Tue, 16 Mar 2021 11:26:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1615893969;
        bh=fQ5byuoRSBcV4wgRY5BqLvmyPiroD+0dGSSW1tSd7ig=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vzYPQRUTTlcrDTxm0V72gT8X84dbmF3xbk42tMxshLXiLcr0WeSwewYS3OlL0zPrT
         CHW57P2XENDK9+hLl67N46OWXmWkHY+w2k1IA4IWOXEuDpx+E+SDChR9eCibeIqn5p
         ZhVat/a5PtjYLkAu4FJmpvlVfO2iS6PbiXavBoaw=
Date:   Tue, 16 Mar 2021 12:26:02 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Shreya <shreya.ajithchb@gmail.com>
Cc:     devel@driverdev.osuosl.org, bkkarthik@pesu.pes.edu,
        d.straghkov@ispras.ru, linux-kernel@vger.kernel.org,
        dan.carpenter@oracle.com
Subject: Re: [PATCH v2] staging:rtl8723bs:core:rtw_wlan_util:fixed
 indentation coding style issue
Message-ID: <YFCVylU6ieHAHVnc@kroah.com>
References: <20210314162855.GA2002@shreya-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210314162855.GA2002@shreya-VirtualBox>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 14, 2021 at 09:58:55PM +0530, Shreya wrote:
> Fixed the indentation of the else part of the conditional statement.
> 
> Signed-off-by: Shreya <shreya.ajithchb@gmail.com>
> ---
> v1 -> v2:
> Changed name in signed-off-by to match name in From

No, change it the other way around, you had your "real" name in the
signed-off-by line, fix your email client to also have that :)

Please try this again with a v3 patch.

thanks,

greg k-h
