Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 668263636E7
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Apr 2021 19:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231807AbhDRRA2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Apr 2021 13:00:28 -0400
Received: from mail.skyhub.de ([5.9.137.197]:53672 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229446AbhDRRA0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Apr 2021 13:00:26 -0400
Received: from zn.tnic (p200300ec2f25f6004f6759a73f3b605d.dip0.t-ipconnect.de [IPv6:2003:ec:2f25:f600:4f67:59a7:3f3b:605d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 937281EC026D;
        Sun, 18 Apr 2021 18:59:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1618765196;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=NpQYZXvjLRkeD9aRobuDgVQB/agTppYn2tW+8c/M7ms=;
        b=eAsOKh/blZgL0HJry/c7mcPJMKz/mDezp2WY0nH+xDbI3DefrxzIOMF/c0NBNGV0Q1DEBo
        Ho3j/LVvi50M8g1qcVyzGjpi1zO3COMvgDj2JwoL3J0FVqAHjCnePhJ5/QEzURdVK2oxDD
        nxPBSREfGszsa//6L5TY0egUAq9G+QA=
Date:   Sun, 18 Apr 2021 18:59:53 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Liang Zhou <lullaby2005@gmail.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, x86@kernel.org,
        hpa@zytor.com, corbet@lwn.net, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, zhoul110@chinatelecom.cn
Subject: Re: [PATCH] docs: fix the invalid vt-d spec location
Message-ID: <20210418165953.GA1206@zn.tnic>
References: <1618763386-29562-1-git-send-email-zhoul110@chinatelecom.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1618763386-29562-1-git-send-email-zhoul110@chinatelecom.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 18, 2021 at 09:29:46AM -0700, Liang Zhou wrote:
> This patch fixes the invalid vt-d spec location.

Avoid having "This patch" or "This commit" in the commit message. It is
tautologically useless.

Also, do

$ git grep 'This patch' Documentation/process

for more details.

> Signed-off-by: Liang Zhou <zhoul110@chinatelecom.cn>
> ---
>  Documentation/x86/intel-iommu.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/x86/intel-iommu.rst b/Documentation/x86/intel-iommu.rst
> index 099f13d..e95ee34 100644
> --- a/Documentation/x86/intel-iommu.rst
> +++ b/Documentation/x86/intel-iommu.rst
> @@ -4,7 +4,7 @@ Linux IOMMU Support
>  
>  The architecture spec can be obtained from the below location.
>  
> -http://www.intel.com/content/dam/www/public/us/en/documents/product-specifications/vt-directed-io-spec.pdf
> +https://software.intel.com/content/dam/develop/external/us/en/documents-tps/vt-directed-io-spec.pdf

Those links are never stable.

Please open a bugzilla at bugzilla.kernel.org, upload that document
there, like this, for example:

https://bugzilla.kernel.org/show_bug.cgi?id=206537

and then add the *bugzilla* link to intel-iommu.rst so that it doesn't
get invalid again.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
