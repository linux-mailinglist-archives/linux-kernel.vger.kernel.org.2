Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B98063404A4
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 12:32:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbhCRLbz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 07:31:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbhCRLbs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 07:31:48 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DBB3C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 04:31:47 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id b9so3366343ejc.11
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 04:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=iE3o/hCM2p37deLsWlZAboSCZEN8A+uQjzYQvJph1UE=;
        b=dvogcnO4LvDz0mM8v9Ii8P+kPwdmwm0km8vDh6nnJ9/HJLWk/kD4nmsvyx7iWz7sS6
         2yUfG0NVwMo5v8H5xpRDrcwgXCnTO3dcqOzpNPL1DmT+t1vVe5QLsoI/6tXDjcDqwVKk
         dAn2LMTvjgdysj19T6gmVeokCidjCL91Zx1PY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iE3o/hCM2p37deLsWlZAboSCZEN8A+uQjzYQvJph1UE=;
        b=FbNsJO2rOYBQzfv1rKwhZO1lsaZbLp5jyBsDOyMfhRC/HQqMDLjjMiIYxSqCL+1Cg3
         +DJvBh31jtcC9qun/cD0a5HiYBaBydXdFUa63Q3KKryluYpKF394WMS0OGgFfqdKRXu8
         ZCjQA5DDCfG8KSiMpLvkfiY3w/6vda4Sf6+QJdYRluFgtzMlyUG6KaO6tkoPCdJkl2Ji
         vL3n72bVEG8+GM9nc4fyBQuhMQHYd23UySgcr+llWV9k1QATH44PllJBnXyMuCzS38td
         hqlKxWQSsbiLECbvJZEk9HIL5BQMSaEIWi/9TAW4kCvXx4WdvDvyL4qrIYpoLh5Luc7A
         JI8Q==
X-Gm-Message-State: AOAM532kXsngA6GNWdB8mRvSisXkBSFnLyYOU+ciASVWzxAnpHHeTQea
        a1F8WJyEPlkVjdcxWnN1IuVr9w==
X-Google-Smtp-Source: ABdhPJybRqvVoEF7H9burhDE0WQ10akUHpO34528D/mDYaPl65eHHApqxt1a3+8How9WbcQy/omrHg==
X-Received: by 2002:a17:906:4955:: with SMTP id f21mr41777443ejt.74.1616067106225;
        Thu, 18 Mar 2021 04:31:46 -0700 (PDT)
Received: from [192.168.1.149] ([80.208.71.248])
        by smtp.gmail.com with ESMTPSA id r10sm1642179eju.66.2021.03.18.04.31.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Mar 2021 04:31:45 -0700 (PDT)
Subject: Re: [PATCH v5] printk: Userspace format enumeration support
To:     Petr Mladek <pmladek@suse.com>
Cc:     Chris Down <chris@chrisdown.name>, linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>, kernel-team@fb.com
References: <YEgvR6Wc1xt0qupy@chrisdown.name>
 <02c3b2f3-ff8e-ceb9-b30b-e533959c0491@rasmusvillemoes.dk>
 <YFDAfPCnS204jiD5@chrisdown.name> <YFHAdUB4lu4mJ9Ar@alley>
 <5ea3b634-5467-35cf-dd08-1001f878b569@rasmusvillemoes.dk>
 <YFMvfawY+0CncS8G@alley>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <226a276d-2018-b419-4a6b-3ab21d3e4584@rasmusvillemoes.dk>
Date:   Thu, 18 Mar 2021 12:31:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <YFMvfawY+0CncS8G@alley>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/03/2021 11.46, Petr Mladek wrote:

> BTW: Is the trick with int (printk)(const char *s, ...) documented
> somewhere? Is it portable?

It is completely standard and portable C, explicitly spelled out in the
C standard itself. C99:

===
6.10.3 Macro replacement

10 [...] Each subsequent instance of the
function-like macro name followed by a ( as the next preprocessing token
introduces the
sequence of preprocessing tokens that is replaced by the replacement
list in the definition
(an invocation of the macro). [...]
===

and later

===
7.1.4 Use of library functions

1 [...] one
of the techniques shown below can be used to ensure the declaration is
not affected by
such a macro. Any macro definition of a function can be suppressed
locally by enclosing
the name of the function in parentheses, because the name is then not
followed by the left
parenthesis that indicates expansion of a macro function name. For the
same syntactic
reason, it is permitted to take the address of a library function even
if it is also defined as
a macro.
===

Also, the use of printk() inside the definition of a printk()
function-like macro does not lead to infinite recursion, by

===
6.10.3.4 Rescanning and further replacement

2 If the name of the macro being replaced is found during this scan of
the replacement list
(not including the rest of the source file’s preprocessing tokens), it
is not replaced.
===

Rasmus
