Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C79C363349
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Apr 2021 05:53:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237165AbhDRDxq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Apr 2021 23:53:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbhDRDxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Apr 2021 23:53:42 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B94B0C06174A
        for <linux-kernel@vger.kernel.org>; Sat, 17 Apr 2021 20:52:27 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id z25so1112341qtn.8
        for <linux-kernel@vger.kernel.org>; Sat, 17 Apr 2021 20:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fnUcXf5ZAUj++fa/tjrDH3s8xVGjfeHzzCb0lbTD9kA=;
        b=IC7ovzKoqs0GmZyy+hRoPrOxIbIdAl+zA9V6KpxK9PMinRVQDYEP3TLFFWfWQiSnEU
         1guXDfoh0OQyXxXZW1znK8O/tpgSoaCI6vK86SW339n4bkKJ+3Quy7dP/Ua7rF9+n7nL
         KHhTyHxa2kQLbhGR7JdxdDBs2hdEV/sqsA6eU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fnUcXf5ZAUj++fa/tjrDH3s8xVGjfeHzzCb0lbTD9kA=;
        b=fPGrnV5eJajT0lpJEKuObenEoNLIlATOFWzquSE/YJxjaCWn+stO76O2dVXo8wwj6c
         Jrb+XlQEy4de+LcPuwsrP8qo1K7/nicTwjRNjvy8sKRbtoRdBzOPecAspishRbzPbFET
         5N7PDAx0O/IhTb8BRISrBwwp5nDxXGMA9HB9faZsvJHzQaiPGfeJREyk+o0SoZOov7uZ
         eX7yx/E3WzEE4h9e8NoECEthhRGAciOPfkMRY6p4pIUsPdKhgBQRYZq+cZ8T0j0TUECa
         0ebqMeJRjpvVMUNU84rD/8F8+jErt2asl3lfxGOToO53QiN9RjO/h6KMsDl+fbBPh8cI
         GNlw==
X-Gm-Message-State: AOAM5336lUkiDpdQ3+wBUvfUalJ2OA3UFnl22IPlI7wBJCACvvX+8H1Z
        RMkbSBdqUq2IxmXTe41puQXY8w==
X-Google-Smtp-Source: ABdhPJz36AV+wb1OsH7HrAhPfxLBxrZ07AikxTGMfbK9A3VZyv8hlmpfMUw9gvUyUQI0uAGnm2SFEw==
X-Received: by 2002:a05:622a:1354:: with SMTP id w20mr3861742qtk.223.1618717946918;
        Sat, 17 Apr 2021 20:52:26 -0700 (PDT)
Received: from localhost ([2620:15c:6:411:5970:b016:6052:152])
        by smtp.gmail.com with ESMTPSA id x4sm7121857qkp.78.2021.04.17.20.52.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Apr 2021 20:52:26 -0700 (PDT)
Date:   Sat, 17 Apr 2021 23:52:25 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     chris.hyser@oracle.com, joshdon@google.com, mingo@kernel.org,
        vincent.guittot@linaro.org, valentin.schneider@arm.com,
        mgorman@suse.de, linux-kernel@vger.kernel.org, tj@kernel.org,
        tglx@linutronix.de
Subject: Re: [PATCH 5/9] sched: prctl() core-scheduling interface
Message-ID: <YHus+cmlfdErEi97@google.com>
References: <20210401131012.395311786@infradead.org>
 <20210401133917.350276562@infradead.org>
 <YG3lMaqnH10s6JfN@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YG3lMaqnH10s6JfN@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 07, 2021 at 07:00:33PM +0200, Peter Zijlstra wrote:
> On Thu, Apr 01, 2021 at 03:10:17PM +0200, Peter Zijlstra wrote:
> 
> > Current hard-coded policies are:
> > 
> >  - a user can clear the cookie of any process they can set a cookie for.
> >    Lack of a cookie *might* be a security issue if cookies are being used
> >    for that.
> 
> ChromeOS people, what are you doing about this? syscall/prctl filtering?

Yes, in ChromeOS, we allow the prctl(2) syscall only before entering the
seccomp sandbox. Once we enter the sandbox, we do not allow the prctl(2).

This has the nice design that the security is enforced on entering the
sandbox, and prior to entering the sandbox, no permissions need be given.

Let me know if that makes sense and if you had any other questions. thanks,

-Joel
