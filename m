Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 923963217BF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 13:57:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231495AbhBVM5B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 07:57:01 -0500
Received: from mx.kolabnow.com ([95.128.36.40]:22444 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231267AbhBVMYF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 07:24:05 -0500
X-Greylist: delayed 507 seconds by postgrey-1.27 at vger.kernel.org; Mon, 22 Feb 2021 07:24:01 EST
Received: from localhost (unknown [127.0.0.1])
        by ext-mx-out001.mykolab.com (Postfix) with ESMTP id 04947AAD;
        Mon, 22 Feb 2021 13:13:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        message-id:references:in-reply-to:subject:subject:from:from:date
        :date:content-transfer-encoding:content-type:content-type
        :mime-version:received:received:received; s=dkim20160331; t=
        1613996015; x=1615810416; bh=su6lN/wfDzpqvIMHiCSOa35nXcRiEiL67qu
        Y39rTeko=; b=bM0Y5l8y5eb5/KPO2JNE8jFtVjv6yO7e2++iJoOYhuf0nbqsWPU
        lpLCwWbqoUAQa2xzqBhJTanYdzMxcEFlm04tWblVBSTwH+RatT44DmjjNpgKzipQ
        SWwTK+lhtFB1FkRL9m+7aNNnGrJcjqQeW1aQNdeLqHM89QRAqUxPw/bolSmzWf+x
        6JcwYfBjUBTJDLCyFwKdU3LQjYeBZoptDj7AesXuMTY5aOyJJhi/5PhjBdK4CqRe
        eKUo49vLEMq7KdA4oQc3XJyot+sQegPgyrBP8XGIkH6mUkceehlDfieXeBwBXP9P
        3TEPVNanoWPGj6mpwBHONwrGS69y6VLSVCbW8BeuNd1kpyf960OMa+HnaDO3wMP1
        M5UkqYqqePqb4hnKkQ6gvROcM2TK1yRojKFETbtDe3LkpJU1cU02YD8L5pXRzYbM
        RVxmQOQKuf9GEJLlNd1E6cvarxQ6qzHQfzU1KcUea/YDVOPbVnmbxHYl3wHjz/TU
        RN6qXa495mCEc4rd9gzFcfqQKaYBz+9qgpotD9EZ/5amflvn4GOCpcvm7DHf54N2
        Puy5M4GwIfOZK/EfnJehegp4xh4pz6SLY0W7FgJfwNFr8p2d2/pyRDzVPmCynmrd
        vsYCyvzJeZiuUJX7J4jGXx/OjpzObu8raySiv+Q00CfwB49uhhbbYHAE=
X-Virus-Scanned: amavisd-new at mykolab.com
X-Spam-Flag: NO
X-Spam-Score: -1.9
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 tagged_above=-10 required=5
        tests=[BAYES_00=-1.9] autolearn=ham autolearn_force=no
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out001.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id AdfDJeDEk9-6; Mon, 22 Feb 2021 13:13:35 +0100 (CET)
Received: from int-mx003.mykolab.com (unknown [10.9.13.3])
        by ext-mx-out001.mykolab.com (Postfix) with ESMTPS id 0D0F35ED;
        Mon, 22 Feb 2021 13:13:34 +0100 (CET)
Received: from int-subm002.mykolab.com (unknown [10.9.37.2])
        by int-mx003.mykolab.com (Postfix) with ESMTPS id 81279A4C;
        Mon, 22 Feb 2021 13:13:32 +0100 (CET)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 22 Feb 2021 13:13:30 +0100
From:   Federico Vaga <federico.vaga@vaga.pv.it>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Harry Wei <harryxiyou@gmail.com>, Jyri Sarha <jsarha@ti.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] doc: use KCFLAGS instead of EXTRA_CFLAGS to pass flags
 from command line
In-Reply-To: <20210221152524.197693-1-masahiroy@kernel.org>
References: <20210221152524.197693-1-masahiroy@kernel.org>
Message-ID: <d3f3b273ff2ac78e5cecc10789ffd2da@vaga.pv.it>
X-Sender: federico.vaga@vaga.pv.it
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-02-21 16:25, Masahiro Yamada wrote:
> You should use KCFLAGS to pass additional compiler flags from the
> command line. Using EXTRA_CFLAGS is wrong.
> 
> EXTRA_CFLAGS is supposed to specify flags applied only to the current
> Makefile (and now deprecated in favor of ccflags-y).
> 
> It is still used in arch/mips/kvm/Makefile (and possibly in external
> modules too). Passing EXTRA_CFLAGS from the command line overwrites
> it and breaks the build.
> 
> I also fixed drivers/gpu/drm/tilcdc/Makefile because commit 
> 816175dd1fd7
> ("drivers/gpu/drm/tilcdc: Makefile, only -Werror when no -W* in
> EXTRA_CFLAGS") was based on the same misunderstanding.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
> 
>  Documentation/process/4.Coding.rst                            | 2 +-
>  Documentation/process/submit-checklist.rst                    | 2 +-
>  Documentation/translations/it_IT/process/4.Coding.rst         | 2 +-
>  Documentation/translations/it_IT/process/submit-checklist.rst | 2 +-
>  Documentation/translations/zh_CN/process/4.Coding.rst         | 2 +-
>  drivers/gpu/drm/tilcdc/Makefile                               | 2 +-
>  6 files changed, 6 insertions(+), 6 deletions(-)

Acked-by: Federico Vaga <federico.vaga@vaga.pv.it>

-- 
Federico Vaga
http://www.federicovaga.it/
