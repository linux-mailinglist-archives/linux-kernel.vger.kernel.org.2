Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3D293498AF
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 18:53:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230120AbhCYRwn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 13:52:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:50344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230113AbhCYRwL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 13:52:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5874D61A2C;
        Thu, 25 Mar 2021 17:52:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616694731;
        bh=hmocFGPZAU29mExog+Yco+ObLadWafpsYzzec6xWfRM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JC6vOCPceqf3RxxEJCzwzv0I9bN3rijhd0FH1wg6NWvJ2mAsoCQA8Fv6blTZvGIiG
         3k6EeztvmsQvZayCfuJZ6XnD6PwDSiDUQpKsqFCl4kLOecsPunpJH7sS4WRf5ZAV5n
         c3OcOC7OrQtTrXQdKFb8cgrGq7k1/c6NwlU50ge4kMXm/eKu8MHTWl9mTFbHGowdJC
         RKXUwUTVFYckhUoBdnQSusgjFyNBVeBvapKQylPorI8HTq9ijfDxXR/JZo5Uj1/Z58
         4GeaV+0TsJTg5+nFCcLf91MM2R1IGpPQsctxslSivDnr+8YUoAd+zcUUUwT9Nx29ZN
         WY2aYSmQ4DTRA==
Date:   Thu, 25 Mar 2021 18:52:06 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: Re: [PATCH 3/8] docs: dt: writing-schema: Include the example
 schema in the doc build
Message-ID: <20210325185206.73f8ba1c@coco.lan>
In-Reply-To: <20210325164713.1296407-4-robh@kernel.org>
References: <20210325164713.1296407-1-robh@kernel.org>
        <20210325164713.1296407-4-robh@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, 25 Mar 2021 10:47:08 -0600
Rob Herring <robh@kernel.org> escreveu:

> The example-schema.yaml file serves as documentation, so let's include it
> from writing-schema.rst.
> 
> Cc: Frank Rowand <frowand.list@gmail.com>
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>

Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/writing-schema.rst | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/Documentation/devicetree/writing-schema.rst b/Documentation/devicetree/writing-schema.rst
> index 03e279d8fd6a..be14dbed6081 100644
> --- a/Documentation/devicetree/writing-schema.rst
> +++ b/Documentation/devicetree/writing-schema.rst
> @@ -8,6 +8,8 @@ written in a JSON compatible subset of YAML. YAML is used instead of JSON as it
>  is considered more human readable and has some advantages such as allowing
>  comments (Prefixed with '#').
>  
> +Also see :ref:`example-schema`.
> +
>  Schema Contents
>  ---------------
>  
> @@ -170,3 +172,12 @@ json-schema Resources
>  `JSON-Schema Specifications <http://json-schema.org/>`_
>  
>  `Using JSON Schema Book <http://usingjsonschema.com/>`_
> +
> +.. _example-schema:
> +
> +Annotated Example Schema
> +------------------------
> +
> +Also available as a separate file: :download:`example-schema.yaml`
> +
> +.. literalinclude:: example-schema.yaml



Thanks,
Mauro
