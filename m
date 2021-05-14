Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EDC63808D9
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 13:47:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232134AbhENLsd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 07:48:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:60530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229445AbhENLsc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 07:48:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C0F3461451;
        Fri, 14 May 2021 11:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1620992841;
        bh=cqBDYFIise7BzFH9pyRmTy35CizPahqpg4N2b5yr9vs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BGc4UgXZHB9JW/LqevKrCXznQZ89zsJJmZfIWgQ0zuvb5o6gWseDNDgSIdTW8+HiG
         TQ9KG4yq1toN4IsIoFqOs9IsCavh25Q/TBpeUGesik32lXyI5g1x/jxPLpIsxDZUOZ
         2tZ4HfDapfN2GGumld/cylkNEZMglMC5HasOUOQY=
Date:   Fri, 14 May 2021 13:47:17 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Luiz Sampaio <sampaio.ime@gmail.com>
Cc:     zbr@ioremap.net, corbet@lwn.net, rikard.falkeborn@gmail.com,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v7 0/6] w1: ds2438: adding support for calibration of
 current measurements
Message-ID: <YJ5jRYRkFSo4OxFe@kroah.com>
References: <20210409031533.442123-1-sampaio.ime@gmail.com>
 <20210416221739.501090-1-sampaio.ime@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210416221739.501090-1-sampaio.ime@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 16, 2021 at 07:17:33PM -0300, Luiz Sampaio wrote:
> The following patches aim to make a user able to calibrate the current
> measurement of the DS2438. This chip uses a offset register in page1, which
> is added to the current register to give the user the current measurement.
> If this value is wrong, the user will get an offset current value, even if
> the current is zero, for instance. This patch gives support for reading the
> page1 registers (including the offset register) and for writing to the
> offset register. The DS2438 datasheet shows a calibration routine, and with
> this patch, the user can do this quickly by writing the correct value to
> the offset register. This patch was tested on real hardware using a power
> supply and an electronic load.
> Please help to review this series of patches.
> 
> Best regards!
> Sampaio
> ---
> Changes in v7:
> - Build test again

Can you fix the warning in patch 6/6 that the kernel test robot found,
and resend?

thanks,

greg k-h
