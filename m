Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47FD242A9A8
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 18:37:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231659AbhJLQjj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 12:39:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbhJLQjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 12:39:35 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FA71C061570
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 09:37:33 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id a73so14427415pge.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 09:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iukDYlKpdVnpmIGbLuJTC0MlapAj9Nd9mr0vNrg5C4k=;
        b=bZSINsLTZv0sqNMbIdtRFSEc8C+iiuq9xwnl+Y3pkNkhXbvjcYHs/GqSYFJX5yDLnh
         Bfm9vcs143y6w0yLCf0lmavKEGmDIyCmTmRfyNoqhjEdVmwlOt1Ss3r+QWplBdOWKNDH
         DoqQdn+u+7XhTaGUjt2X1hxH17v6CwwPPajjdg8TfaU8aEJtjSCA6TSV5e5XGcdHOg+h
         PU0SwYdHN8Yfg43hJ7/ZMZ/efDhiph5Cqfn+0V4gIK+7xdlfhGw7rvZ40AqoNzVlBmEb
         wOJIysxafPxoNVUYVeFWzf45JipgeLqXQgksDuatvTx8V447TJv4QaqdrGwCoe7E8Mwm
         GDPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iukDYlKpdVnpmIGbLuJTC0MlapAj9Nd9mr0vNrg5C4k=;
        b=GXpaTgXC4KJGbUPHxPMT7HSfgye+e63IpNblggHsDyao6HvLcQMFP5/S8y4nNwVffB
         ejNZMR02GQl6vZYLmhR0kmpRZ8EeP7m7HZoiXfOgZ0bqovzRsnr3FjaMrypQMYFzPxY5
         vVszcjb/YkpMvU8dzfRjs0UFm0O571lAs3/xjkfVnZGVxr9QWPG8xevChTjLr8w0RCUZ
         B/K9cyCrWMD8t+Q0fRK92MbVfiaJCrWXhECHC+yAfgVf2KGf6/n2QbzQK3AqckcDLBcn
         hLFJAmQhSDrW53LH9Q5SRMXUFjSZuANYGIVA6jjHWgfcFNYIJxXUXzZX8WYiIpiCGp4I
         TRiA==
X-Gm-Message-State: AOAM533RkW0pf6zpI/j5RT8YREgNysMKXG7DRjnaHmRAUAmbjGMyQb8P
        LgINIk3uoBgZdGtYwrDnL9jhTw==
X-Google-Smtp-Source: ABdhPJzGtUHMC0TMXqGbLht/ed5VA30A7QH9pStPrOBeLBoX1mZYdXlF5iV7FKQ8oikd9exBMlmthQ==
X-Received: by 2002:a63:204a:: with SMTP id r10mr23710980pgm.365.1634056652813;
        Tue, 12 Oct 2021 09:37:32 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id d67sm11428041pfd.151.2021.10.12.09.37.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 09:37:32 -0700 (PDT)
Date:   Tue, 12 Oct 2021 16:37:28 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Reiji Watanabe <reijiw@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org,
        syzbot <syzbot+9fc046ab2b0cf295a063@syzkaller.appspotmail.com>
Subject: Re: [syzbot] WARNING in static_key_slow_try_dec (2)
Message-ID: <YWW5yN5OCSjRXptm@google.com>
References: <00000000000029c95905c9742a31@google.com>
 <611efcc8-76f7-34fc-306d-412957f81093@I-love.SAKURA.ne.jp>
 <YWWqG3xF6KAHBU2O@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YWWqG3xF6KAHBU2O@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 12, 2021, Sean Christopherson wrote:
> On Sun, Oct 10, 2021, Tetsuo Handa wrote:
> > Hello.
> > 
> > Commit 4547700a4d190ac4 ("KVM: x86: Consolidate APIC base RESET initialization code")
> 
> That's definitely where the error was made visible,

I take that back, the bug was likely visible even before the redundant vendor code
was dropped.  Doesn't change the fix in any way though.

> but commit 421221234ada ("KVM: x86: Open code necessary bits of
> kvm_lapic_set_base() at vCPU RESET") is the real culprit.  I'll send a patch
> later today.  I'm leaning toward a partial revert with some extra comments.
> 
> Thanks for the debug!  I was having trouble reproducing the syzbot report.
