Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6ECD351F2C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 20:56:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239896AbhDASzA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 14:55:00 -0400
Received: from foss.arm.com ([217.140.110.172]:47232 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239199AbhDASpN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 14:45:13 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E2E66152D;
        Thu,  1 Apr 2021 04:28:19 -0700 (PDT)
Received: from [10.57.24.208] (unknown [10.57.24.208])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A1E573F694;
        Thu,  1 Apr 2021 04:28:16 -0700 (PDT)
Subject: Re: [PATCH 2/3] tracing: Use pr_crit() instead of long fancy messages
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Petr Mladek <pmladek@suse.com>, Marco Elver <elver@google.com>,
        Linux Embedded <linux-embedded@vger.kernel.org>,
        John Ogness <john.ogness@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Linux IOMMU <iommu@lists.linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Will Deacon <will@kernel.org>, Gary R Hook <gary.hook@amd.com>
References: <20210331093104.383705-1-geert+renesas@glider.be>
 <20210331093104.383705-3-geert+renesas@glider.be>
 <20210331094007.77aa5194@gandalf.local.home>
 <CAMuHMdUvgRiYfsVOJdocB3peLhnDWe=Kn1MLW64sh8zpd2XoLA@mail.gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <b8dba57b-860b-0bd4-2ca0-e8f2e26571bd@arm.com>
Date:   Thu, 1 Apr 2021 12:28:11 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdUvgRiYfsVOJdocB3peLhnDWe=Kn1MLW64sh8zpd2XoLA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-04-01 10:39, Geert Uytterhoeven wrote:
> Hi Steven,
> 
> On Wed, Mar 31, 2021 at 3:40 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>> On Wed, 31 Mar 2021 11:31:03 +0200
>> Geert Uytterhoeven <geert+renesas@glider.be> wrote:
>>
>>> This reduces kernel size by ca. 0.5 KiB.
>>
>> If you are worried about size, disable tracing and it will go away
>> entirely. 0.5KiB is a drop in the bucket compared to what tracing adds in
>> size overhead.
> 
> Fair enough for this particular case, as tracing can be disabled.

I think the same argument can be applied to patch #1 - it's hard to 
imaging anyone debugging an IOMMU driver on a system where a few hundred 
bytes makes the slightest bit of difference, and for people not 
debugging IOMMU drivers it should be moot (per the message itself).

Robin.
