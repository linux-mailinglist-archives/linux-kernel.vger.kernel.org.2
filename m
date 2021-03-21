Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AFBC34326C
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Mar 2021 13:26:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbhCUMZa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Mar 2021 08:25:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:33044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229815AbhCUMYz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Mar 2021 08:24:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3878661946;
        Sun, 21 Mar 2021 12:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1616329494;
        bh=zn0thQKrRCOaUqXvGKbzNwd9nTC8oSH1ccRAESfzKnw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a+M/10DwX2/dUCM80ZtyS7gENrCKmRXjWnCmGvj3p1GWtiW6R3vyrtM9b5fam9xhu
         9lC3pVM5TGctVC6MYNGWmPHHYgHIfHltHlzZIZkymulPcWB24O2RDvz6ZSMyZc5Qc/
         Zx2OdGr59gdsVpPY9AwsPloX0dTmig6C/Vy6tOnE=
Date:   Sun, 21 Mar 2021 13:24:49 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     eli.billauer@gmail.com
Cc:     arnd@arndb.de, devel@driverdev.osuosl.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        dan.carpenter@oracle.com
Subject: Re: [PATCH v4 1/2] char: xillybus: Move class-related functions to
 new xillybus_class.c
Message-ID: <YFc7EckRKa/iO8rU@kroah.com>
References: <20210311095033.20956-1-eli.billauer@gmail.com>
 <20210311095033.20956-2-eli.billauer@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210311095033.20956-2-eli.billauer@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 11, 2021 at 11:50:32AM +0200, eli.billauer@gmail.com wrote:
> +EXPORT_SYMBOL(xillybus_init_chrdev);

Given the license for this code, perhaps EXPORT_SYMBOL_GPL()?

I have to ask :)

thanks,

greg k-h
