Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65923380F1D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 19:39:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235181AbhENRkO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 13:40:14 -0400
Received: from smtprelay0173.hostedemail.com ([216.40.44.173]:58652 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230487AbhENRkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 13:40:13 -0400
Received: from omf17.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 710E4100E7B42;
        Fri, 14 May 2021 17:39:01 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf17.hostedemail.com (Postfix) with ESMTPA id D0AF127DD36;
        Fri, 14 May 2021 17:38:59 +0000 (UTC)
Message-ID: <7cc30a8a6644bb60e5f3358e89253d9fc783fe54.camel@perches.com>
Subject: Re: [PATCH 2/2] x86/e820: Use pr_debug to avoid spamming dmesg log
 with debug messages
From:   Joe Perches <joe@perches.com>
To:     Jason Baron <jbaron@akamai.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Fri, 14 May 2021 10:38:58 -0700
In-Reply-To: <5a416031-ddcd-7ef4-ec33-47134bf064bb@akamai.com>
References: <f527618e-54f2-c2fb-e267-8065ac34e462@gmail.com>
         <6d55670d-2f06-d768-699f-5a79cece6ce0@gmail.com>
         <d181b674-66fb-1719-e3c6-e4217cf5519c@akamai.com>
         <59985635-665b-773f-de8f-b15fe3f60196@gmail.com>
         <1789b1da-7a0f-9fc9-6ed2-ff68e2306342@akamai.com>
         <204a99e1-de7a-4434-0932-45f1b507e9ec@gmail.com>
         <5a416031-ddcd-7ef4-ec33-47134bf064bb@akamai.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.39
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: D0AF127DD36
X-Stat-Signature: zncc8s658w5jrhh4wga878pkkrtggy83
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+LWHGGfrT5j+QHl9ZY+J10lcSgt4UtBVI=
X-HE-Tag: 1621013939-940429
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2021-05-11 at 17:31 -0400, Jason Baron wrote:

> That said, I do see the value in not having to open code the branch stuff, and
> making pr_debug() consistent with printk which does return a value. So that
> makes sense to me.

IMO: printk should not return a value.

