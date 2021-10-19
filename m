Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6094433106
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 10:24:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234707AbhJSI0w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 04:26:52 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:35668
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234691AbhJSI0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 04:26:49 -0400
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com [209.85.208.200])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id E38A13F32F
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 08:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1634631876;
        bh=Swi6Ddj8Xbp80QnpAWQNLdENzfNBX7zxXSg0uNaLjZ4=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=f2OGDEHzGLKZqsO6MDQuDNCCZ8ISX5US7ab3Tmq0dnd1cftn3C3K6z9RyF3MdpT8d
         AduLCmRqGz10iTT5OeyTvuslMLdWOG0vxz6/IcvutWpOzi/O1g7+zKStD38J003mZr
         oDEVTHsxWb0TTQu34HASGRWLpLgUa1DqKPjxNSwXnGh9opP559HHl8ZC8nfWSVXGfr
         6NfDdBog4BofZQxYVZFwC5Ji6W/jhIlyWwymTwR77jTfkxl5Se3q7xnAJV+w4QJ049
         EZAeW5Wt5P47yECl3hrmY76xF7aHJhUnh1dsYLW2i79DP1q53KmJj1GMVmISPmP6Hd
         AgaQUMP4YYQvQ==
Received: by mail-lj1-f200.google.com with SMTP id j8-20020a2e3c08000000b00210e2890d61so601921lja.9
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 01:24:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Swi6Ddj8Xbp80QnpAWQNLdENzfNBX7zxXSg0uNaLjZ4=;
        b=4luJy9v88jCV9F9iZ+kyJrHLYdP2WGDXtX7+wXJiY7bH4EPGCl2blyQTqoyXE//5SQ
         ZZ0p8E47QmOI1EyKBIYbRHRMgTYKuG2vxtK4fPLn0vZu9hrr2BhwgCk6i0d+wHIkx7cM
         UDMrNwekcuOS4BcFAcPHOpeKhPz62CSpad7oLLHrxpYPy33/fDEsA3PBaT1KJ0FJNtRf
         TiVClJD013vz/tIvSR5s3e8WbRn4lDy1AJW0Bis2gz6T1p4uPCrXVTNgJnF7JS0NYitP
         QjrU6g5fCxmHBucMy36vBTxqzTJcwsNz3TsQh4FGBYfcr4WuZ1NYXzDmM8nW+/Ji674d
         2lpA==
X-Gm-Message-State: AOAM5303fshOiDovfygmWvJqs7/JXz4kp4aijrfiQdPqNGu8/KIWw1iS
        FU55zZ/nFhwvbxGrycoZoVVW4mtdJvlUEYtUq8R5MPEFdjz1fNVClSt40sRb6NNhu3b9Sar5Y0l
        p4iDB6MMMP1RUvy8WrKp7LmBRxNQeKLSAY5FYQAq5gA==
X-Received: by 2002:a2e:9c92:: with SMTP id x18mr5094992lji.445.1634631876046;
        Tue, 19 Oct 2021 01:24:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw/kAZBOxkypgv+WhYfxmIUQ9Io7rvWQf5Awb9V5Is54av5KHbiCRs1Zw9l65qYqDA79/DqWA==
X-Received: by 2002:a2e:9c92:: with SMTP id x18mr5094971lji.445.1634631875874;
        Tue, 19 Oct 2021 01:24:35 -0700 (PDT)
Received: from [192.168.3.161] (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id b43sm822485ljr.17.2021.10.19.01.24.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Oct 2021 01:24:35 -0700 (PDT)
Subject: Re: [PATCH v3 22/23] regulator: dt-bindings: update
 samsung,s5m8767.yaml reference
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org
References: <cover.1634630485.git.mchehab+huawei@kernel.org>
 <63f3ac8bc958d65e4f31ad4a0060c21a7038cbde.1634630486.git.mchehab+huawei@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <ac1445ce-8b60-c772-4c61-7cdfb8fe6ec6@canonical.com>
Date:   Tue, 19 Oct 2021 10:24:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <63f3ac8bc958d65e4f31ad4a0060c21a7038cbde.1634630486.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/10/2021 10:04, Mauro Carvalho Chehab wrote:
> The file name: Documentation/devicetree/bindings/mfd/samsung,s5m8767.yaml
> should be, instead: Documentation/devicetree/bindings/regulator/samsung,s5m8767.yaml.
> 
> Update its cross-reference accordingly.
> 
> Fixes: fab58debc137 ("regulator: dt-bindings: samsung,s5m8767: convert to dtschema")
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
> 
> To mailbombing on a large number of people, only mailing lists were C/C on the cover.
> See [PATCH v3 00/23] at: https://lore.kernel.org/all/cover.1634630485.git.mchehab+huawei@kernel.org/
> 
>  .../devicetree/bindings/regulator/samsung,s5m8767.yaml          | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/regulator/samsung,s5m8767.yaml b/Documentation/devicetree/bindings/regulator/samsung,s5m8767.yaml
> index 80a63d47790a..4281f670c775 100644
> --- a/Documentation/devicetree/bindings/regulator/samsung,s5m8767.yaml
> +++ b/Documentation/devicetree/bindings/regulator/samsung,s5m8767.yaml
> @@ -15,7 +15,7 @@ description: |
>  
>    The S5M8767 provides buck and LDO regulators.
>  
> -  See also Documentation/devicetree/bindings/mfd/samsung,s5m8767.yaml for
> +  See also Documentation/devicetree/bindings/regulator/samsung,s5m8767.yaml for
>    additional information and example.
>  
>  patternProperties:
> 


Hi Mauro,

Thanks for the patch but it is incorrect. Old path is proper, just the
patch waits on merging.

For this one: NAK.

Best regards,
Krzysztof
