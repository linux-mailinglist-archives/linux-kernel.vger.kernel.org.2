Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F399D41AD44
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 12:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240223AbhI1Kty (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 06:49:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:51830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234543AbhI1Ktv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 06:49:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 24B276101E;
        Tue, 28 Sep 2021 10:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1632826092;
        bh=0FFtsj5LRtIYCEOixSh/NlV8fvQOlEXlekvUGOF88Ec=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L20RTpH781rlfYb+n9TtxaI7pW9btx01hqOdL+h1ZOFYPUzimLHa9Y1GHsX0ScLpv
         jTHYzIJvZNTxPB7Uc+23y4JB1VNamM4fot6DkA3//97ojKayAamPYgbGKv0InXcKG4
         Ia+SFHi1dtOPZIXiommPN2nkKvwp089YC417P+sU=
Date:   Tue, 28 Sep 2021 12:48:10 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Amey Narkhede <ameynarkhede03@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Carlos Bilbao <bilbao@vt.edu>,
        Leon Romanovsky <leon@kernel.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/17] ABI: sysfs-bus-pci: add documentation for modalias
Message-ID: <YVLy6ouDppRSp2Pk@kroah.com>
References: <cover.1632750608.git.mchehab+huawei@kernel.org>
 <9ceb1fcdbef3c0d2d0368dcc2f19084a3e529ad1.1632750608.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ceb1fcdbef3c0d2d0368dcc2f19084a3e529ad1.1632750608.git.mchehab+huawei@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 27, 2021 at 03:59:39PM +0200, Mauro Carvalho Chehab wrote:
> Even being available since 2005, there's no documentation for
> modalias.
> 
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
> 
> See [PATCH 00/17] at: https://lore.kernel.org/all/cover.1632750608.git.mchehab+huawei@kernel.org/
> 
>  Documentation/ABI/testing/sysfs-bus-pci | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
> index 191cbe9ae5ed..1eeac7f59672 100644
> --- a/Documentation/ABI/testing/sysfs-bus-pci
> +++ b/Documentation/ABI/testing/sysfs-bus-pci
> @@ -187,6 +187,24 @@ Description:
>  		The symbolic link points to the PCI device sysfs entry of the
>  		Physical Function this device associates with.
>  
> +What:		/sys/bus/pci/devices/.../modalias
> +Date:		May 2005

Wow, I was not good at documenting this stuff back then, sorry about
that :(

I'll queue this series up now, thanks so much for working on this!

greg k-h
