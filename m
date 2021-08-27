Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6BE23FA18A
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Aug 2021 00:35:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232301AbhH0WgR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 18:36:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232177AbhH0WgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 18:36:16 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFDFFC061796
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 15:35:26 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id f2so14058517ljn.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 15:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0rGLz7zH5VYaPQJm/5R2FgZ/IY8lzcUOIJsQBb/VIWM=;
        b=JD5mh7o51KK+kOxvguNTQUf7rTVF4w9SHbDvpplojTGO4MeyrRJfBlT2B58LyfaviY
         ahMIKvD5OTZrK3VLe5bxgp+oJ1xCnF26s9jzJ+FtmfmTaj7/yI+G8RCXONqVaiSYQS1G
         DBec3lrLIt/IGBcPX8jc1EEIbl9Sy+LcB1dGE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0rGLz7zH5VYaPQJm/5R2FgZ/IY8lzcUOIJsQBb/VIWM=;
        b=eZmb40u5zVDSuAYqBMzwrXY7A7c9JgW8rsGPjlE3JCxz8rn0cBVNg7xAZ47lK9SDk5
         ZzE9E+QN3CpyAGG/QyblI9cBjNGdlPReCVqx8dCvevZZhMSnU/NJxaGqYCVhHQc5/8Mg
         uc2XcVYUPurJXXlyPoOE5pEJdXkQrBXMonWjmHSayPorB5NM/+wg5egan0ljHQZot1B+
         ndCsXDCeC80aXceMxiwEX9uwILNbs0cW/SfWLY/kJ+vYVo3yMilT6U+QymNv3WyAvtjC
         pp6S+Std4wjLfvlO96e5mYb8GOnDLBYiiNFKG77/6EGJBlfxoGiU8XTIoEdNEvHx29PY
         Zbxg==
X-Gm-Message-State: AOAM530VwDLRLAAfl8MwO+V3FRIcn72ivT32LTdP+J23y83RcPTMbtXq
        yPL+Q7snabWEjSzamgWAHhPBFWwRv56bz22R
X-Google-Smtp-Source: ABdhPJyOhd8m3YiXbXNkhoKsweYmj+fg4Be7O/rTdZrEkfRL0ethLtKb4kD0qHXtmdaQWsOochnfQg==
X-Received: by 2002:a2e:bc2a:: with SMTP id b42mr9467762ljf.395.1630103724661;
        Fri, 27 Aug 2021 15:35:24 -0700 (PDT)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id 138sm823596ljj.128.2021.08.27.15.35.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Aug 2021 15:35:23 -0700 (PDT)
Received: by mail-lj1-f170.google.com with SMTP id h1so13983485ljl.9
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 15:35:22 -0700 (PDT)
X-Received: by 2002:a05:651c:908:: with SMTP id e8mr9500825ljq.507.1630103722494;
 Fri, 27 Aug 2021 15:35:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210827164926.1726765-1-agruenba@redhat.com> <20210827164926.1726765-17-agruenba@redhat.com>
 <20210827183018.GJ12664@magnolia> <CAHc6FU44mGza=G4prXh08=RJZ0Wu7i6rBf53BjURj8oyX5Q8iA@mail.gmail.com>
 <20210827213239.GH12597@magnolia>
In-Reply-To: <20210827213239.GH12597@magnolia>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 27 Aug 2021 15:35:06 -0700
X-Gmail-Original-Message-ID: <CAHk-=whCCyxkk+wfDZ5bQNX62MfdprBLpy_RwpSFhFziA2Oecg@mail.gmail.com>
Message-ID: <CAHk-=whCCyxkk+wfDZ5bQNX62MfdprBLpy_RwpSFhFziA2Oecg@mail.gmail.com>
Subject: Re: [PATCH v7 16/19] iomap: Add done_before argument to iomap_dio_rw
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        cluster-devel <cluster-devel@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, ocfs2-devel@oss.oracle.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 27, 2021 at 2:32 PM Darrick J. Wong <djwong@kernel.org> wrote:
>
> No, because you totally ignored the second question:
>
> If the directio operation succeeds even partially and the PARTIAL flag
> is set, won't that push the iov iter ahead by however many bytes
> completed?
>
> We already finished the IO for the first page, so the second attempt
> should pick up where it left off, i.e. the second page.

Darrick, I think you're missing the point.

It's the *return*value* that is the issue, not the iovec.

The iovec is updated as you say. But the return value from the async
part is - without Andreas' patch - only the async part of it.

With Andreas' patch, the async part will now return the full return
value, including the part that was done synchronously.

And the return value is returned from that async part, which somehow
thus needs to know what predated it.

Could that pre-existing part perhaps be saved somewhere else? Very
possibly. That 'struct iomap_dio' addition is kind of ugly. So maybe
what Andreas did could be done differently. But I think you guys are
arguing past each other.

           Linus
