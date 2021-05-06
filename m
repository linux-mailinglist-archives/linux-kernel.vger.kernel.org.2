Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 756213758B7
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 18:51:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236039AbhEFQwO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 12:52:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:49358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236000AbhEFQwN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 12:52:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8F50561177;
        Thu,  6 May 2021 16:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620319874;
        bh=F1DFxIGpJicBhGexwPvhepSUAEDx4pcv9TaGvCXT+ac=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pgLzgydPZegPnSSJgBoGZ4L0NTMcKHxUQgo2Exv9ocyuSV+lmn4y+kEH7BSWqlWvg
         1ir9uX+lvIuzR8f1LvZ6vCPQ/kcDdjc7VrgYE+8AenLUnl0IxGw9+ANLzOGY/pJ3ml
         ZMqhY9UyUPbtE2UDHGWBIYAPUD6ziiBaYVEpdLp7Unp3MJ0otH/bxzcL8Vra9DOS3d
         hfXfEzOOhziWYJtHZfQ8e47xOQbpMvZCdmOoNU189lPEjrCLD9r9K3O3cZnte/B3tY
         gHilmw+CVpTb66ej5JDMz/AmM7DQhgesB1NB6eJw3thN8bpkwXvH5N9LlSNZpCaIID
         nejjCtLBLYxsw==
Date:   Thu, 6 May 2021 18:51:09 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Carlos Bilbao <bilbao@vt.edu>
Cc:     gregkh@linuxfoundation.org, Jonathan.Cameron@huawei.com,
        corbet@lwn.net, hdegoede@redhat.com, linux-kernel@vger.kernel.org,
        tytso@mit.edu, rdunlap@infradead.org
Subject: Re: [PATCH v3] Fixed typos in all directories of Documentation/ABI/
Message-ID: <20210506185109.1d5ac46d@coco.lan>
In-Reply-To: <4312859.LvFx2qVVIh@iron-maiden>
References: <2219636.ElGaqSPkdT@iron-maiden>
        <YJPvl6Si9Xi0w5tG@mit.edu>
        <5458216.DvuYhMxLoT@iron-maiden>
        <4312859.LvFx2qVVIh@iron-maiden>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, 06 May 2021 11:19:54 -0400
Carlos Bilbao <bilbao@vt.edu> escreveu:

> diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
> index ef00fada2efb..93f9c3789d0f 100644
> --- a/Documentation/ABI/testing/sysfs-bus-pci
> +++ b/Documentation/ABI/testing/sysfs-bus-pci
> @@ -139,8 +139,8 @@ Description:
>  		binary file containing the Vital Product Data for the
>  		device.  It should follow the VPD format defined in
>  		PCI Specification 2.1 or 2.2, but users should consider
> -		that some devices may have malformatted data.  If the
> -		underlying VPD has a writable section then the
> +		that some devices may have incorrectly formatted data.  
> +                If the underlying VPD has a writable section then the
>  		corresponding section of this file will be writable.

Nitpick: please use tabs at the new text, in order to follow
the same pattern ;-)

With such change:

Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>


Thanks,
Mauro
