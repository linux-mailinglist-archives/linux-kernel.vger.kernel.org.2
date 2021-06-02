Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89CF93993B3
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 21:41:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbhFBTnb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 15:43:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229467AbhFBTna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 15:43:30 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DF45C06174A
        for <linux-kernel@vger.kernel.org>; Wed,  2 Jun 2021 12:41:47 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id j184so3612448qkd.6
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 12:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VXM916lfkO68AGVYAVVKzngsp7xw6VP9qJatS89TJDQ=;
        b=yom/k1cYjeziEpSAxyhHbN/6wHxOkLzYl9GkEyX+B7jrWcu5LhmKc0tkPmZG2fFBkk
         /Zrq0Y6+DL6WXsZb8pLrLUaPdKlE6MNUZ+u4ROLUtjJdov10nx5BpDeq/lLkXkfJketm
         vgU64ahIht8WmizFhoYxcqsFxXbXmCplgfIjYgpQGGwGxMEAmG0OVZ/GCqvKAT1ayk4+
         CwcgdkRp7p8WdvBdP5pHkJxDXxcSO3unb9ae+55RBucCNm6jaeCT8/ixJ3xqdksSqYqs
         E2UVroA8D6m/2cJHRAWMrF5//1l2n7ZRntnkhJ4I8weaFqTrLvlEf+peS879BZ63za2h
         p02w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VXM916lfkO68AGVYAVVKzngsp7xw6VP9qJatS89TJDQ=;
        b=JNP5fJnBu0SFe6J5GuzV9qWmzfdDvxWjISfGa7jDe9QvIg6Fsnb8yDI0bFFn8BFgi2
         0ANbP8z9PRl7kd42tst8xbnSPoA5snMdxeEsGQMJSRcJRVdh9uLrfBzLis8jcHDxcP+R
         ktGRSJYbTurMx3V13o6wtQbsPivAIqIsrwp2c66Wy513vLXTuvvwTpP19AJzZZrAwrNk
         ASG2GLTqlKF5cPVa9NHa7IWopRS8ZBO54LQzjjVmYxGt91XP5exgQVbCMjz1ye5aiwm+
         scix7zM+FcoqtW+buyc0ZFR4rfb13sY5MjdW/cnCdm+XOu8AFVKro+1eJ2+3+Nor4SC7
         enKg==
X-Gm-Message-State: AOAM531qFwaI7qeQeQwsmbD2JGDFi8v2AzORrWta6Qe1VQl/a2WuNdUG
        +0FL1JRgBV2uU33KuySxJu2kHQXBmEJbND/6
X-Google-Smtp-Source: ABdhPJw4yhYvmaBRL8dLeKlsAsWvJQFOIDcQgG4nDLcddgPSmgNV9L3kogYtiNmvHaXfaavTMHyAOg==
X-Received: by 2002:a05:620a:2a01:: with SMTP id o1mr4499975qkp.137.1622662906284;
        Wed, 02 Jun 2021 12:41:46 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:9178:81cf:a7f0:8e5d])
        by smtp.gmail.com with ESMTPSA id f13sm475634qkk.107.2021.06.02.12.41.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 12:41:45 -0700 (PDT)
Date:   Wed, 2 Jun 2021 15:41:44 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        git@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jiri Kosina <trivial@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: git feature request: git blame --ignore-cleanup/--ignore-trivial
Message-ID: <YLfe+HXl4hkzs44b@nand.local>
References: <30399052.5964.1622647235870.JavaMail.zimbra@efficios.com>
 <YLej6F24Emm7SX35@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YLej6F24Emm7SX35@zeniv-ca.linux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 02, 2021 at 03:29:44PM +0000, Al Viro wrote:
> > Any maybe the patterns associated to "cleanup" and "trivial" commits
> > should be something that can be configured through a git config
> > file.
>
> Just an observation: quite a few subtle bugs arise from mistakes in
> what should've been a trivial cleanup.  Hell, I've seen bugs coming
> from rebase of provably no-op patches - with commit message unchanged.
> So IME this is counterproductive...

Yes, I find excluding revisions from 'git blame' to be rarely useful,
exactly for this reason.

You could probably use the '--ignore-revs-file' option of 'git blame' to
exclude commits you consider trivial ahead of time. If you had an
'Is-trivial' trailer, I would probably do something like:

  $ git log --format='%H %(trailers:key=Is-trivial)' |
      grep "Is-trivial: true" | cut -d" " -f1 >exclude
  $ git blame --ignore-revs-file exclude ...

Thanks,
Taylor
