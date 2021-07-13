Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7121B3C6AD6
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 08:56:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234103AbhGMG7k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 02:59:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:56598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232908AbhGMG7j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 02:59:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8D3F960FF4;
        Tue, 13 Jul 2021 06:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1626159410;
        bh=6zmrZp+UpsZtKwYF50aH+ywMAYQqheyzEIjFm3aIzNI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tjot6NymBu9vhRyxpcQ0sAkIOF/DQiuHYzOq+k8nexnmoCk9e6gcE37KsJD9gw66j
         eZY3dhI6JI9/kHR6mEjecRhKj0IE4uZ2qNsZ7HdKiiWwWflNw6cWg3SGPO3CS3B7vO
         Cgcp7OUogZFtghfTX70M/dI0i+SIMD0stz1IL8ek=
Date:   Tue, 13 Jul 2021 08:56:47 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     pandith.n@intel.com
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org, furong.zhou@intel.com,
        mgross@linux.intel.com, mallikarjunappa.sangannavar@intel.com,
        andriy.shevchenko@linux.intel.com,
        lakshmi.bai.raja.subramanian@intel.com
Subject: Re: [PATCH V5 1/1] misc: NOC Probe Counters
Message-ID: <YO05L5t5iauazGYQ@kroah.com>
References: <20210713065347.21554-1-pandith.n@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210713065347.21554-1-pandith.n@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 13, 2021 at 12:23:47PM +0530, pandith.n@intel.com wrote:
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -12589,6 +12589,12 @@ F:	include/linux/nitro_enclaves.h
>  F:	include/uapi/linux/nitro_enclaves.h
>  F:	samples/nitro_enclaves/
>  
> +NOC, DSS NOC SUPPORT

I have no idea what this means, please spell it out in the MAINTAINERS
file for everyone to understand.

thanks,

greg k-h
