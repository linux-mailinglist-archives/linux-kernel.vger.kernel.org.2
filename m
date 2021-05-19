Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F01D8389882
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 23:20:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbhESVVe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 17:21:34 -0400
Received: from mail-il1-f200.google.com ([209.85.166.200]:49982 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbhESVVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 17:21:33 -0400
Received: by mail-il1-f200.google.com with SMTP id w11-20020a92db4b0000b02901bb97fba647so7823235ilq.16
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 14:20:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=fHKEKHdPjoZhYVJRZoCAKKckDq3mCm+7VXF61UEPMbE=;
        b=LuOb8d8OqX7kKh9gQqFdfgvFtHwmE8qF+kMku0xIG7hh0hRMDpnO2Hj/5O6/KpsXFG
         VJf57itfv8umk53K/aSDhf+xYz8qM9EdizXbrc38FI6ucI2X4OFx7+3tlDcVcqdbbjGG
         TIccVe77yoQydS6gqk2dMN0bBGAjXe24xS/DaEeJBw+nWm3XmETQ3G0yaIdReuPElJRl
         58eAEriSugD/sVPGbSJrKUJLQDCzfYtlRBeg7a5GN9WBeZEOdAoFjb0zxDPuDn0f1ktm
         /bCrgwWNAAxHaGAxBm0FE8COSH7VtsLg5okaZdioFRHR8Q4Uk2yM5QMuCVpBUBT1UTKR
         KLQQ==
X-Gm-Message-State: AOAM532DcKUq/EQqp0E4bzqeVBhCltBmYoPnS5ig6rAWMl/tXLX8XoV/
        o+oqTWhrKLiSdrSs3VadiwNAprW6MnKUYyjabhZ2OO0FKmSx
X-Google-Smtp-Source: ABdhPJx8VGV2AowHbhQLRUUM3t2/NTkPxF/lr8g2940N1fdAGo4lnn8PGW6H1XIbKr7SpsV+18LlWRt4H4yTIMVu63/Nu5zWdSEY
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:e05:: with SMTP id a5mr1018062ilk.235.1621459212835;
 Wed, 19 May 2021 14:20:12 -0700 (PDT)
Date:   Wed, 19 May 2021 14:20:12 -0700
In-Reply-To: <0000000000006932df0596121784@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000066201405c2b56476@google.com>
Subject: Re: KCSAN: data-race in wbt_wait / wbt_wait
From:   syzbot <syzbot+ba8947364367f96fe16b@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, elver@google.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        syzkaller-upstream-moderation@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Auto-closing this bug as obsolete.
Crashes did not happen for a while, no reproducer and no activity.
