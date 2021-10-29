Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B11A543F4AD
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 03:56:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231436AbhJ2B6m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 21:58:42 -0400
Received: from mail-oi1-f174.google.com ([209.85.167.174]:39741 "EHLO
        mail-oi1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231281AbhJ2B6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 21:58:39 -0400
Received: by mail-oi1-f174.google.com with SMTP id n11so3025495oig.6;
        Thu, 28 Oct 2021 18:56:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oYU1YcRcY5AH8rpowyG9n6NnTxomX0k9iKpp8Ots/X8=;
        b=LzL4Wd5zH07H4rUK67eZri770x5K9/xm0lfE7Jv83fE3+Jn2/C23YALDmhGyVIy8wt
         8A8ASDdBXFd14LZIuyOfrJkjwTlgTYXA0kUfCkAw9mhChxLK0Ncyt6JpkX05PlA8gqrE
         oL6RiJFfBiwn/V5EkI9QFXhrYmZcoSi9Lw54B/egfQBEKusJaf/EtstWaHSrc7KhhQ36
         9jhFkBuslKW2OPE7Zpi+PH6Nn0jtr53IvRKReJGZancF7XUsnYmsm2yvZOOF3zsdlV3Z
         aG1t6yDg9W1aruXNKrtfnie7w7KZiBhkem7Ir+qvFQfB4uGQFgl4rg0BjfgCfGkdlsyu
         TRHQ==
X-Gm-Message-State: AOAM530wLlOjC+TOsRDtjnAr3GY5E1Y7PGh8xkB0m5IA/GYMUDknfTXS
        NtPd8WyVKzCSnyQlKRXFdQ==
X-Google-Smtp-Source: ABdhPJw263Mo6hPnmuyL4VA3LWInj+/Pbag7DyHYiNzCCgaVdcaQJ1dtJ/g69JuL2RkCf78F/apobQ==
X-Received: by 2002:a05:6808:1a27:: with SMTP id bk39mr11724071oib.89.1635472571843;
        Thu, 28 Oct 2021 18:56:11 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id 46sm1526386otd.2.2021.10.28.18.56.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 18:56:11 -0700 (PDT)
Received: (nullmailer pid 996742 invoked by uid 1000);
        Fri, 29 Oct 2021 01:56:10 -0000
Date:   Thu, 28 Oct 2021 20:56:10 -0500
From:   Rob Herring <robh@kernel.org>
To:     qinjian <qinjian@cqplus1.com>
Cc:     p.zabel@pengutronix.de, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] dt-bindings: clock: Add bindings for SP7021 reset
 driver
Message-ID: <YXtUujrvSABZCPqL@robh.at.kernel.org>
References: <20211022061216.281903-1-qinjian@cqplus1.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211022061216.281903-1-qinjian@cqplus1.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 22, 2021 at 02:12:16PM +0800, qinjian wrote:
> Add documentation to describe Sunplus SP7021 reset driver bindings.

The subject should be 'reset', not 'clocks'.

> 
> Signed-off-by: qinjian <qinjian@cqplus1.com>
> ---
>  .../bindings/reset/sunplus,reset.yaml         | 40 ++++++++
>  MAINTAINERS                                   |  2 +
>  include/dt-bindings/reset/sp-sp7021.h         | 99 +++++++++++++++++++
>  3 files changed, 141 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/reset/sunplus,reset.yaml
>  create mode 100644 include/dt-bindings/reset/sp-sp7021.h

With that fixed,

Reviewed-by: Rob Herring <robh@kernel.org>
