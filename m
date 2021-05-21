Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CBEC38C25C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 10:55:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234160AbhEUI5B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 04:57:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233621AbhEUI47 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 04:56:59 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4464BC0613CE;
        Fri, 21 May 2021 01:55:36 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id eb9so10010121qvb.6;
        Fri, 21 May 2021 01:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Kp/ysYVEmYIMLiNSKzfBzrR9z7OzmQLKQ2Sawak68LY=;
        b=YPBVlWE4l2A4ezAJHFNC+Il1+5+5W12wlemT+PDD4ckOlhVCiC/+9aUy98jCR/BPV/
         0Und1ZHWCRP7Cb3P+Zl7er4AFX0BtB9boljRfeWE6mwkdBV1ufM09WTLjigU3uLuAVur
         Uu38UA4LotXZqXdVdEGUYLugFyufHcWfDwVJ/Q6bHtNO0UurK3fiSh0AhH2zhtLMdppZ
         OjEdVtuVAafnBEwt9rWhYNH3QS6bJIKjYtquGrAaR8aT2lyoXjBsUBxGTD+xArspOX+p
         cgf66olHRhaDmcwB91E5vFdWmXHRJ2BQCC3yA5TgWa4hvba/pPODIi0OyIu5cCGFx1vj
         9nzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Kp/ysYVEmYIMLiNSKzfBzrR9z7OzmQLKQ2Sawak68LY=;
        b=jX+IvVUny6nEatNS6SzKTvhbiE2sPVNHMzNjxC708TQeTwZXa9cgTc+QJMBmgu7d28
         qZALV7H6MLe1cm8ZLjYqWj0+nwPMVI1AzIa/UyOhrJYUw6QRB8XXGlXwZhX0xDQexMKb
         ofdwrzB4SDbiMYwBzry0fZX/nSv4vnh+nVJCV/Vv+CL8ESR/xp3VZmwbOLg0JIYu44FE
         RnyC4iCeEV7DpAtqgzcJTUMK7k8REKg0y2CzXBRYoUOeQjG0sbiNnx95eBlhIbr7kOky
         8hWZsKKmMkjO9F7OReGV6yey/0dUaX67f+PeuAgFGVO5Gubs0cggYbTfrUKN28Rgc07Y
         98vQ==
X-Gm-Message-State: AOAM533IcTJXPt7yKZMeQtSTu7RC9Gl4W5jDGN5Q5UfcI2v1Ywdbgt7r
        QEnbDeGvzCZyvqdpQWiA94M=
X-Google-Smtp-Source: ABdhPJxw7sz5aIuW4iLCr915B8yRlIiLDiAP9oofNv+2RTvcpwKIYwRj+m4cjAgJ02Nrlp/9gllK6g==
X-Received: by 2002:a05:6214:391:: with SMTP id l17mr11269278qvy.22.1621587335199;
        Fri, 21 May 2021 01:55:35 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id w189sm4545620qkb.39.2021.05.21.01.55.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 01:55:34 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id D7F7D27C0054;
        Fri, 21 May 2021 04:55:33 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Fri, 21 May 2021 04:55:33 -0400
X-ME-Sender: <xms:hHWnYAyskXIZunEPr7pbZHwONJPXJFnD8eLq-qJzZprtyNChv1oPqg>
    <xme:hHWnYEQln_O7b0fyjfkbM3AGoa-t676mJjP3L16hAKoFVqjJvnHgSL2o_lRJGS_bH
    6V19LCaN45uCetEIg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdejfedguddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesthdtre
    dttddtvdenucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehg
    mhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpedvleeigedugfegveejhfejveeuve
    eiteejieekvdfgjeefudehfefhgfegvdegjeenucfkphepudefuddruddtjedruddrvdeh
    geenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsoh
    hquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedq
    udejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmh
    gvrdhnrghmvg
X-ME-Proxy: <xmx:hHWnYCVOTgANXFIGudOCzU24BaVzd0oOoyFux7QVb2Te0ND3J3K1Hw>
    <xmx:hHWnYOjvi-ASIsXvBePK82oucn2cjbSD_dHuFg1YG9hMA-dE3bDoYw>
    <xmx:hHWnYCBaQ-twQ9KbfEUewKL3--UZJVkf9ktkj3e5M7duNpAkLdCITw>
    <xmx:hXWnYICI7G6vBX8T_N6Djb9U7Xe6RkDmzIZQl5wEfk65A0nw9FpYsSdlaQw>
Received: from localhost (unknown [131.107.1.254])
        by mail.messagingengine.com (Postfix) with ESMTPA;
        Fri, 21 May 2021 04:55:32 -0400 (EDT)
Date:   Fri, 21 May 2021 16:55:05 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Xiongwei Song <sxwjean@me.com>
Cc:     peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        longman@redhat.com, corbet@lwn.net, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, Xiongwei Song <sxwjean@gmail.com>
Subject: Re: [PATCH] docs: lockdep-design: correct the notation for writer
Message-ID: <YKd1aVkojNsx4wrl@boqun-archlinux>
References: <1621578594-13237-1-git-send-email-sxwjean@me.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1621578594-13237-1-git-send-email-sxwjean@me.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 21, 2021 at 02:29:54PM +0800, Xiongwei Song wrote:
> From: Xiongwei Song <sxwjean@gmail.com>
> 
> The block condition matrix is using 'E' as the writer noation here, so it
> would be better to use 'E' as the reminder rather than 'W'.
> 

Good catch!

> Signed-off-by: Xiongwei Song <sxwjean@gmail.com>

Reviewed-by: Boqun Feng <boqun.feng@gmail.com>

Regards,
Boqun

> ---
>  Documentation/locking/lockdep-design.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/locking/lockdep-design.rst b/Documentation/locking/lockdep-design.rst
> index 9f3cfca..c3b923a 100644
> --- a/Documentation/locking/lockdep-design.rst
> +++ b/Documentation/locking/lockdep-design.rst
> @@ -462,7 +462,7 @@ Block condition matrix, Y means the row blocks the column, and N means otherwise
>  	| R | Y | Y | N |
>  	+---+---+---+---+
>  
> -	(W: writers, r: non-recursive readers, R: recursive readers)
> +	(E: writers, r: non-recursive readers, R: recursive readers)
>  
>  
>  acquired recursively. Unlike non-recursive read locks, recursive read locks
> -- 
> 2.7.4
> 
