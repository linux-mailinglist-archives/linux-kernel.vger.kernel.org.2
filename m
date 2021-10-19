Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F31624332C7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 11:46:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235040AbhJSJs4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 05:48:56 -0400
Received: from ixit.cz ([94.230.151.217]:50542 "EHLO ixit.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234764AbhJSJsy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 05:48:54 -0400
Received: from [10.30.101.69] (unknown [213.151.89.154])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ixit.cz (Postfix) with ESMTPSA id E7BC120064;
        Tue, 19 Oct 2021 11:46:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
        t=1634636799;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dyqa41bKY0fVZZuGka4A1rVzoocTJ2PWZP1VFWd09wo=;
        b=U1deCH0nMNIpv9q/xPxT+EZ+KnZxGnIiR/cBRd6+7aXD66ndQyMludawYSgbQUyZBBmMti
        9tTZWVxNu2r6offw5iF3R1d5wUtC6eGyM89V2LGBdCFc/KaQUGabJxqtoFmGypYcK5gLMp
        rdIBpgxIGF8wDEK6XwKpVqOg/2wV6Vs=
Date:   Tue, 19 Oct 2021 11:45:05 +0200
From:   David Heidelberg <david@ixit.cz>
Subject: Re: [PATCH v3 23/23] dt-bindings: reserved-memory: ramoops: update
 ramoops.yaml references
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Kees Cook <keescook@chromium.org>,
        Rob Herring <robh@kernel.org>, Tony Luck <tony.luck@intel.com>,
        linux-kernel@vger.kernel.org
Message-Id: <5RX71R.7VC8VUYI0TBC1@ixit.cz>
In-Reply-To: <bccd9c181b68a1ebbaefd5dcce63e1b8a4b1596c.1634630486.git.mchehab+huawei@kernel.org>
References: <cover.1634630485.git.mchehab+huawei@kernel.org>
        <bccd9c181b68a1ebbaefd5dcce63e1b8a4b1596c.1634630486.git.mchehab+huawei@kernel.org>
X-Mailer: geary/40.0
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Than you for catching this.

Reviewed-by: David Heidelberg <david@ixit.cz>


Best regards
David Heidelberg

On Tue, Oct 19 2021 at 09:04:22 +0100, Mauro Carvalho Chehab 
<mchehab+huawei@kernel.org> wrote:
> Changeset 89a5bf0f22fd ("dt-bindings: reserved-memory: ramoops: 
> Convert txt bindings to yaml")
> renamed: Documentation/devicetree/bindings/reserved-memory/ramoops.txt
> to: Documentation/devicetree/bindings/reserved-memory/ramoops.yaml.
> 
> Update the cross-references accordingly.
> 
> Fixes: 89a5bf0f22fd ("dt-bindings: reserved-memory: ramoops: Convert 
> txt bindings to yaml")
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
> 
> To mailbombing on a large number of people, only mailing lists were 
> C/C on the cover.
> See [PATCH v3 00/23] at: 
> https://lore.kernel.org/all/cover.1634630485.git.mchehab+huawei@kernel.org/
> 
>  Documentation/admin-guide/ramoops.rst | 2 +-
>  MAINTAINERS                           | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/admin-guide/ramoops.rst 
> b/Documentation/admin-guide/ramoops.rst
> index 8f107d8c9261..e9f85142182d 100644
> --- a/Documentation/admin-guide/ramoops.rst
> +++ b/Documentation/admin-guide/ramoops.rst
> @@ -69,7 +69,7 @@ Setting the ramoops parameters can be done in 
> several different manners:
>  	mem=128M ramoops.mem_address=0x8000000 ramoops.ecc=1
> 
>   B. Use Device Tree bindings, as described in
> - ``Documentation/devicetree/bindings/reserved-memory/ramoops.txt``.
> + ``Documentation/devicetree/bindings/reserved-memory/ramoops.yaml``.
>   For example::
> 
>  	reserved-memory {
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d74b08c4fb1f..1dc758a0db58 100644
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
> 2.31.1
> 


