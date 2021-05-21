Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6631A38BBA8
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 03:37:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237050AbhEUBir (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 21:38:47 -0400
Received: from mail-ot1-f48.google.com ([209.85.210.48]:38667 "EHLO
        mail-ot1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237001AbhEUBiq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 21:38:46 -0400
Received: by mail-ot1-f48.google.com with SMTP id i14-20020a9d624e0000b029033683c71999so5460661otk.5;
        Thu, 20 May 2021 18:37:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=PU0wqAPlfXa5ioTwymYq6yRTqRxt/LLzW8WseVv/Exo=;
        b=OnOtA/et5fM4nxVYg+tzAMcAJz+RkA8+gPpa0KT2EWbeXoRplAFRJCdQSs0IjofrQQ
         C0b5jO71wymfHnGesiT87nET8YVTETC/S5qDlStO8nhBxII4cJAZYF3r/KB818hEA1gs
         tXsqYsaLjeVHy3FxANpe5bFwu6qFna3NbrqP4OzMUgHQWo8iNCRcflrXCx/96q9SOAoQ
         COmyXOd1FS4/HA7GwvazzX7WzZUGBotFDHQUkWHFHOF3gRk/VbKozQTREsiTryHRUfSe
         fOQ5V2Gkcv2U71eACO9lIfUQ8tvj6gjEPm5d2cwHvyrP0j7hWAl1cHnq2fjMpztpg/gu
         +ZiA==
X-Gm-Message-State: AOAM531gi9KpopRP+u7yvi2vbKnqwgtjDd3ixZ/Ud345erLvuIVtSjHe
        M1z1l3kwA+sDRpyblv+GTw==
X-Google-Smtp-Source: ABdhPJzLevEdXk1J/LS6sp90IY4zxHV2okOGcnhpXvtdzFZ2I7YcOpoKuJRUBf4lqNmPYoivs6uhpw==
X-Received: by 2002:a9d:470e:: with SMTP id a14mr6173715otf.236.1621561043894;
        Thu, 20 May 2021 18:37:23 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id f8sm857214oos.33.2021.05.20.18.37.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 18:37:23 -0700 (PDT)
Received: (nullmailer pid 2455951 invoked by uid 1000);
        Fri, 21 May 2021 01:37:22 -0000
Date:   Thu, 20 May 2021 20:37:22 -0500
From:   Rob Herring <robh@kernel.org>
To:     Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linuxppc-dev@lists.ozlabs.org, devicetree@vger.kernel.org,
        Ash Logan <ash@heyquark.com>,
        Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.ne@posteo.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] dt-bindings: nintendo-otp: Document the Wii and
 Wii U OTP support
Message-ID: <20210521013722.GA2454145@robh.at.kernel.org>
References: <20210519095044.4109-1-linkmauve@linkmauve.fr>
 <20210519095044.4109-3-linkmauve@linkmauve.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210519095044.4109-3-linkmauve@linkmauve.fr>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 19, 2021 at 11:50:42AM +0200, Emmanuel Gil Peyrot wrote:
> Both of these consoles use the exact same two registers, even at the
> same address, but the Wii U has eight banks of 128 bytes memory while
> the Wii only has one, hence the two compatible strings.
> 
> Signed-off-by: Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
> ---
>  .../devicetree/bindings/nvmem/nintendo-otp.txt     | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/nvmem/nintendo-otp.txt

Bindings should be in DT schema format now.

> 
> diff --git a/Documentation/devicetree/bindings/nvmem/nintendo-otp.txt b/Documentation/devicetree/bindings/nvmem/nintendo-otp.txt
> new file mode 100644
> index 000000000000..b26d705ec52d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/nvmem/nintendo-otp.txt
> @@ -0,0 +1,14 @@
> +Nintendo Wii and Wii U OTP
> +
> +Required Properties:
> +- compatible: depending on the console this should be one of:
> +	- "nintendo,hollywood-otp" for the Wii
> +	- "nintendo,latte-otp" for the Wii U
> +- reg: base address and size of the OTP registers
> +
> +
> +Example:
> +	otp@d8001ec {
> +		compatible = "nintendo,latte-otp";
> +		reg = <0x0d8001ec 0x8>;
> +	};
> -- 
> 2.31.1
> 
