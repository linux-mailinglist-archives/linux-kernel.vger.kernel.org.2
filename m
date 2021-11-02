Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 943004439FF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 00:47:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbhKBXuT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 19:50:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbhKBXuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 19:50:17 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43A55C061714
        for <linux-kernel@vger.kernel.org>; Tue,  2 Nov 2021 16:47:41 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id m14so516635pfc.9
        for <linux-kernel@vger.kernel.org>; Tue, 02 Nov 2021 16:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zEhg8OnWypfDOYGe7dzdLgVngqsN+xKmbv8NAsTcI/w=;
        b=XV9odVC9izg3debwVzox7ia6Uc2w7r79lyJ4M+oTGICimADA5mhCylgU03t/sY5ah+
         TVCgDHW66T1E6UxnFFNhEeAhoDGKHb1N/7lw5D10aebQcnrnCrxkaHTVjSO+QeIaeaq6
         phuyB5K1Q9S6jn3JKLtMK76xF54Q+JUyt2i9cIZ9kbZBUr9jgvoOi8tIRwJeyon80CuB
         d1zhP06fG21X1r/8dJlPgYMLy1jzL5mg1SO9sH3/cCn5vsD6EJTYTZhcONKSyizfE9i3
         63CbUdu4TIpCFSb8JoKISH+n0ixE7LNLmHhWIAfbti2Jef9L6ql162xCxUnNKvNCEDrS
         W9XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zEhg8OnWypfDOYGe7dzdLgVngqsN+xKmbv8NAsTcI/w=;
        b=aEYreOx1h5amPS0C5ziOSSgY1VVBOh8mJ0gYJ1m2RdKFlrRfn/eB4P2RjJ0W7kUEmb
         6iMpZjBKxhpRViWO0URlacmcujJkuS+kIaEyQ92C6quSIPJVNgonvb8AypgTdG0cA3hp
         LGAdqhbnUMjM1iTE5M7mOnAQlyW7AXJhPOthkbPjpVci9QRIzy9Fhxglneex2sK9iFxZ
         fplJpfiZNDw2EFGg2tD15Q9TZrIKYouKSowfGHwr6CzMe+EpuwryrvMwA2WHll0wzur0
         dIwcNEwvROkolgsncj5028/4y0KB8YQhYyid7JMPWWiM/BzQeI/5IBBzMHzObNriIxSc
         Djeg==
X-Gm-Message-State: AOAM5311TAkIP3J6PTzjMyyt6IzbwFwkMNfoeT9nL2jAOxxeXhV+tl7L
        k9LlhNIfLVI7RIS7ClGdlt3LyfVmDic=
X-Google-Smtp-Source: ABdhPJzijxl86+9ex/TILecK4UwKdLH5UF2V7bX5svJLKURANFNrxbzEQi/YUg3T85XE+Zuc2fy9Hg==
X-Received: by 2002:a63:d00c:: with SMTP id z12mr29189578pgf.334.1635896860565;
        Tue, 02 Nov 2021 16:47:40 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:9ff4:d422:7d09:b7e7])
        by smtp.gmail.com with ESMTPSA id x13sm160183pgt.80.2021.11.02.16.47.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Nov 2021 16:47:39 -0700 (PDT)
Date:   Tue, 2 Nov 2021 16:47:37 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/9] Input: remove unused header
 <linux/input/cy8ctmg110_pdata.h>
Message-ID: <YYHOGdQlsDh3+i8i@google.com>
References: <20211102220203.940290-1-corbet@lwn.net>
 <20211102220203.940290-6-corbet@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211102220203.940290-6-corbet@lwn.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 02, 2021 at 04:01:59PM -0600, Jonathan Corbet wrote:
> Commit 83b41248ed04 ("Input: cy8ctmg110_ts - switch to using gpiod API")
> remove the last use of <linux/input/cy8ctmg110_pdata.h> but left the header
> file behind.  Nothing uses it now, delete it.
> 
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Signed-off-by: Jonathan Corbet <corbet@lwn.net>

Applied, thank you.

-- 
Dmitry
