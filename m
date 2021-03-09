Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 142E0332DFB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 19:15:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231571AbhCISOx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 13:14:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231175AbhCISOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 13:14:33 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E017C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  9 Mar 2021 10:14:33 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id l11so14184427wrp.7
        for <linux-kernel@vger.kernel.org>; Tue, 09 Mar 2021 10:14:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=to:cc:references:from:subject:message-id:date:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=YWRjKT60IEBhulpbgMdBcOEwMVDBc2QXRWkm6ND2LTY=;
        b=TIEoH2DNa8qRSYBVWnaxdsJQ+Zi7/GF7DRltAHbqpXoGbdlc4MMGMaFnIT5Z/TDUed
         g2vR7gAaFTAWUjUXilU5pBFbGW9EG3//W7O8fZaeeG4tcect3Fsol1/ba3c/o+kirWB5
         ar/BGkbk2+hGs5A1gXnGUmWjt9d00gZLL0f7EfWZbVnXFYBKmSOYIlkGPTavpkYTkN5j
         W8ezlpofISU+eEFENaF7FA2pR1kOchhiwnhdULUQJsCifMLBuhCFfk0G8qPBX5YaQc0C
         x+0NsKHpTJ11I4dxLOZ4AJbF/Sq6uvbC48s9f83qtPF5LcRTwvDsDreoFhfpPezIdx0M
         +rOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YWRjKT60IEBhulpbgMdBcOEwMVDBc2QXRWkm6ND2LTY=;
        b=iRjevcqqquIpbIqnLg3ao8UilPk4DLSHLmAxQV3Q6oB075LYno3PGiOi9KefpEAH+O
         e1YTdCrU/vItxMU82LpAwCdHciuYDlkcQC/MbK43P/HREuno64BHgJmPDJ4O7UlshX9X
         7BBIs6Yl0XVngRXMPRdMbwzLp2JrsPdmtEKGV7C8SYVxqj8Eqzd/ugXeehRv+5jkjzqi
         M/WNfKnQ4O6R1p7/zSr3/zGy5zw5JC+2PIeJa/BNC3MHYPeS5YgWiJX2ajPVpgVPBPIj
         NXUEudgCuWPAnaOs7noGrApHAPkkCbWVe1SpPgDNegu924OxbprrsGD6jstgEcbE0yhy
         5lSA==
X-Gm-Message-State: AOAM531K/CtQx/9kLDvsQnlM9j64KuTnUrDkmm6yERwtN9fKFjX4eqma
        s6WMl9du8CBIzjVovAAi3tF8bwPoQxo/nQ==
X-Google-Smtp-Source: ABdhPJyPRsdzft5PXcEJd8oZLDku0oji0/0KIglu9HmYJeRoMykTORGWU7luuklo2QcxwLm/nPzLpg==
X-Received: by 2002:adf:e38f:: with SMTP id e15mr28608333wrm.321.1615313671893;
        Tue, 09 Mar 2021 10:14:31 -0800 (PST)
Received: from [10.44.66.8] ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id x8sm24791935wru.46.2021.03.09.10.14.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Mar 2021 10:14:31 -0800 (PST)
To:     Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        akpm@linux-foundation.org, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com
Cc:     corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210309134720.29052-1-georgi.djakov@linaro.org>
 <390d8a2f-ead9-48a9-99eb-65c73bd18422@suse.cz>
From:   Georgi Djakov <georgi.djakov@linaro.org>
Subject: Re: [PATCH] mm/slub: Add slub_debug option to panic on memory
 corruption
Message-ID: <6bfebf01-5f52-49bd-380b-04785c474c81@linaro.org>
Date:   Tue, 9 Mar 2021 20:14:30 +0200
MIME-Version: 1.0
In-Reply-To: <390d8a2f-ead9-48a9-99eb-65c73bd18422@suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vlastimil,

Thanks for the comment!

On 3/9/21 17:09, Vlastimil Babka wrote:
> On 3/9/21 2:47 PM, Georgi Djakov wrote:
>> Being able to stop the system immediately when a memory corruption
>> is detected is crucial to finding the source of it. This is very
>> useful when the memory can be inspected with kdump or other tools.
> 
> Is this in some testing scenarios where you would also use e.g. panic_on_warn?
> We could hook to that. If not, we could introduce a new
> panic_on_memory_corruption that would apply also for debug_pagealloc and whatnot?

I would prefer that we not tie it with panic_on_warn - there might be lots of
new code in multiple subsystems, so hitting some WARNing while testing is not
something unexpected.

Introducing an additional panic_on_memory_corruption would work, but i noticed
that we already have slub_debug and thought to re-use that. But indeed, аdding
an option to panic in for example bad_page() sounds also useful, if that's what
you suggest.

Thanks,
Georgi
