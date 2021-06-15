Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 578753A841C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 17:37:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231652AbhFOPjF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 11:39:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230352AbhFOPjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 11:39:02 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D318C06175F
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 08:36:58 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id y15so13549288pfl.4
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 08:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1DPucRFAeorZjnPTe1o61We/n0wdasm18ByDS7A0W6A=;
        b=CEHmIOod2G6jvGxHbD9CADgZUgOPqr/v4FCQIOGlubiU0GN1JkV3vR5dJyvlapKhkp
         9mCp24EqBHBYbvnTBCQhMZGFoTgSIZ+1nMdqxiBMJIg0JxI0592JRvoJ71k0tKyMkgYz
         7q9ePHJv00vsCUEDSPeEjWt7gL7xacWT1L4vI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1DPucRFAeorZjnPTe1o61We/n0wdasm18ByDS7A0W6A=;
        b=axrp3oAVFkFI5cMADDK1vO9r48k1HcG9BwFmHcPAsNbr1R0uxI4pNYWujFasQ1OiWr
         ZyQ6Od/MW66ou4TAMbsdeLm7cM4coaWY0toft0UlUCEIsOKa2ptUGQEPSNvN5tIk+Q5/
         0nJNfbjyczyMD59jzgpRFIWbBmALoPiJHQtX/6n3SSdZjWgqygSJRmxg2/gEuRzZMxg1
         CAhl57EqC8X2n+qH6VhJ1K5yzTBPU4ZnaycfwXzS2JEXj7cUl0aiS+NmfvMaFWTGlBLB
         cJZYtQPds6wOHXdKYfJZXSdoCwIcUnpU7ghgSi0BojarsYJq8YSJLDdn1SoxMMkXYasW
         ljAQ==
X-Gm-Message-State: AOAM530ayKoTJzEf8/vVr4UTxIj7ZwR6naDm2zjb8kLPZFxUVwSmVm++
        Vne1kj30rg8ZuV5Dl8zASYQn5X0qPu7mOg==
X-Google-Smtp-Source: ABdhPJzjtgmxbjTP794D3SrN3M/72ebuMs/8fNCvG8pAk8JDarCWD4hWeWsXcVrFUhejbrM4+bNpGQ==
X-Received: by 2002:a63:d45:: with SMTP id 5mr150540pgn.72.1623771418068;
        Tue, 15 Jun 2021 08:36:58 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u38sm5545858pgm.14.2021.06.15.08.36.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 08:36:57 -0700 (PDT)
Date:   Tue, 15 Jun 2021 08:36:56 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the pstore tree
Message-ID: <202106150833.1F1D7E5A@keescook>
References: <20210615201516.56c760fa@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210615201516.56c760fa@canb.auug.org.au>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 15, 2021 at 08:15:16PM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the pstore tree, today's linux-next build (htmldocs)
> produced this warning:
> 
> fs/pstore/blk.c:1: warning: no structured comments found
> 
> Introduced by commit
> 
>   38c18fec13fb ("pstore/blk: Use the normal block device I/O path")
> 
> The last kernedoc comment in this file is removed by this commit.

I was briefly quite confused by this. I see now it's the
:internal: not the :export: use of blk.c. If it's possible to
improve this error report email with more details in the future,
that would be nice. For example, "blk.c:1" isn't helpful, but
"Documentation/admin-guide/pstore-blk.rst:230" would be. :)

I'll get this fixed up; thanks!

-Kees

-- 
Kees Cook
