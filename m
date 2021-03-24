Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEDB934791C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 13:57:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235220AbhCXM5D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 08:57:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234741AbhCXM4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 08:56:35 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4786C061763
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 05:56:34 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id v186so14566819pgv.7
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 05:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BRsabgXq1j/oZODFUT1sBBvOqEOBW7MpFRgZymkaaUA=;
        b=A99XLQZDgZ/5k/F3KdS2TsU8Q4orPYziYZf2YsYkzLzMn1xb9ZEnAQkE3CSnhoR4Vg
         N/tFuW4/K9C4XwdQb2BVjcywh7QQNtf63Kw/lqkcv4bEzdO/qL2jMWPccS6lLuAhEYw6
         ykfbZPWc7DHxJKksBDJjK54Ci/zfV0cPJsUBD09g1bvXloVxDnAHlxRaeQuLzajRETqJ
         VNpbMHiNSRZPdpbkQ7Z5uF3c/lTnDqrgW0TNfvzpZtdAwtOSUqKVzmyb4dIifOv5XNLs
         5rHX/BTaT8oEfz0+SABgAc8tTDikOJdpZ+E72T/x2NC3M1yvw0Rjk0PZG6Yhxt6cMsss
         1+pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BRsabgXq1j/oZODFUT1sBBvOqEOBW7MpFRgZymkaaUA=;
        b=Cf54Jt3RYN1JaDCfdvIdr7NVoHon987nSLFkLSf4v54zoi5BAZCXaZIDHWuLgUZ19a
         gXdmiDwqh32OBqa7ZunrIQ2071gqn3JeLRVS3D/FD+A57ESP7NFZHPjWHQ4liOlfJyvb
         GxHxWGoGLwsV03swdItde1S4YUZu3Qg9PkUBUlv1fCMmD+183YTQWBrhYtmvQ6W+hLrT
         yI3d0qaedsQJwk8JWGyQdAvULjKkZTRcOK6go0uYRETiIW/DD5k7fk1sv8DpC3iVvmwl
         y8uUvTWwvJTQmUbVscNqjtInxkgLhbujb9KdntxNC68wnJLVdiLhPOajjDPusdApkAmm
         goeA==
X-Gm-Message-State: AOAM5305wc6I35Y+45nFXQOhkB8TNtC+bNE4+wVJ8a8MJnnSD1LOCsoE
        Unj+mWcqZqnIPgeH5oaGL6xYAg==
X-Google-Smtp-Source: ABdhPJwzi7PJ15TKf4jgmeDypTlfdkL9JMx3c0LopfpPKhKT3B5q/LG3ho9qNjsB2tXxMmy8LUTF6A==
X-Received: by 2002:aa7:9a1a:0:b029:1ee:ea41:9a2b with SMTP id w26-20020aa79a1a0000b02901eeea419a2bmr2923986pfj.42.1616590594380;
        Wed, 24 Mar 2021 05:56:34 -0700 (PDT)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id i10sm3175415pgo.75.2021.03.24.05.56.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Mar 2021 05:56:34 -0700 (PDT)
Subject: Re: [PATCH] rsxx: remove extraneous 'const' qualifier
To:     Arnd Bergmann <arnd@kernel.org>,
        Joshua Morris <josh.h.morris@us.ibm.com>,
        Philip Kelleher <pjk1939@linux.ibm.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Philip J Kelleher <pjk1939@linux.vnet.ibm.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
References: <20210323215753.281668-1-arnd@kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <a13867ce-8fee-8e26-5179-7255e9527229@kernel.dk>
Date:   Wed, 24 Mar 2021 06:56:32 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210323215753.281668-1-arnd@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/23/21 3:57 PM, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The returned string from rsxx_card_state_to_str is 'const',
> but the other qualifier doesn't change anything here except
> causing a warning with 'clang -Wextra':
> 
> drivers/block/rsxx/core.c:393:21: warning: 'const' type qualifier on return type has no effect [-Wignored-qualifiers]
> static const char * const rsxx_card_state_to_str(unsigned int state)

Applied, thanks Arnd.

-- 
Jens Axboe

