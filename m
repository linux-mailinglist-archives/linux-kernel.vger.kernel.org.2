Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF241344D13
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 18:17:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231899AbhCVRQ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 13:16:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231634AbhCVRQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 13:16:39 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38638C061756
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 10:16:39 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id j7so12903824qtx.5
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 10:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=AOzWwNh9Z9Q2fPxgCHDYPxpc0oqGNwrpuGjPzRTDOYM=;
        b=SUPXIeJkm8BeqFPeZOhFyudDzS8X+Q3bXG7r/aza6Z9TpqZXVn/JWTdHwTjt7pO1Di
         2mdLRNSeZt0mL+p9bkjlJ12mu38eSVhX/qcLwxXOaJ3V4NU/7rpg65aRD1C7wHvTWmHk
         jT/MgB55wcXIxwl63yMiCJDwSsui3U08+dwDI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=AOzWwNh9Z9Q2fPxgCHDYPxpc0oqGNwrpuGjPzRTDOYM=;
        b=HDqzq6W3or7RwSssMHS0gNKtTrNROrcWqZ6ZRLWQQZUr8chBNsuIjnMIEa8DdzltUp
         r4VoVHQIo15E3Vr7i8OwZpibhxgTx31CPfcyC1EGWQ+u2mKwoEn//RoV5yz0Y0Gbeok0
         tB3THBqxrMKYBik2mI4dqDRrFrJL0srY96tV/mjv24799CgYFbk0sfYxnMpzzfBSiVPT
         ljr8pgpkqYiEZ4ncu8wDmNvMhpDx9NQx0ZggTVRmFhYbIKOwTj8N4evdDA+lQFkyexo0
         JOtb0aoeN4NQHOGgHlue3EoaE1zZ9bxpmE16eyMDObFgBvQbgPIDOiKJPB6qE3/3RJSX
         dtLA==
X-Gm-Message-State: AOAM531cJfcOG8R6x7hslx2nn5LYPVUxhUN4SEl4GzdWuzut0w9LDN4/
        eb/pvPflHE46HzWgDuxlArfCog==
X-Google-Smtp-Source: ABdhPJy/CiFfBssEItdA5oVBV2QXfAv2XhDWbXT90l7G5Lo5Ba8ddKwgyAendg7ze94cnMR379PEvA==
X-Received: by 2002:ac8:4a19:: with SMTP id x25mr850552qtq.271.1616433398205;
        Mon, 22 Mar 2021 10:16:38 -0700 (PDT)
Received: from chatter.i7.local ([89.36.78.230])
        by smtp.gmail.com with ESMTPSA id o197sm11087024qka.26.2021.03.22.10.16.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 10:16:37 -0700 (PDT)
Date:   Mon, 22 Mar 2021 13:16:36 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Thorsten Leemhuis <linux@leemhuis.info>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        ksummit-discuss@lists.linuxfoundation.org,
        workflows@vger.kernel.org
Subject: Re: RFC: create mailing list "linux-issues" focussed on issues/bugs
 and regressions
Message-ID: <20210322171636.fkep2lby6gnve4su@chatter.i7.local>
Mail-Followup-To: Thorsten Leemhuis <linux@leemhuis.info>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
        ksummit-discuss@lists.linuxfoundation.org,
        workflows@vger.kernel.org
References: <613fe50d-fc9c-6282-f1f3-34653acb2ee9@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <613fe50d-fc9c-6282-f1f3-34653acb2ee9@leemhuis.info>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 22, 2021 at 04:18:14PM +0100, Thorsten Leemhuis wrote:
> Note, there is a second reason why ksummit-discuss is CCed: another
> reason why I want to create this new list is making it easier to find
> and track regressions reported to our various mailing lists (often
> without LKML in CC, as for some subsystems it's seems to be custom to
> not CC it). 

FYI, there will soon be a unified "search all of lore.kernel.org regardless of
the list/feed source" capability that may make it unnecessary to create a
separate list for this purpose. There's active ongoing work in the
public-inbox project to provide parallel ways to follow aggregate topics,
including query-based subscriptions (i.e. "put a thread into my inbox whenever
someone mentions my favourite file/function/device name"). This work is not
complete yet, but I have great hopes that it will become available in the next
little while.

Once we have this ability, we should be able to plug in multiple sources
beyond just mailing lists, including a feed of all bugzilla.kernel.org
changes. This should allow someone an easy way to query specific bugs and may
not require the creation of a separate list.

I'm not opposed to the creation of a new list, of course -- just want to make
sure it's aligned with the improvements we are working to make available.

-K
