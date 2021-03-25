Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C39C3498A9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 18:52:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbhCYRwK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 13:52:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:50138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229984AbhCYRvg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 13:51:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BED6161A2C;
        Thu, 25 Mar 2021 17:51:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616694695;
        bh=bmKxrcFDO8ybGPOlzXlm6/h98h3ySnqnnUu1RE7ZX+Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lAUzytZ6PsI9epCm3u6lfwfiIBC4noQP2C9dNI7W74yWygAElbOfFu3M4qIbRL439
         FbRASoYr9+fNhfpTqB1/jJMXGLn2n73l8bVO++FuoDM1r62deP4bYQfS8SIfLkX6s9
         7E70XvXsTq5CXs5liywP9aqe1Pz0kCkguB8bfuHYFL6Snfvz42QZCrbstPdSUSKrID
         yAdSH6CiBn1rqfORwA3xtJJnVGb+eTMM3fd2QI7dXgwPktjyFKuL40QiKopfE1ZA7E
         LWF624yHIwoEJ85UMEa10TGepEYBXxLEytWU2zn6enWVrvQE3W0MoLRimpWyOOgG6A
         BgHyTk+D9s5Zw==
Date:   Thu, 25 Mar 2021 18:51:31 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: Re: [PATCH 1/8] dt-bindings: Fix reference in
 submitting-patches.rst to the DT ABI doc
Message-ID: <20210325185131.14e65c31@coco.lan>
In-Reply-To: <20210325164713.1296407-2-robh@kernel.org>
References: <20210325164713.1296407-1-robh@kernel.org>
        <20210325164713.1296407-2-robh@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, 25 Mar 2021 10:47:06 -0600
Rob Herring <robh@kernel.org> escreveu:

> submitting-patches.rst has a stale reference to ABI.txt. Fix this with a
> proper rSt link.
> 
> Cc: Frank Rowand <frowand.list@gmail.com>
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> Signed-off-by: Rob Herring <robh@kernel.org>

Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

> ---
>  Documentation/devicetree/bindings/submitting-patches.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/submitting-patches.rst b/Documentation/devicetree/bindings/submitting-patches.rst
> index 68129ff09967..42e86f978be2 100644
> --- a/Documentation/devicetree/bindings/submitting-patches.rst
> +++ b/Documentation/devicetree/bindings/submitting-patches.rst
> @@ -84,7 +84,7 @@ II. For kernel maintainers
>  III. Notes
>  ==========
>  
> -  0) Please see ...bindings/ABI.txt for details regarding devicetree ABI.
> +  0) Please see :doc:`ABI` for details regarding devicetree ABI.
>  
>    1) This document is intended as a general familiarization with the process as
>       decided at the 2013 Kernel Summit.  When in doubt, the current word of the



Thanks,
Mauro
