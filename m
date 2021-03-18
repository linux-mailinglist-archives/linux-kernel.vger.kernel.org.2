Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26E663405FD
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 13:47:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230523AbhCRMrE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 08:47:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:37456 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231327AbhCRMqq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 08:46:46 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6FC7FAEFB;
        Thu, 18 Mar 2021 12:46:44 +0000 (UTC)
Subject: Re: [PATCH v6 2/6] init_on_alloc: Optimize static branches
To:     Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Alexander Potapenko <glider@google.com>,
        Elena Reshetova <elena.reshetova@intel.com>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Popov <alex.popov@linux.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jann Horn <jannh@google.com>,
        David Hildenbrand <david@redhat.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        kernel-hardening@lists.openwall.com,
        linux-hardening@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20210315180229.1224655-1-keescook@chromium.org>
 <20210315180229.1224655-3-keescook@chromium.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <5d626b9b-5355-be94-e8e2-1be47f880f30@suse.cz>
Date:   Thu, 18 Mar 2021 13:46:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210315180229.1224655-3-keescook@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/15/21 7:02 PM, Kees Cook wrote:
> The state of CONFIG_INIT_ON_ALLOC_DEFAULT_ON (and ...ON_FREE...) did not
> change the assembly ordering of the static branches: they were always out
> of line. Use the new jump_label macros to check the CONFIG settings to
> default to the "expected" state, which slightly optimizes the resulting
> assembly code.
> 
> Reviewed-by: Alexander Potapenko <glider@google.com>
> Link: https://lore.kernel.org/lkml/CAG_fn=X0DVwqLaHJTO6Jw7TGcMSm77GKHinrd0m_6y0SzWOrFA@mail.gmail.com/
> Signed-off-by: Kees Cook <keescook@chromium.org>

For the fixed version

Acked-by: Vlastimil Babka <vbabka@suse.cz>
