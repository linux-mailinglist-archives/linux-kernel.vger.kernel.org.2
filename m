Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C1F7326692
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 18:56:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230324AbhBZRzj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 12:55:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230321AbhBZRy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 12:54:58 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D26CC061574
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 09:54:18 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id t5so7036916pjd.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 09:54:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=i3EwEh8FhuYAascbOooKgoVMHRk9QB/LWCkxzrXyOuE=;
        b=Qprfjm1YEE+PFFVbwrNn400st58ADNuESMCLAeaNl8w9B1XzCHcxE/fdCKYPaU0VC7
         QVRqKNiv4S8n6f8Sn3DOsuvCkYfb7cBkxaa0D95Qjqd2rO7AMSh4NtSspb7zby+xL8Rf
         +icEpU1rMlRQLq7KweEEFdkeXu1A97ghnNysBY3J90O1SyzYI8o5xnoUGMI7Xozi3MNw
         /C8Rx3NFch+cKSkG2+IoevJ7K5QfUY4DRSmoxs411ZZKUZLTu9U36zXLbv+o7burPATv
         0tw01qzZrYFXBXFZmWRNlYF7OAXk+DJ393OSdU+FoY4xG92sGcDsFPSdwSwKeym4eyd1
         TCGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=i3EwEh8FhuYAascbOooKgoVMHRk9QB/LWCkxzrXyOuE=;
        b=Cc/+PkXqDxqsjaZTo95n438+miKyJ3aeZaJ13rKhmaf8J3SbQ2aBSVNcwdL6ib5dpy
         i4tqQ1EmB71GnXltvpHrXKp2BovX7y+rrsBJSw9KrnpXfGJset43tiZi+1le2LO7q0a4
         u6a7yE/GRPzqc+QjmO5jlp+H99GxeuKwNa5ug0g6Mx2tQ5aRV1rpsULkxmfxp1WdsA9P
         HLqAxa8Lvum8U3IbCYJ/pqsoXaMvIfJaTM71tHzfVt764F9hEinmwSrFKCbTeaHoOca8
         2wdGdJnFJ8AUsZ1BBES7GM/i+higR//7jGE3dULfuDWZThSLYnWJ7TwMMPylbgGk08sd
         qPow==
X-Gm-Message-State: AOAM532N+wizQ3JNknwX85pHis77VWPnrieyz555JirNrQ0aTFjJ7LNW
        e/20TDBAraEgqaa2E2Mrfb8WCg==
X-Google-Smtp-Source: ABdhPJwX1Wqi+aRoJxLbEzGE0WOVi7yQ5FqRGlZ43yICaUKtQc02FXHuf/1k3A6Gq3pF2XS9gd5VsQ==
X-Received: by 2002:a17:90b:2389:: with SMTP id mr9mr4659770pjb.141.1614362057584;
        Fri, 26 Feb 2021 09:54:17 -0800 (PST)
Received: from google.com ([2620:15c:f:10:e190:bf4c:e355:6c55])
        by smtp.gmail.com with ESMTPSA id v15sm9440977pgl.44.2021.02.26.09.54.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Feb 2021 09:54:17 -0800 (PST)
Date:   Fri, 26 Feb 2021 09:54:10 -0800
From:   Sean Christopherson <seanjc@google.com>
To:     syzbot <syzbot+0182764296ab74754c77@syzkaller.appspotmail.com>
Cc:     bp@alien8.de, hpa@zytor.com, jmattson@google.com, joro@8bytes.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, pbonzini@redhat.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        vkuznets@redhat.com, wanpengli@tencent.com, x86@kernel.org
Subject: Re: general protection fault in synic_get
Message-ID: <YDk1woB8GeqX5JHf@google.com>
References: <00000000000001316d05bc3a2bea@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000001316d05bc3a2bea@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 26, 2021, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    a99163e9 Merge tag 'devicetree-for-5.12' of git://git.kern..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=11564f12d00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=49116074dd53b631
> dashboard link: https://syzkaller.appspot.com/bug?extid=0182764296ab74754c77
> compiler:       Debian clang version 11.0.1-2
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+0182764296ab74754c77@syzkaller.appspotmail.com

#syz dup: general protection fault in kvm_hv_irq_routing_update
