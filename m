Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3864F30BBC2
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 11:08:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbhBBKHI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 05:07:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbhBBKF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 05:05:28 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFB48C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 02:04:44 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id j2so12918689pgl.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 02:04:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=V7cOc/ZvsWoACo8U/ft21hSHRmHjqN4AW7Dj7jN/hzI=;
        b=CdNjlNEgTD8V2bja0Be1gCk1PUqsuht8aAJT62j0qFALlAIRQTfZz5nZEbS8jv4Tol
         t08i8UV1JEZ5yLsKv5/Fp6y4r2dArx36/ezEK7ndDrZaZkJmVSD9EyBbEaZWjrlR2Akw
         tZRWDVK8UqVQwqdawyhVbrOPY+KAA7aa+bRTmAAiEnWYyWD+1XCZmk62jHe8E1E/H6qJ
         Eawf6WqrzE2sn4WbreKlHPgKUTrIFXEUaDFHpcyKzJvHNxSt0te+Dbyb+aYAazIQfL2h
         RkTz+4PUCxUoIfF7r0tREf5FtRCxhqkG1/MAnMhUs6o3TNtz60UJIP/AwWCpjUCZ8hr+
         AfKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=V7cOc/ZvsWoACo8U/ft21hSHRmHjqN4AW7Dj7jN/hzI=;
        b=l7S/iPSUnxuHx8GypWhRlrRMeyFrE9VWrWhBqJ865Wp7O6qjvVtqJojfVX1fwKzWlG
         quNr7mDjvKOFfvRbMC0M4MLFYtxBryRcbqrVzGHDFJw+WVnNrpqPy6zOEZVm1uQ2vfzs
         rXSGt8yXL2XPU6KhXdB5/3LxCqPDpAC1iS6TVIN8E4jZcaqafG4CigWAL1ZWnr0z4s40
         MgFEpdjHCZEpMhEBBIQYdH4d0OVDnw9sZ/Aq33ubpHcp+rIfmHni8nq27QL+q+v5T7Nb
         4J0lL8L9A/BEv1kKvzgoFgIpGXSRzylhIRiWR/SsMjfuqDV1Zty3z/ITluslqQnkemMZ
         qh2A==
X-Gm-Message-State: AOAM530fBzFrrCV2q0aVXtCuxCkGzXFI9UuFTRHdb4Fv9NciRnq/hoSo
        zwGt4HB3XOvvT9349Baoh4M=
X-Google-Smtp-Source: ABdhPJwXohYSBrMvKOq8d7zRuYtA5//mHYyaidnUp4Xqfi2qTXGH8UK/I6L6lkEvvUAcF6jORUEpWw==
X-Received: by 2002:a63:2745:: with SMTP id n66mr20983884pgn.310.1612260284084;
        Tue, 02 Feb 2021 02:04:44 -0800 (PST)
Received: from localhost ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id br21sm2362924pjb.9.2021.02.02.02.04.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 02:04:43 -0800 (PST)
Date:   Tue, 2 Feb 2021 19:04:40 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 3/3] printk: move CONSOLE_EXT_LOG_MAX to
 kernel/printk/printk.c
Message-ID: <YBkjuDw/zmnl0VH0@jagdpanzerIV.localdomain>
References: <20210202070218.856847-1-masahiroy@kernel.org>
 <20210202070218.856847-3-masahiroy@kernel.org>
 <87bld22709.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87bld22709.fsf@jogness.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (21/02/02 09:50), John Ogness wrote:
> 
> The only consequences could be out-of-tree modules breaking,
> but do we care about that?

Yeah, I don't think anyone does. So we are fine here.

	-ss
