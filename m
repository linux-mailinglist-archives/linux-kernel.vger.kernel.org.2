Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4669A3F9F58
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 20:57:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230437AbhH0S63 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 14:58:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230245AbhH0S62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 14:58:28 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1726C061757
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 11:57:38 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id d16so13122820ljq.4
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 11:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YxxLEk/XSr4w+re4v3pBg80KnJK57H4H8Qpi3MkYDbY=;
        b=Jg8UhP0MumuEF16XC/BDdN6h3G2VkliI2bln+XsceyJl5CxwtTks5T4jpFevEkg9i3
         nYPVQeA/fchkKPRtZkeWbC5DEUI0BBrFHkejQEBbuSjJWlprvPb5zJUMeUfXr9H45g6k
         2NmKyRGKrZm3y5Du+xJe6JyQX79ON09SLUbKc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YxxLEk/XSr4w+re4v3pBg80KnJK57H4H8Qpi3MkYDbY=;
        b=FPlfZALrIWgULkgUCZfUIAelbddZ5KP41W5CKQ8RZSmBjfrEMqByZhpON7I5zBw0KA
         IghR6Om+gsJ4VwNUx5kXHcpybEsely0VI3UPCQqRTJFNCu8MmTLJxufARYmbLGNv09Wf
         eWggrCpNVUgh7DTltyFnvbBIqM6pid6aYcZDfwv3k47ckIXSM/GQJdyZvgOmFugXVciN
         JYHKaCgjshJhjFS2yoS6znIQZBp3BidRnTpRWv5vMU8035QZy0+grenSpDxLA0GTbK5U
         tIHgfVhUfUiVdQfakcUYMHmXzJb3jPbvajPz8ISdnbAySpiumphdaQ+xhQPeahBxBX+H
         UXQg==
X-Gm-Message-State: AOAM530ym4aij6WFRwFkiZWjFFXlOoBNuNCb+Z6TGDSM6e24NaTHnC/Y
        Uv4LgIGy3RhpqUfwneazcVO+YT/6yQur8RJx
X-Google-Smtp-Source: ABdhPJyy307eE3yylzKH1VJqZDhQ4TGQNDOUu3xhu4wo4y5QpEEmETyJjD/fmuHdZnhgixQ5bqAzxg==
X-Received: by 2002:a2e:b807:: with SMTP id u7mr8991938ljo.268.1630090656599;
        Fri, 27 Aug 2021 11:57:36 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id w3sm775021ljm.13.2021.08.27.11.57.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Aug 2021 11:57:36 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id s12so13228092ljg.0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 11:57:35 -0700 (PDT)
X-Received: by 2002:a2e:944c:: with SMTP id o12mr8723398ljh.411.1630090655578;
 Fri, 27 Aug 2021 11:57:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210827164926.1726765-1-agruenba@redhat.com> <20210827164926.1726765-5-agruenba@redhat.com>
 <YSk0pAWx7xO/39A6@zeniv-ca.linux.org.uk>
In-Reply-To: <YSk0pAWx7xO/39A6@zeniv-ca.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 27 Aug 2021 11:57:19 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj8Q6PtnQqamACJU1TWpT4+nr2+YGhVwMTuU=-NJEm5Rg@mail.gmail.com>
Message-ID: <CAHk-=wj8Q6PtnQqamACJU1TWpT4+nr2+YGhVwMTuU=-NJEm5Rg@mail.gmail.com>
Subject: Re: [PATCH v7 04/19] iov_iter: Turn iov_iter_fault_in_readable into fault_in_iov_iter_readable
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        cluster-devel <cluster-devel@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ocfs2-devel@oss.oracle.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 27, 2021 at 11:53 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> I really disagree with these calling conventions.  "Number not faulted in"
> is bloody useless

It's what we already have for copy_to/from_user(), so it's actually
consistent with that.

And it avoids changing all the existing tests where people really
cared only about the "everything ok" case.

Andreas' first patch did that changed version, and was ugly as hell.

But if you have a version that avoids the ugliness...

             Linus
