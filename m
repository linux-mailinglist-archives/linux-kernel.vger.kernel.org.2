Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4E9F35AB90
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 09:00:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234415AbhDJHBB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Apr 2021 03:01:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234367AbhDJHA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Apr 2021 03:00:56 -0400
Received: from mail.ionic.de (ionic.de [IPv6:2001:41d0:a:588b:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 26979C061762
        for <linux-kernel@vger.kernel.org>; Sat, 10 Apr 2021 00:00:42 -0700 (PDT)
Authentication-Results: root24.eu; spf=softfail (domain owner 
   discourages use of this host) smtp.mailfrom=ionic.de 
   (client-ip=217.92.117.31; helo=home.ionic.de; 
   envelope-from=ionic@ionic.de; receiver=<UNKNOWN>)
Received: from [192.168.0.46] (home.ionic.de [217.92.117.31])
        by mail.ionic.de (Postfix) with ESMTPSA id 3A9DB4F00338;
        Sat, 10 Apr 2021 07:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ionic.de; s=default;
        t=1618038034; bh=S+95RKxtO3PJbCmeLJdIjWCX646SI4fb/oRRtGv+Tmc=;
        h=To:Cc:References:From:Subject:Date:In-Reply-To:From;
        b=l1fuYv6Qu+dPFolJPBqxKxCZ3YmD2h6qPvkKCl5nqmoQfi9uk6IKFTphCfNFF3jHw
         hTtK9ixYhxfhSyxSppXJe6KvtD45sDv7NKOUc5ID+hyo4+aw6fx7W5KLHqX8aMXf8I
         aUJEh+3tlze3TLixts1xDxiXkAUFECIaoga75aWM=
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20210327120155.500-1-ionic@ionic.de>
 <20210328095227.24323-1-ionic@ionic.de>
 <CAK7LNATzx9ujmapPbPzjL1Yo-A0RAXz0Kma+ve8pUeDDVx8GGw@mail.gmail.com>
From:   Mihai Moldovan <ionic@ionic.de>
Subject: Re: [PATCH v2] kconfig: nconf: stop endless search-up loops
Message-ID: <9e8d429f-c21c-7d9e-0dcd-8947846fe9ba@ionic.de>
Date:   Sat, 10 Apr 2021 09:00:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <CAK7LNATzx9ujmapPbPzjL1Yo-A0RAXz0Kma+ve8pUeDDVx8GGw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* On 4/10/21 7:47 AM, Masahiro Yamada wrote:
> On Sun, Mar 28, 2021 at 6:52 PM Mihai Moldovan <ionic@ionic.de> wrote:
>> +               if ((index == -1) && (index == match_start))
>> +                       return -1;
> 
> We know 'index' is -1 in the second comparison.
> So, you can also write like this:
> 
>        if (match_start == -1 && index == -1)
>                 return -1;

I know, but I sided for the other form for semantic reasons - this more closely
directly describes what we actually care about (both being the same value and
either one being -1).


> But, it is not the correct fix, either.
> 
> The root cause of the bug is match_start
> becoming -1.
> 
> 
> The following is the correct way to fix the bug
> without increasing the number of lines.
> 
> 
> 
> diff --git a/scripts/kconfig/nconf.c b/scripts/kconfig/nconf.c
> index e0f965529166..af814b39b876 100644
> [...]
> +       match_start = (match_start + items_num) % items_num;
>         index = match_start;
> -       index = (index + items_num) % items_num;

This is probably more elegant and fixes two issues at the same time: match_start
becoming -1 or n (which is likewise invalid, but was implicitly handled through
the remainder operation).

No objections from my side.



Mihai
