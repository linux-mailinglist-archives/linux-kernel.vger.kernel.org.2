Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DABA450180
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 10:33:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237307AbhKOJgU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 04:36:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:42214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237249AbhKOJer (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 04:34:47 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id DC04D61C14;
        Mon, 15 Nov 2021 09:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1636968712;
        bh=gvaNIOA2WSbXAoHLUuyg7yyCEmgRbV0AnZ3stqcMUzk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fFN+idGCtjA0hmFeDeOWaqq6J/o3efYm0Tzi1/Y/iWfALB2Lw2ZP4RNQj7bzbGQHq
         0u3rs+zYtUbpXD/KfPslNYTUJtrPYtAtRah3uY5WKIYz2aROzQr7pHFaKJckbh3QA6
         /cq0DDok2uDgNNnEdOed+59HHepSgOwo/QkTXmPw=
Date:   Mon, 15 Nov 2021 10:31:49 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Alberto Merciai <alb3rt0.m3rciai@gmail.com>
Cc:     devel@driverdev.osuosl.org, forest@alittletooquiet.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: vt6655: refactor camelcase uCurrRSSI to
 current_rssi
Message-ID: <YZIpBUF1Kv455nIC@kroah.com>
References: <20211114164048.GA134727@t470p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211114164048.GA134727@t470p>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 14, 2021 at 05:40:48PM +0100, Alberto Merciai wrote:
> Replace camelcase variable "uCurrRSSI" (current Received Signal Strength
> Indicator) into linux kernel coding style equivalent 

Odd line break :(

And trailing whitespace :(

> variable "current_rssi".
> 
> References:
> https://www.kernel.org/doc/html/latest/process/coding-style.html
> https://www.cse.iitk.ac.in/users/dsrkg/cs245/html/Guide.htm

Same comments on these links as before.

thanks,

greg k-h
