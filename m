Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 284023ED0F3
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 11:21:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235368AbhHPJVf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 05:21:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:52474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234976AbhHPJVe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 05:21:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 12B2161A7E;
        Mon, 16 Aug 2021 09:21:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1629105663;
        bh=Qb9gKvIdgRArWNfTgiNwDGTBi2NO7833/nKSzV9bwIA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fkAS+3ZmssKmHWEiNAQ6N+KcD1LkeUk9IrDWAXp8jYFUayLXlbTZVFTN1x+t6aDNC
         jAHq1jGt8Wk95ZIY8Q0xfZ4wPa8HXT4yhzdHG89tf+MtHQ1DzfdZVJHzzf3CEhFrDf
         mudL1kE3vzJ3c0OVrSexfstIzOsWLQCD5Ld3R5NY=
Date:   Mon, 16 Aug 2021 11:20:59 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Slark Xiao <slark_xiao@163.com>
Cc:     Reinhard Speyerer <rspmn@arcor.de>, johan@kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH] [V2,1/1]USB: serial: option: add Foxconn T77W175
 composition 0x901d
Message-ID: <YRot+wBa6v529Z7q@kroah.com>
References: <20210816035404.4210-1-slark_xiao@163.com>
 <YRoqAJmGBpV/OuZL@arcor.de>
 <d1d16fd.6f62.17b4e3ffa26.Coremail.slark_xiao@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d1d16fd.6f62.17b4e3ffa26.Coremail.slark_xiao@163.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 16, 2021 at 05:17:00PM +0800, Slark Xiao wrote:
>   So should I use USB_DEVICE_INTERFACE_NUMBER(QUALCOMM_VENDOR_ID, 0x901d, 0x00) to bind Diag port only?

Why is this device using the QUALCOMM vendor id anyway?  Is this allowed
by Qualcomm?

thanks,

greg k-h
