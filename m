Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B1B8354130
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Apr 2021 12:38:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232470AbhDEKdJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 06:33:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:53586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230305AbhDEKdI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 06:33:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A2F2561002;
        Mon,  5 Apr 2021 10:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617618781;
        bh=0wHqgcE2bXp1m+qUNuoVmhAvJ8AW/07Qzz4FNRVqzuo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KZbHIoPokEVhDtfXOmO2haLraKCJUwxpn1iQCDR8djRjmi0ndHm5PfLL1hvX7MQIY
         3l7qbnlDMnThYVst36sFIeFtyus8rYiFONpKIU628JXeAfkuxSWs9mzt0XmQJfTEZG
         1jbw6Pm5JP2vzNc6hqPY3YE+a24f1Y3mPjzcuRzQ=
Date:   Mon, 5 Apr 2021 12:32:58 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Luiz Sampaio <sampaio.ime@gmail.com>
Cc:     zbr@ioremap.net, corbet@lwn.net, rikard.falkeborn@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/9] w1: ds2438: adding support for calibration of
 current measurements
Message-ID: <YGrnWtvRO5/0lMRc@kroah.com>
References: <20210403012446.381516-1-sampaio.ime@gmail.com>
 <20210403044547.390226-1-sampaio.ime@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210403044547.390226-1-sampaio.ime@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 03, 2021 at 01:45:47AM -0300, Luiz Sampaio wrote:
> The following patches aim to make a user able to calibrate the current measurement of the DS2438. This chip uses a offset register in page1, which is added to the current register to give the user the current measurement. If this value is wrong, the user will get an offset current value, even if the current is zero, for instance. This patch gives support for reading the page1 registers (including the offset register) and for writing to the offset register. The DS2438 datasheet shows a calibration routine, and with this patch, the user can do this quickly by writing the correct value to the offset register. This patch was tested on real hardware using a power supply and an electronic load.
> Please help to review this series of patches.
> 
> Best regards!
> Sampaio
> ---
> Changes in v3:
> - I accidentally added a wrong line that would not compile. I'm sorry. Fixed it.
> 
> Changes in v2:
> - Using git send-email to send the patches
> - Adding documentation as requested
> - Separating the coding style changes in different patches as requested
> 
> Luiz Sampaio (9):
>   w1: ds2438: fixed a coding style issue
>   w1: ds2438: fixed a coding style issue
>   w1: ds2438: fixed a coding style issue
>   w1: ds2438: fixed a coding style issue
>   w1: ds2438: fixed a coding style issue
>   w1: ds2438: fixed a coding style issue

You can not have different patches that do different things, yet have
identical subject lines.

Please make them unique.

thanks,

greg k-h
