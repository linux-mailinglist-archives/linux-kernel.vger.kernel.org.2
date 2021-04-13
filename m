Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 328BC35E7B1
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 22:43:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232101AbhDMUna (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 16:43:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25652 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230281AbhDMUn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 16:43:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618346588;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=l7+E0a1RmQtz9OdkPBWVwzVjeeLrb1IaJD410lr0Tlc=;
        b=fD0sYZLA3YodHgRIFQTQBHzMknKBGjWYWq7iX8NtN9lxtrlBjgVjEMyHc2hPkGrMW50EkW
        6sEdZLb84o0EalDsAqrp3ldCzkSfIaj1X7Ep8NkC5Pw7sIZ0n74Ohu1p9YOYJ7a8lcgCDK
        GVm66+oZt3joLX/ygM5FNm7iHCtREXk=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-517-SZSsNe_FMUmot1ePmnCcMA-1; Tue, 13 Apr 2021 16:43:07 -0400
X-MC-Unique: SZSsNe_FMUmot1ePmnCcMA-1
Received: by mail-qv1-f69.google.com with SMTP id u7so10818825qvf.5
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 13:43:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=l7+E0a1RmQtz9OdkPBWVwzVjeeLrb1IaJD410lr0Tlc=;
        b=DmtAypGIaEjCX/a0Rn4ul/0E8YC+SA6cUzNrXpCNYDcEUHQX0lR+K9tJK6nuVa0xdy
         2xdcMEapw+ZOVyx0AxXJsHERpcCec+VDuVtBC780QiLW/5u4/FhqXJLgXbX7hkNqG9hB
         je5uW3XB4no37yRbhKcNfyuLHdA74D9iqBkTa4yrtq9bdo2TKsnuZldRoX8PGMJxHQqG
         RO/1RXFQ34lOLfvprU+lmgKNG/2Ec4v5zhGi+2ncsaGGsvt4KojRD2yg1ji/L+v+aY6u
         VAtuU5uneQmNTL13zNpn75hPN4a1QSOf5q91Mlhxkgc2/jd4XBPN41OB8TA6b7cvseAu
         kNcw==
X-Gm-Message-State: AOAM533792Zjfv4HAL4bEmrVaqjQGhWVpx3dkiufzevRrv8T26AU8+rz
        uR4viszueNrcVlkc0M+NVtCVlVKBLUOtTjV0xWCN/gOaij9rkmgNZy2uRFWHcdedDxZ41ieJvge
        TFvEr1knluzrSRfiTPtgjFYPr
X-Received: by 2002:ac8:529a:: with SMTP id s26mr9139709qtn.86.1618346586712;
        Tue, 13 Apr 2021 13:43:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyhhgdT699IOjKyQMCFGRKWPZFD1wjCraEpotriSy8OLfP4IZ7xZ1qfAYCJAbXf3dGDou98CA==
X-Received: by 2002:ac8:529a:: with SMTP id s26mr9139679qtn.86.1618346586512;
        Tue, 13 Apr 2021 13:43:06 -0700 (PDT)
Received: from xz-x1 (bras-base-toroon474qw-grc-88-174-93-75-154.dsl.bell.ca. [174.93.75.154])
        by smtp.gmail.com with ESMTPSA id i2sm3031068qtg.0.2021.04.13.13.43.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 13:43:05 -0700 (PDT)
Date:   Tue, 13 Apr 2021 16:43:04 -0400
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
Subject: Re: [PATCH v2 3/9] userfaultfd/shmem: support minor fault
 registration for shmem
Message-ID: <20210413204304.GG4440@xz-x1>
References: <20210413051721.2896915-1-axelrasmussen@google.com>
 <20210413051721.2896915-4-axelrasmussen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210413051721.2896915-4-axelrasmussen@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 12, 2021 at 10:17:15PM -0700, Axel Rasmussen wrote:
> This patch allows shmem-backed VMAs to be registered for minor faults.
> Minor faults are appropriately relayed to userspace in the fault path,
> for VMAs with the relevant flag.
> 
> This commit doesn't hook up the UFFDIO_CONTINUE ioctl for shmem-backed
> minor faults, though, so userspace doesn't yet have a way to resolve
> such faults.
> 
> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>

Everything looks right to me, but it'll be great if Andrea or Hugh will have a
look too.

Acked-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu

