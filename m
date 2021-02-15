Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D4BE31C043
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 18:16:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231599AbhBORPL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 12:15:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232625AbhBOQKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 11:10:47 -0500
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB451C061574
        for <linux-kernel@vger.kernel.org>; Mon, 15 Feb 2021 08:10:06 -0800 (PST)
Received: by mail-oi1-x22f.google.com with SMTP id v193so8221272oie.8
        for <linux-kernel@vger.kernel.org>; Mon, 15 Feb 2021 08:10:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tK6WvVsZdmcR/71vc9kTYyb9NnNF+oCdWaBRmeINUI8=;
        b=nm4U0mvxZRXRSFLW/2hAAYMV/UOHgEYA9lvlh1iTB2WmSOFjL/VR8KvaNskuBGfDR3
         0WeIdKeJzbENFJA2wC5HmTNBr324GOhiUGXg5JzxJ+59e+AvoufWNQaA1zhxnmLqtePh
         ibuShRRPK+TWac10tslLoPLdjtawsFzZ5/XOewe827h9gCtnQcQkP9lf6dR1hxgR6JiA
         flsKbKmg1GygkDpy1gCx4idKGhF0iPboWfKD/Y98YrAUougPx3QD3uQ0/TzwiTACeCG5
         L5QL6bYFMrfKIHUe0EGZMXE0VtxBSWyeDeqggycTTWh5BVs4B1Dyko1tbLAYIu5d2TA3
         BusQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=tK6WvVsZdmcR/71vc9kTYyb9NnNF+oCdWaBRmeINUI8=;
        b=VKAg9LjQIMijK7EO5l7XsB3gydYRzOaYCw+c8dwc9TV1jWDj3Vth9L0avEo9uZQEbs
         ZrVwZ59IvG10bLlI1uiiK6bs7rNSr3rAmfrd5LMS5tIOpOde9Nr2KhOtovw66Bb+2uto
         cCtuxsodXQOlOB7CM5rMcgonJVCuVLN/TBQZNQlrl3wePkv7Eg99FWg50MRAl6pnSMtj
         td62J5jPYFfO7v22nmAJkKif22+99SZSn864P1mu6L3wfgHuc2x7dTlMl3GzS/6yUoYB
         IupKmi8QA+BD0Qm9rzz0iJ3dtfOtU90JopfAN4ja0koNMR/pSuERMmHcbu8pqqku/OZb
         HwLg==
X-Gm-Message-State: AOAM531Pa31jcgImSmL3AB5kU/pLFWqTedmRthpbKjrbsLAYxWmrH+uk
        OSeNzhJGolL1n1REki+7Kxr/W49U4+I=
X-Google-Smtp-Source: ABdhPJzzDSxop9RgNbkQ/b2CuMpPH4EI3FBcLRSWeIC/uAB55JvrSk4OQftinjgj1JOSX4SRVCMLFQ==
X-Received: by 2002:aca:bd8a:: with SMTP id n132mr9174135oif.18.1613405406240;
        Mon, 15 Feb 2021 08:10:06 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b4sm1832411oop.27.2021.02.15.08.10.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Feb 2021 08:10:05 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 15 Feb 2021 08:10:03 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 5.11
Message-ID: <20210215161003.GA46229@roeck-us.net>
References: <CAHk-=wg8LpRi9+P2_V+ehJ2_EoJifNh2QmVf47aLXfkCd-1UAQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wg8LpRi9+P2_V+ehJ2_EoJifNh2QmVf47aLXfkCd-1UAQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 14, 2021 at 02:45:13PM -0800, Linus Torvalds wrote:
> Nothing unexpected or particularly scary happened this week, so here
> we are - with 5.11 tagged and pushed out.
> 
> In fact, it's a smaller-than-average set of commits from rc7 to final,
> which makes me happy. And I already have several pull requests lined
> up for tomorrow, so we're all set for the merge window to start.
> 
> But in the meantime - and yes, I know it's Valentine's Day here in the
> US - maybe give this release a good testing before you go back and
> play with development kernels. All right? Because I'm sure your SO
> will understand.
> 

Build results:
	total: 153 pass: 153 fail: 0
Qemu test results:
	total: 432 pass: 432 fail: 0

Guenter
