Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E59A310F6E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 19:05:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233569AbhBEQVb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 11:21:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233554AbhBEQTH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 11:19:07 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76E8BC061756
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 10:00:49 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id f63so4808416pfa.13
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 10:00:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8qb1CyCQjn/N+1y/YOs2JFjHcLhMQN11acgAoLNGKiQ=;
        b=VVHaLfLKNyYdA5QhCxSkdfo9vcIXZlgeeExzIcDLdit6Cwz79JwZjnR9mN4wSkzjz4
         dy0HpQQhUTiQOJD/dH0xmL+h/d6U3IA6hcdJWGCn0DnqZPInxzfyK5Mfoj+7UpAskeHv
         gJlKMk0UN67uJOO3S6q01Lspk2sEmmBXz0CZ4N3g7jcm7pFR/TugKpafwtQAEdfDhgih
         kljOAquYcTx+TMj3xOAFzy5MChDZ/zV8uGnHEYxJkbnzpPkkJIwf5EIjFgUFXzxF39rK
         wajcA0PgmVfz8+eOdZHu/ooY6KtCYHjOQhZxn8CcYmlked0L6nzMXYZ32LBnnrluYOs9
         Cwqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8qb1CyCQjn/N+1y/YOs2JFjHcLhMQN11acgAoLNGKiQ=;
        b=Y3Gchq6p+I4rc6UV3SLEiRPBqm+tHbcVUgcinXs9SZJGmc4CiaPn3C+ltVoAuX77Vp
         vcadFQkXCINqPQw1isjtl7DhqoJpgvVD3WkPOSUi7J32MhHcBLeJ0F3JBrR7KFWCSMXH
         6RqHft4Ga0LZqovm/tyKJvId+45vOEB9wLwpCNWGQwDnxzdAnlrMgEQ8MF4tEz4tHVQ+
         cksl6cDu0/TrudesnW0BkTYgUSQcm5PIZcXjIcSs/7AOmoxRC8nELg2MbLTXGY9JtW8o
         M7DZ34rEFJfo4NttbEKchOvYrB9+G25C1gaRBsgCZWXlqAG12JN5sz+Bwd88wPNwtqK4
         PXdw==
X-Gm-Message-State: AOAM532fpIkzsg5VWTG4GXs/qG6tN1lhncxVBaIntEtfcpnX6REJ/HgJ
        IGwA22cA5nQvkR2g8JsoKd1AmEV88km9UQ==
X-Google-Smtp-Source: ABdhPJyqrLSbGinpw8kAw9OAisrZH9ZMhkWsRghDbIat1Imo0jHkgsZrHsOrwJ9ds6qdleA9MfPldQ==
X-Received: by 2002:a63:2f86:: with SMTP id v128mr5345741pgv.241.1612548048759;
        Fri, 05 Feb 2021 10:00:48 -0800 (PST)
Received: from google.com ([2620:15c:f:10:d169:a9f7:513:e5])
        by smtp.gmail.com with ESMTPSA id w12sm8852108pjq.26.2021.02.05.10.00.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 10:00:48 -0800 (PST)
Date:   Fri, 5 Feb 2021 10:00:42 -0800
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, Jonny Barker <jonny@jonnybarker.com>
Subject: Re: [GIT PULL] KVM fixes for 5.11-rc7
Message-ID: <YB2HykY8laADI+Qm@google.com>
References: <20210205080456.30446-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210205080456.30446-1-pbonzini@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 05, 2021, Paolo Bonzini wrote:
> Sean Christopherson (3):
>       KVM: x86: Update emulator context mode if SYSENTER xfers to 64-bit mode

Ah, shoot.  Too late now, but this should have been attributed to Jonny, I was
just shepherding the official patch along and forgot to make Jonny the author.

Sorry Jonny :-/
