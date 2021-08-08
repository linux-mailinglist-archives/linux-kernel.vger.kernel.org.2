Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9021A3E3C41
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Aug 2021 20:47:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232031AbhHHSr2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Aug 2021 14:47:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22219 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230049AbhHHSr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Aug 2021 14:47:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628448428;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wvXgyLOQU/mH0LHeHC+eEhUvc0avwsGPtDVQ4efBtfo=;
        b=bknNSbeIktz81uqPuuv16LXjwHyN0y68n+doCXcdcfShX+gB1sCsYqZ4pLYRlcNM+FERiy
        hdN+P91Pc52CsritCOaK++XIR/KJxwCbStnsy/GZxCft5WGtfJ4dAwXN8PqvL6FgrluSgX
        h70ZD4SX8Y3hw9fxQR8vvWxvF1Mg3iM=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-399-s-3olC3WNHSXxYJ0DLEDEw-1; Sun, 08 Aug 2021 14:47:06 -0400
X-MC-Unique: s-3olC3WNHSXxYJ0DLEDEw-1
Received: by mail-qv1-f71.google.com with SMTP id a2-20020a0562141302b02903303839b843so10947681qvv.13
        for <linux-kernel@vger.kernel.org>; Sun, 08 Aug 2021 11:47:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wvXgyLOQU/mH0LHeHC+eEhUvc0avwsGPtDVQ4efBtfo=;
        b=M0sD4HJk9lB7ywGiI+n+nVTanwGXB0SYEE3N00SApXR04Jv0u+3soB65+1nLb8yvb3
         bxQ0i0SuDXF+n91nc486dwyEkpPFu7Cjl8KxLnWGk6FtZLCn7k4zDyQSk8beD83456x8
         /G7XzZtKGuUma3kfFyYLOOgCuFYufF16uobWpsbXR+DJpfo/iVtT5Rl+q1LSU7f5/YvW
         gpzGBMLwNC3TWFmOyO5m7tsl/RFY3MvF9Qs75ZtAtCRynlaThHdRbR6zJytVdzLPTtKt
         FydDTozWjqhkHMFDM8mZeB/TtkCsliF+s1wHDxCiOm4bncxzdjAsX9eqfT5whmFkrjM6
         7+fQ==
X-Gm-Message-State: AOAM531WXENmhIAHQ7DxYLWeu9qkrAB1Mk5/yjH9L4N+tBUJ5BT1BaAy
        aeA191AOI82SCMixIoIBX1B9NXx4uezNuaSkwUXcIqAirjdzM0tPsO/sSKqlVa8ieyfvmvUCXd0
        idHZVpGWwzuSnVEBiXW1ODK/Y
X-Received: by 2002:a05:620a:22b:: with SMTP id u11mr11752238qkm.423.1628448426487;
        Sun, 08 Aug 2021 11:47:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwvl0rzdwG5RPiHTBsmRCSekqxcMIFdm3zhyV5kiUpAPF5YZ9ux/WJm4h91q3kvF0mL/sAaaQ==
X-Received: by 2002:a05:620a:22b:: with SMTP id u11mr11752227qkm.423.1628448426296;
        Sun, 08 Aug 2021 11:47:06 -0700 (PDT)
Received: from treble ([68.74.140.199])
        by smtp.gmail.com with ESMTPSA id o139sm8104031qke.129.2021.08.08.11.47.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Aug 2021 11:47:05 -0700 (PDT)
Date:   Sun, 8 Aug 2021 11:47:03 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     jbaron@akamai.com, rostedt@goodmis.org, ardb@kernel.org,
        linux-kernel@vger.kernel.org, ltykernel@gmail.com
Subject: Re: [PATCH] static_call: Update comment
Message-ID: <20210808184703.oqpdtap4kpvidg5y@treble>
References: <YQwIorQBHEq+s73b@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YQwIorQBHEq+s73b@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 05, 2021 at 05:49:54PM +0200, Peter Zijlstra wrote:
> @@ -96,6 +102,33 @@
>   *   To query which function is currently set to be called, use:
>   *
>   *   func = static_call_query(name);
> + *
> + *
> + * DEFINE_STATIC_CALL_RET0 / __static_call_return0:
> + *
> + *   Just like how DEFINE_STATIC_CALL_NULL() / static_call_cond() optimize the
> + *   conditional void function call, DEFINE_STAT_CALL_RET0 /

s/STAT/STATIC/

Otherwise

Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>

-- 
Josh

