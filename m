Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEA7C36DF38
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 20:52:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243884AbhD1Swq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 14:52:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229474AbhD1Swk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 14:52:40 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9605C061573
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 11:51:55 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id b15so110108pfl.4
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 11:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=JjPNWYzivZEdcpCuRxsrwPTWbqsXO0/4Y3Uy/HOSZA8=;
        b=VlbQeOnA7KvNe1GIX8LdGu7C8BEa9V0CjxS6/AzASbPFtT6MdB3mLvqt/6I1llO4H4
         gsH5N0byaURsPF5BpXEKub7VqZLkoRuywMCx67wk3wisBJHxW/Lu9pXD4ra1zHuVErwo
         s0eMjHL76cOhel8ZjDRK9bmEtXm+huL09Hej8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=JjPNWYzivZEdcpCuRxsrwPTWbqsXO0/4Y3Uy/HOSZA8=;
        b=UGD9pAx9ufdIBZl575SgCKvYnRoWvmVhmYFSX0getkw+DH6OKUMGMlIh1XDmxu5MMa
         qCsrQj4GlEQybToG7U6YQe5PohaXUJ2nZPi3V/yggy5OdsfIUIrXvDx0M06xmXmgyhBb
         xaoMp+5yjHp71Sd5Jaf3D+ofogy8sst31JYMOqTMuVThQNs3uyEkoW5Yoj+iWSs22gVP
         ijfg+isdyyiZ0zuUMI/lHIDY+uFZbAe1xJ7/9D1hoNx8kJqNFLEohtBwEoBPSzK16QlD
         n2nwPiLiPZmilOO2D2VprhVbDAAATepQTNPXhGF517CKNbowNeTAHT94XDU6FaOUwhrD
         u7dg==
X-Gm-Message-State: AOAM533oiGflHW//wPe2ZIaJC0X1pOnwiLT0LKwc4DVO4s2Wb2G4a6i6
        mpR07qzIKG7kn2s7RPtgcLqZqg==
X-Google-Smtp-Source: ABdhPJxlUuUzc7n2D1/2uiJUpQLNQRkJr4hgfh/ju22CU3JhIFY+rGC/ZlI/lD6UkPiMm3vp53HC9w==
X-Received: by 2002:aa7:83d8:0:b029:249:79c9:fd49 with SMTP id j24-20020aa783d80000b029024979c9fd49mr29725617pfn.72.1619635915237;
        Wed, 28 Apr 2021 11:51:55 -0700 (PDT)
Received: from cork (c-73-93-175-39.hsd1.ca.comcast.net. [73.93.175.39])
        by smtp.gmail.com with ESMTPSA id r14sm5540915pjz.43.2021.04.28.11.51.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Apr 2021 11:51:54 -0700 (PDT)
Date:   Wed, 28 Apr 2021 11:51:24 -0700
From:   =?iso-8859-1?Q?J=F6rn?= Engel <joern@purestorage.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>
Subject: Re: sched: wakeup setting TIF_NEED_RESCHED too frequently
Message-ID: <YImurOENWBEg8UP+@cork>
References: <YIh/QubidJcE5IIv@cork>
 <YIkdDeb9c+XmDRvM@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YIkdDeb9c+XmDRvM@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 28, 2021 at 10:30:05AM +0200, Peter Zijlstra wrote:
> 
> set_nr_if_polling() only sets TIF_NEED_RESCHED IFF TIF_POLLING_NRFLAG is
> set. TIF_POLLING_NRFLAG is only set when idle and is then sufficient to
> wake that cpu and reschedule.
> 
> If not TIF_POLLING_NRFLAG, then we send an IPI to deal with the
> non-empty wake_list.

Yeah, saw that myself.  My explanation of the behaviour is wrong.  The
observed behaviour remains, though.

Guess I have to add more instrumentation if I cannot find the cause by
reading the code.

Thank you!

Jörn

--
Optimizations always bust things, because all optimizations are, in
the long haul, a form of cheating, and cheaters eventually get caught.
-- Larry Wall
