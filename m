Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E86B73AB31D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 13:57:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232605AbhFQMAC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 08:00:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230269AbhFQMAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 08:00:00 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5A7EC061574
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 04:57:52 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id l9so3264713wms.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 04:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MZ33EQrarFipwDO2m7oPj7Kr+yPURVsoLgLKn7NF/gc=;
        b=GAnRF6DteSW4bz0NcB/IQ2an6fFiZC0ZVY/HAzR08nL7hELTxD7N9ThKwDa4Pz5GIG
         qHgX7VOTSEaxM2qqxQNlAFUkzf6KqrYEBMj6oIM9D3sk5T72UAUfjLHG5BAU/jkZC/5X
         8Flxfu+obukQ4lKPL/n7ni3iRycmHJeKpibsY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MZ33EQrarFipwDO2m7oPj7Kr+yPURVsoLgLKn7NF/gc=;
        b=hVZC0MDAih5zgDdrgvRIQJDtL9hDMKW5Rz0WVu5h/cHs24REv4qBdXLHtQ8fEb+vNY
         uOZIjTWmwEi9crvHyaRHLF8k7LKBMp/oXuMtTtp5Nb39SDermdYYh9RZyql0VGxqgjwL
         xpK7jMcGweao3a30i0GDQhfBpRmfw4n4ZWBee3iXRlzPbwVzOn65wEtqGGgI1H9EYARK
         vZFtnvWF2UHF4mmI9NJuDbFEAiIRISetKl99RXvjYWAdnSP5y+4rceFr7zz/ECFpo8hJ
         MG5zBpYlqGjrut1CjSIjenNCnDKir6I5UN8tekZw6P9qKxu78Vy8cQcHY3exd3oEJOau
         uI9A==
X-Gm-Message-State: AOAM532eK7GyVBUUooHnB1Dc05GS/j1SxUqSpsGGG5KmJt84dIQF+65k
        s00qK/St1SEewzmaZ4AAvOjV734xOQlMt09jr08=
X-Google-Smtp-Source: ABdhPJxiiYSnnZ1YYSEWZm2dtZWZJ1s+9dT/BwbIkOwbry+XZ9Xg/zy+QbTixUFUGaM9MJXJJ+/i2w==
X-Received: by 2002:a1c:59c9:: with SMTP id n192mr4603151wmb.81.1623931071194;
        Thu, 17 Jun 2021 04:57:51 -0700 (PDT)
Received: from localhost ([2620:10d:c093:400::5:7326])
        by smtp.gmail.com with ESMTPSA id k67sm2513624wma.14.2021.06.17.04.57.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 04:57:50 -0700 (PDT)
Date:   Thu, 17 Jun 2021 12:57:49 +0100
From:   Chris Down <chris@chrisdown.name>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     kernel test robot <lkp@intel.com>, linux-kernel@vger.kernel.org,
        kbuild-all@lists.01.org, Petr Mladek <pmladek@suse.com>,
        Jessica Yu <jeyu@kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        John Ogness <john.ogness@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v7 4/5] printk: Userspace format indexing support
Message-ID: <YMs4vZVsYlgZ1RhN@chrisdown.name>
References: <e42070983637ac5e384f17fbdbe86d19c7b212a5.1623775748.git.chris@chrisdown.name>
 <202106171546.7koPrJBA-lkp@intel.com>
 <YMsJ6ORGRKmSlvJO@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <YMsJ6ORGRKmSlvJO@smile.fi.intel.com>
User-Agent: Mutt/2.1 (4b100969) (2021-06-12)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Shevchenko writes:
>Chris, to avoid such issues, use `git format-patch --base ...` when sending a
>series / patches.

Ah, I forgot about that. Will do, thanks.
