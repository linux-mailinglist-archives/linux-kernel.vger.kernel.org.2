Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51EC4315CB3
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 02:58:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234403AbhBJB6D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 20:58:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234889AbhBJAYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 19:24:55 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19563C061574
        for <linux-kernel@vger.kernel.org>; Tue,  9 Feb 2021 16:24:14 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id j11so220439plt.11
        for <linux-kernel@vger.kernel.org>; Tue, 09 Feb 2021 16:24:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=X45YGhvSSKINz38Za1Kkw3oOXRPeq40EClkO0mkNfk0=;
        b=bB0qQvW/EF9biTCYsZRdZp2t1wzgg8HcyPgCsaAdgn6UYufvqz+ZPo/l/TZvkhElhh
         VtlZd00G2ZbIppI7LRcrFM9Q9bJsIN+sBsu1mE9b4IGIGWVhzm4xRylRNXTKUXTpm24l
         t4L8GzLd+l2EcucPBlmtuugylzY/W1hW5+1eg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=X45YGhvSSKINz38Za1Kkw3oOXRPeq40EClkO0mkNfk0=;
        b=roy1HSaHRiKdz3J3UPqm/P/BazAADhIMsH9xc5QYCC257AO9kF1INmRjFbluoqyCXa
         Ce4exhVaa2MhJivssSVDh5RkG3vy6otkgzNupPreEeg372u7rbCIv6CPgGvz1mv+YlzM
         C3fXrpd5RtKxZi72/kso3gembpTLEmDDVd6jMxHTvp5IRuPEvfkopjA2Dp4cmaQyvg1M
         1M8vPZYgR1XUOQA/tfNlgdVozKsLXHFwxrF9zU+BTeeWW/k90/ZqQFWoFho5pPnc/33E
         YN7sawv6GiAKBltsi7bWRsSwpKO9BV1lOQCS0kxsQo9WJC/I6DAC7fUielJ2sJDAHi5x
         nYEA==
X-Gm-Message-State: AOAM5313de6l4e4qsgROgu0ljksPCSkNuTnKDCFhH5Adx/3LvMADAKIF
        PRXZcxn4DPqLVFGCt/unMMzjAg==
X-Google-Smtp-Source: ABdhPJwd9kfCwN45s5u8pGEivd05omdi+/c9ZvGSn5Xhe1K3ArjpgzuS9S6/BeDw2fjPbvM4K44hKg==
X-Received: by 2002:a17:90b:354:: with SMTP id fh20mr483392pjb.122.1612916653657;
        Tue, 09 Feb 2021 16:24:13 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c18sm94664pfj.58.2021.02.09.16.24.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 16:24:12 -0800 (PST)
Date:   Tue, 9 Feb 2021 16:24:11 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Timur Tabi <timur@kernel.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>, Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        willy@infradead.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, roman.fietze@magna.com,
        john.ogness@linutronix.de, akinobu.mita@gmail.com
Subject: Re: [PATCH][RESEND] lib/vsprintf: make-printk-non-secret printks all
 addresses as unhashed
Message-ID: <202102091623.834390BBF9@keescook>
References: <20210202213633.755469-1-timur@kernel.org>
 <3baace45-38af-a59b-c376-9a4c39a17b2d@suse.cz>
 <d6223371-a5e7-28ac-704c-0e3d5b7ea713@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d6223371-a5e7-28ac-704c-0e3d5b7ea713@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 05, 2021 at 12:25:22PM -0600, Timur Tabi wrote:
> I can extend make-printk-non-secret to %pK if everyone agrees.

Let's just leave those alone. There is already a toggle for that in
/proc.

-- 
Kees Cook
