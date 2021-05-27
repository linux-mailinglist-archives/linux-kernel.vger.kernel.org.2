Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC641392579
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 05:31:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234627AbhE0Dch (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 23:32:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233717AbhE0Dce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 23:32:34 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3DEFC061574;
        Wed, 26 May 2021 20:31:00 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id k22so3358900ioa.9;
        Wed, 26 May 2021 20:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=w3LWi3pqlr3B4AlunE4XQO/yKeeRdh+JIp87c9hiyZo=;
        b=ISi8Q4CD6rbdfXzcoV0mi4T5raNiBIUZIsyxFzTMz6b+efBYqUsq59GLd5/jhvGeJY
         u3TJrU0zcb6Y10Y1XLDZjeWTQnUONB1tYT9PJPRSGqN88Jfflqx9XhUeOpz9M052KnVN
         WOWEuqQJH3/OfeSu4o6ENGoQb4rnYN1PGrbtV30P4OqgpAR9PnHvKxllz6CGc/VqdQ0t
         ZsHa/+tvfv4yZ474fYuLGvasWhlaLCo5hOwFIE5FDEEvSlBjIaPRW8hS6yuge8stWqmW
         J0JQp2/bA7Ni73i8ZWqP5KLFQI8Fl19WON2VYEEXaerQYHeWpq6/YXFGKYrgTXA+C2/s
         IVeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=w3LWi3pqlr3B4AlunE4XQO/yKeeRdh+JIp87c9hiyZo=;
        b=qWpK5gFWU5JYXJ3+UT+VQIIVJ26ZRH0oBCKyCS8pvJOSSdtvKGgKPAGI5T3TuQfutL
         Xnc2TwuTIp5fvDNAGtvubkmJidF5G+FkNG+xkLHYDyEGjnD1jfvuoeXoG9t+3uDfqXZc
         FLZyeBcNi91HoUbIITCOSlFm1UbRnj40uwomH5rkGD1bwSGWsQr9dHRqZcQI1S5qejk+
         gVX9DLTR3dFssFwUodPhzt69XquxZTxKHDF8tAJLnytod+R/VTaVRpAAXFcMT7G7vGVl
         Ij2Izw7IFGlcn3yIEhgde1MG1Z9X3IqRA2//mtWcJ4CgPscf0M2jNgxX2PN0pXaWdcep
         fYlw==
X-Gm-Message-State: AOAM531x9tuTST8cmj6Ch/a8egYqSCAyQ1MqOGoYLAln5X72dJIR8MYg
        B2EO+ea4P/sk3pANP4WioVo=
X-Google-Smtp-Source: ABdhPJx2GlTFjea70whpnKFaQxVADVYnUsZSDO1oFK0G4U4Wyj8GSFiitDfYy6Hht0e29l3al8TjMg==
X-Received: by 2002:a05:6602:1212:: with SMTP id y18mr1199110iot.189.1622086260183;
        Wed, 26 May 2021 20:31:00 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id n5sm492754ilq.14.2021.05.26.20.30.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 20:30:59 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailauth.nyi.internal (Postfix) with ESMTP id AA47827C0054;
        Wed, 26 May 2021 23:30:58 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 26 May 2021 23:30:58 -0400
X-ME-Sender: <xms:cRKvYINYvIKw7NmsTCtaxjdO-HwO7M8TEdOm_YD66rlrh-1PmS6GeA>
    <xme:cRKvYO99cVwYAeTPnScnBPQORQQAO3RAXKbXKmTgKuN38tsUmzVM90iQQ2S4gZkf2
    a5mwaIZFiWt285pBw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdekgedgieelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesthdtre
    dttddtvdenucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehg
    mhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpedvleeigedugfegveejhfejveeuve
    eiteejieekvdfgjeefudehfefhgfegvdegjeenucfkphepudefuddruddtjedruddrvdeh
    geenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsoh
    hquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedq
    udejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmh
    gvrdhnrghmvg
X-ME-Proxy: <xmx:cRKvYPSwK6U4zIyOGU3t1n6ZDP_XH9YYpc5DkT1irr9Hkloul_2SQQ>
    <xmx:cRKvYAv8aJL9fDVQO5GG6FIplz_dEInxbO17ec5329LEr6fa2fxXVA>
    <xmx:cRKvYAf3jMmEy9oN9hKWSqfwN7cOBXQD4TLzU9kYuDljpystupulAQ>
    <xmx:chKvYOthgv4CFyyWbCiwFyv0je8jdFJbSQi_lA_byfAGL7h2S2sXvw>
Received: from localhost (unknown [131.107.1.254])
        by mail.messagingengine.com (Postfix) with ESMTPA;
        Wed, 26 May 2021 23:30:57 -0400 (EDT)
Date:   Thu, 27 May 2021 11:30:14 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Xiongwei Song <sxwjean@me.com>
Cc:     peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        longman@redhat.com, corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xiongwei Song <sxwjean@gmail.com>
Subject: Re: [PATCH] docs: lockdep-design: improve readability of the block
 matrix
Message-ID: <YK8SRvhp1+iR2y6G@boqun-archlinux>
References: <1621868745-23311-1-git-send-email-sxwjean@me.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1621868745-23311-1-git-send-email-sxwjean@me.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 24, 2021 at 11:05:45PM +0800, Xiongwei Song wrote:
> From: Xiongwei Song <sxwjean@gmail.com>
> 
> The block condition matrix is using 'E' as the writer notation, however,
> the writer reminder below the matrix is using 'W', to make them consistent
> and make the matrix more readable, we'd better to use 'W' to represent
> writer.
> 
> Suggested-by: Waiman Long <llong@redhat.com>
> Suggested-by: Boqun Feng <boqun.feng@gmail.com>
> Signed-off-by: Xiongwei Song <sxwjean@gmail.com>

Reviewed-by: Boqun Feng <boqun.feng@gmail.com>

Regards,
Boqun

> ---
>  Documentation/locking/lockdep-design.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/locking/lockdep-design.rst b/Documentation/locking/lockdep-design.rst
> index 9f3cfca..82f36ca 100644
> --- a/Documentation/locking/lockdep-design.rst
> +++ b/Documentation/locking/lockdep-design.rst
> @@ -453,9 +453,9 @@ There are simply four block conditions:
>  Block condition matrix, Y means the row blocks the column, and N means otherwise.
>  
>  	+---+---+---+---+
> -	|   | E | r | R |
> +	|   | W | r | R |
>  	+---+---+---+---+
> -	| E | Y | Y | Y |
> +	| W | Y | Y | Y |
>  	+---+---+---+---+
>  	| r | Y | Y | N |
>  	+---+---+---+---+
> -- 
> 2.7.4
> 
