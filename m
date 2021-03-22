Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A988344FCB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 20:21:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231991AbhCVTU3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 15:20:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231307AbhCVTUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 15:20:05 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74933C061756
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 12:20:05 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id 7so11791983qka.7
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 12:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=8Q7RRvuVNavl/gwkoCMwZmRYpQT/3oqqA/DKA2GV8Lw=;
        b=bTRCp0Fu5tnZf7WgMih1mKBhgJgdd4RgZj/Nl+Pxf7YIflOd9ERjLcGWkpn99ggt8B
         loClDoBJn0+GNwZXWsLu7rWDks9FZaW856qyk+2YJBHYweTgZRFizRhhuvcvOlZweEbP
         V5lo753rKrmksaAOHvwXvO+14lJT7nA/EgDao=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=8Q7RRvuVNavl/gwkoCMwZmRYpQT/3oqqA/DKA2GV8Lw=;
        b=svG1DCme4XLAMYiMGLYHrXwBEAIXKIk1lO6oOvfmXP1wKAbsBaQplmxEoe3EZOoW6c
         lE4w9B7QWvBviMXJWgfQayhjVFgDLacONjG7WHlo/XsBX+MMG/ZzqeoYQC+XQt06WJQV
         w6YXU+YkEeALeBLyQ57mDB8FTW+tu3YNafJJg2WxOPNmZ2uoEMrJ5zhNhwtUjgV65C9x
         Kdgx2MCe20/12sn7jNHi7Yhggit2COf+C2yM5+K+ZGdUL1Ex0IfDRq8IxZy7qoDDqVBl
         0xsF7785s1trLBXNEMjMbVi+j37sBx9HU8WhjADY1ME8b7GGb8TQw1oCNEpl/YNrNGRx
         fY3g==
X-Gm-Message-State: AOAM53223ZaTEb3Z3aUlcnsy8DInf1Lws2GeNoIDgtgpQbuSoDfH3a4F
        zJCloXDn0Ql6rf8CWro1lmyt8A==
X-Google-Smtp-Source: ABdhPJwj9SrTtbeqsFzhsM9BN2vyOE0oiCFqLRGfTVoVe/f+PdSx7Aw2LHjTovOR1jv3SmTYcm9WfA==
X-Received: by 2002:a37:9d57:: with SMTP id g84mr1540801qke.71.1616440804306;
        Mon, 22 Mar 2021 12:20:04 -0700 (PDT)
Received: from chatter.i7.local ([89.36.78.230])
        by smtp.gmail.com with ESMTPSA id h16sm9632950qto.45.2021.03.22.12.20.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 12:20:02 -0700 (PDT)
Date:   Mon, 22 Mar 2021 15:20:00 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Thorsten Leemhuis <linux@leemhuis.info>
Cc:     Eric Wong <e@80x24.org>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        ksummit-discuss@lists.linuxfoundation.org,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, workflows@vger.kernel.org
Subject: Re: RFC: create mailing list "linux-issues" focussed on issues/bugs
 and regressions
Message-ID: <20210322192000.7ea4dfslebcfok4l@chatter.i7.local>
Mail-Followup-To: Thorsten Leemhuis <linux@leemhuis.info>,
        Eric Wong <e@80x24.org>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        ksummit-discuss@lists.linuxfoundation.org,
        Greg KH <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
        workflows@vger.kernel.org
References: <613fe50d-fc9c-6282-f1f3-34653acb2ee9@leemhuis.info>
 <20210322171636.fkep2lby6gnve4su@chatter.i7.local>
 <e93ad98a34828a4140fa59c1fb5b01f03c6f4245.camel@HansenPartnership.com>
 <20210322183427.GA1195@dcvr>
 <09a6256e-0015-d360-9347-f025a7d5adfd@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <09a6256e-0015-d360-9347-f025a7d5adfd@leemhuis.info>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 22, 2021 at 07:55:29PM +0100, Thorsten Leemhuis wrote:
> Out of curiosity: will that work for other bug trackers as well? Like
> the gitlab instance used by the drm developers? It's not really
> important and I guess the answer will be "no", but the question came up
> while at it...

If there's an API to poll changes, then it can be easily turned into a
public-inbox "feed" -- same as I intend to do for bugzilla. Each entry simply
gets converted into an RFC2822 message and stored in the repository that can
be indexed and queried by public-inbox alongside any other source.

-K
