Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 367283675AA
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 01:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343681AbhDUXVC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 19:21:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231296AbhDUXVA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 19:21:00 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DA91C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 16:20:27 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id 65-20020a9d03470000b02902808b4aec6dso35711979otv.6
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 16:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Yr+99ckeJiaoGdClbpWB4HHCEhei4MoOISTzWXxk02Q=;
        b=qbJ2+PTT2nqKysWj4o9Q+vtSpUSGrF1fZf19BZfYCKxHNxzxGuzV4uVvxYxT+6Fo08
         +kiWA0CbvKO2TSzV6Q54ruMCNOYdvzXQrzn2CS/H37rUl9TtD3GhL8cYHKBwrXa2IyPV
         fMlKwmDXPER+OLOcyg4UoXpQB/oyyqQat9nXzTrpHe0da7BlDyubZQQX/ymBjYPg0ziy
         YBIaJ9sKQlMt6aYhwX/ZK2YVBo1CRRSyn5NcA9/LptaaLjRgr3uplYcXPL13W0jiJsow
         AyTKusSvzCYN1WrazOEd0DI2eR6YoDSkSexnzI6c6OyKjtE8hmvpq0jczub1oJEsSiR7
         rLRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Yr+99ckeJiaoGdClbpWB4HHCEhei4MoOISTzWXxk02Q=;
        b=MiRVp/GeWqDTOlJIDzgG8iaRrQWrQ8UqbR9uMwiBzzObloeDOg3G0yAQLsXJhPWHMt
         8C9nx7XpFxObrKcyQtvhypvdNYj4L5XWePtoYtrALrtMRRSR+B8uzrloSouiXIPZpgWB
         AjHcKFamyNLF5Jj0djaAJ6z1j98khtnVY7jBH5xMjyn2V+CURaPAmevwIc3GTFPw5vB5
         StXbLjCOS7FtPP2/X00Tns59113+mQwS+S555XDWm5HjCN0DnC6Olkw84gNRZDYFP9j/
         gvPEr/q5APOOEL42ZBeb8ufkD5D93XLnJDn58jIp6pVychu2ulTUSfZspj9NEeMQg/oe
         LlWA==
X-Gm-Message-State: AOAM531R7MWuDbFLjz5LCrGm4CDH0qokJBMOz9hFCFCXvrtpeyH5LqIS
        xAHtMI7QgfbOjLzgH9qgh4A=
X-Google-Smtp-Source: ABdhPJzWnJzpSekO8NckH804Oi+7aq+v8bKqBWCF/GY9ROMwTEc4LEbsnAKuRf4101tbO0ZTzyzWVA==
X-Received: by 2002:a9d:6f04:: with SMTP id n4mr438594otq.33.1619047226562;
        Wed, 21 Apr 2021 16:20:26 -0700 (PDT)
Received: from ?IPv6:2600:1700:dfe0:49f0:7057:1c1c:7495:4212? ([2600:1700:dfe0:49f0:7057:1c1c:7495:4212])
        by smtp.gmail.com with ESMTPSA id j11sm223173ooo.45.2021.04.21.16.20.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Apr 2021 16:20:26 -0700 (PDT)
Subject: Re: [PATCH 170/190] Revert "net: dsa: bcm_sf2: Propagate error value
 from mdio_write"
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Kangjie Lu <kjlu@umn.edu>, "David S . Miller" <davem@davemloft.net>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-171-gregkh@linuxfoundation.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <30b2efa4-f873-a391-00c7-f1eb278a3db1@gmail.com>
Date:   Wed, 21 Apr 2021 16:20:24 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210421130105.1226686-171-gregkh@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/21/2021 6:00 AM, Greg Kroah-Hartman wrote:
> This reverts commit e49505f7255be8ced695919c08a29bf2c3d79616.
> 
> Commits from @umn.edu addresses have been found to be submitted in "bad
> faith" to try to test the kernel community's ability to review "known
> malicious" changes.  The result of these submissions can be found in a
> paper published at the 42nd IEEE Symposium on Security and Privacy
> entitled, "Open Source Insecurity: Stealthily Introducing
> Vulnerabilities via Hypocrite Commits" written by Qiushi Wu (University
> of Minnesota) and Kangjie Lu (University of Minnesota).
> 
> Because of this, all submissions from this group must be reverted from
> the kernel tree and will need to be re-reviewed again to determine if
> they actually are a valid fix.  Until that work is complete, remove this
> change to ensure that no problems are being introduced into the
> codebase.
> 
> Cc: Kangjie Lu <kjlu@umn.edu>
> Cc: David S. Miller <davem@davemloft.net>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

While this commit does not fix a known problem, the driver should have
arguably propagated the return values and it did not, so I would be
inclined to keep it.
-- 
Florian
