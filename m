Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E34213C9F5E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 15:18:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237478AbhGONV3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 09:21:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:30340 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237112AbhGONV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 09:21:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626355115;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0xpUm/bZf/gJUFnUOsgmJ47taBTH+Qv6PQ/m3LfGTGw=;
        b=N3kUHg1VFGs4xc5TMFMKl2jJHP+LkPU3qK0+SKJQHKDxyZu2w8CMjw23r6QAE+v6lSKH98
        7oZkDNTV2v6O8i2ApU9Le9jL70P+RDkzQ3K6nz49Dq3T5z+feGAss9vBnUn2g/kVlSVfhl
        YeqAly4QZ16DR0xnt0JwN8HReQjA5do=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-140-pvaPskzENuqIf8ILZlauwQ-1; Thu, 15 Jul 2021 09:18:33 -0400
X-MC-Unique: pvaPskzENuqIf8ILZlauwQ-1
Received: by mail-qv1-f69.google.com with SMTP id p6-20020a05621415c6b02902f61b4b012eso3119356qvz.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 06:18:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=0xpUm/bZf/gJUFnUOsgmJ47taBTH+Qv6PQ/m3LfGTGw=;
        b=RJRH0SGGZeOZM3kDSsW0ZWeWiDfCQQaw/qybW2vZVp0tZRIeflbthZRs4gQvIHFuy/
         Sk113tdzC0DT6aJ73piti3SEa0t1ucMGl9B335Vz3qw2Mr1GMhklNDQ1RuXkuR2nIdF6
         V0pJ4Br5JYqLnnWDtA444md+IL8Sy7/d71aZ8xO5RKWVQiliDNmUZjS7Od6BxYPKUuxM
         1ksgb03ZUliswtPSlsEXKiRNLXj5IlDN9MCprr76UZhZWxzyPrR6TX9bNkpqhCg5TLei
         FZXHd2yi3U7qG4gssWp1tEK+h7leyphbQJAAVFk2tzC9KYY5xR1qBlJdwohFqDTNBuZ3
         Uquw==
X-Gm-Message-State: AOAM532NeBW5E/QJVfqL+vGnJWTjmTUlNITPTvRuCTrc6bDFDaZOOwRG
        ITHJuFXh6F2kCa2KaYBM2HfIsY42Jz7TY+8qALx40azDS9OPiXXG0/AwD/bnXp3zmb6K55hA2Sx
        +U/7fHL3AHXHtWgJ2N3Q5H4ND
X-Received: by 2002:a05:6214:7cf:: with SMTP id bb15mr4351650qvb.29.1626355113183;
        Thu, 15 Jul 2021 06:18:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwvOYGQHwP4m9K0OvynsEmDNkxDs2xY5R/rJGf0uAm0tyiz1L5gf7DU/xLnn7JerWoBsO1R8w==
X-Received: by 2002:a05:6214:7cf:: with SMTP id bb15mr4351636qvb.29.1626355112992;
        Thu, 15 Jul 2021 06:18:32 -0700 (PDT)
Received: from localhost.localdomain (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id d25sm2005088qtw.59.2021.07.15.06.18.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jul 2021 06:18:31 -0700 (PDT)
Subject: Re: [PATCH] dt-bindings: fpga: convert Xilinx Zynq MPSoC bindings to
 YAML
To:     Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, robh+dt@kernel.org,
        michal.simek@xilinx.com, mdf@kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org
References: <20210715100236.228531-1-iwamatsu@nigauri.org>
From:   Tom Rix <trix@redhat.com>
Message-ID: <f78e471c-8f08-4ef6-667b-1c8484baf60a@redhat.com>
Date:   Thu, 15 Jul 2021 06:18:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210715100236.228531-1-iwamatsu@nigauri.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/15/21 3:02 AM, Nobuhiro Iwamatsu wrote:
> Convert FPGA Manager for Xilinx Zynq MPSoC bindings documentation to
> YAML.
>
> Signed-off-by: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
> ---
>   .../bindings/fpga/xlnx,zynqmp-pcap-fpga.txt   | 25 -------------
>   .../bindings/fpga/xlnx,zynqmp-pcap-fpga.yaml  | 36 +++++++++++++++++++
>   2 files changed, 36 insertions(+), 25 deletions(-)
>   delete mode 100644 Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.txt
>   create mode 100644 Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.yaml
>
> diff --git a/Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.txt b/Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.txt
> deleted file mode 100644
> index 3052bf619dd547..00000000000000
> --- a/Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.txt
> +++ /dev/null
> @@ -1,25 +0,0 @@
> -Devicetree bindings for Zynq Ultrascale MPSoC FPGA Manager.
> -The ZynqMP SoC uses the PCAP (Processor configuration Port) to configure the
> -Programmable Logic (PL). The configuration uses  the firmware interface.
> -
> -Required properties:
> -- compatible: should contain "xlnx,zynqmp-pcap-fpga"
> -
> -Example for full FPGA configuration:
> -
> -	fpga-region0 {
> -		compatible = "fpga-region";
> -		fpga-mgr = <&zynqmp_pcap>;
> -		#address-cells = <0x1>;
> -		#size-cells = <0x1>;
> -	};
> -
> -	firmware {
> -		zynqmp_firmware: zynqmp-firmware {
> -			compatible = "xlnx,zynqmp-firmware";
> -			method = "smc";
> -			zynqmp_pcap: pcap {
> -				compatible = "xlnx,zynqmp-pcap-fpga";
> -			};
> -		};
> -	};
> diff --git a/Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.yaml b/Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.yaml
> new file mode 100644
> index 00000000000000..565b835b7fbac0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.yaml
> @@ -0,0 +1,36 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/fpga/xlnx,zynqmp-pcap-fpga.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Xilinx Zynq Ultrascale MPSoC FPGA Manager Device Tree Bindings
> +
> +maintainers:
> +  - Michal Simek <michal.simek@xilinx.com>
Needs a change to MAINTAINERS ?
> +
> +description: |
> +  Device Tree Bindings for Zynq Ultrascale MPSoC FPGA Manager.
> +  The ZynqMP SoC uses the PCAP (Processor configuration Port) to

Configuration

Tom

> +  configure the Programmable Logic (PL). The configuration uses the
> +  firmware interface.
> +
> +properties:
> +  compatible:
> +    const: xlnx,zynqmp-pcap-fpga
> +
> +required:
> +  - compatible
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    firmware {
> +      zynqmp_firmware: zynqmp-firmware {
> +        zynqmp_pcap: pcap {
> +          compatible = "xlnx,zynqmp-pcap-fpga";
> +        };
> +      };
> +    };
> +...

