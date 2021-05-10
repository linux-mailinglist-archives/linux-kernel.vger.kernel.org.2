Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55619378DEB
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 15:48:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350236AbhEJM4y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 08:56:54 -0400
Received: from foss.arm.com ([217.140.110.172]:56736 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347822AbhEJMh0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 08:37:26 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 89F4715BE;
        Mon, 10 May 2021 05:36:21 -0700 (PDT)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 69A1E3F73B;
        Mon, 10 May 2021 05:36:21 -0700 (PDT)
Received: by e110455-lin.cambridge.arm.com (Postfix, from userid 1000)
        id 29145683931; Mon, 10 May 2021 13:36:20 +0100 (BST)
Date:   Mon, 10 May 2021 13:36:20 +0100
From:   Liviu Dudau <liviu.dudau@arm.com>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Jonathan Corbet <corbet@lwn.net>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        David Airlie <airlied@linux.ie>,
        "James (Qian) Wang" <james.qian.wang@arm.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Mali DP Maintainers <malidp@foss.arm.com>,
        Mihail Atanassov <mihail.atanassov@arm.com>,
        intel-gfx@lists.freedesktop.org
Subject: Re: [PATCH 44/53] docs: gpu: avoid using UTF-8 chars
Message-ID: <YJkoxKE2+hG5BsPI@e110455-lin.cambridge.arm.com>
References: <cover.1620641727.git.mchehab+huawei@kernel.org>
 <36bc1118467da645a57515743c9f6c1cd86abe8c.1620641727.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <36bc1118467da645a57515743c9f6c1cd86abe8c.1620641727.git.mchehab+huawei@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 10, 2021 at 12:26:56PM +0200, Mauro Carvalho Chehab wrote:
> While UTF-8 characters can be used at the Linux documentation,
> the best is to use them only when ASCII doesn't offer a good replacement.
> So, replace the occurences of the following UTF-8 characters:
> 
> 	- U+2019 ('’'): RIGHT SINGLE QUOTATION MARK
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  Documentation/gpu/i915.rst       | 2 +-
>  Documentation/gpu/komeda-kms.rst | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/gpu/i915.rst b/Documentation/gpu/i915.rst
> index 486c720f3890..2cbf54460b48 100644
> --- a/Documentation/gpu/i915.rst
> +++ b/Documentation/gpu/i915.rst
> @@ -361,7 +361,7 @@ Locking Guidelines
>  	  real bad.
>  
>  #. Do not nest different lru/memory manager locks within each other.
> -   Take them in turn to update memory allocations, relying on the object’s
> +   Take them in turn to update memory allocations, relying on the object's
>     dma_resv ww_mutex to serialize against other operations.
>  
>  #. The suggestion for lru/memory managers locks is that they are small
> diff --git a/Documentation/gpu/komeda-kms.rst b/Documentation/gpu/komeda-kms.rst
> index eb693c857e2d..c2067678e92c 100644
> --- a/Documentation/gpu/komeda-kms.rst
> +++ b/Documentation/gpu/komeda-kms.rst
> @@ -324,7 +324,7 @@ the control-abilites of device.
>  
>  We have &komeda_dev, &komeda_pipeline, &komeda_component. Now fill devices with
>  pipelines. Since komeda is not for D71 only but also intended for later products,
> -of course we’d better share as much as possible between different products. To
> +of course we'd better share as much as possible between different products. To
>  achieve this, split the komeda device into two layers: CORE and CHIP.
>  
>  -   CORE: for common features and capabilities handling.

Acked-by: Liviu Dudau <liviu.dudau@arm.com>

Best regards,
Liviu

> -- 
> 2.30.2
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯
