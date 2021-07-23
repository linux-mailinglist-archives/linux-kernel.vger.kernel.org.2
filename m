Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4DC33D3C0E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 16:54:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235437AbhGWONn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 10:13:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:30137 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235351AbhGWONa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 10:13:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627052043;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KzcnGLaacDgNN8JHkByoexh8GLTQOigyRJDFx1KyDyI=;
        b=gkD+OTzKaN9ITGSUy4rUXoFnZ65UbIwaTaOH8oLurWIrQkcPXqgUqqMCaxYFU971Fdp//t
        wlB0IAFDRiFrWjZJwvPntAmvPlh6kDPzxAHCE+zwn7IhG5lNUteII0yvvApC1BGy5Raur9
        YS2aad1lG5B/9/ksBpblgqMVAKLbwhM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-78-W4e0NKjoM62qwxhbK2OT6A-1; Fri, 23 Jul 2021 10:54:02 -0400
X-MC-Unique: W4e0NKjoM62qwxhbK2OT6A-1
Received: by mail-wm1-f70.google.com with SMTP id c2-20020a7bc8420000b0290238db573ab7so1503767wml.5
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 07:54:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KzcnGLaacDgNN8JHkByoexh8GLTQOigyRJDFx1KyDyI=;
        b=eukcg+UOZLMVVxLkkPKB3WrrPItR+2UXmKbnR5ardj80yQNzyaAECdPBcmeANbc6Zs
         lD2EfgNL/yLq8/MdEQ4ycOWuGOF6Xhmx13P9BkccZpZu6SogGzRsnO/py6p+qaswVmkh
         z4e9BsAYchrCX8NEtZiqWkhPiExGnquL6bfYYOiH08nY3tffGET8pgxPcNU8ZYcaiHLq
         EERgZNXV2Rh55cOwj+EXgU2qzK0JIFC8O+/7MDSVtfgfg9FGqgsHHP7d0Dup76HNCeCc
         LNjteF56Cteawu7EeP9XluTqUhzQAiXYws/B3UV678FAPYiHecps7/K6U84BjsW/JxVF
         Izzg==
X-Gm-Message-State: AOAM532VmA+l7xVv2Qa6X6QvWj0ETyfdEdvZKxVeNLw4rwFsIErWa+Ec
        Ht0B5n5Y9iu0MMltabCxpJyHNJOmjN6vFK9w7mvpGVPk9qUQ/un2ZlN1NDT+hSo/H9GFE8ScCrm
        NgBnHTjPU2fvSxn+96a47sipf
X-Received: by 2002:a7b:cb4d:: with SMTP id v13mr3594839wmj.68.1627052041371;
        Fri, 23 Jul 2021 07:54:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzg3/rHxC6b3F9kv0Z/oQV6K4OuNHE8KmjmwppyGJt73QDUzut6gjIGYOsMCZq0dX32zZczvQ==
X-Received: by 2002:a7b:cb4d:: with SMTP id v13mr3594830wmj.68.1627052041247;
        Fri, 23 Jul 2021 07:54:01 -0700 (PDT)
Received: from vian.redhat.com ([79.116.5.179])
        by smtp.gmail.com with ESMTPSA id w18sm35594863wrg.68.2021.07.23.07.54.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jul 2021 07:54:01 -0700 (PDT)
From:   Nicolas Saenz Julienne <nsaenzju@redhat.com>
To:     bristot@kernel.org
Cc:     axboe@kernel.dk, bigeasy@linutronix.de,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        pbonzini@redhat.com, stable@vger.kernel.org, tglx@linutronix.de,
        viro@zeniv.linux.org.uk, zhe.he@windriver.com,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>
Subject: Re: [PATCH] eventfd: protect eventfd_wake_count with a local_lock
Date:   Fri, 23 Jul 2021 16:53:04 +0200
Message-Id: <20210723145303.272822-1-nsaenzju@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <523c91c4a30f21295508004c81cd2e46ccc37dc2.1626680553.git.bristot@kernel.org>
References: <523c91c4a30f21295508004c81cd2e46ccc37dc2.1626680553.git.bristot@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Jul 2021 09:54:52 +0200, Daniel Bristot de Oliveira wrote:
> eventfd_signal assumes that spin_lock_irqsave/spin_unlock_irqrestore is
> non-preemptable and therefore increments and decrements the percpu
> variable inside the critical section.
> 
> This obviously does not fly with PREEMPT_RT. If eventfd_signal is
> preempted and an unrelated thread calls eventfd_signal, the result is
> a spurious WARN. To avoid this, protect the percpu variable with a
> local_lock.
> 
> Reported-by: Daniel Bristot de Oliveira <bristot@kernel.org>
> Fixes: b5e683d5cab8 ("eventfd: track eventfd_signal() recursion depth")
> Cc: He Zhe <zhe.he@windriver.com>
> Cc: Jens Axboe <axboe@kernel.dk>
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Cc: stable@vger.kernel.org
> Cc: linux-fsdevel@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Co-developed-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
> ---

Tested-by: Nicolas Saenz Julienne <nsaenzju@redhat.com>

Thanks!

--
Nicolás Sáenz

