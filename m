Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB1F5459541
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 20:03:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234897AbhKVTGk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 14:06:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231959AbhKVTGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 14:06:39 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99C66C061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 11:03:32 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id y12so81354835eda.12
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 11:03:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=88MiCrNUO1fu1ZV77EpG2zm8wlaV03pygYzQ5K3Jbkc=;
        b=hvC5Ebadv1xLbNrESA8R/fltWWJ2K40QDdsBlrqtbua2y0lC062juL6avNj4AbPRv5
         au08LCuSjgOvQhJykgwXhKHor2m6z0CEK83nfNX26yJwZRzqgjFvLBh1HXO7OEl3u43G
         gApz2Mwdcg9F9kU/HuxvTWVUyPVT4F7mXLd4bclmFNqHxi0c8tbbjdFWAuysG0yIba7s
         Wah+MwsqyAi3e6JDBYRNmyucTe8kmBa72/bUSViYHQQq3xhjasPMqNxBXafKJeecgdfy
         cHASNJvd91nSanmXZJ9+iHvCRd33HFkyv1ndhZlgihv67Myj1lqG2XmeJFps4wxNmJ4R
         kFEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=88MiCrNUO1fu1ZV77EpG2zm8wlaV03pygYzQ5K3Jbkc=;
        b=FAisfAsaZgXq/7/oagSAJ5y2Pe7NLMVAfQHmcMupJWFqHye4YrjrhF9Jm+uDMpSvPo
         7fGym0dbtt1fDZJzSkNde+aU1VVu6CSWOzwB8L4duAobhooZ+7YCwabGmSfMaVRK10Mm
         GZ7KaChR5Uu+tl/ByQv7YHRFZEh+KcFrfA1mQIEJ6mlmcuJwHzOehQiQsCNWmYQ5BVib
         O0dRa+AaZdCs/9zmj9ow/EjiWa5KUpH5wqzNywbmEModw+pPHUgiebNXPlEaPK8i9jpz
         kWMJtWuR/2JcB6098G9/Ss9xx9YRVQy9m5DKyVtFwYRtaYhxOUR9Tbx/DJUQZG83vHoB
         +OpA==
X-Gm-Message-State: AOAM5323tAJu8UT1bWImTp99EHeL0W8L7hpHQtees7xjezVXXeg8OOTf
        uTzypIxzVwlbvLEBXtcB087Pndfjx7p/1SppRFk=
X-Google-Smtp-Source: ABdhPJyAEj062POSm32f+YSEoYXryO5reyMb9qNmunkYCkGfTlhed21lrKBgQfDlcBipKqlNo5wK9Rlm+YMWfM/mXM0=
X-Received: by 2002:a50:a6ca:: with SMTP id f10mr66794394edc.81.1637607811163;
 Mon, 22 Nov 2021 11:03:31 -0800 (PST)
MIME-Version: 1.0
References: <20211116193247.21102-1-shy828301@gmail.com> <CAHbLzkooDg-KbtBxofBYFvNF8nN=vTCwb6+srYZOHqqBLH58Zg@mail.gmail.com>
 <CAHk-=whDwowy+Q_M74f=0AFW3izcqU9U1OL2agyOF7=4fvPefQ@mail.gmail.com>
In-Reply-To: <CAHk-=whDwowy+Q_M74f=0AFW3izcqU9U1OL2agyOF7=4fvPefQ@mail.gmail.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Mon, 22 Nov 2021 11:03:19 -0800
Message-ID: <CAHbLzkrXdknzNmBWCnTPS0ey1vnhMB5-hPPDTORvnc2dMXwkKw@mail.gmail.com>
Subject: Re: [v2 UPDATE PATCH] mm: shmem: don't truncate page if memory
 failure happens
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Matthew Wilcox <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>, Oscar Salvador <osalvador@suse.de>,
        Peter Xu <peterx@redhat.com>,
        Ajay Garg <ajaygargnsit@gmail.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 20, 2021 at 2:13 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Thu, Nov 18, 2021 at 10:55 AM Yang Shi <shy828301@gmail.com> wrote:
> >
> > Does this version look good to you? Would you please consider to apply
> > this to -rc2? Or you prefer to get it from Andrew?
>
> I don't see anything wrong, but yes, I'd prefer this to go through the
> -mm tree and get at least that minimal testing (and maybe extra eyes)

Thanks, it has been in the -mm tree.

>
>          Linus
