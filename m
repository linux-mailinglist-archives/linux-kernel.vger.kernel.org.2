Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 420113498AC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 18:52:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbhCYRwQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 13:52:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:50266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230097AbhCYRvw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 13:51:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 83CEF61A2A;
        Thu, 25 Mar 2021 17:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616694712;
        bh=fTvHMi2KqwzRHzBkbbtVaeFW5b141mCJbvUhsPdMsoE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=H47Yjl+WQlgdgbF/034LchsDV2/f+Tjb//xEzdks0B2QFjprfR4q8b97YhQYpZj3r
         +DmjyCkIdeGAtuP/7xi1ITMwrSlV2vRgZmXk6coA850P8NScTu+MLd1nKhxbrg5QHt
         ob45KjqK+btafhzBecLVM1WmHyPWE2DQoif6Zi1EiHAWpDKCLMeGHSnqcqLBmWNY1X
         vX7n0GQsMNXEAU9X+Lh+TR/rakXu0CIvVFkgllhzvXlSbIORWAPoGKlwUq4Gmx9Qep
         MXRQoeMq2u13INcwUHbTcU3wGITZIo/XVr2Dpvozc101Eb8urL+2LHxqzFmykya00J
         8EYg+qiSLCv3Q==
Date:   Thu, 25 Mar 2021 18:51:47 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: Re: [PATCH 2/8] docs: dt: writing-schema: Remove spurious
 indentation
Message-ID: <20210325185147.0cdf304b@coco.lan>
In-Reply-To: <20210325164713.1296407-3-robh@kernel.org>
References: <20210325164713.1296407-1-robh@kernel.org>
        <20210325164713.1296407-3-robh@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, 25 Mar 2021 10:47:07 -0600
Rob Herring <robh@kernel.org> escreveu:

> 'allOf' and 'properties' have a leading space which causes them to be
> indented in the doc output.
> 
> Cc: Frank Rowand <frowand.list@gmail.com>
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>

Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/writing-schema.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/writing-schema.rst b/Documentation/devicetree/writing-schema.rst
> index 16f21e182ff6..03e279d8fd6a 100644
> --- a/Documentation/devicetree/writing-schema.rst
> +++ b/Documentation/devicetree/writing-schema.rst
> @@ -46,12 +46,12 @@ select
>    schema. By default without 'select', nodes are matched against their possible
>    compatible string values or node name. Most bindings should not need select.
>  
> - allOf
> +allOf
>    Optional. A list of other schemas to include. This is used to
>    include other schemas the binding conforms to. This may be schemas for a
>    particular class of devices such as I2C or SPI controllers.
>  
> - properties
> +properties
>    A set of sub-schema defining all the DT properties for the
>    binding. The exact schema syntax depends on whether properties are known,
>    common properties (e.g. 'interrupts') or are binding/vendor specific properties.



Thanks,
Mauro
