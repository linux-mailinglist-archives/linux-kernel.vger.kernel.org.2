Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7822336CC15
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 22:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235903AbhD0UGU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 16:06:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235576AbhD0UGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 16:06:17 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BA18C061760
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 13:05:33 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id j4so56086821lfp.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 13:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yRcc/vr5Chj3M+4Hm2av7mbAqZ86imiIi9qoDwUZ/zU=;
        b=IRkv5P+hJ3HAvAVcYxfphR2IIalOpLukHJvNdIbyeYiLqB0zwJ4BoazBrHvbL7KeWQ
         YYkLIthfmcyOy+zftHPGy4a5Mdp6pRhBcLvLYvLaScIsMmWwXp0b3UxnZghldjA3FlIY
         iKXh7PqxoIO1WXdxmpi9PD3H48mfugN8DTiMY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yRcc/vr5Chj3M+4Hm2av7mbAqZ86imiIi9qoDwUZ/zU=;
        b=uRa/DvdchCduXRrM4bbPMIIthYXYQcgRIHFbhkhAWFsxfyvAQFOugNkuKYHIix3gww
         zlNkajo8bNGv9KEPtVNY1C1lHw0lkZGqazE+0b4hn+ikxgq0GveextECv381Y+i2jkfS
         oaJlthmMqkFbltowutY4XxfkFFlhFK9v5ifbGAPYdncP7ARnBOUeiFbL8GbsvVMJs9TX
         1n/RDQVfIZt+Vu4npDl2s/+oTjdUcysgSlMK+ZG+DYdAn5PY7C4aUbbUAyT7dM8dIrT3
         QOq8SVjSCZv5g68Wtg8bPIejClLLckIshoyuTBxqnvcdCQCpcnVFI1jfw8NU7mrOuaRA
         3Sow==
X-Gm-Message-State: AOAM530RUaGxWkP0PfX/0RL4YeSgoSL7j01OtCg4Zw/GNErcRg+6ERxU
        bq+mUY9msBCnD0hMjR1opwVzuJkf6W9wEaXc
X-Google-Smtp-Source: ABdhPJxCU/PVBscjCNiD6B0Osn1Yhyj2PaISsFrroBbbQEHleF3BbzvU3f1f7iLjgB90IeXMnLCsfA==
X-Received: by 2002:ac2:533b:: with SMTP id f27mr18163139lfh.244.1619553931321;
        Tue, 27 Apr 2021 13:05:31 -0700 (PDT)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id h22sm657744ljc.99.2021.04.27.13.05.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Apr 2021 13:05:30 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id h36so41394017lfv.7
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 13:05:30 -0700 (PDT)
X-Received: by 2002:a19:c30b:: with SMTP id t11mr5016247lff.421.1619553929885;
 Tue, 27 Apr 2021 13:05:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210427025805.GD3122264@magnolia> <CAHk-=wj6XUGJCgsr+hx3rz=4KvBP-kspn3dqG5v-cKMzzMktUw@mail.gmail.com>
 <20210427195727.GA9661@lst.de>
In-Reply-To: <20210427195727.GA9661@lst.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 27 Apr 2021 13:05:13 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjrpinf=8gAjxyPoXT0jbK6-U3Urawiykh-zpxeo47Vhg@mail.gmail.com>
Message-ID: <CAHk-=wjrpinf=8gAjxyPoXT0jbK6-U3Urawiykh-zpxeo47Vhg@mail.gmail.com>
Subject: Re: [GIT PULL] iomap: new code for 5.13-rc1
To:     Christoph Hellwig <hch@lst.de>
Cc:     "Darrick J. Wong" <djwong@kernel.org>, Jia He <justin.he@arm.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Eric Sandeen <sandeen@sandeen.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 27, 2021 at 12:57 PM Christoph Hellwig <hch@lst.de> wrote:
>
> I'm aware of %pD, but 4 components here are not enough.  People
> need to distinguish between xfstests runs and something real in
> the system for these somewhat scary sounding messages.

So how many _would_ be enough? IOW, what would make %pD work better
for this case?

Why are the xfstest messages so magically different from real cases
that they'd need to be separately distinguished, and that can't be
done with just the final path component?

If you think the message is somehow unique and the path is something
secure and identifiable, you're very confused. file_path() is in no
way more "secure" than using %pD4 would be, since if there's some
actual bad actor they can put newlines etc in the pathname, they can
do chroot() etc to make the path look anything they like.

So I seriously don't understand the thinking where you claim that "<n>
components are not enough". Please explain why that could ever be a
real issue.

             Linus
