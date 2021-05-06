Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED61B374F7A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 08:42:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232464AbhEFGnm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 02:43:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:38536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229844AbhEFGnj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 02:43:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7151E611AC;
        Thu,  6 May 2021 06:42:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620283361;
        bh=fQQlQTrEN5mS3liFxio1DaWexB5sdTGkW/vxkGPIm84=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nyBI0xzGehu6gAf7+IwrdA8ePQbHzWnh28MVnFX8xIbezXj+8ysG5M6UHKFRex/ai
         0npxGrFkkUpa3chTSDFeQNE3RZRCmu7oFnEav7VYdw7D7xRDRCF7PmcbYPTDajZc+J
         DHlHjE2fNhrqJgBF/eJo7izEkQMA3jOrTiiKMFqTJ3fhGvnl4kvjf5b36a1n3P5Y6k
         XqNYWt/nMVdJoQcaFBChDlEoTDX5Qwe42DzLiZnazPv+xTgfeLo6lAF62uOKCS1fHz
         sE6Al1VtQ3YRCCiDEf5bi0xiyNg4ynY/f1PJqnUk08brexeIgx/TFFF/6LFwIxRYB2
         zZUhkqeI/t6tQ==
Date:   Thu, 6 May 2021 08:42:37 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Carlos Bilbao <bilbao@vt.edu>
Cc:     corbet@lwn.net, hdegoede@redhat.com, Jonathan.Cameron@huawei.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fixed typos in all directories of Documentation/ABI/
Message-ID: <20210506084237.1f8363ba@coco.lan>
In-Reply-To: <2219636.ElGaqSPkdT@iron-maiden>
References: <2219636.ElGaqSPkdT@iron-maiden>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, 05 May 2021 16:43:59 -0400
Carlos Bilbao <bilbao@vt.edu> escreveu:

> Fix the following typos in the Documentation/ABI/ directory:
> 
> - In file obsolete/sysfs-cpuidle, change "obselete" for "obsolete".
> 
> - In file removed/sysfs-kernel-uids, change "propotional" for "proportional".
> 
> - In directory stable/, fix the following words: "associtated" for "associated",
>   "hexidecimal" for "hexadecimal", "vlue" for "value", "csed" for "caused" and 
>   "wrtie" for "write". This updates a total of five files.
> 
> - In directory testing/, fix the following words: "subystem" for "subsystem", 
>   isochrnous" for "isochronous", "Desctiptors" for "Descriptors", "picutre" for 
>   "picture", "capture" for "capture", "occured" for "ocurred", "connnected" for 
>   "connected","agressively" for "aggressively","manufacturee" for "manufacturer"
>   and "transaction" for "transaction" and "malformatted" for "malformed". This 
>   updates a total of ten files.
> 
> Signed-off-by: Carlos Bilbao <bilbao@vt.edu>

...
 
> diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
> index ef00fada2efb..bfd017204563 100644
> --- a/Documentation/ABI/testing/sysfs-bus-pci
> +++ b/Documentation/ABI/testing/sysfs-bus-pci
> @@ -139,7 +139,7 @@ Description:
>  		binary file containing the Vital Product Data for the
>  		device.  It should follow the VPD format defined in
>  		PCI Specification 2.1 or 2.2, but users should consider
> -		that some devices may have malformatted data.  If the
> +		that some devices may have malformed data.  If the
>  		underlying VPD has a writable section then the
>  		corresponding section of this file will be writable.
>  

(not a native English speaker here)

I'm in doubt about this one. The description is talking about the
"VPD format".

On a quick look, it sounds that malformatted is valid, at least
in computing:

	https://en.wiktionary.org/wiki/malformatted
	https://etymologeek.com/eng/malformatted/73029882
	https://en.glosbe.com/en/en/malformatted

Maybe the best here would be to double-check with PCI maintainers
and/or take a look at PCI specs and see what it is used there.

Thanks,
Mauro
