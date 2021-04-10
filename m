Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB87435ADB8
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 15:37:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234729AbhDJNhe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Apr 2021 09:37:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234377AbhDJNhc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Apr 2021 09:37:32 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E310CC061762
        for <linux-kernel@vger.kernel.org>; Sat, 10 Apr 2021 06:37:17 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id l76so5906911pga.6
        for <linux-kernel@vger.kernel.org>; Sat, 10 Apr 2021 06:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QVzrjlrbODT5X6pYvA9IbhF9UE3pTeVxu5GHqVg8Uu8=;
        b=rKtFuIbE2Ox+dAQesBBbA5eLo9GXphDrdon3mFjAiHgmTrBr5MO5lxVM2f2kihlLYW
         pck5pPuT1a4EfEOihCTvGz9p2RnlE8+pTm7GOICIH4PpqapSSdFOtSn4ymn5ujVCAwKo
         kNYGJ4xTqAC40CchG2Iu1X7YcsD5x/B2mVGPQ3CTK15BHNS/Gb63F1sH26sLSIiDXywv
         aHW4wor2koQV+oyYTUQqaXAGLLU6gl1uErjbmyv55jlFsuTbrVTYAipWqwVmCFz6+JgV
         DmUuoS/LlC+FUmPnh8FUSddgKoxWHaiYae5LIxhDDqs6sIAeQ2235qFCG2fr64k65lUs
         QWGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QVzrjlrbODT5X6pYvA9IbhF9UE3pTeVxu5GHqVg8Uu8=;
        b=d+/koxOc2bZC4J3k0CtI/eZuZ/iQnkXNiFzsTbmauITwrkz0Kv44FK4eSXDooehMgS
         YlF5Xrgzv3JNSbw5dmpFAlnJ/JOCqm4v/Mc40tQclSXupBbTvjkCypNM5ZB+dDmk8Jer
         TEe7KL7sZ2AyV8yBgDG2e7nhEVcQH8S0yaYKJJxBFGDN09hfqAUQtb2gf+sYP72cQcQn
         JKy5zm4T9KicWt3zvVkqnseKJHkP1YNGD4L9mbicOagLmE/EqYAIpchQRvdqxkqaKtCq
         HqkvVh7nRZIfggfOvTpM3W5sDbNOoNH80/sudeZLRAijzQUiQ0grbDLoi+fswH6uxwp+
         Ni7w==
X-Gm-Message-State: AOAM531CWypPI+poCQmX/uaixQUa/u8z7S6BeqhzYhNCGTnhribSo89a
        gW1G/68VLPNzozEZ7cKIAEbkeEBZJ8u9mA==
X-Google-Smtp-Source: ABdhPJyQQj0wIIEkQVhlqcjEVTN8U33Wck6nBo0R7nSYLbvUrDaRVn7aBtUQ4Fw8yMvWuI139nmd2A==
X-Received: by 2002:aa7:8dd2:0:b029:247:c334:5e6f with SMTP id j18-20020aa78dd20000b0290247c3345e6fmr5776730pfr.57.1618061837387;
        Sat, 10 Apr 2021 06:37:17 -0700 (PDT)
Received: from kali ([106.195.15.71])
        by smtp.gmail.com with ESMTPSA id q1sm5379475pgf.20.2021.04.10.06.37.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Apr 2021 06:37:17 -0700 (PDT)
Date:   Sat, 10 Apr 2021 19:07:08 +0530
From:   Mitali Borkar <mitaliborkar810@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com, mitali_s@me.iitr.ac.in
Subject: Re: [PATCH v2] staging: rtl8192e: fixed pointer error by adding '*'
Message-ID: <YHGqBLS+IcHdkI6r@kali>
References: <YHGhdtldqAlRsPHT@kali>
 <YHGksKltkkmaUeAk@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YHGksKltkkmaUeAk@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 10, 2021 at 03:14:24PM +0200, Greg KH wrote:
> On Sat, Apr 10, 2021 at 06:30:38PM +0530, Mitali Borkar wrote:
> > Fixed Comparison to NULL can be written as '!...' by replacing it with
> > simpler form i.e. boolean expression. This makes code more readable
> > alternative.
> > Reported by checkpatch.
> 
> Checkpatch did not report this specific problem, Julia did :)
> 
> And this changelog text does not reflect the commit you made here.
> 
Making the changes now.

> > 
> > Signed-off-by: Mitali Borkar <mitaliborkar810@gmail.com>
> 
> We need a "Reported-by:" line here to reflect that someone reported the
> problem as well.
>
I am resending this as patch v3. I have to add reprted by Julia, right?

> Ideally it will have a "Fixes:" tag also, but I can add that if you
> don't know how to do that just yet.
> 
> thanks,
> 
> greg k-h
