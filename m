Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77C64420763
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 10:37:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231526AbhJDIjH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 04:39:07 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:42626
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231491AbhJDIjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 04:39:05 -0400
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com [209.85.167.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 1DFB6402CC
        for <linux-kernel@vger.kernel.org>; Mon,  4 Oct 2021 08:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1633336634;
        bh=9ZwCtTzwSq1uVvj/tTRyEks425J4Fu+BkeRySbAum8A=;
        h=To:Cc:References:From:Subject:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=QmSh3bJcje6+E4yzaOJmPDHZY/x8Ce94IkVHixBQK2o7E0In8I+hW4KUaGI6XstZi
         auhX6cFnOFrAQfxskePlNmveNzc5+HnQXzNRLCNrgBpTL5ZJn/UD3IEQguhZ138jRZ
         ShkK/CUIjx0+CXJeAouAaiaz/k6X9tLSc4AyXPbUzq2PlE9UUlavy6m7tbpijgPj5I
         EeF4PvOx6P+jFCXJzWsBIeCBzahQCeJVCoyesAwkTR/I3rGjsZqQeeXkxp3cSi0VGV
         9/ryMvhseyrn/4C/nGfltmqaBkCc2h25RmWJYt4z24iyPQEpNVmNflSVSqZIhRA/HE
         bKlo/k1TVcT/w==
Received: by mail-lf1-f69.google.com with SMTP id t14-20020ac24c0e000000b003fd392f9a5eso1040957lfq.13
        for <linux-kernel@vger.kernel.org>; Mon, 04 Oct 2021 01:37:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9ZwCtTzwSq1uVvj/tTRyEks425J4Fu+BkeRySbAum8A=;
        b=wkEQD1FtTTJUnCr/t5p/CwyuKcXcazKK/1eB1hPcWLlf8BGxTjEcsbKVY1ine6rmJv
         12nTHQdEMlseZXgU2rZ+1HdAyZIX2VRoW3NPV+CYtJ3PJk1X78ZD9FC+XWjOiN/L+TF/
         4E6+kGITchoFtj9ZZXjNS6HNj22ebVGmbm2/Rd0XaYVF4U5iR/UuSp9kiTuCP/rfpo6G
         jVbWrHUHBRL1g1a1TRudhkKQdgle90GYWmAMkkMORMTWmpOTl83TqcNtDCAW75YDfxaG
         KtRsiNSbfT5Rfytj/WInx05yazKlJmn7yK5yJ4gwCh7mEb/y3uS8IRI0Es38d79QszRn
         KauQ==
X-Gm-Message-State: AOAM530LzWt7VgAxxGrU7RL9UkIpanGc1ngKoSRq5gSAGBHlWz/ys5/r
        T3qdQxqpIXNwbSPRIj3A+fdE8Q1UDuf3HmGx36fsYXjCIv25oUkKw9CtK43g53pqyUzsPFY4s6U
        tZrf20q/DNHidxh+PcTmEMGi8cq9IZNyDXjkkg3g3/A==
X-Received: by 2002:ac2:44a2:: with SMTP id c2mr4213103lfm.452.1633336633257;
        Mon, 04 Oct 2021 01:37:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzIpIoQvGRYSydgv8gO2smid6Br2zdF6PBc8gJBhHpLJls5rpiHdF7zMbh37bkAT9xl7GaGLQ==
X-Received: by 2002:ac2:44a2:: with SMTP id c2mr4213083lfm.452.1633336633008;
        Mon, 04 Oct 2021 01:37:13 -0700 (PDT)
Received: from [192.168.0.197] ([193.178.187.25])
        by smtp.gmail.com with ESMTPSA id a23sm1005122ljb.107.2021.10.04.01.37.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Oct 2021 01:37:12 -0700 (PDT)
To:     Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org
References: <20211003013235.2357-1-digetx@gmail.com>
 <20211003013235.2357-3-digetx@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: Re: [PATCH v3 2/4] dt-bindings: memory: tegra20: emc: Document new
 LPDDR2 sub-node
Message-ID: <a3713f62-0ece-5ab2-f55a-3d614ce01c00@canonical.com>
Date:   Mon, 4 Oct 2021 10:37:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211003013235.2357-3-digetx@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/10/2021 03:32, Dmitry Osipenko wrote:
> Some Tegra20 boards don't have RAM code stored in NVMEM, which is used for
> the memory chip identification and the identity information should be read
> out from LPDDR2 chip in this case. Document new sub-node containing generic
> LPDDR2 properties that will be used for the memory chip identification if
> RAM code isn't available. The identification is done by reading out memory
> configuration values from generic LPDDR2 mode registers of SDRAM chip and
> comparing them with the values of device-tree sub-node's.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  .../memory-controllers/nvidia,tegra20-emc.yaml  | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra20-emc.yaml b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra20-emc.yaml
> index cac6842dc8f1..65f7c3898ac4 100644
> --- a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra20-emc.yaml
> +++ b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra20-emc.yaml
> @@ -164,13 +164,14 @@ patternProperties:
>        "#size-cells":
>          const: 0
>  
> +      lpddr2-configuration:

Nodes should be named generic, so just lpddr2?


> +        $ref: "jedec,lpddr2.yaml#"
> +        type: object
> +
>      patternProperties:
>        "^emc-table@[0-9]+$":
>          $ref: "#/$defs/emc-table"
>  
> -    required:
> -      - nvidia,ram-code

Isn't lpddr2-configuration required in such case? If not, probably you
want either this or that (oneOf like in reserved-memory.yaml).

> -
>      additionalProperties: false
>  
>  required:
> @@ -186,6 +187,8 @@ additionalProperties: false
>  
>  examples:
>    - |
> +    #include <dt-bindings/memory/lpddr2.h>
> +
>      external-memory-controller@7000f400 {
>          compatible = "nvidia,tegra20-emc";
>          reg = <0x7000f400 0x400>;
> @@ -226,5 +229,13 @@ examples:
>                          0x007fe010 0x00001414 0x00000000 0x00000000
>                          0x00000000 0x00000000 0x00000000 0x00000000>;
>              };
> +
> +            lpddr2-configuration {
> +                jedec,lpddr2-manufacturer-id = <LPDDR2_MANID_ELPIDA>;
> +                jedec,lpddr2-revision-id1 = <1>;
> +                jedec,lpddr2-density-mbits = <2048>;
> +                jedec,lpddr2-io-width-bits = <16>;
> +                jedec,lpddr2-type = <LPDDR2_TYPE_S4>;
> +            };
>          };
>      };
> 


Best regards,
Krzysztof
