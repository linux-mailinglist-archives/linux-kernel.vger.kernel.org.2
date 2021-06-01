Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D7C3397D3B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 01:52:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235217AbhFAXyb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 19:54:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:53892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235137AbhFAXy3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 19:54:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 70F0E613AD;
        Tue,  1 Jun 2021 23:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1622591567;
        bh=dxjDIz0r0b7xu1n9w+LYp4IakkKBhTx8Jn5ZMEZwbhI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HCyhQjonnStyx/IAf6j38G5VoiTAkwlYEGBOjWwsTQRs9d74mqf0NIB6G9LdowvNg
         06s4vaky2uliZYTTcrBHtdLErU12UipwM8Aqzb7u303acCyzFmTU6JaEsi+VvCVr0d
         B4feOWRTx/LtL6nVZMHV5JUfKevSWoHIaGwUrPTE=
Date:   Tue, 1 Jun 2021 16:52:46 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Dong Aisheng <dongas86@gmail.com>,
        Dong Aisheng <aisheng.dong@nxp.com>, linux-mm@kvack.org,
        open list <linux-kernel@vger.kernel.org>,
        Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>, kexec@lists.infradead.org
Subject: Re: [PATCH V2 4/6] mm: rename the global section array to
 mem_sections
Message-Id: <20210601165246.99d7374d07661b7e91e49cb6@linux-foundation.org>
In-Reply-To: <f7f77368-72cf-e15d-cc3c-b0ddf86e14fd@redhat.com>
References: <20210531091908.1738465-1-aisheng.dong@nxp.com>
        <20210531091908.1738465-5-aisheng.dong@nxp.com>
        <42617372-c846-85fe-4739-abbe55eca8f6@redhat.com>
        <CAA+hA=Ss4j8qeoe7RtDJ14nuqy+TpOk2qi-A9+YN6=2y8c_CGg@mail.gmail.com>
        <f7f77368-72cf-e15d-cc3c-b0ddf86e14fd@redhat.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Jun 2021 10:40:09 +0200 David Hildenbrand <david@redhat.com> wrote:

> > Thanks, i explained the reason during my last reply.
> > Andrew has already picked this patch to -mm tree.
> 
> Just because it's in Andrews tree doesn't mean it will end up upstream. ;)
> 
> Anyhow, no really strong opinion, it's simply unnecessary code churn 
> that makes bisecting harder without real value IMHO.

I think it's a good change - mem_sections refers to multiple instances
of a mem_section.  Churn is a pain, but that's the price we pay for more
readable code.  And for having screwed it up originally ;)

