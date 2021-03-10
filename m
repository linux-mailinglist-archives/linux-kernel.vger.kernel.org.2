Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC5D833478F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 20:09:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233422AbhCJTIe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 14:08:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233732AbhCJTIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 14:08:18 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F94BC061760
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 11:08:18 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id dx17so40944101ejb.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 11:08:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KkBWh521G6K67Xk4FdgqO8Q1j+x61LG4JCDOyUXgiLs=;
        b=YHX8nZ3xU8tzzDZTmKoBNw8OF0LwMRBYjw8hRIZYT5RmPsYTL5N7QwcL4TPttk2Pcm
         +UhMttODSRckYV8Mq1if03d2qV8vB96OZGUx2jN80j2PsBRz7OiEcl1mVohwJOlGNkV0
         9GiR4eje2eTg1LEpc47+fSg50e1krDOp2gUTS3KDG48ZBhxh8cR5iWnocadYkrfDG0vQ
         SY5ZWpjoI9mbzzZH5jmCYmF7hQSelnmYrK4+qFv+tbQSmET67E8DPR3CdPjQeMyxl+Gy
         CvTgYzGN0fP0aNgn+oeHcZUpEFbS/Xzej7zJ9V8QEnq0qcuXW6uyRWMAqEvc216L71Hq
         3yHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KkBWh521G6K67Xk4FdgqO8Q1j+x61LG4JCDOyUXgiLs=;
        b=HpNfgVSa1Qn0XXHDY6nzgrQmdPYzZHc+0X3rsR0B0fOOGVuOB21rMEgqBiwwkgRHUh
         FoSoUaaAUIrBTs0+kIbg/ZWtNrSFb5QUVYbCQe07yYHmw9/KoNn9/qz+xcbJSZZHiu5C
         wEO0uUXw3/7CMhWbLhoghx8NNKRrtOVxyT/X4dqNj/fa4z2ibJkuv1ue066lHmdekxNb
         HY8SC5hon7sWPGzkX04E4WP5fYQPcBLLHPqo9LRhKq2JInwsNjRXnVvbq/5QbFObCjs1
         6h3WO6jdhKvHUSgPQqFkGkO8Ae0NQsRpmYBwT6KnrnX/3an3cDzg3BiReGqs682W2O8y
         4fxQ==
X-Gm-Message-State: AOAM531HCr1s1o2+Ch4qWo0lOh6hg9oTK+bpqOrwCEojN/n5GQUoOy1Z
        9Sm+USCDDJyYrJ//g3exGVcRCw==
X-Google-Smtp-Source: ABdhPJz4PrlVch1rnJiSNBSSVG762qVeudFt5fPvrO/Vt7O4tCvqaywjsp8XZ1+MrqSKdonGt1i61A==
X-Received: by 2002:a17:906:3c18:: with SMTP id h24mr5068431ejg.435.1615403296678;
        Wed, 10 Mar 2021 11:08:16 -0800 (PST)
Received: from google.com ([2a00:79e0:2:11:1c42:4cf0:d720:10e7])
        by smtp.gmail.com with ESMTPSA id fw3sm170347ejb.82.2021.03.10.11.08.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 11:08:16 -0800 (PST)
Date:   Wed, 10 Mar 2021 20:08:10 +0100
From:   Piotr Figiel <figiel@google.com>
To:     Alexey Dobriyan <adobriyan@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Alexey Gladkov <gladkov.alexey@gmail.com>,
        Michel Lespinasse <walken@google.com>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        Andrei Vagin <avagin@gmail.com>,
        mathieu.desnoyers@efficios.com, viro@zeniv.linux.org.uk,
        peterz@infradead.org, paulmck@kernel.org, boqun.feng@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        posk@google.com, kyurtsever@google.com, ckennelly@google.com,
        pjt@google.com
Subject: Re: [PATCH v4] fs/proc: Expose RSEQ configuration
Message-ID: <YEkZGsc9L7qygDPJ@google.com>
References: <20210202173709.4104221-1-figiel@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210202173709.4104221-1-figiel@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 02, 2021 at 06:37:09PM +0100, Piotr Figiel wrote:
> For userspace checkpoint and restore (C/R) some way of getting process
> state containing RSEQ configuration is needed.

[...]

> To achieve above goals expose the RSEQ ABI address and the signature
> value with the new procfs file "/proc/<pid>/rseq".

For the record: this idea was dropped in favor of ptrace approach, as
discussed over separate mail thread with Mathieu Desnoyers and Peter
Zijlstra.  The equivalent ptrace patch in its current version is here:

https://lore.kernel.org/lkml/20210226135156.1081606-1-figiel@google.com/

Best regards,
Piotr.
