Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7421836DB48
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 17:24:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237192AbhD1PLy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 11:11:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53886 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231524AbhD1PLw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 11:11:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619622667;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=T807XqCTr78fh+zT3Qv4di+WLGWcFE6R3h9u02iLdq0=;
        b=OZ2Z7psUTHyhXPnamxMkJa7+0M5XQddubzY18T/sJG3h0Ze+iQAvKUbpuz3qR3pu5pASiM
        ZxTeNO8OikSVwzo6bJuEkkewuJWyILJPFtcea4WjisMPSHUPn/CtcW5btv7gcpVZ33bE85
        pGtM6+nntapuujEE3g0X/ghQ5xYLCIw=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-343-txxEQ9AcPAKViy8fmUzv5w-1; Wed, 28 Apr 2021 11:11:05 -0400
X-MC-Unique: txxEQ9AcPAKViy8fmUzv5w-1
Received: by mail-qt1-f200.google.com with SMTP id h12-20020ac8744c0000b02901ba644d864fso15377796qtr.8
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 08:11:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=T807XqCTr78fh+zT3Qv4di+WLGWcFE6R3h9u02iLdq0=;
        b=uE2LiL+fBPgukQt4NTYatQDSPjunmSSaP/BU7e/fhF0CBu+2Qk2QruKW/kLjN5ue+s
         0PENHUcOKSskP7mvB7iLC5x6QMEfeZF5oofWGPQyQhtcE4fbtdvat0f+euttVMydk6+M
         pm9tKf6yAOMHNI0iXzrz8oWI5kurl2kcjwY+fRHiu0Ti1LDtV+j6TvAXcQPW3GpuwxR1
         lqpk5KdcOOYG83cTBaJ5g1K9e+FEdEfPAms4cokrd+y25ZzC8MiaUTBcOlX6Sf7w7ir2
         BUNGMDqS3JFGA3WyI990lPWSGQNZuKR9t6SbgNyxkMy3IaHvIv3Ceec6qO4UBcamwWfo
         3bEg==
X-Gm-Message-State: AOAM532xQOC9ZgJCm5NvKnUtneYye2QEqRCpSZvAXZFhUlknQf/OJB4s
        AKYvrCBxSVFTCSz/HJ94kROPjrBIz/5HVp0PyLfH8ccwD+oGtAuliDSf5BvErUlcA1LdieBhiTp
        SY0weD6al9qBOfohknEokSPOM
X-Received: by 2002:ac8:7a6f:: with SMTP id w15mr27072605qtt.153.1619622664721;
        Wed, 28 Apr 2021 08:11:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxmlz6i+k8GL+CodVGGb/U/hb9IU3h8zgSIAJf+VwEX/cqDhpeMEGloDjVttPcXhjj2HOgzLg==
X-Received: by 2002:ac8:7a6f:: with SMTP id w15mr27072578qtt.153.1619622664510;
        Wed, 28 Apr 2021 08:11:04 -0700 (PDT)
Received: from xz-x1 (bras-base-toroon474qw-grc-77-184-145-104-227.dsl.bell.ca. [184.145.104.227])
        by smtp.gmail.com with ESMTPSA id b17sm194720qto.88.2021.04.28.08.11.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Apr 2021 08:11:04 -0700 (PDT)
Date:   Wed, 28 Apr 2021 11:11:01 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Joe Perches <joe@perches.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Shaohua Li <shli@fb.com>, Shuah Khan <shuah@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Wang Qing <wangqing@vivo.com>, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        Brian Geffon <bgeffon@google.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Mina Almasry <almasrymina@google.com>,
        Oliver Upton <oupton@google.com>
Subject: Re: [PATCH v5 05/10] userfaultfd/shmem: advertise shmem minor fault
 support
Message-ID: <20210428151101.GC6584@xz-x1>
References: <20210427225244.4326-1-axelrasmussen@google.com>
 <20210427225244.4326-6-axelrasmussen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210427225244.4326-6-axelrasmussen@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 27, 2021 at 03:52:39PM -0700, Axel Rasmussen wrote:
> Now that the feature is fully implemented (the faulting path hooks exist
> so userspace is notified, and the ioctl to resolve such faults is
> available), advertise this as a supported feature.
> 
> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>

Acked-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu

