Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08E3835DAC9
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 11:11:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245312AbhDMJME (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 05:12:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:45230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245305AbhDMJMB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 05:12:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 49B706124B;
        Tue, 13 Apr 2021 09:11:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1618305101;
        bh=CXFf9eOGEOFFg2jSw8hjvuyc0IJcgo7e7gCJHl6r5ps=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lOSS5qqJUKjV0+GdYJ4diz1gJIWMmavB/rMBrIDaaAKYi3xd815/Ys1syzcEYQoze
         w65feWLmhPgB5lxSOFFzZKc1ykuxMnhh39qZ4dU9b/d5ndBgaQgR5c19PBWOeAwVzi
         YI45q9Iko1JkNXX3y0cRXvDSL/GM6vd7dbtn2JD8=
Date:   Tue, 13 Apr 2021 11:11:38 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Fabio Aiuto <fabioaiuto83@gmail.com>
Cc:     joe@perches.com, julia.lawall@inria.fr,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: cocci script hints request
Message-ID: <YHVgSuRCW1fdabrH@kroah.com>
References: <20210413090400.GA5477@agape.jhs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210413090400.GA5477@agape.jhs>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 13, 2021 at 11:04:01AM +0200, Fabio Aiuto wrote:
> Hi,
> 
> I would like to improve the following coccinelle script:
> 
> @@
> expression a, fmt;
> expression list var_args;
> @@
> 
> -       DBG_871X_LEVEL(a, fmt, var_args);
> +       printk(fmt, var_args);
> 
> I would  replace the DBG_871X_LEVEL macro with printk,

No you really do not, you want to change that to a dev_*() call instead
depending on the "level" of the message.

No "raw" printk() calls please, I will just reject them :)

thanks,

greg k-h
