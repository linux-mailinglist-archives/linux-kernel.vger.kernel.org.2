Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70CF743C3E7
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 09:31:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240419AbhJ0HdX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 03:33:23 -0400
Received: from hostingweb31-40.netsons.net ([89.40.174.40]:35363 "EHLO
        hostingweb31-40.netsons.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231144AbhJ0HdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 03:33:22 -0400
Received: from [79.2.93.196] (port=38082 helo=[192.168.101.73])
        by hostingweb31.netsons.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <luca@lucaceresoli.net>)
        id 1mfdOh-00Ebpp-PV; Wed, 27 Oct 2021 09:30:55 +0200
Subject: Re: [PATCH] dt-bindings: Add a help message when dtschema tools are
 missing
To:     Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
References: <20211026171804.2867369-1-robh@kernel.org>
From:   Luca Ceresoli <luca@lucaceresoli.net>
Message-ID: <8c6d5a97-14f7-9155-6f90-17e6e33d77c2@lucaceresoli.net>
Date:   Wed, 27 Oct 2021 09:30:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211026171804.2867369-1-robh@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hostingweb31.netsons.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lucaceresoli.net
X-Get-Message-Sender-Via: hostingweb31.netsons.net: authenticated_id: luca+lucaceresoli.net/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: hostingweb31.netsons.net: luca@lucaceresoli.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

thanks for this patch!

On 26/10/21 19:18, Rob Herring wrote:
> The dtschema version check works, but is not that clear when dtschema is
> neither installed nor in the PATH. Add a separate check and message if

Nit: I think it should say "either not installed or not in the PATH".

> dt-doc-validate is not found.
>
> Cc: Luca Ceresoli <luca@lucaceresoli.net>
> Cc: Masahiro Yamada <masahiroy@kernel.org>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/Makefile | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/Makefile b/Documentation/devicetree/bindings/Makefile
> index 8d6d912c6a6a..001b4f62b741 100644
> --- a/Documentation/devicetree/bindings/Makefile
> +++ b/Documentation/devicetree/bindings/Makefile
> @@ -9,6 +9,10 @@ DT_SCHEMA_MIN_VERSION = 2021.2.1
>  
>  PHONY += check_dtschema_version
>  check_dtschema_version:
> +	@which $(DT_DOC_CHECKER) >/dev/null || \
> +		{ echo "Error: '$(DT_DOC_CHECKER)' not found!" \
> +		"\nEnsure dtschema python package is installed and in your PATH." \
> +		"\nCurrent PATH is:\n$$PATH\n" >&2; false; }

You need 'echo -e' for the '\n'.

Otherwise looks and works well.

-- 
Luca
