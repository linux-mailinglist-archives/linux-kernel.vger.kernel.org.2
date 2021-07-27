Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17E3A3D739B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 12:48:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236293AbhG0Ksi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 06:48:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24891 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236169AbhG0Ksh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 06:48:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627382916;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O/2pcW3cgupuTPX8yXQI9/9/2BekgqwjZaOJikbyWFc=;
        b=iYnLvVGt5DrJLznJ0qB+dOYOYI7QLssfQ8ECohsIOPEDJ2q3xde8xQgEFgdpxgHC+UoFlC
        txaN5ZUTTraofhES6/uhu3yuKt8qj8Yw6YOPphBcu39h9kwKP9DIv4K1e6zY/fVylxhfIY
        Xw4xNpTYzz9PNxMQpquT+LNJyhJsZ8g=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-269-AXq4Rs2uPQ-p0ynyVo0QkA-1; Tue, 27 Jul 2021 06:48:35 -0400
X-MC-Unique: AXq4Rs2uPQ-p0ynyVo0QkA-1
Received: by mail-wm1-f70.google.com with SMTP id a1-20020a7bc1c10000b0290225338d8f53so1197848wmj.8
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 03:48:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=O/2pcW3cgupuTPX8yXQI9/9/2BekgqwjZaOJikbyWFc=;
        b=rFZ/C6YTnjvyp2v8lSP6CzYyVYqg2jgVlmBngAcAIoEqTlT3x88jHSw6STmPUX8YAE
         uTKl+O4O7FQD7OLDR2Zgw6bA2ySYhDRH87E3oG4Zax8Rpng2NTfhR/4fKhA/z+xcswBR
         B1xjexgcok/d5p2bow5K1qibDztWsfY07Tth3ZPh2QhIhsHiHIQ93HrmsIbq/Y1VswY9
         4hiGzJbMbQiA711PV2QSewG0/679/AlSlPHEQKrbf9MmxFPj6lDVjJP5j8PQkopBYEP2
         cHIUElaJsJm+9b/svqrav2IO5dumjc4EbnQ1vqJPpGnOKkdX0huRU8dCamt7Ehl5oSq6
         eJGA==
X-Gm-Message-State: AOAM530Yu8bWS0VOXISGmSukr9YEq0MzrorzgyvER+3uUd9eXZ0lEufD
        LersM87l0oR43hldV6dAz5Zup54oQLGCr9UTQNdng7+2nbikncKPdTvG30slje2VdGTApRpym5T
        rayErW6/IsT1jcyW5PwbEOBwI
X-Received: by 2002:adf:ffd1:: with SMTP id x17mr23450686wrs.411.1627382914444;
        Tue, 27 Jul 2021 03:48:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwx7D8VgREuvxcUInc1/rAk2Wt3I8CEj7XBxdIg12UMW/NzZjfwAgXsWDNMrvc3kX29hlf5EQ==
X-Received: by 2002:adf:ffd1:: with SMTP id x17mr23450669wrs.411.1627382914251;
        Tue, 27 Jul 2021 03:48:34 -0700 (PDT)
Received: from [192.168.1.136] ([79.116.5.179])
        by smtp.gmail.com with ESMTPSA id h4sm2866493wru.2.2021.07.27.03.48.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 03:48:33 -0700 (PDT)
Message-ID: <7b2d6bf91d30c007e19a7d2cbddcb2460e72d163.camel@redhat.com>
Subject: Re: [patch 1/4] add basic task isolation prctl interface
From:   nsaenzju@redhat.com
To:     Marcelo Tosatti <mtosatti@redhat.com>, linux-kernel@vger.kernel.org
Cc:     Nitesh Lal <nilal@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alex Belits <abelits@marvell.com>, Peter Xu <peterx@redhat.com>
Date:   Tue, 27 Jul 2021 12:48:33 +0200
In-Reply-To: <20210727104119.551607458@fuller.cnet>
References: <20210727103803.464432924@fuller.cnet>
         <20210727104119.551607458@fuller.cnet>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.3 (3.40.3-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2021-07-27 at 07:38 -0300, Marcelo Tosatti wrote:
> +Isolation mode (PR_ISOL_MODE):
> +------------------------------
> +
> +- PR_ISOL_MODE_NONE (arg4): no per-task isolation (default mode).
> +  PR_ISOL_EXIT sets mode to PR_ISOL_MODE_NONE.
> +
> +- PR_ISOL_MODE_NORMAL (arg4): applications can perform system calls normally,
> +  and in case of interruption events, the notifications can be collected
> +  by BPF programs.
> +  In this mode, if system calls are performed, deferred actions initiated
> +  by the system call will be executed before return to userspace.
> +
> +Other modes, which for example send signals upon interruptions events,
> +can be implemented.

Shouldn't this be a set of flags that enable specific isolation features?
Something the likes of 'PR_ISOL_QUIESCE_ON_EXIT'. Modes seem more restrictive
and too much of a commitment. If we merge MODE_NORMAL as is, we won't be able
to tweak/extend its behaviour in the future.

-- 
Nicolás Sáenz

