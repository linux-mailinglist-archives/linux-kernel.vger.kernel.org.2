Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B8CB3E56B8
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 11:23:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238921AbhHJJX1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 05:23:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:59682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233409AbhHJJX0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 05:23:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 454FA60F56;
        Tue, 10 Aug 2021 09:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628587384;
        bh=1RkLB+u/H9JR5P1WMGquk3Gbsype+3hT6sbZfS9eSGg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DTXugz17ja/UXlBXHHr+rPukWED9s6c+ssFeNlgkl3XyCMtiy3kflXg/ZaHLLC4zN
         H8oihG4to7NHE24NREy6OTunWzOZWHVoPn6rv8h8cCGfC5kZOfVOJ1U2CRl9yhfX7a
         swPavBHNIfCARzGb3GH2yDKvbz2xAZJvPbw3NnebMMoX7yFj1cYdg2AY9zrg3oEidF
         cqVpj6iwHvaZFaOS9Dq1D1jT8tcptqeE0JSwVWVcGDxYhpdmAJV4ee9aAwy7zz4noY
         Rozix22r8oWgb5U4iGGEV8WpjqqySAmgvPybSMQgDyLYf6obj3G7UhUc77F9SPnhSR
         TjATbyxfREBVw==
Date:   Tue, 10 Aug 2021 11:22:59 +0200
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Akira Yokosawa <akiyks@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] docs: sphinx-requirements: Move sphinx_rtd_theme to
 top
Message-ID: <20210810112259.6af4651d@coco.lan>
In-Reply-To: <75f14c88-6091-1072-41cb-16b886aee5a0@gmail.com>
References: <974babfe-540f-40e4-38b3-ab294ba70ccc@gmail.com>
        <75f14c88-6091-1072-41cb-16b886aee5a0@gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, 10 Aug 2021 18:16:32 +0900
Akira Yokosawa <akiyks@gmail.com> escreveu:

> sphinx_rtd_theme 0.5.2 has "docutils<0.17" in its requirements.
> docutils 0.17 released this April caused regression in
> sphinx_rtd_theme 0.5.1 [1].
> 
> By removing docutils and moving sphinx_rtd_theme before Sphinx in
> requirements.txt, the requirement of "docutils<0.17" can be met
> naturally.
> 
> [1]: https://github.com/readthedocs/sphinx_rtd_theme/issues/1112
> 
> Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>

This was needed when the minimal version was 1.x, but I guess
we can just get rid of docutils explicit dependency nowadays.

Acked-by: Mauro Carvalho Chehab <mchehab@kernel.org>

> ---
> Hi,
> 
> It is better to keep requirements as minimal as possible.
> Let's leave the dependency to the sphinx_rtd_theme package.
> 
> Changes in v1 [2] -> v2:
> 
>     o Remove docutils entry.
>     o Move sphinx_rtd_theme to top.
>     o Adjust patch title.
> 
> [2]: https://lore.kernel.org/linux-doc/974babfe-540f-40e4-38b3-ab294ba70ccc@gmail.com/
> 
>         Thanks, Akira
> --
>  Documentation/sphinx/requirements.txt | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/Documentation/sphinx/requirements.txt b/Documentation/sphinx/requirements.txt
> index 489f6626de67..9a35f50798a6 100644
> --- a/Documentation/sphinx/requirements.txt
> +++ b/Documentation/sphinx/requirements.txt
> @@ -1,3 +1,2 @@
> -docutils
> -Sphinx==2.4.4
>  sphinx_rtd_theme
> +Sphinx==2.4.4



Thanks,
Mauro
