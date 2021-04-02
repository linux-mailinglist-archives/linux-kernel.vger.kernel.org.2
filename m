Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25C5E352AA2
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 14:22:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235207AbhDBMW3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 08:22:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:48792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229599AbhDBMW2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 08:22:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1EFDF61158;
        Fri,  2 Apr 2021 12:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617366147;
        bh=f+d/TZI4Ubp+oeT3R4SGYepUDJVNLdy284TI4MXluh8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xQRTDn/9Ml7hJ+lFejZ8cVTEQhGSvZEQZclXElUCA1N/5l7YHCDXHoZ0+9Va5Qeqd
         nA+/aYu3d4xEQcQH5Szcz1uRAdOX9tob1Zde33fEvAQW7brWM6ENjttC8lFiMHzSQc
         xRdfiPWCp7H312ZyFGATHdU8RBmOgE/VWPW/HFRE=
Date:   Fri, 2 Apr 2021 14:22:24 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     zuoqilin1@163.com
Cc:     rafael@kernel.org, linux-kernel@vger.kernel.org,
        zuoqilin <zuoqilin@yulong.com>
Subject: Re: [PATCH] fs/debugfs: Convert to DEFINE_SHOW_ATTRIBUTE
Message-ID: <YGcMgENjMSla4BO3@kroah.com>
References: <20210402121141.82-1-zuoqilin1@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210402121141.82-1-zuoqilin1@163.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 02, 2021 at 08:11:41PM +0800, zuoqilin1@163.com wrote:
> From: zuoqilin <zuoqilin@yulong.com>

Please use your full/real name.

thanks,

greg k-h
