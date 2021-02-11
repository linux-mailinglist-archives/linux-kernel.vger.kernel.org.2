Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 086BE319174
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 18:50:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232589AbhBKRsC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 12:48:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:43002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229679AbhBKRI4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 12:08:56 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id BCC23601FB;
        Thu, 11 Feb 2021 17:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613063295;
        bh=oa5xxkgHegTId186SifRj7R4Z6bmoEkTHDsq/mrrNyE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=HcIgB2MUR/bhcDgruLRPJqlLfXrXds21CReZVP1jGfGgiaUsNPs5/qBDnFD2+7z2a
         3PBdFu31dEwl83bz/+a6rEF/f3s5Lz6/KjsQbkL55UT7Rwxne5lhUaegUldT6i18mh
         KZCk2191TEq3EM5rvk5fRAwynQGsG8dWliK7YaS7rIa8oN1Bwo40RWL2DH4e86oiu/
         LTpL+ucmdCw5NJ+FmHRKLWzP0u3fyT5T4Zm50YWo+JnT/d6Kfs8eAPpR7bszHJkvt1
         Jiq3Zfk0TJFB57NbL8OhHcRw2i88t492rdnOW7IZRUtALSjqc8Vo4jT1BQTLNvmbdK
         8Tvxws7lwHzmw==
Subject: Re: [PATCH 3/3] [v3] lib/vsprintf: debug_never_hash_pointers prints
 all addresses as unhashed
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        akpm@linux-foundation.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        roman.fietze@magna.com, Kees Cook <keescook@chromium.org>,
        John Ogness <john.ogness@linutronix.de>,
        akinobu.mita@gmail.com, glider@google.com,
        Andrey Konovalov <andreyknvl@google.com>,
        Marco Elver <elver@google.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20210210213453.1504219-1-timur@kernel.org>
 <20210210213453.1504219-4-timur@kernel.org> <20210211123118.GB31708@amd>
From:   Timur Tabi <timur@kernel.org>
Message-ID: <9f0c02d9-29d6-95ce-b9b7-27342aa70c6f@kernel.org>
Date:   Thu, 11 Feb 2021 11:08:12 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210211123118.GB31708@amd>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/11/21 6:31 AM, Pavel Machek wrote:
> Can we make this something shorter? Clearly you don't want people
> placing this in their grub config, so they'll be most likely typing
> this a lot...
> 
> debug_pointers or debug_ptrs would be better.

dbg_unhash_ptrs?  "debug_ptrs" is too vague IMHO, and I want to keep the 
word "hash" somewhere there to indicate exactly what's happening.
