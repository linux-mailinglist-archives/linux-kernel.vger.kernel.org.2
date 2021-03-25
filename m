Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4183A3498B5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 18:53:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbhCYRxX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 13:53:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:50410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230147AbhCYRwl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 13:52:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AB16B61A2D;
        Thu, 25 Mar 2021 17:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616694760;
        bh=u+TWH/y7jPfMqOJaT4wpeN0p1XcgumenIiiPtuB71Ls=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=IOn9OeVuttIhi8bX3v12cDImvXxIFptEWBdG5JjYYIoC1Hwq+YX2tLeSvXdFqmYZu
         A8s5QQ2wPSmVNyd8NEaeMJqxmKcS6w01VX7er4T0sVklcHEzyupKeF+73W5J7cKYO3
         KW42wfLegnyrkgyxWet0XU9UvY/cp0QCb3CKDafx2UY/66CC+MxRUdBhcZNv7id6bq
         R+blkDlAztt5Y/mM9td5rSpzeVqKCGEKNqV8wGp9h90Nf5KCvDg8gkYp+9Dwlszbbj
         gZTluHWR9HX9bessyHb5gL23MtMQBs4gWiC8REX7Uw4qKuqMN0Q6nHJ0adZ+5Eb4mc
         fD+e+OTLVJp2Q==
Date:   Thu, 25 Mar 2021 18:52:35 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: Re: [PATCH 5/8] docs: dt: Group DT docs into relevant sub-sections
Message-ID: <20210325185235.0e568bd3@coco.lan>
In-Reply-To: <20210325164713.1296407-6-robh@kernel.org>
References: <20210325164713.1296407-1-robh@kernel.org>
        <20210325164713.1296407-6-robh@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, 25 Mar 2021 10:47:10 -0600
Rob Herring <robh@kernel.org> escreveu:

> The DT docs are currently all just lumped together in the doc build.
> Let's organize the documents by kernel specifics, overlays and bindings.
> 
> As writing-schema.rst is about bindings, let's move it to the bindings
> directory.
> 
> Cc: Frank Rowand <frowand.list@gmail.com>
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>

Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/index.rst      |  7 ++-----
>  .../devicetree/{ => bindings}/writing-schema.rst |  0
>  Documentation/devicetree/index.rst               | 16 ++++++++++++++--
>  3 files changed, 16 insertions(+), 7 deletions(-)
>  rename Documentation/devicetree/{ => bindings}/writing-schema.rst (100%)
> 
> diff --git a/Documentation/devicetree/bindings/index.rst b/Documentation/devicetree/bindings/index.rst
> index 3837b17c234f..d9002a3a0abb 100644
> --- a/Documentation/devicetree/bindings/index.rst
> +++ b/Documentation/devicetree/bindings/index.rst
> @@ -1,12 +1,9 @@
>  .. SPDX-License-Identifier: GPL-2.0
>  
> -===========
> -Device Tree
> -===========
> -
>  .. toctree::
>     :maxdepth: 1
>  
>     ABI
> -   submitting-patches
>     writing-bindings
> +   writing-schema
> +   submitting-patches
> diff --git a/Documentation/devicetree/writing-schema.rst b/Documentation/devicetree/bindings/writing-schema.rst
> similarity index 100%
> rename from Documentation/devicetree/writing-schema.rst
> rename to Documentation/devicetree/bindings/writing-schema.rst
> diff --git a/Documentation/devicetree/index.rst b/Documentation/devicetree/index.rst
> index 32509e8de8da..70b5dcdbcf07 100644
> --- a/Documentation/devicetree/index.rst
> +++ b/Documentation/devicetree/index.rst
> @@ -4,14 +4,26 @@
>  Open Firmware and Devicetree
>  =============================
>  
> +Kernel Devicetree Usage
> +=======================
>  .. toctree::
>     :maxdepth: 1
>  
>     usage-model
> -   writing-schema
> +   of_unittest
> +
> +Devicetree Overlays
> +===================
> +.. toctree::
> +   :maxdepth: 1
> +
>     changesets
>     dynamic-resolution-notes
> -   of_unittest
>     overlay-notes
>  
> +Devicetree Bindings
> +===================
> +.. toctree::
> +   :maxdepth: 1
> +
>     bindings/index



Thanks,
Mauro
