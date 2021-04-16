Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A99903621CE
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 16:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244353AbhDPOKB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 10:10:01 -0400
Received: from smtprelay0212.hostedemail.com ([216.40.44.212]:45440 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S244519AbhDPOJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 10:09:35 -0400
Received: from omf06.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 52CB4180CC338;
        Fri, 16 Apr 2021 14:09:09 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf06.hostedemail.com (Postfix) with ESMTPA id C75542448B4;
        Fri, 16 Apr 2021 14:09:06 +0000 (UTC)
Message-ID: <f6f66233fbd670fef82a199ab0299489618cad81.camel@perches.com>
Subject: Re: [PATCH v5] printk: Userspace format enumeration support
From:   Joe Perches <joe@perches.com>
To:     Chris Down <chris@chrisdown.name>, Petr Mladek <pmladek@suse.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>, kernel-team@fb.com
Date:   Fri, 16 Apr 2021 07:09:05 -0700
In-Reply-To: <YHmXi303WxVZzVwI@chrisdown.name>
References: <YEgvR6Wc1xt0qupy@chrisdown.name>
         <02c3b2f3-ff8e-ceb9-b30b-e533959c0491@rasmusvillemoes.dk>
         <YFDAfPCnS204jiD5@chrisdown.name> <YFHAdUB4lu4mJ9Ar@alley>
         <5ea3b634-5467-35cf-dd08-1001f878b569@rasmusvillemoes.dk>
         <YFMvfawY+0CncS8G@alley> <YHmXi303WxVZzVwI@chrisdown.name>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: C75542448B4
X-Spam-Status: No, score=1.60
X-Stat-Signature: cqhxomtunzwjze9g7h59ftyp7i7akz79
X-Rspamd-Server: rspamout04
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX199kE6lHRbJ4CRcIEWXOQ0Zqvf2Fpq0BkA=
X-HE-Tag: 1618582146-290331
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2021-04-16 at 14:56 +0100, Chris Down wrote:
> Any better suggestions? :-)

A gcc plugin that looks for functions marked __printf(fmt, pos)
so any const fmt is stored.


