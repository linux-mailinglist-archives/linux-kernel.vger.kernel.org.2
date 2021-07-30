Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7474A3DB150
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 04:47:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236316AbhG3CrF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 22:47:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbhG3CrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 22:47:04 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96101C061765
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 19:47:00 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id e21so9314468pla.5
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 19:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0gex/tHIIqROCazAIa+3yy3ZLtHLqR62SUUl52o7b/I=;
        b=yv5QtD7vE7XQ9YRuYnHH93xA6BszBoDQPh1YsgwRb1wfYMAsPuIsVGeBmfQp/niLX8
         eMvFzhfSP3SojsR67J6Ym7tnsGvVJPlWYM8QEx5AZamKDpBCpNXlH016/wMoLLvQS49d
         iEkJGtyzLMOstssUG78bj98UaY0UgACnT0Ytl6iq7b8hfd38S0fmd2uiqGTQ/Ezw3CF5
         yeU48XlrCRpQMUxICLO8wEfdObpCmeMPraHCg5SqRnzbo5CPasqtK5daP3nckmvvD4wu
         PWl6bUO8k9XfdcVwH5JK0KzZT2X6XFmmYrU4lKMMVugmEiusEcass8w2ApZomBALI1EV
         5w0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0gex/tHIIqROCazAIa+3yy3ZLtHLqR62SUUl52o7b/I=;
        b=XMtC1PizVipvRZ6eRZ0kiVie8Gkqf4yBf16s9tzvOMM0jFdr0STD+z+MEfRmdO18Ha
         4OZtio5wusP/kOuP6W4Kp9ymOfuRgxdipwUHS/NHBFmn5Y9GfD2h1/m1xKIec0PTCF5/
         dRS6casCQkzV0EUmA2G03v41DvaTWgXJn8h1+VN26p1o1lYkiHGos6xWd+udtcaIchYv
         xdYyfbysnkkP7elTm8eNeF5WQynxML3GM4m8M03A+Qbfs2MYjqId6G1c5tLv0jjMJ0jn
         o9LHaa4EOjHk9/kQ6ECCo8Nsry8BNYWlw+TO5HuUjOcAwhPOqYoMoJds64t3ShSWiXdy
         ZVhg==
X-Gm-Message-State: AOAM532cuNV4FtftJkCAv6ceKNMoVNPYTz9wyqb3NORWddCXOS9xZ+Hy
        lJZ47qs6znjKDxJNuhIuFyb7kS/CClBgrIWC1xZvoA==
X-Google-Smtp-Source: ABdhPJxWtHFvwccw8X2cCVMHaDPRSKyI+acIw3T+4nhZS7CWN2BYKFMRLVksux8cC657DEyvsJBXSjiVjfOQaNoF9Tg=
X-Received: by 2002:a62:92d7:0:b029:32c:8c46:9491 with SMTP id
 o206-20020a6292d70000b029032c8c469491mr324821pfd.2.1627613220241; Thu, 29 Jul
 2021 19:47:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210729092841.38175-1-ligang.bdlg@bytedance.com>
In-Reply-To: <20210729092841.38175-1-ligang.bdlg@bytedance.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Fri, 30 Jul 2021 10:46:19 +0800
Message-ID: <CAMZfGtUzop8aLjiSjj+Z+NmV7kLrqJXQVvq22EX2ybTqTjGNug@mail.gmail.com>
Subject: Re: [PATCH 2/3] mm: mmap_lock: use DECLARE_EVENT_CLASS and DEFINE_EVENT_FN
To:     Gang Li <ligang.bdlg@bytedance.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Axel Rasmussen <axelrasmussen@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 29, 2021 at 5:28 PM Gang Li <ligang.bdlg@bytedance.com> wrote:
>
> By using DECLARE_EVENT_CLASS and TRACE_EVENT_FN, we can save a lot
> of space from duplicate code.
>
> Signed-off-by: Gang Li <ligang.bdlg@bytedance.com>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>
