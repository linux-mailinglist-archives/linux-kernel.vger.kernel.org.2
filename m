Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C50113498BF
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 18:54:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbhCYRxs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 13:53:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:50704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230108AbhCYRxc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 13:53:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 647A961A2A;
        Thu, 25 Mar 2021 17:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616694812;
        bh=BW+pUsQgH25Awv1xkED4cmTlWwY4Ud/NboxKfzBsaxE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=IbKi/ujZFxLqTB+m2pzKOVBiVulYvuouJoSULd/szSVl84/VVyWrZIqH+PzhzVdFN
         xxMLdjup32lSbZlCfmtxeOR44wvwq5AQIRt8TXFON60IDCQhcaKTCfAF9m8A3urfKf
         2ms1rWefp7yQDFeTwtPmmkYPxtjIqkHVuTr/DKgAu/4IRXLJsbJRThSmTpu2x6dAgW
         HynwiqqBdZttdOrUezD5RkhVuXV/UFNI+hgo1ELOEhVul09l/tt/8MYI6qRicjyARw
         abe7/Fq+R2zRvn/eMzomfImws/T8t0FKLs3KMefZwu0kUCjK9F9HEBL4lexweSUKGR
         o2UxQUKUU/GgQ==
Date:   Thu, 25 Mar 2021 18:53:26 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: Re: [PATCH 8/8] docs: dt: Add DT API documentation
Message-ID: <20210325185326.431030c8@coco.lan>
In-Reply-To: <20210325164713.1296407-9-robh@kernel.org>
References: <20210325164713.1296407-1-robh@kernel.org>
        <20210325164713.1296407-9-robh@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, 25 Mar 2021 10:47:13 -0600
Rob Herring <robh@kernel.org> escreveu:

> The kernel-doc for the DT APIs are not included in the documentation
> build. Add them.
> 
> Cc: Frank Rowand <frowand.list@gmail.com>
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>

Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/index.rst      |  1 +
>  Documentation/devicetree/kernel-api.rst | 57 +++++++++++++++++++++++++
>  2 files changed, 58 insertions(+)
>  create mode 100644 Documentation/devicetree/kernel-api.rst
> 
> diff --git a/Documentation/devicetree/index.rst b/Documentation/devicetree/index.rst
> index 70b5dcdbcf07..1a2fc8014996 100644
> --- a/Documentation/devicetree/index.rst
> +++ b/Documentation/devicetree/index.rst
> @@ -11,6 +11,7 @@ Kernel Devicetree Usage
>  
>     usage-model
>     of_unittest
> +   kernel-api
>  
>  Devicetree Overlays
>  ===================
> diff --git a/Documentation/devicetree/kernel-api.rst b/Documentation/devicetree/kernel-api.rst
> new file mode 100644
> index 000000000000..b7429e6ed6d5
> --- /dev/null
> +++ b/Documentation/devicetree/kernel-api.rst
> @@ -0,0 +1,57 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +.. _devicetree:
> +
> +======================================
> +DeviceTree Kernel API
> +======================================
> +
> +Core functions
> +--------------
> +
> +.. kernel-doc:: drivers/of/base.c
> +   :export:
> +
> +.. kernel-doc:: include/linux/of.h
> +   :internal:
> +
> +.. kernel-doc:: drivers/of/property.c
> +   :export:
> +
> +.. kernel-doc:: include/linux/of_graph.h
> +   :internal:
> +
> +.. kernel-doc:: drivers/of/address.c
> +   :export:
> +
> +.. kernel-doc:: drivers/of/irq.c
> +   :export:
> +
> +.. kernel-doc:: drivers/of/fdt.c
> +   :export:
> +
> +Driver model functions
> +----------------------
> +
> +.. kernel-doc:: include/linux/of_device.h
> +   :internal:
> +
> +.. kernel-doc:: drivers/of/device.c
> +   :export:
> +
> +.. kernel-doc:: include/linux/of_platform.h
> +   :internal:
> +
> +.. kernel-doc:: drivers/of/platform.c
> +   :export:
> +
> +Overlay and Dynamic DT functions
> +--------------------------------
> +
> +.. kernel-doc:: drivers/of/resolver.c
> +   :export:
> +
> +.. kernel-doc:: drivers/of/dynamic.c
> +   :export:
> +
> +.. kernel-doc:: drivers/of/overlay.c
> +   :export:



Thanks,
Mauro
