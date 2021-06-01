Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D015639765A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 17:16:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234465AbhFAPSR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 11:18:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234142AbhFAPSP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 11:18:15 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CF46C061574
        for <linux-kernel@vger.kernel.org>; Tue,  1 Jun 2021 08:16:32 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id j14so14740582wrq.5
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jun 2021 08:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kOSh/zofq3qeP30f+IEnH+WuvF90oX+I7nGxmbJO9jo=;
        b=CsJpH8PR42ImDn9yEPn60N6ZAwMOToFzz6FwKYiu+Ju/aPA81vQHgXQkqIgMGV1BJH
         BbX1i8+05R5n8Nds0xpg17rIBZdA+dmLngXsxICVCF/MIrTFEt8jZEJvTRkoRz0lS30r
         ljUO/Aah5VRnnjw5rp+q0oIhfVKH8wK1oE0hs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kOSh/zofq3qeP30f+IEnH+WuvF90oX+I7nGxmbJO9jo=;
        b=aR6O48d9bAQvQCzeH/szm9F811tC6T+JRJ4OcGd1we6E42w8ZvnNDMtBCgnKMHPrcr
         lPechIjgaBFCORZ1+iYPURsmWz+ElYU9LpuzaGxOgmXwd50dIR+dC8wHUn441cfumVTT
         JyYKOYT7Y6/ytXoSJaophGm0Qf6CGe4Lvg4FQmp8ZggBkjVRVHoLva/ojh1Y9X2VdF1L
         L7XztHDfZT2kXPWQw8ALDv/Yf9XMxJeBRIsK6ONLTje5jUEFs57X6pvlSiRiETTJSIPI
         Y4lJNZL874Ls+bk+rL+2R76P7RYw9FsDXc0VoJhGG7zZTt0bmLOV+jn5EyHjAEHaTVvL
         2/7Q==
X-Gm-Message-State: AOAM532oMbMuwRLSPpyXaXbJGKZZ269R1YQiPY1EyN0nrUl5Iw5a2Br3
        nsNacsBndhCGUnJhODeLZzgKTw==
X-Google-Smtp-Source: ABdhPJxuO6BNj5E1egfBw8t+Y1iPayYxGyF/DFHunn2+JqTw8tK5GimfFz2XyHuLDPwWTKkSSEimjw==
X-Received: by 2002:adf:f748:: with SMTP id z8mr17307396wrp.115.1622560591070;
        Tue, 01 Jun 2021 08:16:31 -0700 (PDT)
Received: from localhost ([2620:10d:c093:400::5:a819])
        by smtp.gmail.com with ESMTPSA id o22sm2751149wmc.17.2021.06.01.08.16.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 08:16:30 -0700 (PDT)
Date:   Tue, 1 Jun 2021 16:16:30 +0100
From:   Chris Down <chris@chrisdown.name>
To:     Petr Mladek <pmladek@suse.com>
Cc:     John Ogness <john.ogness@linutronix.de>,
        linux-kernel@vger.kernel.org, Jessica Yu <jeyu@kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Kees Cook <keescook@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>, kernel-team@fb.com
Subject: Re: [PATCH v6 2/4] printk: Straighten out log_flags into
 printk_info_flags
Message-ID: <YLZPTmPeNu1H7JI9@chrisdown.name>
References: <cover.1621338324.git.chris@chrisdown.name>
 <0b4f0e60960217ac36462316cf43497a9fad1747.1621338324.git.chris@chrisdown.name>
 <YKzSfQIa99Ld2ZMI@alley>
 <87tumr82ri.fsf@jogness.linutronix.de>
 <YK35OTteXMoET3SZ@alley>
 <87v975c2ix.fsf@jogness.linutronix.de>
 <YK4UIBgdqr02QoHG@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <YK4UIBgdqr02QoHG@alley>
User-Agent: Mutt/2.0.7 (481f3800) (2021-05-04)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Petr Mladek writes:
>Fair enough. Chris, please move enum printk_info_flags declaration
>into kernel/printk/internal.h

Sure thing, will do for v7 once the points in the other patch are agreed on. 
Thanks! :-)
