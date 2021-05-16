Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33062381E0E
	for <lists+linux-kernel@lfdr.de>; Sun, 16 May 2021 12:28:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231127AbhEPK31 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 May 2021 06:29:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbhEPK3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 May 2021 06:29:23 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A786C061573;
        Sun, 16 May 2021 03:28:09 -0700 (PDT)
Received: from ip4d14bd53.dynamic.kabel-deutschland.de ([77.20.189.83] helo=[192.168.66.200]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1liE0E-000328-KE; Sun, 16 May 2021 12:28:06 +0200
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org
References: <cover.1621159997.git.mchehab+huawei@kernel.org>
 <5625907ed95964321c39a8688b70c54bac6d8e95.1621159997.git.mchehab+huawei@kernel.org>
From:   Thorsten Leemhuis <linux@leemhuis.info>
Subject: Re: [PATCH v3 02/16] docs: admin-guide: reporting-issues.rst: replace
 some characters
Message-ID: <a138a130-6208-be63-b6ea-b08f3d66012a@leemhuis.info>
Date:   Sun, 16 May 2021 12:28:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <5625907ed95964321c39a8688b70c54bac6d8e95.1621159997.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-BS
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1621160889;0a20e3d2;
X-HE-SMSGID: 1liE0E-000328-KE
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lo! On one hand I think it would be good to fix the tools to make them
understand non-breakable spaces in places where the author chose to use
them, but whatever, their use in that sentence is definitely not
important, so feel free to add:

Acked-by: Thorsten Leemhuis <linux@leemhuis.info>

Thanks for working on this. Ciao, Thorsten

On 16.05.21 12:18, Mauro Carvalho Chehab wrote:
> The conversion tools used during DocBook/LaTeX/html/Markdown->ReST
> conversion and some cut-and-pasted text contain some characters that
> aren't easily reachable on standard keyboards and/or could cause
> troubles when parsed by the documentation build system.
> 
> Replace the occurences of the following characters:
> 
> 	- U+00a0 (' '): NO-BREAK SPACE
> 	  as it can cause lines being truncated on PDF output
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  Documentation/admin-guide/reporting-issues.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/admin-guide/reporting-issues.rst b/Documentation/admin-guide/reporting-issues.rst
> index 18d8e25ba9df..d7ac13f789cc 100644
> --- a/Documentation/admin-guide/reporting-issues.rst
> +++ b/Documentation/admin-guide/reporting-issues.rst
> @@ -1248,7 +1248,7 @@ paragraph makes the severeness obvious.
>  
>  In case you performed a successful bisection, use the title of the change that
>  introduced the regression as the second part of your subject. Make the report
> -also mention the commit id of the culprit. In case of an unsuccessful bisection,
> +also mention the commit id of the culprit. In case of an unsuccessful bisection,
>  make your report mention the latest tested version that's working fine (say 5.7)
>  and the oldest where the issue occurs (say 5.8-rc1).
>  
> 
