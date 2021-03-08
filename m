Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55203331AF5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 00:30:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230457AbhCHX3h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 18:29:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbhCHX3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 18:29:20 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51280C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  8 Mar 2021 15:29:20 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id y13so4765757pfr.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Mar 2021 15:29:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CmfxbJbsR32j2stPZTCAVs668uTJmv8SU8V0tORla8k=;
        b=loMSgpyCPFx0qqhEygDCduyPFZcBermyVhL9olczMSLnaHjD/dewtfsl3m0CMLrPKW
         HXffVL050IlTqPDH4XUokC47IidmWHhOUHXb7DL2WP7BTYVoXWLpJlrhtF5DTg83tahq
         Z++bWV0GgCBfSIqO1csGQ3rGm1M8ID4CYAaO4VzebEqfnBSL2hsEuqZ7ekbj5Cb5FCKA
         mKM0S4UCyPIWPUNlTPZrj3//ayV+tgpuO3/LxPKjm9ImwrhQUZfa6gfUgwVwDjzlGhDd
         nucwhzOM8f2Dr8woxq8Awiml9V8mwXXMyVWntouwPKeia7Fu7QnUaYe/4BrxpjLWsu9T
         XKxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CmfxbJbsR32j2stPZTCAVs668uTJmv8SU8V0tORla8k=;
        b=WY9kOLg6i+CHBetjeegQoxmNdUZkt3u2Eyv57jOn4nKsG/czSvqzsMZCuGjTWMZ9t9
         M41s80h6ol17Y5fl0/2THqFeiHpD1qPggwz9IALxu4LQPq0TqhLcug2sHv9gTeKYD0kq
         JPDochxi4wTG418Zo1X+bjeCoD6YfB2EB12iwM5i9XhYvSBm02R2bgsqUuJ80Wo1qu51
         9ILZej2adyV/0PnX2ZczE0JxQmXimdHRKRjxbc1q8F2bWnZdDz0Qs5roWMCQUg0NFKwl
         iCp2q5jsOOrgA1F5Sm88FUkpzER4vSIsJI2XpX1jU93ukc9IqrAHxCulfuMvlTioYAi3
         hgdw==
X-Gm-Message-State: AOAM530Y9Uha458ZWwU1luhYrJWpUEbv31SKMaM3e+K8Nwc5wTfIWK2T
        oamXqlj5ecTr7IQjDF+NrJR7bg==
X-Google-Smtp-Source: ABdhPJxpn6GHNZAPqETOhgrPoqObmFdwbzRNeB6gxDD3X7bTKOUHCY3nYHX3mMJ+o0dP5thKkYD4ew==
X-Received: by 2002:a63:e22:: with SMTP id d34mr22551523pgl.264.1615246159344;
        Mon, 08 Mar 2021 15:29:19 -0800 (PST)
Received: from google.com ([2620:15c:f:10:8:847a:d8b5:e2cc])
        by smtp.gmail.com with ESMTPSA id y6sm11950866pfm.99.2021.03.08.15.29.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 15:29:18 -0800 (PST)
Date:   Mon, 8 Mar 2021 15:29:12 -0800
From:   Sean Christopherson <seanjc@google.com>
To:     syzbot <syzbot+3c2bc6358072ede0f11b@syzkaller.appspotmail.com>
Cc:     bp@alien8.de, hpa@zytor.com, jmattson@google.com, joro@8bytes.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, pbonzini@redhat.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        vkuznets@redhat.com, wanpengli@tencent.com, x86@kernel.org
Subject: Re: [syzbot] WARNING in kvm_wait
Message-ID: <YEazSAsa2l6KQZwL@google.com>
References: <0000000000003912cf05bd0cdd75@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000003912cf05bd0cdd75@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 08, 2021, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    a38fd874 Linux 5.12-rc2
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=14158fdad00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=db9c6adb4986f2f2
> dashboard link: https://syzkaller.appspot.com/bug?extid=3c2bc6358072ede0f11b
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1096d35cd00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16bf1e52d00000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+3c2bc6358072ede0f11b@syzkaller.appspotmail.com

Wanpeng has a patch posted to fix this[*], is there a way to retroactively point
syzbot at that fix?

[*] https://lkml.kernel.org/r/1614057902-23774-1-git-send-email-wanpengli@tencent.com
