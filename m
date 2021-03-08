Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F25433149B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 18:22:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbhCHRWT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 12:22:19 -0500
Received: from mail-il1-f177.google.com ([209.85.166.177]:33477 "EHLO
        mail-il1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230342AbhCHRV4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 12:21:56 -0500
Received: by mail-il1-f177.google.com with SMTP id e2so9566129ilu.0;
        Mon, 08 Mar 2021 09:21:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=I9C+IFyr33dAu9Kqcftozrt07hiCQ7Ix1pjgeavX26Q=;
        b=jc4Qst6TASQDMFtitz0DtEa0TVZELxFZBzI/prz4sMwlhzZICJ65nzM8XzfxCxErx5
         83l2A2ico26yIENBAFzQxHYJNIXUwB/a1Qi2+4QvcGqxVAufD2uwzqEXRmtn/50cGKdG
         N2QBDIiT8g/cSJ7wYmJiERkcMhAt9CuW+NbFRFbTDWzt8gbi79uN61VdSnQoTZ+7cEO0
         TPE/U49jPm8wh+PF61eCLC2+TTyO6v/saP4oj2EiKJ4Xs/lfcAiQYmNinQG05yJ1dU64
         FrJehEWCFN48kFNnvCJDpY61lR0TmwhmkTiJ2ME/9b8A1GCV2VXjka9eVgcx1sJpSPAD
         NTtQ==
X-Gm-Message-State: AOAM532xcmVwndcuPyhn+dqHSkwXDKbsjALK4MNQRx9CgGHXeeQ8fw+8
        Q4yOcfMnu9xXJPqgfiUr7VzJ6WMdhg==
X-Google-Smtp-Source: ABdhPJzSGdpR3ERyKpm3ixPrSK/LkiqVL91XK7jo+nbZKT9ATyTGtIJ4/k8iwQSs/INijl6TegVgUQ==
X-Received: by 2002:a92:c641:: with SMTP id 1mr22296948ill.94.1615224115555;
        Mon, 08 Mar 2021 09:21:55 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id w13sm6392957ilg.48.2021.03.08.09.21.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 09:21:54 -0800 (PST)
Received: (nullmailer pid 2655238 invoked by uid 1000);
        Mon, 08 Mar 2021 17:21:53 -0000
Date:   Mon, 8 Mar 2021 10:21:53 -0700
From:   Rob Herring <robh@kernel.org>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, linux-clk@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: misc: add binding for generic ripple
 counter
Message-ID: <20210308172153.GA2505339@robh.at.kernel.org>
References: <20210226141411.2517368-1-linux@rasmusvillemoes.dk>
 <20210226141411.2517368-2-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210226141411.2517368-2-linux@rasmusvillemoes.dk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 26, 2021 at 03:14:10PM +0100, Rasmus Villemoes wrote:
> While a ripple counter can not usually be interfaced with (directly)
> from software, it may still be a crucial component in a board
> layout. To prevent its input clock from being disabled by the clock
> core because it apparently has no consumer, one needs to be able to
> represent that consumer in DT.

I'm okay with this as it is describing h/w, but we already 
'protected-clocks' property which should work.

> 
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> ---
>  Documentation/devicetree/bindings/misc/ripple-ctr.txt | 8 ++++++++
>  1 file changed, 8 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/misc/ripple-ctr.txt
> 
> diff --git a/Documentation/devicetree/bindings/misc/ripple-ctr.txt b/Documentation/devicetree/bindings/misc/ripple-ctr.txt
> new file mode 100644
> index 000000000000..1497d3a237a7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/misc/ripple-ctr.txt
> @@ -0,0 +1,8 @@
> +Generic ripple counter
> +
> +A ripple counter is a simple component that can for example be used to
> +delay propagation of a signal.
> +
> +Required properties:
> +- compatible: Must be "linux,ripple-ctr".

Nothing linux specific about this.

> +- clocks: Input clock specifier. Refer to common clock bindings.
> -- 
> 2.29.2
> 
