Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5414838996F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 00:44:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbhESWpl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 18:45:41 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:34558 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbhESWph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 18:45:37 -0400
Received: by mail-io1-f69.google.com with SMTP id e84-20020a6bb5570000b029043a9371b108so10589243iof.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 15:44:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=fHKEKHdPjoZhYVJRZoCAKKckDq3mCm+7VXF61UEPMbE=;
        b=TjM+UrXxE33FMzGfgH96UGkkMEETgOwPCaNaVIaZzPfQahUtVSgLlIZmyyf58iCyyA
         wiE12y03GQ9+JKE9AEp4Ks2Gx8NfbLLe4+NOSOb5AX58IFCfBqvg4FkQRv6CfA1bieZW
         QNM3N+20i/+KtLWGnbQlH9HMavccdsyO2ROvUEqp+dV6c++AqtErFI5MTeR8gz8SKWch
         ij337rdQmly7Yw93UW7EOCk8wPRRXdC2nWnYArn9taOXoVGti7JhbhYSKEdv2kEHhzIx
         wD1qXTPbZQXmlNdb2ZLIflcu5ECW0O7ggaef1H5kn30btOYQ9dyDwkiuNYjELVXRAcgi
         Xgyg==
X-Gm-Message-State: AOAM5316Uhim3LuPu3k2w3JKJCmEcnWAlDgfeDNNN30CrCqXn3EAhOah
        +Ov0OqVaJDJu4X6INrTHfdyIeFsLmASGMMKvsLVijLBPKIoI
X-Google-Smtp-Source: ABdhPJyy7WsmunMscRzGZVcZm0kcgfRUDFw5tRRNg+oc3UqRBjmZABfpUTcyQT1bOgD6k6kE4tP6yI+RwGd/mTsf9t7t7n0b8AVu
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:490:: with SMTP id b16mr1608186ils.213.1621464255133;
 Wed, 19 May 2021 15:44:15 -0700 (PDT)
Date:   Wed, 19 May 2021 15:44:15 -0700
In-Reply-To: <000000000000a62d9705a9b61a4e@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f17f5b05c2b69026@google.com>
Subject: Re: KCSAN: data-race in __mod_timer / expire_timers
From:   syzbot <syzbot+aa7c2385d46c5eba0b89@syzkaller.appspotmail.com>
To:     C.Emde@osadl.org, bigeasy@linutronix.de, jkacur@redhat.com,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        rostedt@goodmis.org, srivatsa@csail.mit.edu,
        stable-rt@vger.kernel.org,
        syzkaller-upstream-moderation@googlegroups.com, tglx@linutronix.de,
        wagi@monom.org, zanussi@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Auto-closing this bug as obsolete.
Crashes did not happen for a while, no reproducer and no activity.
