Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16EE1305307
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 07:16:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233915AbhA0GAQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 01:00:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:32998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235723AbhA0DXZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 22:23:25 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 48BC7205CA;
        Wed, 27 Jan 2021 03:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611717745;
        bh=NZVFUDdUWED82/tyO9oyzLgiLRuwpzIH+cQHX4ebBKk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=OcBU7u2DVjqPNCipdqJ0SEbNe+oLON5GbrQlD/uMJFHBWQ+bx1XPxV2DrEyouD7UL
         iVFQ+jupCUNtCeIcNKTVDNuKLtPa56uLlQMtNV6BUpC547zHzd4UpGOpOqZjncmn05
         iPHML94ByDWZ0VATAP5YkwuEVVPXQtLInlIx1EtLENH4If9J2suraqTSOYVZSdPgs1
         72nYwz6aVeO1+oZlFbIyRwlPwYHom5t0lKTtBEHlOlJb/FGdGYSUTcnTr1EMkQBSei
         RHTH9Pu/p1tmA1VdfqmjLdbQfTBSNR+Zc6QnkiVkh5xSRUDp5j0UcqUF7mIOI1x1A5
         geWdKqcLYFbrw==
Subject: Re: [PATCH 0/2] introduce DUMP_PREFIX_UNHASHED for hex dumps
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        John Ogness <john.ogness@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vlastimil Babka <vbabka@suse.cz>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        Petr Mladek <pmladek@suse.com>, roman.fietze@magna.com,
        keescook@chromium.org, linux-mm@kvack.org,
        Akinobu Mita <akinobu.mita@gmail.com>
References: <YAYtbbHAHeEwunkW@jagdpanzerIV.localdomain>
 <20210119014725.GH2260413@casper.infradead.org>
 <YAa2oCNWjExWlQTu@jagdpanzerIV.localdomain>
 <09c70d6b-c989-ca23-7ee8-b404bb0490f0@suse.cz>
 <cd9e7a31-e4f6-69d3-0648-c6228108b592@kernel.org>
 <083dd940-60c1-4cc8-fc89-8815b253d5c5@suse.cz>
 <a9b38fe7-8a22-71b7-1e84-0ebf1e864306@kernel.org>
 <20210126123912.23a5c3a1@gandalf.local.home>
 <20210126124032.0915f408@gandalf.local.home>
 <87mtwv8ptz.fsf@jogness.linutronix.de>
 <YBDLxddRw5u+IA6B@jagdpanzerIV.localdomain>
From:   Timur Tabi <timur@kernel.org>
Message-ID: <e52b557d-c7e3-60ff-7c52-10479c297508@kernel.org>
Date:   Tue, 26 Jan 2021 21:22:21 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YBDLxddRw5u+IA6B@jagdpanzerIV.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/26/21 8:11 PM, Sergey Senozhatsky wrote:
> +1 for boot param with a scary name and dmesg WARNING WARNING WARNING that
> should look even scarier.
> 
> Timur, do you have time to take a look and submit a patch?

Yes, I'll submit a patch.
