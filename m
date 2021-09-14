Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0228740B754
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 20:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232324AbhINS7n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 14:59:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:35802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230061AbhINS7m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 14:59:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B2AED6113E;
        Tue, 14 Sep 2021 18:58:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631645905;
        bh=BAMu1k18f/MzAdl1i/fDK8qSopN0nEM4536fTuwIFto=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=fHhVGkTnpnWJzxOlxMn3yB5O9Elpth4s0tb6CsAqVk9p+AL4S5tf/2ewpWluHNOwJ
         dHrI35po8XoJpnVnzszrfxbq6n4+jhCzFyraIdj6ueDyBjrXufVgj0UwMkQde0GvnQ
         mBSHX9vl5ElM1f/GjCKqOd08MCSxDKrZjssbmjgxRaHvX1RKwISAGaqbVrcIh4P91E
         Wf/O6IJ3NXtAeZ8MJUWg/sLfh4sd0pNwtcwvFEkIhR/7n0l2dYEDCogZiN2BewqSz5
         /ulUx49nCklAVhh7kXX2lK0jaF/25Rs+OHP7GWS6yRy6HvJdicmdPIMMa2VMt55Bot
         ceHuS/wdtG5Aw==
Date:   Tue, 14 Sep 2021 13:58:23 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Amey Narkhede <ameynarkhede03@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Carlos Bilbao <bilbao@vt.edu>,
        Leon Romanovsky <leon@kernel.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/8] ABI: sysfs-bus-pci: add documentation for modalias
Message-ID: <20210914185823.GA1444822@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c2dfcf56d156a13d9c7c82122efdb64ddbc4e7d9.1631630792.git.mchehab+huawei@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2021 at 04:55:19PM +0200, Mauro Carvalho Chehab wrote:
> Even being available since 2005, there's no documentation for
> modalias.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  Documentation/ABI/testing/sysfs-bus-pci | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
> index 191cbe9ae5ed..1da4c8db3a9e 100644
> --- a/Documentation/ABI/testing/sysfs-bus-pci
> +++ b/Documentation/ABI/testing/sysfs-bus-pci
> @@ -187,6 +187,23 @@ Description:
>  		The symbolic link points to the PCI device sysfs entry of the
>  		Physical Function this device associates with.
>  
> +What:		/sys/bus/pci/devices/.../modalias
> +Date:		May 2005
> +Contact:	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> +Description:
> +		This attribute indicates the PCI ID of the device object.
> +
> +		That is in the format:
> +		pci:vXXXXXXXXdXXXXXXXXsvXXXXXXXXsdXXXXXXXXbcXXscXXiXX,
> +		where:
> +		    - vXXXXXXXX contains the vendor ID;
> +		    - dXXXXXXXX contains the device ID;
> +		    - svXXXXXXXX contains the sub-vendor ID;
> +		    - sdXXXXXXXX contains the subsystem device ID;
> +		    - bcXX contains the device class;
> +		    - scXX contains the device subclass;
> +		    - iXX contains the device class programming interface.
> +
>  What:		/sys/bus/pci/slots/.../module
>  Date:		June 2009
>  Contact:	linux-pci@vger.kernel.org
> -- 
> 2.31.1
> 
