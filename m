Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C25C2307A62
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 17:13:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231631AbhA1QLh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 11:11:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232262AbhA1QKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 11:10:51 -0500
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50299C061756
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 08:10:11 -0800 (PST)
Received: by mail-oo1-xc2b.google.com with SMTP id j8so1549702oon.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 08:10:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9j0OlL+xIOBnprbaoSGIUQrRbKys8hFx+xwZEA8uky4=;
        b=uNyjDpzjbuv9Nn/sHkPB1k2JILj4iGHWZ6AKmNxOLpmGUYHdZwdq7oWC7y6lBfh8D+
         XSK5aStyIwB+MIjwRuMvldc5s71hCKWtIq0YmxOj1x5yx7jpOSMZBynjX1s6rtkF3VMG
         xe0YC/vzyRbbj2qQUvqIAVX1V9e6OHKMRNC4yQJv6FbMGtXwHX6MR6lD20oFskrTzKsH
         2Nn0d8VRPRn+xo7ml1i5BLa6q9sj1ugj2LsCTDsAahhgu+yCLMpBfIiSxS+399e0QMuC
         oMmpbcrIwHg8/sPDuoYXMWwW8JICHM8Sxo6n1n5TEC5GIIXiMkYgELmIShNJHG+vMrpK
         Ypsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9j0OlL+xIOBnprbaoSGIUQrRbKys8hFx+xwZEA8uky4=;
        b=g3xzt5OjXYlANpr5caYODkuQhDO9YKu2maPd6XFI6DG1sprtHpAuZCn0NJwE/krU4E
         yBpcZReo3/85YqXT7zNzPstHVpWDIM4n0/57WRR0DTGtM9VPVmAsP7hoSzQMoWv4aNPr
         LK2H7GTTjenuQVtK3FjKjIuutkqYbU/wSVmHP+AUFqHGxY4hLCuxtLT+uR24hSQ5onG1
         VAUHmCy4xhpFfYyxyFp6plbYkTy10Kf1j6OH++Bh4reVEc8ZqnCCzLWczLAVvFrRx2lT
         mOr6Um1sBE2kcrrxuKfC93T6MRA8pOB1KjnyRVwdNCKR6i/NpJsuajV4ifqnGIcpv25q
         5iQw==
X-Gm-Message-State: AOAM531lRK+UdDEwYqiaOTmiWINdSPaG7BEjqQrUXFkqMJYJMv0Yg+es
        0J4DucG8dXS1tkfpDqB4P7kMaQ==
X-Google-Smtp-Source: ABdhPJzc44md3mjOo5VkG7nZrqwNUMHRSJgAAToAdqqnC8ri0CIXsFbuSihpBuAU2yuLyW8FiOpasQ==
X-Received: by 2002:a4a:3b4f:: with SMTP id s76mr189204oos.29.1611850210534;
        Thu, 28 Jan 2021 08:10:10 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id w194sm1144393oiw.39.2021.01.28.08.10.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jan 2021 08:10:09 -0800 (PST)
Date:   Thu, 28 Jan 2021 10:10:08 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 1/6] dt-bindings: arm: qcom: Document SM8350 SoC and
 boards
Message-ID: <YBLh4Lc9Z2W9PPf3@builder.lan>
References: <20210127123054.263231-1-vkoul@kernel.org>
 <20210127123054.263231-2-vkoul@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210127123054.263231-2-vkoul@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 27 Jan 06:30 CST 2021, Vinod Koul wrote:

> Document the SM8350 SoC binding and also the boards using it.
> 
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Vinod Koul <vkoul@kernel.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> ---
>  Documentation/devicetree/bindings/arm/qcom.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
> index c97d4a580f47..8fe7e473bfdf 100644
> --- a/Documentation/devicetree/bindings/arm/qcom.yaml
> +++ b/Documentation/devicetree/bindings/arm/qcom.yaml
> @@ -41,6 +41,7 @@ description: |
>          sdm660
>          sdm845
>          sm8250
> +        sm8350
>  
>    The 'board' element must be one of the following strings:
>  
> @@ -178,6 +179,11 @@ properties:
>                - qcom,sm8250-mtp
>            - const: qcom,sm8250
>  
> +      - items:
> +          - enum:
> +              - qcom,sm8350-mtp
> +          - const: qcom,sm8350
> +
>  additionalProperties: true
>  
>  ...
> -- 
> 2.26.2
> 
