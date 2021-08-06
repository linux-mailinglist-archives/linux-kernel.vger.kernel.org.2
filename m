Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4244D3E30A4
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 23:07:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238549AbhHFVHq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 17:07:46 -0400
Received: from mail-io1-f48.google.com ([209.85.166.48]:40841 "EHLO
        mail-io1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231431AbhHFVHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 17:07:45 -0400
Received: by mail-io1-f48.google.com with SMTP id m13so13986457iol.7;
        Fri, 06 Aug 2021 14:07:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=2SKEqkCGO8SZF6WOXnVbncMlr9FaMp+IEHcaIiXZQRQ=;
        b=fAsegyGs8D6Y1Ti++AdCbE1fZchYbhmynuJEhPzFGRlXGoxFILrfIqQIb6OVxpV3Ya
         XBcr92V0euCyS46GYmp/9a/wzsG5oXu8xZ3FMTM9cb7cJkCu23SNEZaeeup3WF+OKL4z
         VJooFmDTflKcO53cW/8RjvL8AHa/SHAAXy04QL197sqBgOPFd+rdO12XxwAX0sBjGe4s
         4osRwm9HdLDV8Gikzqj79MMFGoGGuOPf8i1tApYxtAtT6OkByXo8MJ3B/Ivc0vAH8RCV
         AjXQd9ncekQnaR5I/6FfGzYRA+4JJV9ulR0wPAvoYRvlk+8Pj/1InUFU+mdCfYM6TIt2
         q6cA==
X-Gm-Message-State: AOAM5327XZQKt8EaM6QLlwrrSA6659KuPPPPue2bO6dsJizlylr5/ovx
        5Hcvoo1ZHKPrQ5Aw9NMkfQ==
X-Google-Smtp-Source: ABdhPJwndFJtx3b3ZDvSAkeey37JrPQb+hvwBzcT0Ovv8ZFy6MGxo+EtaiMARDc58qLubkKewF+wCg==
X-Received: by 2002:a05:6638:14d:: with SMTP id y13mr11762265jao.78.1628284047994;
        Fri, 06 Aug 2021 14:07:27 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id f7sm5152608ils.42.2021.08.06.14.07.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Aug 2021 14:07:27 -0700 (PDT)
Received: (nullmailer pid 1799495 invoked by uid 1000);
        Fri, 06 Aug 2021 21:07:25 -0000
Date:   Fri, 6 Aug 2021 15:07:25 -0600
From:   Rob Herring <robh@kernel.org>
To:     Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
Cc:     Paul Mackerras <paulus@samba.org>, Ash Logan <ash@heyquark.com>,
        linuxppc-dev@lists.ozlabs.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linux-kernel@vger.kernel.org,
        Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.ne@posteo.net>
Subject: Re: [PATCH v4 2/5] dt-bindings: nintendo-otp: Document the Wii and
 Wii U OTP support
Message-ID: <YQ2kja2CldN4ht+H@robh.at.kernel.org>
References: <20210701225743.14631-1-linkmauve@linkmauve.fr>
 <20210801073822.12452-1-linkmauve@linkmauve.fr>
 <20210801073822.12452-3-linkmauve@linkmauve.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210801073822.12452-3-linkmauve@linkmauve.fr>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 01 Aug 2021 09:38:19 +0200, Emmanuel Gil Peyrot wrote:
> Both of these consoles use the exact same two registers, even at the
> same address, but the Wii U has eight banks of 128 bytes memory while
> the Wii only has one, hence the two compatible strings.
> 
> Signed-off-by: Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
> ---
>  .../bindings/nvmem/nintendo-otp.yaml          | 44 +++++++++++++++++++
>  1 file changed, 44 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/nvmem/nintendo-otp.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
