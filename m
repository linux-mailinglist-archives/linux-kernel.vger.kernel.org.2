Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B21943DAB4E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 20:47:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231878AbhG2Srm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 14:47:42 -0400
Received: from mail-il1-f172.google.com ([209.85.166.172]:40582 "EHLO
        mail-il1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbhG2Srl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 14:47:41 -0400
Received: by mail-il1-f172.google.com with SMTP id d10so6915771ils.7;
        Thu, 29 Jul 2021 11:47:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Owvt51G8BT5PCEkDXOGLyJL8jNSW/BJVhbz954O1Bc0=;
        b=T3A97Gt9DGKdazaeHO/dUXPew7vClsFpRGqXy2VvjgnOQZw8+AMCpnfal5HpLMc1Co
         NwVXcwmP8GemYANlJniCv11pZZf3stta8OxT4z/cmW7GPxVpssVpSFE/xbFZwMlZc3TW
         mmxoJlwIGDH0jD2GWyPdxpgMKES+5dG/W4fVh8EONSjP01/aJb2rfpTOhfuPNSEO0puF
         r1tZz7wM4FbZvmtcOUAgLKVFmavRJPT/OcAmbKiCTug2VlkQIoTV+bjc8QCJZL2mWPRi
         R03j5FAAhKvBzVMoYnw4kn9d35zCW6hNLXLNS5GcAWcpG1plusfMjpBhybG0ZKDSlV4D
         BlQw==
X-Gm-Message-State: AOAM530/Fnqb1wvcGH5hUL8WQjAnPMipYzShHbKQRrc1eSJBwEFRLz3u
        BYYrHOt7z86epWF0vMQgUA==
X-Google-Smtp-Source: ABdhPJxX0k6iQCUv15njGxn+W7mZqKHWMfJLJcFS8RA5siL2fGoKV0G2ZN8cJSu0slGTwYRVt0rizA==
X-Received: by 2002:a92:d74c:: with SMTP id e12mr1806567ilq.162.1627584456459;
        Thu, 29 Jul 2021 11:47:36 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id n12sm2418682ilo.57.2021.07.29.11.47.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 11:47:35 -0700 (PDT)
Received: (nullmailer pid 671734 invoked by uid 1000);
        Thu, 29 Jul 2021 18:47:34 -0000
Date:   Thu, 29 Jul 2021 12:47:34 -0600
From:   Rob Herring <robh@kernel.org>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/2] dt-bindings: nvmem: Extend patternProperties to
 optionally indicate bit position
Message-ID: <YQL3xmranCyNH0XO@robh.at.kernel.org>
References: <1626661864-15473-1-git-send-email-hayashi.kunihiko@socionext.com>
 <1626661864-15473-2-git-send-email-hayashi.kunihiko@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1626661864-15473-2-git-send-email-hayashi.kunihiko@socionext.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Jul 2021 11:31:03 +0900, Kunihiko Hayashi wrote:
> Allow to extend expression of sub nodes to optionally indicate bit
> position. This extension is needed to distinguish between different bit
> positions in the same address.
> 
> For example, there are two nvmem nodes starting with bit 4 and bit 0
> at the same address 0x54. In this case, it can be expressed as follows.
> 
>     trim@54,4 {
>         reg = <0x54 1>;
>         bits = <4 2>;
>     };
>     trim@54,0 {
>         reg = <0x54 1>;
>         bits = <0 4>;
>     };
> 
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---
>  Documentation/devicetree/bindings/nvmem/nvmem.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Applied, thanks!
