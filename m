Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E42C3E1A25
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 19:11:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237575AbhHERLr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 13:11:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238328AbhHERLm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 13:11:42 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D72AC061765
        for <linux-kernel@vger.kernel.org>; Thu,  5 Aug 2021 10:11:27 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id z128so10160500ybc.10
        for <linux-kernel@vger.kernel.org>; Thu, 05 Aug 2021 10:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ERQbtS+fnxY/GTjgoyN4o7LqbVRRH79OP2qmymgXTb4=;
        b=GLD06EgaLKGHSCBxOJTN/DXGjec2pkyyzJTY1leEDGCcziiVUca3XMjOep8ny+eZPl
         WwIBrHwTE4pJCWUvcgQTu1EurBleqeX/YGIb5fcy9nYAyjYgzfaRK/ZAkersLxI+yYLh
         qS0Iq6/OYOwoevzPH22Dur+oqnmICw5w8d5erIyvyYQqF73KcnK2obR0w4QqyRHCuDsB
         2DZHlUt5JUAU28ukvUN8+pzbZjjHps5wuctG26TSCLmXYZq911yb9fgVcH9tHkbVxM9n
         bnudqaSbSeT0djOQBO0+BZkRwBwHLhM9XRYALf8fnwVbK6GnN2kHEWqbjpCza+U8qpIu
         Fpiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ERQbtS+fnxY/GTjgoyN4o7LqbVRRH79OP2qmymgXTb4=;
        b=sQCe7kz/x00uNOJ7Ois3JfVwqnOp+ZSdMN9aTmOqjJCER5Gmawtu304C1l1bV2246Z
         fclcSKPhpB7mmTmwUOeaud2sez3MfGxHZDLCcwZfN0oQnsf7g3cFy3mQnkFpWBd9zt/s
         WCw/pfmYdj/CLe9pyH8BMOHQ0YV/kJ8sEbTfOlaAcZTL925x3Au5Km22nACXrFvl1OS3
         ELgSm3K2UaNq+wLuHgwebIULOTy3jrvFO5orp0mFUCtMexdM8QgocZNEvnamzL7m0nbj
         +NIIv2cac54h8J6bidXCa/IBEeMfObW5HbJEGNgTmAw8x1mNIdt8qz9gm1Q/sqU7zYv0
         CNvw==
X-Gm-Message-State: AOAM531xlpcR/AdoNAzMAmf9dUyp7azMa7dye2l2nS/QIYxMRshOFfPC
        SXlbBESfH7kOnKYlckGFShzoByW0WRuWRV4gNz5W3A==
X-Google-Smtp-Source: ABdhPJzHLim3LivVZpBBq/WtrI2aeZb4sR+FqouWvGBUQtNrYWNyFBLCGhpPrixUmUXh2NvNijcm64R0KOQ7Agi9/Eo=
X-Received: by 2002:a25:49c2:: with SMTP id w185mr6617021yba.294.1628183486539;
 Thu, 05 Aug 2021 10:11:26 -0700 (PDT)
MIME-Version: 1.0
References: <20210804185004.1304692-1-surenb@google.com> <YQuO36AeQUwsAyU1@dhcp22.suse.cz>
 <CAJuCfpF1JSTSRu5v8s9wG0J-S+-p57tMO+0dUF+P16_6yYV7Mg@mail.gmail.com> <c67c89a2-02b3-a226-97ae-897f704b337e@redhat.com>
In-Reply-To: <c67c89a2-02b3-a226-97ae-897f704b337e@redhat.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 5 Aug 2021 10:11:15 -0700
Message-ID: <CAJuCfpFMZU2mJL1s9S6Fn9q-L6SKBfoqYc8Z8X1NQ2UQww1Pjg@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] mm: introduce process_mrelease system call
To:     David Hildenbrand <david@redhat.com>
Cc:     Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Rik van Riel <riel@surriel.com>,
        Minchan Kim <minchan@kernel.org>,
        Christian Brauner <christian@brauner.io>,
        Christoph Hellwig <hch@infradead.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Florian Weimer <fweimer@redhat.com>,
        Jan Engelhardt <jengelh@inai.de>,
        Tim Murray <timmurray@google.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 5, 2021 at 8:31 AM David Hildenbrand <david@redhat.com> wrote:
>
> >
> > I see. Let me update the patch and will ask Andrew to remove the
> > previous version from mm tree.
>
> No need to ask. Just resend and Andrew will (usually) replace the old
> version automatically :)

Done: https://lore.kernel.org/linux-mm/20210805170859.2389276-1-surenb@google.com
Thanks!

>
>
> --
> Thanks,
>
> David / dhildenb
>
