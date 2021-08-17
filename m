Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFDBA3EE167
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 02:40:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236817AbhHQAki (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 20:40:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:39284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237029AbhHQAkd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 20:40:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BAD5F60240;
        Tue, 17 Aug 2021 00:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1629160802;
        bh=nNjbX5cWn1CMLFVoEdB7PkH+dxuHmFgEZzkDVdkXFW0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=yzbFLNT8gkFtcXHHIjJpr+XMUoCQTO4dGWnSn4NFeFwYSDXXdzkdEw004xSWr6fkw
         woX23uyu/EYJS/AJ0VZChyv02r2kYIHbMqQoL47rnWlb/X8X2RiPYE2j2B82YSrDet
         GVv4HEyvQ0DBoC1eq4vXyYhtHiF2mfCXs3xmsido=
Date:   Mon, 16 Aug 2021 17:39:59 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>, Zi Yan <ziy@nvidia.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        David Rientjes <rientjes@google.com>
Subject: Re: [PATCH RESEND 0/8] hugetlb: add demote/split page functionality
Message-Id: <20210816173959.950443c7516a2b178e2ec376@linux-foundation.org>
In-Reply-To: <5dd4e07b-d2cf-63f2-fc0a-9b371b469a44@oracle.com>
References: <20210816224953.157796-1-mike.kravetz@oracle.com>
        <20210816162305.b19bfa3f3ba7431a62ff205f@linux-foundation.org>
        <5dd4e07b-d2cf-63f2-fc0a-9b371b469a44@oracle.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Aug 2021 17:17:50 -0700 Mike Kravetz <mike.kravetz@oracle.com> wrote:

> > 
> > And how does one know the operation has completed so the sysfs files
> > can be reloaded for another operation?
> > 
> 
> When the write to the file is complete, the operation has completed.
> Not exactly sure what you mean by reloading the sysfs files for
> another operation?

If userspace wishes to perform another demote operation, it must wait
for the preceding one to complete.

Presumably if thread A is blocked in a write to `demote' and thread B
concurrently tries to perform a demotion, thread B will be blocked as
well?  Was this tested?

Lots of things are to be added to changelogs & documentation, methinks.


