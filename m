Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AEEA381106
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 21:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232256AbhENTl3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 15:41:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbhENTlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 15:41:24 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 838F4C061574
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 12:40:12 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id c13so478729pfv.4
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 12:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VfLCGaOV2wAJvv6o64cTzjS19Z38bR4c8NNaoufspPA=;
        b=E/h6rdIsTCLVfZtWslWRMtGS6ovDjPY3DC/jf4LLhXi/JTNHx5WeLdEA1PyaRI7bmU
         MsUu0zRgyNDO6mfFTTS66Q4PuMMN1gajuPfi/V+83U13ZUMMQzMseGbYKEnM+BReZZZb
         4CRe92LAjV5QJ+6KwOBfLLdKRGP8rVMjdyxJyYWSfQ3mfjqliHAWthCqwyAU9tC9NV05
         2tOCIpSRvdO/WJcpKFSduBXji+NVb4f8w+7EYY0zHcpMULBj7ACPb/mwaDHQkO0tmBxS
         JWX/EWca6IHbH6rHkiM0W+gjwHASomDd8MtuzRlsSgTP1BM50tmWUOsJaMTgzYg55Lr+
         ckIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VfLCGaOV2wAJvv6o64cTzjS19Z38bR4c8NNaoufspPA=;
        b=AMWNv8A8enTFCrZYhZMhce9HBuXy+855vsd77+36wSqyL//n+l7hXtgQ5SZA/+PhQC
         /IFS0CggdvlL+iszcifbCz0dbP9sa8EdSqV5LoMgcdcYRe0+7l/dZMUwbrHrBCIFlVWy
         e50+y2rGgTBxykhpp9SWc0cWsT50iny/LtAp2QBudxzUOpC4BEEMug9OYdl9tuae1cg2
         /LRNSswHbHTzwtT4PYklLBn1RMbDdIkngOpM4xI1xZ+LsX2Nm8vipEmIzd3y9XRsOLvT
         pqmTPRNdPSE1DnOv9YhGsgiLhJtGRtseeeFVXIBGvRuS/KVaPmTuhHXbCOjz935AQp4t
         qAZw==
X-Gm-Message-State: AOAM530rSoo/1AgLzJ9W21HxXwhWRb7JzuJoRcnrHo0Tdmnl/YP8Ej2m
        /kdegGwNpnJCVbzNKJ0nzcU=
X-Google-Smtp-Source: ABdhPJx3mWS6Cw2Wndc9jYPUSJj4ufeF4GrrLNChiOeOgxouJt7uqleK+xoiH/ZjFOxIVYcSDxvJyw==
X-Received: by 2002:a63:4422:: with SMTP id r34mr18228607pga.275.1621021211978;
        Fri, 14 May 2021 12:40:11 -0700 (PDT)
Received: from fedora ([2405:201:6008:61b4:4e16:5348:d963:c66d])
        by smtp.gmail.com with ESMTPSA id h22sm4649955pfn.55.2021.05.14.12.40.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 May 2021 12:40:11 -0700 (PDT)
Date:   Sat, 15 May 2021 01:10:05 +0530
From:   Shreyansh Chouhan <chouhan.shreyansh630@gmail.com>
To:     Alex Elder <elder@ieee.org>
Cc:     Joe Perches <joe@perches.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        pure.logic@nexus-software.ie, johan@kernel.org, elder@kernel.org,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: greybus: fix gb_loopback_stats_attrs definition
Message-ID: <YJ7SFVInaYgJLywS@fedora>
References: <20210514133039.304760-1-chouhan.shreyansh630@gmail.com>
 <YJ582f3O9K9YD3QA@kroah.com>
 <YJ5/tqFfcjxOLsF0@fedora>
 <YJ6DrLiMsdkG5loA@kroah.com>
 <YJ6H/WsojYcN/bLO@fedora>
 <YJ6Jf+Z1ReVgDt64@kroah.com>
 <YJ6TUAowTI75h/sl@fedora>
 <YJ6XpUMliWQOS8MB@kroah.com>
 <bccbec1a0ffbf6c31b5e6a78cedd78cd64f2b8fe.camel@perches.com>
 <88d7da63-d03c-7fa3-a881-aff8e7b4a618@ieee.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88d7da63-d03c-7fa3-a881-aff8e7b4a618@ieee.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PS: Thought I should clarify why I think it might help. The macro
definition for gb_loopback_attr, calls other macros, but since these
macros are not in all caps, (I apologise if they follow some other macro
convention that I am not aware about,) it makes them look like function
calls. And I know it were lazy of me to not look at the individual macros
themselves, I think it would be a lot clearer if there was a way of knowing
that these calls are infact to other macros and not functions.

Adding declare_ as a prefix to all of them certainly helps, if only a
little, in that regards. Functions are not used for declaring things,
and since the gb_loopback_attr macro itself would have declare_
prepended to it, it would certainly give a hint to the fact that the
calls used in the definition might similarly be macros.

Once again, I do accept it was my fault that I sent the patch without
looking at those definitions more closely, and not considering that the
developer who wrote it must have had a reason for doing so. I just
wanted to clarify that renaming them might actually help.

Regards,
Shreyansh Chouhan
