Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36207405F1B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 23:54:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234070AbhIIVzI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 17:55:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbhIIVzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 17:55:07 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC37FC061574
        for <linux-kernel@vger.kernel.org>; Thu,  9 Sep 2021 14:53:57 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0e4500e54deaa4563ec494.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:4500:e54d:eaa4:563e:c494])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D04B31EC0277;
        Thu,  9 Sep 2021 23:53:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1631224430;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=NUEsI+swjqPe/UooycIhKWMyQ3NgAhXifc0qEEodAfM=;
        b=Xz90GA79ggcI+KwjmKi7IMUeynYCgpSjMTK0tqofagZPMZ7vItUDL0X1sAppG6/m+3WY9P
        ZsMC2cg7LGUZO08NUG5yfLXNhXm+nWIzlHbWa3XQatxKkoKxrylUVfgR/QZZakNkVHk42N
        Etqk6Vz4HwnnrqZcXvWzlj4nb21AbhY=
Date:   Thu, 9 Sep 2021 23:53:43 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "H. Peter Anvin" <hpa@zytor.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/asm: pessimize the pre-initialization case in
 static_cpu_has()
Message-ID: <YTqCZ2DM4SAJvO6p@zn.tnic>
References: <20210908171716.3340120-1-hpa@zytor.com>
 <YTo92+0ruBlkcaDf@zn.tnic>
 <1a73e0c2-8efe-fee9-5141-f7e9a95c748d@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1a73e0c2-8efe-fee9-5141-f7e9a95c748d@zytor.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 09, 2021 at 02:28:42PM -0700, H. Peter Anvin wrote:
> Because it is shorter and thus can fit more contents

                Pessimize the pre-initialization case

vs

Do not waste registers in the pre-initialization case

I'll take 16 chars longer but a lot more understandable any day of the
week.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
