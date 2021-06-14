Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A7E03A6867
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 15:50:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234249AbhFNNwr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 09:52:47 -0400
Received: from mail-wr1-f47.google.com ([209.85.221.47]:35736 "EHLO
        mail-wr1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233674AbhFNNwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 09:52:46 -0400
Received: by mail-wr1-f47.google.com with SMTP id m18so14642789wrv.2;
        Mon, 14 Jun 2021 06:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=rK9Q1mNWnb94FFuQqkdC7VJ2nzbzqNo9H25GvMLEJag=;
        b=TRi/aZqILauPquOhvVzePZlwFemjM4DxUaMTDQZuaTyYe7FcMc2FKib8fBfUF2/hsY
         t4W9pTVMOLFf6fn093Vi0o1aBgNb4u9k0+FB6BsZpmfNDx5unCYSM2dXeC/mFI5o/A+G
         IBVcqsSfZhRihX13zRhrZjA9bgCdAlgF8zQr9wLrNEbws5D3lWnoXT/X6KMw2SIwJjFW
         promwW+1MwOsHvY8f6GYe+qAbZyrSgcQ1gZbMEvoBIeUC6E+uGz6z7nES4XXnx6eitWB
         IXfMCOf+rVj4Oq+MoKjDVMmvWyo7hyoFy7osSU1vRHdLBMKf7aVUXMpiPPLFhwH5dHDx
         Je/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=rK9Q1mNWnb94FFuQqkdC7VJ2nzbzqNo9H25GvMLEJag=;
        b=pyV/+WAPfYR4S7GV9cVmcgriDyJA0QzatHOAraMiy+JWAC0FOedPe5Kej0BznsvEk7
         mYYoxnAk+a6qmrr/MBgWcTQQbkux/1mffK5z4Kx6lWGBdX8S6aMXKPNfIXlS58LLgI4n
         Jt6quO+R8VkNb+kOrgZ7Dl2df8KzInD+R+DPd7ulZQSMdyhptrBzImoRofhMZv/NZOVT
         4JgY/8NNNWuV5JlMc6fLOFK1cMw2fciXJ/4fQPXUlFy48WGpCxBkzr1GYvPnZxqqoYaf
         g3urjLpYp8nKEc0clu1r21NJU0zG5Hh8ViyI0gSSZA9rIROGR2bQKUXMnzI8UakOZlL9
         8O/g==
X-Gm-Message-State: AOAM531YDy1lpadpa+Zdcs6sqk2NpmvzmZ/eb79Qpa0XIwPF7cZWk0D+
        X5YFMHi5b/tJ8XR190DtpYQ=
X-Google-Smtp-Source: ABdhPJxDCuIQ5fy9tEkTO0AgnukU7YnvgAVRLYDvp2FsT6EU7U7C1evAhiiPzCTMg4DkDSft24eMWQ==
X-Received: by 2002:a5d:6546:: with SMTP id z6mr19043411wrv.100.1623678576619;
        Mon, 14 Jun 2021 06:49:36 -0700 (PDT)
Received: from felia ([2001:16b8:2d62:e800:a8e7:80e:6e34:237d])
        by smtp.gmail.com with ESMTPSA id o5sm16637577wrw.65.2021.06.14.06.49.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 06:49:36 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
X-Google-Original-From: Lukas Bulwahn <lukas@gmail.com>
Date:   Mon, 14 Jun 2021 15:49:22 +0200 (CEST)
X-X-Sender: lukas@felia
To:     Dwaipayan Ray <dwaipayanray1@gmail.com>
cc:     corbet@lwn.net, linux-kernel@vger.kernel.org,
        lukas.bulwahn@gmail.com, joe@perches.com, linux-doc@vger.kernel.org
Subject: Re: [PATCH v3] docs: checkpatch: Document and segregate more checkpatch
 message types
In-Reply-To: <20210611060833.1802-1-dwaipayanray1@gmail.com>
Message-ID: <alpine.DEB.2.21.2106141330240.27009@felia>
References: <20210611060833.1802-1-dwaipayanray1@gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 11 Jun 2021, Dwaipayan Ray wrote:

> Add and document more checkpatch message types. About 50% of all
> message types are documented now.
> 
> In addition to this:
> 
> - Create a new subsection 'Indentation and Line Breaks'.
> - Rename subsection 'Comment style' to simply 'Comments'.
> - Refactor some of the existing types to appropriate subsections.
> 
> Signed-off-by: Dwaipayan Ray <dwaipayanray1@gmail.com>

Reviewed-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Tested-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

'make htmldocs' produces no new warnings.

See one further comment on the html presentation below; other than that no 
further comments.

Lukas

> ---
> 
> Changes in v3:
> - Update explanation for CONSTANT_CONVERSION
> - Add more reference links
> - Fix grammatical errors
> 
> Changes in v2:
> - Correct DEVICE_ATTR message types as suggested by Joe Perches.
>   https://lore.kernel.org/lkml/eab0487d7b4e68badbbe0505b2a7903b9d8931c4.camel@perches.com/T/#t
> - Use passive voice in the documentation
> 
>  Documentation/dev-tools/checkpatch.rst | 397 ++++++++++++++++++++-----
>  1 file changed, 327 insertions(+), 70 deletions(-)
> 
> diff --git a/Documentation/dev-tools/checkpatch.rst b/Documentation/dev-tools/checkpatch.rst
> index 87b859f321de..ad84e709aa25 100644
> --- a/Documentation/dev-tools/checkpatch.rst
> +++ b/Documentation/dev-tools/checkpatch.rst

<snip>
> +
> +  **FUNCTION_ARGUMENTS**
> +    This warning is emitted due to any of the following reasons::

I think here you wnt to have an enumeration, but the "::" makes it
a code block.

> +
> +      1. Arguments for the function declaration do not follow
> +         the identifier name.  Example::
> +
> +           void foo
> +           (int bar, int baz)
> +
> +         This should be corrected to::
> +
> +           void foo(int bar, int baz)
> +
> +      2. Some arguments for the function definition do not
> +         have an identifier name.  Example::
> +
> +           void foo(int)
> +
> +         All arguments should have identifier names.
> +
>    **FUNCTION_WITHOUT_ARGS**
>      Function declarations without arguments like::
>  
