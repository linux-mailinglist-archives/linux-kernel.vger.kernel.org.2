Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9015D434A95
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 13:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbhJTLz0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 07:55:26 -0400
Received: from ixit.cz ([94.230.151.217]:56906 "EHLO ixit.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230241AbhJTLzZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 07:55:25 -0400
Received: from [192.168.1.138] (ip-89-176-96-70.net.upcbroadband.cz [89.176.96.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ixit.cz (Postfix) with ESMTPSA id 4245F20064;
        Wed, 20 Oct 2021 13:53:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
        t=1634730788;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lnJgnbUXn69VwdukVVbjRObvM3/oVycgvV0+KxSZIks=;
        b=WIt/G9qEG0AQ24eGIiVF7jLlUbvLnRdwJD9XPIK1JHf6hInTNZvQ6z+HCupR/KPXXe+9WJ
        +3kLo37GRvOuvmPz+KgtGmQ6Xdlq+JdVcfzBfqOHxCoeOfRh0GEeFT6fa3M2vkpLHuMDhw
        e1CYRqz+zQqj2Z5eSkLiihxNhn+PB1w=
Date:   Wed, 20 Oct 2021 13:51:34 +0200
From:   David Heidelberg <david@ixit.cz>
Subject: Re: [PATCH] MAINTAINERS: rectify entry for PSTORE FILESYSTEM
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>, Rob Herring <robh@kernel.org>,
        devicetree@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Message-Id: <Y9Y91R.5KFSRX6QS1RV1@ixit.cz>
In-Reply-To: <20211020104647.11556-1-lukas.bulwahn@gmail.com>
References: <20211020104647.11556-1-lukas.bulwahn@gmail.com>
X-Mailer: geary/40.0
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In Rob tree, there is already applied patch "dt-bindings: 
reserved-memory: ramoops: update ramoops.yaml references" which should 
fix it.
David

On Wed, Oct 20 2021 at 12:46:47 +0200, Lukas Bulwahn 
<lukas.bulwahn@gmail.com> wrote:
> Commit 89a5bf0f22fd ("dt-bindings: reserved-memory: ramoops: Convert 
> txt
> bindings to yaml") converts ramoops.txt to ramoops.yaml, but missed to
> adjust its reference in MAINTAINERS.
> 
> Hence, ./scripts/get_maintainer.pl --self-test=patterns complains 
> about
> a broken reference.
> 
> Repair this file reference in PSTORE FILESYSTEM.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
> applies cleanly on next-20211019
> 
> Please apply clean-up patch on top of commit above.
> 
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1ad9cbe46b53..cb84a0d46a24 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -15336,7 +15336,7 @@ S:	Maintained
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git 
> for-next/pstore
>  F:	Documentation/admin-guide/ramoops.rst
>  F:	Documentation/admin-guide/pstore-blk.rst
> -F:	Documentation/devicetree/bindings/reserved-memory/ramoops.txt
> +F:	Documentation/devicetree/bindings/reserved-memory/ramoops.yaml
>  F:	drivers/acpi/apei/erst.c
>  F:	drivers/firmware/efi/efi-pstore.c
>  F:	fs/pstore/
> --
> 2.26.2
> 


