Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57A5242281D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 15:41:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234694AbhJENnA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 09:43:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:55812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233950AbhJENm6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 09:42:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D88D7615A3;
        Tue,  5 Oct 2021 13:41:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1633441268;
        bh=tIZEYtnrhTwGy5fksmIl5Qyzz5zg6z8TXlyYBW2Ifh8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Zt5YvxS8eJZS4nT+yEHeIpstBCPDwCtZF5TFh7eC5uUrm5nwTX9Z6uvCtDVNImTyh
         yOsGoJ5ILzoUtRrN9gFttJUQVDSdlMSyFhZQFHbwmI933lPYQYikUDI4uZXZet1K9U
         jq5Djzq/9gbXr9UJmvG68XS8XU1yxm7DTFG+WLo8=
Date:   Tue, 5 Oct 2021 15:41:06 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Stefani Seibold <stefani@seibold.net>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] samples/kfifo: Rename read_lock/write_lock
Message-ID: <YVxV8sKyc1Y62X7r@kroah.com>
References: <20210923172918.o22iwgvn3w7ilh44@linutronix.de>
 <5cb013d281fc064a7e928eb16bdfa9d5d77987e1.camel@seibold.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5cb013d281fc064a7e928eb16bdfa9d5d77987e1.camel@seibold.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 05, 2021 at 11:42:57AM +0200, Stefani Seibold wrote:
> Acked by Stefani Seibold <stefani@seibold.net>

WHo is supposed to take these?

Want me to take them through my char/misc tree?

thanks,

greg k-h
