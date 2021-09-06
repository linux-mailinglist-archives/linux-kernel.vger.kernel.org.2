Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A133401CB6
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 15:58:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243001AbhIFN6x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 09:58:53 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:32842
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232432AbhIFN6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 09:58:51 -0400
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id DEE133F32C
        for <linux-kernel@vger.kernel.org>; Mon,  6 Sep 2021 13:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1630936665;
        bh=J8YbYX9rObxi/+dAj0p29flv/Pb6qwtzNhWxLnF5+5k=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=tmU/CJOKfiK4JS+K1GArjGZrp4creNNHLWcFQ3eAJ7gMCPdQd2G+4j9GK/u641unr
         iP7hxEbAZHIZRbm6nqo239ysdHFcYm25WTIO8xEQrXcHbMrQCsKLVXODpJS2wF/zfb
         moO8zixLCq5RvtPts2ebBpOFsJR2ptFrHM6jCTayjsIAqfDkpUMLD4qFUIV5/Rah4W
         XnnKS41iBWFbrvAhU9M2WJF2DhjnBcRzKLYpPjtgklvMWGXy/G/g6L7pc4oIj5/+Lw
         CLlTPByG3gxthq/jv1JtOw8haKCFfQLcZ4oYq/cPgxiA3/n3o5ayrKoCnOQweZOyNL
         vhtSHMfdkbFhw==
Received: by mail-wm1-f71.google.com with SMTP id f17-20020a05600c155100b002f05f30ff03so3952928wmg.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Sep 2021 06:57:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=J8YbYX9rObxi/+dAj0p29flv/Pb6qwtzNhWxLnF5+5k=;
        b=U35qopIOlU0VrFFYmphC0l6gyN2d6eo2WNWBooy3VwNsBtH33XXTKCfW/z0p27YKxZ
         UYQM/gv63pXisRaN258qQXBYOuHQVlUwBPbIuAf3dEFbyav2nSDsM1eu89MSj/ZNnlyl
         vhS+vFwXruYjqPajUhrWS0igFSn5zaJKP6/e2B/ncBCaAYKpqLN7aw96iJdJh+9D3qsT
         QOoKq0Wk1TIQlyJiASMPkWk02dVy0xCKn4cow/UZE3nwZKCzrDbpkzzovqrWjCWkNxxd
         rJ7t6/bzAlQx9xVmP1odGv/0MHKxja+FXOaQcodqvKpdYZHY2d4WQ1qxFnyhmoXZuYP+
         Mhjg==
X-Gm-Message-State: AOAM533tGop6WgRN+HPqzFWsCu+lKHVnG7ky+hVQfGoh3cwt7kzm6Drz
        ibgeJTKBMv092bE0962dWDYovXEWpmBjW0xy00ZcEFbQV+VrLwyZH3WxhWzHQsdy9UFW6VHOlNS
        w+83a6Ck86oN5DLldNEydrIDSD+EbvEHxbHTH7di/2w==
X-Received: by 2002:a05:600c:2295:: with SMTP id 21mr11497244wmf.84.1630936665323;
        Mon, 06 Sep 2021 06:57:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxfKIgSTWWuKIqTodWd4lKtj/JI/NVBFOzbRNEQLz76HjYJektmsLbR+IXiCrH1QFEpjoH4Jw==
X-Received: by 2002:a05:600c:2295:: with SMTP id 21mr11497232wmf.84.1630936665170;
        Mon, 06 Sep 2021 06:57:45 -0700 (PDT)
Received: from [192.168.3.211] ([79.98.113.217])
        by smtp.gmail.com with ESMTPSA id o10sm8422907wrc.16.2021.09.06.06.57.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Sep 2021 06:57:44 -0700 (PDT)
Subject: Re: [PATCH] ARM: s3c: Use strscpy to replace strlcpy
To:     Jason Wang <wangborong@cdjrlc.com>
Cc:     linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210906134656.101088-1-wangborong@cdjrlc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <6ca0d3e1-b895-e6c8-e075-786f24c19696@canonical.com>
Date:   Mon, 6 Sep 2021 15:57:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210906134656.101088-1-wangborong@cdjrlc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/09/2021 15:46, Jason Wang wrote:
> The strlcpy should not be used because it doesn't limit the source
> length. As linus says, it's a completely useless function if you
> can't implicitly trust the source string - but that is almost always
> why people think they should use it! All in all the BSD function
> will lead some potential bugs.
> 
> But the strscpy doesn't require reading memory from the src string
> beyond the specified "count" bytes, and since the return value is
> easier to error-check than strlcpy()'s. In addition, the implementation
> is robust to the string changing out from underneath it, unlike the
> current strlcpy() implementation.
> 
> Thus, We prefer using strscpy instead of strlcpy.

Don't copy-paste kernel documentation into commits. It's enough to say
that strlcpy is preferred, according to the kernel coding style (see
strlcpy()).

If you want to add more sentences, make them relevant, e.g. describe
possible effect of bugs depending on the source.




Best regards,
Krzysztof
