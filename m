Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B94C3715D6
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 15:17:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234245AbhECNS0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 09:18:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:22391 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234186AbhECNSO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 09:18:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620047841;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lZ3P44Yfnu49NpfXUggovdI/GLNt/AAmmjz1I1EQb1c=;
        b=XGEmrvx5ZL3hUmnJb/yr0w4vXa8XNUB3+/Pv8c1K8LjCSHYIIefcm5amK2NaSwGMntbHuk
        L6LdrwePlUXMO7NRyUXbNM6Bz6fTBNYFZi8tLqCeqVap3zpl/RvDqGc7yDOPD2OAlM0PTc
        OeYjAo00t2f2tAD4+Xw2urLywFSgAFM=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-34-9avEkPjAOVim4BVnpt09Iw-1; Mon, 03 May 2021 09:17:17 -0400
X-MC-Unique: 9avEkPjAOVim4BVnpt09Iw-1
Received: by mail-qk1-f198.google.com with SMTP id b19-20020a05620a0893b02902e956b29f5dso5058662qka.16
        for <linux-kernel@vger.kernel.org>; Mon, 03 May 2021 06:17:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=lZ3P44Yfnu49NpfXUggovdI/GLNt/AAmmjz1I1EQb1c=;
        b=s+SeIH2sQqecmklhs1RTidrpdn+zQPz/tyMV6xu3MMQgsJ+oMs0HO7i9CexLKWp8Ik
         khM/JJHzXQzAfM35vV5AHe4lZWA1N0z4+WX/mp/C3tdiueDMyy2Zx0bb9Bgpwq+iieV8
         5l6dPgjmcqflcWNVMfuaVD+Jjqr+Q6D7XNy9bc9dLGnSrRtR7iVM5sTcIShZqbJa0ZDJ
         QYtvx8qS5HaRzaWe2mYcs8qba0FG3tE3aJrfN3/NTkbSL7SN0fgm7o5aIGvO3RPFuicd
         oqgRU4X2uJnBZCG/Mqhx6T2pHPa7tRQ7bkfoO24xoh+mZjX7JEqeMS49I7bmEHndB8BY
         YGIw==
X-Gm-Message-State: AOAM531ndLwDFTJs4bTLPCrluz2YvkMv9MiqyA7WXiLOgo5TuDB8CTPA
        /4N88O9+3pxGzxEVtAjX32J3Nwew178d5tSDtQGIVxbiz5TZVYZ4wQdG5Q9uZnVJIM6p2krQOEh
        JFJi06PnChxuc7dLUrNWHH9Uv
X-Received: by 2002:a37:9a16:: with SMTP id c22mr16145761qke.0.1620047837078;
        Mon, 03 May 2021 06:17:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyQxOHgnDvzivrvWF+f41wjCfS0nWr2QjOGWOHxpLgLWxPJr4p5uQ3N9F4ixkJD2cJUfJ+RTQ==
X-Received: by 2002:a37:9a16:: with SMTP id c22mr16145743qke.0.1620047836859;
        Mon, 03 May 2021 06:17:16 -0700 (PDT)
Received: from redhatnow.users.ipa.redhat.com ([2605:a601:ab5e:300:20c:bff:fe44:d76d])
        by smtp.gmail.com with ESMTPSA id g1sm8460932qth.69.2021.05.03.06.17.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 May 2021 06:17:15 -0700 (PDT)
Subject: Re: [PATCH] Revert "ACPI: custom_method: fix memory leaks"
To:     Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Wenwen Wang <wenwen@cs.uga.edu>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org
References: <20210502172326.2060025-1-keescook@chromium.org>
From:   Mark Langsdorf <mlangsdo@redhat.com>
Message-ID: <0fefece0-f8a1-6ee1-114f-0a2bb412b986@redhat.com>
Date:   Mon, 3 May 2021 08:17:14 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210502172326.2060025-1-keescook@chromium.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In 5/2/21 12:23 PM, Kees Cook wrote:
> This reverts commit 03d1571d9513369c17e6848476763ebbd10ec2cb.
>
> While /sys/kernel/debug/acpi/custom_method is already a privileged-only
> API providing proxied arbitrary write access to kernel memory[1][2],
> with existing race conditions[3] in buffer allocation and use that could
> lead to memory leaks and use-after-free conditions, the above commit
> appears to accidentally make the use-after-free conditions even easier
> to accomplish. ("buf" is a global variable and prior kfree()s would set
> buf back to NULL.)
>
> This entire interface needs to be reworked (if not entirely removed).
>
> [1] https://lore.kernel.org/lkml/20110222193250.GA23913@outflux.net/
> [2] https://lore.kernel.org/lkml/201906221659.B618D83@keescook/
> [3] https://lore.kernel.org/lkml/20170109231323.GA89642@beast/
>
> Cc: Wenwen Wang <wenwen@cs.uga.edu>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---

I have two patches submitted to linux-acpi to fix the most obvious bugs 
in the current driver.  I don't think that just reverting this patch in 
its entirety is a good solution: it still leaves the buf allocated in 
-EINVAL, as well as the weird case where a not fully consumed buffer can 
be reallocated without being freed on a subsequent call.

https://lore.kernel.org/linux-acpi/20210427185434.34885-1-mlangsdo@redhat.com/

https://lore.kernel.org/linux-acpi/20210423152818.97077-1-mlangsdo@redhat.com/

I support rewriting this driver in its entirety, but reverting one bad 
patch to leave it in a different buggy state is less than ideal.

--Mark Langsdorf

