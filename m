Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 446AA368324
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 17:16:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237495AbhDVPQk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 11:16:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:59028 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233106AbhDVPQj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 11:16:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1619104563; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dkrS5Dxrb1ouK8VtwGEkh5+X/L5fhslUZ1usjLo8vSc=;
        b=GUNZNQaO/jkQoegnioQaMiAtk4QDzpmlHgZUBGMSLbFtV5BTZalH7QPEbdCNus9LoRlUVs
        ysPByqkQJ1gHh8KYGQagyKga5/7X7axPIJaw2sTmnDc9t7xHWPfdO7NKg19z/DNBAXKImi
        xIE2dkKMNRAxvhpaUYGLJSMyvWmZcOI=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7D546AF9E;
        Thu, 22 Apr 2021 15:16:03 +0000 (UTC)
Subject: Re: [PATCH 0/3] xen: remove some checks for always present Xen
 features
To:     Juergen Gross <jgross@suse.com>
Cc:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        xen-devel@lists.xenproject.org
References: <20210422151007.2205-1-jgross@suse.com>
From:   Jan Beulich <jbeulich@suse.com>
Message-ID: <df27aba6-c67e-d66e-f00e-75a1f76de921@suse.com>
Date:   Thu, 22 Apr 2021 17:16:03 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210422151007.2205-1-jgross@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.04.2021 17:10, Juergen Gross wrote:
> Some features of Xen can be assumed to be always present, so add a
> central check to verify this being true and remove the other checks.
> 
> Juergen Gross (3):
>   xen: check required Xen features
>   xen: assume XENFEAT_mmu_pt_update_preserve_ad being set for pv guests
>   xen: assume XENFEAT_gnttab_map_avail_bits being set for pv guests

I wonder whether it's a good idea to infer feature presence from
version numbers. If (at some point in the past) you had inferred
gnttab v2 being available by version, this would have been broken
by its availability becoming controllable by a command line option
in Xen.

Jan
