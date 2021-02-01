Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEF1F30A5D1
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 11:53:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233305AbhBAKxG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 05:53:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232981AbhBAKxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 05:53:04 -0500
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 810D9C061574
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 02:52:24 -0800 (PST)
Received: by mail-qv1-xf2d.google.com with SMTP id ew18so7880253qvb.4
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 02:52:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=xAxHW8t26AK/BvxfyN2E75faUDCs1xxbN801V4CktZ8=;
        b=P1PU5TK3qnEy+bMxLHifbYddEVyElIPLkRtJFJt3ccBRzui30i2+Dzf2S4n9Adn3jR
         3szoVBZxxiWlg/5fyuuIzFAgL/mqai/EJsoKj64gncsKfCa41TtrQVH26U7nr3MLfV2U
         NqWurjB8xrrrBZUMqv/k+1v+6fUzI6DoHnMV3JisI47BqDLxGYrnMpFn3OaA9/0AVP0A
         z/+nGhA/GQ/RYbfheFD4eizQffW+NQFtcNREnwDqF9K0xaQjL3lNQXp7Cprcalx6+64f
         ySlNZMlM2avjFWRFdr9pPngSPMUSjzPRtlYbSQg+vehHM6SC3ivZPu4iArXJ3YwfNW2Q
         H48g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=xAxHW8t26AK/BvxfyN2E75faUDCs1xxbN801V4CktZ8=;
        b=rvaOezebSkO9ETwLPln2l/o5pMhP919Ppp0zAKPjLTTeUi+hCE3a51CUNJqsQflpGI
         ziyqrUb76Iaa1jMVqb2hb2djyyacnPR6FpCh/zytyAXNscY7PygEtgCotThaRbkIjPa3
         MUKa+qS+G20GOzke+G6JORCwZEndI+zI83+BaRfbFrRgu+7T38f9sysjmStY1zLiqRWG
         HUyTEWaRfFBpkzRnoeMZVcSN2YpdM1bWnwlhu8ov0012D5cKFeD/3uxjbHhLvpOjPfC5
         3Np9PQKaNFj243F4fK6L3D5+SbfBMmnMa8fQhnYWCPb1EAxH8VN09JXK9HX+L2HHK5qs
         EQpg==
X-Gm-Message-State: AOAM532v69Bz0UiuEBD7dQxPziXcg+qqGVH+osf/zfWZqgx7Gd3ZNQJs
        1v7o4gd7Abwumx0XnrkGpFJyF9EivdywOR1HmWPTG5+xbtd1Mg==
X-Google-Smtp-Source: ABdhPJx9ypusrvA6kDk9XNyTyN4tVOJSUte8hnpU0hyHCVdaQkt1fUKJatwlTXWldnkM/XU3rrvKYkFemUVn073uRTM=
X-Received: by 2002:a0c:fd8e:: with SMTP id p14mr14829886qvr.37.1612176743345;
 Mon, 01 Feb 2021 02:52:23 -0800 (PST)
MIME-Version: 1.0
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 1 Feb 2021 11:52:12 +0100
Message-ID: <CACT4Y+YytChe9Tv5etacBL4snEDu+A2fNzF4zKiKtfmH0C0roQ@mail.gmail.com>
Subject: syzbot reporting less duplicates
To:     LKML <linux-kernel@vger.kernel.org>,
        syzkaller <syzkaller@googlegroups.com>
Cc:     Eric Dumazet <edumazet@google.com>,
        Hillf Danton <hdanton@sina.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

FYI syzbot should report less duplicates now.
A significant number of reported duplicates was one of common
complaints. syzbot will now merge some slightly differently looking
crashes together, for example, these 2 recently reported bugs will be
merged into a single bug and reported once in future:

KASAN: use-after-free Read in skb_segment
KASAN: slab-out-of-bounds Read in skb_segment

You can see an example here:
https://syzkaller.appspot.com/bug?id=9936b32dd3a4a278f06a2cb07eb13df9e113ca84
which contains crashes for both "BUG: unable to handle kernel paging
request in cdev_del" and "general protection fault in cdev_del".

Hope you will find this useful.

If you are interested in heuristics details, grep for "alt:" here:
https://github.com/google/syzkaller/blob/master/pkg/report/linux.go
Crashes with the same alt title are merged together. In short,
currently there is one cluster for "bad access in function foo" (GPF,
fault, KASAN, KMSAN, corrupted list, etc); another cluster for passive
hangs (task hung, task can't die); and another cluster for active
stalls (rcu stall, cpu hang). These rules are based on analysis of all
previously reported bugs and duplicates among them.

Thanks
