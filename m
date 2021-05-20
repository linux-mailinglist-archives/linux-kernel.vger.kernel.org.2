Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBC3A38ACDB
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 13:50:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243579AbhETLuP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 07:50:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:36181 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240937AbhETLal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 07:30:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621510156;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fApY2/CJIX1tFI96hzXYxLzQ0BStaTApGqNhPN+PjZY=;
        b=Yvxo3zqoxPlrkvfmPUByxGg2aldDt6D7CGtyiuxOELayzouSUc5cVDiztzylOaJEcf7j0r
        hFQVe1eGsoQUNkxaRTbdwf43zmiqz289eMrOY1gszC8PFG6EM+mHAiHwgpTDDYhOJKuui0
        a1wjew5dZP/QOHgCpaxeK7G7pneyRT4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-470-dYFSHUFaMy6owJFd8n7jcA-1; Thu, 20 May 2021 07:29:15 -0400
X-MC-Unique: dYFSHUFaMy6owJFd8n7jcA-1
Received: by mail-wr1-f70.google.com with SMTP id 7-20020adf95070000b02901104ad3ef04so8527417wrs.16
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 04:29:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fApY2/CJIX1tFI96hzXYxLzQ0BStaTApGqNhPN+PjZY=;
        b=QDC55ybw3fwZKYliQj9PHhk4SQv8FdNpEXKf9Sc7hyDrleEZhGrHl0FKIIUtQx61a7
         eeREMbDcZwaEaYsMCYsttis8/75KrRFC2ebjCDChNG7XjCYl6I++dZJrPXuYmcTfF4r7
         nRl9g/SfUZAfld2b9mvUuYpevysZLuMtHI24Y4STRxUHgBnWaga+JzjARO4cbDCF9eLS
         lB2Ximt2Ri2XN5M153ZYfnG5HImgDwgQCW/6agNePyptzZlCnUFqns2q4/+z8h6TmoW4
         Umc71Rk36ltBf+2nPaROWrBw6JxdlfgN0BLMuMR/dV9sqfg1CkP7zYm2/UBS75MA3O0z
         aa2w==
X-Gm-Message-State: AOAM5335fd7z0QEA0nEhxjpPd6f5lHWFdJiljgqSGGRTFeVzCLgc4kK0
        4OysE9UtQu/7zvJpzhQaDDxUquedWYykoWhaO3gsYdQOt058jV9NwboP5IkqOkSPcI6UrPHxl10
        1Cj4sl50+mjBooDMufKjbOKwN9UWRmb9IlRa40rpu
X-Received: by 2002:adf:e589:: with SMTP id l9mr3891974wrm.361.1621510153896;
        Thu, 20 May 2021 04:29:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwuJsZNK3zu08Ws9lCvd1BVkAGIlYMcVEjOIv5bj7ch735Gnid6Ymu5WOSwbPYZGxsNdrkKZq/r+3iHJThN8k8=
X-Received: by 2002:adf:e589:: with SMTP id l9mr3891964wrm.361.1621510153781;
 Thu, 20 May 2021 04:29:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210519060809.1288-1-hdanton@sina.com>
In-Reply-To: <20210519060809.1288-1-hdanton@sina.com>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Thu, 20 May 2021 13:29:02 +0200
Message-ID: <CAHc6FU4iHhbJ-mfOR=sJMNXfMjLLfr7fnrRxQ1cmj9VaT9yQFg@mail.gmail.com>
Subject: Re: [PATCH] gfs2: fix uaf in glock shrinker
To:     Hillf Danton <hdanton@sina.com>
Cc:     cluster-devel <cluster-devel@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Bob Peterson <rpeterso@redhat.com>,
        syzkaller-bugs@googlegroups.com,
        syzbot <syzbot+34ba7ddbf3021981a228@syzkaller.appspotmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 19, 2021 at 8:08 AM Hillf Danton <hdanton@sina.com> wrote:
> The GLF_LRU flag is checked under lru_lock in gfs2_glock_remove_from_lru() to
> remove glock from the lru list in __gfs2_glock_put().
>
> On the shrink scan path, the same flag is cleared under lru_lock but because
> of cond_resched_lock(&lru_lock) in gfs2_dispose_glock_lru() progress on the
> put side can be made without deleting glock from lru.
>
> Keep GLF_LRU across the race window opened by cond_resched_lock(&lru_lock) to
> ensure correct behaviors on both sides - clear GLF_LRU after list_del under
> lru_lock. That is the fix to uaf reported by the smart syzbot.

Thanks, I've added this to for-next.

Andreas

