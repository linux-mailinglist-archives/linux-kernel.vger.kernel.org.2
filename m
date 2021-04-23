Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7723C369BF6
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 23:19:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244027AbhDWVUZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 17:20:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232686AbhDWVUT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 17:20:19 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82313C061574;
        Fri, 23 Apr 2021 14:19:42 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id p12so36030804pgj.10;
        Fri, 23 Apr 2021 14:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WAO+nTeTFKCXmHl+vp74ehdsr2jzD+Il2HojC2vivp4=;
        b=jh3E0F9cmHHV45i2iz4jSxo6rNeP1zus8z7oJn9SUycV0Qwp/5hqJ6LIJsCaGM5azq
         0j4/pX8V/HNvmN3TQcgtlvCWt5l7I05gNF2CImlB4N0UnWK0RBoe7UGB/GKi3cF02Et8
         s/8ILNzGnE/1JyxtRr919BrJZc/2ZOxe/stWx7HHzDxJFfmABIgxNjbKCwBq/h+ZTPtN
         sCzAgUtJSiXsLpfjUNH8RZPI7kImn3S7zT0jUNr2Bv4oGPWAs7mkhaia9TMELq6YCKNg
         3esi8HjeOyeHnmCk9h1kQzG61G0TVi+6DFxepUsPo9cdET7YCwVw++0hE421c5V0q9dN
         7n7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WAO+nTeTFKCXmHl+vp74ehdsr2jzD+Il2HojC2vivp4=;
        b=XY13GvJrX6fmMVJRJmtGc7n0+D3cswuL4WyZ4HZct9usoCfIfSlrkoxBVqTLgtbd0W
         YIQB4UqHXlE0208i6upt0QVWeH+ZkOo7klwLbszQoWPtidjpI+6KWwzDY7znZXviH/e5
         6dHcStwtjgxclhV7e1jzbPCkTE8lFMpGd8OzPxvIgENNIk5QQ5jst305Y/CyVdObrwaL
         0dA4IZe4sCTXcOG8cKLr/wvII0wWle3KhxHL5bn9pZNJpGg9d2LyUJVI52if8v/T0pek
         cJgGCyAeXxibrDlBglNm/M3H8Lq5TVG5AN4CiBMGA9SABODlNuVVwSpDEMA9MIyv12SP
         iJxg==
X-Gm-Message-State: AOAM530s+8t8W9UYft6FAb++FlBhxmTcXT7hFc+U78/Vjz9bb2kGQtEw
        m119koFYL/OadTitftO0KlE=
X-Google-Smtp-Source: ABdhPJwgDjseqFJlZ7o7q9LGMWZO9BTmSGr0Y6iCXKAXi19G4EFyrcnl6ZWfwKsgNo8LSmW07YWeTA==
X-Received: by 2002:a63:5626:: with SMTP id k38mr5878365pgb.128.1619212781788;
        Fri, 23 Apr 2021 14:19:41 -0700 (PDT)
Received: from localhost (g191.124-44-145.ppp.wakwak.ne.jp. [124.44.145.191])
        by smtp.gmail.com with ESMTPSA id d17sm5339384pfn.60.2021.04.23.14.19.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Apr 2021 14:19:41 -0700 (PDT)
Date:   Sat, 24 Apr 2021 06:19:39 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     jonas@southpole.se, stefan.kristiansson@saunalahti.fi,
        rppt@kernel.org, akpm@linux-foundation.org, arnd@arndb.de,
        openrisc@lists.librecores.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] openrisc: Fix a memory leak
Message-ID: <20210423211939.GP3288043@lianli.shorne-pla.net>
References: <c078439e31fd60e1617be8c17cc1ec57639e0586.1619190470.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c078439e31fd60e1617be8c17cc1ec57639e0586.1619190470.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 23, 2021 at 05:09:28PM +0200, Christophe JAILLET wrote:
> 'setup_find_cpu_node()' take a reference on the node it returns.
> This reference must be decremented when not needed anymore, or there will
> be a leak.
> 
> Add the missing 'of_node_put(cpu)'.
> 
> Note that 'setup_cpuinfo()' that also calls this function already has a
> correct 'of_node_put(cpu)' at its end.

Thanks, this looks good to me.  I will queue it up.

> Fixes: 9d02a4283e9c ("OpenRISC: Boot code")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  arch/openrisc/kernel/setup.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/openrisc/kernel/setup.c b/arch/openrisc/kernel/setup.c
> index 2416a9f91533..c6f9e7b9f7cb 100644
> --- a/arch/openrisc/kernel/setup.c
> +++ b/arch/openrisc/kernel/setup.c
> @@ -278,6 +278,8 @@ void calibrate_delay(void)
>  	pr_cont("%lu.%02lu BogoMIPS (lpj=%lu)\n",
>  		loops_per_jiffy / (500000 / HZ),
>  		(loops_per_jiffy / (5000 / HZ)) % 100, loops_per_jiffy);
> +
> +	of_node_put(cpu);
>  }
>  
>  void __init setup_arch(char **cmdline_p)
> -- 
> 2.27.0
> 
