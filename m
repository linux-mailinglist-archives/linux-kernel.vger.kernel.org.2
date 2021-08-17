Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE9123EE5B4
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 06:30:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233902AbhHQEao (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 00:30:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbhHQEan (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 00:30:43 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 518A2C061764
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 21:30:11 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id i13so20848852ilm.11
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 21:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WnD/sqQt1eHkhZeP7ZVGsBnVN9a99AUvhJ1HTLg2KCw=;
        b=Ze8Y8t4STx8oMENHOWVzkao6MKmTjCXo/JgixRUHMzY7jtvNtQexq0jK3F0e+DNixb
         ghinWx9X2FHgCWoNLS0y+AB6Kz5dUwiayFvL0IfdxU30oUPWjDvnbS2trjOLJP8dJDEj
         pb4LsqJn06B5sfvBd8Dbxy1CW9aLFFHcbJK2Eo+ReYo8z2ABQKcVYSjh4j4lZZHVBdpN
         nmlml3g3Dl0S6aKllGBvTpAZK7aQvVmjWp9jM5y0hsIzTqtfQiShmc1shJpWIAriV/WP
         f8e8C38Po36GC09jTDGWgteCYc0d3XYXJEbqCpOHiOubeHbKHdmjLjF9xE00jbOB9woG
         VQwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WnD/sqQt1eHkhZeP7ZVGsBnVN9a99AUvhJ1HTLg2KCw=;
        b=O3ukdaC2ST5rIKnkM/DNGD26sAOVAxy2RuwU7hOyoyuNuGHRmi47rJjq0ISVYS4n+E
         2pB++VbcWCT1LRwKZttKOHYdtxMBvckDHBZiH4O7lIQEj7wNGc2sfWILOYyagqf93psw
         m2VAjCop3XxPRTBxhrBXtuh85264hCCJqoqMdwi1J42pFR0GXiJsy456TabUqgVSJWkg
         Oqa5bwXPEKzgD4z9Mg5S+5lRbe0MOjUQHK8aAUGzJPE2IvppdHpDJ9SrGdTTQ7fGVQ2C
         n4didZkrDxaPcej/ZXpFmmYWfs4YUtgoVs3WYgLCsf/PwxV+NB5sAvNEdnASI2ulg3dm
         ZJvw==
X-Gm-Message-State: AOAM531Wn4UEXjqaxc0uYb+byn+lLMGhezuWvw+3ZPmQVp7LEzYqeXuH
        iQkTw/35CQLm5I3aTtQEv0CaqoWaeGcB5WjkL5PykAfB
X-Google-Smtp-Source: ABdhPJw5qNj7eG2lbuCLe+728TWrldRugpkBxeEf90Ai5QDyP7o/YwWGv3U3VrVYbhxp9bHo/eOfW2LRjEhOxIEOMtU=
X-Received: by 2002:a05:6e02:1bed:: with SMTP id y13mr1086910ilv.276.1629174610800;
 Mon, 16 Aug 2021 21:30:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210806121521.124365-1-xianting.tian@linux.alibaba.com>
In-Reply-To: <20210806121521.124365-1-xianting.tian@linux.alibaba.com>
From:   Jassi Brar <jassisinghbrar@gmail.com>
Date:   Mon, 16 Aug 2021 23:29:59 -0500
Message-ID: <CABb+yY3i5aZQrimoWLTMQRY5WsOJ1FCGNxBN0Hz_=4qxUvoqSw@mail.gmail.com>
Subject: Re: [PATCH] mailbox: fix a UAF bug in msg_submit()
To:     Xianting Tian <xianting.tian@linux.alibaba.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        guoren@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 6, 2021 at 7:15 AM Xianting Tian
<xianting.tian@linux.alibaba.com> wrote:
>
> We met a UAF issue during our mailbox testing.
>
> In synchronous mailbox, we use mbox_send_message() to send a message
> and wait for completion. mbox_send_message() calls msg_submit() to
> send the message for the first time, if timeout, it will send the
> message in tx_tick() for the second time.
>
Seems like your controller's  .send_data() returns error. Can you
please explain why it does so? Because
send_data() only _accepts_ data for further transmission... which
should seldom be a problem.

thanks.
