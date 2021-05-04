Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C6FB372D95
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 18:09:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231683AbhEDQJv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 12:09:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231529AbhEDQJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 12:09:49 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1704FC061574
        for <linux-kernel@vger.kernel.org>; Tue,  4 May 2021 09:08:54 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id e12so9519301ljn.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 May 2021 09:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Tf/R97YEf4cFzt1vZ9gUcx48NN8pR3KeiNJvsYkKg1c=;
        b=QmkTJKvcsfPZuv1JX6swOXoEYeVJtK7+DCp0ngbQEG3HB5/LVcPjTPzZ9A8lpto6n/
         QbWdo2r7oFJ3iacS0C3orXwTHSICzrAgU8oJoG2xfbmps9bFuL2wzDyjhLdmTFdvHpSZ
         f8F5C21S2/HxUHwhfQp1Afe+T+NPCqQ1VjaLY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Tf/R97YEf4cFzt1vZ9gUcx48NN8pR3KeiNJvsYkKg1c=;
        b=FGTUgLOm0afNE466Vpqbe6nfq1e3AWscv2ZlPzy5KNR1Dz0GGO9hGX5GkSKapeWMvw
         5+4l50MOIT9s0algWisZk31KGUa+kX2XOi/19BqPy3t5fYaLbfK0lsoXV4FecftdlnKj
         blxAGB3yfU+dIYi7wZWcIhIBaqGUZ+S2EcGn8lU+vo6SYiggH/xGwDXmzQo9u0eqXIE+
         DhXWZtWFcWlsrWHQHyDXKsRO4hZCQpfoUK1KurQWzqVrYdsaT379gK6W48gAmD/1tLsr
         I3Azv9MgXePni4ypl5K47D0qf+9sxH7pKjy1sCj3BhX+jpDl7HP/kBI8z6nQe7tIXd8O
         wOYg==
X-Gm-Message-State: AOAM531t5GimEthmdtAGCTCSAzy4ApPrFPe5IZZzUhGtBOoLNS9xptE1
        Gk9lwnSYmY0xF1at30Qjt4GHvYVcXnOScn0R
X-Google-Smtp-Source: ABdhPJy6KeYtm3Q+C9pFnAIH2qx2vZg9F8ZyOIR96O4u6Mmaq6ZYrXaSYyP7EQUHpamv3cPE5lvBLA==
X-Received: by 2002:a2e:921a:: with SMTP id k26mr2612007ljg.149.1620144532420;
        Tue, 04 May 2021 09:08:52 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id t1sm299833lfg.226.2021.05.04.09.08.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 May 2021 09:08:50 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id u20so11787351lja.13
        for <linux-kernel@vger.kernel.org>; Tue, 04 May 2021 09:08:49 -0700 (PDT)
X-Received: by 2002:a05:651c:33a:: with SMTP id b26mr18071486ljp.220.1620144529516;
 Tue, 04 May 2021 09:08:49 -0700 (PDT)
MIME-Version: 1.0
References: <vs1Us2sm4qmfvLOqNat0-r16GyfmWzqUzQ4KHbXJwEcjhzeoQ4sBTxx7QXDG9B6zk5AeT7FsNb3CSr94LaKy6Novh1fbbw8D_BBxYsbPLms=@emersion.fr>
 <CAHk-=wgmGv2EGscKSi8SrQWtEVpEQyk-ZN1Xj4EoAB87Dmx1gA@mail.gmail.com>
 <20210429154807.hptls4vnmq2svuea@box> <20210429183836.GF8339@xz-x1> <lpi4uT69AFMwtmWtwW_qJAmYm_r0jRikL11G_zI4X7wq--6Jtpiej8kGn8gePfv0Dtn4VmzsOqT2Q5-L3ca2niDi0nlC0nVYphbFBnNJnw0=@emersion.fr>
In-Reply-To: <lpi4uT69AFMwtmWtwW_qJAmYm_r0jRikL11G_zI4X7wq--6Jtpiej8kGn8gePfv0Dtn4VmzsOqT2Q5-L3ca2niDi0nlC0nVYphbFBnNJnw0=@emersion.fr>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 4 May 2021 09:08:33 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiAs7Ky9gmWAeqk5t7Nkueip13XPGtUcmMiZjwf-sX3sQ@mail.gmail.com>
Message-ID: <CAHk-=wiAs7Ky9gmWAeqk5t7Nkueip13XPGtUcmMiZjwf-sX3sQ@mail.gmail.com>
Subject: Re: Sealed memfd & no-fault mmap
To:     Simon Ser <contact@emersion.fr>
Cc:     Peter Xu <peterx@redhat.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Will Deacon <will@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Herrmann <dh.herrmann@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Greg Kroah-Hartman <greg@kroah.com>,
        "tytso@mit.edu" <tytso@mit.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 4, 2021 at 2:29 AM Simon Ser <contact@emersion.fr> wrote:
>
> The remaining 10% is when the compositor needs a writable mapping for
> things like screen capture. It doesn't seem like a SIGBUS handler can
> be avoided in this case then=E2=80=A6 Oh well.

So as Peter Xu mentioned, if we made it a "per inode" thing, we
probably could make such an inode do the zero page fill on its own,
and it might be ok for certain cases even for shared mappings.

However, realistically I think it's a horrible idea for the generic
situation, because I think that basically requires the filesystem
itself to buy into it. And we have something like 60+ different
filesystems.

Is there some very specific and targeted pattern for that "shared
mapping" case? For example, if it's always a shared anonymous mapping
with no filesystem backing, then that would possibly be a simpler case
than the "random arbitrary shared file descriptor".

But maybe that simpler (if untested) VM patch is fine if 90% of the
time it's a plain normal non-shared mapping, and you have to have the
SIGBUS case for backwards compatibility anyway, but at least some
_benign_ cases are now handled without pain...

                    Linus
