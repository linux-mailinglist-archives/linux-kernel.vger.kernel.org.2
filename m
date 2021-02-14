Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C51E231B041
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Feb 2021 12:48:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbhBNLsg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Feb 2021 06:48:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:46974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229563AbhBNLse (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Feb 2021 06:48:34 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id EA0B464DCE;
        Sun, 14 Feb 2021 11:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1613303273;
        bh=elUQm2lXY4Hj87e0jO09Oq6YFsKLumYYHK8S4+ADqCM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=coqw7c9m7e9YIdQZHy5QtzVQmN94nSPlohH6H9G0i/SWCfjfETnQZSZwBC2LTslsp
         tA9fejFsakK8VplR1wcNzEdTkAbiKYA3ph5If5fxyHENOyvKlv/s4/yFPG/Ye+F+Hf
         zVzdDjbAtI9rS5WjUVbUlt2POzKZYJB2GU5s4Wso=
Date:   Sun, 14 Feb 2021 12:47:49 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     AristoChen <jj251510319013@gmail.com>
Cc:     linux-kernel@vger.kernel.org, balbi@kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: function: fix typo in f_printer.c
Message-ID: <YCkN5WxFhYHSDW71@kroah.com>
References: <20210214113525.9279-1-jj251510319013@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210214113525.9279-1-jj251510319013@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 14, 2021 at 07:35:25PM +0800, AristoChen wrote:
> In line 824, it is trying to enable `out_ep`, so I
> believe that in line 826, it should print `out_ep`
> instead of `in_ep`.
> 
> Signed-off-by: AristoChen <jj251510319013@gmail.com>

Is this the name you use to sign legal documents?  If not, please resend
with your real name, as the documentation requires.

thanks,

greg k-h
