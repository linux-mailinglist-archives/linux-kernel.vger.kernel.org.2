Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E77773B2F86
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 14:58:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231945AbhFXNAh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 09:00:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:45146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231467AbhFXNAg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 09:00:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5432C613C3;
        Thu, 24 Jun 2021 12:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1624539496;
        bh=5HgfKV3KNHodF5YVB0C/oGwC4UwPn2YZnTEjr0F4kgU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NVHhKZ7MdoETAo3P4bip9WJhMoTg66WO9SSqVOeuosPsv2V+OXeXuhosGW78rhWQr
         VFC1MKVMxfpf6tL8oIr0yQD3N54ymU3mqk3nMeDebaobQzIWTdud16xNrS1MismEOt
         Khri9r0rM9V/l6/bfrgngw6zYp16eGRDCL17fp6M=
Date:   Thu, 24 Jun 2021 14:58:14 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Zhenguo Zhao <zhenguo6858@gmail.com>
Cc:     jirislaby@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tty: n_gsm: CR bit value should be 0 when config
 "initiator=0"
Message-ID: <YNSBZs9OXTfhGfF3@kroah.com>
References: <1623844402-4731-1-git-send-email-zhenguo6858@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1623844402-4731-1-git-send-email-zhenguo6858@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 16, 2021 at 07:53:22PM +0800, Zhenguo Zhao wrote:
> From: Zhenguo Zhao <zhenguo.zhao1@unisoc.com>
> 
> config "initiator=0",gsmld will receives dlci SABM/DISC control command
> frame,as slaver,the CR bit value check should be 1.

I am really sorry, but I do not understand this changelog comment.  Can
you try rewriting it again?

> 
> if check "cr == 0",it will goto invalid,so it can't send UA response
> frame and open slaver dlci.

Same here, I do not understand.

thanks,

greg k-h
