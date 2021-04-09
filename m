Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BF1F35929A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 05:09:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233290AbhDIDJx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 23:09:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233264AbhDIDJe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 23:09:34 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 168C8C061763
        for <linux-kernel@vger.kernel.org>; Thu,  8 Apr 2021 20:09:22 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id t22so2850863pgu.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Apr 2021 20:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=p6V7kMAr/qfNsP2NpJNwSvSLsZ0EwZ6E9deTk98f6UM=;
        b=FqMTU93Mb4VBYmWBa2xwQCeJSoQRjSTY0KwqA8yKLBzbU80L4YLdxutfRcXzPWwQ85
         4VnipuSuKCOjQyzBJR/sofD/eWTYEq0xJzfqojfCVDV09IfYbdrU53yuUlDkInGAcBnC
         RSckyjdC9LYXRL671NZRN0jiv/64YKKar5RHU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=p6V7kMAr/qfNsP2NpJNwSvSLsZ0EwZ6E9deTk98f6UM=;
        b=tRjN57To0H1eyTRjNcmQuT9cuOQz8slUnT8MifNsCi/7Y54YH1vhymorpaTHkhHhvQ
         43ueV6rV+ucF7Ej1Tk8l4a1M8cT7gJ5QrhiZomT6L8KpojrQQc93C/YTrIp0CvG3sSYf
         Mc7wIMGvlua31Yq55c+cPJAVzWBE4GMDqnrCX9MRW18zq6+lmgjx1rrtGBx1QG+H7RUn
         r7QS9oF3ABg0BkSjdfYCNKDnTbs8nQOuGfjOUJdDeG2HZAR/ZKp4N5eqn0BHBF441Dtn
         ZRL236uRRIOBkgYgtGWhwSKHpY/36EtLCK/zDi+PLgrVn5240pgDep17nX8PSifOeGY3
         Nk+A==
X-Gm-Message-State: AOAM533/UtxWGE625p06VLSln3jIKFbxTJOkB2+JUrEhXneW1vOEfBC/
        wwF4rMjclgq4aJyyJSMyJwf8rQ==
X-Google-Smtp-Source: ABdhPJzk7Zl0O1lLvoWl18AE7wqoq81kr634C0TdGiP11qwod4pzWNf2ghvh6pnXAELrMZto7M9jVw==
X-Received: by 2002:a65:48c5:: with SMTP id o5mr10975475pgs.101.1617937761659;
        Thu, 08 Apr 2021 20:09:21 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i7sm649034pgq.16.2021.04.08.20.09.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 20:09:21 -0700 (PDT)
Date:   Thu, 8 Apr 2021 20:09:20 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org
Subject: Re: [PATCH 18/20] kbuild: sh: remove unused install script
Message-ID: <202104082009.D5774EDC4@keescook>
References: <20210407053419.449796-1-gregkh@linuxfoundation.org>
 <20210407053419.449796-19-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210407053419.449796-19-gregkh@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 07, 2021 at 07:34:17AM +0200, Greg Kroah-Hartman wrote:
> The sh arch has a install.sh script, but no Makefile actually calls it.
> Remove it to keep anyone from accidentally calling it in the future.
> 
> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> Cc: Rich Felker <dalias@libc.org>
> Cc: linux-sh@vger.kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
