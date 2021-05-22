Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8801238D6E3
	for <lists+linux-kernel@lfdr.de>; Sat, 22 May 2021 20:14:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231360AbhEVSQL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 May 2021 14:16:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:51836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231156AbhEVSQJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 May 2021 14:16:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 17DD761139;
        Sat, 22 May 2021 18:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621707284;
        bh=IHJaW7ZlVSvMC1KLuAGqIxUGLtak5vbK3m+puLvh9yk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=um8dFcrfe44rnIZGthyLzh6KkWo4SncCPGa7YOFMLc3sItv0k5g70uX7GDMsABRFC
         ddMUnV/jwq14wwFs18vD6BQ2EUQ0ZWOcbV0SuYgzedgO6Yzoj953ck8PZQ3ymlhHlC
         zVNKYQ7nSZkkMSRRnECG4LGQdNYB7IOebJcXeVUK8Y+QxIPyzUQ5WbwAN3lM/kASKp
         gDxPZtZmlOrYv3V7MFhsoO5TR21tCPuLlv1D+h87i4fCTrUJRNV0NP6bsuw4/8/f4o
         uaEiSbHuQWfbuCZD5khhMura8+HiKuQOk/gtX94e6a0JB0gk9P2Qv9AdRDTTE8fRXj
         1NX1zbOLwU2fw==
Date:   Sat, 22 May 2021 20:14:39 +0200
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Akira Yokosawa <akiyks@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: Activate xeCJK only in CJK chapters
Message-ID: <20210522201439.156bded8@coco.lan>
In-Reply-To: <2061da0a-6ab1-35f3-99c1-dbc415444f37@gmail.com>
References: <2061da0a-6ab1-35f3-99c1-dbc415444f37@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sat, 22 May 2021 16:28:55 +0900
Akira Yokosawa <akiyks@gmail.com> escreveu:

> Activating xeCJK in English or Italian-translation documents
> results in sub-optimal typesetting with wide-looking apostrophes
> and quotation marks.
> 
> The xeCJK package provides macros for enabling and disabling its
> effect in the middle of a document, namely \makexeCJKactive and
> \makexeCJKinactive.
> 
> So the goal of this change is to activate xeCJK in the relevant
> chapters in translations.
> 
> To do this:
> 
>     o Define custom macros in the preamble depending on the
>       availability of the "Noto Sans CJK" font so that those
>       macros can be embedded in translations.tex after the fact.
>       By default, xeCJK is inactive.
> 
>     o Add a script retouch-translations.sh to embed the on/off
>       macros in translations.tex where necessary.
>       The patterns in the script are ad-hoc by nature, and will
>       need updates when the chapter organization changes.
> 
>     o Invoke the script at the final step of target "latexdocs".

Interesting solution, but there are probably an easy/better
way of doing something similar to it.

There is an extension called:

	Documentation/sphinx/load_config.py

Which allows using a per-document conf.py file. While it can also be
used to have a "nitpick" version where extra warnings are enabled,
the main usage were to have separated PDF documents. 

We ended finding a better solution, so most conf.py got removed
on this patch: 9fc3a18a942f ("docs: remove extra conf.py files").

Anyway, perhaps we could simply add a Documentation/translations/conf.py
that would add the CJK font only there.

Even better, we could even improve it in a way that each translation
would generate a separated book, and then use CJK only for the
non-Latin translations.

Regards,
Mauro
