Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCC39353453
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Apr 2021 16:33:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236590AbhDCOdd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Apr 2021 10:33:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230319AbhDCOdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Apr 2021 10:33:31 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30D47C0613E6
        for <linux-kernel@vger.kernel.org>; Sat,  3 Apr 2021 07:33:28 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id n2so4669237ejy.7
        for <linux-kernel@vger.kernel.org>; Sat, 03 Apr 2021 07:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PKvsSUnLc1lwCYoNX9nYiZPdPvhVQHWnDlTVl94e+8E=;
        b=Qru8VSCrqSAjD7o+EOa552SvpBAaP8nt7nYoCJODXb+JBwYR/u5NgH46hBGm/YQIKA
         73BzYkX9jUwnhNohQIvFieOgBxjiPuz4xhlOobQSKmVJAypfx/yaGaGner00oVxYD0Je
         TRGWqIHvevW6VWzTxx4vVJ3sopdLaI6V5p+6QXdZwBCYVsUKe2lQDOMabtbWyL1kGauG
         /Y8UBbW1SEfVU9o1LhVy/BQJyPEuW7vl7xVKtSspYtQxTlgRWBtnNV5k5S4DThE1F/Bx
         +xbLdP1nA2KCw6ePO6jDTVxdVHkqv4yanSeSBenoq1YwL6n4i70O1b5AXNFmb0Bh28b/
         svyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PKvsSUnLc1lwCYoNX9nYiZPdPvhVQHWnDlTVl94e+8E=;
        b=R+uvLepOqlbXZ+puIJYIsNRXlLzCctFX/tQ5f7QdFcXrGazUXizXpu+wXqGVGp4Fx7
         Rxh4uJefGMWzASQb9bs4KbVqarw+o8elL4+DQP+4fdp8VLc0I9NuC7St/EGTajETiwJw
         IXuTDBKTS9HWWfxKBjGBRHTAJpbIJ+93+6PF9FMYuLq4oKdxmMNk21KfoKhf2lWfRNpO
         U5ZvgJFaQPdVi7MLuve/tF4DUIK7T+QQTChLjzRLSRhpTbYyk//TiBMNjbiMlqIGg/G1
         WlONxWm48oGeNj8e+pJg9KKfuVkAzvR4W7E3J6C644XwyDBjBQwqReHo0jTC+ZRGKuKh
         BhHQ==
X-Gm-Message-State: AOAM5301yRYE+dFB633AedbJIeDdkuJDR3m6+/dF+9XFkB0d6PBwHNeA
        6+uxO/lre2weKfPfPSWrEMby0uEs91IlRUMXQPV3
X-Google-Smtp-Source: ABdhPJzeDtKTRi8R6rfLL7dQf2L79CQQqmOB0lLBHTMxvkOcLKkWagq/cNB9gf47WxPCqf6dMYGqo1FSNqd/k3AotFM=
X-Received: by 2002:a17:906:f283:: with SMTP id gu3mr18829894ejb.91.1617460406662;
 Sat, 03 Apr 2021 07:33:26 -0700 (PDT)
MIME-Version: 1.0
References: <3c63e34b-e54f-9b01-bad4-8fde8528a64d@linux.microsoft.com>
In-Reply-To: <3c63e34b-e54f-9b01-bad4-8fde8528a64d@linux.microsoft.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Sat, 3 Apr 2021 10:33:15 -0400
Message-ID: <CAHC9VhTD2iXw7CkxgwnOx1zNN_AqMV+x1Vy8FijdMQE1m4AOJA@mail.gmail.com>
Subject: Re: [BUG] Oops in sidtab_context_to_sid
To:     Vijay Balakrishna <vijayb@linux.microsoft.com>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Ondrej Mosnacek <omosnace@redhat.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        selinux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 2, 2021 at 6:35 PM Vijay Balakrishna
<vijayb@linux.microsoft.com> wrote:
>
> Seeing oops in 5.4.83 sidtab_context_to_sid().  I checked with Tyler (copied),  he said it might be
>
> https://lore.kernel.org/selinux/CAFqZXNu8s5edDbSZuSutetTsy58i08vPuP2h-n9=kT34HcPc4w@mail.gmail.com/
>
> Ondrej, can you confirm?  Unfortunately, we don't have a on demand repro.

I'm guessing this may be the problem that Tyler reported earlier and
which appeared to be fixed by the patch below:

https://lore.kernel.org/selinux/20210318215303.2578052-3-omosnace@redhat.com

... which was merged into Linus' tree during the v5.12-rcX development
phase, any chance you could try that patch to see if it resolves your
issue?  There are still some issues to be sorted out, but if you
aren't reloading policy it shouldn't be a concern.

Tyler, since both of you are at Microsoft, do you have a patched
kernel that Vijay could try?

-- 
paul moore
www.paul-moore.com
