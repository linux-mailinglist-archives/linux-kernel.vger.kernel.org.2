Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDBB837ED3D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 00:39:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383652AbhELUP6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 16:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378203AbhELTKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 15:10:50 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49ED6C061574
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 12:09:40 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id j26so24691811edf.9
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 12:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=apG1X3HrVuRv/i/BvJgwnrGIjCE1leMjMNDGvCM9iD4=;
        b=dE9R4i57fBYrZfLm4Sv2D2SQVZG+iZswX1Qm5jh63U13htwYgUMeUfxoQIYe3iT/78
         m6f4JE24TdhLocRKmin11kv1wENOLqSHHoFhi3ey9Q86MCS8tc6J1ZOmRSgT8UzwfO4z
         H8Stbv5gjKPbAmxjNIVpohDuEhLqkoXEZUCTmuUQL4pdZKlBHYl72dozG3A5xqBJEN70
         mmLaQ9gvF2B1nlpEmwlrbGz/OaOJw2SxaLRCsGcZdU16LX9x2vHGUs4usCFVqaurvGJZ
         h9u2VtLNdytoCgz0BTB712h/QWZi91UJF1cU7F9AUXp4oMTRtjY86B7PYbtxdcRy1Inh
         Z/cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=apG1X3HrVuRv/i/BvJgwnrGIjCE1leMjMNDGvCM9iD4=;
        b=jzyJTQ66fVUaNMqYn+g+GIUeNXB22T138UtqxGKB+Gi7+EvnWdGz4+cyTowZjsqtGd
         kDF6wfX1aZT2OKQ8+NTdrO8W5FkdI6Zwca56SS1HGjbMaSyeI3mdwGIpTObRLfceqn4P
         P6D1bWKZHWpE3ru8wU2F3k496n9KbKSLo0ChxgsxrRnnewF+GNEvx+mjj7I3hGpR+0to
         ys2u7j3Sdz+Fs6fG1xmaEdkV5z5bVrJoo0J2gaNhE+y/Qc0d9VnFebyX9UcsO6vGqE0b
         09f7gGvZyGjwiXUFqDJPFcmks4hEhG+fxPCgDBJVnIg/Z0YoNxV7uw2baqQrC18f/Qdx
         TmnQ==
X-Gm-Message-State: AOAM531cUy+0HY0U6kD6BlTGraQADuMG0tE3pvj90Br8z8bkwp2S0LPn
        zVgKejUfXkfBxkVaeSqtF0lPzwF6H7c=
X-Google-Smtp-Source: ABdhPJzDZ4zaWHx45p5OLVBZ82uHiyv5hDMxzXu2INe1CKI54xuHCFG4uY1ZIdgdJsBuNq+/XAKd1w==
X-Received: by 2002:a05:6402:35c4:: with SMTP id z4mr44519810edc.362.1620846578993;
        Wed, 12 May 2021 12:09:38 -0700 (PDT)
Received: from gmail.com (0526E777.dsl.pool.telekom.hu. [5.38.231.119])
        by smtp.gmail.com with ESMTPSA id z11sm376077ejc.122.2021.05.12.12.09.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 12:09:36 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Wed, 12 May 2021 21:09:34 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] kernel/locking: make __down_common use flags previously
 saved
Message-ID: <YJwn7qb3/ekFBWDF@gmail.com>
References: <20210424142823.3896-1-42.hyeyoo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210424142823.3896-1-42.hyeyoo@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Hyeonggon Yoo <42.hyeyoo@gmail.com> wrote:

> down, down_interruptible, down_killable, and down_timeout
> call raw_spin_lock_irqsave that saves current status to flags.
> 
> but in __down_common, that is called by functions above, calls
> raw_spin_lock_irq and raw_spin_unlock_irq regardless of flags previously saved.

Yes, this is intentional, because if we get into __down_common() we have to 
schedule, so we have to enable interrupts.

> this mismatch can potentially cause problem.

What problems?

Thanks,

	Ingo
