Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D9534336B8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 15:13:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235793AbhJSNPN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 09:15:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbhJSNPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 09:15:11 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EE71C06161C
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 06:12:58 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id i20so12630201edj.10
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 06:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C51Lh41WoBpmX5ebPui+TVxwhH8ZqyDbgZK9znUvKYU=;
        b=iJ2VeR0tYteIn3RLl/KzJUoYJI5TVGEyyJN0AdZFGDFPieNfAkC+3VzS+gc0J8An35
         ikAy8SFTrevYcV9NPLhr0qe4lio7Q+PxJlPjbliVJ/ZX0B5NL4RQc1djqNlfwkr/Q/Ba
         NgkiQA0dakNdVNuQsxvbjFOPppXtWTkoVVX4wn6ZL0UTHvmWkUQ6/gBlPk6ngTyw9LSs
         ocnaKxjN5J27MBGKRbHHGEVDfqrWP5e2UorJkJ55xx0JAaB0cOY3R3hI/ehsgBk/5EGp
         M8NXl5TxMESLLVJik9t+7nzd4lFT1vLZI2Cno3fx7IIRXuv1bWC1RnnrD+CK7hQUH9IA
         /vLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C51Lh41WoBpmX5ebPui+TVxwhH8ZqyDbgZK9znUvKYU=;
        b=aSLZOiaSjZ2RlVD3QVaZndciQfvrJBqHOA0N40PcitzDw89vRbPd+oLwkRwuHGEnx0
         IgSGtuqwqlpQR5mlvIOp7YCZpOqNWLTkNYZZ8eWfSQ56PbaiI3ipbJJaCl8E51kZR2jV
         f1Czog2f82aD4ByvH0QBSJ3sROcwZqwsQ/cTgLPLMtHMpVNfzqp6fl8TAqa39Pz7m7vp
         1NcBIziZvpMxVRQ3CCcxLn57tbuCJj8G5doEHxHdqQtV+p/NbDh0NzEvHpIZbn5NzsIK
         u42aktHf0tKW3ue2LRvhvtZJbX726P6Xv0/1NTgUBIKe8NUTq+GB/ZEyT9k9M3ONF0ei
         eOSQ==
X-Gm-Message-State: AOAM533wMbIXuEKlJgcPgF2S/EuFn7FO4eQ52a1s9I7Hlaik2MxwBAOE
        mLUQCFlqg+aj+bQJOnd+Owo=
X-Google-Smtp-Source: ABdhPJxsINe2KSf73o5DhZVu5wrNvDYPYK8vz1rURG2vB/nBNJa/zJ0wq6njRkrRDOUssLSxpFMwGg==
X-Received: by 2002:a17:907:2d12:: with SMTP id gs18mr33605414ejc.353.1634649169144;
        Tue, 19 Oct 2021 06:12:49 -0700 (PDT)
Received: from localhost.localdomain (host-79-47-104-180.retail.telecomitalia.it. [79.47.104.180])
        by smtp.gmail.com with ESMTPSA id h11sm10131010eji.96.2021.10.19.06.12.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 06:12:48 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Karolina Drobnik <karolinadrobnik@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        outreachy-kernel@googlegroups.com
Cc:     outreachy-kernel@googlegroups.com, forest@alittletooquiet.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Joe Perches <joe@perches.com>
Subject: Re: [Outreachy kernel] Re: [PATCH] staging: vt6655: Fix line wrapping in rf.c file
Date:   Tue, 19 Oct 2021 15:12:47 +0200
Message-ID: <2001042.7W5oOxFLzk@localhost.localdomain>
In-Reply-To: <4c6a85a4934ef977eee07fb7e38b07b8061bfce4.camel@perches.com>
References: <20211018150526.9718-1-karolinadrobnik@gmail.com> <810a4e29b0c54520a30cae4d37fde0a59ea3d83b.camel@gmail.com> <4c6a85a4934ef977eee07fb7e38b07b8061bfce4.camel@perches.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, October 19, 2021 2:26:05 PM CEST Joe Perches wrote:
> On Tue, 2021-10-19 at 11:59 +0100, Karolina Drobnik wrote:
> > Hi,
> > 
> > Thank you very much for your comments.
> > 
> > On Mon, 2021-10-18 at 17:12 +0200, Greg KH wrote:
> > > Also, these are all just fine as-is for now.  A better way to make
> > > these lines smaller is to use better variable and function names 
> > > that are shorter and make sense :)
> > 
> > I have v2 ready but I'm not sure, given the Joe's patch, if my solution
> > is a satisfactory one. I didn't jump on such refactoring as I'm still
> > learning about the codebase/process and didn't want to muddle the
> > waters (...more than I do already).
> > 
> > Greg, what would you prefer? Should I back up with my patch, pick
> > something else and let Joe's patch be merged?
> 
> What I suggested is not a patch it's just an example.

Sorry, Joe. I sent a message trying to explain what you were showing to 
Karolina with your previous email. Soon after sending my reply, I noticed 
that you had already elaborated a bit more.

I hope that you don't mind. If I wrote something that contradicts your 
thoughts and intentions please accept my apologies.

Regards,

Fabio



