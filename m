Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB50E4194A4
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 14:52:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234445AbhI0Mxx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 08:53:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234360AbhI0Mxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 08:53:53 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80B7CC061575
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 05:52:15 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id d13-20020a17090ad3cd00b0019e746f7bd4so10063309pjw.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 05:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=uwRoL4vai1J0WCVDQj2ZNZYEe4M117wFeqCni6D+v3E=;
        b=lIuP9Ea+24LNri1ZcHUdW/tVNQU6hgWf3lQMcY95jfTE1wQGynD3ga2bdh/5fiQFZc
         UUVP09bfDPEFimluS++Fl83/d7CDJgAlCM6s2z9A75bueSCVTgNWHl4oDxPmwheDxSrJ
         Wz4rskU73WgwwIMLriyk9Mo2xpBQ7lBLVWb27Y1T4fgQ3oWzDh8Axg8kb5DKTIX+UKLd
         oi1lw4uIBnBQkrcXQeGnF1Ux5oyeuTG4aLdnNllda7WUUgOAXxq2nbJix5fZik9fKOYh
         rB0QzqnBDqd26WDp4QwvOlBSNkkhWGWNml55lp4lVYIio878F2uYtU2DVae0i8gkOoAB
         qyBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=uwRoL4vai1J0WCVDQj2ZNZYEe4M117wFeqCni6D+v3E=;
        b=f3uPWYyWI1iy0HZ7DhDY+PTSVS3npPmDsjR9bF2RijPbxG78zVpn812eLT1oYueIxd
         SJze3pyfOtCvT750mfA8n2P+IkNkQGATRhYrg7IqPm59uUC6X91x6cicNXoaunTfRZuc
         Q+2HZJz14PjZIvGtWpaDyBFSLDJOdcosWkO2p06vviSzpHOXMj6kWlxCVufk26PM4Nif
         uP22UkVGmt0Gg/PzsfsW+zYiz47OHy2Ktu2azuZzjvhesgm/Fy80vOQ0s9YNf05Q9fpT
         srzTc6HoHSHHUNkEaAFea1Uo5rHDcOQW2M0r+OGMfGMjlLfi6RoJId9PViXg//facVSj
         xAcQ==
X-Gm-Message-State: AOAM531OlFXeTBno2W0kWkwbwERVdfbqJxUeR+gzlIpTN1nPRdFlMkKK
        JY804vqYhG0Uzm1KAnj/fgU=
X-Google-Smtp-Source: ABdhPJx7Pg/Umy0XcsNCFDGYkPG5X0aJOG/Q6pDcZTE/qrvym6KCK3DQx7zD0+9QBdbYAzi4puEBhw==
X-Received: by 2002:a17:90a:8810:: with SMTP id s16mr8581927pjn.7.1632747134920;
        Mon, 27 Sep 2021 05:52:14 -0700 (PDT)
Received: from smtpclient.apple (c-24-6-216-183.hsd1.ca.comcast.net. [24.6.216.183])
        by smtp.gmail.com with ESMTPSA id q18sm17715537pfj.46.2021.09.27.05.52.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Sep 2021 05:52:14 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [RFC PATCH 2/8] mm/madvise: remove unnecessary check on
 madvise_dontneed_free()
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <20210927121902.r5gslag4nvvseoxo@box>
Date:   Mon, 27 Sep 2021 05:52:12 -0700
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Peter Xu <peterx@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Minchan Kim <minchan@kernel.org>,
        Colin Cross <ccross@google.com>,
        Suren Baghdasarya <surenb@google.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <8ACD5AC6-2235-4A62-8044-F686EB26840E@gmail.com>
References: <20210926161259.238054-1-namit@vmware.com>
 <20210926161259.238054-3-namit@vmware.com>
 <20210927091143.tn6ediykqycu6rtu@box.shutemov.name>
 <DD025444-B1A2-4470-9069-0072A59427A5@gmail.com>
 <20210927121902.r5gslag4nvvseoxo@box>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Sep 27, 2021, at 5:19 AM, Kirill A. Shutemov <kirill@shutemov.name> =
wrote:
>=20
> On Mon, Sep 27, 2021 at 04:05:47AM -0700, Nadav Amit wrote:
>> Having said that, if you want, I can turn this condition into
>> WARN_ON_ONCE() or VM_BUG_ON(), although I really see no reason to
>> do so.
>=20
> BUILD_BUG() should be fine here.

It does not work. At least my gcc is not smart enough to figure it
out in build time.

I can put instead:

	BUILD_BUG_ON(__builtin_constant_p(behavior));

for potentially smarter compilers (clang?), but I doubt it would work.


