Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49B3A378A45
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 13:59:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237095AbhEJLjs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 07:39:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234807AbhEJK5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 06:57:07 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9F5DC07E5DC
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 03:48:34 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id d3-20020a9d29030000b029027e8019067fso13964508otb.13
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 03:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fpdNaPoh+Qx3t3BwBK+Iz4ogoqVCSXTC0wZDMtXobLk=;
        b=tg/IM/umPCsk8/1PIAdsL7Q4jzvVJpwr2Ous4GKpnigKeVFgoeDiyHX41iAwuxrnqW
         CMUpd/ljb9ervsuzUAxGRWq/hrTQ66imb45TufCzARJg8T7kXHSRYF14L3H3UuQ9tpAg
         kt38QjGvwsI5jI2alE04U+c9lcjA6xxQxoFFD41kVLB/0LRGn2tBgAz1TZcCZMl/IdBm
         kTOet1S5nIr7QnASnB4xJkj31RaiflOoeiJlVxI45vDv7RQXlp7VmVYVElWCoUkP/GTb
         avsC7F1KybWnG6gIt2lR8GS8+RgOOccPE1F8tBPQm40LdgNH/4WwROzLFp4FUlvZniZJ
         RlXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fpdNaPoh+Qx3t3BwBK+Iz4ogoqVCSXTC0wZDMtXobLk=;
        b=Ovc0CO4u4giKOcnjE6wrtziSh0/qwpbPlCemuXpkO6HiYhZiJGWn/ODmv/lLz7yEfH
         rXO/u9l4PMI4PUSnmhZVHir4VF0TQpIlJaspHbvCXF2BcjREBoWhExpyz4O5CbzoEgN/
         z4JhNaxW1Bb+wX0hOo7aSBO/Dc2JZVHPycBbtYeWj90oDG+3DwX6ONfIjXkV6g3mfOhR
         7+pHjxPSpjmUZeuf6nj6C3iXHC15ly+9DIgMdwVT8RG+diENHmHBTzAIYyM6h8Z/mXP9
         /MVu2MNPe5y+OVrjEBhlT1yJhEsBMGWyqDGSzUN+BZ+Y98acNDbP6QnmdFmG7v+L6F8K
         rGLg==
X-Gm-Message-State: AOAM533nnMRfrpnXxE6p+g/UTXHvHF69NntsQ2EAuSgES8XWkiSs3OVI
        55XjnRlV9xGcUjYw9o/WCIrE+7J0Mc2qwYfIgaqsPe5xc6E=
X-Google-Smtp-Source: ABdhPJxjQtS8qDfjOY3t+VzwxHoFktl0tYE4j07YRXvokGoKLNlT4LH+GW2oyPRIHRUBg95QsBMkuj1v+VXbXmmQ7lU=
X-Received: by 2002:a05:6830:349b:: with SMTP id c27mr2883745otu.251.1620643714123;
 Mon, 10 May 2021 03:48:34 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1620641727.git.mchehab+huawei@kernel.org> <1591224255d095d14ff3bc2bf4e7796dcc55c77d.1620641727.git.mchehab+huawei@kernel.org>
In-Reply-To: <1591224255d095d14ff3bc2bf4e7796dcc55c77d.1620641727.git.mchehab+huawei@kernel.org>
From:   Marco Elver <elver@google.com>
Date:   Mon, 10 May 2021 12:48:22 +0200
Message-ID: <CANpmjNNnSechXTHno3j_8aXHkgVQ1je6QynGO44roAFKot-mgA@mail.gmail.com>
Subject: Re: [PATCH 39/53] docs: dev-tools: testing-overview.rst: avoid using
 UTF-8 chars
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Daniel Latypov <dlatypov@google.com>,
        David Gow <davidgow@google.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 May 2021 at 12:27, Mauro Carvalho Chehab
<mchehab+huawei@kernel.org> wrote:
>
> While UTF-8 characters can be used at the Linux documentation,
> the best is to use them only when ASCII doesn't offer a good replacement.
> So, replace the occurences of the following UTF-8 characters:
>
>         - U+2014 ('=E2=80=94'): EM DASH
>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  Documentation/dev-tools/testing-overview.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/dev-tools/testing-overview.rst b/Documentation=
/dev-tools/testing-overview.rst
> index b5b46709969c..8adffc26a2ec 100644
> --- a/Documentation/dev-tools/testing-overview.rst
> +++ b/Documentation/dev-tools/testing-overview.rst
> @@ -18,8 +18,8 @@ frameworks. These both provide infrastructure to help m=
ake running tests and
>  groups of tests easier, as well as providing helpers to aid in writing n=
ew
>  tests.
>
> -If you're looking to verify the behaviour of the Kernel =E2=80=94 partic=
ularly specific
> -parts of the kernel =E2=80=94 then you'll want to use KUnit or kselftest=
.
> +If you're looking to verify the behaviour of the Kernel - particularly s=
pecific
> +parts of the kernel - then you'll want to use KUnit or kselftest.

Single dash is incorrect punctuation here. So that Sphinx gives us the
correct em dash, these should be '--'.

Thanks,
-- Marco
