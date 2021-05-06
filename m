Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 043CB37553B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 15:59:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234488AbhEFOAp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 10:00:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233931AbhEFOAo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 10:00:44 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CF51C061574
        for <linux-kernel@vger.kernel.org>; Thu,  6 May 2021 06:59:45 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id q136so4938084qka.7
        for <linux-kernel@vger.kernel.org>; Thu, 06 May 2021 06:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=P3dw17zuo1UvFMrejsvUdXCi2Z0ZGfb51kowuUuzZZ8=;
        b=HzD2Pr6fW/XfYOgiEktawUfv/YNH789za5xh04grZtFPge5CBVPFjT7tQleddaaw0P
         0GzCd7hifL9SMbR+wi058rNZ1TfA6RsNdsjwK2kvLKaMHPEYhZDE7wxxVWIlm759KgXZ
         7rST99EsSuQNn5HOYf2fEZlEebfdAsEVlEN123D2Zn2twHTDUOmotVVLzgTPiahMO2Yw
         FEbq7Pszj8iAhtMUBSd9Uru8BZiEYmgGsAFLgMfoXO+/7zFx13g/UItV+8Q2Subr3efF
         bNrUBLudejo0ctdardbquGAEcfoTmX5GFKZa6lS/mMsxgIHnCz9PAq3HAKCZCzW7d45u
         bumA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=P3dw17zuo1UvFMrejsvUdXCi2Z0ZGfb51kowuUuzZZ8=;
        b=Ub5ZazRaFqSZpC0HwekhqL+bxdm1hqobgA4CllKD+A+HuRPByuqqebxBwBAm0y2qIt
         Fc/580ujd+9TuzXt63+oCgqMVIRwg+u2Z4jOEPc70nQ2yimt6ZtvZX7ezVMqe2Edfvj6
         LqOymTHCVA60pxN8mkm5j/G9/CAhNNr0vL4RYeIAH6Yajgslo676LrlE+INRfgn3pqdC
         36ntkEE7AthORY+4a6pWAdG9fwRHgdIqgwlRyaqkXyCmyIZtDVrlr/7Uv9ghWWRZQUXB
         1ni5RfVIxhY9hNo0EeQ1sMl0RwKcmTfkVHWC531C/aEcknc8N2gMaUjc/r+dmmZUM7Gd
         2Dfg==
X-Gm-Message-State: AOAM531Si0hpuc9bMkUlpGCOm8ke49zgLlCYgklRGUP6eV6bObihLkyy
        w3FTAAVGL1o3Hmygd6s+hhS7Bw==
X-Google-Smtp-Source: ABdhPJykn5wBn+Btu8UnOTleFuUkQVFAlMylO8dXhBhmeoGMuKPAw4bgovytvqXi+4sKeBEqhtpGjg==
X-Received: by 2002:a37:40d5:: with SMTP id n204mr3999721qka.79.1620309584440;
        Thu, 06 May 2021 06:59:44 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:4c4b])
        by smtp.gmail.com with ESMTPSA id r65sm2093020qkd.81.2021.05.06.06.59.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 May 2021 06:59:44 -0700 (PDT)
Date:   Thu, 6 May 2021 09:59:41 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, mingo@kernel.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, bsingharora@gmail.com, pbonzini@redhat.com,
        maz@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        riel@surriel.com
Subject: Re: [PATCH 2/6] sched: Rename sched_info_{queued,dequeued}
Message-ID: <YJP2TQncvovn3tSh@cmpxchg.org>
References: <20210505105940.190490250@infradead.org>
 <20210505111525.061402904@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210505111525.061402904@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 05, 2021 at 12:59:42PM +0200, Peter Zijlstra wrote:
> For consistency, rename {queued,dequeued} to {enqueue,dequeue}.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
