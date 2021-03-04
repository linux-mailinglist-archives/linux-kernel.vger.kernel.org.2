Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D91C32D77E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 17:15:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236393AbhCDQOp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 11:14:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:51067 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232441AbhCDQON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 11:14:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614874367;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IYwWU2u1cMcJa2Xo3YoetpEdqTSLPjrDCfoLSDezE1I=;
        b=AxlZjwruJzR3sEhb8O+VYDaiDMqi2apcQQNO+IC94O76CE3WowX6oFSrgq+ecjz+QyvvnV
        d5j15UQK2i528andsKGeiD23SkWOCCoEj8lHfiOuXbJFVa2V6IlqWJ5p2Oj15pD2RgFpMj
        y1v2j1/SdBzULWxazTVL6UcEOIDOTMY=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-202-JODhEeshNCWjAScgPwKfcw-1; Thu, 04 Mar 2021 11:12:45 -0500
X-MC-Unique: JODhEeshNCWjAScgPwKfcw-1
Received: by mail-qt1-f199.google.com with SMTP id o20so19208359qtx.22
        for <linux-kernel@vger.kernel.org>; Thu, 04 Mar 2021 08:12:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IYwWU2u1cMcJa2Xo3YoetpEdqTSLPjrDCfoLSDezE1I=;
        b=GPzm453Ya1/xQGnj30alKwrpzMs9r4+l9ZIla3fjyuPaYpRoKSFXhoFuaMDAWUWi92
         lfir9xqSwGc+9FNiF/3uzF9gaaae1UzDZB6LvRkWZ34V1hv1vAf4bB+FqXzhJV8oMQuH
         sdzj24Fykp7d+lAg43FQp5hLcB3iE3jchpqOYrfzLjxg37Nn+U27wWIZ+072noASmi/h
         ouSOQ6WQz09cJsb7on7sBWMqV+3X0cZiqpLXZPoDGzYcvNmDg0Lho5qfbk+cZziOWA4+
         Ixch0Uhbkh7EAO5k2mfeFTyFVfBKkZFrlOAd8vvqJFvJzMnsv04/ivHoWlrPBAelLTkZ
         jngQ==
X-Gm-Message-State: AOAM530YYtSnE9HGJbEmk7uF+uKANyr0hkGMWgTt7hAvAx3+asvPOKfJ
        jlv16xvKZfXRS4WyKOsEJNCgTZvT+RdVBhMpzHklJ6aNT/EBjw6xss6XwfDdRi1bEZl+dYrAo34
        3b6QlcpTZklNmiVQ6v21aObM+
X-Received: by 2002:a37:bc07:: with SMTP id m7mr4592033qkf.58.1614874365398;
        Thu, 04 Mar 2021 08:12:45 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxXn2Sp423cDssLqlGJv3agRA1znE4R8cjgXXrJcM2+dmFVO+SShoUWpOGbwaGdDOoOQweErA==
X-Received: by 2002:a37:bc07:: with SMTP id m7mr4592015qkf.58.1614874365189;
        Thu, 04 Mar 2021 08:12:45 -0800 (PST)
Received: from xz-x1 (bras-vprn-toroon474qw-lp130-25-174-95-95-253.dsl.bell.ca. [174.95.95.253])
        by smtp.gmail.com with ESMTPSA id b7sm19837826qkj.115.2021.03.04.08.12.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Mar 2021 08:12:44 -0800 (PST)
Date:   Thu, 4 Mar 2021 11:12:43 -0500
From:   Peter Xu <peterx@redhat.com>
To:     linux-man@vger.kernel.org
Cc:     Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        linux-kernel@vger.kernel.org,
        Linux MM Mailing List <linux-mm@kvack.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Alejandro Colomar <alx.manpages@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>
Subject: Re: [PATCH 4/4] ioctl_userfaultfd.2: Add write-protect mode docs
Message-ID: <20210304161243.GA397383@xz-x1>
References: <20210304015947.517713-1-peterx@redhat.com>
 <20210304015947.517713-5-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210304015947.517713-5-peterx@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 03, 2021 at 08:59:47PM -0500, Peter Xu wrote:
> Userfaultfd write-protect mode is supported starting from Linux 5.7.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  man2/ioctl_userfaultfd.2 | 74 +++++++++++++++++++++++++++++++++++++---
>  1 file changed, 70 insertions(+), 4 deletions(-)
> 
> diff --git a/man2/ioctl_userfaultfd.2 b/man2/ioctl_userfaultfd.2
> index 1965d1932..3feb888a8 100644
> --- a/man2/ioctl_userfaultfd.2
> +++ b/man2/ioctl_userfaultfd.2
> @@ -208,10 +208,11 @@ signal will be sent to the faulting process.
>  Applications using this
>  feature will not require the use of a userfaultfd monitor for processing
>  memory accesses to the regions registered with userfaultfd.
> +.TP
>  .BR UFFD_FEATURE_THREAD_ID " (since Linux 4.14)"
>  If this feature bit is set,
>  .I uffd_msg.pagefault.feat.ptid
> -Will be set
> +will be set to the faulted thread ID for each page fault message.

These two changes should belong to the previous patch - will get them fixed
too.

-- 
Peter Xu

