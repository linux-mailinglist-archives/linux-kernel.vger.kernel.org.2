Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADD753D7A16
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 17:46:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236978AbhG0PqS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 11:46:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:38437 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229537AbhG0PqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 11:46:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627400776;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qyu2Y2TRrxflVv9Re1ddIxikd/FHNJ3gk/I5zZBEQ38=;
        b=I+HLilGqJ0edziQMxkDK0r7+lFWLygv/kgqIq5UhNf2HLo6bvTJu9EbUuzFKxD9PTCo8WK
        LKuFpwPxzHrFbhKCxZuH/nKj3Bs+L8sfX6N4tdbFt6IwtMJK1bVCEmuzsh2BH3PDphwYy4
        THozO+iCk6y/Ywi7uOr5QBrWKQ1yFyg=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-374-fEjydgYrPe2GwoTPPkXxqQ-1; Tue, 27 Jul 2021 11:46:15 -0400
X-MC-Unique: fEjydgYrPe2GwoTPPkXxqQ-1
Received: by mail-qk1-f198.google.com with SMTP id u22-20020ae9c0160000b02903b488f9d348so11845128qkk.20
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 08:46:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qyu2Y2TRrxflVv9Re1ddIxikd/FHNJ3gk/I5zZBEQ38=;
        b=HJI2xY2a+cuMiUt5GcixsKUVAwxek9LjAFG1OGcnRyD/39WDqDkX40XjIJSmhQ5eCS
         8DoRyihCv9Q5PA8BIwvP6ZRUzYez7t1GY3Q6WYLnRDBJUiUBJWPtRK5L+ejlbWA3QMDG
         BKpifo4Y9nhjW9ulBjSE3IzEiUBNoF4My3aHEuT+8UWNaBU2zj5P9NhnH90S6UMVz53a
         +gIF1fcdYnXRpJeO5ABq7etNVuyerwDxFg5iq4ywrTVlvvVJP1yVS4mvKL8z7Y1N64yK
         q5ecP2t1lk4/KBF0TX9Ts/3id6s0tfNtM32mfYlCjcRO/3txrSvzW4CIhRdoymcgFSyP
         4Szw==
X-Gm-Message-State: AOAM5331n4pizu05fzP27PDD2PY0s3ZD34WvtW0AXEbSip1tUsgc+Fm6
        i5HYBJp+5bR4Mb1S6E2NXYuTediCrI+wn3piWkZCo/QkVC8SpZK5h9b9/cVD+qqH/JgQRVKic+r
        4vOWMFp9XPc4Z65uzXiGFzlUn
X-Received: by 2002:a05:620a:1137:: with SMTP id p23mr23880574qkk.490.1627400775129;
        Tue, 27 Jul 2021 08:46:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzhTawW9W+VTgqHYhIOqH2k2b/KQYhF35BYDKPB7IDZDwwML1ltc1GzD2gc42Ak+yJCkznYwA==
X-Received: by 2002:a05:620a:1137:: with SMTP id p23mr23880554qkk.490.1627400774782;
        Tue, 27 Jul 2021 08:46:14 -0700 (PDT)
Received: from t490s (bras-base-toroon474qw-grc-65-184-144-111-238.dsl.bell.ca. [184.144.111.238])
        by smtp.gmail.com with ESMTPSA id f3sm1570573qti.65.2021.07.27.08.46.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 08:46:13 -0700 (PDT)
Date:   Tue, 27 Jul 2021 11:46:12 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] KVM: add missing compat KVM_CLEAR_DIRTY_LOG
Message-ID: <YQAqRB7OPHHQNdJ+@t490s>
References: <20210727124901.1466039-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210727124901.1466039-1-pbonzini@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 27, 2021 at 08:49:01AM -0400, Paolo Bonzini wrote:
> The arguments to the KVM_CLEAR_DIRTY_LOG ioctl include a pointer,
> therefore it needs a compat ioctl implementation.  Otherwise,
> 32-bit userspace fails to invoke it on 64-bit kernels; for x86
> it might work fine by chance if the padding is zero, but not
> on big-endian architectures.
> 
> Reported-by: Thomas Sattler
> Cc: stable@vger.kernel.org
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu

