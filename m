Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F5D33EAE27
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 03:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238207AbhHMB36 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 21:29:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237238AbhHMB34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 21:29:56 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DF5FC061756;
        Thu, 12 Aug 2021 18:29:30 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id bl13so4362196qvb.5;
        Thu, 12 Aug 2021 18:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d7y1hw5LdhKxpKxA/yXBN3ZJJ9yKaaGgYxkF16tEOMQ=;
        b=XgmjOaNQhbcCpvEmbZ5/zeX1bIUCgsvOXXufJ2DPyPwiVEcOXqrSKm7FQ6EHIiZPyf
         oLeOmGXFO5wc15/y2C90t9Vq9dPWNQ1zd0kaJv433461YrWvDUAzi2BBUezZlhb5C9cK
         XEDHQ5hrZEWfa+AOsbVJMlsxxBhsgTXh6Acys=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d7y1hw5LdhKxpKxA/yXBN3ZJJ9yKaaGgYxkF16tEOMQ=;
        b=hwMBouZ2mAgpiZBPsPK0s87Fi61zee7S4HNbnaDMNvzob1DRQGfY9debR7i8w3TLP2
         FZTwFBL8tGBmJSN9tmd0Xk0s/TXoW1YE5nbJGkkXESJE5+POsbbMswUU2Xockj0n8mat
         ZJFz+3XcfPrtgVT1X3FL9O3tyhx/VfLNX78bl728qlkxQHPgcjO8hKEXzSfQP0nZjVMK
         8mIKKDkygEqJBNq2b8C3K1mz+JcFLYWYOjVHbhWEvnJwIxF3FE8j5loKbBP6kV7/yyZr
         e5Rw5R5HJBKL3Z5AFBgNXsdQgfBPS3SYrrXhSd5SUVaEurlsy6t+Wd+RZTaui9vPIEU2
         c++g==
X-Gm-Message-State: AOAM5325GveBTe40moyQqInnfD4ywhI0Od0y8hpIvzwcAU6rjC3p5j9u
        pq1QAQFVwf6HogAjcr1XZe4a9JrXTZFN14msF4w=
X-Google-Smtp-Source: ABdhPJwhFLUqMIHIWOI/nCQlWmPOcdMRcHIRqjb8rAdMkprVxUulQ0uUl0tMgKhaIcL2vd8J9M1zxJmLtEpFhq9AfOM=
X-Received: by 2002:a0c:e6a4:: with SMTP id j4mr107833qvn.16.1628818169431;
 Thu, 12 Aug 2021 18:29:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210805222818.8391-1-rentao.bupt@gmail.com> <20210805222818.8391-5-rentao.bupt@gmail.com>
In-Reply-To: <20210805222818.8391-5-rentao.bupt@gmail.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Fri, 13 Aug 2021 01:29:17 +0000
Message-ID: <CACPK8XcV5On2D4D+SXnfw1M0owwfCL4Su19jOEA7yWpq+T3jLw@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] ARM: dts: aspeed: Add Facebook Cloudripper
 (AST2600) BMC
To:     Tao Ren <rentao.bupt@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Andrew Jeffery <andrew@aj.id.au>,
        devicetree <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Tao Ren <taoren@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Aug 2021 at 22:28, <rentao.bupt@gmail.com> wrote:
> +&mdio1 {
> +       status = "okay";

You're enabling this but it looks like it's unused?

> +};
> +
> +&mdio3 {
> +       status = "okay";
> +
> +       ethphy1: ethernet-phy@13 {
> +               compatible = "ethernet-phy-ieee802.3-c22";
> +               reg = <0x0d>;
> +       };
> +};
> +
> +&mac3 {
> +       status = "okay";
> +       phy-mode = "rgmii";
> +       phy-handle = <&ethphy1>;
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_rgmii4_default>;
> +};
