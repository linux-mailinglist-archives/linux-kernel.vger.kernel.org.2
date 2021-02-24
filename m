Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 055BB32464C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 23:20:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234633AbhBXWTu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 17:19:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233615AbhBXWTq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 17:19:46 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36DBBC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 14:19:06 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id d8so5587606ejc.4
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 14:19:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=esgHPFAXtJraAFZeVMnbgtLoIpVTIBSPXC2kaE9EIyo=;
        b=Bk62oPLB6TXDuzwnMS2NVq6cZU2EJ+AgM1xn5jV+9BsuyYK0qKJTJ/1QjllD0IpCIx
         C0+vR8F8imu7znz7XfUVRtxSj6vyCbzzt8h7YyWqTTT8M88zCKOKkfMeCKTG8Pdj5Ljw
         2AgNFO6k0WOlAPxrmeYAKCUVW2ktlwKBGt5JE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=esgHPFAXtJraAFZeVMnbgtLoIpVTIBSPXC2kaE9EIyo=;
        b=uFPkcVI1zglEvbCalvbM/IR+qqybk6lmDWYOLjLARE8gI/CK47QO3BbT7Z0SahcC/w
         4cexjzo+FAVLDkim4NNA3sTNHejOVCqwiAAp5U0IV5Kra+EbCXfidXPxNPoyJxhUuwvh
         PggKWpEN9XIuiFhqzh676nJ/kx19sgC9V8FYD71iduLnDysN6McBRf/3hWrsA6a5G4JO
         tDrMeHGnq5FZsp3n8a9KquDk6mwkcF3MsLQTLU7oy5H5mqo8vjK4F+4PvUnHaHkq22mq
         vW6IQZpjvcJ8STz9Uye3ET/jQNwM2jn+g3IysX+5btBzVH3KS62ZlLfMhRJ/WLip2jPh
         nv4Q==
X-Gm-Message-State: AOAM5329sKli3Sx9ZjlehLUW8wraVfVYvujlFX/daSx89Wa6xf7cgUTl
        gQ5rSanv+YaYAHuguaZq4MuF4o6JJxaWtQ==
X-Google-Smtp-Source: ABdhPJxjiD5KAeODBCv+FcuEH0jO8vVbYzDx7TZOo87cBVxKIdxa0Yg5W3ud56iHmkQMwwQ8RBhiPQ==
X-Received: by 2002:a17:906:32d1:: with SMTP id k17mr33393373ejk.141.1614205144864;
        Wed, 24 Feb 2021 14:19:04 -0800 (PST)
Received: from [192.168.1.149] ([80.208.71.141])
        by smtp.gmail.com with ESMTPSA id t19sm1987576ejs.122.2021.02.24.14.19.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Feb 2021 14:19:04 -0800 (PST)
Subject: Re: [PATCH/RFC 0/2] background initramfs unpacking, and
 CONFIG_MODPROBE_PATH
To:     linux-kernel@vger.kernel.org
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>
References: <20210224142909.2092914-1-linux@rasmusvillemoes.dk>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <e240d10c-2c81-d3f2-9973-5527297db8de@rasmusvillemoes.dk>
Date:   Wed, 24 Feb 2021 23:19:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210224142909.2092914-1-linux@rasmusvillemoes.dk>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/02/2021 15.29, Rasmus Villemoes wrote:
> These two patches are independent, but better-together.

kernel test robot says I'll have to add a 0/2 patch:

linux/initrd.h: grow an include guard

[because defining a macro a second time with the same contents is ok, so
is doing another extern declaration, but a trivial static inline
definition can't be repeated sigh]
