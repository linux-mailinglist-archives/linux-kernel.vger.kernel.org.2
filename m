Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AFF632FE94
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Mar 2021 04:42:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbhCGDlf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Mar 2021 22:41:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbhCGDlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Mar 2021 22:41:25 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAEFBC06175F
        for <linux-kernel@vger.kernel.org>; Sat,  6 Mar 2021 19:41:14 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id p21so4140436pgl.12
        for <linux-kernel@vger.kernel.org>; Sat, 06 Mar 2021 19:41:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=penguintechs.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=j+GZzqGgIYZ9yKqNheOI33xjFEyGpTiyMfaxR/myKz4=;
        b=gO1G4fH2IRR0vhI88sYsvwxcnZ0MYmU8+aTFfy9M8F4E6lIO6s6qI1IxrubnZJUked
         vREwPzwkyK9fdkIS7JCjHMxKAtd4UmuX38nNG+zNLYgrzfIYJCsMZpbXiCXUDxYvqyNq
         cOxic3ynJ7iuhmzWZE5hYcim3QFAJ0afxpWgA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=j+GZzqGgIYZ9yKqNheOI33xjFEyGpTiyMfaxR/myKz4=;
        b=no65+1ZKIdAgxgONX0Ay27Kx9QIOVbdlCJZkCsw9aq1HzeffIKVHiL34Lk1pFjkueL
         FQ72OLtyJygFITGRx39yNnoPBtqzUcmbq6QKTr5AnmI7rfO0YbQY62e8gK+NjrmxOOWq
         kCjyXt6f/7sUtdqh11S+/W04ebLOUlNcDJrVNVimcoLF7hfYMY5N7umZRN+A8Tx/2lOf
         JG5YVp10HbPOBdUh/x3lCtjyFnXUGVOnQ3bS9tGTiGhdVtwofk7CGYyGzEARt4VcSqnt
         A+yPOm6KJpD1LAdvAdeEXF3Qx2yPAb3DKz1KkDLmu/bwqtE6VuIRqPHF0bhfOxJNPpqT
         QIbA==
X-Gm-Message-State: AOAM5310NV5LGZPvgM74wj/bCAw4UBZNdJsINc8JAbvtJUjDOI5/g/V2
        JTqY0YvF14tHUB7MTEZZHmtysU3K5AjFCbzf
X-Google-Smtp-Source: ABdhPJwaIf4qp1MB2is+pt4D5Zfq1E80gsxO7mJ3Ur34fLVqd07rmtr2Ue4yvaeRnIEtrmgjc5DYFw==
X-Received: by 2002:aa7:92cb:0:b029:1f1:542f:2b2b with SMTP id k11-20020aa792cb0000b02901f1542f2b2bmr9787278pfa.31.1615088474021;
        Sat, 06 Mar 2021 19:41:14 -0800 (PST)
Received: from braindead.localdomain (c-71-202-115-154.hsd1.ca.comcast.net. [71.202.115.154])
        by smtp.gmail.com with ESMTPSA id i1sm6386749pfo.160.2021.03.06.19.41.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Mar 2021 19:41:13 -0800 (PST)
Subject: Re: [PATCH v2] Expose the bus kernel docs to the build docs.
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210307014445.GT2723601@casper.infradead.org>
 <20210307031219.53800-1-wt@penguintechs.org>
 <20210307031611.GU2723601@casper.infradead.org>
From:   Wren Turkal <wt@penguintechs.org>
Message-ID: <de97ad62-d7bc-13e2-3816-441e98dbbc8d@penguintechs.org>
Date:   Sat, 6 Mar 2021 19:41:12 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210307031611.GU2723601@casper.infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/6/21 7:16 PM, Matthew Wilcox wrote:
> On Sat, Mar 06, 2021 at 07:12:19PM -0800, Wren Turkal wrote:
>> +Fucntions and Structures
> 
> Typo, but hold off on a v3 until someone weighs in with an opinion on
> the rest of the patch.
> 

Okay, I fixed the misspelling locally. Looking forward to addtional 
feedback.

Thanks,
wt
