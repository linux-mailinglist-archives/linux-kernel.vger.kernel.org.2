Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2905F356834
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 11:40:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234651AbhDGJkg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 05:40:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:55698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350187AbhDGJju (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 05:39:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E2DEC6135D;
        Wed,  7 Apr 2021 09:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617788380;
        bh=gL48Be7VweFk5+IC4tU1i5lMgIjar4UO08YJFiy9Od0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kbNhwYQMHHCFqmj8pG/nNpq9z3vvb7h5A054rk93aYPWBdizW3Cn6n3SOXIffcdEX
         dbOFI2uM2yOJoRF8JEl3Tq5Tot/Rwibr3rH1kCI7Zy/GL+Umtuyfi6zFqRwFv45mbC
         pb8JlB6w1Ossn7Qiewc8ME6ziEjC++ljShQ5bxAR9gNJGQpBjQUftdFts3pDA260On
         mM69jyM07DoqQrWZPB+bkoLx+C4FOXggODsiLOIO/QM/29MN7Tt5vGFD1QjJNYwonZ
         V0qAPFNHCYCaw1z/iMYfVDFO3eSvAO1X4eldDjujEJgqOAE8xreQ+bw2kMFkFmAjaX
         wQWEVAEBOGbLg==
Date:   Wed, 7 Apr 2021 11:39:34 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Thorsten Leemhuis <linux@leemhuis.info>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        Jonathan Corbet <corbet@lwn.net>, Alex Shi <alexs@kernel.org>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Harry Wei <harryxiyou@gmail.com>,
        Wu XiangCheng <bobwxc@email.cn>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 17/19] docs: replace transation references for
 reporting-bugs.rst
Message-ID: <20210407113934.1a61ad9e@coco.lan>
In-Reply-To: <1c37acb4-f927-e2f7-8c77-d4fc2644f1d8@leemhuis.info>
References: <cover.1617783062.git.mchehab+huawei@kernel.org>
        <65d1983fb625b5dd38d05f5c75a592e61992a4e0.1617783062.git.mchehab+huawei@kernel.org>
        <1c37acb4-f927-e2f7-8c77-d4fc2644f1d8@leemhuis.info>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, 7 Apr 2021 10:52:14 +0200
Thorsten Leemhuis <linux@leemhuis.info> escreveu:

> On 07.04.21 10:20, Mauro Carvalho Chehab wrote:
> > Changeset d2ce285378b0 ("docs: make reporting-issues.rst official and delete reporting-bugs.rst")
> > dropped reporting-bugs.rst, in favor of reporting-issues.rst, but
> > translations still need to be updated, in order to point to the
> > new file.
> > 
> > Fixes: d2ce285378b0 ("docs: make reporting-issues.rst official and delete reporting-bugs.rst")
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>  
> 
> Well, yeah, might be the right thing to do. But FWIW: when I recently
> submitted the change that became d2ce285378b0 I actually pointed out
> that it breaks some of the translations. Back then I considered to do
> what you did with this patch, but among others got a reply from Jonathan
> who said "let the translators catch up on their own time". For details
> see this thread:
> https://lore.kernel.org/linux-doc/87h7krksvu.fsf@meer.lwn.net/

Hmm... at the e-mail you mentioned, Jon commented that:

	"None of the broken references actually generate warnings"

That's actually not the case: they do generate warnings if
the Kernel is built with CONFIG_WARN_MISSING_DOCUMENTS:

	Documentation/translations/zh_CN/admin-guide/reporting-issues.rst: Documentation/admin-guide/reporting-bugs.rst
	Documentation/translations/zh_CN/admin-guide/reporting-issues.rst: Documentation/admin-guide/reporting-bugs.rst

As it will call the ./scripts/documentation-file-ref-check.

That's basically why I detected and submitted a fix ;-)

Thanks,
Mauro
