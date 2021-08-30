Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0649C3FB381
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 12:00:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235604AbhH3KAw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 06:00:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbhH3KAv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 06:00:51 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 864E6C061575
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 02:59:58 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id f22so14916476qkm.5
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 02:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mJdwvRMdkrpxEfeQAg6MAeFgakBlC1tISJ8H7onnuLM=;
        b=ISu+0Ybd+wbw3eW5LgQYHi72bEiVI6B4w36e0SjAnuoqFNSAo0c4NhIMS9HrVzX9RP
         lHauOs6mR76mUbBOOidKk4MvBB905v0vNPdJJbIYDfRhpZGd7UYCWlSOBROUGIfc59kO
         GWCroOmImTW1l3JQgrU0pI6sX1FfahEaEuOLuGAiEi8odi5i//ZjgKnSz8IRTpzoYyj5
         A3is99vwxyS+BU1IQ/Ks0GuKgUQ8SM27gPVjmrR7IS4+XJJw9BXCqYw78T0SJLu+OFHS
         VQ3PcnZFABH4qZszhbPKHupTgPcLK5leXcFYjtUi+ourV6QVZu6Zgk99jBWZ7QZx91Ue
         b1qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mJdwvRMdkrpxEfeQAg6MAeFgakBlC1tISJ8H7onnuLM=;
        b=WFtOTTVTaeN2lRgKpI4A6iiv0k/sQe+hjGgxZf7k6Eqlhy/mEOX1GuWdqcPt/geCj6
         eOJ3DTQvZokbPFSOmhjg3mymVNrwVRPQ6VDwa5PJv4+A1SInIe3GAl8SUV6pxR6SR1x8
         ZZGngGNevQKr5+1r4gB54yuBmmm6fXrnMk3pgA2lXFMRKlqZE2KjfhrgM/ni0HEGSmmc
         Hu27NNrE45VPn3C4/8jwprM5jgEnYuv1j/gNptjyUYGhtoIKZKm6d7aBTDi1GVi3ACc2
         d9i29zce87NtxQs045h93i1VIdy6Vk4+W0l9qHAaL6JNTY10PtkNPEr9OyCOag+MOS8H
         Ny5A==
X-Gm-Message-State: AOAM530sUwdO7XQHwYDKdkULYlRP6ex+xsn6+0rzN9GvK/UqA35ZCjVu
        9kIL0vJQACBlibVvFgSXqN0BGjlJ7oE=
X-Google-Smtp-Source: ABdhPJzYM+ujLda+0cyqURBwDvoWd6i6xnN0imxljCn7lZGaok9KdWki/Ymg/zPqrLWIDE+F2ofH8A==
X-Received: by 2002:a37:e20f:: with SMTP id g15mr22059950qki.450.1630317597528;
        Mon, 30 Aug 2021 02:59:57 -0700 (PDT)
Received: from vps.qemfd.net (vps.qemfd.net. [173.230.130.29])
        by smtp.gmail.com with ESMTPSA id g27sm7977036qts.79.2021.08.30.02.59.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 02:59:57 -0700 (PDT)
Received: from schwarzgerat.orthanc (schwarzgerat.danknet [192.168.128.2])
        by vps.qemfd.net (Postfix) with ESMTP id A36F72B478;
        Mon, 30 Aug 2021 05:59:56 -0400 (EDT)
Received: by schwarzgerat.orthanc (Postfix, from userid 1000)
        id 935C56001E5; Mon, 30 Aug 2021 05:59:56 -0400 (EDT)
Date:   Mon, 30 Aug 2021 05:59:56 -0400
From:   nick black <dankamongmen@gmail.com>
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] console: consume APC, DM, DCS
Message-ID: <YSysHCQyN+brJLEj@schwarzgerat.orthanc>
References: <YSydL0q8iaUfkphg@schwarzgerat.orthanc>
 <0f094eb9-11d4-1bd5-0a1b-823317ad4f7d@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0f094eb9-11d4-1bd5-0a1b-823317ad4f7d@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jiri Slaby left as an exercise for the reader:
> So simply:
> return state == ESosc || state == ESapc || state == ESpm || state == ESdcs;

Sure, I can do this. Would you like me to recut the patch?

> I wonder if we can simply hide them all behind single ESignore?

I'd rather not--I have plans beyond this patch which will
require differentiating between them.

-- 
nick black -=- https://www.nick-black.com
to make an apple pie from scratch,
you need first invent a universe.
