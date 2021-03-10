Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 025EA333674
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 08:36:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231548AbhCJHft (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 02:35:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbhCJHf0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 02:35:26 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 037D9C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  9 Mar 2021 23:35:24 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id mm21so36425855ejb.12
        for <linux-kernel@vger.kernel.org>; Tue, 09 Mar 2021 23:35:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BOyazx73bKuDxT9YFQZ+98Lel151zbsjsLGlPaNK1No=;
        b=GQX3w3HgDZ3XpcKbxx6BPNluskMFI30wJnXIqgGw2DCsm14QOrhZ7iU/BMYQ7KZag8
         AUMVg16XZCUGtNVRgI8IOjQy6V2l00Zx9ujX0KW8YjenSiK2A5YbzF4rjl3m6I9I3LmI
         X5JYIWdqwYWzxqLRFNhkxVwi3fbUJF7XRF7ftHNbre+LvkkKhUyJixnwSlxhGVlPUDzv
         +L6WZ0WCBr2ENGzS1+c+iL9oMCDyyB0EiOTJcOxrsm1W6qVZTvAYVb/4WK+mO24xf6RW
         St8cj2sYoR1Sew0wE2TCV/GcKbCiFAgXBwemM81Bm+u6sh0KcKoQXIXIEIphYbsqQA+g
         EcWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BOyazx73bKuDxT9YFQZ+98Lel151zbsjsLGlPaNK1No=;
        b=iBrjrC6dHrTSaa5eH/eDzEcIjGCOyEpiPi9PurGxi2hmI4f475GbzoirAQwxqjbAng
         0o7y5FpX4NE3xKaph0VgNmnulfUjkyVhqNVoqiY5T9t5DS91a+o8pK7s8rMCGoouavM1
         pyLZtXi0oZL+zWETVvh1WYeS+wjcIciAPMywsdBVxq3GRB+W2WbtRqlrD7XcEhsgif1+
         VAYVa+xjwiibDlEIRuwwx+UyFWliqjt6WrwqIQs8PhpGM+LzJxWRKma17BG25wAPxCCj
         Hpqc5+ly9Cs4ik/H9cEopWUpmVMbrHu3R5D7XoulXAiioX/W+qdLlOR++5Y8rVXQP0vD
         wcvw==
X-Gm-Message-State: AOAM532kH9+7DX9I4hAEzEK248ApoBXaK8EkTRIoexz4TIf+tjtGF6RW
        QVamj4lUuxM7JbXkrZpNQvMt4cA3m/v9s8Mz4mx4vY0n
X-Google-Smtp-Source: ABdhPJzPMz7HPUreJVDfjQKXo8NHbxnL8gyAMIBrPKJN4gvyPKqTZ4D0zTwlg0Qpd7ksTpXGl2yCYahZgyyOGFR2pXc=
X-Received: by 2002:a17:906:30da:: with SMTP id b26mr2207660ejb.376.1615361722831;
 Tue, 09 Mar 2021 23:35:22 -0800 (PST)
MIME-Version: 1.0
References: <1615360238-22508-1-git-send-email-jiapeng.chong@linux.alibaba.com>
In-Reply-To: <1615360238-22508-1-git-send-email-jiapeng.chong@linux.alibaba.com>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Tue, 9 Mar 2021 23:35:11 -0800
Message-ID: <CAMo8BfKwfBXXpkubu=W30S+q0Xt3xYFrD8QBDiWq=H=pLo=bCQ@mail.gmail.com>
Subject: Re: [PATCH] xtensa: fix warning comparing pointer to 0
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     Chris Zankel <chris@zankel.net>,
        "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 9, 2021 at 11:10 PM Jiapeng Chong
<jiapeng.chong@linux.alibaba.com> wrote:
>
> Fix the following coccicheck warning:
>
> ./arch/xtensa/kernel/pci.c:79:17-18: WARNING comparing pointer to 0.
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  arch/xtensa/kernel/pci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks, applied to my xtensa tree.

-- 
Thanks.
-- Max
