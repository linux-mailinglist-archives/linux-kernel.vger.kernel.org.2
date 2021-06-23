Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11A1E3B1433
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 08:53:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbhFWGz1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 02:55:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbhFWGz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 02:55:27 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43B87C061574
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 23:53:09 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id bg14so2278722ejb.9
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 23:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GPff1zuVJOczP113JwbHW6RlycNYQVY66PmMZBuOr6E=;
        b=YrKobmck6zwAgRxXw7R5JbweMjyPWcSu1MaLj9l+k76/kgwegZNKk4URfKlht1yiKO
         9bNODQMvyBBV10ycisky1QRL6iRd91yA7oZ4uDH+b7hvZ6uenKPgjAD0R3GsMJ4d1po9
         LGCC2I8H2MEBu8dhKONx3m4CU5r339RgXbzOSwlNbbvJ6OU8E2772M0377Ox8wTzJKR5
         fuKU/IeS6iEmaiTdkmU6QNy/5+r3IPwL8bWTAeEn0KIQoFRJqUhqmkVCWJD90n3xdqev
         zy+57Sx4ueN4iPsHktbgetpr1EwWDF9xYeJs3CEh1mnAvnOmdb9NDAh7OpKuuQ10zXEJ
         t3RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GPff1zuVJOczP113JwbHW6RlycNYQVY66PmMZBuOr6E=;
        b=n42gzSuRiyqkO2rKTt8pPEZ+/mwXY6bZbjBu/u8+JkkLvWVE7Qd8ijjhNfl/7eEAO0
         Zih9ObWiiCCyzCSvNq91bZgfnn7NJoNenuMLgMO3QKOjFctv/KZLwEhahsxG5oaAr++U
         AhdorLAAa2s/5zs2cFkELOZviX+jzJoQOWrDL82DonDj4eMZ8sojrKVE/GEMvhq89SEi
         rkH5DswbMsuefzT73QqOuGVawmPyjJNSORcZWYrMiEw4WyG0r+s9jpTgIMx/1Tav30AF
         GW2FJzCv/v6aAb0+xvx/Kc1iA2nMdjrptxlqWyfINaJwOK1eycbkCTpOF0e8hDD21uQF
         7xNw==
X-Gm-Message-State: AOAM5315hesMiuOQoaE1xlHG2M2/MWzFjrmjUF4zVgbzKiZDg0rtv3cq
        UaCfTG4aaZMTWFnc37P/dkaf/xHVm9ND9JRqubo=
X-Google-Smtp-Source: ABdhPJxSBDW9iUaKGAf5+5glqZHxyQ6hfy8PYdE6I58bzttxCE0YeXbUSn9St6nkDe/BPKYfKmV1A1FlwWP5hekjaR0=
X-Received: by 2002:a17:906:d288:: with SMTP id ay8mr8105744ejb.230.1624431187839;
 Tue, 22 Jun 2021 23:53:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210622215757.3525604-1-willy@infradead.org>
In-Reply-To: <20210622215757.3525604-1-willy@infradead.org>
From:   Pekka Enberg <penberg@gmail.com>
Date:   Wed, 23 Jun 2021 09:52:52 +0300
Message-ID: <CAOJsxLFm7ws4+Q_VwKxqAvt61snVv3TmxVHxt20P+SATaQeURQ@mail.gmail.com>
Subject: Re: [PATCH v2] mm: Move kvmalloc-related functions to slab.h
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        David Rientjes <rientjes@google.com>,
        Christoph Lameter <cl@linux.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 23, 2021 at 12:58 AM Matthew Wilcox (Oracle)
<willy@infradead.org> wrote:
> Not all files in the kernel should include mm.h.  Migrating callers from
> kmalloc to kvmalloc is easier if the kvmalloc functions are in slab.h.
>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Acked-by: Pekka Enberg <penberg@kernel.org>
