Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E98BA33C7A9
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 21:23:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233383AbhCOUX2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 16:23:28 -0400
Received: from mail-pg1-f172.google.com ([209.85.215.172]:36574 "EHLO
        mail-pg1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbhCOUXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 16:23:07 -0400
Received: by mail-pg1-f172.google.com with SMTP id o16so4161339pgu.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 13:23:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LkrK6Ut7OCblvP4n1lYpcAzNGECNXXmTAxZVNE4zt+o=;
        b=ecx+EVBAV7eHVZRYL8NH3MA4ibFaVxPSaHnnHSxHWjPK15m9W2fcJzYR5T1fkvo7GG
         P1PmE5eHaW2bMBh4oGhHgr+JxGccWY8vXFjGhNZSipFa6ED1vBtsRsSA+lsSqF4R/7zT
         tezyVi4Rtv8yqu+NPsq0w+gkxQoCx8Vl0qRxWa4pxYz5XbvgTdlofWtAN6Q+9DXk28ws
         s04IC+H+AoiZ7N/zVCYYHcl8eVE7RAQWNkVUUUQytlvkcdfhzSAwPkIsv/EIIjANRByG
         F+nanB5EA9KeJOBtQDpzpbHFrSlDxRZ1l6hmXvIjIYTJN4AUd2KlyO5r5bBA0dN+g51d
         hJ8A==
X-Gm-Message-State: AOAM530pz1sKxE54iw/I3/GuR5B7z67TXVtpojDQeXrPiEMElQL8Qhmz
        upQEwEK/+HfLNdNi+8WIUvo=
X-Google-Smtp-Source: ABdhPJyCxiDaZK72lBLNUjYoJm9Op3VmEWpc4weiLytzYDiFNM0LSiF0jYeoG1xUBASK8/DSgoeBTw==
X-Received: by 2002:a63:1901:: with SMTP id z1mr727738pgl.434.1615839786944;
        Mon, 15 Mar 2021 13:23:06 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id gf20sm469482pjb.39.2021.03.15.13.23.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 13:23:05 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 4300640106; Mon, 15 Mar 2021 20:23:05 +0000 (UTC)
Date:   Mon, 15 Mar 2021 20:23:05 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jessica Yu <jeyu@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH v3 0/2] background initramfs unpacking, and
 CONFIG_MODPROBE_PATH
Message-ID: <20210315202305.GC4332@42.do-not-panic.com>
References: <20210313212528.2956377-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210313212528.2956377-1-linux@rasmusvillemoes.dk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 13, 2021 at 10:25:26PM +0100, Rasmus Villemoes wrote:
> Routing-wise, I hope akpm can handle both patches. Andrew, Luis?

I think it would be ideal for it to go through Andrew's tree.

  Luis
