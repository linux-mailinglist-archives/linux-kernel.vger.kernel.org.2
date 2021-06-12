Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 699633A4F89
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jun 2021 17:48:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231422AbhFLPuX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Jun 2021 11:50:23 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:49004 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbhFLPuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jun 2021 11:50:20 -0400
Received: by mail-io1-f70.google.com with SMTP id u19-20020a6be3130000b02904a77f550cbcso20386642ioc.15
        for <linux-kernel@vger.kernel.org>; Sat, 12 Jun 2021 08:48:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=fHKEKHdPjoZhYVJRZoCAKKckDq3mCm+7VXF61UEPMbE=;
        b=EKoxkRVvEHfguBNuOB55nyvHtxEzEYYV9wapsXfbC3fF8bM8JodQDmKQ5Vkb3ea8D4
         CHUbThCaIzk5aYrhVYOebr/awA0jSlHt2fjfC586X4mHmsiflGSjziPrP06E1iVqeBh+
         qCgPKt2MqBqBZ+9GPRHUtuLCqqmsUXzKlDsU50RG4BHgyoglyosrpYJvN55W3S2vEnV3
         LUiEjalB7RvVhUJQyIreT6VDwuNBCzSutRgwLcy2u0G5nKvWRg/hk0EHuapiibqrxbBB
         Azxcw8PsJ7V/670v3NJdNelfZSG4enAEGCxNY8u+4n6flqwP8Rcjh68wBi4BFsWBhFl3
         woTA==
X-Gm-Message-State: AOAM530fQLwUFGVVEU9mY6k2pCHE/cM4hQLOtE91dav8XF75p+KFAEau
        +apRt1QcNw1PHpP+LKrTgj0n7MzAkv3360VO7qxG4ECAQwia
X-Google-Smtp-Source: ABdhPJxwicvpslAfehGqNDqtLCXqGTIaNYt46nQ5oM7xsDuDXeu+CzN/C0h5XtpoKbFsY4h1N65d9YNhyl6wHUwYr2dM4hUnln8a
MIME-Version: 1.0
X-Received: by 2002:a92:c211:: with SMTP id j17mr5619986ilo.232.1623512900682;
 Sat, 12 Jun 2021 08:48:20 -0700 (PDT)
Date:   Sat, 12 Jun 2021 08:48:20 -0700
In-Reply-To: <0000000000000c97e505bdd1d60e@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000bbc7c905c4938de9@google.com>
Subject: Re: INFO: task hung in io_uring_cancel_sqpoll
From:   syzbot <syzbot+11bf59db879676f59e52@syzkaller.appspotmail.com>
To:     asml.silence@gmail.com, axboe@kernel.dk, hdanton@sina.com,
        io-uring@vger.kernel.org, linux-kernel@vger.kernel.org,
        oswalpalash@gmail.com,
        syzkaller-upstream-moderation@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Auto-closing this bug as obsolete.
Crashes did not happen for a while, no reproducer and no activity.
