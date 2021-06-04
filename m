Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2630439C15C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 22:31:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231200AbhFDUdS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 16:33:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:35774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229854AbhFDUdQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 16:33:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7CCCE613AE;
        Fri,  4 Jun 2021 20:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1622838680;
        bh=Pu+BgslkvbmVRKZaeA88N293hw51E0+I3f9Br6nrJBQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Ef+xKa/8joaIKJ60FEP+JhtA/CFn1Im5NXqyzboBrT3jrDWDY2QqnRwmKELbHSvv4
         AOkGeZ8KjZt2uENeocI9WYGRUlUvwIkJRIAObt8yFu+rnUahvbfPkSrVrhnraJHZsn
         sGdKJZu5Xv1j8kaxgfd77QNQdduw4sIkXoBGUSRQ=
Date:   Fri, 4 Jun 2021 13:31:19 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Dennis Zhou <dennis@kernel.org>
Cc:     Roman Gushchin <guro@fb.com>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] percpu: memcg memory accounting rework
Message-Id: <20210604133119.7e291efe6aa1305a6dcb38db@linux-foundation.org>
In-Reply-To: <YLpQhuZwuf32avkf@google.com>
References: <20210603010931.1472512-1-guro@fb.com>
        <YLpQhuZwuf32avkf@google.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Jun 2021 16:10:46 +0000 Dennis Zhou <dennis@kernel.org> wrote:

> I think I'm pretty happy with this approach. If there is any issue with
> the delta of memcg on but kmem accounting off, we can tackle that
> separately. I'll need another day or so to review the last patch a
> little more carefully though.
> 
> Andrew do you mind if I route the first two in my tree too?

Please do.
